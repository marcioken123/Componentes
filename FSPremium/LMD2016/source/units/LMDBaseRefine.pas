unit LMDBaseRefine;
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

LMDBaseRefine unit (DD)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Variants,
  Windows, Classes, LMDYParser, SysUtils,
  LMDStrSupp, LMDStrings, LMDWildcardUnit;

const
  C_CONST = 0;
  C_AND = 1;
  C_OR = 2;
  C_NEAR = 3;
  C_NOT = 4;

type
  TLMDRefineDetailPositionItem = record
    ActualWord: string;
    Position: longint;
  end;

  TLMDRefineDetailItem = record
    SearchWord: string;
    Positions: array of TLMDRefineDetailPositionItem;
  end;

  TLMDRefineDetail = array of TLMDRefineDetailItem;

  TLMDRefineExecuter = class
  private
    FDetail: TLMDRefineDetail;
    FStack, FCode: TSegment;
    FStream: TStream;
    iPos: Integer;
    FNearLength: Integer;
    FWholeWordsOnly: Boolean;
    FMatchCase: Boolean;
    function ExecuteCommand: Boolean;
  public
    AnySingleCharacter, AnySequenceCharacter: Char;
    constructor Create;
    destructor Destroy; override;
    function ExecuteCode(Code: TSegment; szText: string): Boolean;
    function ExecuteCodeByStream(Code: TSegment; Stream: TStream): Boolean;

    property Detail: TLMDRefineDetail read FDetail;
    property NearLength: Integer read FNearLength write FNearLength;
    property WholeWordsOnly: Boolean read FWholeWordsOnly write FWholeWordsOnly;
    property MatchCase: Boolean read FMatchCase write FMatchCase;
  end;

  TYLMDRefineBaseParser = class(TYParser)
  protected
    FCode: TSegment;
  public
    constructor Create(Lex: TYLex);
    destructor Destroy; override;
    property Code: TSegment read FCode;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  dialogs;
{$I C2.INC}
{$ENDIF}

{ TYLMDRefineBaseParser }
{------------------------------------------------------------------------------}

constructor TYLMDRefineBaseParser.Create;
begin
  inherited;
  FCode := TSegment.Create;
end;

{------------------------------------------------------------------------------}

destructor TYLMDRefineBaseParser.Destroy;
begin
  FCode.Free;
  inherited;
end;

{ TLMDRefineExecuter }
{------------------------------------------------------------------------------}

constructor TLMDRefineExecuter.Create;
begin
  inherited;
  FStack := TSegment.Create;
  FNearLength := 50;
  FWholeWordsOnly := False;
  FMatchCase := True;
  FStream := nil;
  AnySingleCharacter := '?';
  AnySequenceCharacter := '*';
end;

{------------------------------------------------------------------------------}

destructor TLMDRefineExecuter.Destroy;
begin
  FStack.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDRefineExecuter.ExecuteCode(Code: TSegment; szText: string): Boolean;

var
  Stream: TMemoryStream;
  i, j, k, l: integer;
  v1: variant;
  stl: TStringList;
begin
  FDetail := nil;
  Stream := TMemoryStream.Create;
  FStream := Stream;
  stl := TStringList.Create;
  try
    Stream.SetSize(Length(szText) * SizeOf(Char));
    {$IFDEF LMD_NATIVEUNICODE}
    LMDWideStringToStream(szText, Stream);
    {$ELSE}
    LMDAnsiStringToStream(szText, Stream);
    {$ENDIF}
// For C++Builder 2009 Move with Stream.Size param drop exception
//    Move(szText[1], Stream.Memory^, Stream.Size - 2);
    FStack.Clear;
    FCode := Code;
    iPos := 0;
    while ExecuteCommand do;
    if FStack.Count > 0 then
      Result := VarIsArray(FStack.Code)
    else
      Result := False;
{Result filter begin}
    stl.Sorted := True;
    stl.Duplicates := dupIgnore;
    while FStack.Count > 0 do
    begin
      V1 := FStack.Pop;
      if VarIsArray(V1) then
      begin
        l := VarArrayHighBound(V1, 1);
        for k := 1 to l do
          stl.Add(IntToStr(V1[k]));
      end;
    end;
    for i := 0 to Length(FDetail) - 1 do
      for j := Length(FDetail[i].Positions) - 1 downto 0 do
        if stl.IndexOf(IntToStr(FDetail[i].Positions[j].Position)) = -1 then
        begin
          for k := j to Length(FDetail[i].Positions) - 1 do
          FDetail[i].Positions[k].Position := FDetail[i].Positions[k + 1].Position;
          SetLength(FDetail[i].Positions, Length(FDetail[i].Positions) - 1);
        end;
{Result filter end}
  finally
    FStream.Free;
    stl.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDRefineExecuter.ExecuteCodeByStream(Code: TSegment; Stream:
  TStream): Boolean;
begin
  FDetail := nil;
  FStream := Stream;
  FStack.Clear;
  FCode := Code;
  iPos := 0;
  while ExecuteCommand do;
  if FStack.Count > 0 then
    Result := VarIsArray(FStack.Code)
  else
    Result := False;
  FStream := nil;
end;

{------------------------------------------------------------------------------}

function TLMDRefineExecuter.ExecuteCommand: Boolean;
var
  szTmp: string;
  V1, V2, VR: Variant;
  i, j, k, l: integer;
  iCount: Integer;
  b: Boolean;
  bWildCard: Boolean;
  WCP: TLMDWildcardProcessor;
  DetailItem: TLMDRefineDetailItem;
  szActual: string;

  function NextChar: Char;
  begin
    FStream.Read(Result, sizeof(Result));
    if not FMatchCase then
      // DONE:
      Result := LMDAnsiUpperChar(Result);
  end;

begin
  if iPos >= FCode.Count then
    Result := False
  else
  begin
    case FCode.Codes[iPos] of
      C_CONST:
        begin
          Inc(iPos);
          szTmp := FCode.Codes[iPos];
          DetailItem.SearchWord := szTmp;
          DetailItem.Positions := nil;
          szActual := '';

          VarClear(VR);
          l := pos(AnySingleCharacter, szTmp);
          j := pos(AnySequenceCharacter, szTmp);
          bWildCard := (l > 0) or (j > 0);
          FStream.Position := 0;

          if bWildCard then
          begin
            WCP := TLMDWildcardProcessor.Create;
            WCP.MatchCase := FMatchCase;
            i := WCP.FindWildcard(szTmp, FStream, szActual, WholeWordsOnly,
                 AnySingleCharacter, AnySequenceCharacter);
          end
          else
          begin
            WCP := nil;
            i := LMDSPFindInStream(FStream, szTmp, FMatchCase);
          end;
          iCount := 0;
          while i > 0 do
          begin
            if FWholeWordsOnly and not (bWildCard) then
            begin
              if (FStream.Position > 0) then
              begin
                FStream.Seek(-1, soFromCurrent);
                //DONE: b := LMDSPIsSpace(NextChar);
                b := LMDAnsiIsSpace(NextChar);
              end
              else
                b := True;
              if b then
              begin
                i := FStream.Position;
                FStream.Seek(Length(szTmp), soFromCurrent);
                //DONE:
                b := LMDAnsiIsSpace(NextChar);
                FStream.Seek(i, soFromBeginning);
                end;
            end
            else
              b := True;
            if b then
            begin
              l := Length(DetailItem.Positions);
              SetLength(DetailItem.Positions, l + 1);
              DetailItem.Positions[l].ActualWord := szActual;
              DetailItem.Positions[l].Position := i;

              if VarIsEmpty(VR) then
              begin
                VR := VarArrayCreate([1, 1], varInteger);
                VR[1] := i;
                iCount := 1;
              end
              else
              begin
                Inc(iCount);
                VarArrayRedim(VR, iCount);
                VR[iCount] := i;
                end;
            end;
           szActual := '';
            if WCP <> nil then
              i := WCP.FindWildcard(szTmp, FStream, szActual, WholeWordsOnly,
                AnySingleCharacter, AnySequenceCharacter)
            else
            begin
              if NextChar = #32 then
                FStream.Seek(-1, soFromCurrent);
                i := LMDSPFindInStream(FStream, szTmp, FMatchCase);
            end;
          end;
          l := Length(FDetail);
          SetLength(FDetail, l + 1);
          FDetail[l] := DetailItem;
          FStack.AddCode(VR);
        end;
      C_OR:
        begin
          V1 := FStack.Pop;
          V2 := FStack.Pop;
          if VarIsArray(V1) or VarIsArray(V2) then
          begin
            if VarIsArray(V1) and VarIsArray(V2) then
            begin
              j := VarArrayHighBound(V1, 1);
              VR := VarArrayCreate([1, j + VarArrayHighBound(V2, 1)],
                varInteger);
              for i := 1 to j do
                VR[i] := V1[i];
              for i := 1 to VarArrayHighBound(V2, 1) do
                VR[i + j] := V2[i];
            end
            else if VarIsArray(V1) then
              VR := V1
            else
              VR := V2;
          end
          else
            VarClear(VR);
          FStack.AddCode(VR);
        end;

      C_AND:
        begin
          V1 := FStack.Pop;
          V2 := FStack.Pop;
          if VarIsArray(V1) and VarIsArray(V2) then
          begin
            j := VarArrayHighBound(V1, 1);
            VR := VarArrayCreate([1, j + VarArrayHighBound(V2, 1)], varInteger);
            for i := 1 to j do
              VR[i] := V1[i];
            for i := 1 to VarArrayHighBound(V2, 1) do
              VR[i + j] := V2[i];
          end
          else
            VarClear(VR);
          FStack.AddCode(VR);
        end;

      C_NOT:
        begin
          V1 := FStack.Pop;
          if VarIsArray(V1) then
            VarClear(VR)
          else
          begin
            VR := VarArrayCreate([1, 1], varInteger);
            VR[1] := 0;
          end;
          FStack.AddCode(VR);
        end;

      C_NEAR:
        begin
          V1 := FStack.Pop;
          V2 := FStack.Pop;
          VarClear(VR);
          if VarIsArray(V1) and VarIsArray(V2) then
          begin
            i := VarArrayHighBound(V1, 1);
            j := VarArrayHighBound(V2, 1);
            iCount := 0;
            for k := 1 to i do
            begin
              for l := 1 to j do
              begin
                if (abs(V1[k] - V2[l]) < FNearLength) then
                begin
                  if VarIsEmpty(VR) then
                  begin
                    VR := VarArrayCreate([1, 2], varInteger);
                    VR[1] := V1[k];
                    VR[2] := V2[l];
                    iCount := 2;
                  end
                  else
                  begin
                    Inc(iCount, 2);
                    VarArrayRedim(VR, iCount);
                    VR[iCount - 1] := V1[k];
                    VR[iCount] := V2[l];
                  end;
                end;
              end;
            end;
          end;
          FStack.AddCode(VR);
        end;
    end;
    Inc(iPos);
    Result := True;
  end;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
{$I C3.INC}
{$ENDIF}

end.
