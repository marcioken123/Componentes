unit LMDPlainTextWriter;
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

LMDPlainTextWriter unit (VO)
----------------------------

Store parserd text in plain text format 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes, Graphics, Sysutils,
  LMDWriter;

type
  { ********************************** TLMDPlainTextWriter *************************}
  TLMDPlainTextWriter = class(TLMDWriter)
  public
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
  LMDText, LMDTable;

const
  cNewLine = #$D#$A;

{ ********************************** TLMDPlainTextWriter ***************************}

procedure TLMDPlainTextWriter.WriteOpenTable(aWidth, aAlign, aVAlign, aCellspacing, aCellpadding, aBorder : integer;
      aBgColor : TColor);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseTable;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenTableRow;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseTableRow;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan,
      aAlign, aVAlign : integer; BgColor : TColor);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseTableData;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteImage(const aSrc : string; aWidth, aHeight : integer);
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteHLine;
begin end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteLineBreak;
begin
  Writeln;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenList(aListType : integer);
begin
  Indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseList(aListType : integer);
begin
  RevIndent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriterListBullet(aListType , aNo : integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenLink(const aHREF : string);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseLink;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteText(const aText : string; aLink : boolean;
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor;
      aFontStyle : TFontStyles; aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
      aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer);
begin
  Write(' '+aText);
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenParagraph;
begin
  Writeln;
  indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseParagraph;
begin
  RevIndent;
  Writeln;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteOpenTree ;
begin
  indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteCloseTree;
begin
  RevIndent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriterOpenTreeItem;
begin
  Indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriterCloseTreeItem;
begin
  RevIndent;
end;

{------------------------------------------------------------------------------}

procedure TLMDPlainTextWriter.WriteEmbdControl(const aControlClass, aControlName : string;
    aHeight, aWidth : integer);
begin
end;

procedure TLMDPlainTextWriter.WriteDocumentEnd;
begin
end;

procedure TLMDPlainTextWriter.WriteDocumentStart;
begin
end;

initialization
  RegisterWriter(TLMDPlainTextWriter, ['txt', 'text'], true);
end.
