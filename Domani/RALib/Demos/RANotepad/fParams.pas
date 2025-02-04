
{$INCLUDE RA.INC}

unit fParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, RARegAuto, StdCtrls, ColorGrd, RAEditor, RAHLEditor;

type
  TParamsForm = class(TForm)
    Pages: TPageControl;
    bCancel: TButton;
    bOK: TButton;
    tsEditor: TTabSheet;
    Label1: TLabel;
    cbKeyboardLayot: TComboBox;
    gbEditor: TGroupBox;
    cbUndoAfterSave: TCheckBox;
    cbDoubleClickLine: TCheckBox;
    cbKeepTrailingBlanks: TCheckBox;
    cbSytaxHighlighting: TCheckBox;
    cbAutoIndent: TCheckBox;
    cbSmartTab: TCheckBox;
    cbBackspaceUnindents: TCheckBox;
    cbGroupUndo: TCheckBox;
    cbCursorBeyondEOF: TCheckBox;
    eTabStops: TEdit;
    Label2: TLabel;
    tsColors: TTabSheet;
    Label3: TLabel;
    cbColorSettings: TComboBox;
    Label4: TLabel;
    lbElements: TListBox;
    Label5: TLabel;
    ColorGrid: TColorGrid;
    GroupBox1: TGroupBox;
    cbBold: TCheckBox;
    cbItalic: TCheckBox;
    cbUnderline: TCheckBox;
    GroupBox2: TGroupBox;
    cbDefForeground: TCheckBox;
    cbDefBackground: TCheckBox;
    raColorSamples: TRegAuto;
    Label6: TLabel;
    RegAuto1: TRegAuto;
    procedure FormCreate(Sender: TObject);
    procedure NotImplemented(Sender: TObject);
    procedure lbElementsClick(Sender: TObject);
    procedure lbElementsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ColorChanged(Sender: TObject);
    procedure cbColorSettingsChange(Sender: TObject);
    procedure DefClick(Sender: TObject);
    procedure RegAuto1AfterSave(Sender: TObject);
    procedure RegAuto1AfterLoad(Sender: TObject);
  private
    { Private declarations }
    RAHLEditor1: TRAHLEditor;
    FHighlighter: THighlighter;
    FRegAuto: TRegAuto;
    SC: TSymbolColor;
    InChanging: boolean;
  public
    { Public declarations }
  end;

  TParams = class
  public
    DoubleClickLine    : boolean;
    UndoAfterSave      : boolean;
    KeepTrailingBlanks : boolean;
    AutoIndent         : boolean;
    SmartTab           : boolean;
    BackspaceUnindents : boolean;
    GroupUndo          : boolean;
    CursorBeyondEOF    : boolean;
    SytaxHighlighting  : boolean;
    TabStops  : string;
    RightMargin: integer;

    constructor Create;
    destructor Destroy; override;
    procedure Save(ARegAuto : TRegAuto);
    procedure Restore(ARegAuto : TRegAuto);
    procedure LoadColors(ARegAuto : TRegAuto; const Section: string;
      ARAHLEditor: TRAHLEditor);
    procedure SaveColors(ARegAuto : TRegAuto; const Section: string;
      ARAHLEditor: TRAHLEditor);
  end;

  function Show(ARegAuto: TRegAuto; AHighlighter: THighlighter;
    const EditorPagesOnly : boolean) : boolean;

const
  HighLighters: array[THighLighter] of string = (
    'None', 'Pascal', 'CBuilder', 'Sql', 'Python', 'Java', 'VB', 'Html', 'Perl');

var
  Params : TParams;


implementation

uses RAUtils;

{$R *.DFM}

type
  TSampleViewer = class(TRAHLEditor)
  private
    TmpEd: TRAHLEditor;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TParams.Create;
begin
 {default settings}
  DoubleClickLine := false;
  UndoAfterSave := true;
  KeepTrailingBlanks := true;
  AutoIndent         := true;
  SmartTab           := true;
  BackspaceUnindents := true;
  GroupUndo          := true;
  CursorBeyondEOF    := false;
  SytaxHighlighting  := true;
  TabStops := '3 5';
  RightMargin := 80;
end;

destructor TParams.Destroy;
begin
end;

procedure TParams.Save(ARegAuto : TRegAuto);
begin
  with ARegAuto do
  begin
    WriteBool('Params', 'DoubleClickLine'   , DoubleClickLine   );
    WriteBool('Params', 'UndoAfterSave'     , UndoAfterSave     );
    WriteBool('Params', 'KeepTrailingBlanks', KeepTrailingBlanks);
    WriteBool('Params', 'AutoIndent', AutoIndent        );
    WriteBool('Params', 'SmartTab', SmartTab          );
    WriteBool('Params', 'BackspaceUnindents', BackspaceUnindents);
    WriteBool('Params', 'GroupUndo', GroupUndo         );
    WriteBool('Params', 'CursorBeyondEOF', CursorBeyondEOF   );
    WriteBool('Params', 'SytaxHighlighting', SytaxHighlighting );
    WriteString('Params', 'TabStops'        , TabStops          );
    WriteInteger('Params', 'RightMargin', RightMargin);
  end
end;

procedure TParams.Restore(ARegAuto : TRegAuto);
begin
  with ARegAuto do
  begin
    DoubleClickLine    := ReadBool('Params', 'DoubleClickLine'   , DoubleClickLine   );
    UndoAfterSave      := ReadBool('Params', 'UndoAfterSave'     , UndoAfterSave     );
    KeepTrailingBlanks := ReadBool('Params', 'KeepTrailingBlanks', KeepTrailingBlanks);
    AutoIndent := ReadBool('Params', 'AutoIndent', AutoIndent);
    SmartTab := ReadBool('Params', 'SmartTab', SmartTab);
    BackspaceUnindents := ReadBool('Params', 'BackspaceUnindents', BackspaceUnindents);
    GroupUndo := ReadBool('Params', 'GroupUndo', GroupUndo);
    CursorBeyondEOF := ReadBool('Params', 'CursorBeyondEOF', CursorBeyondEOF);
    SytaxHighlighting := ReadBool('Params', 'SytaxHighlighting', SytaxHighlighting);
    TabStops := ReadString('Params', 'TabStops'        , TabStops          );
    RightMargin := ReadInteger('Params', 'RightMargin', RightMargin);
  end
end;
procedure TParams.SaveColors(ARegAuto : TRegAuto; const Section: string;
  ARAHLEditor: TRAHLEditor);

  procedure SaveColor(AColor: TSymbolColor; const Prefix: string);
  begin
    ARegAuto.WriteString(Section, Prefix, ColorToString(AColor.ForeColor) +
      ', ' + ColorToString(AColor.BackColor) +
      ', ' + IntToStr(byte(AColor.Style)));
  end;

begin
  ARegAuto.WriteString(Section, 'BackColor', ColorToString(ARAHLEditor.Color));
  ARegAuto.WriteString(Section, 'FontName', ARAHLEditor.Font.Name);
  ARegAuto.WriteInteger(Section, 'FontSize', ARAHLEditor.Font.Size);
  ARegAuto.WriteString(Section, 'RightMarginColor', ColorToString(ARAHLEditor.RightMarginColor));
  SaveColor(ARAHLEditor.Colors.Number      , 'Number');
  SaveColor(ARAHLEditor.Colors.Strings     , 'Strings');
  SaveColor(ARAHLEditor.Colors.Symbol      , 'Symbol');
  SaveColor(ARAHLEditor.Colors.Comment     , 'Comment');
  SaveColor(ARAHLEditor.Colors.Reserved    , 'Reserved');
  SaveColor(ARAHLEditor.Colors.Identifer   , 'Identifer');
  SaveColor(ARAHLEditor.Colors.Preproc     , 'Preproc');
  SaveColor(ARAHLEditor.Colors.FunctionCall, 'FunctionCall');
  SaveColor(ARAHLEditor.Colors.Declaration , 'Declaration');
  SaveColor(ARAHLEditor.Colors.Statement   , 'Statement');
  SaveColor(ARAHLEditor.Colors.PlainText   , 'PlainText');
end;

procedure TParams.LoadColors(ARegAuto : TRegAuto; const Section: string;
  ARAHLEditor: TRAHLEditor);

  procedure LoadColor(AColor: TSymbolColor; DefaultForeColor,
    DefaultBackColor: TColor; DefaultStyle: TFontStyles; const Prefix: string);
  var
    S, S1: string;
  begin
    S := ARegAuto.ReadString(Section, Prefix, ColorToString(DefaultForeColor) +
      ', ' + ColorToString(DefaultBackColor) +
      ', ' + IntToStr(byte(DefaultStyle)));
    S1 := Trim(SubStr(S, 0, ','));
    if S1 <> '' then
      AColor.ForeColor := StringToColor(S1)
    else
      AColor.ForeColor := DefaultForeColor;
    S1 := Trim(SubStr(S, 1, ','));
    if S1 <> '' then
      AColor.BackColor := StringToColor(S1)
    else
      AColor.BackColor := DefaultBackColor;
    S1 := Trim(SubStr(S, 2, ','));
    if S1 <> '' then
      AColor.Style := TFontStyles(byte(StrToInt(S1)))
    else
      AColor.Style := DefaultStyle;
  end;

begin
  LoadColor(ARAHLEditor.Colors.Number      , clNavy       , clWindow, [], 'Number');
  LoadColor(ARAHLEditor.Colors.Strings     , clMaroon     , clWindow, [], 'Strings');
  LoadColor(ARAHLEditor.Colors.Symbol      , clBlue       , clWindow, [], 'Symbol');
  LoadColor(ARAHLEditor.Colors.Comment     , clOlive      , clWindow, [fsItalic], 'Comment');
  LoadColor(ARAHLEditor.Colors.Reserved    , clWindowText , clWindow, [fsBold], 'Reserved');
  LoadColor(ARAHLEditor.Colors.Identifer   , clWindowText , clWindow, [], 'Identifer');
  LoadColor(ARAHLEditor.Colors.Preproc     , clGreen      , clWindow, [], 'Preproc');
  LoadColor(ARAHLEditor.Colors.FunctionCall, clWindowText , clWindow, [], 'FunctionCall');
  LoadColor(ARAHLEditor.Colors.Declaration , clWindowText , clWindow, [], 'Declaration');
  LoadColor(ARAHLEditor.Colors.Statement   , clWindowText , clWindow, [], 'Statement');
  LoadColor(ARAHLEditor.Colors.PlainText   , clWindowText , clWindow, [], 'PlainText');
  ARAHLEditor.Color := StringToColor(ARegAuto.ReadString(Section, 'BackColor', 'clWindow'));
  ARAHLEditor.Font.Name := ARegAuto.ReadString(Section, 'FontName', 'Courier New');
  ARAHLEditor.Font.Size := ARegAuto.ReadInteger(Section, 'FontSize', 10);
  ARAHLEditor.RightMarginColor := StringToColor(ARegAuto.ReadString(Section, 'RightMarginColor', 'clSilver'));
end;


function Show(ARegAuto: TRegAuto; AHighlighter: THighlighter;
  const EditorPagesOnly : boolean) : boolean;
begin
  with TParamsForm.Create(Application) do
  try
    FRegAuto := ARegAuto;
    FHighlighter := AHighlighter;
    cbDoubleClickLine   .Checked := Params.DoubleClickLine   ;
    cbUndoAfterSave     .Checked := Params.UndoAfterSave     ;
    cbKeepTrailingBlanks.Checked := Params.KeepTrailingBlanks;
    cbAutoIndent        .Checked := Params.AutoIndent        ;
    cbSmartTab          .Checked := Params.SmartTab          ;
    cbBackspaceUnindents.Checked := Params.BackspaceUnindents;
    cbGroupUndo         .Checked := Params.GroupUndo         ;
    cbCursorBeyondEOF   .Checked := Params.CursorBeyondEOF   ;
    cbSytaxHighlighting .Checked := Params.SytaxHighlighting ;
    eTabStops.Text := Params.TabStops;
    cbColorSettings.ItemIndex := Integer(FHighlighter);
    cbColorSettingsChange(nil);
    RAHLEditor1.RightMargin := Params.RightMargin;

    Result := ShowModal = mrOk;
    if Result then
    begin
      Params.DoubleClickLine    := cbDoubleClickLine   .Checked;
      Params.UndoAfterSave      := cbUndoAfterSave     .Checked;
      Params.KeepTrailingBlanks := cbKeepTrailingBlanks.Checked;
      Params.AutoIndent         := cbAutoIndent        .Checked;
      Params.SmartTab           := cbSmartTab          .Checked;
      Params.BackspaceUnindents := cbBackspaceUnindents.Checked;
      Params.GroupUndo          := cbGroupUndo         .Checked;
      Params.CursorBeyondEOF    := cbCursorBeyondEOF   .Checked;
      Params.SytaxHighlighting  := cbSytaxHighlighting .Checked;
      Params.TabStops           := eTabStops.Text;
      Params.Save(ARegAuto);
      Params.SaveColors(ARegAuto, HighLighters[RAHLEditor1.HighLighter], RAHLEditor1);
    end;
  finally
    Free;
  end;
end;

procedure TParamsForm.FormCreate(Sender: TObject);
begin
  RAHLEditor1 := TSampleViewer.Create(Self);
  RAHLEditor1.Parent := tsColors;
  RAHLEditor1.SetBounds(8, 176, 396, 110);
  RAHLEditor1.TabStop := False;
  cbKeyboardLayot.ItemIndex := 0;
  cbColorSettings.ItemIndex := 0;
  lbElements.ItemIndex := 0;
  lbElementsClick(nil);
end;

procedure TParamsForm.RegAuto1AfterSave(Sender: TObject);
begin
  RegAuto1.WriteInteger('Params', 'ActivePage', Pages.ActivePage.PageIndex);
end;

procedure TParamsForm.RegAuto1AfterLoad(Sender: TObject);
var
  F: Integer;
begin
  F := RegAuto1.ReadInteger('Params', 'ActivePage', Pages.ActivePage.PageIndex);
  if (F > -1) and (F < Pages.PageCount) and Pages.Pages[F].TabVisible then
    Pages.ActivePage := Pages.Pages[F];
end;

procedure TParamsForm.NotImplemented(Sender: TObject);
begin
  (Sender as TCheckBox).Checked := true;
  raise Exception.Create('This option can''t be changed. Sorry.');
end;


{ Color tab }

procedure TParamsForm.lbElementsClick(Sender: TObject);

  function ColorToIndex(const AColor: TColor): integer;
   {$IFNDEF RA_D4H}
  var
    FPaletteEntries: array[0..NumPaletteEntries - 1] of TPaletteEntry;
    I: Integer;
    RealColor: TColor;
   {$ENDIF}
  begin
   {$IFDEF RA_D4H}
    Result := ColorGrid.ColorToIndex(AColor);
   {$ELSE}
    { ColorGrid.ColorToIndex don't work in Delphi 3 }
    { ColorGrid.ColorToIndex none in Delphi 2 }
    GetPaletteEntries(GetStockObject(DEFAULT_PALETTE), 0, NumPaletteEntries,
      FPaletteEntries);
    Result := 0;
    I := 0;
    RealColor := ColorToRGB(AColor);
    while I < 20 do
    begin
      with FPaletteEntries[I] do
        if RealColor = TColor(RGB(peRed, peGreen, peBlue)) then Exit;
      if I <> 7 then
        Inc(I)
      else
        Inc(I, 5);
      Inc(Result);
    end;
    Result := -1;
   {$ENDIF}
  end;

var
  FC, BC: TColor;
  ST: TFontStyles;
begin
  InChanging := True;
  try
  SC := nil;
  ST := [];
  FC := clWindowText;
  BC := clWindow;
  case lbElements.ItemIndex of
    0: { Whitespace }
      begin
        FC := RAHLEditor1.Font.Color;
        BC := RAHLEditor1.Color;
      end;
    1: { Comment }
      SC := RAHLEditor1.Colors.Comment;
    2: { Reserved word }
      SC := RAHLEditor1.Colors.Reserved;
    3: { Identifer }
      SC := RAHLEditor1.Colors.Identifer;
    4: { Symbol }
      SC := RAHLEditor1.Colors.Symbol;
    5: { String }
      SC := RAHLEditor1.Colors.Strings;
    6: { Number }
      SC := RAHLEditor1.Colors.Number;
    7: { Preprocessor }
      SC := RAHLEditor1.Colors.Preproc;
    8: { Declaration }
      SC := RAHLEditor1.Colors.Declaration;
    9: { Function call }
      SC := RAHLEditor1.Colors.FunctionCall;
    10: { VB Statement }
      SC := RAHLEditor1.Colors.Statement;
    11: { PlainText }
      SC := RAHLEditor1.Colors.PlainText;
    12: { Marked block }
      begin
        FC := RAHLEditor1.SelForeColor;
        BC := RAHLEditor1.SelBackColor;
      end;
    13: { Right margin }
      begin
        FC := RAHLEditor1.RightMarginColor;
        BC := -1;
      end;
  end;
  if SC <> nil then
  begin
		FC := SC.ForeColor;
		BC := SC.BackColor;
    ST := SC.Style;
  end;
  cbDefForeground.Checked := ((lbElements.ItemIndex < 12) and (FC = clWindowText)) or
    ((lbElements.ItemIndex = 12) and (FC = clHighlightText));
  cbDefBackground.Checked := ((lbElements.ItemIndex < 12) and (BC = clWindow)) or
    ((lbElements.ItemIndex = 12) and (BC = clHighlight));
  if not cbDefForeground.Checked then
    ColorGrid.ForegroundIndex := ColorToIndex(FC)
  else
    ColorGrid.ForegroundIndex := -1;
  if not cbDefBackground.Checked then
    ColorGrid.BackgroundIndex := ColorToIndex(BC)
  else
    ColorGrid.BackgroundIndex := -1;
  cbBold.Checked := fsBold in ST;
  cbItalic.Checked := fsItalic in ST;
  cbUnderline.Checked := fsUnderline in ST;
  finally
    InChanging := False;
  end;
end;

procedure TParamsForm.ColorChanged(Sender: TObject);
var
  FC, BC: TColor;
  ST: TFontStyles;
begin
  if InChanging then Exit;
  InChanging := True;
  try
  ST := [];
  if ColorGrid.ForegroundIndex <> -1 then
    cbDefForeground.Checked := False;
  if ColorGrid.BackgroundIndex <> -1 then
    cbDefBackground.Checked := False;
	if cbDefForeground.Checked then
	begin
		if lbElements.ItemIndex = 12 then
			FC := clHighlightText
    else
			FC := clWindowText;
    ColorGrid.ForegroundIndex := -1;
	end
	else
		FC := ColorGrid.ForegroundColor;
	if cbDefBackground.Checked then
	begin
		if lbElements.ItemIndex = 12 then { marked block }
			BC := clHighlight
    else
			BC := clWindow;
    ColorGrid.BackgroundIndex := -1;
	end
	else
		BC := ColorGrid.BackgroundColor;
	if cbBold.Checked then Include(ST, fsBold);
	if cbItalic.Checked then Include(ST, fsItalic);
	if cbUnderline.Checked then Include(ST, fsUnderline);
  if SC <> nil then
  begin
    SC.Style := ST;
    SC.ForeColor := FC;
    SC.BackColor := BC;
  end
  else if lbElements.ItemIndex = 12 then { marked block }
  begin
    RAHLEditor1.SelForeColor := FC;
    RAHLEditor1.SelBackColor := BC;
  end
  else if lbElements.ItemIndex = 0 then { whitespace }
    RAHLEditor1.Color := BC
  else if lbElements.ItemIndex = 13 then { right margin }
    RAHLEditor1.RightMarginColor := FC;
  RAHLEditor1.Invalidate;
  finally
    InChanging := False;
  end;
end;

procedure TParamsForm.DefClick(Sender: TObject);
begin
  if InChanging then Exit;
  if cbDefForeground.Checked then
     ColorGrid.ForegroundIndex := -1;
  if cbDefBackground.Checked then
    ColorGrid.BackgroundIndex := -1;
  ColorChanged(nil);
end;

procedure TParamsForm.lbElementsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
	with (Control as TListBox).Canvas do  { draw on control canvas, not on the form }
	begin
    FillRect(Rect);       { clear the rectangle }
    TextOut(Rect.Left, Rect.Top, (Control as TListBox).Items[Index])  { display the text }
	end;
end;

procedure TParamsForm.cbColorSettingsChange(Sender: TObject);
begin
  if Sender <> nil then
    Params.SaveColors(FRegAuto, HighLighters[RAHLEditor1.HighLighter], RAHLEditor1);
  raColorSamples.ReadSection(cbColorSettings.Text, RAHLEditor1.Lines);
  RAHLEditor1.Highlighter := THighlighter(cbColorSettings.ItemIndex);
  Params.LoadColors(FRegAuto, HighLighters[RAHLEditor1.HighLighter], RAHLEditor1);
  lbElementsClick(nil);
end;

{
procedure TParamsForm.AssignColors(Dest, Source: TRAHLEditor);
begin
  Dest.Colors.Assign(Source.Colors);
  Dest.SelForeColor := Source.SelForeColor;
  Dest.SelBackColor := Source.SelBackColor;
  Dest.Color := Source.Color;
  Dest.RightMarginColor := Source.RightMarginColor;
end;
}

constructor TSampleViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TmpEd := TRAHLEditor.Create(Self);
  TmpEd.Visible := False;
  TmpEd.Parent := Self;
end;    { Create }

procedure TSampleViewer.WndProc(var Message: TMessage);
begin
  case Message.Msg of    { }
    {WM_LBUTTONDOWN,} WM_LBUTTONUP, WM_RBUTTONDOWN, WM_RBUTTONUP,
    WM_MOUSEMOVE, WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK :
      { nothing - prevent user interact };
    else
      inherited WndProc(Message);
  end;    { case }
end;

procedure TSampleViewer.WMLButtonDown(var Message: TWMLButtonDown);
var
  XX, YY: integer;
  F: integer;
begin
  { also prevent user interact }
  { detect symbol type }
	Mouse2Caret(Message.XPos, Message.YPos, XX, YY);
  if (XX = RightMargin) or (XX - 1 = RightMargin) then
    F := 13
  else
  begin
    TmpEd.Lines := Lines;
    TmpEd.HighLighter := HighLighter;
   { color values corresponds to lbElements ListBox }
    TmpEd.Font.Color := 0;
    TmpEd.Colors.Comment.ForeColor := 1;
    TmpEd.Colors.Reserved.ForeColor := 2;
    TmpEd.Colors.Identifer.ForeColor := 3;
    TmpEd.Colors.Symbol.ForeColor := 4;
    TmpEd.Colors.Strings.ForeColor := 5;
    TmpEd.Colors.Number.ForeColor := 6;
    TmpEd.Colors.Preproc.ForeColor := 7;
    TmpEd.Colors.Declaration.ForeColor := 8;
    TmpEd.Colors.FunctionCall.ForeColor := 9;
    TmpEd.Colors.Statement.ForeColor := 10;
    TmpEd.Colors.PlainText.ForeColor := 11;
    TmpEd.SelForeColor := 12;
    TSampleViewer(TmpEd).GetLineAttr(YY, 0, RAEditor.Max_X - 1);
    F := TSampleViewer(TmpEd).LineAttrs[XX].FC;
  end;
	(Owner as TParamsForm).lbElements.ItemIndex :=F;
  (Owner as TParamsForm).lbElementsClick((Owner as TParamsForm).lbElements);
end;

initialization
  Params := TParams.Create;
finalization
  Params.Free;
end.
