unit wwradiogroup;
{
//
// Components : TwwRadioGroup
//
// Copyright (c) 2001 by Woll2Woll Software
//
// 8/7/01 - Avoid Idx out of range related to itemindex<>0 for bound control
// 10/01/2001 - Correct typo that caused itemindex not to get stored in unbound case.
// 5/17/2002-Don't call inherited. This can cause a popupmenu item to fire in grid.
}
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwframe, dbctrls, db, wwradiobutton, wwclearbuttongroup,
  grids, imglist, wwdbgrid;

{$i wwIfDef.pas}

type
  TwwCustomRadioGroup=class;
  TwwCreateRadioButton = procedure (
    Sender: TwwCustomRadioGroup;
    RadioButton: TwwRadioButton) of object;

  TwwRGEditFrame = class(TwwEditFrame)  // Change defaults
  published
     property FocusBorders default [];
     property NonFocusBorders default [];
  end;
  TwwRGWinButtonIndents=class(TwwWinButtonIndents)
  protected
    procedure Repaint(FWinControl: TWinControl); override;
  end;

  TwwCustomRadioGroup = class(TwwCustomTransparentGroupBox)
  private
    FOnCreateRadioButton: TwwCreateRadioButton;
    FIndents: TwwWinButtonIndents;
    FFrame: TwwEditFrame;
    FButtonFrame: TwwRGEditFrame;
    FItems: TStrings;
    FItemIndex: Integer;
    FColumns: Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    FShowBorder: boolean;
    FShowGroupCaption: boolean;
    FShowFocusRect: boolean;
    FTransparentActiveItem: boolean;
    FImages: TCustomImageList;
    FGlyphImages: TCustomImageList;
    FButtons: TList;
    PaintCopyTextColor: TColor;
    FShowText: boolean;
    FFocused: boolean;
    SkipSetChildFocus: boolean;
    FWordWrap: boolean;
    FAlignment: TLeftRight;
    FNoSpacing: boolean;
    FAnyClickToggles: boolean;
    FDisableThemes: boolean;

    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    function StoreItemIndex: boolean; virtual;
    function IsTransparent: boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoCreateRadioButton(RadioButton: TwwRadioButton); virtual;
    procedure SetParent(AParent: TWinControl); override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    function HaveBorder: boolean; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemIndex: Integer read FItemIndex write SetItemIndex stored StoreItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
  public
    LastBrushColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    procedure UpdateButtons;
    property ButtonFrame: TwwRGEditFrame read FButtonFrame write FButtonFrame;
    property Frame: TwwEditFrame read FFrame write FFrame;
    property ShowBorder : boolean read FShowBorder write FShowBorder default True;
    property ShowGroupCaption : boolean read FShowGroupCaption write FShowGroupCaption default True;
    property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect default true;
    property TransparentActiveItem: boolean read FTransparentActiveItem write FTransparentActiveItem default False;
    property Images: TCustomImageList read FImages write FImages;
    property GlyphImages: TCustomImageList read FGlyphImages write FGlyphImages;
    property Indents: TwwWinButtonIndents read FIndents write FIndents;
    property OnCreateRadioButton: TwwCreateRadioButton read FOnCreateRadioButton write FOnCreateRadioButton;
    property ShowText: boolean read FShowText write FShowText default True;
    property WordWrap: boolean read FWordWrap write FWordWrap default False;
    property Alignment: TLeftRight read FAlignment write FAlignment default taRightJustify;
    property NoSpacing: boolean read FNoSpacing write FNoSpacing default False;
    property AnyClickToggles: boolean read FAnyClickToggles write FAnyClickToggles;
    property DisableThemes : boolean read FDisableThemes write FDisableThemes;
//    property Buttons : TList read FButtons;
  end;

  TwRadioGroup = class(TwwCustomRadioGroup)
  published
    property Align;
    property Anchors;
//    property AnyClickToggles; // Undocumented currently, so not published
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ButtonFrame;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowBorder;
    property ShowGroupCaption;
    property TabOrder;
    property TabStop default True;
    property Transparent;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

  TwwRadioGroup = class(TwwCustomRadioGroup)
  private
    FDataLink: TFieldDataLink;
    FValue: string;
    FValues: TStrings;
    FInSetValue: Boolean;
    FOnChange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetValues(Value: TStrings);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure SetColor(Value: TColor);
    Function GetColor: TColor;
    function IsColorStored: Boolean;
  protected
    function StoreItemIndex: boolean; override; //8/7/01
    procedure Paint; override;
    procedure Change; dynamic;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    function CanModify: Boolean; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property Value: string read FValue write SetValue;
    function GetButtonValue(Index: Integer): string;
    Function GetDisplayValue(const Value: string): string;
  published
    property DisableThemes;
    property ItemIndex;
    property TransparentActiveItem;
    property Frame;
    property ButtonFrame;
    property Indents;
    property Images;
    property GlyphImages;
    property ShowBorder;
    property ShowGroupCaption;
    property ShowFocusRect;
    property Transparent;
    property ShowText;
    property NoSpacing;

    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;

    // No clWindow default for this control as it makes clWindow ignored
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Items write SetItems;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property WordWrap;
    property Alignment;
    property Values: TStrings read FValues write SetValues;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
    property OnCreateRadioButton;
  end;

implementation

uses
   {$ifdef wwDelphi7Up}
   themes,
   {$endif}
   wwcommon;

{ TGroupButton }

type
  TGroupButton = class(TwwRadioButton)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
  protected
    function GetShowText: boolean; override;
    Function GetEffectiveChecked: boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function GetButtonIndex: integer; override;
    function GetLastBrushColor: TColor; override;
    function GetPaintCopyTextColor: TColor; override;
  public
    constructor InternalCreate(RadioGroup: TwwCustomRadioGroup);
    destructor Destroy; override;
  end;

constructor TGroupButton.InternalCreate(RadioGroup: TwwCustomRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor TGroupButton.Destroy;
begin
  TwwCustomRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

Function TGroupButton.GetEffectiveChecked: boolean;
var i: integer;
begin
   result:= Checked;
   if (csPaintCopy in ControlState) then
   begin
     if Owner is TwwRadioGroup then
       with TwwRadioGroup(Owner) do begin
          if not DataLink.Active or (DataLink.Field=nil) then exit;
          
          for i:= 0 to FButtons.count-1 do
            if FButtons[i]=self then
            begin
               result := DataLink.Field.Text = GetButtonValue(i);
               break;
            end
       end
   end;
end;

procedure TwwCustomRadioGroup.WMPaint(var Message: TWMPaint);
begin
  PaintCopyTextColor:= clNone;
  if IsInGridPaint(self) and (message.dc<>0) then
  begin
     PaintCopyTextColor:= GetTextColor(message.dc);
  end;
  inherited;
end;

procedure TGroupButton.WMPaint(var Message: TWMPaint);
begin
   inherited;
end;

procedure TGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TwwCustomRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TwwCustomRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TwwCustomRadioGroup(Parent).CanModify then Key := #0;
  end;
end;


function TGroupButton.GetButtonIndex: integer;
var i: integer;
begin
  result:=0;
  with TwwCustomRadioGroup(Owner) do begin
     for I := 0 to FButtons.Count - 1 do begin
         if FButtons[i]=self then begin
            result:=i;
            break;
         end
     end
  end
end;

procedure TGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TwwCustomRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ TCustomRadioGroup }

// Allow radiogroup embedded in grid to cycle through and exit if at ends
procedure TGroupButton.CNKeyDown(var Message: TWMKeyDown);
var key: integer;
  procedure SendToParent;
  begin
    with TwwCustomRadioGroup(parent) do
    begin
       if not wwIsClass(parent.classtype, 'TwwDBGrid') then exit;
       Parent.setFocus;

      { If grid does not have focus then SetFocus raised exception }
      if Parent.focused then  { 7/2/98 }
         PostMessage(parent.handle, WM_KEYDOWN, message.charcode, 0);
      message.charcode := 0;
    end
  end;

begin
  key:= message.charcode;

  if (key = VK_TAB) then // On tab should go to parent form's next/prev control
  begin
     // Set focus back to radiogroup so tabbing and shift-tabbing work fine
     TwwCustomRadioGroup(parent).SkipSetChildFocus:= True;
     try
        Parent.SetFocus;
     finally
        TwwCustomRadioGroup(parent).SkipSetChildFocus:= False;
     end;
  end;

  if (key in [vk_up, vk_down, vk_left, vk_right]) then
  with TwwCustomRadioGroup(parent) do
  begin
      if (key in [vk_left, vk_up]) then
      begin
          if (FButtons.count>0) and TGroupButton(FButtons[0]).Focused then
          begin
             SendToParent;
             exit; //5/17/2002-Don't call inherited.
          end
      end
      else if (key in [vk_right, vk_down]) then
      begin
          if (FButtons.count>0) and TGroupButton(FButtons[FButtons.Count-1]).Focused then
          begin
             SendToParent;
             exit; //5/17/2002-Don't call inherited.
          end;
      end;
  end;

  inherited;
end;

procedure TwwCustomRadioGroup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (key=13) or (key=vk_f2) and wwIsClass(parent.classtype, 'TwwDBGrid') then parent.setfocus;
end;

constructor TwwCustomRadioGroup.Create(AOwner: TComponent);
begin
  FFrame:= TwwEditFrame.create(self);
  inherited Create(AOwner);
  ShowFocusRect:= True;
  TabStop:= True;
  FShowText:= True;
  FIndents:= TwwRGWinButtonIndents.create(self);
  FButtonFrame:= TwwRGEditFrame.create(self);
  FButtonFrame.FocusBorders:= [];
  FButtonFrame.NonFocusBorders:= [];
  FAlignment:= taRightJustify;

  ControlStyle := [csSetCaption, csDoubleClicks];
//  ControlStyle := [csSetCaption, csDoubleClicks, csAcceptsControls];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
  FShowBorder:= True;
  FShowGroupCaption:= True;
end;

destructor TwwCustomRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  FButtonFrame.Free;
  FFrame.Free;
  FIndents.Free;
  inherited Destroy;
end;

procedure TwwCustomRadioGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TwwCustomRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft: Integer;
  TempWidth,TempHeight, TempButtonWidth, TempButtonHeight : integer;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    TempWidth:= Width;
    if (HaveBorder) then TempWidth:= TempWidth - 7;
    if (not ButtonFrame.enabled) then TempWidth:= TempWidth - 4;
    if NoSpacing then
    begin
       if Frame.Enabled then  TempWidth:= TempWidth - 2;
       ButtonWidth := (TempWidth div FColumns);  // 1 less so right-border has space for framing
    end
    else begin
       ButtonWidth := ((TempWidth-1) div FColumns) - 1;  // 1 less so right-border has space for framing
       if Frame.Enabled then ButtonWidth:= ButtonWidth - 2;
    end;

    if HaveBorder then
    begin
       if ShowGroupCaption then
       begin
          I := Height - Metrics.tmHeight - 5;
          ButtonHeight := I div ButtonsPerCol;
          TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2
       end
       else begin
          I := Height - 5;
          ButtonHeight := I div ButtonsPerCol;
          TopMargin := 2 + (I mod ButtonsPerCol) div 2
       end;
    end
    else begin
//       I := Height - 3;
       if NoSpacing then i:= Height
       else I:= Height - 3;
       if Frame.Enabled then I:= I - 2;
       ButtonHeight := I div ButtonsPerCol;
       TopMargin := 2;//(I mod ButtonsPerCol) div 2;
    end;
    TempHeight:= i;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + 9; { At least left =1}
          if not HaveBorder and Frame.Enabled then
             ALeft:= ALeft + 1;
          if ButtonFrame.enabled then ALeft:= ALeft - 4;
          if (not HaveBorder) then ALeft:= ALeft - 4;

          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;
          //!!! PYW Shortened Buttonwidth or they touch the right edge.  Also made the ButtonHeight a tad smaller.
          Frame.AssignAll(FButtonFrame);
          WordWrap:= self.WordWrap;
          Alignment:= self.Alignment;
          if (self.parent is TCustomGrid) or IsTransparent then
          begin
             Frame.Enabled:= True;
//             if (not ButtonFrame.Transparent) and not (parent is TCustomGrid) then
//              Frame.Transparent:= False; //Transparent;
             if parent is TCustomGrid then
                Frame.Transparent:=False
             else if IsTransparent then
                Frame.Transparent:= True;
          end;
          if self.TransparentActiveItem and Transparent then AlwaysTransparent:= True;
          Images:= self.images;
          ShowFocusRect:= self.ShowFocusRect;
          GlyphImages:= self.GlyphImages;
          Indents.assign(self.indents);
          DoCreateRadioButton(FButtons[i]);

          if NoSpacing and ((i >=(ButtonsPerCol*(FColumns-1)))) then
             TempButtonWidth:= TempWidth - (ButtonWidth * (FColumns-1))
          else
             TempButtonWidth:= ButtonWidth;

          if NoSpacing and ((i mod ButtonsPerCol) = ButtonsPerCol-1)then
             TempButtonHeight:= TempHeight - (ButtonHeight * (ButtonsPerCol-1))
          else
             TempButtonHeight:= ButtonHeight;

          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            TempButtonWidth{-4}, TempButtonHeight{-1},
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TwwCustomRadioGroup.DoCreateRadioButton(RadioButton: TwwRadioButton);
begin
   if Assigned(FOnCreateRadioButton) then
      FOnCreateRadioButton(Self, RadioButton);
end;

procedure TwwCustomRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
    if Transparent {and ButtonFrame.Transparent }then Invalidate;
  end;
end;

procedure TwwCustomRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
    UpdateButtons;
  end;
end;

procedure TwwCustomRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TwwCustomRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TwwCustomRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do TGroupButton.InternalCreate(Self);
  while FButtons.Count > Value do TGroupButton(FButtons.Last).Free;
end;

procedure TwwCustomRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TwwCustomRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TGroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        TGroupButton(FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure TwwCustomRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TwwCustomRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
    TGroupButton(FButtons[I]).Caption := FItems[I];
  if (FItemIndex >= 0) and (FItemIndex<FButtons.Count) then // 8/7/01 - Avoid Idx out of range
  begin
    FUpdating := True;
    TGroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TwwCustomRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TwwCustomRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TwwCustomRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TwwCustomRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TwwCustomRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to ControlCount - 1 do
  begin
    Control := Controls[I];
    if Control is TwwRadioButton then exit;
    if Control.Owner = Root then Proc(Control);
  end;
end;

procedure TwwCustomRadioGroup.SetParent(AParent: TWinControl);
begin
   inherited;
   if AParent <>nil then
      ArrangeButtons;
end;

type
  TwwCheatGridCast = class(TwwDBGrid);

procedure TwwRadioGroup.Paint;
var r: TRect;
  function DrawHighlight: boolean;
  begin
     result:= False;
     if wwIsClass(parent.classtype, 'TwwDBGrid') then begin
       result:= parent.focused and
                not wwInPaintCopyState(ControlState)
     end
  end;
begin
   LastBrushColor:= clNone;

   if (parent is TCustomGrid) and not (csPaintCopy in ControlState)
      and parent.focused then
   begin
      r:= ClientRect;
      Canvas.Brush.Color:= Color;
      if DrawHighlight then begin
         Canvas.Brush.Color := clHighlight;
         Canvas.Font.Color := clHighlightText;
      end;

      {  Honor grid's colors when painting cell }
      if DrawHighlight and (wwIsClass(parent.classtype, 'TwwCustomDBGrid')) then
      begin
         if (DataLink.Field<>nil) then
             TwwCheatGridCast(Parent).DoCalcCellColors(GetField, [], True, Canvas.Font, Canvas.Brush);
      end;

      Canvas.FillRect(r);
      LastBrushColor:= Canvas.Brush.Color;
      if DrawHighlight then
      begin
        r:= ClientRect;
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color := clHighlightText;
        Canvas.Pen.Color:= clHighlight;
        Canvas.FrameRect(r);
        SetTextColor(Canvas.Handle, ColorToRGB(clHighlightText));
        SetBkColor(Canvas.Handle, ColorToRGB(clHighlight));
        Canvas.DrawFocusRect(r);
      end
   end;
   inherited;
end;

procedure TwwCustomRadioGroup.Paint;
var
  H: Integer;
  TempRect, R, TextR: TRect;
  Flags: Longint;
  Text: string;
  StartText, EndText: integer;

  {$ifdef wwDelphi7Up}
  Details: TThemedElementDetails;
  CheckboxStyle: TThemedButton;
  PaintRect: TRect;
  CaptionRect: TRect;
  {$endif}

  Function GetRect: TRect;
  begin
     with Canvas do begin
       Font := Self.Font;
       if not ShowGroupCaption then
         H:= 2
       else
         H := TextHeight('0');
       Result := Rect(0, H div 2 - 1, Width, Height);
     end;
  end;

begin
   // 4/15/01 - Back-color support
   if (Frame.Enabled and (not Frame.Transparent)) and
      (not FFocused) and (Frame.NonFocusColor<>clNone) then
  begin
     Canvas.Brush.Color:= Frame.NonFocusColor;
     tempRect:= ClientRect;
//     tempRect.Top:= GetRect.Top;
     Canvas.FillRect(tempRect);
  end;

  if not HaveBorder then begin
     if Frame.Enabled then
      wwDrawEdge(self, Frame, Canvas, FFocused);
     exit;
  end;


   Text:= Caption;
   if Text='' then exit;

   if not ShowGroupCaption then
      H:= 2
   else
      H:= Canvas.TextHeight('0');

   if UseRightToLeftAlignment then
   begin
      R:= GetRect; // 7/8/02 - Not initialized before
      TextR := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
      TextR.Left:= TextR.left - 2;
   end
   else
      TextR := Rect(8, 0, 0, H);

   with Canvas do begin
     R:= GetRect;
     if not ShowGroupCaption then begin
        StartText:= 0;
        EndText:= 0;
     end
     else begin
        StartText:= TextR.Left;
        EndText:= TextR.Left + Canvas.TextWidth(Text);
     end;

     if wwUseThemes(self) then
     begin
       {$ifdef wwDelphi7Up}
       if self.enabled then CheckboxStyle:= tbGroupBoxNormal
       else CheckboxStyle:= tbGroupBoxDisabled;
       Details := ThemeServices.GetElementDetails(CheckboxStyle);
       PaintRect := R;
       CaptionRect:= Rect(StartText-1, TextR.top, EndText+1, TextR.Bottom);
       with CaptionRect do
          ExcludeClipRect(Handle, Left, Top, Right, Bottom);
       ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);

       //Paint background over lines just drawn
//       ThemeServices.DrawParentBackground(self.Handle, Canvas.Handle, @Details, False, @TempTextRect)

       SelectClipRgn(Handle, 0);
       if Text <> '' then
          ThemeServices.DrawText(Handle, Details, Text, CaptionRect, DT_LEFT, 0);
       exit;
       {$endif}
     end
     else begin
       if Ctl3D then
       begin
         Inc(R.Left);
         Inc(R.Top);
         Brush.Color := clBtnHighlight;
         Pen.Color:= clBtnHighlight;
         if not ShowGroupCaption then begin
            PolyLine([Point(0, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
                 Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
                 Point(0, r.top)]);
         end
         else begin
            PolyLine([Point(TextR.Left, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
                   Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
                 Point(TextR.Left + Canvas.TextWidth(Text), r.top)]);
         end;
         OffsetRect(R, -1, -1);
         Brush.Color := clBtnShadow;
         Pen.Color:= clBtnShadow;
       end else
         Brush.Color := clWindowFrame;
       PolyLine([Point(StartText, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
               Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
               Point(EndText, r.top)]);
     end;
   end;

   if not UseRightToLeftAlignment then
     R := Rect(8, 0, 0, H)
   else
     R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
   Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);

   if not ShowGroupCaption then exit;
   with Canvas do begin
      SetBkMode(Handle, windows.TRANSPARENT);
      //      if FFrame.Transparent then
      DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
{      if (not Transparent) then
      begin
         if Frame.NonFocusColor<>clNone then
            Brush.Color:= Frame.NonFocusColor
         else
            Brush.Color := Color;
      end;
}
      SetBkMode(Handle, windows.TRANSPARENT);
      DrawText(Handle, PChar(Text), Length(Text), R, Flags);
   end
end;

procedure TwwCustomRadioGroup.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if SkipSetChildFocus then exit;

  if (ItemIndex=-1) then
  begin
     if (FButtons.Count>0) then
        TGroupButton(FButtons[0]).SetFocus
     else exit
  end
  else
     TGroupButton(FButtons[ItemIndex]).SetFocus
end;

{ TDBRadioGroup }

constructor TwwRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TStringList.Create;
end;

destructor TwwRadioGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

procedure TwwRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
     if (FDataLink <> nil) and (AComponent = DataSource) then
        DataSource := nil
     else if AComponent = Images then Images := nil
     else if AComponent = GlyphImages then GlyphImages:= nil
  end;
end;

function TwwRadioGroup.UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;

procedure TwwRadioGroup.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    Value := FDataLink.Field.Text else
    Value := '';
end;

procedure TwwRadioGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then FDataLink.Field.Text := Value;
end;

function TwwRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TwwRadioGroup.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TwwRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TwwRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TwwRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TwwRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TwwRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TwwRadioGroup.GetButtonValue(Index: Integer): string;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

function TwwRadioGroup.GetDisplayValue(const Value: string): string;
var
   I: Integer;
begin
   result:= '';
   for I := 0 to Items.Count - 1 do
     if Value = GetButtonValue(I) then
     begin
       result:= TGroupButton(FButtons[i]).Caption;
       Break;
     end;
end;

procedure TwwRadioGroup.SetValue(const Value: string);
var
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;
end;

procedure TwwRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TRadioButton(Controls[ItemIndex]).SetFocus else
      TRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;

procedure TwwRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    if ItemIndex >= 0 then Value := GetButtonValue(ItemIndex);
    if FDataLink.Editing then FDataLink.Modified;
  end;
end;

procedure TwwRadioGroup.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TwwRadioGroup.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

procedure TwwRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TwwRadioGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

function TwwRadioGroup.CanModify: Boolean;
begin
  result:= inherited CanModify;
  if ReadOnly then result:= False;

  if result and (FDataLink.DataSet<>nil) then
     Result := FDataLink.Edit
end;

function TwwRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TwwRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;

Function TwwRadioGroup.GetColor: TColor;
begin
   result:= inherited Color;
end;

procedure TwwRadioGroup.SetColor(Value: TColor);
begin
   inherited Color:= Value;
end;

Function TwwRadioGroup.IsColorStored;
begin
   result:= not ParentColor;
end;

function TwwCustomRadioGroup.HaveBorder: boolean;
begin
   result:= ShowBorder and not (parent is TCustomGrid)
end;

procedure TwwRGWinButtonIndents.Repaint(FWinControl: TWinControl);
begin
//   if csDestroying in FWinControl.ComponentState then exit;

   TwwRadioGroup(FWinControl).UpdateButtons;
   if FWinControl.parent is TCustomGrid then
      FWinControl.parent.Invalidate;
end;

function TGroupButton.GetLastBrushColor: TColor;
begin
   result:= TwwRadioGroup(Owner).LastBrushColor;
end;

function TGroupButton.GetPaintCopyTextColor: TColor;
begin
   result:= TwwRAdioGroup(Owner).PaintCopyTextColor;
end;

function TGroupButton.GetShowText: boolean;
begin
   result:= TwwRadioGroup(Owner).ShowText;
end;

procedure TwwCustomRadioGroup.CMEnter(var Message: TCMEnter);
var exStyle, origStyle: longint;
begin
   FFocused:= True;
   inherited;

   if Frame.Enabled and Frame.Transparent and not Transparent then begin
     OrigStyle:= Windows.GetWindowLong(handle, GWL_EXSTYLE);
     exStyle:= OrigStyle and not WS_EX_TRANSPARENT;
     Windows.SetWindowLong(handle, GWL_EXSTYLE, exStyle);
   end;

   if Frame.Enabled then begin
      Invalidate;
//      InvalidateBorder;
   end
end;

procedure TwwCustomRadioGroup.CMExit(var Message: TCMExit);
//var exStyle, origStyle: longint;
begin
  FFocused:= False;
  inherited;
  if (Frame.Enabled and Frame.Transparent) and not Transparent then begin
     RecreateWnd;
  end;
  if Frame.Enabled then Invalidate;
end;

procedure TwwCustomRadioGroup.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if Frame.Enabled and (Frame.NonFocusColor<>clNone) and (not FFocused) then
     message.result:=1
  else if wwUseThemes(self) then
  begin
    {$ifdef wwDelphi7Up}
    if not (parent is TCustomGrid) then
    begin
      { Get the parent to draw its background into the control's background. }
      ThemeServices.DrawParentBackground(Handle, Message.DC, nil, False);
      message.result:=1;
    end
    else inherited
    {$endif}
  end
  else inherited;
end;

function TwwCustomRadioGroup.IsTransparent: boolean;
begin
   result:= inherited IsTransparent;
   if (not result) and Frame.Enabled and Frame.Transparent then
      result:= not FFocused;
end;

function TwwCustomRadioGroup.StoreItemIndex: boolean;
begin
   result:= True;
end;

function TwwRadioGroup.StoreItemIndex: boolean;
begin
   // 10/01/2001 - Correct typo that caused itemindex not to get stored in unbound case.
   result:= DataSource=nil
end;

end.
