unit LMDDBFWriter;
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

LMDDBFWriter unit (VO)
----------------------

Store parsed data in DBF format 

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
  { ********************************** TLMDDBFWriter *************************}
  TLMDDBFWriter = class(TLMDWriter)
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
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor;
      aFontStyle : TFontStyles; aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
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
  LMDText, LMDTable, LMDDBFReader;

const
  cNewLine = #$D#$A;

{ ********************************** TLMDDBFWriter ***************************}

constructor TLMDDBFWriter.Create(aStream : TStream);
begin
  inherited;
  FTableRef := 0;
  FStrData := '';
  FStringsList := TLMDStringsList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDDBFWriter.Destroy;
begin
  FStringsList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenTable(aWidth, aAlign, aVAlign, aCellspacing, aCellpadding, aBorder : integer;
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

procedure TLMDDBFWriter.WriteCloseTable;
begin
  Dec(FTableRef);
  if FTableRef = 0 then FStrData := '';
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenTableRow;
begin
  if FTableRef = 1 then
    FStringsList.Add;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseTableRow;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan,
      aAlign, aVAlign : integer; BgColor : TColor);
begin
  if FTableRef = 1 then FStrData := '';
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseTableData;
begin
  if FTableRef = 1 then
    FStringsList[FStringsList.count-1].Strings.Add(FStrData);
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteImage(const aSrc : string; aWidth, aHeight : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteHLine;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteLineBreak;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenList(aListType : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseList(aListType : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriterListBullet(aListType , aNo : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenLink(const aHREF : string);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseLink;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteText(const aText : string; aLink : boolean;
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor;
      aFontStyle : TFontStyles; aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
      aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer);
begin
  FStrData := FStrData + aText;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenParagraph;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseParagraph;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteOpenTree ;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteCloseTree;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriterOpenTreeItem;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriterCloseTreeItem;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDDBFWriter.WriteEmbdControl(const aControlClass, aControlName : string;
  aHeight, aWidth : integer);
begin
end;

procedure TLMDDBFWriter.WriteDocumentEnd;
var
  I, J, N : LongInt;
  DBFHeader : TLMDDBFHeader;
  FieldDef : TLMDDBFFieldDef;
  tmpStr : string;
  tmpByte : byte;
  begin
  if FStrData <> '' then
    begin
      FStringsList.Add;
      FStringsList[FStringsList.count-1].Strings.Add(FStrData);
    end;

  DBFHeader := TLMDDBFHeader.Create;
  N := FStringsList.GetMaxSubItemsCount;
  try
    DBFHeader.Version := 3;
    DBFHeader.Modified := Date;
    DBFHeader.RecordCount := FStringsList.Count;
    DBFHeader.FirstRecordOffset := 33*(N+1)-1;
    DBFHeader.RecordSize := 1;
    DBFHeader.CDXPresent := False;

    for I := 0 to N-1 do
      begin
        FieldDef := DBFHeader.FieldDefs.Add;
        FieldDef.FieldName := 'Field_'+IntToStr(I);
        FieldDef.FieldType := ftChar;
        FieldDef.FieldSize := FStringsList.GetMaxSubItemLength(I);
        DBFHeader.RecordSize := DBFHeader.RecordSize + FieldDef.FieldSize;
      end;
    DBFHeader.Save(Stream);

    tmpByte := 0;
    while Stream.Position < DBFHeader.FirstRecordOffset do
      Stream.WriteBuffer(tmpByte,1);

    for I := 0 to FStringsList.Count-1 do
      begin
        Write(' ');
        for J := 0 to N-1 do
          begin
            SetString(tmpStr, nil, DBFHeader.FieldDefs[J].FieldSize);
            if J < FStringsList[I].Strings.Count then
              tmpStr := Copy(FStringsList[I].Strings[J], 1, Length(FStringsList[I].Strings[J]));
            Stream.WriteBuffer(PChar(tmpStr)^, DBFHeader.FieldDefs[J].FieldSize);
            end;
      end;
  finally
    DBFHeader.Free;
  end;
end;

procedure TLMDDBFWriter.WriteDocumentStart;
begin
end;

initialization
  RegisterWriter(TLMDDBFWriter, ['DBF'], False);
end.
