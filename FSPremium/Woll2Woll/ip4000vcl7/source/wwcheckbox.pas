{
//
// Components : TwwCheckbox
//
// Copyright (c) 2001 by Woll2Woll Software
// 8/25/01 - Check grid's rowselect for expand button coloring in grid
// 10/10/01 - Use Leftcol instead of 0 in case indicator column is not visible
// 10/15/01 - Don't set row if datalink.dataset is nil. Fixes problem when closing expanded grid with frames.
// 3/30/2002 - In some cases we only wish to check for rowselect so focusrect will still show.  Also preserved canvas color when
//             focusrect being drawn.
// 5/29/2002 - If Databound and not active then use NullAndBlankState.
// 6/10/02 - Add new event OnCheckVisibleButton to allow
//           expand button to be hidden progmatically without calculated field
// 6/14/02 - Add new property FCenterTextVertically - Developer
//           can now disable this automatic centering mechnanism
// 6/29/02 - FCenterTextVertically default is wrong in constructor
}
unit wwcheckbox;
                     
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwframe, dbctrls, db, wwcommon, imglist, wwradiobutton, grids,
  wwdbgrid;

{$i wwIfDef.pas}

type
  TwwCustomCheckBox = class(TCustomCheckBox)
  private
    FCanvas: TControlCanvas;
    FFrame: TwwEditFrame;
    FIndents: TwwWinButtonIndents;
    FAlwaysTransparent: boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FDisplayValueChecked: string;
    FDisplayValueUnchecked: string;
    FShowFocusRect: boolean;
    FShowBoxAroundGlyph: boolean;
    FDynamicCaption: boolean;
    FImages: TCustomImageList;
    FWordWrap: boolean;

    FPaintBitmap: TBitmap;
    FPaintCanvas: TCanvas;
//    UseTempCanvas: Boolean;
    SpaceKeyPressed: boolean;
    FModified: Boolean;
//    PaintCopyState: TCheckBoxState;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FShowAsButton: boolean;
    FNullAndBlankState: TCheckBoxState;
    FShowText: boolean;
    FCenterTextVertically: boolean;
    FDisableThemes: boolean;

    function isTransparentEffective: boolean;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct); virtual;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure EMGetModify(var Message: TMessage); message EM_GETMODIFY;

    procedure SetValueChecked(const Value: string);
    procedure SetValueUnchecked(const Value: string);
    function GetDisplayValueChecked: string;
    function GetDisplayValueUnchecked: string;
    procedure SetDisplayValueChecked(const Value: string);
    procedure SetDisplayValueUnchecked(const Value: string);
    procedure ComputeTextRect(var DrawRect: TRect);
    function GetModified: Boolean;
    procedure SetModified(Value: Boolean);
    procedure SetColor(Value: TColor);
    Function GetColor: TColor;
    function IsColorStored: Boolean;

  protected
    Function GetDisplayText: string; virtual;
    Function GetExtraIndentX: integer; virtual;
    Function IsMouseInControl(CheckAreaOnly: boolean=False): boolean; virtual;
    function FillBackground: boolean; virtual;
    function GetFieldState: TCheckBoxState; virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; virtual;
    procedure PaintBorder;
    procedure DataChange(Sender: TObject); virtual;
    Function GetCanvas: TCanvas; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    function GetImageList: TImageList; virtual;
    function HideExpand: boolean; virtual;

    function GetField: TField; virtual;
    function GetAlignment: TAlignment; virtual;
    function GetDrawFlags: integer; virtual; // 8/13/02 - Don't display prefix when using TwwExpandButton
  public
     destructor Destroy; override;
     constructor Create(AOwner: TComponent); override;
     procedure ComputeGlyphRect(var DrawRect: TRect); virtual;
     property Canvas: TCanvas read GetCanvas;
     property Images: TCustomImageList read FImages write FImages;
     property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
     property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
     property Modified: Boolean read GetModified write SetModified;

  public
    property DisableThemes : boolean read FDisableThemes write FDisableThemes;
    property AlwaysTransparent: boolean read FAlwaysTransparent write FAlwaysTransparent;
    property Frame: TwwEditFrame read FFrame write FFrame;
    property Indents: TwwWinButtonIndents read FIndents write FIndents;
    property DynamicCaption: boolean read FDynamicCaption write FDynamicCaption default False;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
    property DisplayValueChecked: string read GetDisplayValueChecked write SetDisplayValueChecked;
    property DisplayValueUnchecked: string read GetDisplayValueUnchecked write SetDisplayValueUnchecked;
    property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect default true;
    property WordWrap: boolean read FWordWrap write FWordWrap default False;
    property NullAndBlankState: TCheckBoxState read FNullAndBlankState write FNullAndBlankState;
    property ShowText: boolean read FShowText write FShowText default True;
    property ShowAsButton: boolean read FShowAsButton write FShowAsButton default False;
    property ShowBoxAroundGlyph: boolean read FShowBoxAroundGlyph write FShowBoxAroundGlyph default False;
    property CenterTextVertically: boolean read FCenterTextVertically write FCenterTextVertically default True;
    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    // No clWindow default for this control as it makes clWindow ignored
    property Color: TColor read GetColor write SetColor stored IsColorStored;
//    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TDBCheckBox }

  TwwDBCustomCheckBox = class(TwwCustomCheckBox)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    Function IsDataBound: boolean;
    procedure DataChange(Sender: TObject); override;
    procedure Toggle; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    function GetField: TField; override;
    function GetFieldState: TCheckBoxState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
//  published
//    property AlwaysTransparent: boolean read FAlwaysTransparent write FAlwaysTransparent;
//    property Frame: TwwEditFrame read FFrame write FFrame;
//    property DynamicCaption: boolean read FDynamicCaption write FDynamicCaption default False;
//    property ValueChecked: string read FValueChecked write SetValueChecked;
//    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
//    property DisplayValueChecked: string read FDisplayValueChecked write SetDisplayValueChecked;
//    property DisplayValueUnchecked: string read FDisplayValueUnchecked write SetDisplayValueUnchecked;
//    property ShowFocusRect: boolean read FShowFocusRect write FShowFocusRect default true;
//    property NullAndBlankState: TCheckBoxState read FNullAndBlankState write FNullAndBlankState;

    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
//    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnStartDock;
    property OnStartDrag;

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

  TwwCheckBox = class(TwwDBCustomCheckBox)
  published
    property DisableThemes;
    property AlwaysTransparent;
    property Frame;
    property DynamicCaption;
    property ValueChecked;
    property ValueUnchecked;
    property DisplayValueChecked;
    property DisplayValueUnchecked;
    property ShowFocusRect;
    property NullAndBlankState;
    property Indents;

    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property CenterTextVertically;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowText;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnStartDock;
    property OnStartDrag;

    property ReadOnly;
  end;

  TwwExpandGridIndents=class(TPersistent)
  private
    FWinControl: TWinControl;
    FIndentX: integer;
    FIndentY: integer;
//    procedure SetIndentX(Value: integer);
//    procedure SetIndentY(Value: integer);
  public
    constructor Create(AOwner: TComponent);
//    Procedure Assign(Source: TPersistent); override;
  published
    property X: integer read FIndentX write FIndentX default 0;
    property Y: integer read FIndentY write FIndentY default 0;
  end;

//  TwwExpandAutoShrink = (easDisabled, easTerminalGrid, easAllGrids);
  TwwExpandButton = class;

  TwwCheckVisibleButton = procedure (
    Sender: TwwExpandButton;
    DataSet: TDataSet;
    var AShowExpand: boolean) of object;

  TwwExpandButton = class(TwwDBCustomCheckBox)
   private
    FButtonAlignment: TAlignment;
    FGrid: TWinControl;
    FExpandImages: TImageList;
    FAutoShrink: boolean; //TwwExpandAutoShrink;
    //    FExpanded: boolean;
    FOnBeforeExpand: TNotifyEvent;
    FOnBeforeCollapse: TNotifyEvent;
    FOnAfterExpand: TNotifyEvent;
    FOnAfterCollapse: TNotifyEvent;
    FAutoHideExpand: boolean;
    InClickEvent: boolean;
    FGridIndents: TwwExpandGridIndents;
    FOnCheckVisibleButton: TwwCheckVisibleButton;
    BeforeExpandHeightOfParentGrid, BeforeExpandRowHeight: integer;

    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure SetGrid(value: TWinControl);
    procedure SetExpanded(val: boolean);
    function GetExpanded: boolean;
   protected
    OriginalHeight: integer;
    procedure WndProc(var Message: TMessage); override;
    function GetAlignment: TAlignment; override;
    Function GetDisplayText: string; override;
    Function GetExtraIndentX: integer; override;
    function GetImageList: TImageList; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Toggle; override;
    procedure DataChange(Sender: TObject); override;
    function GetFieldState: TCheckBoxState; override;
    function FillBackground: boolean; override;
    procedure DoBeforeExpand; virtual;
    procedure DoBeforeCollapse; virtual;
    procedure DoAfterExpand; virtual;
    procedure DoAfterCollapse; virtual;
    function HideExpand: boolean; override;
    function GetDrawFlags: integer; override;
   public
    PaintAsExpanded: boolean;
    DesiredRow: integer;
    ExpandedGridRow: integer;
    InRefreshCalcField: boolean;
    InToggle: boolean;
//    ftest: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetHeight;
    procedure Click; override;
    property Expanded: boolean read GetExpanded write SetExpanded;
    procedure RefreshCalcField;
    procedure ExpandAfterDelay;
//    property Checked: boolean read FExpanded write SetExpanded;
   published
    property DisableThemes;
    property Grid: TWinControl read FGrid write SetGrid;
    property AutoShrink: boolean read FAutoShrink write FAutoShrink default True;

    property AutoHideExpand: boolean read FAutoHideExpand write FAutoHideExpand default False;
    property ShowFocusRect;
    property OnBeforeExpand: TNotifyEvent read FOnBeforeExpand write FOnBeforeExpand;
    property OnBeforeCollapse: TNotifyEvent read FOnBeforeCollapse write FOnBeforeCollapse;
    property OnAfterExpand: TNotifyEvent read FOnAfterExpand write FOnAfterExpand;
    property OnAfterCollapse: TNotifyEvent read FOnAfterCollapse write FOnAfterCollapse;
    property OnCheckVisibleButton: TwwCheckVisibleButton read FOnCheckVisibleButton write FOnCheckVisibleButton;
    property GridIndents: TwwExpandGridIndents read FGridIndents write FGridIndents;
//    property Alignment;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
//    property test: integer read FTest write FTest;
    property DataField;
    property DataSource;
    property Enabled;
    property Font;
    property Images;
    property ParentBiDiMode;
    property ParentColor;
    property Indents;
    property ShowAsButton;
    property ShowText default False;
//    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ButtonAlignment: TAlignment read FButtonAlignment write FButtonAlignment default taLeftJustify;
//    property OnClick;
    property OnContextPopup;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;

    property ReadOnly;
  end;


implementation
uses
     {$ifdef wwDelphi7Up}
     themes,
     {$endif}
     wwdbigrd;
type
  EwwExpandError = class(Exception);
  
Function TwwCustomCheckbox.GetColor: TColor;
begin
   result:= inherited Color;
end;

procedure TwwCustomCheckbox.SetColor(Value: TColor);
begin
   inherited Color:= Value;
end;

Function TwwCustomCheckbox.IsColorStored;
begin
   result:= not ParentColor;
end;

procedure TwwCustomCheckBox.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;

procedure TwwCustomCheckBox.DrawItem(const DrawItemStruct: TDrawItemStruct);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;
begin
  CanvasNeeded;
  FCanvas.Handle := DrawItemStruct.hDC;
  FCanvas.Font:= Font;
  Paint;
  PaintBorder;
  FCanvas.Handle := 0;
end;

procedure TwwCustomCheckBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var r: TRect;
begin
  if IsInwwObjectViewPaint(self) or
    ((IsTransparentEffective and not Focused) or AlwaysTransparent) then
  begin
     if not (csDesigning in ComponentState) then Message.result:= 1
     else inherited;
  end
  else if wwUseThemes(self) then
  begin
    {$ifdef wwDelphi7Up}
    if (parent is TCustomGrid) then
    begin
       r:= ClientRect;
       if (FCanvas<>nil) then
       begin
          FCanvas.Brush.Color:= Color;
          Windows.FillRect(message.dc, r, FCanvas.brush.handle );
       end;
       message.result:=1
    end
    else begin
      { Get the parent to draw its background into the control's background. }
      ThemeServices.DrawParentBackground(Handle, Message.DC, nil, False);
      message.result:=1;
    end
    {$endif}
  end
  else
     inherited;
{   if Frame.enabled and not (csDesigning in ComponentState) then
      message.result:=1
   else inherited;}
end;

procedure TwwCustomCheckBox.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TLeftRight] of DWORD =
    ((BS_LEFTTEXT, 0), (0, BS_LEFTTEXT));
begin
   inherited;
   CreateSubClass(Params, 'BUTTON');
   if IsTransparentEffective then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;  // For transparency

// Following 2 lines may not be necessary
//   if ThemeServices.ThemesEnabled then
//     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;  // For transparency

   with Params do begin
     Style:= Style and not BS_3STATE;
     Style := Style or BS_ownerdraw;
//     Style:= Style or ws_border;
     WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
   end;
end;

procedure TwwCustomCheckBox.CreateWnd;
  procedure DisableParentClipping;
  begin
     SetWindowLong(GetParent(Handle), GWL_STYLE,
      GetWindowLong(GetParent(Handle), GWL_STYLE) and not WS_CLIPCHILDREN);
  end;
begin
   inherited;
   if IsTransparentEffective then
   begin
     DisableParentClipping;
   end;
   Modified := FModified;
end;

destructor TwwCustomCheckBox.Destroy;
begin
   FIndents.Free;
   FCanvas.Free;
   FFrame.Free;
   inherited;
end;
{
procedure TwwCustomCheckBox.PaintGlyph(drawrect: TRect; b: TBitmap);
var TempRect: TRect;
    FGlyphs: TImageList;
    i: integer;
begin
 for i:= 1 to 1 do
  begin
   FGlyphs:= TImageList.createsize(b.Width, b.Height);
   FGlyphs.AddMasked(b, b.Canvas.Pixels[0, b.Height-1]);
   Canvas.Lock;
   TempRect:= Rect(0, 0, b.Width, b.Height);
   try
      FGlyphs.Draw(Canvas, drawrect.left, drawrect.top,
        0, True);
//      FCanvas.Brush.Style:= bsClear;
//      FCanvas.BrushCopy(DrawRect, b, TempRect,
//          b.Canvas.Pixels[0, b.Height-1]);
   finally
      Canvas.Unlock;
      FGlyphs.Free;
   end;
end
end;
}

procedure TwwCustomCheckBox.ComputeGlyphRect(var DrawRect: TRect);
var offsetx, offsety: integer;
    checkboxSizeX, checkboxSizeY: integer;
    pt: TPoint;
    TempIndentCheckboxX: integer;
begin
   if (GetImageList<>nil) and (GetImageList.count>0) then
   begin
      checkboxSizeX:= GetImageList.Width;
      checkboxSizeY:= GetImageList.Height;
   end
   else begin
      checkboxSizex:= 13;
      checkboxSizey:= 13;
   end;

     offsetx:= checkboxsizex div 2;
     offsety:= checkboxsizey div 2;

     TempIndentCheckboxX:= Indents.ButtonX+1+GetExtraIndentX;
     if parent is TCustomGrid then inc(TempIndentCheckboxX);

     if Frame.Enabled and
        (efLeftBorder in Frame.FocusBorders) then
     begin
        TempIndentCheckboxX:= wwmax(TempIndentCheckboxX, 3);
     end;

     if GetAlignment = taRightJustify then
        pt.x:= offsetx + TempIndentCheckboxX
     else if GetAlignment = taLeftJustify then
        pt.x:= ClientWidth - TempIndentCheckboxX - offsetx -2
     else
        pt.x:= (ClientWidth - offsetx) div 2;
     pt.y:= Height div 2;

     DrawRect.Left:= pt.x - offsetx;
     DrawRect.Right:= pt.x + offsetx+1;
     DrawRect.Top:= pt.y-offsety+Indents.ButtonY;
     DrawRect.Bottom:= pt.y+offsety+1+Indents.ButtonY;

end;

procedure TwwCustomCheckBox.ComputeTextRect(var DrawRect: TRect);
var TempIndentTextX: integer;
    pt: TPoint;
    NewDrawRect: TRect;
    DrawFlags: integer;
    TempCaption : string;
begin
   ComputeGlyphRect(DrawRect);

   TempIndentTextX:= Indents.TextX;
   if Frame.Enabled and
      (efLeftBorder in Frame.FocusBorders) then
      TempIndentTextX:= wwmax(TempIndentTextX, 3);
//   if FShowAsButton then TempIndentTextX:= wwmax(TempIndentTextX, 3);

   pt.y:= Height div 2;
   if GetAlignment = taRightJustify then
       NewDrawRect:= Rect(DrawRect.Right + 4 + TempIndentTextX, 0,
                     Width, Height)
   else
       NewDrawRect:= Rect(TempIndentTextX + 2, 0, DrawRect.Left, Height);
   DrawFlags:= GetDrawFlags;
   if WordWrap then
      DrawFlags:= DrawFlags or DT_EDITCONTROL or DT_WORDBREAK;
   if DynamicCaption then
   begin
      TempCaption:=  DisplayValueChecked;
      if length(TempCaption)<length(DisplayValueUnchecked) then
         TempCaption:= DisplayValueUnchecked;
      //if length(TempCaption) < length(Caption) then TempCaption := Caption; !! Uncomment?
   end
   else TempCaption:= GetDisplayText; //Caption;


   DrawTextEx(Canvas.Handle, PChar(TempCaption),
              Length(TempCaption), newdrawrect, DrawFlags or DT_CALCRECT, nil);
   DrawRect:= NewDrawRect;

   if CenterTextVertically then
      DrawRect.Top:= Indents.TextY + (ClientHeight -
                   (NewDrawRect.Bottom-NewDrawRect.Top)) div 2
   else
      DrawRect.Top:= Indents.TextY + 1;

   DrawRect.Bottom:= DrawRect.Top + NewDrawRect.Bottom; //DrawRect.Bottom - (NewDrawRect.Bottom-NewDrawRect.Top) div 2;
   if wwIsClass(parent.classtype, 'TwwDBGrid') and
      (dgRowLines in TwwDBGrid(parent).Options) then
       DrawRect.Top:= DrawRect.Top +1;

end;

type
  TwwCheatGridCast = class(TwwDBGrid);

procedure TwwCustomCheckBox.Paint;
var r: TRect;

// 8/25/01 -   If rowselect is True for grid then
//             if dgAlwaysshowSelection is true, then paint highlight
//             else if expandbutton has focus then override painting to paint as highlight
// 3/30/2002 - In some cases we only wish to check for rowselect so focusrect will still show.
   function DrawHighlightForRowSelect(CheckBoth:boolean=True): boolean;
   begin
      Result:= False;
      if (wwIsClass(classtype, 'TwwExpandbutton')) then
      begin
          if (wwIsClass(parent.classtype, 'TwwCustomDBGrid')) then
          begin
             if (dgRowSelect in TwwCheatGridCast(Parent).Options) or
                (CheckBoth and (TwwCheatGridCast(Parent).PaintOptions.ActiveRecordColor<>clNone)) then
             begin
                if (dgAlwaysShowSelection in TwwCheatGridCast(Parent).Options) or
                   Focused then
                begin
                    result:= True;
                end
             end;
          end;
      end
  end;
  function DrawHighlight: boolean;
  begin
     result:= False;
     if wwIsClass(parent.classtype, 'TwwDBGrid') then begin

       result:= parent.focused {or
               (TwwDBGrid(parent).HasFocus and
               (not Focused) and
                not wwInPaintCopyState(ControlState))};
       //    8/25/01
       if (not result) and DrawHighlightForRowSelect then result:= True;
    end
  end;

    {$ifdef wwDelphi7Up}
    function GetCheckboxThemeStyle(Pressed: boolean): TThemedButton;
    var TempState: TCheckboxState;
    begin
       if csPaintCopy in ControlState then
          TempState:= GetFieldState
       else
          TempState:= State;

       if (TempState=cbGrayed) or (not Enabled) then
       begin
          if TempState = cbChecked then
             Result:= tbCheckboxCheckedDisabled
          else Result:= tbCheckboxUnCheckedDisabled
       end
       else begin
          if TempState = cbChecked then
          begin
             if Pressed then
                Result:= tbCheckboxCheckedPressed
             else begin
                if IsMouseInControl and not (csPaintCopy in ControlState) then
                   Result:= tbCheckboxCheckedHot
                else
                   Result:= tbCheckboxCheckedNormal
             end
          end
          else begin
             if Pressed then
                Result:= tbCheckboxUncheckedPressed
             else begin
                if IsMouseInControl and not (csPaintCopy in ControlState) then
                   Result:= tbCheckboxUncheckedHot
                else
                   Result:= tbCheckboxUncheckedNormal
             end
          end;
       end;
    end;
    {$endif}

  procedure PaintText;
  var ARect, FocusRect: TRect;
      Flags: integer;
      HaveText: boolean;
      TempCaption: string;
      SaveColorbg,savecolorfont:TColor;
      temp: integer;
      {$ifdef wwDelphi7Up}
      Details: TThemedElementDetails;
      CheckboxStyle: TThemedButton;
      {$endif}
  begin
    SaveColorbg:=Canvas.Brush.Color;
    SaveColorfont:=Canvas.Font.Color;

    ComputeTextRect(ARect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
       Temp:= ARect.Left;
       ARect.Left:= ClientWidth-ARect.Right;
       ARect.Right:= ClientWidth-Temp;
    end;

    TempCaption:= GetDisplayText;
    HaveText:= DynamicCaption or (TempCaption<>'');
    if Focused and ShowFocusRect and HaveText and
      (not (csPaintCopy in ControlState)) then // {and not (parent is TCustomGrid) }then
    begin
      if parent is TCustomGrid then
        FocusRect:= Rect(ARect.Left - 2, ARect.Top - 1,
                     wwMin(ARect.Right+2, ARect.Left + Canvas.TextWidth(TempCaption) + 2),
                     ARect.Bottom + 1)
      else
        FocusRect:= Rect(ARect.Left - 2, wwMax(ARect.Top - 2, 0), // 6/29/02 - Changed from ARect.Top - 2 as focusrect cutoff from top in default case
                     wwMin(ARect.Right+2, ARect.Left + Canvas.TextWidth(TempCaption) + 2),
                     ARect.Bottom + 2);
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := clBlack;
      Canvas.FrameRect(FocusRect);
      // 3/30/2002-PYW-If Highlight then focusrect colors were wrong.
      if DrawHighlight then begin
        Canvas.Brush.Color := clBlack;
        Canvas.Font.Color := clWhite;
      end
      else begin
        Canvas.Brush.Color := clWhite;
        Canvas.Font.Color := clBlack;
      end;
      Canvas.DrawFocusRect(FocusRect);
      // 3/30/2002-PYW-Restore Saved Canvas and Font Colors.
      Canvas.Font.Color := SaveColorFont;
      Canvas.Brush.Color := SaveColorBg;
    end;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    Flags:= GetDrawFlags;
    if WordWrap then flags:= flags or DT_EDITCONTROL or DT_WORDBREAK;

    InflateRect(ARect, 0, 2);
    ARect.Top:= ARect.Top + 2;
    if DrawHighlight then begin
//       Canvas.Font.Color := clHighlightText;
    end
    else if not (csPaintCopy in ControlState) then
       Canvas.Font.Color:= Font.Color;

    if (not Focused) and IsTransparentEffective and
       (Frame.NonFocusTransparentFontColor<>clNone) then
        Canvas.Font.Color:= Frame.NonFocusTransparentFontColor
    // 4/15/01
    else if (not Focused) and (Frame.Enabled) and
            (Frame.NonFocusFontColor<>clNone) then
       Canvas.Font.Color:= Frame.NonFocusFontColor;

    if (not Enabled) and not wwUseThemes(self) then
    begin
      OffsetRect(ARect, 1, 1);
      Canvas.Font.Color:= clBtnHighlight;
      DrawTextEx(Canvas.Handle, Pchar(TempCaption), length(TempCaption), ARect, Flags, nil);
      Canvas.Font.Color:= clGrayText;
      OffsetRect(ARect, -1, -1);
    end;

    if wwUseThemes(self) then
    begin
      {$ifdef wwDelphi7Up}
      CheckboxStyle:= GetCheckboxThemeStyle(False);
      Details := ThemeServices.GetElementDetails(CheckboxStyle);

      if TempCaption <> '' then
          ThemeServices.DrawText(Canvas.Handle, Details, TempCaption, ARect, DT_LEFT, 0);
     {$endif}
    end
    else
       DrawTextEx(Canvas.Handle, Pchar(Tempcaption), length(Tempcaption), ARect, Flags, nil);
  end;

  procedure PaintCheckbox;
  var
      DrawRect, TempRect: TRect;
      FrameStateFlags, StateFlags: integer;
      TempState: TCheckboxState;
      {$ifdef wwDelphi7Up}
      Details: TThemedElementDetails;
      ExpandStyle: TThemedTreeview;
      CheckboxStyle: TThemedButton;
      PaintRect: TRect;
      {$endif}
      UseThemesForExpandButton: boolean;
  begin
    ComputeGlyphRect(DrawRect);

    // 6/29/02 - Bidi mode
    if UseRightToLeftAlignment then
    begin
       DrawRect.Right:= ClientWidth-DrawRect.Left;
       DrawRect.Left:= DrawRect.Right-13;
    end;

    if csPaintCopy in ControlState then
       TempState:= GetFieldState
    else
       TempState:= State;

    if TempState=cbChecked then
       StateFlags:= DFCS_BUTTONCHECK
    else
       StateFlags:= DFCS_BUTTON3STATE;

    if (cslbuttondown in controlstate) and Focused and not (csPaintCopy in ControlState) then
    begin
        if IsInGrid(self) then
        begin
           if IsMouseInControl(True) then
              StateFlags := StateFlags or DFCS_PUSHED;
        end
        else begin
            if IsMouseInControl then
              StateFlags := StateFlags or DFCS_PUSHED;
        end
    end;

    if SpaceKeyPressed and (GetKeyState(vk_space)<0) and Focused then
       StateFlags := StateFlags or DFCS_PUSHED;

    if TempState=cbChecked then
       StateFlags := StateFlags or DFCS_CHECKED
    else if TempState = cbGrayed then
       StateFlags:= StateFlags or DFCS_CHECKED;

    UseThemesForExpandButton:=
       wwUseThemes(self) and (GetImageList<>Images);

    if UseThemesForExpandbutton then
    begin
       {$ifdef wwDelphi7Up}
       if TempState=cbChecked then ExpandStyle:= ttGlyphOpened
       else ExpandStyle:= ttGlyphClosed;
       Details := ThemeServices.GetElementDetails(ExpandStyle);
       TempRect:= DrawRect;
       InflateRect(TempRect, 1, 1);
       ThemeServices.DrawElement(Canvas.Handle, Details, TempRect);
       exit;
       {$endif}
    end
    else if (GetImageList<>nil) and (GetImageList.Count>0) then
    begin
       FrameStateFlags:= DFCS_BUTTONPUSH;
       if (StateFlags and DFCS_PUSHED <> 0) then
          FrameStateFlags:= FrameStateFlags or DFCS_PUSHED;

       if ShowBoxAroundGlyph then
       begin
          TempRect:= DrawRect;
          InflateRect(TempRect, 1, 1);
          Canvas.Brush.Color:= clWhite;
          Canvas.FillRect(TempRect);
          Canvas.Brush.Color:= clBlack;
          Canvas.FrameRect(TempRect);
       end;

       if (FShowAsButton) then begin
          TempRect:= DrawRect;
          InflateRect(TempRect, 2, 2);
          if not Enabled then
             FrameSTateFlags:= FrameStateFlags + DFCS_INACTIVE;
          with DrawRect do
              DrawFrameControl(Canvas.Handle, TempRect,
                      DFC_BUTTON, FrameStateFlags);
       end;

       if TempState=cbChecked then
       begin
          if (GetImageList<>nil) and (GetImageList.count>1) then begin
             GetImageList.Draw(Canvas, drawrect.left, drawrect.top, 1, True);
             exit;
          end
       end
       else if TempState=cbUnchecked then
       begin
          if (GetImageList<>nil) and (GetImageList.count>0) then begin
             GetImageList.Draw(Canvas, drawrect.left, drawrect.top, 0, True);
             exit;
          end
       end
       else begin
          if (GetImageList<>nil) and (GetImageList.count>2) then begin
             GetImageList.Draw(Canvas, drawrect.left, drawrect.top, 2, True);
             exit;
          end
       end;
    end;

    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(DrawRect);
    Canvas.Brush.Color := clBtnShadow;

    if GetImageList=nil then
    begin
      if not Enabled then
          StateFlags:= StateFlags + DFCS_INACTIVE;

      if wwUseThemes(self) then
      begin
//         PerformEraseBackground(Self, Canvas.Handle);
         {$ifdef wwDelphi7Up}
         CheckboxStyle:= GetCheckboxThemeStyle((StateFlags and DFCS_PUSHED)<>0);
         Details := ThemeServices.GetElementDetails(CheckboxStyle);
         PaintRect := DrawRect;
         ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
         PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
         {$endif}
      end
      else begin
          with DrawRect do
             DrawFrameControl(Canvas.Handle, DrawRect,
                 DFC_BUTTON, StateFlags);
      end
    end
  end;

  Function Max(x,y: integer): integer;
  begin
     if x>y then result:=x else result:=y
  end;

  procedure EndPainting;
  begin
     if (FCanvas = Canvas) then exit;
     r:= ClientRect;
//     InflateRect(r, -2, -2); // Seems to cause glyph to not appear
     FCanvas.CopyRect(r, FPaintCanvas, r);
  end;

begin
   if False and Focused and (not AlwaysTransparent) then
   begin
      FPaintBitmap:= TBitmap.create;
      FPaintCanvas:= FPaintBitmap.canvas;
      FPaintBitmap.Width:= ClientWidth;
      FPaintBitmap.Height:= ClientHeight;
   end;

   try
     if (not (Frame.Enabled and Frame.Transparent)) or
       (not AlwaysTransparent) and (Focused) then
     begin
        if not (IsInGridPaint(self)) then
        begin
          r:= ClientRect;
//          InflateRect(r, -2, -2); // Seems to cause glyph to not appear
          Canvas.Brush.Color:= Color;

          // 4/15/01 - Back-color support
          if (not IsTransparentEffective) then
          begin
             if Frame.Enabled and (not Focused) and (Frame.NonFocusColor<>clNone) then
             begin
                Canvas.Brush.Color:= Frame.NonFocusColor;
             end
          end;

          {
//          If rowselect is True for grid then
//             if dgAlwaysshowSelection is true, then paint highlight
//             else if expandbutton has focus then override painting to paint as highlight
          if (wwIsClass(parent.classtype, 'TwwCustomDBGrid')) then
          begin
             if (dgRowSelect in TwwCheatGridCast(Parent).Options) then
             begin
                if (dgAlwaysShowSelection in TwwCheatGridCast(Parent).Options) or
                   Focused then
                begin
                   Canvas.Brush.Color:= clHighlight;
                   Canvas.Font.Color := clHighlightText;
                end
             end;
          end;
}
          if DrawHighlight then begin
             Canvas.Brush.Color := clHighlight;
             Canvas.Font.Color := clHighlightText;
          end;
          {  Honor grid's colors when painting cell }
          if DrawHighlight and (wwIsClass(parent.classtype, 'TwwCustomDBGrid')) then
          begin
             if TwwCustomDBGrid(parent).PaintOptions.ActiveRecordColor<>clNone then
                Canvas.Brush.Color:=
                  TwwCustomDBGrid(parent).PaintOptions.ActiveRecordColor;

             if (GetField<>nil) then
                TwwCheatGridCast(Parent).DoCalcCellColors(GetField, [], True, Canvas.Font, Canvas.Brush);
             Canvas.FillRect(r);
          end
          else begin
             if FillBackground and not(wwUseThemes(self)) then
                Canvas.FillRect(r);
          end;
        end
     end;
     if not HideExpand then PaintCheckbox;
     if ShowText then PaintText;

    // 8/25/01 - Check grid's rowselect
    // 3/30/2002 - Only check for rowselect so focusrect will still show.
    if DrawHighlight and not DrawHighlightForRowSelect(False) and
      (parent.Focused and not (csPaintCopy in ControlState)) then
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

   finally
     EndPainting;
     FPaintBitmap.Free;
     FPaintBitmap:=nil;
   end
end;

procedure TwwCustomCheckBox.WMLButtonUp(var Message: TWMLButtonUp);
var r: TRect;
begin
   inherited;
   if not IsInGrid(self) then begin
      if PtInRect(ClientRect, Point(Message.xpos,Message.ypos)) then
         Toggle;
   end
   else begin
      ComputeGlyphRect(r);
      InflateRect(r, 3, 3);
      if PtInRect(r, Point(Message.xpos,Message.ypos)) then
         if not wwIsClass(self.classtype, 'TwwExpandButton') or
            Focused or (not Checked) then
            Toggle;
   end
end;

procedure TwwCustomCheckBox.BMSetCheck(var Message: TMessage);
var r: TRect;
begin
   inherited;
   if DynamicCaption then begin
     if State=cbChecked then Caption:= DisplayValueChecked
     else if State=cbUnchecked then Caption:= DisplayValueUnchecked
     else Caption:= ''
   end
   else begin
      if IsTransparentEffective and
         ((not Focused) or AlwaysTransparent) then
      begin
        ComputeGlyphRect(r);
        r:= Rect(r.left + left, r.top + top, r.right+left, r.bottom+top);
        InvalidateRect(parent.handle, @r, False);
//       Frame.RefreshTransparentText(False, False);
      end
   end;

   invalidate;
end;

procedure TwwCustomCheckBox.PaintBorder;
begin
   if HandleAllocated then
   begin
     if not Frame.Enabled then exit;
     Frame.Ncpaint(Focused, AlwaysTransparent);
   end;
end;

procedure TwwCustomCheckBox.WMKillFocus(var Message: TWMKillFocus);
var
   exStyle, origStyle: longint;
//   r: TRect;
begin
   inherited;

   if IsTransparentEffective then
   begin
     OrigStyle:= Windows.GetWindowLong(handle, GWL_EXSTYLE);
     exStyle:= OrigStyle or WS_EX_TRANSPARENT;
     Windows.SetWindowLong(handle, GWL_EXSTYLE, exStyle);
     Frame.RefreshTransparentText(True, True, True);
//     r:= BoundsRect;
//     InvalidateRect(Parent.handle, @r, False);
   end;

   invalidate;
//   InvalidateBorder;
end;

procedure TwwExpandButton.WMKillFocus(var Message: TWMKillFocus);
var r: TRect;
begin
   if parent is TCustomGrid then
   begin
      r:= Rect(Left, Top, Left+width, top+height);
      InvalidateRect(parent.handle, @r, False);
   end;
end;

procedure TwwDBCustomCheckbox.WMSetFocus(var Message: TWMSetFocus);
begin
   inherited;
   if (FDataLink.Field<>nil) then Modified:=False;
end;

procedure TwwCustomCheckBox.WMSetFocus(var Message: TWMSetFocus);
var r: TRect;
    exStyle, origStyle: longint;
begin
   inherited;

   SpaceKeyPressed:=False;

   if IsTransparentEffective and (not AlwaysTransparent) then begin
     OrigStyle:= Windows.GetWindowLong(handle, GWL_EXSTYLE);
     exStyle:= OrigStyle and not WS_EX_TRANSPARENT;
     Windows.SetWindowLong(handle, GWL_EXSTYLE, exStyle);
     invalidate;
   end;

{  if Frame.enabled then begin
     if IsTransparentEffective then begin
        r:= BoundsRect;
        InvalidateRect(Parent.Handle, @r, False);
     end;
     invalidate;
  end;
}

   if IsTransparentEffective and AlwaysTransparent then
   begin
     r:= BoundsRect;
     InvalidateRect(Parent.handle, @r, False);
   end;
   invalidate;

//   if Frame.Enabled then {(not AlwaysTransparent) then }InvalidateBorder;
end;

procedure TwwCustomCheckBox.WMNCPaint(var Message: TMessage);
begin
   inherited;
{   if not Frame.Enabled then exit;
   Frame.Ncpaint(Focused, AlwaysTransparent);
   message.result:= 0;
}
end;

constructor TwwCustomCheckBox.Create(AOwner: TComponent);
begin
   inherited;
   FShowText:=True;
//   FShowAsButton:= True;
   FFrame:= TwwEditFrame.create(self);
   FIndents:= TwwWinButtonIndents.create(self);
   FValueChecked:= 'True';
   FValueUnchecked:= 'False';
   FShowFocusRect:= True;
   FCenterTextVertically:= True;
end;

function TwwCustomCheckBox.isTransparentEffective: boolean;
begin
   result:= Frame.Transparent and Frame.IsFrameEffective
end;


Function TwwCustomCheckBox.IsMouseInControl(CheckAreaOnly: boolean = False): boolean;
var p: TPoint;
    AHandle: HWND;
//    c: TControl;
    r: TRect;
begin
  GetCursorPos(p);
  p:= ScreenToClient(p);
  p.x:= p.x + Left;
  p.y:= p.y + Top;
  AHandle := ChildWindowFromPointEx(Parent.Handle, p, CWP_SKIPINVISIBLE);
//  c:= FindControl(AHandle);
  result:= FindControl(AHandle) = self;
  if CheckAreaOnly then
  begin
     ComputeGlyphRect(r);
     InflateRect(r, 3, 3);
     GetCursorPos(p);
     p:= ScreenToClient(p);
     if not PtInRect(r, p) then result:= False;
  end;
end;

procedure TwwCustomCheckBox.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
end;

procedure TwwCustomCheckBox.DataChange(Sender: TObject);
begin
end;

procedure TwwCustomCheckBox.CMTextChanged(var Message: TMessage);
begin
  if IsTransparentEffective and
    ((not Focused) or AlwaysTransparent) then
     Frame.RefreshTransparentText(False, False);

  inherited;
end;

procedure TwwCustomCheckBox.SetValueChecked(const Value: string);
begin
  FValueChecked := Value;
  DataChange(Self);
end;

procedure TwwCustomCheckBox.SetValueUnchecked(const Value: string);
begin
  FValueUnchecked := Value;
  DataChange(Self);
end;

procedure TwwCustomCheckbox.SetDisplayValueChecked(const Value: string);
begin
  FDisplayValueChecked := Value;
  invalidate;
end;

procedure TwwCustomCheckbox.SetDisplayValueUnchecked(const Value: string);
begin
  FDisplayValueUnchecked := Value;
  invalidate;
end;

function TwwCustomCheckbox.GetDisplayValueChecked: string;
begin
  if FDisplayValueChecked <> '' then result:= FDisplayValueChecked
  else result:= ValueChecked;
end;

function TwwCustomCheckbox.GetDisplayValueUnchecked: string;
begin
  if FDisplayValueUnchecked <> '' then result:= FDisplayValueUnchecked
  else result:= ValueUnchecked;
end;

constructor TwwDBCustomCheckbox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  State := cbUnchecked;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
//  FPaintControl := TPaintControl.Create(Self, 'BUTTON');
//  FPaintControl.Ctl3DButton := True;
end;

destructor TwwDBCustomCheckbox.Destroy;
begin
//  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TwwDBCustomCheckbox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TwwDBCustomCheckbox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TwwCustomCheckBox.GetFieldState: TCheckBoxState;
begin
   result:= State;
end;

function TwwDBCustomCheckbox.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
      Result := NullAndBlankState
    else if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    else
    begin
//      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueChecked, Text) then Result := cbChecked
      else
        if ValueMatch(FValueUnchecked, Text) then Result := cbUnchecked
      else
         Result:= NullAndBlankState;

    end
  else
  begin
    // 5/29/2002 - If Databound and not active then use NullAndBlankState.
    if isDataBound then Result:= NullAndBlankState
    else Result:= State;
  end;

//    Result := cbUnchecked;
end;

procedure TwwDBCustomCheckbox.DataChange(Sender: TObject);
begin
  State := GetFieldState;
  if (DataSource<>nil) and (DataSource.State=dsBrowse) then FModified:=False;
end;

procedure TwwDBCustomCheckbox.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else
    if FDataLink.Field.DataType = ftBoolean then
      FDataLink.Field.AsBoolean := Checked
    else
    begin
      if Checked then S := FValueChecked else S := FValueUnchecked;
      Pos := 1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

function TwwDBCustomCheckbox.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

Function TwwDBCustomCheckbox.IsDataBound: boolean;
begin
   result:= (DataSource<>nil) and
            (DataField<>'');
end;

function TwwCustomCheckbox.GetModified: Boolean;
begin
  Result := FModified;
end;

procedure TwwCustomCheckbox.SetModified(Value: Boolean);
begin
   FModified := Value;
end;

procedure TwwDBCustomCheckbox.Toggle;
begin
  if IsDataBound then
  begin
     if FDataLink.Edit then
     begin
       inherited Toggle;
       FDataLink.Modified;
       Modified:= True;
//       if not (csPaintCopy in ControlState) then modified:=True;
     end;
  end
  else if not ReadOnly then inherited Toggle
end;

function TwwDBCustomCheckbox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TwwDBCustomCheckbox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TwwDBCustomCheckbox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TwwDBCustomCheckbox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TwwDBCustomCheckbox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TwwDBCustomCheckbox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TwwDBCustomCheckbox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TwwDBCustomCheckbox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        Modified:= False;
      end
  end;
end;

procedure TwwDBCustomCheckbox.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TwwDBCustomCheckbox.WMPaint(var Message: TWMPaint);
//var OldState: TCheckboxState;
var tc: TColor;
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;

begin
  if not (csPaintCopy in ControlState) then
  begin
     inherited;
     PaintBorder;
  end
  else
  begin
//      OldState:= State;
      ClicksDisabled:= True;
      Try
        // This code works for inspector
        tc:= Font.Color; // Make compiler happy
        if IsInGridPaint(self) and (message.dc<>0) then
        begin
           tc:= GetTextColor(message.dc);
//           bc:= GetBkColor(message.dc);
        end;
        CanvasNeeded;
        FCanvas.Handle := Message.dc;
        FCanvas.Font:= Font;
        if IsInGridPaint(self) and (message.dc<>0) then
        begin
           FCanvas.Font.Color:= tc;
//           FCanvas.Brush.Color:= bc;
        end;
        Paint;
        FCanvas.Handle := 0;

      finally
        ClicksDisabled:= False;
      end;
  end;
end;

procedure TwwDBCustomCheckbox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TwwDBCustomCheckbox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TwwDBCustomCheckbox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwDBCustomCheckbox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

Function TwwCustomCheckBox.GetCanvas: TCanvas;
begin
   if Focused and (FPaintBitmap<>nil) then
      result:= FPaintCanvas
   else
      result:= FCanvas;
end;

procedure TwwCustomCheckBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key=vk_space then
  begin
     if SpaceKeyPressed then Toggle;
     SpaceKeyPressed:=False;
  end
end;

procedure TwwCustomCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
  procedure SendToParent;
  begin
    Parent.setFocus;
    { If grid does not have focus then SetFocus raised exception }
    if Parent.focused then
       TwwDBGrid(Parent).KeyDown(Key, Shift);
    Key := 0;
  end;
begin
  inherited;
  case key of
     VK_ESCAPE:
       if (parent is TCustomGrid) then
       begin
         if not modified then SendToParent;
       end;
     vk_space :
       begin
         SpaceKeyPressed:=True;
       end
  end;
end;

procedure TwwCustomCheckBox.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (csDesigning in ComponentState) then
  begin
    with Message do
       if (charcode = VK_SPACE) then SpaceKeyPressed:=True;
  end;

  inherited;
end;

procedure TwwCustomCheckBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
  end;
end;

procedure TwwCustomCheckBox.CNCommand(var Message: TWMCommand);
begin
  // Handle toggling ourselves instead of control
  // as when control is in inspector it does not work otherwise
  // Therefore we do not call inherited CNCommand
end;

procedure TwwCustomCheckBox.DoMouseEnter;
begin
  try
     If Assigned( FOnMouseEnter ) Then FOnMouseEnter( self );
  except
    exit;
  end;

  if wwUseThemes(self) then
  begin
     Invalidate;
  end;

  if Frame.IsFrameEffective and (not Focused) and
     Frame.MouseEnterSameAsFocus then
     wwDrawEdge(self, Frame, GetCanvas, True);
end;

procedure TwwCustomCheckBox.DoMouseLeave;
begin
  try
    If Assigned( FOnMouseLeave ) Then FOnMouseLeave( self );
  except
    exit;
  end;
  if wwUseThemes(self) then
  begin
     Invalidate;
  end;

  if Frame.IsFrameEffective and (not Focused) and
     Frame.MouseEnterSameAsFocus then begin
     wwDrawEdge(self, Frame, GetCanvas, False);
     if IsTransparentEffective then
        Frame.CreateTransparent:= True;
     RecreateWnd;
  end;
end;

procedure TwwCustomCheckBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoMouseEnter;
//  if cslButtonDown in ControlState then
//     Invalidate;
end;

procedure TwwCustomCheckBox.CMMouseLeave(var Message: TMessage);
var r:TRect;
    pt:TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  r := ClientRect;
  if (PtInRect(r,pt)) then exit;

  inherited;
  DoMouseLeave;

//  if cslButtonDown in ControlState then Invalidate;
end;

function TwwCustomCheckbox.GetField: TField;
begin
   result:=nil;
end;

procedure TwwCustomCheckbox.EMGetModify(var Message: TMessage);
begin
   If FModified then message.result:=1
   else message.result:=0;
end;

procedure TwwExpandButton.CMExit(var Message: TCMExit);
begin
   inherited;
end;

procedure TwwExpandButton.CMShowingChanged(var Message: TMessage);
begin
   inherited;
end;

procedure TwwExpandButton.DataChange(Sender: TObject);
begin
   if (datasource<>nil) and (datasource.state=dsbrowse)
      and not InClickEvent
      and not InRefreshCalcField then
   begin
      if State <> cbUnchecked then Toggle;
   end
//      state:= cbUnchecked;
end;

function TwwExpandButton.GetFieldState: TCheckBoxState;
begin
   result:= inherited GetFieldState;
   if (csPaintCopy in ControlState) then
   begin
      Result:= cbUnchecked;
      if (parent is TCustomGrid) and
         (Grid<>nil) and Grid.visible and PaintAsExpanded then
         Result:= cbChecked;
   end;

// Return cbChecked if child grid is visible and
// this is the active column, row
end;

procedure TwwExpandButton.Toggle;
var OrigChecked: boolean;
//    TempCol, TempRow: integer;
begin
  if InToggle then exit;

  OrigChecked:= Checked;
  InToggle:=True;
  try
    // 6/1/01 - Prevent grid's custom edit from moving beyond grid boundaries
    if wwIsClass(parent.classtype, 'TwwDBGrid') then
       TwwDBGrid(Parent).SkipHideControls:= True;

    if Checked then DoBeforeCollapse
    else DoBeforeExpand;

    if (OrigChecked=Checked) then
    begin
       case State of
         cbUnchecked:
          if AllowGrayed then State := cbGrayed
          else begin
             if Parent is TwwDBGrid then with TwwDBGrid(parent) do
             begin
                if RowHeightPercent<>MinRowHeightPercent then
                begin
                   RestoreRowHeights;
                   Update;  // Updates our position
                end
             end;
             State := cbChecked;
          end;
         cbChecked: State := cbUnchecked;
         cbGrayed: State := cbChecked;
       end;
    end;

    if Checked then DoAfterExpand
    else DoAfterCollapse;

  finally
     InToggle:=False;
     TwwDBGrid(Parent).SkipHideControls:= False;
  end
end;

procedure TwwExpandButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FGrid<>nil) and
    (AComponent = FGrid) then FGrid := nil;
end;

function TwwCustomCheckBox.FillBackground: boolean;
begin
   result:= True;
end;

function TwwExpandButton.FillBackground: boolean;
begin
   result:= not checked;
end;

procedure TwwExpandButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
   if ((parent is TCustomGrid) and (not Focused)) then
     message.result:=1
   else inherited;
end;

procedure TwwExpandButton.WMLButtonUp(var Message: TWMLButtonUp);
begin
   inherited;
end;

procedure TwwExpandButton.Click;
var parentGrid: TwwDBGrid;
    p: TPoint;
//    RowsNeeded: integer;
    SpaceAvailable, SpaceNeeded: integer;
    ShiftAmount: integer;
    DefaultRowHeight: integer;
//    BorderOffset, TitleOffset: integer;
    TerminalNode: boolean;
    i: integer;
    TrueScrollAmount: integer;
//    OrigShiftAmount: integer;
    OrigDesiredRow: integer;
    SkipSetTop: boolean;
    ParentParentGrid: TwwDBGrid;
    DesiredRowHeightParent: integer;
    r: TRect;
    TempDesiredRow: integer;
    OrigActiveRecord: integer;
//    NegativeScrollAmount: integer;
//    OldRowCount: integer;

  procedure ClearHorzRange;
  begin
    if TDrawGrid(Grid).ScrollBars in [ssHorizontal, ssBoth] then
      SetScrollRange(Grid.Handle, SB_HORZ, 0, 0, True);
  end;

  procedure SetRow(val: integer);
  var DrawInfo: TGridDrawInfo;
      OldLeft: integer;
  begin
     OldLeft:= Left;  // In case control's left is changed by grid
     if (Grid<>nil) and (not wwIsClass(Grid.classtype, 'TwwDBGrid')) then
        Grid.Update;
     with ParentGrid do begin
       BeginUpdate;
       CalcDrawInfo(DrawInfo);
       TDrawGrid(ParentGrid).row:= val;
       // Fix case where inherited grid gets confused on fixed columns
       if LeftCol<DrawInfo.Horz.FixedCellCount then
       begin
         LeftCol:= DrawInfo.Horz.FixedCellCount;
       end;
       EndUpdate;
       Invalidate;
     end;
     Left:= OldLeft;
  end;

begin
   if InRefreshCalcField then exit;  // Don't collapse if refreshing
   if InClickEvent then exit;
   if Grid=nil then exit;
//      screen.cursor:= crarrow;

   inherited Click;
   if not (parent is TCustomGrid) then exit;
   if Grid=nil then exit;

   SkipSetTop:= False;

   parentGrid:= TwwDBgrid(parent);
   DefaultRowHeight:= TDrawGrid(parentGrid).DefaultRowHeight;
   OrigDesiredRow:= DesiredRow;

   // Check if gird has any expandbuttons.  If so, then
   // we don't allow shrinkage as we need to accomodate embedded grid.
   TerminalNode:= True;
   for i:= 0 to Grid.ControlCount-1 do
      if Grid.Controls[i] is TwwExpandButton then TerminalNode:= False;
//   TempAutoShrink:= AutoShrink;

   InClickEvent:= True;

  try
   if checked then begin
      BeforeExpandHeightOfParentGrid:= 0;
      if OriginalHeight=0 then
         OriginalHeight:= Grid.Height;

      if (Grid is TwwDBGrid) then with TwwDBGrid(Grid) do
      begin
//         if TerminalNode and (AutoShrink = easTerminalGrid) or
//            (AutoShrink = easAllGrids) then
         Grid.parent:= self.parent;  // Set parent now so RowHeights are accurate

         if {TerminalNode and }AutoShrink then
         begin
           ClearHorzRange;  // So UpdateRowCount works accurately
           Height:= OriginalHeight;
           UpdateRowCount;
//           OldRowCount:= GetRowCount;
           DoShrinkToFit;
//           if GetRowCount<OldRowCount then
//              SetScrollRange(Handle, SB_VERT, 0, 0, False);
//         UpdateRowCount;
//         Height:= Height;
         end
      end
      else Grid.parent:= self.parent;  // Set parent now so RowHeights are accurate

//! increase parentgrid height if its also a childgrid
// Not easily done, as then we need to recompute parent's rowoffset
// Instead let us just allow AutoShrink only for terminal nodes
      with parentGrid do begin
//        SpaceAvailable:= ClientHeight - CellRect(0, TDrawGrid(parentGrid).Row).Bottom;
        // 10/10/01 - Use Leftcol instead of 0 in case indicator column is not visible
        SpaceAvailable:= ClientHeight - CellRect(LeftCol, TDrawGrid(parentGrid).Row).Bottom;
        if TerminalNode then
          SpaceNeeded:= Grid.height-1-SpaceAvailable
        else
          SpaceNeeded:= OriginalHeight-1-SpaceAvailable;
        if SpaceNeeded>0 then
        begin
           if ParentGrid.haveanyrowlines then
               ShiftAmount:= SpaceNeeded div (DefaultRowHeight+1) + 1
           else
               ShiftAmount:= SpaceNeeded div (DefaultRowHeight) + 1
        end
        else ShiftAmount:=0;

        if (ParentGrid is TwwDBGrid) then
        begin
            // Compute desired row based on having enough
            // space to display the entire original grid
            // Note: Make desired row smaller, never make larger
            if (dgTitles in Options) and (AutoShrink) and (not TerminalNode) then
            begin
               TempDesiredRow:=
                  (ClientHeight - (OriginalHeight + self.Height + 1) - (RowHeights[0]+2{+Grid.GetEffectiveFooterHeight})) div DefaultRowHeight+ 1;
               if DesiredRow=-1 then
               begin
                  DesiredRow:= wwmin(TempDesiredRow, TDrawGrid(parentGrid).Row - ShiftAmount);
               end
               else DesiredRow:= wwmin(DesiredRow, TempdesiredRow);
            end
        end;
        if (DesiredRow>=0) and (ShiftAmount>0) then
        begin
           // Update desired row based on new shift amount
           // Never make DesiredRow larger as we don't need to do this to help the space issue
           DesiredRow:= wwmin(DesiredRow, TDrawGrid(parentGrid).Row - ShiftAmount);
        end;
//        OrigShiftAmount:= ShiftAmount;
        if DesiredRow<0 then
        begin
           ShiftAmount:= wwmin(ShiftAmount, GetActiveRow);
//           DesiredRow:= 1;
        end
        else begin
           //Force current record to top if changing rows to something earlier

           // Need to get more records in buffer so taht there can be
           // records after auto-shrinked grid
           ShiftAmount:= 0;

           if DataLink.BufferCount-DesiredRow<>0 then
           with datasource.dataset do try
             OrigActiveRecord:= DataLink.ActiveRecord;

             // Scrolls forward
             TrueScrollAmount:= MoveBy(DataLink.BufferCount-(DesiredRow));//-DataLink.ActiveRecord);
             if TrueScrollAmount <DataLink.BufferCount-(DesiredRow) then // reached eof
             begin
                MoveBy(-TrueScrollAmount); // Move back
                ShiftAmount:= DataLink.ActiveRecord+1-DesiredRow;
                if ShiftAmount<0 then
                begin
                   raise EwwExpandError.Create(
                      'Shift Amount: ' + inttostr(ShiftAmount) + #13 +
                      'True Scroll Amount: ' + inttostr(TrueScrollAmount) + #13 +
                      'OrigActiveRecord: ' + inttostr(OrigActiveRecord) + #13 +
                      'DesiredRow: ' + inttostr(DesiredRow) + #13 +
                      'OrigDesiredRow: ' + inttostr(OrigDesiredRow) + #13
                      );
//                   ShiftAmount:= 0;
                end;
             end
             else begin
                MoveBy(-TrueScrollAmount); // Scroll back
//                ShiftAmount:= RowOffset;
//                DataLink.ActiveRecord:=RowOffset;
             end

           finally
           end;

           SetRow(DesiredRow);
           ExpandedGridRow:= DesiredRow;
           self.Top:= ParentGrid.CellRect(TDrawGrid(ParentGrid).Col, TDrawGrid(ParentGrid).Row).Top;
           SkipSetTop:= True;
           self.visible:=true;
        end
      end;

      if not SkipSetTop then
      begin
         if ParentGrid.haveanyrowlines then
             top:= top - ShiftAmount * (DefaultRowHeight+1)
         else top:= top - ShiftAmount * DefaultRowHeight;
      end;
      if wwIsClass(grid.classtype, 'TwwDBGrid') then
        TDrawGrid(FGrid).Ctl3D:= False;
      Grid.parent:= self.parent;
      p:= Point(Left+11, Top+Height);
      grid.top:=P.y + GridIndents.y;
      grid.left:= p.x + GridIndents.x;
      if ThemeServices.ThemesEnabled then
         grid.ControlStyle:= grid.controlstyle - [csParentBackground];
      grid.visible:=true;
      grid.setfocus;
      // Expand parent grid if it has been auto-shrinked
      with ParentGrid do begin
         if (ParentGrid.Parent is TwwDBGrid) then
         begin
            ParentParentGrid:= TwwDBGrid(ParentGrid.Parent);

            if (ParentParentGrid.ActiveExpandButton<>nil)
               and (TwwExpandButton(ParentParentGrid.ActiveExpandButton).AutoShrink) then
             begin
               DesiredRowHeightParent:=
                  wwMin(TwwExpandButton(ParentParentGrid.ActiveExpandButton).OriginalHeight, Height + Grid.Height);
               BeforeExpandHeightOfParentGrid:= Height;
               BeforeExpandRowHeight:=
                   ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).Row];
               Height:= DesiredRowHeightParent;
               ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).Row]:=
                  DesiredRowHeightParent + TDrawGrid(ParentParentGrid).DefaultRowHeight -1; // RSW Added -1 to make grid fit better
            end
         end
      end;

      with ParentGrid do
      begin

         RowOffset:= ShiftAmount;
         if not SkipSetTop then
            ExpandedGridRow:= DataLink.ActiveRecord+ParentGrid.TitleOffset-RowOffset;
         Rowheights[ExpandedGridRow]:=
           Rowheights[ExpandedGridRow] + Grid.height-1{+1};  // Subtract 1 instead of adding 1 for better fit

         // Expand parent grid
{         if (ParentGrid.Parent is TwwDBGrid) then
         begin
            ParentParentGrid:= TwwDBGrid(ParentGrid.Parent);

            if (ParentParentGrid.ActiveExpandButton<>nil) then
            begin
               DesiredRowHeightParent:=
                  wwMin(TwwExpandButton(ParentParentGrid.ActiveExpandButton).OriginalHeight, Height + Grid.Height);
               BeforeExpandHeightOfParentGrid:= Height;
               Height:= DesiredRowHeightParent;
               ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).Row]:=
                  DesiredRowHeightParent + TDrawGrid(ParentParentGrid).DefaultRowHeight;
            end
         end
}
      end;
{      if wwdbigrd.dgTitles in ParentGrid.Options then
         TDrawGrid(ParentGrid).Row:= ParentGrid.DataLink.ActiveRecord+1-ParentGrid.RowOffset
      else
         TDrawGrid(ParentGrid).Row:= ParentGrid.DataLink.ActiveRecord-ParentGrid.RowOffset;
}
//      parentGrid.BeginUpdate;
//      TDrawGrid(parentGrid).row:= ExpandedGridRow;
      SetRow(ExpandedGridRow);
//      parentGrid.EndUpdate;
//      parentGrid.invalidate;
//      DoAfterExpand;
   end
   else begin
      // Collapse grid's expanded grids
      for i:= 0 to Grid.ControlCount-1 do
         if Grid.Controls[i] is TwwExpandButton then
         begin
            if TwwExpandButton(Grid.Controls[i]).Expanded then
               TwwExpandButton(Grid.Controls[i]).Expanded:=False;
         end;

      Grid.visible:=false;

      if ParentGrid.CanFocus and
         not (csDestroying in ComponentState) then // 8/1/02 - Don't set focus if destroying
         ParentGrid.setfocus;

      if ExpandedGridRow<ParentGrid.GetRowCount then
         ParentGrid.Rowheights[ExpandedGridRow]:= DefaultRowHeight;
//      ParentGrid.Rowheights[ParentGrid.getactiverow+1]:=
//         DefaultRowHeight;
      //10/15/01-Don't set row if datalink.dataset is nil.
      if ParentGrid.DataLink.DataSet<>nil then
         SetRow(ParentGrid.DataLink.ActiveRecord+ParentGrid.TitleOffset);
      ParentGrid.RowOffset:= 0;

      if parent.parent is TCustomGrid then  // Prevent flicker when collapsing
      begin
         ValidateRect(Parent.Parent.Handle, nil);
         r:= Rect(ParentGrid.Left, ParentGrid.Top, ParentGrid.Left + ParentGrid.Width, ParentGrid.Top + ParentGrid.Height);
         if dgTitles in ParentGrid.Options then
           r.Top:= r.Top + ParentGrid.RowHeights[0]+2;

         InvalidateRect(Parent.Parent.Handle, @r, false);
      end;

      // Restore previous height before expanding parentparentgrid
      if (BeforeExpandHeightOfParentGrid<>0) then
      begin
         ParentParentGrid:= parent.parent as TwwDBGrid;
         ParentGrid.Height:= BeforeExpandHeightOfParentGrid;
         ParentParentGrid.RowHeights[TDrawGrid(ParentParentGrid).Row]:= BeforeExpandRowHeight;
      end;
//      ParentGrid.UpdateRowCount;
   end;

  finally
    InClickEvent:= False;
    DesiredRow:= -1;
  end;
end;


constructor TwwExpandGridIndents.Create(AOwner: TComponent);
begin
   if AOwner is TWinControl then
      FWinControl:= TWinControl(AOwner)
end;

constructor TwwExpandButton.Create(AOwner: TComponent);
var Bmp: TBitmap;
begin
   inherited;
   FShowText:=False;
   ShowBoxAroundGlyph:= True;
//   FShowAsButton:= True;
   FGridIndents:= TwwExpandGridIndents.create(self);
   FAutoShrink:= True; //easAllGrids;
   DesiredRow:= -1;
   Bmp := TBitmap.Create;
   try
      Bmp.LoadFromResourceName(HInstance, 'WWEXPAND');
      FExpandImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
      FExpandImages.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, 'WWCOLLAPSE');
      FExpandImages.AddMasked(Bmp, clWhite);
   finally
      Bmp.Free;
   end
end;

destructor TwwExpandButton.Destroy;
begin
   FExpandImages.Free;
   FGridIndents.Free;
   inherited;
end;

function TwwCustomCheckBox.GetImageList: TImageList;
begin
   result:= TImageList(Images);
end;

function TwwExpandButton.GetImageList: TImageList;
begin
   result:= inherited GetImageList;
   if result=nil then
      result:= FExpandImages;
end;

Function TwwCustomCheckbox.GetExtraIndentX: integer;
begin
   result:= 0;
end;

Function TwwExpandButton.GetExtraIndentX: integer;
begin
   result:= 2;
end;

procedure TwwExpandButton.SetGrid(value: TWinControl);
begin
   FGrid:= Value;
   if FGrid<>nil then
   begin
      FGrid.visible:= false;
      if wwIsClass(grid.classtype, 'TwwDBGrid') then
        TDrawGrid(FGrid).Ctl3D:= False;
   end
end;

procedure TwwExpandButton.SetExpanded(val: boolean);
begin
   if GetExpanded<>Val then
   begin
//      FExpanded:= Val;
      // 5/29/01
      if val and wwIsClass(parent.classtype, 'TwwDBGrid') then
         TwwDBGrid(Parent).UpdateCustomEdit;
      Toggle;
   end
end;

procedure TwwExpandButton.DoAfterExpand;
begin
   if Assigned(FOnAfterExpand) then FOnAfterExpand(self);
end;

procedure TwwExpandButton.DoAfterCollapse;
begin
   if Assigned(FOnAfterCollapse) then FOnAfterCollapse(self);
end;

procedure TwwExpandButton.DoBeforeExpand;
begin
   if Assigned(FOnBeforeExpand) then FOnBeforeExpand(self);
end;

procedure TwwExpandButton.DoBeforeCollapse;
begin
   if Assigned(FOnBeforeCollapse) then FOnBeforeCollapse(self);
end;

Function TwwExpandbutton.GetDisplayText: string;
begin
  if (FDataLink<>nil) and (FDataLink.Field<>nil) and
     (FDataLink.DataSet<>nil) and
     (FDataLink.DataSet.Active) then
     result:= FDataLink.Field.DisplayText
  else
     result:= ''
end;

Function TwwCustomCheckBox.GetDisplayText: string;
var PaintFieldState : TCheckBoxState;
begin
   if DynamicCaption then begin
      if csPaintCopy in ControlState then
      begin
         PaintFieldState:= GetFieldState;
         if (PaintFieldState = cbChecked) then Result:= DisplayValueChecked
         else if PaintFieldState=cbUnchecked then Result:= DisplayValueUnchecked
         else Result:= ''
      end
      else result:= Caption
   end
   else
      result:= Caption;
end;

function TwwCustomCheckbox.HideExpand: boolean;
begin
   result:= False;
end;

function TwwExpandButton.HideExpand: boolean;
var AShowExpand: boolean;
begin
   result:= False;

   if (not (csDesigning in ComponentState)) and
      AutoHideExpand then begin
      if (FDataLink.Field=nil) or (FDataLink.DataSet=nil) or
         (not FDataLink.DataSet.Active) or
         FDataLink.Field.IsNull or (FDataLink.Field.asString='0') then

         if (IsInGridPaint(self)) or
            (not IsInGridPaint(self)) and (Grid<>nil) and
            (not Grid.visible) then
            result:= True;
   end;

   // Add new event to allow customization of expand button's visibility.
   if Assigned(FOnCheckVisibleButton) and Assigned(FDataLink.DataSet) then
   begin
      AShowExpand:= not result;
      FOnCheckVisibleButton(self, FDataLink.DataSet, AShowExpand);
      result:= not AShowExpand;
   end;
end;

type TCheatDataset = class(TDataSet);
procedure TwwExpandButton.RefreshCalcField;

  procedure CalcFieldRefresh;
  var ParentDataSet: TDataSet;
  begin
    if not (parent is TwwDBGrid) then exit;
    if TwwDBGrid(parent).DataSource=nil then exit;

    ParentDataSet := TwwDBGrid(parent).DataSource.DataSet;
    if (ParentDataSet=nil) or (not ParentDataSet.Active) then exit;

    if FDataLink.field.Calculated or FDataLink.Field.lookup then
    begin
      InRefreshCalcField:= True;
      try
        TCheatDataSet(ParentDataSet).GetCalcFields(TCheatDataSet(ParentDataSet).ActiveBuffer);
        TCheatDataSet(ParentDataSet).DataEvent(deRecordChange, 0);
      finally
        ValidateRect(parent.handle, nil);  // Don't repaint as it will flicker entire parent grid
        InRefreshCalcField:= False;
      end;
    end;

  end;

begin
//   InRefreshCalc:= True;
   CalcFieldRefresh;
//   inherited Refresh;
//   InRefreshCalc:= False;
end;

function TwwExpandButton.GetExpanded: boolean;
begin
   result:= Checked;
end;

procedure TwwExpandButton.BMSetCheck(var Message: TMessage);
begin
  inherited;
end;

function TwwExpandButton.GetAlignment: TAlignment;
begin
   if ButtonAlignment= taLeftJustify then
      result:= taRightJustify
   else if ButtonAlignment = taRightJustify then
      result:= taLeftJustify
   else result:= taCenter
end;

function TwwCustomCheckbox.GetAlignment: TAlignment;
begin
   result:= Alignment;
end;

procedure TwwExpandButton.ResetHeight;
begin
   OriginalHeight:= 0;
end;

var WM_EXPANDBUTTONDROPDOWN : UINT = 0;

procedure TwwExpandButton.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_EXPANDBUTTONDROPDOWN then begin { 6/8/00 }
     Expanded:=True;
  end
  else inherited;
end;

procedure TwwExpandButton.ExpandAfterDelay;
begin
   PostMessage(Handle, WM_EXPANDBUTTONDROPDOWN, 0, 0);
end;

function TwwExpandButton.GetDrawFlags: integer;
begin
   result:= DT_NOPREFIX;
end;

function TwwCustomCheckBox.GetDrawFlags: integer;
begin
   result:= 0;
end;


initialization
  WM_EXPANDBUTTONDROPDOWN := RegisterWindowMessage('IPEXPANDBUTTONDROPDOWN');
end.
