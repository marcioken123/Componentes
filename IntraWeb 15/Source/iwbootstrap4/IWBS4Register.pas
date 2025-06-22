unit IWBS4Register;

interface

uses Classes, Dialogs, SysUtils, StrUtils, DesignEditors, DesignIntf, StrEdit,
  IWDsnPaintHandlers;

type
  TFontAwesomeEditor = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TGoogleIconsEditor = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBS4StringProperty = class(TStringListProperty)
  private
    FStrings: TStrings;
  protected
    function GetStrings: TStrings; override;
    procedure SetStrings(const Value: TStrings); override;
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TIWBS4PaintHandlerRegion = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerBlockquote = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerBlock = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerInline = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerTable = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerInputForm = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerAlert = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerCarousel = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerFlexbox = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerFlexboxItem = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerCustomInput = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerCustomCheck = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerCustomButton = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

(*TIWBS4PaintHandlerGlyphicon = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;*)

  TIWBS4PaintHandlerFile = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerRadioGroup = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerText = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerLabel = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

  TIWBS4PaintHandlerImage = class (TIWPaintHandlerRectangle)
  public
    procedure Paint; override;
  end;

procedure Register;

implementation

uses Windows, Forms, Graphics, IconsFontAwesome, IconsGoogle, IWBaseControl,
  IWBS4LayoutMgr, IWBS4Controls, IWBS4CustomInput, IWBS4CustomRegion,
  IWBS4Region, IWBS4InputForm, IWBS4Input, IWBS4CustomControl,
  IWBS4DropDown, IWBS4TabControl, IWBS4NavBar, IWBS4List, IWBS4Deprecated,
  IWBS4Common, IWBS4Button, IWBS4Image, IWBS4MemoHTML, IWBS4ButtonGroup,
  IWBS4BlockText, IWBS4Table, IWBS4Carousel, IWBS4Flexbox, IWBS4FlexboxItem,
  IWBS4Block, IWBS4Inline, IWBS4Alert, IWBS4InputCheckbox, IWBS4InputSelect,
  IWBS4InputText, IWBS4Progress, IWBS4Cal,
  IWBS4Moab, IWBS4MoabDialog, IWBS4MoabContent,
  IWDsnControlAbout;


const
  CNST_DEFAULTFONTNAME = 'Tahoma';
  CNST_GLYPHICONSFONT = 'GLYPHICONS Halflings';
//CNST_PROPORTIONALFONT = 'Courier New';
  CNST_PROPORTIONALFONT = 'Consolas';

var
  slFontAwesome: TStringList;
  slGoogleMaterial: TStringList;
  lFontAdvice: Boolean = True;

procedure PaintBadge(ACanvas: TCanvas; ATagType: string);
var
  PrevColor: TColor;
  w: Integer;
  BadgeWidth: Integer;
const
  BUFFER_BOTH_SIDES = 10;
begin
  // We want the width of the badge to respond to the width of the contents
  // First step is to get the width of the caption in the badge
  ACanvas.Font.Color := clWebAZURE;
  ACanvas.Font.Name := 'Tahoma';
  ACanvas.Font.Size := 8;
  ACanvas.Font.Style := [fsBold];
  w := ACanvas.TextWidth(ATagType);
  // Don't need variable BadgeWidth (could use "w + 10"), but the code is more readable
  BadgeWidth := w + BUFFER_BOTH_SIDES;
  // Paint the badge
  PrevColor := ACanvas.Brush.Color;
  ACanvas.Brush.Color := clWebDEEPPINK;
  ACanvas.RoundRect(2, 2, BadgeWidth, 19, 5, 5);
  // Paint the tag type
  ACanvas.TextOut(2 + (((BadgeWidth - 2) - w) div 2), 3, ATagType);
  // Don't leave the canvas a mess
  ACanvas.Brush.Color := PrevColor;
  ACanvas.Font.Color := clWebNAVY;
  ACanvas.Font.Name := CNST_PROPORTIONALFONT;
  ACanvas.Font.Size := 9;
  ACanvas.Font.Style := [];
end;

// advice to install glyphicon font
procedure GlyphiconsFontAdvice;
begin
  if lFontAdvice then
  begin
    lFontAdvice := False;
    if Screen.Fonts.IndexOf(CNST_GLYPHICONSFONT) = -1 then
    begin
      ShowMessage('Please install "demo\bin\wwwroot\iwbs\bootstrap-3.3.5\fonts\glyphicons-halflings-regular.ttf" to render glyphicons at design time');
    end;
  end;
end;

function GetGlyphiconChar(const AFontAwesomeIcon: string; const AFallBackTo: string = ''): string;
var
  i: Integer;
begin
  if AFontAwesomeIcon <> ''
    then i := StrToIntDef(slFontAwesome.Values[AFontAwesomeIcon], 0)
    else i := 0;

  if i = 0
    then Result := AFallBackTo
    else Result := Char(i);
end;

function TFontAwesomeEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TFontAwesomeEditor.GetValues(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to slFontAwesome.Count - 1 do
  begin
    Proc(slFontAwesome.Names[i]);
  end;
end;

procedure TFontAwesomeEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

procedure DrawGlyphicon(ACanvas: TCanvas; var ARect: TRect; AGlyphicon, AFallBackTo: string; ARight: Boolean = False);
var
  c: string;
begin
  ACanvas.Font.Name := CNST_GLYPHICONSFONT;
  if AGlyphicon <> '' then
  begin
    c := GetGlyphiconChar(AGlyphicon, AFallBackTo);
  end;

  if c <> '' then
  begin
    if ARight then
    begin
      DrawTextEx(ACanvas.Handle, PChar(c), Length(c), ARect, DT_SINGLELINE + DT_VCENTER + DT_RIGHT, nil);
      Dec(ARect.Right, ACanvas.TextWidth(c)+4);
    end else
    begin
      DrawTextEx(ACanvas.Handle, PChar(c), Length(c), ARect, DT_SINGLELINE + DT_VCENTER, nil);
      Inc(ARect.Left, ACanvas.TextWidth(c)+4);
    end;
  end;
end;

procedure DrawControlName(ACanvas: TCanvas; ARect: TRect; const AName: string);
begin
  ACanvas.Font.Name := CNST_PROPORTIONALFONT;
  ACanvas.Font.Color := clGray;
  ACanvas.Font.Size := 8;
  ACanvas.Font.Style := [fsItalic];
  DrawTextEx(ACanvas.Handle, PChar(AName), Length(AName), ARect, DT_SINGLELINE + DT_VCENTER, nil);
  ACanvas.Font.Style := [];
end;

procedure TIWBS4PaintHandlerRegion.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4CustomRegion(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    if Control is TIWBS4FormGroup then
    begin
      if s <> '' then
      begin
        s := ' '+ s;
      end;
      s := 'form-group' + s;
    end;
    s := '[' + s + ']';
    if (not RawText) and (not (Control is TIWBS4BlockText)) then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    if Control is TIWBS4FormGroup then
    begin
       PaintBadge(ControlCanvas, 'form-group');
    end else
    if (Control is TIWBS4Region) and ((Control as TIWBS4Region).BSRegionType <> bs4rtNone) then
    begin
      PaintBadge(ControlCanvas, aIWBS4RegionType[(Control as TIWBS4Region).BSRegionType]);
    end else
    begin
      PaintBadge(ControlCanvas, TagType);
    end;

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end else
    begin
      // Disabling this feature until further notice (Oct 17, 2018)
      // Painting the h1 huge on the control has some benefit, but it also makes
      // it impossible to have a compact visual design. There are already enough
      // divs within divs within divs -- and vertical real estate is at a premium
     {ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
      if Control is TIWBS4BlockText then
        case TIWBS4BlockText(Control).TagType of
          bs4bttH1: ControlCanvas.Font.Height := -36;
          bs4bttH2: ControlCanvas.Font.Height := -30;
          bs4bttH3: ControlCanvas.Font.Height := -24;
          bs4bttH4: ControlCanvas.Font.Height := -18;
          bs4bttH5: ControlCanvas.Font.Height := -14;
          bs4bttH6: ControlCanvas.Font.Height := -12;
        end;
      if Control is TIWBS4Region then
        case TIWBS4Region(Control).TagType of
          bs4ttDiv, bs4ttP: ControlCanvas.Font.Height := -12;
        end;}
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 19, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerBlockquote.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Blockquote(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, TagType);

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerBlock.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Block(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, TagType);

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerInline.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Inline(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, TagType);

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerTable.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Table(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, TagType);

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerInputForm.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4InputForm(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, 'form');

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerAlert.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Alert(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    PaintBadge(ControlCanvas, TagType);

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerCarousel.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Carousel(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    // It's really a div, but it looks much better to just call it a carousel
    PaintBadge(ControlCanvas, 'carousel');

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerFlexbox.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Flexbox(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    // It's really a div, but it looks much better to just call it a carousel
    PaintBadge(ControlCanvas, 'flexbox');

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerFlexboxItem.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
  LLines: string;
  LScript: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4FlexboxItem(Control) do
  begin
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Size := 9;
    ControlCanvas.Font.Color := clWebNAVY;
    ControlCanvas.Font.Style := [];

    // draw css classes
    s := GetCssString;
    s := '[' + s + ']';
    if not RawText then
    begin
      s := '<' + TagType + '> ' + s;
    end;
    s := Name + ' ' + s;
    w := ControlCanvas.TextWidth(s);
    LRect := Rect(Control.ClientWidth - w - 10, 1, Control.Width, Control.Height);
    ControlCanvas.TextRect(LRect, s, []);

    // It's really a div, but it looks much better to just call it a carousel
    PaintBadge(ControlCanvas, 'flex-item');

    // draw embedded text and script
    LLines := Text;
    if RawText then
    begin
      ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    if LLines <> '' then
    begin
      LRect := Rect(10, 18, Control.Width - 10, Control.Height - 3);
      ControlCanvas.Font.Color := clBlack;
      ControlCanvas.TextRect(LRect, LLines, []);
    end;
  end;
end;

procedure TIWBS4PaintHandlerCustomInput.Paint;
var
  LRect, LIcon: TRect;
  s, c: string;
  LMultiLine: Boolean;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
  ControlCanvas.Font.Size := 10;
  ControlCanvas.Font.Color := clBlack;
  ControlCanvas.Rectangle(LRect);

  Inc(LRect.Top, 2);
  Inc(LRect.Left, 2);
  Dec(LRect.Bottom, 2);
  Dec(LRect.Right, 2);
  ControlCanvas.Pen.Color := clLtGray;
  ControlCanvas.Rectangle(LRect);

  if Control is TIWBS4CustomInput then
  begin
    LMultiLine := False;

    s := TIWBS4CustomInput(Control).DataField;
    if Control is TIWBS4CustomTextInput then
    begin
      if s = '' then
      begin
        s := TIWBS4Input(Control).Text;
      end;
      if s = '' then
      begin
        s := TIWBS4Input(Control).PlaceHolder;
        ControlCanvas.Font.Color := clLtGray;
      end;
      if Control is TIWBS4Memo then
      begin
        LMultiLine := True;
      end;
    end else
    if Control is TIWBS4Select then
    begin
      LMultiLine := TIWBS4Select(Control).Size <> 1;
      if s = '' then
      begin
        if LMultiLine then
        begin
          s := TIWBS4Select(Control).Items.Text
        end else
        if TIWBS4Select(Control).Items.Count > 0 then
        begin
          s := TIWBS4Select(Control).Items[0];
        end;
      end;

      if not LMultiLine then
      begin
        LIcon := Rect(LRect.Right - 18, LRect.Top + 1, LRect.Right - 1, LRect.Bottom - 1);
        ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
        ControlCanvas.Brush.Color := clLtGray;
        ControlCanvas.Rectangle(LIcon);
        c := GetGlyphiconChar('chevron-down', 'V');
        if c <> '' then
        begin
          DrawTextEx(ControlCanvas.Handle, PChar(c), 1, LIcon, DT_CENTER + DT_SINGLELINE + DT_VCENTER, nil);
          ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
          ControlCanvas.Brush.Color := clWhite;
          Dec(LRect.Right, 20);
        end;
      end;
    end;

    Inc(LRect.Top, 1);
    Inc(LRect.Left, 8);
    Dec(LRect.Bottom, 1);
    Dec(LRect.Right, 8);
    if LMultiLine
      then ControlCanvas.TextRect(LRect, s, [])
      else DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE + DT_VCENTER, nil);
  end;
end;

procedure TIWBS4PaintHandlerCustomCheck.Paint;
var
  LRect, LIcon: TRect;
  LGlyp, LCaption: string;
  c: string;
begin
  if Control is TIWBS4RadioButton then
  begin
    LGlyp := 'record';
    LCaption := TIWBS4CheckBox(Control).Caption;
  end else
  if Control is TIWBS4CheckBox then
  begin
    LGlyp := 'ok';
    LCaption := TIWBS4CheckBox(Control).Caption;
  end else
  begin
    LGlyp := '';
    LCaption := '';
  end;

  if LGlyp <> '' then
  begin
    LIcon := Rect(0, 0, 16, Control.Height);
    ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
    ControlCanvas.Font.Size := 8;
    c := GetGlyphiconChar(LGlyp, 'X');
    DrawTextEx(ControlCanvas.Handle, PChar(c), 1, LIcon, DT_SINGLELINE + DT_VCENTER, nil);
  end;

  if LCaption <> '' then
  begin
    LRect := Rect(17, 0, Control.Width, Control.Height);
    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    DrawTextEx(ControlCanvas.Handle, PChar(LCaption), Length(LCaption), LRect, DT_SINGLELINE + DT_VCENTER, nil);
  end;
end;

procedure TIWBS4PaintHandlerCustomButton.Paint;
var
  LRect: TRect;
  s: string;
begin
//GlyphiconsFontAdvice; // no more Glyphicons in BS4

  if not (Control is TIWBS4CustomButton) then
  begin
    Exit;
  end;

  with TIWBS4CustomButton(Control) do
  begin
    LRect := Rect(0, 0, Width, Height);
    case BSButtonStyle of
      bs4bsBasic:
        begin
          ControlCanvas.Brush.Color := clWebSILVER;
          ControlCanvas.Pen.Color := clWebDARKGRAY;
          if Enabled
            then ControlCanvas.Font.Color := clBlack
            else ControlCanvas.Font.Color := clSilver;
        end;
      bs4bsPrimary:
        begin
          ControlCanvas.Brush.Color := clWebDODGERBLUE;
          ControlCanvas.Pen.Color := clWebBlue;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsSecondary:
        begin
          ControlCanvas.Brush.Color := $555555;
          ControlCanvas.Pen.Color := $555555;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsSuccess:
        begin
          ControlCanvas.Brush.Color := clWebYELLOWGREEN;
          ControlCanvas.Pen.Color := clWebLimeGreen;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsInfo:
        begin
          ControlCanvas.Brush.Color := clWebSkyBlue;
          ControlCanvas.Pen.Color := clWebSkyBlue;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsWarning:
        begin
          ControlCanvas.Brush.Color := clWebGoldenRod;
          ControlCanvas.Pen.Color := clWebGoldenRod;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsDanger:
        begin
          ControlCanvas.Brush.Color := clWebFirebrick;
          ControlCanvas.Pen.Color := clWebFirebrick;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsDark:
        begin
          ControlCanvas.Brush.Color := $030303;
          ControlCanvas.Pen.Color := clBlack;
          ControlCanvas.Font.Color := clWhite;
        end;
      bs4bsLight:
        begin
          ControlCanvas.Brush.Color := $FAFAFA;
          ControlCanvas.Pen.Color := clBlue;
          ControlCanvas.Font.Color := clGray;
        end;
      bs4bsLink:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clWhite;
          ControlCanvas.Font.Color := clWebBlue;
        end;
      bs4bsClose:
        begin
          ControlCanvas.Brush.Color := clWhite;
          ControlCanvas.Pen.Color := clWhite;
          ControlCanvas.Font.Color := clGray;
        end;
    end;
    ControlCanvas.Rectangle(LRect);

    Inc(LRect.Top);
    Inc(LRect.Left, 38); // leave room for the badge
    Dec(LRect.Bottom);
    Dec(LRect.Right, 10);

    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Style := [fsBold];
    case BSButtonSize of
      bs4bszLarge:   ControlCanvas.Font.Height := -18;
      bs4bszDefault: ControlCanvas.Font.Height := -14;
      bs4bszSmall:   ControlCanvas.Font.Height := -12;
    end;

   {if not (Control is TIWBS4DropDown) and (BSGlyphicon <> '') then
    begin
      DrawGlyphicon(ControlCanvas, LRect, BSGlyphicon, '');
    end;}

    s := Caption;
    if (s = '') and (BSButtonStyle = bs4bsClose) then
    begin
      s := 'X';
    end;
    if s <> '' then
    begin
      ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
      DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE + DT_VCENTER, nil);
    end;

   {if Control is TIWBS4DropDown then
    begin
      if BSGlyphicon <> ''
        then DrawGlyphicon(ControlCanvas, LRect, BSGlyphicon, '', True)
        else DrawGlyphicon(ControlCanvas, LRect,'chevron-down', 'V', True);
    end;}

    if not (Control is TIWBS4DropDown) and {(BSGlyphicon = '') and} (s = '') then
    begin
      DrawControlName(ControlCanvas, LRect, Name);
    end;

    PaintBadge(ControlCanvas, 'btn');
  end;
end;

procedure TIWBS4PaintHandlerFile.Paint;
var
  LRect: TRect;
  s: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
  ControlCanvas.Font.Size := 10;
  ControlCanvas.Font.Color := clBlack;
  ControlCanvas.Rectangle(LRect);

  Inc(LRect.Top, 1);
  Inc(LRect.Left, 8);
  Dec(LRect.Bottom, 1);
  Dec(LRect.Right, 8);
  s := 'File Input';
  DrawTextEx(ControlCanvas.Handle, PChar(s), Length(s), LRect, DT_SINGLELINE + DT_VCENTER, nil);
end;

(*procedure TIWBS4PaintHandlerGlyphicon.Paint;
var
  LRect: TRect;
  c: string;
  th: Integer;
begin
  GlyphiconsFontAdvice;

  if Control is TIWBS4Glyphicon then
  begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.FillRect(LRect);

    if TIWBS4Glyphicon(Control).BSGlyphicon <> '' then
    try
      ControlCanvas.Font.Name := CNST_GLYPHICONSFONT;
      ControlCanvas.Font.Style := [fsBold];
      ControlCanvas.Font.Height := -14;
      th := ControlCanvas.TextHeight('X');
      c := GetGlyphiconChar(TIWBS4Glyphicon(Control).BSGlyphicon);
      if c <> '' then
      begin
        ControlCanvas.TextRect(LRect, LRect.Left, (LRect.Bottom - LRect.Top - th) div 2, c);
      end;
    except

    end;
  end;
end;*)

procedure TIWBS4PaintHandlerRadioGroup.Paint;
var
  LRect: TRect;
  s: string;
  w: Integer;
begin
  if Control is TIWBS4RadioGroup then
  begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clBlack;
    ControlCanvas.Rectangle(LRect);

    Inc(LRect.Top, 5);
    Inc(LRect.Left, 5);
    Dec(LRect.Right, 5);
    Dec(LRect.Bottom, 5);

    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Color := clGray;
    s := 'RadioGroup';
    w := ControlCanvas.TextWidth(s);
    ControlCanvas.TextRect(LRect, Control.ClientWidth - w - 10, 5, s);

    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Color := clBlack;
    ControlCanvas.Font.Size := 10;
    s := TIWBS4RadioGroup(Control).Items.Text;
    ControlCanvas.TextRect(LRect,s,[]);
  end;
end;

procedure TIWBS4PaintHandlerText.Paint;
var
  LRect: TRect;
  LLines, LScript: string;
begin
  with TIWBS4Text(Control) do
  begin
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clGray;
    ControlCanvas.Rectangle(LRect);

    if RawText
      then ControlCanvas.Font.Name := CNST_PROPORTIONALFONT
      else ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    ControlCanvas.Font.Color := clBlack;

    LLines := DataField;
    if LLines = '' then
    begin
      LLines := Trim(Lines.Text);
    end;

    if RawText then
    begin
      if Script.Count > 0
        then LScript := #13#10'<script>'#13#10 + Script.Text + '</script>'
        else LScript := '';
      LLines := '<' + TagType + '>' + IfThen(LLines <> '', #13#10 + LLines);
      if ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
      LLines := LLines + #13#10'</' + TagType + '>';
      if not ScriptInsideTag then
      begin
        LLines := LLines + LScript;
      end;
    end;

    Inc(LRect.Top, 1);
    Inc(LRect.Left, 8);
    Dec(LRect.Bottom, 1);
    Dec(LRect.Right, 8);
    ControlCanvas.TextRect(LRect, LLines, [])
  end;
end;

procedure TIWBS4PaintHandlerLabel.Paint;
var
  LRect: TRect;
  lCaption: string;
begin
  with TIWBS4Label(Control) do
  begin
    LRect := Rect(0, 0, Control.Width, Control.Height);

    ControlCanvas.Brush.Color := clWhite;
    ControlCanvas.Pen.Color := clGray;
    ControlCanvas.Font.Name := CNST_DEFAULTFONTNAME;
    ControlCanvas.Font.Size := 10;
    ControlCanvas.Font.Color := clBlack;
    lCaption := Caption;

    if DataField <> '' then
    begin
      DrawControlName(ControlCanvas, LRect, DataField)
    end else
    if lCaption <> ''
      then ControlCanvas.TextRect(LRect, lCaption, [])
      else DrawControlName(ControlCanvas, LRect, Name);
  end;
end;

procedure TIWBS4PaintHandlerImage.Paint;
var
  LRect, LImageRect: TRect;
  LPicture: TPicture;
  LText, LImageFile: string;
begin
  LRect := Rect(0, 0, Control.Width, Control.Height);
  LImageRect := LRect;
  LText := '';

  ControlCanvas.Brush.Color := clWhite;
  ControlCanvas.Pen.Color := clGray;
  ControlCanvas.Rectangle(LRect);

  with TIWBS4Image(Control) do
  begin
    if Assigned(DataSource) and (DataField <> '') then
      begin
        LText := DataSource.Name + '.[' + DataField + ']';
        Inc(LImageRect.Top, 40);
        Inc(LImageRect.Left, 40);
        Dec(LImageRect.Bottom, 40);
        Dec(LImageRect.Right, 40);
      end;

    if Assigned(Picture) and Assigned(Picture.Graphic) and (not Picture.Graphic.Empty) then
    begin
      if LText <> '' then
      begin
        LText := LText + #13#10'Fallback to picture';
      end;
      ControlCanvas.StretchDraw(LImageRect, Picture.Graphic);
    end else
    if ImageFile <> '' then
    begin
      LImageFile := GetFixedFilePath;
      if FileExists(LImageFile) then
      begin
        LPicture := TPicture.Create;
        try
          if LText = '' then
          begin
            Inc(LImageRect.Top, 20);
            Inc(LImageRect.Left, 20);
            Dec(LImageRect.Bottom, 20);
            Dec(LImageRect.Right, 20);
          end;
          LPicture.LoadFromFile(LImageFile);
          if Assigned(LPicture.Graphic) and (not LPicture.Graphic.Empty) then
          begin
            ControlCanvas.StretchDraw(LImageRect, LPicture.Graphic);
          end;
        except
          on E: Exception do
            LText := E.Message;
        end;
        LPicture.Free;
      end;
      if LText <> '' then
      begin
        LText := LText + #13#10'Fallback to ';
      end;
      LText := LText + 'file="' + ImageFile + '"';
    end else
    if ImageSrc <> '' then
    begin
      if LText <> '' then
      begin
        LText := LText + #13#10'Fallback to ';
      end;
      LText := LText + 'src="' + ImageSrc + '"';
    end;
  end;

  if LText <> '' then
  begin
    Inc(LRect.Top, 5);
    Inc(LRect.Left, 5);
    Dec(LRect.Bottom, 5);
    Dec(LRect.Right, 5);
    ControlCanvas.Brush.Style := bsClear;
    ControlCanvas.Font.Name := CNST_PROPORTIONALFONT;
    ControlCanvas.Font.Color := clGray;
    ControlCanvas.TextRect(LRect, LText, []);
  end;
end;

destructor TIWBS4StringProperty.Destroy;
begin
  FreeAndNil(FStrings);

  inherited;
end;

function TIWBS4StringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paReadOnly];
end;

function TIWBS4StringProperty.GetStrings: TStrings;
begin
  if FStrings = nil then
  begin
    FStrings := TStringList.Create;
  end;
  FStrings.Text := GetStrValue;
  Result := FStrings;
end;

function TIWBS4StringProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TIWBS4StringProperty.SetStrings(const Value: TStrings);
begin
  SetStrValue(TrimRight(Value.Text));
end;

procedure TIWBS4StringProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

procedure Register;
begin
  RegisterComponents('IW Bootstrap4', [TIWBS4LayoutMgr]);

  RegisterComponents('IW Bootstrap4', [TIWBS4Region]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Region, 'RenderInvisibleControls'); // has no meaning in IWBS4
    UnlistPublishedProperty(TIWBS4Region, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Region, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4Region, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Region, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Region, 'HelpType');
    UnlistPublishedProperty(TIWBS4Region, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Region, 'ParentCustomHint');
  //UnlistPublishedProperty(TIWBS4Region, 'ShowHint');
    UnlistPublishedProperty(TIWBS4Region, 'ParentShowHint');
    UnlistPublishedProperty(TIWBS4Region, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Region, 'Cursor');
    UnlistPublishedProperty(TIWBS4Region, 'Hint');
    UnlistPublishedProperty(TIWBS4Region, 'Margins');
    UnlistPublishedProperty(TIWBS4Region, 'AlignWithMargins');
  RegisterComponents('IW Bootstrap4', [TIWBS4Block]);
  RegisterComponents('IW Bootstrap4', [TIWBS4Inline]);
//RegisterComponents('IW Bootstrap4', [TIWBS4Header]); // has a major bug, use BlockText instead

  RegisterComponents('IW Bootstrap4', [TIWBS4Alert]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Alert, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Alert, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4Alert, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Alert, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Alert, 'HelpType');
    UnlistPublishedProperty(TIWBS4Alert, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Alert, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Alert, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Alert, 'Cursor');
    UnlistPublishedProperty(TIWBS4Alert, 'Hint');
    UnlistPublishedProperty(TIWBS4Alert, 'Margins');

  RegisterComponents('IW Bootstrap4', [TIWBS4BlockText]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4BlockText, 'BSGridOptions');
    UnlistPublishedProperty(TIWBS4BlockText, 'Hint');
    UnlistPublishedProperty(TIWBS4BlockText, 'CustomHint');
    UnlistPublishedProperty(TIWBS4BlockText, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4BlockText, 'Collapse');
    UnlistPublishedProperty(TIWBS4BlockText, 'CollapseVisible');
    UnlistPublishedProperty(TIWBS4BlockText, 'Margins');
    UnlistPublishedProperty(TIWBS4BlockText, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4BlockText, 'HelpContext');
    UnlistPublishedProperty(TIWBS4BlockText, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4BlockText, 'HelpType');
    UnlistPublishedProperty(TIWBS4BlockText, 'Cursor');
    UnlistPublishedProperty(TIWBS4BlockText, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4BlockText, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4BlockText, 'VertScrollBar');
  RegisterComponents('IW Bootstrap4', [TIWBS4Blockquote]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Blockquote, 'BSGridOptions');
    UnlistPublishedProperty(TIWBS4Blockquote, 'Hint');
    UnlistPublishedProperty(TIWBS4Blockquote, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Blockquote, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Blockquote, 'Collapse');
    UnlistPublishedProperty(TIWBS4Blockquote, 'CollapseVisible');
    UnlistPublishedProperty(TIWBS4Blockquote, 'Margins');
    UnlistPublishedProperty(TIWBS4Blockquote, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4Blockquote, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Blockquote, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Blockquote, 'HelpType');
    UnlistPublishedProperty(TIWBS4Blockquote, 'Cursor');
    UnlistPublishedProperty(TIWBS4Blockquote, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Blockquote, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Blockquote, 'VertScrollBar');
  RegisterComponents('IW Bootstrap4', [TIWBS4Button]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Button, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Button, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4Button, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Button, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Button, 'HelpType');
    UnlistPublishedProperty(TIWBS4Button, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Button, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Button, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Button, 'Cursor');
    UnlistPublishedProperty(TIWBS4Button, 'Hint');
    UnlistPublishedProperty(TIWBS4Button, 'ShowHint');
    UnlistPublishedProperty(TIWBS4Button, 'ParentShowHint');
    UnlistPublishedProperty(TIWBS4Button, 'Margins');
    UnlistPublishedProperty(TIWBS4Button, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4Button, 'FriendlyName');
    UnlistPublishedProperty(TIWBS4Button, 'Anchors');
  RegisterComponents('IW Bootstrap4', [TIWBS4ButtonGroup]);

  // Calendar
  RegisterComponents('IW Bootstrap4', [TIWBS4Cal]);
    UnlistPublishedProperty(TIWBS4Cal, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4Cal, 'BorderClass');
    UnlistPublishedProperty(TIWBS4Cal, 'BorderRounded');
    UnlistPublishedProperty(TIWBS4Cal, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Cal, 'Cursor');
    UnlistPublishedProperty(TIWBS4Cal, 'Hint');
    UnlistPublishedProperty(TIWBS4Cal, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Cal, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Cal, 'HorzScrollbar');
    UnlistPublishedProperty(TIWBS4Cal, 'VertScrollbar');
    UnlistPublishedProperty(TIWBS4Cal, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Cal, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Cal, 'HelpType');
    UnlistPublishedProperty(TIWBS4Cal, 'Margins');
    UnlistPublishedProperty(TIWBS4Cal, 'RenderInvisibleControls');
    UnlistPublishedProperty(TIWBS4Cal, 'TabOrder');

  // Carousel
  RegisterComponents('IW Bootstrap4', [TIWBS4Carousel]);
    UnlistPublishedProperty(TIWBS4Carousel, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Carousel, 'Cursor');
    UnlistPublishedProperty(TIWBS4Carousel, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Carousel, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Carousel, 'Margins');
    UnlistPublishedProperty(TIWBS4Carousel, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4Carousel, 'HorzScrollbar');
    UnlistPublishedProperty(TIWBS4Carousel, 'VertScrollbar');
    UnlistPublishedProperty(TIWBS4Carousel, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Carousel, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Carousel, 'HelpType');
    UnlistPublishedProperty(TIWBS4Carousel, 'Hint');
    UnlistPublishedProperty(TIWBS4Carousel, 'TabOrder');
    UnlistPublishedProperty(TIWBS4Carousel, 'Text');

  RegisterComponents('IW Bootstrap4', [TIWBS4Flexbox]);
  RegisterComponents('IW Bootstrap4', [TIWBS4FlexboxItem]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Flexbox, 'RenderInvisibleControls');
    UnlistPublishedProperty(TIWBS4Flexbox, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Flexbox, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4Flexbox, 'TabOrder');
    UnlistPublishedProperty(TIWBS4Flexbox, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4Flexbox, 'Margins');
    UnlistPublishedProperty(TIWBS4Flexbox, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Flexbox, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Flexbox, 'HelpType');
    UnlistPublishedProperty(TIWBS4Flexbox, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Flexbox, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Flexbox, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Flexbox, 'Cursor');
    UnlistPublishedProperty(TIWBS4Flexbox, 'Hint');
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'RenderInvisibleControls');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'TabOrder');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'AlignWithMargins');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'Margins');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'HelpContext');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'HelpType');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'CustomHint');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'Cursor');
    UnlistPublishedProperty(TIWBS4FlexboxItem, 'Hint');

  RegisterComponents('IW Bootstrap4', [TIWBS4List]);

  {$WARNINGS OFF}
//RegisterComponents('IW Bootstrap4', [TIWBS4UnorderedList]);
  {$WARNINGS ON}

  RegisterComponents('IW Bootstrap4', [TIWBS4NavBar]);
  RegisterComponents('IW Bootstrap4', [TIWBS4NavBarHeader]);
  RegisterComponents('IW Bootstrap4', [TIWBS4NavBarCollapse]);

  RegisterComponents('IW Bootstrap4', [TIWBS4Progress]);

  RegisterComponents('IW Bootstrap4', [TIWBS4Table]);
    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4Table, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4Table, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4Table, 'HelpContext');
    UnlistPublishedProperty(TIWBS4Table, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4Table, 'HelpType');
    UnlistPublishedProperty(TIWBS4Table, 'CustomHint');
    UnlistPublishedProperty(TIWBS4Table, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4Table, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4Table, 'Cursor');
    UnlistPublishedProperty(TIWBS4Table, 'Hint');
    UnlistPublishedProperty(TIWBS4Table, 'Margins');

  RegisterComponents('IW Bootstrap4', [TIWBS4Text]);
//RegisterComponents('IW Bootstrap4', [TIWBS4Glyphicon]);


// FORMS AND INPUT ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  RegisterComponents('Bootstrap4 Forms', [TIWBS4InputForm]);

  RegisterComponents('Bootstrap4 Forms', [TIWBS4Switch]);

  RegisterComponents('Bootstrap4 Forms', [TIWBS4CheckBox]);

  // CaleranInput requires license to https://codecanyon.net/item/caleran-date-range-picker/19454049
  RegisterComponents('Bootstrap4 Forms', [TIWBS4DateCaleranInput]);
//RegisterComponents('Bootstrap4 Forms', [TIWBS4DescribedBy]); deprecated, probably will delete it
  RegisterComponents('Bootstrap4 Forms', [TIWBS4DropDown]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4Input]);
//RegisterComponents('Bootstrap4 Forms', [TIWBS4InputFormJacked]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4Label]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4Memo]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4MemoHtml]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4RadioButton]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4RadioGroup]);
  
  // RangeSliderInput requires js/css file references from http://ionden.com/a/plugins/ion.rangeSlider/
  RegisterComponents('Bootstrap4 Forms', [TIWBS4RangeSliderInput]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4Select]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4FormGroup]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4InputGroup]);

  // Modal - Loren renamed Modal classes to Moab
  RegisterComponents('Bootstrap4 Forms', [TIWBS4Moab]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4MoabDialog]);
  RegisterComponents('Bootstrap4 Forms', [TIWBS4MoabContent]);


    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4InputForm, 'BSGridOptions');
    UnlistPublishedProperty(TIWBS4InputForm, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4InputForm, 'Cursor');
    UnlistPublishedProperty(TIWBS4InputForm, 'CustomHint');
    UnlistPublishedProperty(TIWBS4InputForm, 'HelpContext');
    UnlistPublishedProperty(TIWBS4InputForm, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4InputForm, 'HelpType');
    UnlistPublishedProperty(TIWBS4InputForm, 'Hint');
    UnlistPublishedProperty(TIWBS4InputForm, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4InputForm, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4InputForm, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4InputForm, 'RenderInvisibleControls');
    UnlistPublishedProperty(TIWBS4InputForm, 'RawText');
    UnlistPublishedProperty(TIWBS4InputForm, 'Text');
    UnlistPublishedProperty(TIWBS4InputForm, 'Margins');
    UnlistPublishedProperty(TIWBS4InputForm, 'AlignWithMargins');

    // Get rid of Grid Options -- not needed here
    UnlistPublishedProperty(TIWBS4FormGroup, 'HorzScrollBar');
    UnlistPublishedProperty(TIWBS4FormGroup, 'VertScrollBar');
    UnlistPublishedProperty(TIWBS4FormGroup, 'HelpContext');
    UnlistPublishedProperty(TIWBS4FormGroup, 'HelpKeyword');
    UnlistPublishedProperty(TIWBS4FormGroup, 'HelpType');
    UnlistPublishedProperty(TIWBS4FormGroup, 'CustomHint');
    UnlistPublishedProperty(TIWBS4FormGroup, 'ParentCustomHint');
    UnlistPublishedProperty(TIWBS4FormGroup, 'ClipRegion');
    UnlistPublishedProperty(TIWBS4FormGroup, 'Cursor');
    UnlistPublishedProperty(TIWBS4FormGroup, 'Hint');
    UnlistPublishedProperty(TIWBS4FormGroup, 'Margins');

  RegisterPropertyEditor(TypeInfo(string), TIWBS4FontAwesomeIcon, 'FontAwesomeIcon', TFontAwesomeEditor);
  RegisterPropertyEditor(TypeInfo(string), TIWBS4GoogleMaterialIcon, 'GoogleMaterialIcon', TGoogleIconsEditor);

  RegisterComponents('IW Bootstrap4', [TIWBS4Image]);

  RegisterComponents('IW Bootstrap4', [TIWBS4File]);

  RegisterComponents('IW Bootstrap4', [TIWBS4TabControl]);

  RegisterPropertyEditor(TypeInfo(string), TIWBS4CustomRegion, 'Text', TIWBS4StringProperty);
//RegisterPropertyEditor(TypeInfo(string), TIWBS4CustomButton, 'BSGlyphicon', TGlyphiconEditor);
  RegisterPropertyEditor(TypeInfo(string), TIWBS4CustomButton, 'FontAwesome', TFontAwesomeEditor);
  RegisterPropertyEditor(TypeInfo(string), TIWBS4CustomButton, 'GoogleMaterial', TGoogleIconsEditor);
  RegisterPropertyEditor(TypeInfo(string), TIWBS4CustomButton, 'Caption', TIWBS4StringProperty);

  UnlistPublishedProperty(TIWBS4CustomControl, 'SkinId');
  UnlistPublishedProperty(TIWBS4CustomControl, 'StyleRenderOptions');

  UnlistPublishedProperty(TIWBS4CustomRegion, 'TabOrder');
  UnlistPublishedProperty(TIWBS4CustomRegion, 'OnAlignInsertBefore');
  UnlistPublishedProperty(TIWBS4CustomRegion, 'OnAlignPosition');

  UnlistPublishedProperty(TIWBS4TabControl, 'ActiveTabFont');
  UnlistPublishedProperty(TIWBS4TabControl, 'InactiveTabFont');
  UnlistPublishedProperty(TIWBS4TabControl, 'ActiveTabColor');
  UnlistPublishedProperty(TIWBS4TabControl, 'InactiveTabColor');

  RegisterComponentEditor(TIWBS4Region, TIWControlTabOrderEditor);
  RegisterComponentEditor(TIWBS4CustomDbControl, TIWControlTabOrderEditor);
end;

function TGoogleIconsEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TGoogleIconsEditor.GetValues(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to slGoogleMaterial.Count - 1 do
  begin
    Proc(slGoogleMaterial.Names[i]);
  end;
end;

procedure TGoogleIconsEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

initialization
  slFontAwesome := TStringList.Create;
  slFontAwesome.Text :=
    AWESOME_ICONS1 + AWESOME_ICONS2 + AWESOME_ICONS3 + AWESOME_ICONS4 +
    AWESOME_ICONS5 + AWESOME_ICONS6 + AWESOME_ICONS7 + AWESOME_ICONS8;
  slGoogleMaterial := TStringList.Create;
  slGoogleMaterial.Text :=
    GOOGLE_ICONS1 + GOOGLE_ICONS2 + GOOGLE_ICONS3 + GOOGLE_ICONS4 + GOOGLE_ICONS5 +
    GOOGLE_ICONS6 + GOOGLE_ICONS7 + GOOGLE_ICONS8 + GOOGLE_ICONS9 + GOOGLE_ICONS10;

  IWRegisterPaintHandler('TIWBS4Region', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4Block', TIWBS4PaintHandlerBlock);
  IWRegisterPaintHandler('TIWBS4Inline', TIWBS4PaintHandlerInline);
  IWRegisterPaintHandler('TIWBS4BlockText', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4Blockquote', TIWBS4PaintHandlerBlockquote);
  IWRegisterPaintHandler('TIWBS4Table', TIWBS4PaintHandlerTable);
  IWRegisterPaintHandler('TIWBS4Alert', TIWBS4PaintHandlerAlert);
  IWRegisterPaintHandler('TIWBS4InputGroup', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4FormGroup', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4UnorderedList', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4ModalOld', TIWBS4PaintHandlerRegion);


  // New forms/inputs
  IWRegisterPaintHandler('TIWBS4InputForm', TIWBS4PaintHandlerInputForm);
  IWRegisterPaintHandler('TIWBS4CheckBoxOld', TIWBS4PaintHandlerCustomCheck);
  IWRegisterPaintHandler('TIWBS4RadioButtonOld', TIWBS4PaintHandlerCustomCheck);
  IWRegisterPaintHandler('TIWBS4DateCaleranInput', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4Input', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4Memo', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4MemoHtml', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4RangeSliderInput', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4Select', TIWBS4PaintHandlerCustomInput);
  IWRegisterPaintHandler('TIWBS4RadioGroup', TIWBS4PaintHandlerRadioGroup);


  IWRegisterPaintHandler('TIWBS4List', TIWBS4PaintHandlerRegion);

  IWRegisterPaintHandler('TIWBS4ButtonGroup', TIWBS4PaintHandlerRegion);

 {IWRegisterPaintHandler('TIWBS4NavBar', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4NavBarHeader', TIWBS4PaintHandlerRegion);
  IWRegisterPaintHandler('TIWBS4NavBarCollapse', TIWBS4PaintHandlerRegion);}

  IWRegisterPaintHandler('TIWBS4Button', TIWBS4PaintHandlerCustomButton);

  IWRegisterPaintHandler('TIWBS4DropDown', TIWBS4PaintHandlerCustomButton);

  IWRegisterPaintHandler('TIWBS4Label', TIWBS4PaintHandlerLabel);

//IWRegisterPaintHandler('TIWBS4Glyphicon', TIWBS4PaintHandlerGlyphicon);

  IWRegisterPaintHandler('TIWBS4Text', TIWBS4PaintHandlerText);

  IWRegisterPaintHandler('TIWBS4Image', TIWBS4PaintHandlerImage);
  IWRegisterPaintHandler('TIWBS4Carousel', TIWBS4PaintHandlerCarousel);
  IWRegisterPaintHandler('TIWBS4Flexbox', TIWBS4PaintHandlerFlexbox);
  IWRegisterPaintHandler('TIWBS4FlexboxItem', TIWBS4PaintHandlerFlexboxItem);

  IWRegisterPaintHandler('TIWBS4File', TIWBS4PaintHandlerFile);

  IWRegisterPaintHandler('TIWBS4TabControl', TIWPaintHandlerTabControl);

finalization
  slFontAwesome.Free;
  slGoogleMaterial.Free;

  IWUnRegisterPaintHandler('TIWBS4Region');
  IWUnRegisterPaintHandler('TIWBS4Block');
  IWUnRegisterPaintHandler('TIWBS4Inline');
  IWUnRegisterPaintHandler('TIWBS4BlockText');
  IWUnRegisterPaintHandler('TIWBS4Blockquote');
  IWUnRegisterPaintHandler('TIWBS4Table');
  IWUnRegisterPaintHandler('TIWBS4Alert');
  IWUnRegisterPaintHandler('TIWBS4InputGroup');
  IWUnRegisterPaintHandler('TIWBS4FormGroup');
  IWUnRegisterPaintHandler('TIWBS4UnorderedList');
  IWUnRegisterPaintHandler('TIWBS4ModalOld');


  // New inputs/forms
  IWUnRegisterPaintHandler('TIWBS4InputForm');
  IWUnRegisterPaintHandler('TIWBS4CheckBoxOld');
  IWUnRegisterPaintHandler('TIWBS4RadioButtonOld');
  IWUnRegisterPaintHandler('TIWBS4DateCaleranInput');
  IWUnRegisterPaintHandler('TIWBS4Input');
  IWUnRegisterPaintHandler('TIWBS4Memo');
  IWUnRegisterPaintHandler('TIWBS4MemoHtml');
  IWUnRegisterPaintHandler('TIWBS4RangeSliderInput');
  IWUnRegisterPaintHandler('TIWBS4Select');
  IWUnRegisterPaintHandler('TIWBS4RadioGroup');


  IWUnRegisterPaintHandler('TIWBS4List');

  IWUnRegisterPaintHandler('TIWBS4ButtonGroup');

 {IWUnRegisterPaintHandler('TIWBS4NavBar');
  IWUnRegisterPaintHandler('TIWBS4NavBarHeader');
  IWUnRegisterPaintHandler('TIWBS4NavBarCollapse');}

  IWUnRegisterPaintHandler('TIWBS4Button');
  IWUnRegisterPaintHandler('TIWBS4DropDown');

  IWUnRegisterPaintHandler('TIWBS4Label');

//IWUnRegisterPaintHandler('TIWBS4Glyphicon');

  IWUnRegisterPaintHandler('TIWBS4Text');

  IWUnRegisterPaintHandler('TIWBS4Image');
  IWUnRegisterPaintHandler('TIWBS4Carousel');
  IWUnRegisterPaintHandler('TIWBS4Flexbox');
  IWUnRegisterPaintHandler('TIWBS4FlexboxItem');

  IWUnRegisterPaintHandler('TIWBS4TabControl');

end.
