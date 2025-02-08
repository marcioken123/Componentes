unit LMDHTMLWriter;
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

LMDHTMLWriter unit (VO)
-----------------------

Store parsed data in HTML format

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, Graphics, Sysutils,
  LMDWriter;

type
  { ********************************** TLMDHTMLWriter *************************}
  TLMDHTMLWriter = class(TLMDWriter)
  private
    FMustClose : boolean;
    FOnlyCheck : boolean;
    FOrderHandler : TList;
    FLink       : boolean;
    FHREF       : string;
    FFontFace   : string;
    FFontSize   : string;
    FFontColor  : TColor;
    FFontStyle  : TFontStyles;
    FSubscriptStyle : integer;
    FTextStyle  : integer;
    FLightColor : TColor;
    FLightDepth : integer;
    FShadowColor : TColor;
    FShadowDepth : integer;
    procedure ClearTextState;
    procedure CloseText;

    function  CloseSubscriptStyle(aSubscriptStyle : integer) : boolean;
    procedure OpenSubscriptStyle(aSubscriptStyle : integer);
    function  CloseLink(aLink : boolean) : boolean;
    procedure OpenLink(aLink : boolean; aHREF : string);
    function  CloseTextStyle(aTextStyle : Integer; aShadowColor : TColor;
      aShadowDepth : integer; aLightColor : TColor; aLightDepth : Integer) : boolean;
    procedure OpenTextStyle(aTextStyle : Integer; aShadowColor : TColor;
      aShadowDepth : integer; aLightColor : TColor; aLightDepth : Integer);
    function  CloseFontAttr(aFontFace, aFontSize : string;
      aFontColor : TColor) : boolean;
    procedure OpenFontAttr(aFontFace, aFontSize : string; aFontColor : TColor);
    function  CloseFontStyle(aFontStyle : TFontStyles; aStyle : TFontStyle) : boolean;
    procedure OpenFontStyle(aFontStyle : TFontStyles; aStyle : TFontStyle);
    function ColorToHTML(aValue : TColor) : string;
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
  LMDTypes, LMDText, LMDTable;

{ ********************************** TLMDHTMLWriter ***************************}

procedure TLMDHTMLWriter.ClearTextState;
begin
  FLink := False;
  FHREF := '';

  FFontFace  := '';
  FFontSize  := '';
  FFontColor := clDefault;
  FFontStyle := [];

  FShadowColor := clDefault;
  FShadowDepth := 0;
  FLightColor  := clDefault;
  FLightDepth := 0;
  FTextStyle := Integer(tsNormal);
  FSubscriptStyle := Integer(tssNone);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.CloseText;
var
  I : LongInt;
begin
  FOnlyCheck := False;
  FMustClose := True;

  for I := FOrderHandler.count-1 downto 0 do
    case Integer(FOrderHandler[I]) of
      0 : CloseSubscriptStyle(0);
      1 : CloseLink(False);
      2 : CloseTextStyle(0, clDefault, 0, clDefault, 0);
      3 : CloseFontAttr(FFontFace, FFontSize, FFontColor);
      4 : CloseFontStyle([], fsBold);
      5 : CloseFontStyle([], fsItalic);
      6 : CloseFontStyle([], fsUnderline);
      7 : CloseFontStyle([], fsStrikeout);
    end;

  FOrderHandler.Clear;
  ClearTextState;
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLWriter.CloseSubscriptStyle(aSubscriptStyle : integer) : boolean;
begin
  result := (aSubscriptStyle <> FSubscriptStyle);
  if FOnlyCheck then Exit;
  if (FMustClose and (TLMDTextSubscriptStyle(FSubscriptStyle) <> tssNone)) or result then
    case TLMDTextSubscriptStyle(FSubscriptStyle) of
      tssSubscript : Write('</SUB>');
      tssSuperscript : Write('</SUP>');
     end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.OpenSubscriptStyle(aSubscriptStyle : integer);
begin
  if (aSubscriptStyle <> FSubscriptStyle) then
    begin
      case TLMDTextSubscriptStyle(aSubscriptStyle) of
        tssSubscript : Write('<SUB>');
        tssSuperscript : Write('<SUP>');
      end;
      FSubscriptStyle := aSubscriptStyle;
      if TLMDTextSubscriptStyle(aSubscriptStyle) <> tssNone then
        FOrderHandler.Add(Pointer(0));
        end;
end;

{------------------------------------------------------------------------------}

function TLMDHTMLWriter.CloseLink(aLink : boolean) : boolean;
begin
  result := (aLink <> FLink);
  if FOnlyCheck then Exit;
  if (FMustClose and FLink) or Result then
    begin
      if FLink then
        WriteCloseLink;
      result := True;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.OpenLink(aLink : boolean; aHREF : string);
begin
  if aLink <> FLink then
    begin
      if aLink then
        begin
          WriteOpenLink(aHREF);
          FOrderHandler.Add(Pointer(1));
          end;
      FLink := aLink;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDHTMLWriter.CloseTextStyle(aTextStyle : Integer; aShadowColor : TColor;
  aShadowDepth : integer; aLightColor : TColor; aLightDepth : Integer) : boolean;
begin
  result := (aTextStyle <> FTextStyle) or
     (aShadowColor <> FShadowColor) or
     (aShadowDepth <> FShadowDepth) or
     (aLightColor <> FLightColor) or
     (aLightDepth <> FLightDepth);
  if FOnlyCheck then Exit;
  if (FMustClose and (TLMDTextStyle(FTextStyle) <> tsNormal)) or Result then
    begin
      case TLMDTextStyle(FTextStyle) of
        tsSunken : Write('</SUNKEN>');
        tsRaised : Write('</RAISED>');
        tsPColorSunken : Write('</PCOLOR>');
        tsPColorRaised : Write('</PCOLOR>');
      end;
      result := True;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.OpenTextStyle(aTextStyle : Integer; aShadowColor : TColor;
  aShadowDepth : integer; aLightColor : TColor; aLightDepth : Integer);
begin
  if (aTextStyle <> FTextStyle) or
     (aShadowColor <> FShadowColor) or
     (aShadowDepth <> FShadowDepth) or
     (aLightColor <> FLightColor) or
     (aLightDepth <> FLightDepth)
  then
    begin
      case TLMDTextStyle(aTextStyle) of
        tsSunken : Write('<SUNKEN LIGHTCOLOR='+ColorToHTML(aLightColor)+
          ' LIGHTDEPTH='+IntToStr(aLightDepth)+'>');
        tsRaised : Write('<RAISED LIGHTCOLOR='+ColorToHTML(aLightColor)+
          ' LIGHTDEPTH='+IntToStr(aLightDepth)+'>');
        tsPColorSunken, tsPColorRaised : Write('<PCOLOR LIGHTCOLOR='+
          ColorToHTML(aLightColor)+' LIGHTDEPTH='+IntToStr(aLightDepth)+
          ' SHADOWCOLOR='+ColorToHTML(aShadowColor)+' SHADOWDEPTH='+
          IntToStr(aShadowDepth)+'>');
      end;
      FTextStyle := aTextStyle;
      FShadowColor := aShadowColor;
      FShadowDepth := aShadowDepth;
      FLightColor := aLightColor;
      FLightDepth := aLightDepth;
      if TLMDTextStyle(aTextStyle) <> tsNormal then
        FOrderHandler.Add(Pointer(2));
        end;
end;

{------------------------------------------------------------------------------}

function TLMDHTMLWriter.CloseFontAttr(aFontFace, aFontSize : string;
  aFontColor : TColor) : boolean;
begin
  result := (not AnsiSameText(aFontFace, FFontFace)) or
     (not AnsiSameText(aFontSize, FFontSize)) or
  (aFontColor <> FFontColor);
  if FOnlyCheck then Exit;
  if (FMustClose and ((FFontFace <> '') or (FFontSize <> '') or (FFontColor <> clDefault))) or Result then
    begin
      result := True;
      if (FMustClose and ((FFontFace <> '') or (FFontSize <> '') or (FFontColor <> clDefault))) then
        begin
          Write('</FONT>');
          Exit;
        end;
      if (aFontFace = '') and (aFontSize = '') and (aFontColor = clDefault) then Exit;
      Write('</FONT>');
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.OpenFontAttr(aFontFace, aFontSize : string;
  aFontColor : TColor);
var
  S : string;
  lColor : string;
  L      : integer;
begin
  if (not AnsiSameText(aFontFace, FFontFace)) or
     (not AnsiSameText(aFontSize, FFontSize)) or
  (aFontColor <> FFontColor)
  then
    begin
      FFontFace := aFontFace;
      FFontSize := aFontSize;
      FFontColor := aFontColor;
      if (aFontFace = '') and (aFontSize = '') and (aFontColor = clDefault) then
        Exit;
      S := '<FONT';
      if aFontColor <> clDefault then
        begin
          lColor := ColorToString(aFontColor);
          L := Length(LColor);
          if lColor[2] = 'l' then lColor := Copy(lColor, 3, Length(lColor)-2)
          else lColor := '#'+lColor[L]+lColor[L-1]+lColor[L-2]+lColor[L-3]+lColor[L-4]+lColor[L-5];
          if lColor <> '#000000' then S := S + ' COLOR='+lColor;
        end;
      if aFontFace <> '' then S := S + ' FACE='+aFontFace;
      if aFontSize <> '' then S := S + ' POINT-SIZE='+aFontSize;
      S := S + '>';
      Write(S);
      FOrderHandler.Add(Pointer(3));
      end;
end;

{------------------------------------------------------------------------------}

function TLMDHTMLWriter.CloseFontStyle(aFontStyle : TFontStyles; aStyle : TFontStyle) : boolean;
var
  S : string;
begin
  result := (aStyle in FFontStyle) and (not(aStyle in aFontStyle));
  if FOnlyCheck then Exit;
  if (FMustClose and (aStyle in FFontStyle)) or Result then
    begin
      S := '';
      case aStyle of
        fsItalic : S := S + '</I>';
        fsUnderline : S := S + '</U>';
        fsBold : S := S + '</B>';
        fsStrikeout : S := S + '</S>';
      end;
      Write(S);
      result := True;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.OpenFontStyle(aFontStyle : TFontStyles; aStyle : TFontStyle);
var
  S : string;
begin
  if (not(aStyle in FFontStyle)) and (aStyle in aFontStyle) then
    begin
      S := '';
      case aStyle of
        fsBold : S := S + '<B>';
        fsUnderline : S := S + '<U>';
        fsItalic : S := S + '<I>';
        fsStrikeout : S := S + '<S>';
      end;
      Write(S);
      FFontStyle := FFontStyle + [aStyle];
      case aStyle of
        fsBold : FOrderHandler.Add(Pointer(4));
        fsItalic : FOrderHandler.Add(Pointer(5));
        fsUnderline : FOrderHandler.Add(Pointer(6));
        fsStrikeout : FOrderHandler.Add(Pointer(7));
        end;
    end
  else if (aStyle in FFontStyle) and (not (aStyle in aFontStyle)) then
    FFontStyle := FFontStyle - [aStyle];
end;

{------------------------------------------------------------------------------}

function TLMDHTMLWriter.ColorToHTML(aValue : TColor) : string;
var
  lColor : string;
  L      : integer;
begin
  result := '#000000';
  if aValue <> clDefault then begin
    lColor := ColorToString(aValue);
    L := Length(LColor);
    if lColor[2] = 'l' then
      lColor := Copy(lColor, 3, Length(lColor)-2)
    else
      lColor := '#'+lColor[L]+lColor[L-1]+lColor[L-2]+lColor[L-3]+lColor[L-4]+lColor[L-5];
      Result := lColor;
  end;
end;

{------------------------------------------------------------------------------}

constructor TLMDHTMLWriter.Create(aStream : TStream);
begin
  inherited;
  FOrderHandler := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDHTMLWriter.Destroy;
begin
  FOrderHandler.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenTable(aWidth, aAlign, aVAlign, aCellspacing, aCellpadding, aBorder : integer;
      aBgColor : TColor);
var
  S : string;
begin
  CloseText;
  S := '<TABLE';
  if aWidth > 0 then
    S := S + ' width='+IntToStr(aWidth)
  else if (aWidth >= -100) and (aWidth <> 0) then
    S := S + ' width='+IntToStr((-1)*aWidth)+'%';

  if aCellspacing > 0 then
    S := S + ' cellspacing='+IntToStr(aCellspacing);
  if aCellpadding > 0 then
    S := S + ' cellpadding='+IntToStr(aCellpadding);
  if aBorder > 0 then
    S := S + ' border='+IntToStr(aBorder);

  case TLMDParaAlign(aAlign) of
    paLeft : S := S + ' align=left';
    paRight : S := S + ' align=right';
    paJustify : S := S + 'align=justify';
  end;

  case TLMDVAlign(aVAlign) of
    vaMiddle: S := S + ' valign=middle';
    vaBottom : S := S + ' valign=bottom';
  end;

  S := S + '>';

  WriteLn;
  WriteIndent;
  Writeln(S);
  WriteIndent;
  Write('<TBODY>');
  Indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseTable;
begin
  RevIndent;
  Writeln;
  WriteIndent;
  Writeln('</TBODY>');
  WriteIndent;
  writeln('</TABLE>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenTableRow;
begin
  WriteLn;
  WriteIndent;
  Write('<TR>');
  Indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseTableRow;
begin
  RevIndent;
  Writeln;
  WriteIndent;
  Write('</TR>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenTableData(aWidth, aHeight, aRowspan, aColspan,
      aAlign, aVAlign : integer; BgColor : TColor);
var
  S : string;
  lColor : string;
  L      : integer;
begin
  CloseText;
  S := '<TD';

  if aWidth > 0 then
    S := S + ' width='+IntToStr(aWidth)
  else if (aWidth >= -100) and (aWidth <> 0) then
    S := S + ' width='+IntToStr((-1)*aWidth)+'%'
    else if (aWidth < -100)  then
      S := S + ' width='+IntToStr((-1)*aWidth-100)+'*';

  if aHeight > 0 then
    S := S + ' height='+IntToStr(aHeight);

  if aRowspan > 1 then
    S := S + ' rowspan='+IntToStr(aRowspan);
  if aColspan > 1 then
    S := S + ' colspan='+IntToStr(aColspan);

  if BgColor <>  clDefault then begin
    lColor := ColorToString(BgColor);
    L := Length(LColor);
    if lColor[2] = 'l' then
      lColor := Copy(lColor, 3, Length(lColor)-2)
    else
      lColor := '#'+lColor[L]+lColor[L-1]+lColor[L-2]+lColor[L-3]+lColor[L-4]+lColor[L-5];
    if lColor <> '#000000' then S := S + ' bgcolor='+lColor;
  end;

  case TLMDParaAlign(aAlign) of
    paRight : S := S + ' align=right';
    paJustify : S := S + 'align=justify';
  end;

  case TLMDVAlign(aVAlign) of
    vaMiddle: S := S + ' valign=middle';
    vaBottom : S := S + ' valign=bottom';
  end;

  S := S + '>';
  WriteLn;
  WriteIndent;
  Write(S);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseTableData;
begin
  CloseText;
  Write('</TD>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteImage(const aSrc : string; aWidth, aHeight : integer);
begin
  Write('<IMG src="'+aSrc+'" alt="" width='+IntToStr(aWidth)+' height='+IntToStr(aHeight)+'>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteHLine;
begin
  Write('<HR>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteLineBreak;
begin
  Writeln('<BR>');
  WriteIndent;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenList(aListType : integer);
begin
  CloseText;
  WriteLn;
  WriteIndent;
  case TLMDListType(aListType) of
    ltUnordered : Write('<UL>');
    ltOrdered : Write('<OL>');
  end;
  indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseList(aListType : integer);
begin
  CloseText;
  RevIndent;
  WriteLn;
  WriteIndent;
  case TLMDListType(aListType) of
    ltUnordered : WriteLn('</UL>');
    ltOrdered : WriteLn('</OL>');
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriterListBullet(aListType , aNo : integer);
begin
  WriteLn;
  WriteIndent;
  Write('<LI>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenLink(const aHREF : string);
begin
  Write('<A HREF="'+aHREF+'">');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseLink;
begin
  Write('</A>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteText(const aText : string; aLink : boolean;
      const aHREF, aFontFace, aFontSize : string; aFontColor : TColor;
      aFontStyle : TFontStyles; aSubscriptStyle, aTextStyle : integer; aLightColor : TColor;
      aLightDepth : integer; aShadowColor : TColor; aShadowDepth : integer);
var
  I, J : LongInt;

  function CloseTag(aID : integer) : boolean;
  begin
    case aID of
      0 : result := CloseSubscriptStyle(aSubscriptStyle);
      1 : result := CloseLink(aLink);
      2 : result := CloseTextStyle(aTextStyle, aShadowColor, aShadowDepth, aLightColor, aLightDepth);
      3 : result := CloseFontAttr(aFontFace, aFontSize, aFontColor);
      4 : result := CloseFontStyle(aFontStyle, fsBold);
      5 : result := CloseFontStyle(aFontStyle, fsItalic);
      6 : result := CloseFontStyle(aFontStyle, fsUnderline);
      7 : result := CloseFontStyle(aFontStyle, fsStrikeout);
    else
      Result := False;
    end;
  end;

begin
  FMustClose := False;
  FOnlyCheck := True;
  for I := 0 to FOrderHandler.count-1 do
    if CloseTag(Integer(FOrderHandler[I])) then
      begin
        FOnlyCheck := False;
        FMustClose := True;
        for J := FOrderHandler.count-1 downto I do
          CloseTag(Integer(FOrderHandler[J]));
        for J := FOrderHandler.count-1 downto I do
          FOrderHandler.Delete(J);
        Break;
      end;
  OpenSubscriptStyle(aSubscriptStyle);
  OpenLink(aLink, aHREF);
  OpenTextStyle(aTextStyle, aShadowColor, aShadowDepth, aLightColor, aLightDepth);
  OpenFontAttr(aFontFace, aFontSize, aFontColor);
  OpenFontStyle(aFontStyle, fsBold);
  OpenFontStyle(aFontStyle, fsItalic);
  OpenFontStyle(aFontStyle, fsUnderline);
  OpenFontStyle(aFontStyle, fsStrikeout);
  Write(aText);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenParagraph;
begin
  CloseText;
  ClearTextState;
  WriteLn;
  WriteIndent;
  Write('<P>')
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseParagraph;
begin
  CloseText;
  Write('</P>')
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteOpenTree ;
begin
  CloseText;
  Writeln;
  WriteIndent;
  Write('<TREE>');
  Indent;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteCloseTree;
begin
  CloseText;
  RevIndent;
  WriteLn;
  WriteIndent;
  WriteLn('</TREE>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriterOpenTreeItem;
begin
  Writeln;
  Writeindent;
  Write('<ITEM>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriterCloseTreeItem;
begin
  CloseText;
  Writeln;
  WriteIndent;
  Write('</ITEM>');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLWriter.WriteEmbdControl(const aControlClass, aControlName : string;
  aHeight, aWidth : integer);
var
  S : String;
begin
  if aControlClass = '' then Exit;
  S := '<CONTROL';
  S := S + ' VCLCLASS='+aControlClass;
  if aControlName <> '' then
    S := S + ' NAME='+aControlName;
  if aWidth <> 0 then
    S := S + ' WIDTH='+IntToStr(aWidth);
  if aHeight <> 0 then
    S := S + ' HEIGHT='+IntToStr(aHeight);
  S := S + '>' ;
  Write(S);
end;

procedure TLMDHTMLWriter.WriteDocumentEnd;
begin
  CloseText;
  RevIndent;
  WriteLn;
  WriteIndent;
  WriteLn('</BODY>');
  RevIndent;
  WriteIndent;
  WriteLn('</HTML>');
end;

procedure TLMDHTMLWriter.WriteDocumentStart;
begin
  CloseText;
  Writeln;
  WriteIndent;
  Write('<HTML>');
  Indent;
  Writeln;
  WriteIndent;
  Write('<BODY>');
  Indent;
  Writeln;
end;

initialization
  RegisterWriter(TLMDHTMLWriter, ['HTML', 'HTM'], false);
end.
