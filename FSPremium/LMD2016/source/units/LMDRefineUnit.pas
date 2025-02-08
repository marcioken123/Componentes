unit LMDRefineUnit;
{$I LMDCmps.inc}

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

LMDRefineUnit unit (DD)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms,
  LMDYParser, LMDBaseRefine, LMDSearchBase
  ;

type
  TLMDRefine = class(TLMDSearchBaseDlgComponent)
  private
    FCode: TSegment;
    FErrors: TStringList;
    FNearestLength: Integer;
    FLastParseTime: Integer;
    FLastSearchTime: Integer;
    FMatchCase: Boolean;
    FWholeWordsOnly: Boolean;
    FTemplate: TLMDSearchTemplate;
    procedure SetNearestLength(const Value: Integer);
    procedure SetMatchCase(const Value: Boolean);
    procedure SetWholeWordsOnly(const Value: Boolean);
    procedure SetTemplate(const Value: TLMDSearchTemplate); reintroduce;
  public
    constructor Create(AOwner: TComponent);override;
    destructor  Destroy;override;

    // display refine dialog
    function    ShowDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;

    // template related functions
    function    ParseTemplate(szTemplate: String): Boolean;
    function    SearchTemplate(szText: String):Boolean;
    // DONE:
    // ---
    function    SearchTemplateEx(szText: String; var Detail:TLMDRefineDetail): Boolean;
    function    SearchTemplateInStream(Stream: TStream; var Detail: TLMDRefineDetail): Boolean;
    // ---

    // properties
    property    Errors:TStringList read FErrors;
    property    Code:TSegment read FCode;
    property    LastParseTime:Integer read FLastParseTime;
    property    LastSearchTime:Integer read FLastSearchTime;
  published
    property    NearestLength:Integer read FNearestLength write SetNearestLength default 50;
    property    MatchCase:Boolean read FMatchCase write SetMatchCase default false;
    property    WholeWordsOnly:Boolean read FWholeWordsOnly write SetWholeWordsOnly default false;
    property    Template: TLMDSearchTemplate read FTemplate write SetTemplate;

    property    DlgBuilderOptions;
    property    OnDlgCustomize;
    property    OnDlgHelpClick;
  end;

implementation

uses
  Windows, SysUtils, Controls,
  LMDRefineParser, LMDRefineLex, LMDStrSupp, LMDRVEFormUnit, LMDStrings, LMDUtils
  ;

{ TLMDRefine }
{----------------------------- public -----------------------------------------}
constructor TLMDRefine.Create(AOwner: TComponent);
begin
  inherited;
  FCode := TSegment.Create;
  FErrors := TStringList.Create;
  FNearestLength := 50;
  FMatchCase := False;
  FWholeWordsOnly := False;
end;

{------------------------------------------------------------------------------}
destructor TLMDRefine.Destroy;
begin
  FreeAndNil(FErrors);
  FreeAndNil(FCode);
  inherited;
end;

function TLMDRefine.ParseTemplate(szTemplate: String): Boolean;

var
  FStream : TYVCLStream;
  RL : TLMDREFINELEXLex;
  RF : TLMDREFINEParser;
  c  : Char;
  i  : Integer;
  lTime : LongWord;
begin
  if not FMatchCase then
    szTemplate := LMDAnsiUpperCase(szTemplate);      // LMDSPWUpperCase
  lTime := GetTickCount;
  FCode.Clear;
  FErrors.Clear;
  FStream := TYVCLStream.Create;
  RL := TLMDREFINELEXLex.Create(FStream);
  RF := TLMDREFINEParser.Create(RL);
  try
    with FStream.aInStream do
    begin
      Clear;
      Position := 0;
      Write(szTemplate[1], Length(szTemplate) * SizeOf(Char));
      c := nl;
      Write(c, sizeof(c));
      c := #0;
      Write(c, sizeof(C));
      Write(c, sizeof(C));
      Position := 0;
    end;
    i := RF.yyparse;
    Result := i=0;
    FStream.SaveToStrings(FErrors);
    FCode.AddSegment(RF.Code);
  finally
    RF.Free;
    RL.Free;
    FStream.Free;
  end;
  FLastParseTime := GetTickCount-lTime;
end;

{------------------------------------------------------------------------------}
function TLMDRefine.ShowDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
var
  VisualBuilderForm:TLMDRVEForm;
begin
  result:=false;
  VisualBuilderForm := TLMDRVEForm.Create(nil);
  try
    LMDSPSetupDialog(VisualBuilderForm, self);

    if AOwner<>nil then
      LMDCenterChild(TCustomForm(AOwner), VisualBuilderForm)
    else
      if vboCenterDialog in DlgBuilderOptions then
        begin
          if not (vboCenterOwnerForm in DlgBuilderOptions) then
            LMDCenterForm(VisualBuilderForm)
          else
            if Owner is TCustomForm then
              LMDCenterChild(TCustomForm(Owner), VisualBuilderForm);
        end
      else
        begin
          if X <> -1 then VisualBuilderForm.Left := X;
          if Y <> -1 then VisualBuilderForm.Top := Y;
        end;

    if Assigned(OnDlgCustomize) then OnDlgCustomize(VisualBuilderForm);
    if VisualBuilderForm.ShowModal=mrOK then
      begin
        result:=true;
        LMDSPAssignDialogValues(VisualBuilderForm, self);
      end;
  finally
    VisualBuilderForm.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDRefine.SearchTemplateEx(szText: String; var Detail:TLMDRefineDetail): Boolean;

var
  RE: TLMDRefineExecuter;
  lTime : LongWord;
begin
  ParseTemplate(FTemplate);
  if not FMatchCase then
   szText := LMDAnsiUpperCase(szText); //LMDSPWUpperCase
  szText := ' ' + szText + ' ';
  lTime := GetTickCount;
  if FCode.Count>0 then
  begin
    RE := TLMDRefineExecuter.Create;
    try
      RE.AnySingleCharacter := AnySingleCharacter;
      RE.AnySequenceCharacter := AnySequenceCharacter;
      RE.NearLength := FNearestLength;
      RE.WholeWordsOnly := FWholeWordsOnly;
      RE.MatchCase := FMatchCase;
      Result := RE.ExecuteCode(FCode,szText);
      Detail := RE.Detail;
    except
      Result := False;
    end;
    RE.Free;
  end
  else
    Result := False;
  FLastSearchTime := GetTickCount-lTime;
end;

function TLMDRefine.SearchTemplate(szText: String): Boolean;

var
  RE: TLMDRefineExecuter;
  lTime : LongWord;
begin
  ParseTemplate(FTemplate);
  if not FMatchCase then
   szText := LMDAnsiUpperCase(szText); // LMDSPWUpperCase
  szText := ' ' + szText + ' ';
  lTime := GetTickCount;
  if FCode.Count>0 then
  begin
    RE := TLMDRefineExecuter.Create;
    try
      RE.AnySingleCharacter := AnySingleCharacter;
      RE.AnySequenceCharacter := AnySequenceCharacter;
      RE.NearLength := FNearestLength;
      RE.WholeWordsOnly := FWholeWordsOnly;
      RE.MatchCase := FMatchCase;
      Result := RE.ExecuteCode(FCode,szText);
    except
      Result := False;
    end;
    RE.Free;
  end
  else
    Result := False;
  FLastSearchTime := GetTickCount-lTime;
end;

// CLR
// DONE:: VAR problem!!
function TLMDRefine.SearchTemplateInStream(Stream: TStream; var Detail: TLMDRefineDetail): Boolean;
var
  RE: TLMDRefineExecuter;
  lTime : LongWord;
  MS: TMemoryStream;
  S: String;
  i: integer;
begin
  MS := TMemoryStream.Create;
  try
    i := Stream.Size;
    S := '';
    S := String(LMDAnsiStreamToString(Stream, i));
    S := ' ' + S + ' ';
    LMDWriteStringToStream(MS, S);
//    i := length(S) * SizeOf(Char);
//    MS.Write(i, SizeOf(i));
//    MS.Write(S[1], i);
    MS.Position := 0;

    ParseTemplate(FTemplate);
    lTime := GetTickCount;
    if FCode.Count>0 then
    begin
      RE := TLMDRefineExecuter.Create;
      try
        RE.AnySingleCharacter := AnySingleCharacter;
        RE.AnySequenceCharacter := AnySequenceCharacter;
        RE.NearLength := FNearestLength;
        RE.WholeWordsOnly := FWholeWordsOnly;
        RE.MatchCase := FMatchCase;
        Result := RE.ExecuteCode(FCode, S);
        Detail := RE.Detail;
      except
        Result := False;
      end;
      RE.Free;
    end
    else
      Result := False;
  finally
    MS.Free;
  end;
  FLastSearchTime := GetTickCount-lTime;
end;

procedure TLMDRefine.SetMatchCase(const Value: Boolean);
begin
  FMatchCase := Value;
end;

procedure TLMDRefine.SetNearestLength(const Value: Integer);
begin
  FNearestLength := Value;
end;

procedure TLMDRefine.SetWholeWordsOnly(const Value: Boolean);
begin
  FWholeWordsOnly := Value;
end;

procedure TLMDRefine.SetTemplate(const Value: TLMDSearchTemplate);
begin
  if Value <> FTemplate then FTemplate := Value;
end;

end.
