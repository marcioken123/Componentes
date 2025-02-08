unit LMDRTFHyperText;
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

LMDRTFHyperText unit (RM)
------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Messages,
  LMDTypes, LMDRTFRichEdit, Windows, Classes;

type
  TLMDRichHyperLink = class(TCollectionItem)
  private
    FLinkType: boolean;
    FLinkAddress: string;
  public
    property LinkType: boolean read FLinkType write FLinkType;
    property LinkAddress: string read FLinkAddress write FLinkAddress;
  end;

  TLMDRichHyperLinks = class(TCollection)
  protected
    function GetItem(Index: Integer): TLMDRichHyperLink;
    procedure SetItem(Index: Integer; const Value: TLMDRichHyperLink);
  public
    constructor Create;
    function Add: TLMDRichHyperLink;
    property Items[Index: Integer]: TLMDRichHyperLink read GetItem write SetItem; default;
  end;

{ ******************************** TLMDRichHyperText ******************************** }
  TLMDRichHyperText = class
  private
    FEditor: TLMDRichEdit;
    function GetLinkedTextParams(var SelStart, SelLength: integer): boolean;
  public
    function ValidLinkSelection: boolean;
    function GetLinkParams(var aType: boolean; var aAddress: string): boolean; overload;
    function GetLinkParams(Pos: integer; var aType: boolean; var aAddress: string): boolean; overload;
    function  DeleteLink: Boolean;
    function  ChangeLink(aType: boolean; const aAddress: string): Boolean;
    procedure ShowLinkDialog;
    procedure GetBookMarks(aBookMarks: TStrings);
    procedure InsertBookMark(const aBookMark: string);
    procedure DeleteBookMark(const aBookMark: string);
    procedure GoToBookMark(const aBookMark: string);
    procedure ShowBookMarksDialog;
    procedure MarkAllLink(aProtectLinks: boolean = true);
    procedure MarkLinksForLabel(FLinkStorage: TLMDRichHyperLinks);
    function  InsertLink(aType: boolean; const aAddress: string): Boolean;
    procedure InsertLinkedText(aType: boolean; const Text, aAddress: string);
    function GetBookMarkPos(const aBookMark: string): TPoint;
    property Editor: TLMDRichEdit read FEditor write FEditor;
  end;

function GetLinkParams(FEditor: TLMDCustomRichEdit; var aType: boolean; var aAddress: string): boolean; overload;
function GetLinkParams(FEditor: TLMDCustomRichEdit; Pos: integer; var aType: boolean; var aAddress: string): boolean; overload;

implementation

uses
  Forms, StdCtrls, Controls, Dialogs, Sysutils, RichEdit,
  LMDRTFInt,
  LMDRTFBookmarkDialog, LMDRTFLinkDialog;

const
  cOpenBracket  = #01;
  cCloseBracket = #02;
  cHR_StartTag  = cOpenBracket + 'HR' + cCloseBracket;
  cHR_EndTag    = cOpenBracket + '/HR:';
  cBM_StartTag  = cOpenBracket + 'BM' + cCloseBracket;
  cBM_EndTag    = cOpenBracket + '/BM' + cCloseBracket;

{ ---------------------------------------------------------------------------- }
constructor TLMDRichHyperLinks.Create;
begin
  inherited Create(TLMDRichHyperLink)
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperLinks.Add: TLMDRichHyperLink;
begin
  Result:= TLMDRichHyperLink(inherited Add)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperLinks.SetItem(Index: Integer; const Value: TLMDRichHyperLink);
begin
  inherited SetItem(Index, Value)
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperLinks.GetItem(Index: Integer): TLMDRichHyperLink;
begin
  Result:= TLMDRichHyperLink(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }

function  MakeLinkPart(IsLink: Boolean; const aAddress: string): string;
begin
  if IsLink then
    Result := cHR_EndTag + 'LNK=' + Trim(aAddress) + cCloseBracket
  else
    Result := cHR_EndTag + 'URL=' + Trim(aAddress) + cCloseBracket;
end;

{ ---------------------------------------------------------------------------- }

function FindPos(FEditor: TLMDCustomRichEdit; StartPos: integer; const Sub: string;
            Backward: Boolean = False; FindLength: integer = 0): integer; overload;
const
  FR_DOWN = $00000001;
var
  Find: TFindText;
  Flag: integer;
begin
  Result := -1;

  if  not (Assigned(FEditor) and FEditor.HandleAllocated) then Exit;

  if  StartPos < 0  then
    StartPos := FEditor.SelStart;

  if  Backward  then
    begin
      Find.chrg.cpMin := StartPos;

      if  FindLength > 0  then
        Find.chrg.cpMax := StartPos - FindLength
      else
        Find.chrg.cpMax := 0;

      Flag := 0;
    end
  else
    begin
      Find.chrg.cpMin:= StartPos;

      if  FindLength > 0  then
        Find.chrg.cpMax := StartPos + FindLength
      else
        Find.chrg.cpMax := MAXINT;

      Flag := FR_DOWN;
    end;

  Find.lpstrText := PChar(Sub);
  Result:= FEditor.Perform(EM_FINDTEXT, Flag, TLMDPtrInt(@Find));

end;

{ ---------------------------------------------------------------------------- }

function  FindLink(FEditor: TLMDCustomRichEdit; StartPos: integer;
              var StartTag, EndTag: integer; InPos: Boolean): Boolean;
begin
  Result := False;

  if  Assigned(FEditor) then
    begin
      if  StartPos < 0  then
        StartPos := FEditor.SelStart;

      StartTag := FindPos(FEditor, StartPos, cHR_StartTag, InPos);

      if  StartTag >= 0 then
        begin
          EndTag := FindPos(FEditor, StartTag + 4, cHR_EndTag);
          Result := (EndTag > (StartTag + 4)) and ((EndTag - StartTag) < 50)
            and (not InPos or (StartTag < StartPos) and (EndTag > StartPos));
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function GetLinkParams(FEditor: TLMDCustomRichEdit; Pos: integer;
          var aType: boolean; var aAddress: string): boolean;
var
  StartTag, EndTag, E: integer;
  Txt: String;
begin
  Result:= False;
  aType:= False;
  aAddress:= '';

  if  FindLink(FEditor, Pos, StartTag, EndTag, True)  then
    begin
      E := FindPos(FEditor, EndTag, cCloseBracket);

      if  E > EndTag  then
        begin
          Txt := String(FEditor.GetTextRange(EndTag, E + 1));

          if SameText(Copy(Txt, 6, 3), 'URL') then
            aType:= False
          else
            aType:= True;

          aAddress:= Copy(Txt, 10, E - EndTag - 9);
          Result := True;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function GetLinkParams(FEditor: TLMDCustomRichEdit; var aType: boolean;
  var aAddress: string):boolean;
begin
  Result:= GetLinkParams(FEditor, -1, aType, aAddress);
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperText.GetLinkedTextParams(var SelStart, SelLength: integer):boolean;
var
  StartTag: integer;
  EndTag: integer;
begin
  Result := False;

  if  FindLink(FEditor, SelStart, StartTag, EndTag, False) then
    begin
      Result := True;
      SelStart := StartTag + 4;
      SelLength := EndTag - StartTag - 4;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperText.ValidLinkSelection: boolean;
var
  aType: Boolean;
  aAddress: string;
begin
  Result:= Assigned(FEditor) and (FEditor.SelAttributes.Link
        or GetLinkParams(aType, aAddress));
{
  if Assigned(FEditor) and (FindPos(1, cOpenBracket + 'HR', FEditor.SelText) = 0)
    and (FindPos(1, cOpenBracket + '/HR', FEditor.SelText) = 0) then
    result:= true;
}
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperText.GetLinkParams(Pos: integer;
          var aType: Boolean; var aAddress: string): Boolean;
begin
  Result := LMDRTFHyperText.GetLinkParams(FEditor, Pos, aType, aAddress);
end;

{ ---------------------------------------------------------------------------- }
function TLMDRichHyperText.GetLinkParams(var aType: boolean; var aAddress: string):boolean;
begin
  Result:= GetLinkParams(-1, aType, aAddress);
end;

{ ---------------------------------------------------------------------------- }
function  TLMDRichHyperText.DeleteLink: Boolean;
var
  StartTag, EndTag, SelStart, E: integer;
begin
  Result := False;
  SelStart := FEditor.SelStart;
  StartTag:= FindPos(FEditor, SelStart, cHR_StartTag);
  EndTag:= FindPos(FEditor, SelStart, cHR_EndTag);

  if (StartTag > 0) and (StartTag < EndTag) then Exit;
  StartTag:= FindPos(FEditor, SelStart, cHR_StartTag, True);

  if (StartTag <= 0) or (StartTag > SelStart) then Exit;

  E := FindPos(FEditor, EndTag, cCloseBracket) + 1;

  if  E < 0 then  Exit;

  FEditor.Lines.BeginUpdate;

  try
    FEditor.SetSelRange(StartTag, E - StartTag);
    FEditor.SelAttributes.Protected:= False;

    FEditor.SetSelRange(StartTag + 4 , EndTag - StartTag - 4);
    FEditor.SelAttributes.Link:= False;

    FEditor.SetSelRange(EndTag, E - EndTag);
    FEditor.ClearSelection;

    FEditor.SetSelRange(StartTag, 4);
    FEditor.ClearSelection;
    Result := True;
  finally
    FEditor.Lines.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
function  TLMDRichHyperText.ChangeLink(aType: Boolean; const aAddress: string): Boolean;
var
  StartTag, EndTag, E, SelStart: integer;
  Txt: string;
  P: Boolean;
begin
  Result := False;

  if  not Assigned(FEditor) then
    Exit;

  SelStart := FEditor.SelStart;
  Txt := Trim(aAddress);

  if  Txt = ''  then
    Result := DeleteLink
  else
  if  FindLink(FEditor, -1, StartTag, EndTag, True)  then
    begin
      E := FindPos(FEditor, EndTag, cCloseBracket);

      if  E > EndTag  then
        begin
          Txt := MakeLinkPart(aType, Txt);
          Result := True;

          if  Txt <> String(FEditor.GetTextRange(EndTag, E))  then
            begin
              FEditor.Lines.BeginUpdate;
              try
                FEditor.SetSelRange(EndTag, E - EndTag + 1);
                FEditor.ClearSelection;
                FEditor.SelAttributes.Hidden:= True;
                FEditor.SelText:= Txt;
                FEditor.SetSelRange(StartTag + 4, EndTag - StartTag - 4);
                P := FEditor.SelAttributes.Protected;

                if  P then
                  FEditor.SelAttributes.Protected := False;

                FEditor.SelAttributes.Link := True;

                if  P then
                  FEditor.SelAttributes.Protected:= True;
              finally
                FEditor.Lines.EndUpdate;
              end;
            end;
        end;
    end;

  FEditor.SelStart := SelStart;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.ShowLinkDialog;
begin
  TLMDRichfrmLinkDialog.Execute(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.GetBookMarks(aBookMarks: TStrings);
var
  StartTag, EndTag, L, LE: integer;
  Txt: string;
begin
  if not (Assigned(FEditor) and Assigned(aBookMarks)) then Exit;

  aBookMarks.BeginUpdate;
  try
    aBookMarks.Clear;
    L := Length(cBM_StartTag);
    LE := Length(cBM_EndTag);
    StartTag := FindPos(FEditor, 1, cBM_StartTag);

    if  StartTag > 0  then
      EndTag := FindPos(FEditor, StartTag + L, cBM_EndTag)
    else
      EndTag := -1;

    while (StartTag > 0) and (EndTag > (StartTag + L)) do
      begin
        Txt := String(FEditor.GetTextRange(StartTag + L, EndTag));

        if  Txt <> '' then
          aBookMarks.Add(Txt);

        StartTag := FindPos(FEditor, EndTag + LE, cBM_StartTag);

        if  StartTag > 0  then
          EndTag:= FindPos(FEditor, StartTag + L, cBM_EndTag)
        else
          EndTag := -1;
      end;
  finally
    aBookMarks.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.InsertBookMark(const aBookMark: string);
begin
  if not assigned(FEditor) then Exit;
    with FEditor do
      begin
        SelLength:= 0;
        SelAttributes.Hidden:= True;
        SelText:= cBM_StartTag + aBookMark + cBM_EndTag;
        SelLength:= 0;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.DeleteBookMark(const aBookMark: string);
var
  OldSelStart, OldSelLength: integer;
  StartSel: integer;
//  EndSel: integer;
//  TextSel: string;
begin
//  if not assigned(FEditor) then Exit;

  StartSel:= FindPos(FEditor, 0, cBM_StartTag + aBookMark + cBM_EndTag);

  if StartSel <> 0 then
    begin
      OldSelStart := FEditor.SelStart;
      OldSelLength := FEditor.SelLength;
      FEditor.SetSelRange(StartSel, Length(cBM_StartTag + aBookMark + cBM_EndTag));
      FEditor.ClearSelection;
      FEditor.SetSelRange(OldSelStart, OldSelLength);
{
      FEditor.SelStart:= StartSel - 1;
      FEditor.SelLength:= 9;
      FEditor.SelStart:= FEditor.SelStart - 1;
      StartSel:= FEditor.SelStart;
      FEditor.SelStart:= FEditor.SelStart + 1;
      EndSel:= FEditor.SelStart;
      FEditor.SelStart:= StartSel;
      FEditor.SelLength:= EndSel - StartSel;
      StartSel:= FindPos(1, cOpenBracket + 'BM' + cCloseBracket + aBookMark +
        cOpenBracket + '/BM' + cCloseBracket, FEditor.SelText);
      TextSel:= Copy(FEditor.SelText, 1, StartSel - 1) +
        Copy(FEditor.SelText, StartSel + Length(aBookMark) + 9,
        Length(FEditor.SelText) - StartSel - Length(aBookMark) - 8);
      FEditor.ClearSelection;
      if TextSel <> '' then
        begin
          FEditor.SelAttributes.Hidden:= True;
          FEditor.SelText:= TextSel;
        end;
}
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.GoToBookMark(const aBookMark: string);
var
  StartTag: integer;
begin
  StartTag := FindPos(FEditor, 0, cBM_StartTag + aBookMark + cBM_EndTag);

  if StartTag >= 0 then
    begin
      FEditor.SetFocus;
      FEditor.SetSelRange(StartTag, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.ShowBookMarksDialog;
begin
  TLMDRichfrmBookMarks.Execute(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.MarkLinksForLabel(FLinkStorage: TLMDRichHyperLinks);
var
  OldSelStart: integer;
  OldSelLength: integer;
  OldProtected: Boolean;
  SelStart: integer;
  Sellength: integer;
  CType, IsLink: boolean;
  CAddress: string;
  CLink: TLMDRichHyperLink;
begin
  if not assigned(FEditor) then Exit;
  OldSelStart:= FEditor.SelStart;
  OldSelLength:= FEditor.SelLength;
  SelStart:= 1;

  while GetLinkedTextParams(SelStart, SelLength) do
    begin
      FEditor.SetSelRange(SelStart, SelLength);
      IsLink := GetLinkParams(CType, CAddress);
      OldProtected := FEditor.SelAttributes.Protected;

      if  OldProtected  then
        FEditor.SelAttributes.Protected:= False;
      FEditor.SelAttributes.Link:= False;

      if  IsLink then
        begin
          CLink := FLinkStorage.Add;
          CLink.LinkType:= CType;
          CLink.LinkAddress:= CAddress;
          FEditor.SelAttributes.Color:= (CLink.Index + 1) * 8;
          FEditor.SelAttributes.BackColor:= (CLink.Index + 1) * 8;
        end;
      if  OldProtected  then
        FEditor.SelAttributes.Protected:= OldProtected;
      SelStart:= SelStart + SelLength + 1;
    end;

  FEditor.SetSelRange(OldSelStart, OldSelLength);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRichHyperText.MarkAllLink;
var
  OldSelStart: integer;
  OldSelLength: integer;
  SelStart: integer;
  Sellength: integer;
  LModified: boolean;
begin
  if not Assigned(FEditor) then Exit;
  LModified := FEditor.Modified;
  OldSelStart:= FEditor.SelStart;
  OldSelLength:= FEditor.SelLength;
  SelStart:= 0;

  FEditor.Lines.BeginUpdate;

  try
    while GetLinkedTextParams(SelStart, SelLength) do
      begin
        FEditor.SetSelRange(SelStart, SelLength);
        FEditor.SelAttributes.Protected:= False;
        FEditor.SelAttributes.Link:= True;
        FEditor.SelAttributes.Protected := aProtectLinks;
        SelStart:= SelStart + SelLength + 1;
      end;

    FEditor.SetSelRange(OldSelStart, OldSelLength);
  finally
    FEditor.Lines.EndUpdate;
    FEditor.Modified := LModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
function  TLMDRichHyperText.InsertLink(aType: boolean; const aAddress: string): Boolean;
var
  OldSelStart   : integer;
  OldSelLength  : integer;
  shifted       : boolean;
  S: string;
  i: integer;
begin
  Result := False;

  if not assigned(FEditor) then Exit;

  if (FEditor.SelLength = 0) or (Trim(aAddress) = '') then Exit;

  shifted := False;
  FEditor.Lines.BeginUpdate;

  try
    OldSelStart:= FEditor.SelStart;
    S := FEditor.SelText;
    i := Length(S);

    while (i > 0) and (S[i] < ' ') do dec(i);

    OldSelLength := i;

    if FEditor.SelStart = 0 then
    begin
      FEditor.SelLength := 0;
      FEditor.SelText := ' ';
      OldSelStart := 1;
      FEditor.SelStart := OldSelStart;
    end;

    FEditor.SetSelRange(OldSelStart + OldSelLength - 1, 1);

    if length(FEditor.SelText) = 0 then
    begin
      FEditor.SelStart := OldSelStart + OldSelLength - 1;
      FEditor.SelLength:= 0;
      FEditor.SelText := ' ';
      OldSelLength := OldSelLength - 1;
      shifted := True;
    end;

    FEditor.SetSelRange(OldSelStart, 0);
    FEditor.SelAttributes.Hidden:= True;
    FEditor.SelText:= cHR_StartTag;

    FEditor.SetSelRange(OldSelStart + OldSelLength + 4, 0);
    FEditor.SelAttributes.Hidden:= True;
    FEditor.SelText := MakeLinkPart(aType, aAddress);

    FEditor.SetSelRange(OldSelStart + 4, OldSelLength);
    FEditor.SelAttributes.Link:= True;
    FEditor.SelAttributes.Protected := FEditor.ProtectLinks;

    if shifted then
      FEditor.SetSelRange(OldSelStart + OldSelLength + 100, 0);
  finally
    FEditor.Lines.EndUpdate;
  end;

  Result := True;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRichHyperText.InsertLinkedText(aType: boolean; const Text, aAddress: string);
var
  SS: integer;
begin
  if not assigned(FEditor) or (Text = '') or (aAddress = '') then Exit;

  FEditor.SelLength:= 0;
  SS := FEditor.SelStart;
  FEditor.SelText := Text;
  FEditor.SetSelRange(SS, Length(Text));
  InsertLink(aType, aAddress);
  SS := FEditor.SelStart + FEditor.SelLength + Length(aAddress) + 10;
  FEditor.SetSelRange(SS, 0);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRichHyperText.GetBookMarkPos(const aBookMark: string): TPoint;
var
  BookMarkPos: TPoint;
  CurY, StartTag: integer;
  MaxSize: integer;
  FCanvas: TControlCanvas;
begin
  Result.y := 0;
  Result.x := 0;

  StartTag := FindPos(FEditor, 0, cBM_StartTag + aBookMark + cBM_EndTag);

  if  StartTag < 0  then
    Exit;

  FEditor.SetSelRange(StartTag, 0);
{
  SendMessage(FEditor.Handle, EM_GETSCROLLPOS, 0, LPARAM(@Result));
}

  BookMarkPos:= FEditor.CursorPos;
  FEditor.SetSelRange(0, 0);
  CurY:= FEditor.CursorPos.y;
  MaxSize:= 0;
  FCanvas:= TControlCanvas.Create;

  try
    TControlCanvas(FCanvas).Control:= FEditor;

    while True do
      begin
      // change line
        if CurY <> FEditor.CursorPos.y then
          begin
            inc(Result.y, MaxSize);
            MaxSize:= 0;
            CurY:= FEditor.CursorPos.y;
          end;

        if (CurY = BookMarkPos.y) then
          if  (FEditor.CursorPos.x <= BookMarkPos.x) then
            inc(Result.x, round(FCanvas.TextWidth(FEditor.SelText) * 72 /
              FCanvas.Font.PixelsPerInch))
          else
            Break;

      // break cycle
        if (CurY > BookMarkPos.y) or (FEditor.SelStart > StartTag) then
          begin
            inc(Result.y, MaxSize);
            Break;
          end;

      // Find Max RowHeight
        if FEditor.SelAttributes.Size > MaxSize then
          MaxSize:= FEditor.SelAttributes.Size;

        FEditor.SetSelRange(FEditor.SelStart + FEditor.SelLength, 1);
      end;
  finally
    FCanvas.Free;
  end;

end;

end.
