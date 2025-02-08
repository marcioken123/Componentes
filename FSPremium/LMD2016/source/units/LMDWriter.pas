unit LMDWriter;
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

LMDWriter unit (VO)
-------------------

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Graphics, Classes, SysUtils;

type

  TLMDWriter = class;
  TLMDWriterClass = class of TLMDWriter;

  { ********************************** TLMDWriter *****************************}
  TLMDWriterMode = (wmWindows, wmUnix);
  TLMDWriter = class
  private
    FStream     : TStream;
    FIndent     : integer;
    FMode       : TLMDWriterMode;
    function GetIndent : string;
  public
    constructor Create(aStream : TStream = nil); overload; virtual;
    procedure Indent;
    procedure RevIndent;
    procedure Write(const aText : string);
    procedure Writeln(const aText : string); overload;
    procedure Writeln; overload;
    procedure WriteIndent;

    procedure WriteDocumentStart; virtual; abstract;
    procedure WriteDocumentEnd; virtual; abstract;

    procedure WriteOpenTable(aWidth, aAlign , aVAlign , aCellspacing, aCellpadding, aBorder : integer;
      aBgColor : TColor); virtual; abstract;
    procedure WriteCloseTable; virtual; abstract;
    procedure WriteOpenTableRow; virtual; abstract;
    procedure WriteCloseTableRow; virtual; abstract;
    procedure WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan, aAlign, aVAlign : integer;
      BgColor : TColor); virtual; abstract;
    procedure WriteCloseTableData; virtual; abstract;
    procedure WriteImage(const aSrc : string; aWidth, aHeight : integer);virtual; abstract;
    procedure WriteHLine;virtual; abstract;
    procedure WriteLineBreak; virtual; abstract;
    procedure WriteOpenList(aListType : integer); virtual; abstract;
    procedure WriteCloseList(aListType : integer); virtual; abstract;
    procedure WriterListBullet(aListType , aNo : integer); virtual; abstract;
    procedure WriteOpenLink(const aHREF : string); virtual; abstract;
    procedure WriteCloseLink; virtual; abstract;

    procedure WriteText(const aText : string; aLink : boolean; const
      aHREF, aFontFace, aFontSize : string; aFontColor : TColor; aFontStyle : TFontStyles;
      aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
      aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer); virtual; abstract;

    procedure WriteOpenParagraph; virtual; abstract;
    procedure WriteCloseParagraph; virtual; abstract;
    procedure WriteOpenTree ; virtual; abstract;
    procedure WriteCloseTree; virtual; abstract;
    procedure WriterOpenTreeItem;virtual; abstract;
    procedure WriterCloseTreeItem;virtual; abstract;
    procedure WriteEmbdControl(const aControlClass, aControlName : string;
      aHeight, aWidth : integer);virtual; abstract;
    property Stream : TStream read FStream write FStream;
    property Mode :  TLMDWriterMode read FMode  write FMode;
  end;

  PLMDWriterRec = ^TLMDWriterRec;
  TLMDWriterRec = record
  Default: Boolean;
    WriterClass: TLMDWriterClass;
  end;

  { ********************************* Register routines ************************}
procedure RegisterWriter(aWriterClass: TLMDWriterClass;
  const aExtentions: array of string; aDefault: Boolean);
procedure UnregisterWriter(aWriterClass: TLMDWriterClass);
function Writers: TList;
function DefaultWriterClass: TLMDWriterClass;

implementation

var
  FWriters: TList;

  { ********************************* Register routines ************************}
  {-----------------------------------------------------------------------------}

procedure RegisterWriter(aWriterClass: TLMDWriterClass;
  const aExtentions: array of string; aDefault: Boolean);
var
  P: PLMDWriterRec;
  I: LongInt;
begin
  GetMem(P, SizeOf(TLMDWriterRec));
  P.Default:= aDefault;
  P.WriterClass:= aWriterClass;

  if aDefault then
    begin
      for I:= 0 to FWriters.Count - 1 do
        if PLMDWriterRec(FWriters[I]).Default then
          begin
            PLMDWriterRec(FWriters[I]).Default:= false;
            Break;
          end;
        end;
  FWriters.Add(P);
end;

{-----------------------------------------------------------------------------}

procedure UnregisterWriter(aWriterClass: TLMDWriterClass);
var
  I: LongInt;
begin
  for I:= 0 to FWriters.Count - 1 do
    if PLMDWriterRec(FWriters[I])^.WriterClass = aWriterClass then
      begin
        FreeMem(FWriters[I], SizeOf(TLMDWriterRec));
        FWriters.Delete(I);
        Break;
      end;
    end;

{-----------------------------------------------------------------------------}

function Writers: TList;
begin
  Result:= FWriters
end;

{-----------------------------------------------------------------------------}

function DefaultWriterClass: TLMDWriterClass;
var
  I: LongInt;
begin
  for I:= 0 to FWriters.Count - 1 do
  if PLMDWriterRec(FWriters[I]).Default then
      begin
        Result:= PLMDWriterRec(FWriters[I]).WriterClass;
        Exit;
      end;
  if FWriters.Count > 0 then
    Result:= PLMDWriterRec(FWriters[0]).WriterClass
  else
    raise Exception.Create('Don''t have any registered writer...')
  end;

{ ********************************** TLMDWriter *******************************}
constructor TLMDWriter.Create(aStream : TStream = nil);
begin
  inherited Create;
  FStream :=  aStream;
  FIndent := 0;
  FMode := wmWindows;
end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.Indent;
begin
  inc(FIndent, 2);
end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.RevIndent;
begin
  Dec(FIndent, 2);
end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.Write(const aText : string);

begin
  if not assigned(FStream) then Exit;
  FStream.Write(PChar(aText)^, Length(aText));
  end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.Writeln;
var
  aText : string;
  begin
  if Mode = wmWindows then aText := #13#10
  else aText := #10;
  if not assigned(FStream) then Exit;
  FStream.Write(PChar(aText)^, Length(aText));
  end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.Writeln(const aText : string);
var
  Txt: string;
  begin
  if not assigned(FStream) then Exit;
  if Mode = wmWindows then
    Txt := aText + #13#10
  else
    Txt := aText + #10;
  FStream.Write(PChar(Txt)^, Length(Txt));
  end;

{------------------------------------------------------------------------------}

function TLMDWriter.GetIndent : string;
var
  I : LongInt;
begin
  result := '';
  for I := 0 to FIndent-1 do
    result := result+' ';
end;

{------------------------------------------------------------------------------}

procedure TLMDWriter.WriteIndent;
var
  aText : string;
  begin
  if not assigned(FStream) then Exit;
  aText := GetIndent;
  FStream.Write(PChar(aText)^, Length(aText));
  end;

initialization
  FWriters:= TList.Create;

finalization
  while FWriters.Count > 0 do
    UnregisterWriter(PLMDWriterRec(FWriters[0])^.WriterClass);
    FWriters.Free;

end.
