unit wwexport;
{
//
// Components : TwwExportOptions
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// Revisions:
// 5/18/2001 - PYW - Should check grid's options to see if dgShowFooter in Options as well.
// 6/3/2001 - PYW - Strip Trailing Spaces for HTML files.
// 12/12/2001 - PYW - change HTML tag &nbsp to &nbsp;
// 2/1/2002 - PYW - Added code to handle special controls in grid.
// 2/15/2002 - PYW - Changed Exporting of HTML so Outlook Express and other programs can paste after saving to the clipboard.
//                   Set new property UseOldClipboardSaving to True for old behavior.
// 2/15/2002-PYW-Need to add space for footer cell if recordno is visible.
// 3/13/2002-PYW-Add new property to allow use of A1 reference in Excel vs R1C1.
// 3/13/2002-PYW-Make sure the SYLK format is stored with decimals.  Important for Intl settings.
}
{
NOTES:
1) Need to add Option to not Replace #13#10 with <br> for html in TMemoFields or TRichEdits or String?
   Currently it is doing so blindly.
2) Events to Add:
   OnAddHTMLTag : Need to add formatting event
              (Pass if this is a summary, title, datacell or datarow) Return string to add.
   OnExportHTMLText : Pass string to display, fieldname, and get changed text.
3) Summary Title and Footer info not showing in certain export types.
4) Should we support grid's bidi mode (RTL or LTF?) with other formats besides HTML?
5) Need to call GroupEvents for custom group coloring and font settings.
6) Need to handle special html characters that are used in text.  Probably provide option for
   replacing at the cell level as in some cases it is nice to insert HTML text into HTML cells.
      '<' -> '&lt;';
      '>' -> '&gt;';
   Or allow the end-user to change this with the event above.
}

interface
{$R-,T-,H+,X+}
  uses windows, classes, forms, graphics, SysUtils, controls;

  type
  //wwgetXML not implemented yet.
  TwwGridExportType = (wwgetTxt, wwgetHTML, wwgetSYLK, wwgetXML);
  //esoShowFooter not implemented yet.
  TwwExportSaveOption = (esoShowHeader, esoShowFooter, esoDynamicColors, esoShowTitle,
                         esoDblQuoteFields, esoSaveSelectedOnly, esoAddControls, esoBestColFit,
                         esoShowRecordNo, esoEmbedURL, esoShowAlternating, esoTransparentGrid, esoClipboard);
  TwwExportSaveOptions = set of TwwExportSaveOption;

  TwwExportOptions = class(TPersistent)
  private
     FFileName: string;
     FExportType: TwwGridExportType;
     FDelimiter: string;
     FOptions : TwwExportSaveOptions;
     FTitleName: string;
     FOutputWidthinTwips: integer;
     FHTMLBorderWidth : integer;
     FUseOldClipboardSaving : boolean;
     FUseA1SYLKReference : boolean; // 3/13/2002-PYW-Add new property to allow use of A1 reference in Excel vs R1C1.
     function GetFileName : string;
     procedure SetFileName(val: string);
     function GetDelimiter : string;
     procedure SetDelimiter(val: string);
     function IsDelimiterStored: boolean;
  protected
     function AddQuotes(s:string):string; virtual;
     Function XRecNoOffset: integer;
     Function QuotesPad: integer;
  public
     Owner: TComponent;
     procedure Save; virtual;
  //   procedure SaveToClipboard; virtual;
     procedure ExportToStream(fs:TStream);
     constructor Create(AOwner: TComponent); virtual;
     property UseOldClipboardSaving: boolean read FUseOldClipboardSaving write FUseOldClipboardSaving default False;
     property UseA1SYLKReference: boolean read FUseA1SYLKReference write FUseA1SYLKReference default False;
  published
     property Delimiter: string read GetDelimiter write SetDelimiter stored IsDelimiterStored;
     property ExportType: TwwGridExportType read FExportType write FExportType default wwgetTxt;
     property FileName: string read GetFileName write SetFileName;
     property HTMLBorderWidth : integer read FHTMLBorderWidth write FHTMLBorderWidth default 1;
     property Options : TwwexportSaveOptions read FOptions write FOptions default [esoShowHeader, esoShowTitle, esoDblQuoteFields, esoShowAlternating];
     property OutputWidthinTwips : integer read FOutputWidthinTwips write FOutputWidthinTwips default 0;
     property TitleName : string read FTitleName write FTitleName;
  end;

implementation

uses wwstr, db, wwDBComb, wwRadioGroup, wwCheckbox, wwDBGrid, wwDBiGrd, wwcommon, wwmemo, Dialogs, clipbrd;

const wwCRLF = #13#10;

//dbcol not public so calculate grid data column.
function getdbcol(Grid:TwwDBGrid; col:integer):integer;
begin
   result:= col;
   if wwdbigrd.dgIndicator in Grid.Options then result:= col - 1;
end;

Function ReplaceStrWithStr(str: string; removestr: string;replaceStr: string): string;
var i: integer;
begin
   Result := '';
   i:=1;
   while i<=length(str) do begin
      if (strlcomp(PChar(Copy(str,i,length(removestr))), PChar(removestr),
          length(removestr))<>0) then
      begin
         Result := Result + str[i];
         i:=i+1;
      end
      else begin
        Result:= Result + replaceStr;
        i:=i+length(removeStr);
      end;
   end;
end;

{*************************
 * HTML string functions *
 *************************}

//Get Color String in Hex Format for HTML Colors
function ColorToHexString(aColor:TColor):String;
var dummy,R,G,B:Byte;
  procedure ColorToByteValues(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
    var WinColor: COLORREF;
  begin
    WinColor := ColorToRGB(AColor);
    Reserved := ($FF000000 and WinColor) Shr 24;
    Blue := ($00FF0000 and WinColor) Shr 16;
    Green := ($0000FF00 and WinColor) Shr 8;
    Red := ($000000FF and WinColor);
  end;
begin
  ColorToByteValues(aColor,dummy,R,G,B);
  result := Format('%2.2x%2.2x%2.2x',[B,G,R]);
end;

//Set HTML Background Color.
function SetBkGrndColor(aColor:TColor):string;
begin
   result := 'BGCOLOR=#'+ColorToHexString(AColor);
end;

//Get HTML Alignment string.
function getalignstr(value:TAlignment):string;
begin
  result := '';
  case value of
    taCenter:result := 'center';
    taLeftJustify:result := 'left';
    tarightJustify:result := 'right';
  end;
end;

//Place Font Style Format HTML tag/identifiers around passed in string.
function SetFormatStyle(const s:string;aFont:TFont):string;
begin
   result := s;
   if fsItalic in aFont.Style then
      result := '<I>'+result+'</I>';
   if fsBold in aFont.Style then
      result := '<B>'+result+'</B>';
   if fsUnderline in aFont.Style then
      result := '<U>'+result+'</U>';
   if fsStrikeOut in aFont.Style then
      result := '<STRIKE>'+result+'</STRIKE>';
end;

//Build HTML Inline Style string based on Font properties.  Leave out Style as it is
//handled by SetFormatStyle.
function SetFontstr(aFont:TFont):string;
begin
   result := 'STYLE="font-family: ' + aFont.Name+ ';'+
             'font-size: ' + IntToStr(aFont.Size) +' pt;'+
             'color:#'+ ColorToHexString(aFont.Color)+';'+
             '"';
end;

function SwapHTMLSymbols(const s: string): string;
var
  i: Integer;
  ch: Char;
  replacestr: string;
begin
  Result := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    case ch of
      '<': replacestr := '&lt;';
      '>': replacestr := '&gt;';
    else
      replacestr := ch
    end;
    Result := Result + replacestr
  end
end;

{*******************************
 * SYLK/Excel string functions *
 *******************************}

function GetSYLKAlignment(value:TAlignment):string;
begin
   result := '';
   case value of
      taleftjustify:result := 'L';
      tarightjustify:result := 'R';
      taCenter: result := 'C';
   end;
end;

//This function adds the given font to the FontList if it is a unique font for the
//given style properties.  It will return the Font Count Number as this is used when
//building the tags for the SYLK format.
function AddToSYLKFontList(aFont:TFont;fontlist:TStrings):string;
var fontstr:string;
    boldflag:boolean;
    italicflag:boolean;
    underlineflag:boolean;
    fontcount:integer;
begin
   result := '';
   if fontlist = nil then fontlist := TStringList.Create;
   boldflag := false;
   italicflag := false;
   underlineflag:=false;
   Fontstr := 'P;F'+aFont.Name+';M'+inttostr(aFont.Size*20);
   if fsBold in aFont.style then begin
     Fontstr := Fontstr+';SB';
     boldflag := True;
   end;
   if fsItalic in aFont.Style then begin
     if boldflag then Fontstr := Fontstr + 'I'
     else Fontstr := Fontstr+';SI';
     italicflag := True;
   end;
   if fsUnderline in aFont.Style then begin
     if (not boldflag) and (not italicflag) then
        Fontstr := Fontstr+';SU'
     else Fontstr := Fontstr + 'U';
     underlineflag := True;
   end;
   if fsStrikeOut in aFont.Style then begin
     if (not boldflag) and (not italicflag) and (not underlineflag) then
        Fontstr := Fontstr+';SS'
     else Fontstr := Fontstr + 'U';
   end;
   if (FontList.IndexOfName(fontstr)>-1) then
   begin
      result := FontList.Values[fontstr];
      exit;
   end;
   fontcount := FontList.Count;
   FontList.Add(Fontstr+'='+inttostr(fontcount));
   result := inttostr(fontcount);
end;

{********************
 * TwwExportOptions *
 ********************}
constructor TwwExportOptions.Create(AOwner: TComponent);
begin
   inherited Create;
   FileName := '';
   FOptions := [esoShowHeader,esoShowTitle,esoDblQuoteFields,esoShowAlternating];
   FExportType:=wwgetTxt;
   FDelimiter := ',';
   FOutputWidthinTwips := 0;
   FHTMLBorderWidth := 1;
   FUseA1SYLKReference := False;
   Owner := AOwner;
end;

function TwwExportOptions.AddQuotes(s:string):string;
begin
  if (esoDblQuoteFields in Options) then
  begin
    if (s<>'') or
       ((FDelimiter ='') and (exporttype = wwgetTxt) and (s='')) then
       result := '"'+s+'"'
    else result := s;
  end
  else result := s;
end;

function TwwExportOptions.GetDelimiter:String;
begin
   result := FDelimiter;
end;

procedure TwwExportOptions.SetDelimiter(val:String);
begin
   if val <> FDelimiter then begin
      {if val = '' then FDelimiter := #9
      else}
      FDelimiter := val;
   end;
end;

function TwwExportOptions.GetFileName:String;
begin
   if FFileName = '' then begin
      result := '';//wwInternational.ExportFileName;
      if (result = '') and not (csDesigning in Owner.ComponentState) then
         result := wwExtractFileNameOnly(Application.ExeName)+'.txt'
   end
   else result := FFileName;
end;

procedure TwwExportOptions.SetFileName(val:String);
begin
   if val <> FFileName then begin
      FFileName:= val;
   end;
end;

Function TwwExportOptions.XRecNoOffset: integer;
begin
   if esoShowRecordNo in FOptions then result:= 1
   else result:= 0;
end;

Function TwwExportOptions.QuotesPad: integer;
begin
  if esoDblQuoteFields in FOptions then result := 2 else result := 0;
end;

type TwwCheatCustomDBGrid = class (TwwCustomDBGrid);
procedure TwwExportOptions.ExportToStream(fs:TStream);
var i:integer;
    accept : boolean;
    startpos:integer;
    recordstr,fontlist:string;
    grid:TwwDBGrid;
    currowcount:integer;

    totalstr:string;
    SYLKFontList:TStrings;
    exportFieldList: TStringList;
    TotalPixelCount:Integer;
    SYLKFormatIndex:TStringList;

    function WriteHTMLHeader:string;
    var i,j,k,startcol,endcol:integer;
        rowstr,tempfontstr:string;
        gridfont:TFont;
        gridbrush:TBrush;
        gridTitleAlignment:TAlignment;
        groupassigned:boolean;
        groupcolcount:integer;
        footerrect:TRect;
        footerstring:string;
    begin
      with Grid do begin

        rowstr:='<HTML>'+wwCRLF+
                '<HEAD>'+wwCRLF;
        rowstr := rowstr + '<TITLE>'+FileName+'</TITLE>'+wwCRLF;
        rowstr := rowstr +{'<meta http-equiv=content-style-type content=text/css>'+wwCRLF+}
                '</HEAD>'+wwCRLF;
        rowstr:=rowstr+'<BODY>'+wwCRLF;

        {Rules = groups or rows or cols for dgrowlines and dgcolumnlines and borderstyle support}
        rowstr:=rowstr+
          '<TABLE ALIGN=Center BORDER="'+inttostr(HTMLBorderWidth)+'" CELLPADDING="1" CELLSPACING="0"';
        //Set Table's Bidi mode.  Not may want to move this to the <HTML> Tag.
        if BiDiMode = bdLeftToRight then
           rowstr := rowstr + ' dir="LTR"'
        else {if BiDiMode = bdRightToLeft then}
           rowstr := rowstr + ' dir="RTL"';

        if (esoTransparentGrid in self.Options) then rowstr := rowstr+'>'
        else rowstr := rowstr+' '+SetBkGrndColor(Color)+'>';

        rowstr := rowstr +wwCRLF+'<THEAD>'+wwCRLF;

        //Display Title.
        //7/26/2001-PYW-Handle Header
        if (esoShowHeader in self.options) and (esoShowTitle in self.Options) then begin
          rowstr:=rowstr+
          '<TR '+SetFontStr(TitleFont)+' '+SetBkGrndColor(TitleColor)+'>'+wwcrlf+
          '<TH colspan="'+IntToStr(exportFieldList.count+XRecNoOffset)+'" scope="colgroup">'+TitleName+'</TH>'+wwcrlf+
          '</TR>'+wwCRLF;
        end;

        //Now Do Titles and Group Children
        j:=0;
        groupassigned := False;
        // Loop Twice.  Once for normal titles and the Group Header if there is one and once for the group children.
        //7/26/2001-PYW-Handle Header
        if (esoShowHeader in self.options) then
        while j<2 do begin
          i:=0;
          //Set Title's Font Properties
          rowstr:=rowstr+'<TR '+SetFontStr(TitleFont)+' ALIGN='+getalignstr(TitleAlignment)+'>'+wwCRLF;

          // If this is the RecordNo title then make sure it spans two rows.  Only do this the first time.
          if (j=0) and (esoShowRecordNo in self.Options) then begin
             rowstr := rowstr + '<TD ALIGN="CENTER" '+ SetFontStr(TitleFont)+ ' SCOPE="col" bgcolor=#'+ ColorToHexString(TitleColor);
             rowstr := rowstr + ' RowSpan="2">';
             rowstr := rowstr + SetFormatStyle('#',TitleFont)+'</TD>'+wwCRLF;
          end;

          // Now iterate through the fields.
          while (i <= ExportFieldList.Count-1) do begin
              if (exportFieldList[i] = 'F') then begin
                inc(i); continue;
              end;
              //Initialize default grid font, brush and titlealignment settings.
              gridFont := Grid.Canvas.Font;
              gridFont.assign(TitleFont);
              gridBrush := Grid.Canvas.Brush;
              GridBrush.Color:=TitleColor;
              gridTitleALignment:=TitleAlignment;

              // Call Grid's TitleCellColoring routine to see if titles should be painted a special color.
              if esoDynamicColors in self.Options then
                 DoCalcTitleAttributes(DataLink.Fields[i].FieldName, gridFont, gridBrush, gridTitleAlignment);

              tempfontstr := '';
              if (gridfont.Name <> TitleFont.Name) or (GridFont.Size <> TitleFont.Size) or
                 (gridfont.Color <> TitleFont.color) then
                 tempfontstr := ' '+SetFontStr(GridFont);

              //                if (exportFieldList[i] = 'T') then begin
              if (j>0) or (Columns[getdbcol(Grid,i+xIndicatorOffset)].GroupName = '') then begin
                 if (exportFieldList[i] = 'T') then begin
                    if j=0 then begin
                       rowstr := rowstr + '<TD'+ tempfontstr + ' ALIGN="'+getalignstr(GridTitleAlignment)+
                                    '" SCOPE="col" bgcolor=#'+ ColorToHexString(GridBrush.Color);
                       rowstr := rowstr + ' RowSpan="2">';
                       rowstr := rowstr + SetFormatStyle(strReplaceCharWithStr(Columns[getdbcol(Grid,i+xIndicatorOffset)].DisplayLabel,'~','<BR>'),GridFont)+
                                    '</TD>'+wwCRLF;
                    end
                    else if (Columns[getdbcol(Grid,i+xIndicatorOffset)].GroupName <> '') then begin
                       rowstr := rowstr + '<TD'+ tempfontstr+ ' ALIGN="'+getalignstr(GridTitleAlignment)+
                                    '" SCOPE="col" bgcolor=#'+ ColorToHexString(GridBrush.Color);
                       rowstr := rowstr + ' >';
                       rowstr := rowstr + SetFormatStyle(strReplaceCharWithStr(Columns[getdbcol(Grid,i+xIndicatorOffset)].DisplayLabel,'~','<BR>'),GridFont)+
                                    '</TD>'+wwCRLF;
                    end
                 end;
                 inc(i);
              end
              else begin
                 GroupNameCellRect(i+xIndicatorOffset,0,startcol,endcol,false);
                 groupColCount := 0;
                 for k:=startcol to endcol do begin
                    if exportFieldList[k-1] = 'T' then
                       inc(groupColcount);
                 end;
                 if groupcolCount > 0 then begin
                   rowstr := rowstr + '<TD'+ tempfontstr+
                                ' SCOPE="col" bgcolor=#'+ ColorToHexString(GridBrush.Color);
                   rowstr := rowstr + ' ALIGN=CENTER ColSpan="'+inttostr(groupcolcount)+
                                '">'+SetFormatStyle(Columns[getdbcol(Grid,i+xIndicatorOffset)].GroupName,GridFont)+
                                '</TD>'+wwCRLF;
                   groupassigned := True;
                 end;
                 inc(i,endcol-startcol+1);
              end;
          end;
          inc(j);
          rowstr:=rowstr+'</TR>'+wwCRLF;
          //If No Groups then we are done.  Otherwise, we need to still process the children.
          if not groupassigned then break;
        end; //End While j<2
        // 9/26/2001-If only one row then pad with additional Row because of rowspan. - PYW
        if j = 1 then rowstr := rowstr+'<TR></TR>'+wwCRLF;
        rowstr:=rowstr+'</THEAD>'+wwCRLF;

        //NOW INSERT FOOTER CODE HERE.
        //5/18/2001 - PYW - Should check grid's options to see if dgShowFooter in Options as well.
        if (esoShowFooter in self.Options) and (dgShowFooter in Grid.Options) then begin
            rowstr := rowstr+'<TFOOT '+SetFontStr(TitleFont)+' '+SetBkGrndColor(FooterColor)+'>'+wwCRLF;
//            rowstr := rowstr+'<TH>'+wwCRLF;  //10/01/2001-Remove this as it messes up footer.
            //2/15/2002-PYW-Need to add space for footer cell if recordno is visible.
            if (esoShowRecordNo in self.Options) then
               rowstr := rowstr+'<TD>&nbsp;</TD>'+wwCRLF;
            for i:=0 to ExportFieldList.Count-1 do begin
                                               //10/01/2001-Only print footers for exported cells.
                if (exportFieldList[i] = 'F') then continue;
                FooterRect:= CellRect(i+xindicatoroffset, 0);
                footerstring := Columns[getdbcol(Grid,i+xIndicatorOffset)].FooterValue;
             //   DoDrawFooterCell(Grid.Canvas,footerRect,Datalink.Fields[i],footerstring,footerdraw);
                if footerstring <> '' then begin
                  rowstr := rowstr+'<TD ALIGN='+getalignstr(DataLink.Fields[i].Alignment)+' '+SetFontStr(Font)+' '+SetBkGrndColor(FooterCellColor)+'>'+footerstring+'</TD>'+wwCRLF;
                end
                else begin
                  rowstr := rowstr+'<TD>&nbsp;</TD>'+wwCRLF;
                end;
            end;
//            rowstr := rowstr+'</TH>'+wwCRLF; //10/01/2001-Remove this as it messes up footer.
            rowstr := rowstr + '</TFOOT>'+wwCRLF;
        end;

        rowstr:=rowstr+'<TBODY>'+wwCRLF;
      end;
      result := rowstr;
    end;

    function WriteHTMLDataRow:string;
    var i,j,pos1,pos2,pos3:integer;
        AControlType, Parameters: wwSmallString;
        checkstr,uncheckstr:string;
        Rowstr,LinkAddress,tempstr:String;
        xfactor:extended;
        gridfont:TFont;
        gridbrush:TBrush;
        URLDisplay,controlname,combostr,radiostr,displaystr:string;
        customedit:TWinControl;
    begin
      with Grid do begin
        RowStr:='<TR VALIGN="TOP" '+SetFontStr(Font)+'>'+wwCRLF;
        if esoShowRecordNo in self.Options then
           RowStr:=RowStr+'<TD WIDTH="0*" NOWRAP ALIGN="right" scope="row" '+SetFontStr(TitleFont)+' '+SetBkgrndColor(TitleColor)+'>'+
              IntToStr(curRowCount)+'</TD>'+wwCRLF;
        for i:=0 to exportFieldList.Count-1 do begin
           if (exportFieldList[i] = 'F') then continue;
           GetControlInfo(Datalink.Fields[i].FieldName, AControlType, Parameters);
//           tempstr := GetFieldValue(i);
           tempstr := TrimRight(GetFieldValue(i));  //6/3/2001-PYW-Strip Trailing Spaces.
           if (esoAddControls in self.Options) then begin
              if (AControlType = 'CheckBox') then begin
                 isCheckBox(i+xIndicatorOffset, 1, checkstr, uncheckstr);
                 if tempstr = checkstr then
                    tempstr:='<input align="middle" type="checkbox" checked >'
                 else
                    tempstr:='<INPUT ALIGN="middle" TYPE="checkbox" >';
              end
              else if (AControlType = 'CustomEdit') then begin
                 Pos1:= 1;
                 controlname:= strGetToken(Parameters, ';', Pos1);
                 customEdit:= GetComponent(controlname);
                 if customEdit is TwwRadioGroup then begin
                     with TwwRadioGroup(customedit) do begin
                       radiostr :='';
                       for j:= 0 to Items.count-1 do begin
                          radiostr := radiostr+'<input align="middle" type="radio" value="'+GetButtonValue(j)+'" name="radio'+inttostr(currowcount)+'"';
                          //7/26/2001 - PYW - Need to compare the display value and not stored value.
                          if AnsiCompareText(tempstr,GetDisplayValue(GetButtonValue(j)))=0 then
                              radiostr := radiostr +' checked';
                          radiostr := radiostr+'>'+items[j]+'<BR>'+wwCRLF;
                       end;
                       tempstr := radiostr;
                     end;
                 end
                 else if customedit is TwwCheckbox then
                 begin
                   with TwwCheckbox(customedit) do begin
                     if AnsiCompareText(tempstr,ValueChecked)=0 then
                        tempstr:='<input align="middle" type="checkbox" checked >'
                     else
                        tempstr:='<INPUT ALIGN="middle" TYPE="checkbox" >';
                   end;
                 end
                 else if customedit is TwwDBComboBox then begin
                    with Twwdbcombobox(customedit) do begin
                       combostr :='<Select Name="wwCombo'+inttostr(currowcount)+'">'+wwCRLF;
                       for j:= 0 to Items.count-1 do begin
                          if MapList then begin
                             Pos1 := 1;
                             displaystr := strGetToken(Items[j],#9,Pos1);
                             combostr := combostr+'<Option Value="'+strGetToken(Items[j],#9,Pos1)+'"';
                             if AnsiCompareText(tempstr,displaystr)=0 then
                                combostr := combostr +' selected';
                             combostr := combostr +'>'+DisplayStr+wwCRLF;
                          end
                          else begin
                             combostr := combostr+'<Option Value="'+Items[j]+'"';
                             if AnsiCompareText(tempstr,Items[j])=0 then
                                combostr := combostr +' selected';
                             combostr := combostr +'>'+Items[j]+wwCRLF;
                          end;
                       end;
                       combostr := combostr + '</Select>'+wwCRLF;
                       tempstr := combostr;
                    end;
                 end
                 else begin
                    if tempstr = '' then tempstr := '&nbsp;';
                 end;
              end
              else if tempstr = '' then tempstr := '&nbsp;';
           end
           else begin
              if tempstr = '' then tempstr := '&nbsp;';
           end;

           if (AControlType = 'URL-Link') and (esoEmbedURL in self.Options) then begin
             GetURLLink(Datalink.Fields[i].asString,URLDisplay, LinkAddress);

             if AnsiCompareText(URLDisplay,LinkAddress)=0 then begin
                 //Add MailTo: tag to link string for links that are in an email format.
                 pos1:= AnsiPos('@', LinkAddress);
                 pos2:= AnsiPos('.', LinkAddress);
                 pos3:= AnsiPos('MAILTO:',AnsiUpperCase(LinkAddress));
                 if (pos1>1) and (pos2>pos1) and (pos3 <=0) then
                    LinkAddress:= 'MailTo:' + LinkAddress;

{                 pos1:= AnsiPos('HTTP:',AnsiUpperCase(LinkAddress));
                 pos3:= AnsiPos('MAILTO:',AnsiUpperCase(LinkAddress));
                 if (pos1 < 1) and (pos3 <1) then
                    LinkAddress:= 'http://' + LinkAddress;}
             end;

             tempstr := '<A href="'+LinkAddress+'">'+tempstr+'</A>';
           end;

           tempstr := ReplaceStrWithStr(tempstr,#13#10,'<BR>');
           RowStr := RowStr + '<TD NOWRAP';

           //Don't set alignment if this is a Checkbox.
           if AControlType<>'CheckBox' then
              RowStr := RowStr + ' ALIGN="'+getalignstr(DataLink.Fields[i].Alignment)+'"';

           gridFont := Grid.Canvas.Font;
           gridFont.assign(Font);
           gridBrush := Grid.Canvas.Brush;
           GridBrush.Color:=Color;

           if esoShowAlternating in self.options then begin
             if not odd(currowcount mod 2) then
                GridBrush.Color := PaintOptions.AlternatingRowColor;
           end;

           if esoDynamicColors in self.Options then
              Grid.DoCalcCellColors(DataLink.Fields[i], [], False, gridFont, gridBrush);

           if (gridfont.Name <> Font.Name) or (GridFont.Size <> Font.Size) or
              (gridfont.Color <> Font.color) then
              RowStr := RowStr + ' '+SetFontStr(GridFont);

           if GridBrush.Color <> Color then
              RowStr := RowStr + ' '+SetBkgrndColor(GridBrush.Color);

           // Conversion Factor for desired display in Twips (1440 Twips = 1 Inch)
           if OutputWidthinTwips = 0 then
              xfactor := 1.0
           else xfactor := OutputWidthinTwips/((TotalPixelCount/Screen.PixelsPerInch)*1440.0);

           if esoBestColFit in self.Options then begin
               if ((AControlType = 'RichEdit') or ((DataLink.Fields[i] is TMemoField) and (mGridShow in MemoAttributes))) then
                  RowStr := RowStr + ' WIDTH="'+inttostr(Trunc(ColWidthsPixels[i+xIndicatorOffset]))+'" SCOPE="row">'+SetFormatStyle(tempstr,gridfont)+'</TD>'+wwCRLF
               else RowStr := RowStr + ' WIDTH="0*" SCOPE="row">'+SetFormatStyle(tempstr,gridfont)+'</TD>'+wwCRLF;
           end
           else RowStr := RowStr + ' WIDTH="'+inttostr(Trunc(ColWidthsPixels[i+xIndicatorOffset]*xfactor))+'" SCOPE="row">'+SetFormatStyle(tempstr,gridfont)+'</TD>'+wwCRLF;
        end;
        RowStr := RowStr + '</TR>'+wwCRLF;
        result := RowStr;
      end;
    end;

    function WriteTextDataRow:String;
    var i:integer;
        colwidth:integer;
        RowStr:String;
    begin
      with Grid do begin
        if esoShowRecordNo in self.Options then begin
          if FDelimiter = '' then
             rowstr := Format('%*s%s',[8,AddQuotes(intToStr(curRowCount)),' '])
          else rowstr := AddQuotes(IntToStr(curRowCount))+FDelimiter;
        end
        else rowstr := '';
        for i:=0 to exportFieldList.Count-1 do begin
          if (exportFieldList[i] = 'T') then begin
            if FDelimiter = '' then begin
               colwidth :=  Columns[getdbcol(Grid,I+xIndicatorOffset)].DisplayWidth+QuotesPad;
               colwidth := wwmax(Length(Columns[getdbcol(Grid,I+xIndicatorOffset)].DisplayLabel)+QuotesPad,colwidth);
               if Datalink.Fields[i].Alignment = taLeftJustify then
                   rowstr := rowstr + Format('%-*s',[colwidth,AddQuotes(GetFieldValue(i))])
               else rowstr := rowstr + Format('%*s',[colwidth,AddQuotes(GetFieldValue(i))]);
               if i <> exportFieldList.Count-1 then rowstr := rowstr + ' ';
            end
            else begin
               rowstr := rowstr + AddQuotes(GetFieldValue(i));
               if i <> exportFieldList.Count-1 then rowstr := rowstr + FDelimiter;
            end;
          end;
        end;
        rowstr := rowstr+wwCRLF;
        result := rowstr;
      end;
    end;

    function WriteTextHeader:string;
    var rowstr:string;
        i:integer;
    begin
       with Grid do begin
         if esoShowRecordNo in self.Options then begin
            if FDelimiter = '' then rowstr := Format('%*s%s',[8,'#',' '])
            else rowstr := AddQuotes('#')+FDelimiter;
         end
         else
            rowstr := '';

         for i:= 0 to exportFieldList.count - 1 do begin
            if (exportFieldList[i] = 'T') then begin
               if FDelimiter = '' then begin
                 if Datalink.Fields[i].Alignment = taLeftJustify then
                     rowstr := rowstr + Format('%-*s',[Columns[getdbcol(Grid,I+xIndicatorOffset)].DisplayWidth+QuotesPad,
                               AddQuotes(strReplaceCharWithStr(Columns[getdbcol(Grid,i+xIndicatorOffset)].DisplayLabel,'~',' '))])
                 else rowstr := rowstr + Format('%*s',[Columns[getdbcol(Grid,I+xIndicatorOffset)].DisplayWidth+QuotesPad,
                               AddQuotes(strReplaceCharWithStr(Columns[getdbcol(Grid,i+xIndicatorOffset)].DisplayLabel,'~',' '))]);
                 if i <> exportFieldList.Count-1 then rowstr := rowstr + ' ';
               end
               else begin
                  rowstr := rowstr + AddQuotes(strReplaceCharWithStr(Columns[getdbcol(Grid,i+xIndicatorOffset)].DisplayLabel,'~',' '));
                  if i <> exportFieldList.Count-1 then rowstr := rowstr + FDelimiter;
               end
            end;
         end;
         rowstr := rowstr + wwCRLF;
         result := rowstr;
       end;
    end;

    Function getdisplaylabelforline(lbl: string;lineno:integer): string;
    var APos, curlineno: integer;
        line: string;
    begin
       APos:= 1;
       result := '';
       if lineno = 0 then exit;
       curlineno := 1;
       while True do begin
          line:= strGetToken(lbl, '~', APos);
          if curlineno = lineno then begin
             result := line;
             exit;
          end;
          if (line='') and ((APos<=0) or (APos>=length(line))) then break;
          inc(curlineno);
       end;
    end;

    function WriteSYLKHeader:string;
    var Rowstr:string;
        i,j,k,count,startcol,endcol:integer;
        groupcolcount:integer;
//        groupassigned :boolean;
        recoffset : integer;
        fonttag,formatstr:string;
        gridfont:TFont;
        gridbrush:TBrush;
        gridTitleAlignment:TAlignment;
        SYLKFormatList:TStrings;
        tempdisplaylabel:string;
        exportfieldcount:integer; // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
    begin
       SYLKFontList:=TStringList.Create;
       SYLKFormatList := TStringList.Create;
       //Add Grid TitleFont
       gridFont := Grid.Canvas.Font;
       gridFont.assign(TwwDBGrid(Grid).TitleFont);
       AddToSYLKFontList(gridFont,SYLKFontList);
       //Add GridFont
       gridFont := Grid.Canvas.Font;
       gridFont.assign(TwwDBGrid(Grid).Font);
       AddToSYLKFontList(gridFont,SYLKFontList);

       //Set Identifier and Program name
       rowstr := 'ID;P'+'W2W 3000'+';N;E'+wwCRLF;
       // 9/26/2001-Add general format strings for date/time/datetime and currency to header. - PYW
       SYLKFormatList.Add('General');
       count:=1;
       // 9/26/2001-Build list of unique formats and store appropriate index into list for field export.
       for i:= 0 to exportFieldList.Count-1 do begin
          case Grid.Datalink.Fields[i].datatype of
           ftDate: formatstr:='m/d/yyyy';
           ftTime: formatstr:='h:mm\ AM/PM';
           ftDateTime, ftTimeStamp: formatstr:='m/d/yyyy\ h:mm\ AM/PM';
           ftCurrency: formatstr:='"'+'$'+'"'+'#,##0.00_);;[Red]\('+'"'+'$'+'"'+'#,##0.00\)';
           else
              formatstr := 'General';
          end;
          Grid.DoExportSYLKFormat(grid,Grid.Datalink.Fields[i],formatstr);
          if SYLKFormatList.IndexOf(formatstr) < 0 then begin
             SYLKFormatList.Add(formatstr);
             SYLKFormatIndex[i] := inttostr(Count);
             inc(Count);
          end
          else SYLKFormatIndex[i] := IntToStr(SYLKFormatList.IndexOf(formatstr));
       end;

       // Place formatlist into header.
       for i:=0 to SYLKFormatList.count-1 do
          rowstr := rowstr+'P;P'+SYLKFormatList[i]+wwCRLF;

       SYLKFormatList.Free;

       //Set dimensions.
       //NOTE: Don't know rowcount yet so leave blank.
       if esoShowRecordNo in self.options then
          rowstr := rowstr+'B;Y'+';X'+inttostr(exportfieldList.count+1)+wwCRLF
       else  rowstr := rowstr+'B;Y'+';X'+inttostr(exportfieldList.count)+wwCRLF;

       // 3/13/2002-PYW-Add new property to allow use of A1 reference in Excel vs R1C1.
       if UseA1SYLKReference then rowstr := rowstr+'O;L'+wwCRLF;

       //Turn off grid lines in excel.
       rowstr := rowstr+ 'F;G;M255'+wwCRLF;

       count := 0;
       recoffset := 0;
       //Fill Widths of each column
       if (esoShowRecordNo in Options) then begin
          rowstr := rowstr+'F;W1 1 10'+wwCRLF;
          recoffset := 1;
          inc(count);
       end;

       for i:= 0 to exportFieldList.Count-1 do begin
          if (exportFieldList[i] = 'T') then begin
             inc(count);
             if esoBestColFit in self.Options then
                rowstr := rowstr+'F;W'+inttostr(count)+' '+inttostr(count)+' '+inttostr(grid.DataLink.Fields[i].DisplayWidth)+wwCRLF
             else rowstr := rowstr+'F;W'+inttostr(count)+' '+inttostr(count)+' '+inttostr(Grid.Columns[getdbcol(Grid,I+grid.xIndicatorOffset)].DisplayWidth)+wwCRLF;
          end;
       end;

//       groupassigned := False;
       if esoShowHeader in Options then begin
         for j:= 0 to grid.titlelines-1 do begin
           i:=0; //Start back at the first field.
           exportfieldcount:=recoffset;
           if (esoShowRecordNo in Options) then begin
              if (j=0) then begin
                 rowstr := rowstr+'F;SLRTM0;FG0C;Y1;X1'+wwCRLF;
                 rowstr := rowstr+'C;K"#"'+wwCRLF;
              end
              else begin
                 rowstr := rowstr+'F;SLRBM0;FG0C;Y'+inttostr(j+1)+';X1'+wwCRLF;
              end;
           end;
           while i < exportFieldList.Count do begin
               if (exportFieldList[i] = 'F') then begin
                  inc(i);
                  continue;
               end;
                 //If we are on a subgroup or a nongroup title cell
                 if (j>0) or (grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].GroupName = '') then begin
                    if (exportFieldList[i] = 'T') then begin
                      gridFont := Grid.Canvas.Font;
                      gridFont.assign(TwwDBGrid(Grid).TitleFont);
                      gridBrush := Grid.Canvas.Brush;
                      GridBrush.Color:=TwwDBGrid(Grid).TitleColor;
                      gridTitleALignment:=Grid.TitleAlignment;

                      if esoDynamicColors in self.Options then
                         Grid.DoCalcTitleAttributes(Grid.DataLink.Fields[i].FieldName, gridFont, gridBrush, gridTitleAlignment);

                      fonttag := AddToSYLKFontList(gridFont,SYLKFontList);

                      if (grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].GroupName = '') then begin
                            tempdisplaylabel := strReplaceCharWithStr(grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].DisplayLabel,';',';;');
                            tempdisplaylabel := getdisplaylabelforline(tempdisplaylabel,j+1);
                            rowstr := rowstr+'F;SLR';
                            if j=0 then rowstr := rowstr+'T';
                            if (j=Grid.TitleLines-1) then rowstr := rowstr+'B';
                            // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
                            rowstr := rowstr+'M'+fonttag+';FG0'+GetSYLKAlignment(gridTitleALignment)+';Y'+inttostr(j+1)+';X'+Inttostr(exportfieldcount+1)+wwCRLF;
                            if tempdisplaylabel <> '' then
                               rowstr := rowstr+'C;K"'+ tempdisplaylabel+ '"'+wwCRLF;
                            inc(exportfieldcount);
                      end
                      else begin
                         if j<(grid.titlelines div 2) then begin
                            tempdisplaylabel := strReplaceCharWithStr(grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].GroupName,';',';;');
                            tempdisplaylabel := getdisplaylabelforline(tempdisplaylabel,j+1);
                            rowstr := rowstr+'F;SL';
                            if j+1 >= (grid.titlelines div 2) then rowstr := rowstr+'B';
                            // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
                            rowstr := rowstr+'M0;FG0C;Y'+inttostr(j+1)+';X'+Inttostr(exportfieldcount+1)+wwCRLF;
//                            rowstr := rowstr+'F;SLBRM'+fonttag+';FG0'+GetSYLKAlignment(gridTitleALignment)+';Y2;X'+Inttostr(i+1+recoffset)+wwCRLF;
                            rowstr := rowstr+'C;K"'+ tempdisplaylabel+ '"'+wwCRLF;
                            groupColCount := 0;
                            //!!11/29/2001
                            for k:=startcol to endcol do
                               if exportFieldList[k-1] = 'T' then inc(groupColcount);

                            for k:=i+1 to i+groupcolcount-1 do begin
                               if exportFieldList[k] = 'T' then
                               begin
                                  rowstr := rowstr+'F;S';
                                  if (j+1>=grid.titlelines div 2) then rowstr := rowstr+'B';
                                  rowstr := rowstr+'M0;FG0C;X'+Inttostr(k+1+recoffset)+wwCRLF;
                                  rowstr := rowstr+'C;K""'+wwCRLF;
                               end;
                            end;
                            inc(i,endcol-startcol);
                            inc(exportfieldcount);
                         end
                         else begin
                            tempdisplaylabel := strReplaceCharWithStr(grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].DisplayLabel,';',';;');
                            tempdisplaylabel := getdisplaylabelforline(tempdisplaylabel,j+1-(grid.titlelines div 2));
                            rowstr := rowstr+'F;SLR';
                            if (j-1)<(grid.titlelines div 2) then rowstr := rowstr+'T';
                            if (j=Grid.TitleLines-1) then rowstr := rowstr+'B';
                            // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
                            rowstr := rowstr+'M'+fonttag+';FG0'+GetSYLKAlignment(gridTitleALignment)+';Y'+inttostr(j+1)+';X'+Inttostr(exportfieldcount+1)+wwCRLF;
                            if tempdisplaylabel <> '' then
                               rowstr := rowstr+'C;K"'+ tempdisplaylabel+ '"'+wwCRLF;
                            inc(exportfieldcount);
                         end;
                      end;
                    end;
                    inc(i);
                 end
                 else begin //First Row of a Group Cell.  Add tag and get next cell
                   grid.GroupNameCellRect(i+grid.xIndicatorOffset,0,startcol,endcol,false);
                   groupColCount := 0;
                   for k:=startcol to endcol do begin
                      if exportFieldList[k-1] = 'T' then
                         inc(groupColcount);
                   end;
                   if groupcolCount > 0 then begin
                      // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
                      rowstr := rowstr+'F;SLTM0;FG0C;Y1;X'+Inttostr(exportfieldcount+1)+wwCRLF;
                      inc(exportfieldcount);
                      tempdisplaylabel := strReplaceCharWithStr(grid.Columns[getdbcol(Grid,i+grid.xIndicatorOffset)].GroupName,';',';;');
                      tempdisplaylabel := getdisplaylabelforline(tempdisplaylabel,j+1);
                      rowstr := rowstr+'C;K"'+ tempdisplaylabel + '"'+wwCRLF;
                      for k:=i+1 to i+groupcolcount-1 do begin
                         if exportFieldList[k] = 'T' then begin
                            rowstr := rowstr+'F;STM0;FG0C;X'+Inttostr(k+1+recoffset)+wwCRLF;
                            rowstr := rowstr+'C;K""'+wwCRLF;
                            inc(exportfieldcount);
                         end;
                      end;
//                     groupassigned := True;
                   end;
                   inc(i,endcol-startcol+1);
                 end;
              end;
           //if not groupassigned then break;
         end;
       end;
      result := rowstr+wwCRLF;
    end;

    function WriteSYLKDataRow:String;
    var i:integer;
        RowStr,fonttag,tempstr:String;
        recoffset:integer;
        gridfont:TFont;
        gridbrush:TBrush;
        exportfieldcount:integer;
        Pos1,rownumberoffset:integer;  //6/13/2001-Added to handle case where header is not shown in file.
        AControlType, Parameters: wwSmallString;
        customedit:TWinControl;
        controlname:String;
        //SaveDecimal:char;
    begin
      with Grid do begin
        rowstr := '';
        recoffset :=0;
        rownumberoffset := 0;
        //9/26/2001-Only increment the rownumberoffset by as many rows that are in the header.
        if esoShowHeader in self.Options then
           rownumberoffset := TitleLines;
        if esoShowRecordNo in self.Options then begin
           if (TitleFont.Name <> Font.Name) or (TitleFont.Size <> Font.Size) or
              ((fsBold in TitleFont.Style) and not (fsBold in Font.Style)) or
              (not (fsBold in TitleFont.Style) and (fsBold in Font.Style)) or
              ((fsItalic in TitleFont.Style) and not (fsItalic in Font.Style)) or
              (not (fsItalic in TitleFont.Style) and (fsItalic in Font.Style)) or
              ((fsUnderline in TitleFont.Style) and not (fsUnderline in Font.Style)) or
              (not (fsUnderline in TitleFont.Style) and (fsUnderline in Font.Style)) or
              ((fsStrikeOut in TitleFont.Style) and not (fsStrikeOut in Font.Style)) or
              (not (fsStrikeOut in TitleFont.Style) and (fsStrikeOut in Font.Style)) then
               rowstr := rowstr+'F;SLRTBM1;FG0L;Y'+inttostr(curRowCount+rownumberoffset)+';X1'+wwCRLF
           else rowstr := rowstr+'F;SLRTBM0;FG0L;Y'+inttostr(curRowCount+rownumberoffset)+';X1'+wwCRLF;

           rowstr := rowstr + 'C;K'+IntToStr(curRowCount)+wwCRLF;
           recoffset :=1;
        end;
        // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
        exportfieldcount:=recoffset;
        for i:=0 to exportFieldList.Count-1 do begin
          if (exportFieldList[i] = 'T') then begin
               inc(exportfieldcount);
               gridFont := Grid.Canvas.Font;
               gridFont.assign(Font);
               gridBrush := Grid.Canvas.Brush;
               GridBrush.Color:=Color;

               if esoDynamicColors in self.Options then
                  Grid.DoCalcCellColors(DataLink.Fields[i], [], False, gridFont, gridBrush);

               fonttag := AddToSYLKFontList(gridFont,SYLKFontList);

               //9/26/2001-Specify the associated format based on field and datatype.
               // 10/01/2001 -PYW - Use current numbered exported field instead of fieldnumber
               case Grid.Datalink.Fields[i].datatype of
               ftFloat,ftDate,ftTime,ftDateTime,ftCurrency, ftTimeStamp:
                   rowstr := rowstr+'F;P'+SYLKFormatIndex[i]+';SLTRBM'+fonttag+';FG0'+GetSYLKAlignment(Grid.Datalink.Fields[i].alignment)+';Y'+inttostr(curRowCount+rownumberoffset)+';X'+inttostr(exportfieldcount)+wwCRLF;
               else
                 rowstr := rowstr+'F;SLTRBM'+fonttag+';FG0'+GetSYLKAlignment(Grid.Datalink.Fields[i].alignment)+';Y'+inttostr(curRowCount+rownumberoffset)+';X'+inttostr(exportfieldcount)+wwCRLF;
               end;

               tempstr := strReplaceCharWithStr(GetFieldValue(i),';',';;');
               if not Grid.DataLink.Fields[i].IsNull then
               case Grid.Datalink.Fields[i].datatype of
                 ftBoolean:
                 begin
                   if Grid.DataLink.Fields[i].asBoolean then
                      tempstr := 'TRUE'
                   else tempstr := 'FALSE';
                   tempstr := 'C;K'+AddQuotes(tempstr)+wwCRLF;
                 end;
                 ftLargeInt,ftSmallInt,ftWord,ftInteger:
                 begin
                   //2/1/2002 - PYW - Added code to handle special controls in grid.
                   GetControlInfo(Datalink.Fields[i].FieldName, AControlType, Parameters);
                   if (AControlType = 'CustomEdit') then begin
                      Pos1:= 1;
                      controlname:= strGetToken(Parameters, ';', Pos1);
                      customEdit:= GetComponent(controlname);
                      if (CustomEdit is TwwDBComboBox) then
                      begin
                         if (TwwDBComboBox(CustomEdit).MapList) and
                            (esoAddControls in self.Options) then
                            tempstr := 'C;K'+AddQuotes(tempstr)+wwCRLF
                         else
                            tempstr := 'C;K'+IntToStr(Grid.DataLink.Fields[i].asInteger)+wwCRLF;
                      end
                      else if (CustomEdit is TwwRadioGroup) or (CustomEdit is TwwCheckBox) then begin
                         if esoAddControls in self.Options then begin
                            if CustomEdit is TwwCheckBox then begin
                               if Grid.DataLink.Fields[i].asInteger = 1 then
                                 tempstr := 'C;K'+AddQuotes(TwwCustomCheckBox(CustomEdit).DisplayValueChecked)+wwCRLF
                               else
                                 tempstr := 'C;K'+AddQuotes(TwwCustomCheckBox(CustomEdit).DisplayValueUnchecked)+wwCRLF;
                            end
                            else tempstr := 'C;K'+AddQuotes(tempstr)+wwCRLF
                         end
                         else
                            tempstr := 'C;K'+IntToStr(Grid.DataLink.Fields[i].asInteger)+wwCRLF;
                      end
                      else tempstr := 'C;K'+tempstr+wwCRLF;
                   end
                   else tempstr := 'C;K'+tempstr+wwCRLF;
                 end;
                 //9/26/2001-Added handling of the following additional data types.
//                 ftfloat,ftCurrency: tempstr := 'C;K'+FloatToStr(Grid.DataLink.Fields[i].asFloat)+wwCRLF;
                 ftfloat,ftCurrency: begin
                    //3/13/2002-PYW-Make sure the SYLK format is stored with decimals
                    tempstr := 'C;K'+FloatToStr(Grid.DataLink.Fields[i].asFloat)+wwCRLF;
                    if DecimalSeparator <> '.' then
                       tempstr := ReplaceStrWithStr(tempstr,DecimalSeparator,'.');
                 end;
                 ftDate: tempstr := 'C;K'+IntToStr(Trunc(Grid.DataLink.Fields[i].asDateTime))+wwCRLF;
                 ftTime: begin
                    tempstr := 'C;K'+FloatToStr(Frac(Grid.DataLink.Fields[i].asDateTime))+wwCRLF;
                    if DecimalSeparator <> '.' then
                        tempstr := ReplaceStrWithStr(tempstr,DecimalSeparator,'.');
                 end;
                 ftDateTime, ftTimeStamp: begin
                    tempstr := 'C;K'+FloatToStr(Grid.DataLink.Fields[i].asFloat)+wwCRLF;
                    if DecimalSeparator <> '.' then
                        tempstr := ReplaceStrWithStr(tempstr,DecimalSeparator,'.');
                 end;
               else
                  //SYLK does not like #13 and #10 carriage return line feed characters in string.
                  //Replace them with spaces.
                  tempstr := ReplaceStrWithStr(tempstr,#13#10,' ');
//                  tempstr := strReplaceCharWithStr(tempstr,#10,' ');
                  //Then copy the 1st 255 characters as SYLK does not like cells longer than 255.
                  tempstr := Copy(tempstr,1,255);
                  //Add SYLK Data tags.
                  if tempstr = '' then tempstr := 'C;K""'+wwCRLF
                  else tempstr := 'C;K'+AddQuotes(tempstr)+wwCRLF;
               end
               else tempstr := 'C;K""'+wwCRLF;
               rowstr := rowstr + tempstr;
          end;
        end;
        result := rowstr;
      end;
    end;

    function savetostringfirst:boolean;
    begin
      result := False;
      if esoClipboard in self.Options then begin
        result := True;
      end;
      if ExportType = wwgetSYLK then result := True;
    end;

    procedure SetSYLKToClipboard;
    Var
      MemHandle: THandle;
    begin
      with clipboard do begin
         MemHandle := GlobalAlloc( GHND or GMEM_SHARE, Length(totalstr)+1 );
         If MemHandle <> 0 Then Begin
            StrCopy( GlobalLock( MemHandle ), PChar(totalstr));//memstring );
            GlobalUnlock( MemHandle );
            Open;
            try
              AsText := totalstr;
          //    showmessage(totalstr);
              SetAsHandle( CF_SYLK, MemHandle );
            finally
              Close;
            end;
         End
         Else
           MessageDlg('Global Alloc failed!', mtError, [mbOK], 0 );
      end;
    end;

    procedure SetHTMLToClipboard;
    Var
      MemHandle: THandle;
      CF_HTML:LONGINT;
      header:string;
      starthtml,endhtml,startseg,endseg,startpos:Longint;
      function GetPaddedNumber(number:longint;padlength:integer):string;
      var ct,len:integer;
          padstr:string;
      begin
         padstr := inttostr(number);
         len := length(padstr);
         for ct:= len+1 to padlength do
            padstr := '0'+padstr;
         result := padstr;
      end;
    begin
{      if not UseOldClipboardSaving then begin
        clipboard.open;
        try
          clipboard.Clear;
          wwcopyToClipBoard(totalstr,totalstr);
        finally
          clipboard.close;
        end;
        exit;
      end;}
      if UseOldClipboardSaving then begin
         header := 'Version:0.9'+wwCRLF;
         header := header+'StartHTML:0'+wwCRLF;
         header := header+'EndHTML:'+inttostr(Length(totalstr))+wwCRLF;
         header := header+'StartFragment:0'+wwCRLF;
         header := header+'EndFragment:0'+wwCRLF;
         header := header+'StartSelection:0'+wwCRLF;
         header := header+'EndSelection:0'+wwCRLF;
         totalstr := header+totalstr;
      end
      else begin //2/26/2002 - New Style handles all clipboard HTML export formats as it fills all of the header values.
        totalstr := '<!--StartFragment-->'+wwCRLF+totalstr+'<!--EndFragment-->';

        header := 'Version:0.9'+wwCRLF;
        header := header+'StartHTML:0000000000'+wwCRLF;
        header := header+'EndHTML:0000000000'+wwCRLF;
        header := header+'StartFragment:0000000000'+wwCRLF;
        header := header+'EndFragment:0000000000'+wwCRLF;
        header := header+'StartSelection:0000000000'+wwCRLF;
        header := header+'EndSelection:0000000000'+wwCRLF;

        //Fill in Start Offsets of HTML.
        starthtml:=Length(header);
        startPos:= AnsiPos('StartHTML:0000000000', header);
        header := Copy(header,1,startpos+9)+getpaddednumber(starthtml,10)+Copy(header,startpos+20,length(header));

        //Fill in Start Offsets of HTML.
        endhtml := starthtml + length(totalstr);
        startPos:= AnsiPos('EndHTML:0000000000', header);
        header := Copy(header,1,startpos+7)+getpaddednumber(endhtml,10)+Copy(header,startpos+18,length(header));

        totalstr := header + totalstr;
        //Fill in Start Fragment
        StartSeg:= AnsiPos('<!--StartFragment-->', totalstr);
        startPos:= AnsiPos('StartFragment:0000000000', totalstr);
        totalstr := Copy(totalstr,1,startpos+13)+getpaddednumber(startseg,10)+Copy(totalstr,startpos+24,length(totalstr));

        //Fill in End Fragment
        EndSeg:= AnsiPos('<!--EndFragment-->', totalstr);
        startPos:= AnsiPos('EndFragment:0000000000', totalstr);
        totalstr := Copy(totalstr,1,startpos+11)+getpaddednumber(endseg,10)+Copy(totalstr,startpos+22,length(totalstr));

        //Fill in Start Selection
        startPos:= AnsiPos('StartSelection:0000000000', totalstr);
        totalstr := Copy(totalstr,1,startpos+14)+getpaddednumber(startseg,10)+Copy(totalstr,startpos+25,length(totalstr));

        //Fill in End Selection
        startPos:= AnsiPos('EndSelection:0000000000', totalstr);
        totalstr := Copy(totalstr,1,startpos+12)+getpaddednumber(endseg,10)+Copy(totalstr,startpos+23,length(totalstr));
      end;

      CF_HTML := RegisterClipboardFormat('HTML Format');
      with clipboard do begin
         MemHandle := GlobalAlloc( GHND or GMEM_SHARE, Length(totalstr)+1 );
         If MemHandle <> 0 Then Begin
            StrCopy( GlobalLock( MemHandle ), PChar(totalstr));
            GlobalUnlock( MemHandle );
            Open;
            try
              AsText := totalstr;
              SetAsHandle(CF_HTML, MemHandle );
            finally
              Close;
            end;
         End
         Else
           MessageDlg('Global Alloc failed!', mtError, [mbOK], 0 );
      end;
   end;

begin
  grid := TwwDBGrid(Owner);
  if not Grid.Datalink.Active then exit;

  SYLKFontList:= nil;
  SYLKFormatIndex := nil;
  exportfieldList := TStringList.Create;
  SYLKFormatIndex := TStringList.Create;
  try
    with Grid do begin
      TotalPixelCount := 0;
//      if esoShowRecordNo in self.Options then TotalPixelCount := 0;
      // Save columns to export and total pixel width for later use.
      for i:= 0 to Datalink.FieldCount - 1 do begin
         Accept := True;
         DoExportField(Grid,DataLink.Fields[i],Accept);
         if Accept then begin
            exportFieldList.Add('T');
            TotalPixelCount := TotalPixelCount+Grid.ColWidthsPixels[i+xindicatorOffset]+5;
         end
         else exportFieldList.Add('F');
         SYLKFormatIndex.Add('0');
      end;

      //6/13/2001-SYLK format has additional header initialization that needs to be called.
      //7/26/2001-PYW-Handle Header
      if (esoShowHeader in self.options) or (ExportType=wwgetSYLK) or (ExportType=wwgetHTML) then begin
         case ExportType of
           wwgetTxt: totalstr := WriteTextHeader;
           wwgetHTML: totalstr := WriteHTMLHeader;
           wwgetSYLK: totalstr := WriteSYLKHeader;
         end;  //End Case
         if not savetostringfirst then begin
            fs.WriteBuffer(Pointer(totalstr)^, Length(totalstr));
         end
      end;  //End ShowHeader

      currowcount := 0;

      if esoSaveSelectedOnly in self.Options then begin
        Grid.SortSelectedList;
        for i:=0 to Grid.SelectedList.count-1 do begin
           currowcount := i+1;
           DataSource.Dataset.GotoBookmark(SelectedList[i]);
           case ExportType of
             wwgetTxt: recordstr := WriteTextDataRow;
             wwgetHTML: recordstr := WriteHTMLDataRow;
             wwgetSYLK: recordstr := WriteSYLKDataRow
           end;
           if not savetostringfirst then
              fs.WriteBuffer(Pointer(recordstr)^, Length(recordstr))
           else totalstr := totalstr+recordstr;
           Application.ProcessMessages;
        end;
        if SelectedList.Count <= 0 then begin
           if ExportType = wwgetHTML then begin
              recordstr := '<TR '+SetBkGrndColor(TitleColor)+'>'+
                           '<TH colspan='+IntToStr(Grid.DataLink.Fieldcount+XRecNoOffset)+' scope=colgroup>'+
                           'No Records Selected'+'</TH>'+'</TR>'+wwCRLF;

              if not savetostringfirst then
                fs.WriteBuffer(Pointer(recordstr)^,Length(recordstr))
              else totalstr := totalstr+ recordstr;
           end;
        end;
      end
      else begin
        Datasource.Dataset.First;
        while not DataSource.DataSet.EOF do
        begin
           inc(currowcount);
           case ExportType of
             wwgetTxt: recordstr := WriteTextDataRow;
             wwgetHTML: recordstr := WriteHTMLDataRow;
             wwgetSYLK: recordstr := WriteSYLKDataRow
           end;
           if not savetostringfirst then
              fs.WriteBuffer(Pointer(recordstr)^, Length(recordstr))
           else totalstr := totalstr+recordstr;
           Application.ProcessMessages;
           DataSource.DataSet.Next;
        end;
      end;
    end;  // End With Grid

    if ExportType = wwgetHTML then begin
       recordstr := '</TBODY>'+wwCRLF+'</BODY>'+wwCRLF+'</TABLE>'+wwCRLF+'</HTML>'+wwCRLF;
       if not (savetostringfirst) then
          fs.WriteBuffer(Pointer(recordstr)^, Length(recordstr))
       else totalstr := totalstr+recordstr;
    end
    else if ExportType = wwgetSYLK then begin
       recordstr:='E';
       totalstr := totalstr+recordstr;
       startPos:= AnsiPos('B;Y;', totalStr);
       if esoShowHeader in Options then inc(currowcount);
       Fmtstr(totalstr,'%sB;Y%s;%s',[Copy(totalstr,1,startpos-1),inttostr(currowcount),Copy(totalstr,startpos+4,length(totalstr))]);
       startpos := AnsiPos('B;Y',totalstr);
       fontlist:='';
       //6/13/2001-Don't call if this FontList is nil.
       if SYLKFontList <> nil then
         for i:= 0 to SYLKFontList.Count-1 do begin
           fontlist := fontlist+SYLKFontList.Names[i]+wwCRLF;
         end;
       Fmtstr(totalstr,'%s%s%s',[Copy(totalstr,1,startpos-1),fontlist,Copy(totalstr,startpos,length(totalstr))]);

       if not (esoClipboard in Options) then begin
          fs.WriteBuffer(Pointer(totalstr)^, Length(totalstr))
       end;
    end;
    if esoClipboard in Options then begin
       Clipboard.clear;
       if exportType = wwgetSYLK then begin
          SetSYLKToClipboard;
       end
       else if exportType = wwgetTxt then begin
          Clipboard.asText := totalstr;
       end
       else if exportType = wwgetHTML then begin
          SetHTMLToClipboard;
       end;
    end;
  finally
    exportFieldList.Free;
    SYLKFontList.Free;
    SYLKFormatIndex.Free;
  end;
end;

type TwwCheatExportGrid=class(TwwDBGrid);

procedure TwwExportOptions.Save;
var fs:TFileStream;
   curBookmark: TBookmark;
   ScrollCount, currentrow, moveByCount: integer;
   Grid:TwwDBGrid;
begin
   if esoClipboard in Options then
      fs := nil
   else fs := TFileStream.Create(FileName, fmCreate);
   try
      if Owner is TwwDBGrid then begin
         if (Owner <> nil) and (TwwDBGrid(Owner).Datasource <> nil) and
            (TwwDBGrid(Owner).DataSource.Dataset <> nil) then
         begin
            Grid := TwwDBGrid(Owner);
            with Grid,Grid.DataSource.Dataset do begin
               DisableControls;
               curBookmark := GetBookmark;
               currentRow:= Grid.GetActiveRow;
            {Add middle bookmark code.}
               try
                  ExportToStream(fs);
               finally
                  GotoBookmark(CurBookmark);
                  FreeBOokmark(CurBookmark);
                  if GetActiveRow<currentRow then
                  begin
                     ScrollCount:= CurrentRow-GetActiveRow;
                     MoveByCount:= -(GetActiveRow + ScrollCount);
                     if MoveByCount<>0 then begin
                        MoveBy(MoveByCount);
                        SetActiveRow(CurrentRow);
                     end;
                  end
                  else begin
                     ScrollCount:= GetActiveRow-currentRow;
                     MoveByCount:= ((TwwCheatExportGrid(Grid).VisibleRowCount-1)-GetActiveRow) + ScrollCount;
                     If MoveByCount<>0 then begin
                        MoveBy(MoveByCount);
                        SetActiveRow(CurrentRow);
                     end;
                  end;
                  EnableControls;
               end;
            end;
         end
      end
   finally
      if fs <> nil then fs.Free;
   end;
end;

function TwwExportOptions.IsDelimiterStored: boolean;
begin
   if Delimiter = ',' then result:= false
   else result:= True;
end;

end.
