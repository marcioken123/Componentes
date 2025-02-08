unit LMDSctSource;
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

LMDSctSource unit (YB)
----------------------
LMD Script Pack source code utils unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Consts, Classes, Controls, Dialogs, TypInfo, StrUtils,
  RTLConsts, intfLMDBase, LMDTypes, LMDUnicode, LMDUnicodeStrings, LMDSctScripter;

type
  {************************** class TLMDSourceUtils ***************************}

  TLMDSourceUtils = class;
  ELMDSourceUtils = class(Exception);

  {************************* class TLMDSrcUtilsProc ***************************}

  TLMDSrcUtilsParam = record
    Name:  WideString;
    ByRef: Boolean;
  end;

  TLMDSrcUtilsParamArr = array of TLMDSrcUtilsParam;
  TLMDSrcUtilsProc = class
  private
    FName:          WideString;
    FParamCount:    Integer;
    FParamCapacity: Integer;
    FParams:        TLMDSrcUtilsParamArr;
    FNameBeginPos:  Integer;
    FNameEndPos:    Integer;

    procedure AddParam(const AName: WideString; AByRef: Boolean);
    function  GetParam(AIndex: Integer): TLMDSrcUtilsParam;
  public
    property Name: WideString read FName;
    property NameBeginPos: Integer read FNameBeginPos;
    property NameEndPos: Integer read FNameEndPos;
    property ParamCount: Integer read FParamCount;
    property Param[AIndex: Integer]: TLMDSrcUtilsParam read GetParam;
  end;

  {************************** class TLMDSourceUtils ***************************}

  TLMDEnsureProcRes      = (sprExist, sprCreated, sprRenamed);
  TLMDValidateProcAction = (vpaDoNothing, vpaResetEvent, vpaCancel);

  TLMDSourceUtils = class(TComponent, ILMDComponent)
  private
    FAbout:        TLMDAboutVar;
    FProcs:        TList;
    FLanguage:     TLMDScriptLanguage;
    FTraits:       TObject;
    FAfterRefresh: TNotifyEvent;

    procedure RecreateTraits(ALang: TLMDScriptLanguage);
    procedure CreateProcParams(AProc: TLMDSrcUtilsProc;
                               AEventTypeInfo: TLMDTypeInfo);
    procedure CheckProc(AProc: TLMDSrcUtilsProc;
                        AEventTypeInfo: TLMDTypeInfo);
    procedure CreateProcSrc(ASource: TLMDStrings; const AName: WideString;
                            AEventTypeInfo: TLMDTypeInfo);
    procedure RenameProcSrc(ASource: TLMDStrings; const ANewName: WideString;
                            AProc: TLMDSrcUtilsProc);
    procedure AddProc(AProc: TLMDSrcUtilsProc);
    function  GetProc(AIndex: Integer): TLMDSrcUtilsProc;
    function  GetProcCount: Integer;
    procedure SetLanguage(const Value: TLMDScriptLanguage);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Refresh(ASource: TLMDStrings);
    procedure Clear;

    function  FindProc(const AName: WideString): TLMDSrcUtilsProc;
    procedure GetProcList(AEventTypeInfo: TLMDTypeInfo; AResult: TLMDStrings);
    function  EnsureProcAndRefresh(ASource: TLMDStrings; const AName,
                                   AOldName: WideString;
                                   AEventTypeInfo: TLMDTypeInfo): TLMDEnsureProcRes;
    function  IsCompatibleProc(AProc: TLMDSrcUtilsProc;
                               AEventTypeInfo: TLMDTypeInfo): Boolean;
    function  ValidateProc(AInstance: TPersistent; APropInfo: TLMDPropInfo;
                           const AName: WideString): TLMDValidateProcAction;

    property  ProcCount: Integer read GetProcCount;
    property  Proc[AIndex: Integer]: TLMDSrcUtilsProc read GetProc;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Language: TLMDScriptLanguage read FLanguage write SetLanguage default slVBScript;
    property AfterRefresh: TNotifyEvent read FAfterRefresh write FAfterRefresh;
  end;

implementation

type
  {**************************** class TLangTraits *****************************}

  TLangTraits = class
  private
    FOwner:     TLMDSourceUtils;
    FSource:    WideString;
    FSrcLength: Integer;
    FCurPos:    Integer;
    FCurChar:   WideChar;
  protected
    procedure NextChar;
    function  InRange(AC, ALow, AHigh: WideChar): Boolean;
    function  IsIdentChar(AC: WideChar): Boolean; virtual;
    function  IsLineBreak(AC: WideChar): Boolean; virtual;
    procedure SkipBlanks; virtual;
    function  ParseIdent: WideString; virtual;
    function  CharAt(AOffset: Integer): WideChar;
    property  Source: WideString read FSource;
    property  CurPos: Integer read FCurPos;
    property  CurChar: WideChar read FCurChar;

    function  LineBreak(ABreakCount: Integer = 1): WideString;

    function  DoHasByRefs: Boolean; virtual;
    procedure DoParse; virtual; abstract;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; virtual; abstract;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; virtual; abstract;
  public
    constructor Create(AOwner: TLMDSourceUtils); virtual;

    function  HasByRefs: Boolean;
    function  HasParamDefinitions: Boolean; virtual;

    procedure Parse(const ASource: WideString);
    function  CreateProc(const ASource: WideString; AProc: TLMDSrcUtilsProc): WideString;
    function  RenameProc(const ASource: WideString; const ANewName: WideString;
                         AProc: TLMDSrcUtilsProc): WideString;
    property  Owner: TLMDSourceUtils read FOwner;
  end;

  {************************** class TVBScriptTraits ***************************}

  TVBScriptTraits = class(TLangTraits)
  private
    function  IsRemComment: Boolean;
    procedure SkipComment;
    procedure SkipString;
    procedure SkipClass;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {*************************** class TJScriptTraits ***************************}

  TJScriptTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    function  DoHasByRefs: Boolean; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {*************************** class TPerlTraits ***************************}

  TPerlTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {*************************** class TPythonTraits ***************************}

  TPythonTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    function  DoHasByRefs: Boolean; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {*************************** class TTclTraits ***************************}

  TTclTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    function  DoHasByRefs: Boolean; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {*************************** class TLuaTraits ***************************}

  TLuaTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    function  DoHasByRefs: Boolean; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

  {***************************** class TRexxTraits ****************************}

  TRexxTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
  protected
    procedure SkipBlanks; override;
    function  DoHasByRefs: Boolean; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  public
    function HasParamDefinitions: Boolean; override;                         
  end;

  {************************* class TPasScriptTraits ***************************}

  TPasScriptTraits = class(TLangTraits)
  private
    procedure SkipComment;
    procedure SkipString;
    procedure ParseProc;
    function  ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
    function  ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
  protected
    procedure SkipBlanks; override;
    procedure DoParse; override;
    function  DoCreateProc(AProc: TLMDSrcUtilsProc): WideString; override;
    function  DoRenameProc(const ANewName: WideString;
                           AProc: TLMDSrcUtilsProc): WideString; override;
  end;

{************************** class TLMDSrcUtilsProc ****************************}
{ -------------------------------- private ----------------------------------- }
procedure TLMDSrcUtilsProc.AddParam(const AName: WideString; AByRef: Boolean);
begin
  if FParamCapacity < FParamCount + 1 then
    SetLength(FParams, Length(FParams) * 2 + 4);

  with FParams[FParamCount] do
  begin
    Name  := AName;
    ByRef := AByRef;
  end;
  Inc(FParamCount);
end;
            
{ ---------------------------------------------------------------------------- }
function TLMDSrcUtilsProc.GetParam(AIndex: Integer): TLMDSrcUtilsParam;
begin
  if (AIndex < 0) or (AIndex >= FParamCount) then
    raise ELMDSourceUtils.CreateFmt(SListIndexError, [AIndex]);
  Result := FParams[AIndex];
end;

{**************************** class TLMDSourceUtils ***************************}
{ --------------------------------- prviate ---------------------------------- }

procedure TLMDSourceUtils.RecreateTraits(ALang: TLMDScriptLanguage);
var
  old: TObject;
begin
  old := FTraits; // Care of assertions.

  case ALang of
    slVBScript:   FTraits := TVBScriptTraits.Create(Self);
    slJScript:    FTraits := TJScriptTraits.Create(Self);
    slPerl:       FTraits := TPerlTraits.Create(Self);
    slPython:     FTraits := TPythonTraits.Create(Self);
    slTCL:        FTraits := TTclTraits.Create(Self);
    slLua:        FTraits := TLuaTraits.Create(Self);
    slRexx:       FTraits := TRexxTraits.Create(Self);
    slPascal:     FTraits := TPasScriptTraits.Create(Self);
  else
    Assert(False);
  end;

  old.Free;
end;
             
{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.CreateProcParams(AProc: TLMDSrcUtilsProc;
  AEventTypeInfo: TLMDTypeInfo);
var
  i:     Integer;
  data:  TLMDTypeData;
  p:     Pointer;
  flags: TParamFlags;
  name:  WideString;
begin
  data := GetTypeData(AEventTypeInfo);
  p    := @data.ParamList;

  for i := 0 to data.ParamCount - 1 do
  begin
    flags := TParamFlags(p^);
    Inc(TLMDPtrInt(p), SizeOf(TParamFlags));

    name := WideString(ShortString(p^));
    Inc(TLMDPtrInt(p), Length(name) + 1);
    Inc(TLMDPtrInt(p), Length(ShortString(p^)) + 1); // Skip 'TypeName'.

    AProc.AddParam(name, (pfVar in flags) or (pfOut in flags));
  end;
end;
          
{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.CheckProc(AProc: TLMDSrcUtilsProc;
  AEventTypeInfo: TLMDTypeInfo);
begin
  if not IsCompatibleProc(AProc, AEventTypeInfo) then
    raise  ELMDSourceUtils.CreateFmt('Property and method %s are not ' +
                                     'compatible.',
                                     [AProc.Name]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.CreateProcSrc(ASource: TLMDStrings;
  const AName: WideString; AEventTypeInfo: TLMDTypeInfo);
var
  tmp: TLMDSrcUtilsProc;
begin
  tmp := TLMDSrcUtilsProc.Create;
  try
    tmp.FName := AName;
    CreateProcParams(tmp, AEventTypeInfo);

    ASource.Text := TLangTraits(FTraits).CreateProc(ASource.Text, tmp);
  finally
    tmp.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.RenameProcSrc(ASource: TLMDStrings;
  const ANewName: WideString; AProc: TLMDSrcUtilsProc);
begin
  if ANewName <> AProc.Name then
    ASource.Text := TLangTraits(FTraits).RenameProc(ASource.Text,
                                                    ANewName, AProc);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.AddProc(AProc: TLMDSrcUtilsProc);
begin
  FProcs.Add(AProc);
end;

{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.GetProc(AIndex: Integer): TLMDSrcUtilsProc;
begin
  Result := TLMDSrcUtilsProc(FProcs[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.GetProcCount: Integer;
begin
  Result := FProcs.Count;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.SetLanguage(const Value: TLMDScriptLanguage);
begin
  if FLanguage <> Value then
  begin
    Clear;
    RecreateTraits(Value);

    FLanguage := Value;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDSourceUtils.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_SCRIPT;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSourceUtils.Create(AOwner: TComponent);
begin
  inherited;
  FProcs    := TList.Create;
  FLanguage := slVBScript;

  RecreateTraits(FLanguage);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSourceUtils.Destroy;
begin
  Clear;
  FProcs.Free;
  FTraits.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.Refresh(ASource: TLMDStrings);
begin
  Clear;
  TLangTraits(FTraits).Parse(ASource.Text);

  if Assigned(FAfterRefresh) then
    FAfterRefresh(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.Clear;
var
  i: Integer;
begin
  for i := 0 to FProcs.Count - 1 do
    TLMDSrcUtilsProc(FProcs[i]).Free;
  FProcs.Clear;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.FindProc(const AName: WideString): TLMDSrcUtilsProc;
var
  i: Integer;
begin
  for i := 0 to FProcs.Count - 1 do
    if SameText(TLMDSrcUtilsProc(FProcs[i]).Name, AName) then
    begin
      Result := TLMDSrcUtilsProc(FProcs[i]);
      Exit;
    end;
    
  Result := nil;
end;
  
{ ---------------------------------------------------------------------------- }

procedure TLMDSourceUtils.GetProcList(AEventTypeInfo: TLMDTypeInfo;
                                      AResult: TLMDStrings);
var
  i: Integer;
begin
  for i := 0 to ProcCount - 1 do
  begin
    if IsCompatibleProc(Proc[i], AEventTypeInfo) then
      AResult.Add(Proc[i].Name);
  end;
end;
    
{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.EnsureProcAndRefresh(ASource: TLMDStrings;
  const AName, AOldName: WideString;
  AEventTypeInfo: TLMDTypeInfo): TLMDEnsureProcRes;
var
  proc: TLMDSrcUtilsProc;
begin
  proc := FindProc(AName);
  if proc = nil then
  begin
    proc := FindProc(AOldName);
    if proc <> nil then
    begin
      CheckProc(proc, AEventTypeInfo);
      RenameProcSrc(ASource, AName, proc);
      Result := sprRenamed;
    end
    else
    begin
      CreateProcSrc(ASource, AName, AEventTypeInfo);
      Result := sprCreated;
    end;
  end
  else
  begin
    CheckProc(proc, AEventTypeInfo);
    Result := sprExist;
  end;

  Refresh(ASource);
end;

{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.IsCompatibleProc(AProc: TLMDSrcUtilsProc;
                                          AEventTypeInfo: TLMDTypeInfo): Boolean;
var
  i:   Integer;
  tmp: TLMDSrcUtilsProc;
begin
  Result := True;

  if not TLangTraits(FTraits).HasParamDefinitions then
    Exit;

  tmp    := TLMDSrcUtilsProc.Create;
  try
    tmp.FName := AProc.FName;
    CreateProcParams(tmp, AEventTypeInfo);

    if AProc.ParamCount <> tmp.ParamCount then
      Result := False
    else
    begin
      for i := 0 to AProc.ParamCount - 1 do
        if TLangTraits(FTraits).HasByRefs and
           (AProc.Param[i].ByRef <> tmp.Param[i].ByRef) then
        begin
          Result := False;
          Break; // for
        end;
    end;
  finally
    tmp.Free;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

function TLMDSourceUtils.ValidateProc(AInstance: TPersistent;
  APropInfo: TLMDPropInfo; const AName: WideString): TLMDValidateProcAction;
var
  proc: TLMDSrcUtilsProc;
  mres: Integer;
  ti: TLMDTypeInfo;
begin
  proc := FindProc(AName);

  mres := mrNo;
  if proc = nil then
  begin
    mres := MessageDlg(Format('The %s procedure referenced by %s.%s does not ' +
                              'exist. Remove the reference?',
                              [AName, AInstance.GetNamePath, APropInfo.Name]),
                       mtError, [mbYes, mbNo, mbCancel], 0);
  end
  else
  begin
    ti := APropInfo.PropType^;

    if not IsCompatibleProc(proc, ti) then
    begin
      mres := MessageDlg(Format('The %s procedure referenced by %s.%s has an ' +
                                'incompatible parameter list. Remove the ' +
                                'reference?',
                                [AName, AInstance.GetNamePath, APropInfo.Name]),
                         mtError, [mbYes, mbNo, mbCancel], 0);
    end;
  end;

  case mres of
    mrYes:    Result := vpaResetEvent;
    mrCancel: Result := vpaCancel;
  else
    Result := vpaDoNothing;
  end;
end;

{****************************** class TLangTraits *****************************}
{ --------------------------------- protected -------------------------------- }

procedure TLangTraits.NextChar;
begin
  if FCurPos < Length(FSource) then
  begin
    Inc(FCurPos);
    FCurChar := FSource[FCurPos];
  end
  else
    FCurChar := #0;
end;
               
{ ---------------------------------------------------------------------------- }

function TLangTraits.InRange(AC, ALow, AHigh: WideChar): Boolean;
begin
  Result := (AC >= ALow) and (AC <= AHigh);
end;
              
{ ---------------------------------------------------------------------------- }

function TLangTraits.IsIdentChar(AC: WideChar): Boolean;
begin
  Result := InRange(AC, 'A', 'Z') or InRange(AC, 'a', 'z') or
            (AC = '_') or InRange(AC, '0', '9'); // TODO: Unicode categories
end;            
              
{ ---------------------------------------------------------------------------- }

function TLangTraits.IsLineBreak(AC: WideChar): Boolean;
begin
  Result := (AC = #0) or (AC = #13) or (AC = #10);
end;

{ ---------------------------------------------------------------------------- }

procedure TLangTraits.SkipBlanks;
begin
  while CurChar <> #0 do
  begin
    if Ord(CurChar) > 32 then // TODO: Unicode categories
      Break;
    NextChar;
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TLangTraits.ParseIdent: WideString;
var
  pos: Integer;
begin
  pos := CurPos;
  while IsIdentChar(CurChar) do
    NextChar;
  Result := Copy(Source, pos, CurPos - pos);
end;
      
{ ---------------------------------------------------------------------------- }

function TLangTraits.CharAt(AOffset: Integer): WideChar;
var
  pos: Integer;
begin
  pos := FCurPos + AOffset;

  if (pos > 0) and (pos < Length(FSource)) then
    Result := FSource[pos]
  else
    Result := #0;
end;
    
{ ---------------------------------------------------------------------------- }

function TLangTraits.LineBreak(ABreakCount: Integer): WideString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to ABreakCount - 1 do
    Result := Result + #13#10;
end;
      
{ ---------------------------------------------------------------------------- }

function TLangTraits.DoHasByRefs: Boolean;
begin
  Result := True;
end;

{ ---------------------------------------------------------------------------- }

function TLangTraits.HasParamDefinitions: Boolean;
begin
  Result := True;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLangTraits.Create(AOwner: TLMDSourceUtils);
begin
  inherited Create;
  FOwner := AOwner;
end;
     
{ ---------------------------------------------------------------------------- }

function TLangTraits.HasByRefs: Boolean;
begin
  Result := DoHasByRefs;
end;
     
{ ---------------------------------------------------------------------------- }

procedure TLangTraits.Parse(const ASource: WideString);
begin
  FSource    := ASource;
  FSrcLength := Length(ASource);
  try
    FCurPos := 0;
    NextChar;

    SkipBlanks;
    DoParse;
  finally
    FSource := ''; // Free mem.
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TLangTraits.CreateProc(const ASource: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
begin
  FSource    := TrimRight(ASource);
  FSrcLength := Length(ASource);
  try
    Result := DoCreateProc(AProc);
  finally
    FSource := ''; // Free mem.
  end;
end;
   
{ ---------------------------------------------------------------------------- }

function TLangTraits.RenameProc(const ASource, ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
begin
  FSource    := TrimRight(ASource);
  FSrcLength := Length(ASource);
  try
    Result := DoRenameProc(ANewName, AProc);
  finally
    FSource := ''; // Free mem.
  end;
end;

{**************************** class TVBScriptTraits ***************************}
{ ---------------------------------- private --------------------------------- }

function TVBScriptTraits.IsRemComment: Boolean;
var
  i: Integer;
begin
  i := 0;
  if CurChar = ':' then
  begin
    Inc(i);
    while InRange(CharAt(i), #1, #32) do
      Inc(i);
  end;

  Result := ((CharAt(i) = 'r') or (CharAt(i) = 'R')) and
            ((CharAt(i + 1) = 'e') or (CharAt(i + 1) = 'E')) and
            ((CharAt(i + 2) = 'm') or (CharAt(i + 2) = 'M')) and
            not IsIdentChar(CharAt(i + 3));
end;
     
{ ---------------------------------------------------------------------------- }

procedure TVBScriptTraits.SkipComment;
begin
  while CurChar <> #0 do
  begin
    if IsLineBreak(CurChar) then
      Exit
    else
      NextChar;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TVBScriptTraits.SkipString;
begin
  if CurChar = '"' then
    NextChar
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '"':              begin
                        NextChar;
                        if CurChar = '"' then
                          NextChar
                        else
                          Exit;
                      end;
  else
    NextChar;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TVBScriptTraits.SkipClass;
begin
  while True do case CurChar of
    'e', 'E':       if SameText(ParseIdent, 'end') then
                    begin
                      SkipBlanks;
                      if SameText(ParseIdent, 'class') then
                        Exit;
                    end;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TVBScriptTraits.ParseProc;
var
  s:      WideString;
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  s := ParseIdent;
  if not SameText(s, 'sub') and not SameText(s, 'function') then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and (CurChar = '(') and
       not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;
       
{ ---------------------------------------------------------------------------- }

function TVBScriptTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  comma: Boolean;
begin
  Result := False;

  if CurChar = '(' then
    NextChar
  else
    Exit;

  comma := False;
  while True do
  begin
    SkipBlanks;
    if CurChar = ')' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    if comma then
    begin
      SkipBlanks;
      if CurChar = ',' then
        NextChar
      else
        Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
    comma := True;
  end;
end;
 
{ ---------------------------------------------------------------------------- }

function TVBScriptTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s:     WideString;
  byval: Boolean;
  byref: Boolean;
begin
  Result := False;

  s     := ParseIdent;
  byval := SameText(s, 'byval');
  byref := SameText(s, 'byref');

  if byval or byref then
  begin
    SkipBlanks;
    s := ParseIdent;
  end;

  if s = '' then
    Exit;

  SkipBlanks;
  if CurChar = '(' then
  begin
    NextChar;
    SkipBlanks;
    if CurChar = ')' then
      NextChar
    else
      Exit;
  end;

  AProc.AddParam(s, byref);
  Result := True;
end;

{ --------------------------------- protected -------------------------------- }

procedure TVBScriptTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '''') or IsRemComment then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
           
{ ---------------------------------------------------------------------------- }

procedure TVBScriptTraits.DoParse;
begin
  while True do case CurChar of
    '"':            SkipString;
    'c', 'C':       if SameText(ParseIdent, 'class') then
                      SkipClass;
    'e', 'E':       if SameText(ParseIdent, 'end') then
                    begin
                      SkipBlanks;
                      ParseIdent; // Skip "end sub" or
                                  // "end function".
                    end;
    's', 'S',
    'f', 'F':       ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
          
{ ---------------------------------------------------------------------------- }

function TVBScriptTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'Sub ' + AProc.Name;
  if AProc.ParamCount <> 0 then
  begin
    s := s + '(';
    for i := 0 to AProc.ParamCount - 1 do
    begin
      param := AProc.Param[i];

      if i <> 0 then
        s := s + ', ';
      if param.ByRef then
        s := s + 'ByRef ' + param.Name
      else
        s := s + param.Name;
    end;
    s := s + ')';
  end;
  s := s + LineBreak(2) + 'End Sub' + LineBreak;

  Result := Source + s;
end;
         
{ ---------------------------------------------------------------------------- }

function TVBScriptTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;

{***************************** class TJScriptTraits ***************************}
{ ---------------------------------- private --------------------------------- }

procedure TJScriptTraits.SkipComment;
begin
  NextChar;

  if CurChar = '/' then // Single-line comment.
  begin
    NextChar;

    while CurChar <> #0 do
    begin
      if IsLineBreak(CurChar) then
        Exit
      else
        NextChar;
    end;
  end
  else
  begin // Multi-line comment.
    NextChar;

    while CurChar <> #0 do
    begin
      if (CurChar = '*') and (CharAt(1) = '/') then
      begin
        NextChar;
        NextChar;
        Exit;
      end
      else
        NextChar;
    end;
  end;
end;
             
{ ---------------------------------------------------------------------------- }

procedure TJScriptTraits.SkipString;
var
  term: WideChar;
begin
  if (CurChar = '"') or (CurChar = '''') then
  begin
    term := CurChar;
    NextChar;
  end
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '\':              begin
                        NextChar;
                        if (CurChar = '"') or (CurChar = '''') then
                          NextChar;
                      end;
    '"', '''':        begin
                        if CurChar = term then
                        begin
                          NextChar;
                          Exit;
                        end;
                        NextChar;
                      end;
  else
    NextChar;
  end;
end;
            
{ ---------------------------------------------------------------------------- }

procedure TJScriptTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  if ParseIdent <> 'function' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;
        
{ ---------------------------------------------------------------------------- }

function TJScriptTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  comma: Boolean;
begin
  Result := False;

  if CurChar = '(' then
    NextChar
  else
    Exit;

  comma := False;
  while True do
  begin
    SkipBlanks;
    if CurChar = ')' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    if comma then
    begin
      SkipBlanks;
      if CurChar = ',' then
        NextChar
      else
        Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
    comma := True;
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TJScriptTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s: WideString;
begin
  Result := False;

  s := ParseIdent;
  if s = '' then
    Exit;

  AProc.AddParam(s, False); // No 'ByRef' params in JScript.
  Result := True;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TJScriptTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '/') and ((CharAt(1) = '/') or (CharAt(1) = '*')) then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TJScriptTraits.DoHasByRefs: Boolean;
begin
  Result := False;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TJScriptTraits.DoParse;
begin
  while True do case CurChar of
    '"', '''':      SkipString;
    'n':            if ParseIdent = 'new' then
                    begin
                      SkipBlanks;
                      ParseIdent; // Skip "new function".
                    end;
    'f':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

function TJScriptTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'function ' + AProc.Name + '(';
  for i := 0 to AProc.ParamCount - 1 do
  begin
    param := AProc.Param[i];

    if i <> 0 then
      s := s + ', ';
    s := s + param.Name;
  end;
  s := s + ') {' + LineBreak(2) + '}' + LineBreak;

  Result := Source + s;
end;
        
{ ---------------------------------------------------------------------------- }

function TJScriptTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;
   
{ ---------------------------------------------------------------------------- }

{ TPerlTraits }

function TPerlTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'sub ' + AProc.Name + LineBreak + '{' + LineBreak;
  s := s + '  my (';
  for i := 0 to AProc.ParamCount - 1 do
  begin
    param := AProc.Param[i];

    if i <> 0 then
      s := s + ', ';
    s := s + '$' + param.Name;
  end;
  s := s + ') = @_;' + LineBreak(2);
  s := s + '}' + LineBreak;
  Result := Source + s;
end;

procedure TPerlTraits.DoParse;
begin
  while True do case CurChar of
    '"', '''':      SkipString;
    's':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;

function TPerlTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;

procedure TPerlTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  if ParseIdent <> 'sub' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;

    if proc.FName = '' then
      error := True;

    if not error then
    begin
      SkipBlanks;
      error := not ParseProcParams(proc);
    end;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;

function TPerlTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s: WideString;
begin
  Result := False;

  s := ParseIdent;
  if s = '' then
    Exit;

  AProc.AddParam(s, False); // '@_' parameters array contains values accessible by ref,
                            // but since we use local 'my' copies, they are by val
  Result := True;
end;

function TPerlTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  paramOK: Boolean;
  closingSymbol: Boolean;
begin
  Result := False;

  SkipBlanks;

  if CurChar = '{' then
  begin
    NextChar;
    SkipBlanks;
  end  
  else
    Exit;

  if ParseIdent <> 'my' then
    Exit;

  SkipBlanks;

  if CurChar <> '(' then
    Exit;

  paramOK := true;
  closingSymbol := false;
  while paramOK and (not closingSymbol) do
  begin
    closingSymbol := (CurChar = '#0') or (CurChar = ')');
    NextChar;
    SkipBlanks;
    if CurChar = '$' then
    begin
      NextChar;
      paramOK := ParseProcParam(AProc);
    end
  end;

  if paramOK and closingSymbol then
  begin
    SkipBlanks;
    if CurChar = '=' then
    begin
      NextChar;
      SkipBlanks;
      Result := (CurChar = '@') and (CharAt(1) = '_');
    end;
  end
  else
    Result := false;
end;

procedure TPerlTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '#') or ((CurChar = '=') and IsLineBreak(CharAt(-1))) then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;

procedure TPerlTraits.SkipComment;
begin
  if (CurChar = '#') then // Single-line comment.
  begin
    NextChar;

    while (CurChar <> #0) and (CurChar <> #13) and (CurChar <> #10) do
        NextChar;
  end
  else if (CurChar = '=') and IsLineBreak(CharAt(-1)) then
  begin // POD, sort of a multi-line comment.
    NextChar;
    while (not
                (
                (CurChar = '=') and
                IsLineBreak(CharAt(-1))
                and (CharAt(1)='c') and (CharAt(2)='u') and (CharAt(3) = 't')
                )
           )
                or (CurChar = '#0')
    do
       NextChar;
       
    while not IsLineBreak(CurChar) do
        NextChar;
  end;
end;

procedure TPerlTraits.SkipString;
var
  term: WideChar;
begin
  if (CurChar = '"') or (CurChar = '''') then
  begin
    term := CurChar;
    NextChar;
  end
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '\':              begin
                        NextChar;
                        if (CurChar = '"') or (CurChar = '''') then
                          NextChar;
                      end;
    '"', '''':        begin
                        if CurChar = term then
                        begin
                          NextChar;
                          Exit;
                        end;
                        NextChar;
                      end;
  else
    NextChar;
  end;
end;


{***************************** class TPythonTraits ***************************}
{ ---------------------------------- private --------------------------------- }

procedure TPythonTraits.SkipComment;
begin
  NextChar;
  if CurChar = '#' then // Single-line comment.
  begin
    NextChar;

    while CurChar <> #0 do
    begin
      if IsLineBreak(CurChar) then
        Exit
      else
        NextChar;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TPythonTraits.SkipString;
var
  term: WideChar;
begin
  if (CurChar = '"') or (CurChar = '''') then
  begin
    term := CurChar;
    NextChar;
  end
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '\':              begin
                        NextChar;
                        if (CurChar = '"') or (CurChar = '''') then
                          NextChar;
                      end;
    '"', '''':        begin
                        if CurChar = term then
                        begin
                          NextChar;
                          Exit;
                        end;
                        NextChar;
                      end;
  else
    NextChar;
  end;
end;
            
{ ---------------------------------------------------------------------------- }

procedure TPythonTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  if ParseIdent <> 'def' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;
        
{ ---------------------------------------------------------------------------- }

function TPythonTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  comma: Boolean;
begin
  Result := False;

  if CurChar = '(' then
    NextChar
  else
    Exit;

  comma := False;
  while True do
  begin
    SkipBlanks;
    if CurChar = ')' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    if comma then
    begin
      SkipBlanks;
      if CurChar = ',' then
        NextChar
      else
        Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
    comma := True;
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TPythonTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s: WideString;
begin
  Result := False;

  s := ParseIdent;
  if s = '' then
    Exit;

  AProc.AddParam(s, False); // No 'ByRef' params in Python.
  Result := True;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TPythonTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '#') then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TPythonTraits.DoHasByRefs: Boolean;
begin
  Result := False;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TPythonTraits.DoParse;
begin
  while True do case CurChar of
    '"', '''':      SkipString;
    'd':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

function TPythonTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'def ' + AProc.Name + '(';
  for i := 0 to AProc.ParamCount - 1 do
  begin
    param := AProc.Param[i];

    if i <> 0 then
      s := s + ', ';
    s := s + param.Name;
  end;
  s := s + '): ' + LineBreak(2) + '  ';

  Result := Source + s;
end;
        
{ ---------------------------------------------------------------------------- }

function TPythonTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;
   
{ ---------------------------------------------------------------------------- }

{***************************** class TTclTraits ***************************}
{ ---------------------------------- private --------------------------------- }

procedure TTclTraits.SkipComment;
var
  commentOver: boolean;
  lastCharIsSlash: boolean;
begin
  NextChar;
  if CurChar = '#' then
  begin
    lastCharIsSlash := false;
    commentOver := true;
    while (not commentOver) and (CurChar <> #0) do
    begin
      NextChar;
      commentOver := IsLineBreak(CurChar) and (not lastCharIsSlash);
      if (not lastCharIsSlash) and (CurChar = '\') then
        lastCharIsSlash := true;
      if lastCharIsSlash and not IsLineBreak(CurChar) then
        lastCharIsSlash := false;
    end;
  end;
end;

           
{ ---------------------------------------------------------------------------- }

procedure TTclTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  if ParseIdent <> 'proc' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;
        
{ ---------------------------------------------------------------------------- }

function TTclTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
begin
  Result := False;

  if CurChar = '{' then
    NextChar
  else
    Exit;

  while True do
  begin
    SkipBlanks;
    if CurChar = '}' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TTclTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s: WideString;
begin
  Result := False;

  s := ParseIdent;
  if s = '' then
    Exit;

  AProc.AddParam(s, False); // No 'ByRef' params in Tcl.
  Result := True;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TTclTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '#') then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TTclTraits.DoHasByRefs: Boolean;
begin
  Result := False;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TTclTraits.DoParse;
begin
  while True do case CurChar of
    'p':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

function TTclTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'proc ' + AProc.Name + ' {';
  for i := 0 to AProc.ParamCount - 1 do
  begin
    param := AProc.Param[i];

    if i <> 0 then
      s := s + ' ';
    s := s + param.Name;
  end;
  s := s + '} {' + LineBreak(2) + '}';

  Result := Source + s;
end;
        
{ ---------------------------------------------------------------------------- }

function TTclTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;
   
{ ---------------------------------------------------------------------------- }

{***************************** class TLuaTraits ***************************}
{ ---------------------------------- private --------------------------------- }

procedure TLuaTraits.SkipComment;
begin
  NextChar;
  if (CurChar = '-') and (CharAt(1) = '-') then // Single-line comment marked by --
  begin
    NextChar;
    while CurChar <> #0 do
    begin
      if IsLineBreak(CurChar) then
        Exit
      else
        NextChar;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLuaTraits.SkipString;
var
  term: WideChar;
begin
  if CurChar  = '"' then
  begin
    term := CurChar;
    NextChar;
  end
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '\':              begin
                        NextChar;
                        if CurChar  = '"' then
                          NextChar;
                      end;
    '"':              begin
                        if CurChar = term then
                        begin
                          NextChar;
                          Exit;
                        end;
                        NextChar;
                      end;
  else
    NextChar;
  end;
end;
            
{ ---------------------------------------------------------------------------- }

procedure TLuaTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  if ParseIdent <> 'function' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;
        
{ ---------------------------------------------------------------------------- }

function TLuaTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  comma: Boolean;
begin
  Result := False;

  if CurChar = '(' then
    NextChar
  else
    Exit;

  comma := False;
  while True do
  begin
    SkipBlanks;
    if CurChar = ')' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    if comma then
    begin
      SkipBlanks;
      if CurChar = ',' then
        NextChar
      else
        Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
    comma := True;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLuaTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s: WideString;
begin
  Result := False;

  s := ParseIdent;
  if s = '' then
    Exit;

  AProc.AddParam(s, False); // No 'ByRef' params in Lua.
  Result := True;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TLuaTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '-') and (CharAt(1) = '-') then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TLuaTraits.DoHasByRefs: Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLuaTraits.DoParse;
begin
  while True do case CurChar of
    '"':            SkipString;
    'f':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

function TLuaTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'function ' + AProc.Name + '(';
  for i := 0 to AProc.ParamCount - 1 do
  begin
    param := AProc.Param[i];

    if i <> 0 then
      s := s + ', ';
    s := s + param.Name;
  end;
  s := s + ')' + LineBreak(2) + 'end';

  Result := Source + s;
end;
        
{ ---------------------------------------------------------------------------- }

function TLuaTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;
   
{****************************** class TRexxTraits *****************************}
{ ---------------------------------- private --------------------------------- }

procedure TRexxTraits.SkipComment;
begin
  // Multi-line comments
  NextChar;

  while CurChar <> #0 do
  begin
    if (CurChar = '*') and (CharAt(1) = '/') then
    begin
      NextChar;
      NextChar;
      Exit;
    end
    else
      NextChar;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TRexxTraits.SkipString;
var
  term: WideChar;
begin
  if (CurChar = '"') or (CurChar = '''') then
  begin
    term := CurChar;
    NextChar;
  end
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '\':              begin
                        NextChar;
                        if (CurChar = '"') or (CurChar = '''') then
                          NextChar;
                      end;
    '"', '''':        begin
                        if CurChar = term then
                        begin
                          NextChar;
                          Exit;
                        end;
                        NextChar;
                      end;
  else
    NextChar;
  end;
end;
            
{ ---------------------------------------------------------------------------- }

procedure TRexxTraits.ParseProc;
var
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
  shift: integer;
  isComment: boolean;
  isIdent: boolean;
  found: boolean;
begin
  if ParseIdent <> 'procedure' then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    shift := 0;
    while not ((CharAt(shift) = #0) or (CharAt(shift) = ':')) do
      Dec(shift);

    if CharAt(shift) <> ':' then
        error := true
    else
    begin
      // We have to parse it backwards in reversed order,
      // so commonly used routines cannot be used here.

      isComment := false;
      found := false;
      isIdent := false;
      while not (found or (CharAt(shift) = #0)) do
      begin
        Dec(shift);
        if not isComment then
          isComment := (CharAt(shift) = '/') and (CharAt(shift-1) = '*');
        if isComment then
          isComment := not ((CharAt(shift) = '*') and (CharAt(shift-1) = '/'));
        if (not isComment) then begin
          if IsIdentChar(CharAt(shift)) then
          begin
            if not isIdent then
            begin
              isIdent := true;
              proc.FNameEndPos := CurPos + shift;
            end;
          end;
          if not IsIdentChar(CharAt(shift)) and isIdent then
          begin
            found := true;
            proc.FNameBeginPos := CurPos + shift + 1;
          end;
        end;
      end;
      if found then
      begin
        proc.FName := Trim(Copy(Source, proc.FNameBeginPos,
          proc.FNameEndPos - proc.FNameBeginPos + 1));
      end
      else
        error := true;
    end;

    if proc.FName = '' then
      error := True;

  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;

  NextChar;  
end;
        
{ ---------------------------------------------------------------------------- }

procedure TRexxTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '/') and (CharAt(1) = '*') then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;
     
{ ---------------------------------------------------------------------------- }

function TRexxTraits.DoHasByRefs: Boolean;
begin
  Result := False;
end;
      
{ ---------------------------------------------------------------------------- }

procedure TRexxTraits.DoParse;
begin
  while True do case CurChar of
    '"', '''':      SkipString;
    'p':            ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TRexxTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  s: WideString;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := AProc.Name + ': procedure' + LineBreak(2) + '  return ' + LineBreak;

  if Source <> '' then
    s := LineBreak(2) + s;

  Result := Source + s;
end;
        
{ ---------------------------------------------------------------------------- }

function TRexxTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;

{ ---------------------------------------------------------------------------- }

function TRexxTraits.HasParamDefinitions: Boolean;
begin
  Result := False;
end;
           
{ ---------------------------------------------------------------------------- }
   
{ TPasScriptTraits }

function TPasScriptTraits.DoCreateProc(AProc: TLMDSrcUtilsProc): WideString;
var
  i:       Integer;
  s:       WideString;
  param:   TLMDSrcUtilsParam;
begin
  s := '';
  if Source <> '' then
    s := s + LineBreak(2);

  s := s + 'procedure ' + AProc.Name;
  if AProc.ParamCount <> 0 then
  begin
    s := s + '(';
    for i := 0 to AProc.ParamCount - 1 do
    begin
      param := AProc.Param[i];

      if i <> 0 then
        s := s + '; ';
      if param.ByRef then
        s := s + 'var ' + param.Name
      else
        s := s + param.Name;
    end;
    s := s + ')';
  end;
  s := s + ';' + LineBreak + 'begin' + LineBreak(2) + 'end;' + LineBreak;

  Result := Source + s;
end;

procedure TPasScriptTraits.DoParse;
begin
  while True do case CurChar of
    '''':           SkipString;
    'p', 'P',
    'f', 'F':       ParseProc;
    #0:             Exit;
  else
    NextChar;
    SkipBlanks;
  end;
end;

function TPasScriptTraits.DoRenameProc(const ANewName: WideString;
  AProc: TLMDSrcUtilsProc): WideString;
var
  bpos,
  len: Integer;
begin
  bpos   := AProc.NameBeginPos;
  len    := AProc.NameEndPos - AProc.NameBeginPos + 1;
  Result := StuffString(Source, bpos, len, ANewName);
end;

procedure TPasScriptTraits.ParseProc;
var
  s:      WideString;
  error:  Boolean;
  proc:   TLMDSrcUtilsProc;
begin
  s := ParseIdent;
  if not SameText(s, 'function') and
     not SameText(s, 'procedure') then
    Exit;

  proc  := TLMDSrcUtilsProc.Create;
  error := False;
  try
    SkipBlanks;
    proc.FNameBeginPos := CurPos;
    proc.FName         := ParseIdent;
    proc.FNameEndPos   := CurPos - 1;
    if proc.FName = '' then
      error := True;

    SkipBlanks;
    if not error and (CurChar = '(') and
       not ParseProcParams(proc) then
      error := True;
  except
    proc.Free;
    raise;
  end;

  if not error then
    Owner.AddProc(proc)
  else
    proc.Free;
end;

function TPasScriptTraits.ParseProcParam(AProc: TLMDSrcUtilsProc): Boolean;
var
  s:       WideString;
  isvar:   Boolean;
  isout:   Boolean;
  isconst: Boolean;
begin
  Result := False;

  s       := ParseIdent;
  isvar   := SameText(s, 'var');
  isout   := SameText(s, 'out');
  isconst := SameText(s, 'const');

  if isvar or isout or isconst then
  begin
    SkipBlanks;
    s := ParseIdent;
  end;

  if s = '' then
    Exit;

  AProc.AddParam(s, isvar or isout);
  Result := True;
end;

function TPasScriptTraits.ParseProcParams(AProc: TLMDSrcUtilsProc): Boolean;
var
  semicolon: Boolean;
begin
  Result := False;

  if CurChar = '(' then
    NextChar
  else
    Exit;

  semicolon := False;
  while True do
  begin
    SkipBlanks;
    if CurChar = ')' then
    begin
      NextChar;
      Result := True;
      Exit;
    end;

    if semicolon then
    begin
      SkipBlanks;
      if CurChar = ';' then
        NextChar
      else
        Exit;
    end;

    SkipBlanks;
    if not ParseProcParam(AProc) then
      Exit;
    semicolon := True;
  end;
end;

procedure TPasScriptTraits.SkipBlanks;
begin
  inherited;

  while True do
  begin
    if (CurChar = '{') or
       ((CurChar = '/') and (CharAt(1) = '/')) or
       ((CurChar = '(') and (CharAt(1) = '*')) then
    begin
      SkipComment;
      inherited;
    end
    else
      Break; // while
  end;
end;

procedure TPasScriptTraits.SkipComment;
begin
  NextChar;

  if CurChar = '/' then // Single-line comment.
  begin
    NextChar;

    while CurChar <> #0 do
    begin
      if IsLineBreak(CurChar) then
        Exit
      else
        NextChar;
    end;
  end
  else if CurChar = '{' then // Multi-line comment.
  begin
    NextChar;

    while CurChar <> #0 do
    begin
      if CurChar = '}' then
      begin
        NextChar;
        Exit;
      end
      else
        NextChar;
    end;
  end
  else // (* xxx *) comment
  begin
    NextChar;
    NextChar;

    while CurChar <> #0 do
    begin
      if (CurChar = '*') and (CharAt(1) = '}') then
      begin
        NextChar;
        NextChar;
        Exit;
      end
      else
        NextChar;
    end;
  end;
end;

procedure TPasScriptTraits.SkipString;
begin
  if CurChar = '''' then
    NextChar
  else
    Exit;

  while True do case CurChar of
    #0, #13, #10:     Exit;
    '''':              begin
                        NextChar;
                        if CurChar = '''' then
                          NextChar
                        else
                          Exit;
                      end;
  else
    NextChar;
  end;
end;

end.
