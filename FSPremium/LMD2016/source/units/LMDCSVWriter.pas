unit LMDCSVWriter;
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

LMDCSVWriter unit (VO)
----------------------

Store parsed data in CSV format

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes, Graphics, Sysutils,
  LMDWriter, LMDStringsList;

type
  { ********************************** TLMDCSVWriter *************************}
  TLMDCSVWriter = class(TLMDWriter)
  private
    FTableRef : integer;
    FStrData  : string;
    FStringsList : TLMDStringsList;
  public
    constructor Create(aStream : TStream); override;
    destructor Destroy; override;
    procedure WriteDocumentStart; override;
    procedure WriteDocumentEnd; override;
    procedure WriteOpenTable(aWidth, aAlign, aVAlign, aCellspacing, aCellpadding, aBorder : integer;
      aBgColor : TColor); override;
    procedure WriteCloseTable; override;
    procedure WriteOpenTableRow;override;
    procedure WriteCloseTableRow;override;
    procedure WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan,
      aAlign, aVAlign : integer; BgColor : TColor); override;
    procedure WriteCloseTableData; override;
    procedure WriteImage(const aSrc : string; aWidth, aHeight : integer);override;
    procedure WriteHLine; override;
    procedure WriteLineBreak; override;
    procedure WriteOpenList(aListType : integer); override;
    procedure WriteCloseList(aListType : integer); override;
    procedure WriterListBullet(aListType , aNo : integer); override;
    procedure WriteOpenLink(const aHREF : string); override;
    procedure WriteCloseLink; override;
    procedure WriteText(const aText : string; aLink : boolean;
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor; aFontStyle : TFontStyles;
      aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
      aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer); override;
    procedure WriteOpenParagraph; override;
    procedure WriteCloseParagraph; override;
    procedure WriteOpenTree ; override;
    procedure WriteCloseTree; override;
    procedure WriterOpenTreeItem;override;
    procedure WriterCloseTreeItem;override;
    procedure WriteEmbdControl(const aControlClass, aControlName : string;
      aHeight, aWidth : integer); override;
  end;

implementation
uses
  LMDText, LMDTable;

const
  cNewLine = #$D#$A;

{ ********************************** TLMDCSVWriter ***************************}

constructor TLMDCSVWriter.Create(aStream : TStream);
begin
  inherited;
  FTableRef := 0;
  FStrData := '';
  FStringsList := TLMDStringsList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDCSVWriter.Destroy;
begin
  FStringsList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenTable(aWidth, aAlign, aVAlign, aCellspacing, aCellpadding, aBorder : integer;
      aBgColor : TColor);
begin
  Inc(FTableRef);
  if (FTableRef = 1) and (FStrData <> '') then
    begin
      FStringsList.Add;
      FStringsList[FStringsList.count-1].Strings.Add(FStrData);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseTable;
begin
  Dec(FTableRef);
  if FTableRef = 0 then FStrData := '';
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenTableRow;
begin
  if FTableRef = 1 then
    FStringsList.Add;
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseTableRow;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan,
      aAlign, aVAlign : integer; BgColor : TColor);
begin
  if FTableRef = 1 then FStrData := '';
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseTableData;
begin
  if FTableRef = 1 then
    FStringsList[FStringsList.count-1].Strings.Add(FStrData);
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteImage(const aSrc : string; aWidth, aHeight : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteHLine;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteLineBreak;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenList(aListType : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseList(aListType : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriterListBullet(aListType , aNo : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenLink(const aHREF : string);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseLink;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteText(const aText : string; aLink : boolean;
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor;
      aFontStyle : TFontStyles; aSubscriptStyle, aTextStyle : integer;
      aLightColor : TColor; aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer);
begin
  FStrData := FStrData + aText;
end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenParagraph;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseParagraph;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteOpenTree ;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteCloseTree;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriterOpenTreeItem;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriterCloseTreeItem;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDCSVWriter.WriteEmbdControl(const aControlClass, aControlName : string;
  aHeight, aWidth : integer);
begin
end;

procedure TLMDCSVWriter.WriteDocumentEnd;
var
  I, J, N : LongInt;
begin
  if FStrData <> '' then
    begin
      FStringsList.Add;
      FStringsList[FStringsList.count-1].Strings.Add(FStrData);
    end;
  FStringsList.Replace(';', ' ');

  N := FStringsList.GetMaxSubItemsCount;
  for I := 0 to FStringsList.Count - 1 do
    begin
      for J := 0 to N - 1 do
        begin
          if J < FStringsList[I].Strings.Count then Write(FStringsList[I].Strings[J])
          else Write(' ');
          if J < N-1 then Write(';');
        end;
        WriteLn;
    end;
end;

procedure TLMDCSVWriter.WriteDocumentStart;
begin
end;

initialization
  RegisterWriter(TLMDCSVWriter, ['CSV'], False);
end.
