unit ElRegExpr;
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

ElRegExpr unit (AH)
---------------------
This unit is wrapper around LMDRegExpr, but this unit is deprecated, please
use LMDRegExpr instead of.

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  SysUtils,
  LMDTypes,
  LMDRegExpr,
  LMDFiles,
  LMDProcs,
  LMDStrings,
  ElComponent;

type
  PPCRECalloutBlock = Pointer;
  TElCalloutEvent = procedure(Sender: TObject; const Data: PPCRECalloutBlock) of object;

  TElRegOptions = class(TPersistent)
  private
    FFlags: Integer;
    FOnChange: TNotifyEvent;
    function GetCaseLess: Boolean;
    function GetExtended: Boolean;
    function GetMultiLine: Boolean;
    function GetSingleLine: Boolean;
    function GetUngreedy: Boolean;
    function GetUTF8: Boolean;
    procedure SetCaseLess(const Value: Boolean);
    procedure SetExtended(const Value: Boolean);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetSingleLine(const Value: Boolean);
    procedure SetUngreedy(const Value: Boolean);
    procedure SetUTF8(const Value: Boolean);
    procedure TriggerChange;
  protected
    property Flags: Integer read FFlags;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
  published
    property eroCaseLess: Boolean read GetCaseLess write SetCaseLess default True;
    property eroSingleLine: Boolean read GetSingleLine write SetSingleLine default True;
    property eroMultiLine: Boolean read GetMultiLine write SetMultiLine default False;
    property eroExtendedMode: Boolean read GetExtended write SetExtended default True;
    property eroUngreedyMode: Boolean read GetUngreedy write SetUngreedy default False;
    property eroUTF8: Boolean read GetUTF8 write SetUTF8 default False;
  end;

  TElRegExpHeader = record
    Id: Longint;
    Flags: Integer;
  end;

  TElRegExpr = class(TElComponent)
  protected
    FRegExprEngine: TLMDRegExp;
    FOptions: TElRegOptions;
    FInputText: String;
    FMatchCountLimit: Integer;
    FOnCalloutEvent: TElCalloutEvent;
    procedure Compile;
    function GetMatch(i: Integer): string;
    function GetMatchLen(i: Integer): integer;
    function GetMatchPos(i: Integer): integer;
    function GetNumMatches: Integer;
    function GetExpr: String;
    procedure SetExpr(const Value: String);
    function GetInputText: String;
    procedure SetInputText(const Value: String);
    procedure DoChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Study; // deprecated;

    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(AFileName: TLMDString);
    procedure LoadFromFile(AFileName: TLMDString);

    function Exec: boolean; overload;
    function Exec(const AInputText: string): Boolean; overload;

    function ExecNext: Boolean;
    function ExecPos(AStartOffs: Integer): boolean;

    procedure Split(AInputText: string; AResult: TLMDStrings); overload;
    procedure Split(AResult: TLMDStrings); overload;

    function Substitute(const ATemplate: string): string;

    function Replace(const AReplace: string; AUseTemplates: Boolean): string; overload;
    function Replace(const AInputText: string; const AReplace: string; AUseTemplates: Boolean): string; overload;

    property Match[i: Integer]: string read GetMatch;
    property MatchPos[i: Integer]: integer read GetMatchPos;
    property MatchLen[i: Integer]: integer read GetMatchLen;
    property MatchCount: Integer read GetNumMatches;

  published
    property Options: TElRegOptions read FOptions;
    property MatchCountLimit: Integer read FMatchCountLimit default 100;

    property Expression: string read GetExpr write SetExpr;
    property InputText: string read GetInputText Write SetInputText;

    property OnCallout: TElCalloutEvent read FOnCalloutEvent write FOnCalloutEvent;
  end;

implementation

const
  GId = $45524C45;

{ TElRegExpr }

procedure TElRegExpr.Compile;
begin
  FRegExprEngine.Compile;
end;

procedure TElRegExpr.Study;
begin
  // nothing to do.. deprecated
end;

constructor TElRegExpr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegExprEngine := TLMDRegExp.Create;
  FOptions := TElRegOptions.Create;
  FOptions.FOnChange := DoChange;
end;

destructor TElRegExpr.Destroy;
begin
  FRegExprEngine.Free;
  FOptions.Free;
  inherited;
end;

function TElRegExpr.Exec: boolean;
begin
  Result := Exec;
end;

function TElRegExpr.Exec(const AInputText: string): Boolean;
begin
  FRegExprEngine.InputText := AInputText;
  Result := FRegExprEngine.Exec;
end;

function TElRegExpr.ExecPos(AStartOffs: integer): boolean;
begin
  Result := FRegExprEngine.Exec(AStartOffs);
end;

function TElRegExpr.ExecNext: Boolean;
begin
  Result := FRegExprEngine.ExecNext;
end;

procedure TElRegExpr.Split(AInputText: string; AResult: TLMDStrings);
begin
  FRegExprEngine.InputText := AInputText;
  Split(AResult);
end;

procedure TElRegExpr.Split(AResult: TLMDStrings);
var
  LStrs: TLMDStrings;
begin
  LStrs := TLMDMemoryStrings.Create;
  try
    FRegExprEngine.Split(LStrs);
    AResult.Assign(LStrs);
  finally
    LStrs.Free;
  end;
end;

function TElRegExpr.Substitute(const ATemplate: string): string;
begin
  Result := FRegExprEngine.Substitute(ATemplate);
end;

function TElRegExpr.Replace(const AReplace: string; AUseTemplates: Boolean): string;
begin
  Result := FRegExprEngine.Replace(AReplace, AUseTemplates);
end;

function TElRegExpr.Replace(const AInputText: string; const AReplace: string; AUseTemplates: Boolean): string;
begin
  FRegExprEngine.InputText := AInputText;
  Result := Replace(AReplace, AUseTemplates);
end;

function TElRegExpr.GetMatch(i: Integer): string;
begin
  Result := FRegExprEngine.Match[i];
end;

function TElRegExpr.GetMatchLen(i: Integer): integer;
begin
  Result := FRegExprEngine.MatchLen[i];
end;

function TElRegExpr.GetMatchPos(i: Integer): integer;
begin
  Result := FRegExprEngine.MatchPos[i];
end;

function TElRegExpr.GetNumMatches: Integer;
begin
  Result := FRegExprEngine.MatchCount + 1;
end;

procedure TElRegExpr.SetExpr(const Value: String);
begin
  FRegExprEngine.Expression := Value;
  Compile;
end;

function TElRegExpr.GetExpr: String;
begin
  Result := FRegExprEngine.Expression;
end;

function TElRegExpr.GetInputText: String;
begin
  Result := FRegExprEngine.InputText;
end;

procedure TElRegExpr.SetInputText(const Value: string);
begin
  FRegExprEngine.InputText := Value;
end;

procedure TElRegExpr.DoChange(Sender: TObject);
begin
  FRegExprEngine.ModifierG := not FOptions.eroUngreedyMode;
  FRegExprEngine.ModifierS := FOptions.eroSingleLine;
  FRegExprEngine.ModifierM := FOptions.eroMultiLine;
  FRegExprEngine.ModifierI := FOptions.eroCaseLess;
  FRegExprEngine.ModifierX := FOptions.eroExtendedMode;
end;

procedure TElRegExpr.LoadFromStream(AStream: TStream);
var
  LHdr: TElRegExpHeader;
  LStr: TLMDString;
begin
  AStream.Read(LHdr, SizeOf(LHdr));
  if LHdr.Id = GId then
  begin
    Options.FFlags := LHdr.Flags;
    LMDReadStringFromStream(AStream, LStr);
    FRegExprEngine.Expression := LStr;
    LMDReadStringFromStream(AStream, LStr);
    FRegExprEngine.InputText := LStr;
  end;
end;

procedure TElRegExpr.SaveToStream(AStream: TStream);
var
  LHdr: TElRegExpHeader;
  LStr: TLMDString;
begin
  LHdr.Id := GId;
  LHdr.Flags := Options.Flags;
  AStream.Write(LHdr, SizeOf(LHdr));
  LStr := FRegExprEngine.Expression;
  LMDWriteStringToStream(AStream, LStr);
  LStr := FRegExprEngine.InputText;
  LMDWriteStringToStream(AStream, LStr);
end;

procedure TElRegExpr.LoadFromFile(AFileName: TLMDString);
var
  LFile: TLMDFileStream;
begin
  LFile := TLMDFileStream.Create(AFileName, fmOpenRead);
  LoadFromStream(LFile);
  LFile.Free;
end;

procedure TElRegExpr.SaveToFile(AFileName: TLMDString);
var
  LFile: TLMDFileStream;
begin
  LFile := TLMDFileStream.Create(AFileName, fmCreate, fmShareDenyWrite);
  SaveToStream(LFile);
  LFile.Free;
end;

{ TElRegOptions }
const
  // Options
  PCRE_CASELESS = $0001;
  PCRE_MULTILINE = $0002;
  PCRE_DOTALL = $0004;
  PCRE_EXTENDED = $0008;
  PCRE_ANCHORED = $0010;
  PCRE_DOLLAR_ENDONLY = $0020;
  PCRE_EXTRA = $0040;
  PCRE_NOTBOL = $0080;
  PCRE_NOTEOL = $0100;
  PCRE_UNGREEDY = $0200;
  PCRE_NOTEMPTY = $0400;
  PCRE_UTF8 = $0800;
  PCRE_NO_AUTO_CAPTURE = $1000;

constructor TElRegOptions.Create;
begin
  inherited Create;
  FFlags := PCRE_CASELESS or PCRE_EXTENDED or PCRE_DOTALL;
end;

function TElRegOptions.GetCaseLess: Boolean;
begin
  Result := ((FFlags and not PCRE_CASELESS) <> FFlags);
end;

function TElRegOptions.GetExtended: Boolean;
begin
  Result := ((FFlags and not PCRE_EXTENDED) <> FFlags);
end;

function TElRegOptions.GetMultiLine: Boolean;
begin
  Result := ((FFlags and not PCRE_MULTILINE) <> FFlags);
end;

function TElRegOptions.GetSingleLine: Boolean;
begin
  Result := ((FFlags and not PCRE_DOTALL) <> FFlags);
end;

function TElRegOptions.GetUngreedy: Boolean;
begin
  Result := ((FFlags and not PCRE_UNGREEDY) <> FFlags);
end;

function TElRegOptions.GetUTF8: Boolean;
begin
  Result := ((FFlags and not PCRE_UTF8) <> FFlags);
end;

procedure TElRegOptions.SetCaseLess(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_CASELESS
  else
    FFlags := FFlags and not PCRE_CASELESS;
  TriggerChange;
end;

procedure TElRegOptions.SetExtended(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_EXTENDED
  else
    FFlags := FFlags and not PCRE_EXTENDED;
  TriggerChange;
end;

procedure TElRegOptions.SetMultiLine(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_MULTILINE
  else
    FFlags := FFlags and not PCRE_MULTILINE;
  TriggerChange;
end;

procedure TElRegOptions.SetSingleLine(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_DOTALL
  else
    FFlags := FFlags and not PCRE_DOTALL;
  TriggerChange;
end;

procedure TElRegOptions.SetUngreedy(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_UNGREEDY
  else
    FFlags := FFlags and not PCRE_UNGREEDY;
  TriggerChange;
end;

procedure TElRegOptions.SetUTF8(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_UTF8
  else
    FFlags := FFlags and not PCRE_UTF8;
  TriggerChange;
end;

procedure TElRegOptions.TriggerChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

end.
