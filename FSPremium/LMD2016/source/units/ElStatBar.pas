unit ElStatBar;
{$I lmdcmps.inc}

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

ElStatBar unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  ElImgFrm,
  Windows,
  Messages,
  Graphics,
  Forms,
  Controls,
  CommCtrl,
  Imglist,
  Math,
  Types,
  UxTheme, Themes,
  LMDProcs,
  LMDThemes, LMDClass,
  LMDHTMLUnit,
  LMDTypes,
  LMDObjectList,
  LMDGraphUtils,
  {$ifdef LMD_UNICODE}
  LMDUnicode,
  {$endif}

  ElXPThemedControl,
  ElIni,
  ElVCLUtils;

type
  TElStatusPanelBevel = (epbLowered, epbNone, epbRaised);
  TElStatusPanelStyle = (epsText, epsControl, epsOwnerDraw);

  TElStatusBar = class;

  TElStatusPanel = class(TCollectionItem)
  private
    FImageIndex : Integer;
    FHint: TLMDString;
    FAlignment   : TAlignment;
    FBevel       : TElStatusPanelBevel;
    FStyle       : TElStatusPanelStyle;
    FText        : TLMDString;
    FWidth       : Integer;
    FControl     : TControl;
    FOldParent   : TWinControl;
    FOldBounds   : TRect;
    FCtlVisible,
    FOldVisible,
    FVisible     : Boolean;
    FOwner       : TElStatusBar;
    FSavedWidth  : Integer;
    FResizable   : Boolean;
    FAutoSize    : Boolean;

    FIsHTML      : Boolean;

    procedure SetImageIndex(newValue : Integer);
    procedure SetAutoSize(newValue : Boolean);
    procedure SetVisible(newValue : Boolean);
    procedure SetAlignment(newValue : TAlignment);
    procedure SetBevel(newValue : TElStatusPanelBevel);
    procedure SetStyle(newValue : TElStatusPanelStyle);
    procedure SetText(newValue: TLMDString);
    procedure SetWidth(newValue : Integer);
    procedure SetControl(newValue : TControl);
    function GetLeft : Integer;
    function GetRight : Integer;
    function GetPanelRect : TRect;

    procedure SetIsHTML(Value: Boolean);

  protected
    procedure SaveWidth;
    procedure RestoreWidth;
    procedure UpdateControl; virtual;
    function  CurWidth : integer;
    function  CalcAutoSize : integer;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
    function GetRealWidth: Integer;

    property AutoSize : Boolean read FAutoSize write SetAutoSize;  { Published }
    property Left : Integer read GetLeft;
    property Right : Integer read GetRight;
    property PanelRect : TRect read GetPanelRect;
  published
    property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
    property Resizable : Boolean read FResizable write FResizable default true;
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Bevel     : TElStatusPanelBevel read FBevel write SetBevel default epbLowered;
    property Style     : TElStatusPanelStyle read FStyle write SetStyle default epsText;
    property Text      : TLMDString read FText write SetText;
    property Width     : Integer read FWidth write SetWidth default 100;
    property Control   : TControl read FControl write SetControl;
    property Visible   : Boolean read FVisible write SetVisible default true;
    property Hint      : TLMDString read FHint write FHint;

    property IsHTML    : Boolean read FIsHTML write SetIsHTML default false;

  end;

  TElPanelEvent = procedure(Sender : TObject; Panel : TElStatusPanel) of object;

  TElStatusPanels = class(TCollection)
  private
    FStatusBar : TElStatusBar;
    function GetItems(Index : integer) : TElStatusPanel;
    procedure SetItems(Index : integer; newValue : TElStatusPanel);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
  public
    constructor Create(StatusBar : TElStatusBar);
    function Add: TElStatusPanel;
    function LastVisiblePanel: TElStatusPanel;
    property Items[Index : integer] : TElStatusPanel read GetItems write SetItems; default;
  end;

  TElStatusBar = class(TElXPThemedControl)
  private
    FImageList: TCustomImageList;
    FHChLink: TChangeLink;
    FBevel : TElStatusPanelBevel;
    FStorage : TElIniFile;
    FStoragePath : string;
    FResizablePanels : Boolean;
    FPressed : Boolean;
    FHintPanel,
    FPressedPanel,
    FResizePanel : TElStatusPanel;
    FSimpleText : TLMDString;
    FSimplePanel : Boolean;
    FSizeGrip : Boolean;
    FOnPanelResize : TElPanelEvent;
    FOnPanelDraw : TElPanelEvent;
    FOnPanelClick : TElPanelEvent;
    FOnPanelDblClick : TElPanelEvent;

    FPanels : TElStatusPanels;
    FOldCursor : TCursor;
    FDelta : integer;
    FLine : integer;
    FLineVis : boolean;
    FIgnoreSize : boolean;
    FSimpleTextIsHTML: Boolean;
    FRender: TLMDHTMLRender;
    FOnImageNeeded: TElHTMLImageNeededEvent;

    FImgFormChLink : TImgFormChangeLink;
    FImgForm: TElImageForm;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    procedure SetPanels(Value : TElStatusPanels);
    procedure SetSimpleText(newValue : TLMDString);
    procedure SetSimplePanel(newValue : Boolean);
    procedure SetSizeGrip(newValue : Boolean);
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure WMERASEBKGND(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMNCHitTest(var Message : TWMNCHITTEST); message WM_NCHITTEST;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMHintShow(var Msg : TCMHintShow); message CM_HINTSHOW;
    procedure IntHintShow(var HintInfo : THintInfo);
    procedure DrawDragLine(Restore : boolean);
    procedure SetBevel(newValue : TElStatusPanelBevel);

    procedure SetSimpleTextIsHTML(Value: Boolean);
    procedure SetImageList(newValue : TCustomImageList);

  protected
    // function GetThemedClassName: TLMDThemedItem; override;

    procedure TriggerPanelResizeEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelDrawEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelDblClickEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelClickEvent(Panel : TElStatusPanel); virtual;
    procedure Paint; override;
    procedure DrawPanel(Panel : TElStatusPanel); virtual;
    procedure UpdatePanels; virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image
        : TBitmap); virtual;
    procedure IntLButtonDown(X, Y : integer);
    procedure IntLButtonUp(X, Y : integer);
    procedure IntMouseMove(X, Y : integer);
    procedure InitDragLine;
    procedure DeinitDragLine;
    procedure Resize;
    override;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$endif}
    procedure Loaded; override;
    procedure ImagesChanged(Sender : TObject); virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    function PanelAtPoint(Pos : TPoint) : TElStatusPanel; virtual;
    property Canvas;
    procedure Save;
    procedure Restore;
  published
    property Images : TCustomImageList read FImageList write SetImageList;
    property Panels : TElStatusPanels read FPanels write SetPanels;
    property SimpleText : TLMDString read FSimpleText write SetSimpleText;
    property SimplePanel : Boolean read FSimplePanel write SetSimplePanel default true;

    property SimpleTextIsHTML: Boolean read FSimpleTextIsHTML write SetSimpleTextIsHTML default False;

    property SizeGrip : Boolean read FSizeGrip write SetSizeGrip default true;
    property ResizablePanels : Boolean read FResizablePanels write FResizablePanels default False;
    property Storage : TElIniFile read FStorage write FStorage;
    property StoragePath : string read FStoragePath write FStoragePath;
    property Bevel : TElStatusPanelBevel read FBevel write SetBevel default epbNone;  { Published }

    property ImageForm   : TElImageForm read FImgForm write SetImageForm;

    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}

    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property Align nodefault;
    property Color nodefault;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnPanelResize : TElPanelEvent read FOnPanelResize write FOnPanelResize;
    property OnPanelDraw : TElPanelEvent read FOnPanelDraw write FOnPanelDraw;
    property OnPanelClick : TElPanelEvent read FOnPanelClick write FOnPanelClick;
    property OnPanelDblClick : TElPanelEvent read FOnPanelDblClick write FOnPanelDblClick;

    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;

    property OnContextPopup;

    property Anchors;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property BevelKind;
    property DoubleBuffered default False;
    property DragKind;
  end;

{$ifdef LMD_UNICODE}
function ConvertHintTextW(Hint : string): WideString;
{$endif}

implementation

const
  hMargin = 2;

{$ifdef LMD_UNICODE}
function ConvertHintTextW(Hint : string): WideString;

var S : String;
    i : integer;
begin
  if Length(Hint) < 2 then
    result := Hint
  else
  {if Copy(Hint, Length(Hint) - 1, 2) = #254#255 then
    exit
  else
  }
  if Copy(Hint, Length(Hint) - 1, 2) <> #254#255 then
   Result := GetLongHint(Hint)
  else
  begin
    i := StrLen(PChar(Hint));
    S := Copy(Hint, i + 2, Length(Hint) - i - 4);
    SetLength(Result, (Length(S) - 1) shr 1);
    Move(S[1], Result[1], Length(Result) * 2);
    if LMDWidePos('|', Result) > 0 then
      result := Copy(Result, LMDWidePos('|', Result) + 1, Length(Result));
  end;
end;

{$ENDIF}

function TElStatusPanel.CalcAutoSize : integer;
var R : TRect;
begin
  if FOwner.HandleAllocated then
  begin
    SetRectEmpty(R);
    LMDDrawText(FOwner.Canvas.Handle, FText, -1, R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_CALCRECT);
    InflateRect(R, 3, 0);
    result := R.Right - R.Left;
    end
  else
    result := Width;
end;

function TElStatusPanel.CurWidth : integer;
begin
  if Visible then
    result := GetRealWidth
  else
    result := 0;
end;

procedure TElStatusPanel.SetAlignment(newValue : TAlignment);
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetBevel(newValue : TElStatusPanelBevel);
begin
  if (FBevel <> newValue) then
  begin
    FBevel := newValue;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetStyle(newValue : TElStatusPanelStyle);
begin
  if (FStyle <> newValue) then
  begin
    FStyle := newValue;
    if FStyle = epsControl then UpdateControl;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetText(newValue: TLMDString);
begin
  if (FText <> newValue) then
  begin
    FText := newValue;
    DisplayName := FText;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetWidth(newValue : Integer);
begin
  if (FWidth <> newValue) then
  begin
    FWidth := newValue;
    UpdateControl;
    Changed(true);
  end; {if}
end;

procedure TElStatusPanel.SetControl(newValue : TControl);
begin
  if NewValue = FOwner then exit;

  if (FControl <> newValue) then
  begin
    {if csDesigning in FOwner.ComponentState then
    begin
      FControl := newValue;
      FControl.Parent := FOwner;
      UpdateControl;
      exit;
    end;}
    {if FControl <> nil then
    begin
      //FControl.Parent := FOldParent;
      if FControl.Parent <> nil then
      begin
        FControl.BoundsRect := FOldBounds;
        FControl.Visible := FOldVisible;
      end;
    end;
    }
    if FControl <> nil then
    begin
      if not (csDestroying in FControl.ComponentState) then
        FControl.RemoveFreeNotification(FOwner);
      if (FOldParent <> nil) then
        if not (csDestroying in FOldParent.ComponentState) then
          FOldParent.RemoveFreeNotification(FOwner);
    end;
    FControl := newValue;
    if FControl <> nil then
    begin
      //FOldParent := FControl.Parent;
      FOldBounds := FControl.BoundsRect;
      FOldVisible := FControl.Visible;
      FCtlVisible := FControl.Visible;
      if FControl.Parent <> FOwner then
      begin
        FControl.Parent := FOwner;
        if FOldParent <> nil then
          FOldParent.FreeNotification(FOwner);
        FControl.FreeNotification(FOwner);
      end
      else
        FOldParent := nil;

      FOwner.FIgnoreSize := true;
      UpdateControl;
      FOwner.FIgnoreSize := false;
    end;
  end; {if}
end;

function TElStatusPanel.GetLeft : Integer;
begin
  if Index = 0 then
    result := 0
  else
  begin
    if Visible then
      result := TElStatusPanel(Collection.Items[Index - 1]).Right + hMargin
    else
      result := TElStatusPanel(Collection.Items[Index - 1]).Right;
  end;
end;

function TElStatusPanel.GetRight : Integer;
begin
  if Index = 0 then
    result := CurWidth
  else
    result := Left + CurWidth;
end;

procedure TElStatusPanel.Assign(Source : TPersistent);
begin
  if Source is TElStatusPanel then
    with TElStatusPanel(Source) do
    begin
      Self.FText := Text;
      Self.FWidth := Width;
      Self.FSavedWidth := FSavedWidth;
      Self.FAlignment := Alignment;
      Self.FBevel := Bevel;
      Self.FStyle := Style;
      Self.Control := Control;
      Self.FVisible := Visible;
      Self.FImageIndex := ImageIndex;
    end
  else
    inherited Assign(Source);
end;

procedure TElStatusPanel.SetImageIndex(newValue: Integer);
begin
  if FImageIndex <> newValue then
  begin
    FImageIndex := newValue;
    if FImageIndex < -1 then
      FImageIndex := -1;
    UpdateControl;
    Changed(false);
  end;
end;

procedure TElStatusPanel.SetVisible(newValue : Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    UpdateControl;
    Changed(true);
  end; {if}
end;

procedure TElStatusPanel.UpdateControl;
var
  R : TRect;
begin
  //if (csLoading in FOwner.ComponentState) then exit;
  if (FControl <> nil) and not (csDesigning in FOwner.ComponentState) then
  begin
    if FStyle <> epsControl then
      FControl.Visible := false;
      //FControl.Visible := FCtlVisible
  end;
  R := PanelRect;
  if FBevel <> epbNone then
    InflateRect(R, -2, -2);
  if (FControl <> nil) then
  begin
    if (TElStatusPanels(Collection).FStatusBar.SizeGrip) and (Self = TElStatusPanels(Collection).LastVisiblePanel) then
      R.Right := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
    FControl.BoundsRect := R;
    FControl.Visible := (not FOwner.SimplePanel) and Visible;
  end;
end;

function TElStatusPanel.GetPanelRect : TRect;
var
  R : TRect;
  i : integer;
begin
  i := Left;
  R := Rect(i, 0, i + CurWidth, TElStatusPanels(Collection).FStatusBar.ClientHeight);
//  R := Rect(i, 2, i + CurWidth, TElStatusPanels(Collection).FStatusBar.ClientHeight);
  if TElStatusPanels(Collection).FStatusBar.Bevel <> epbNone then
     InflateRect(R, -2, -2);
  result := R;
end;

procedure TElStatusPanel.SaveWidth;
begin
  if FSavedWidth <> FWidth then
    FSavedWidth := FWidth;
end;

procedure TElStatusPanel.RestoreWidth;
begin
  FWidth := FSavedWidth;
end;

procedure TElStatusPanel.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    Changed(false);
  end;
end;

procedure TElStatusPanel.SetAutoSize(newValue : Boolean);
begin
  if (FAutoSize <> newValue) then
  begin
    FAutoSize := newValue;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end;  { if }
end;  { SetAutoSize }

constructor TElStatusPanel.Create(Collection : TCollection);
begin
  FWidth := 100;
  FSavedWidth := -1;
  inherited;
  FAlignment := taLeftJustify;
  FBevel := epbLowered;
  FStyle := epsText;
  FVisible := true;
  FOwner := TElStatusPanels(Collection).FStatusBar;
  FResizable := true;
  FImageIndex := -1;
end;

destructor TElStatusPanel.Destroy;
begin
  Control := nil;
  inherited;
end;

function TElStatusPanel.GetRealWidth : Integer;
var b : boolean;
    i : integer;
begin
  b := true;
  for i := Index + 1 to Collection.Count - 1 do
    if TElStatusPanel(Collection.Items[i]).Visible then
      b := false;
  if b then
  begin
    if FOwner.Bevel <> epbNone then
      Result := FOwner.ClientWidth - Left - 2
    else
      Result := FOwner.ClientWidth - Left;
  end
  else
    Result := FWidth;
end;

function TElStatusPanels.GetItems(Index : integer) : TElStatusPanel;
begin
  result := TElStatusPanel(inherited GetItem(Index));
end;

procedure TElStatusPanels.SetItems(Index : integer; newValue : TElStatusPanel);
begin
  inherited SetItem(Index, newValue);
end;

constructor TElStatusPanels.Create(StatusBar : TElStatusBar);
begin
  inherited Create(TElStatusPanel);
  FStatusBar := StatusBar;
end;

function TElStatusPanels.Add: TElStatusPanel;
begin
  result := TElStatusPanel(inherited Add);
  Result.FOwner := FStatusBar;
  Update(Result);
end;

function TElStatusPanels.GetOwner : TPersistent;
begin
  result := FStatusBar;
end;

procedure TElStatusPanels.Update(Item : TCollectionItem);
var
  R : TRect;
  i : integer;
begin
  inherited;
  FStatusBar.UpdatePanels;
  if Item = nil then
  begin
    for i := 0 to Count - 1 do
      if Items[i].FStyle = epsControl then
        Items[i].UpdateControl;
    FStatusBar.Repaint;
    exit;
  end;
  R := TElStatusPanel(Item).PanelRect;
  InvalidateRect(FStatusBar.Handle, @R, false);
  FStatusBar.Update;
end;

function TElStatusPanels.LastVisiblePanel: TElStatusPanel;
var i : integer;
begin
  for i := Count - 1 downto 0 do
    if Items[i].Visible then
    begin
      result := Items[i];
      exit;
    end;
  Result := nil;
end;

procedure TElStatusBar.SetPanels;
begin
  FPanels.Assign(Value);
end;

procedure TElStatusBar.SetSimpleText(newValue : TLMDString);
begin
  if (FSimpleText <> newValue) then
  begin
    FSimpleText := newValue;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.SetSimplePanel(newValue : Boolean);
var i : integer;
begin
  if (FSimplePanel <> newValue) then
  begin
    FSimplePanel := newValue;
    if Panels.Count = 0 then
      FSimplePanel := true;
    for i := 0 to Panels.Count - 1 do
    begin
      if Panels[i].Control <> nil then
        Panels[i].Control.Visible := (not simplePanel) and
                                     (Panels[i].Style = epsControl);
    end;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.SetSizeGrip(newValue : Boolean);
var
  b : boolean;
  i : integer;
begin
  if (FSizeGrip <> newValue) then
  begin
    if NewValue then
    begin
      if Parent <> nil then
      begin
        if not (Parent is TForm) then exit;
        b := false;
        for i := 0 to Parent.ControlCount - 1 do
        begin
          if (Parent.Controls[i] = Self) then b := true;
          if b and (Parent.Controls[i] is TElStatusBar) and (Parent.Controls[i] <> Self) then exit;
        end;
      end;
    end;
    FSizeGrip := newValue;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.Paint;
var
  i : integer;
  R : TRect;
  RClip: TRect;
  c : integer;
  f: TCustomForm;
  ACtl  : TWinControl;
  APanel : TElStatusPanel;
  iPartId: Integer;
  ws: WideString;
  BgRect : TRect;
  lc,
  dc : TColor;
  imfk : boolean;
  //  sz: TSize;
  Bitmap :TBitmap;
  DH :HDC;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LUseThemeMode := UseThemeMode;
  Bitmap := TBitmap.Create;
  try
    R := ClientRect;
    with R do
    begin
      Bitmap.Width := Right - Left +1;
      Bitmap.Height := Bottom - Top +1;
    end;
    DH := Canvas.Handle;
    Canvas.Handle := Bitmap.Canvas.Handle;
    try
      Canvas.Font.Assign(Font);
      imfk := false;
      Canvas.Brush.Color := Color;
      RClip := Canvas.ClipRect;
      IntersectRect(RClip, Canvas.ClipRect, R);

    Canvas.FillRect(RClip);
      R := ClientRect;
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        if (FImgForm.Control <> Self) then
        begin
          ACtl := FImgForm.GetRealControl;
          BgRect := R;
          //  OffsetRect(BgRect, -Section.Left + FHPos, 0);
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
          BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
          BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
          FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
          imfk := true;
        end;
      end;
      if LUseThemeMode <> ttmNone then
      begin
        iPartId := 0;
        if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
          begin
          end
        else
          begin
            LDetails.Element := teStatus;
            LDetails.Part := iPartId;
            LDetails.State := 0;
            LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, R, LMDRectToPtr(RClip));
            R := LMDThemeServices.ContentRect(LUseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tsPane), R);
          end;
        if not IsRectEmpty(R) then
        begin
          if FSimplePanel then
          begin
            inc(R.Top, 2);

            Canvas.Brush.Style := bsClear;
            if SimpleTextIsHTML then
            begin
              FRender.Data.DefaultColor := Font.Color;
              FRender.Data.DefaultBgColor := clNone;
              FRender.Data.DefaultStyle := Font.Style;
              FRender.Data.DefaultHeight := Font.Height;
              FRender.Data.DefaultFont := Font.Name;
              FRender.Data.Charset := Font.Charset;

              FRender.PrepareText(SimpleText, 0, false);
              FRender.DrawText(Canvas, Point(0, 0), R, clNone);
            end
            else
            begin
              ws := SimpleText;
              if ws <> '' then
              begin
                LDetails.Element := teStatus;
                LDetails.Part := iPartId;
                LDetails.State := 0;
                LMDThemeServices.DrawThemeText(LUseThemeMode, Canvas.Handle, LDetails, ws, Length(ws), DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, 0, R);
              end;
            end;
          end
          else
            for i := 0 to FPanels.Count - 1 do
            begin
              R := FPanels[i].PanelRect;
              if IntersectRect(R, R, RClip) then
                DrawPanel(FPanels.Items[i]);
            end;
        end;
      end
      else
      begin

        if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
        begin
        end
        else
          Canvas.FillRect(RClip);

        if not SimplePanel then
        case Bevel of
          epbRaised:
            begin
              DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER or BDR_RAISEDOUTER, BF_TOPLEFT);
              DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
            end;
          epbLowered:
            begin
              DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
              DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);
            end;
          epbNone:
            InflateRect(R, 1, 1);
        end;
        {.$else}
        (*
        case Bevel of
          epbRaised:
            DrawEdge(Canvas, R, esRaised, esNone, [ebTop, ebLeft, ebRight, ebBottom]);
          epbLowered:
            DrawEdge(Canvas, R, esLowered, esNone, [ebTop, ebLeft, ebRight, ebBottom]);
          epbNone:
            InflateRect(R, 1, 1);
        end;
        *)
        {.$endif}
        InflateRect(R, -2, -2);
        if FSimplePanel then
        begin
          R := ClientRect;
          inc(R.Top, 2);

          DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
          DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);

          InflateRect(R, -1, -1);
          //Inc(R.Top, 2);
          if SimpleTextIsHTML then
          begin
            FRender.Data.DefaultColor := Font.Color;
            FRender.Data.DefaultBgColor := Color;
            FRender.Data.DefaultStyle := Font.Style;
            FRender.Data.DefaultHeight := Font.Height;
            FRender.Data.DefaultFont := Font.Name;
            FRender.Data.Charset := Font.Charset;

            FRender.PrepareText(SimpleText, 0, false);
            FRender.DrawText(Canvas, Point(0, 0), R, clNone);
          end
          else
          begin
            LMDDrawText(Canvas.Handle, SimpleText, -1, R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
          end;
        end
        else
        begin
          for i := 0 to FPanels.Count - 1 do
          begin
            R := FPanels[i].PanelRect;
            if IntersectRect(R, R, RClip) then
              DrawPanel(FPanels.Items[i]);
          end;
        end;
      end;
      if FSizeGrip then
      begin
        F := GetParentForm(Self);
        if (TForm(F).BorderStyle in [bsSizeable, bsSizeToolWin]) and
          not IsZoomed(f.Handle) then
        begin
          if LUseThemeMode <> ttmNone then
          begin
            R := ClientRect;
            inc(R.Top, 2);
            R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
            dec(R.Bottom);
            dec(R.Right);
            if not IsRectEmpty(R) then
            begin
              LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, tsGripper, R, LMDRectToPtr(RClip));
            end;
          end
          else
          begin
            if FSimplePanel then
            begin
              R := ClientRect;
              inc(R.Top, 2);
              InflateRect(R, -2, -2);
            end
            else
            begin
              APanel := Panels.LastVisiblePanel;
              if APanel = nil then
                R := ClientRect
              else
              begin
                R := APanel.PanelRect;
                if APanel.Bevel <> epbNone then InflateRect(R, -2, -2);
              end;
            end;
            C := R.Bottom - R.Top + 2;
            R.Left := R.Right - C;
            R.Top := R.Bottom - C;
            if (Color = clBtnFace)
            and not imfk
            then
            begin
              inc(R.Top);
              DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP)
            end
            else
            begin
              i := 4;
              C := R.Bottom - R.Top + 1;

              dec(R.Top, 2);
              dec(R.Bottom);
              if Color = clBtnFace then
                lc := clBtnHighlight
              else
                lc := ColorLighter(ColorToRGB(Color), 50);
              if Color = clBtnFace then
                dc := clBtnHighlight
              else
                dc := ColorDarker(ColorToRGB(Color), 50);

              while true do
              begin
                R.Left := R.Right - C + i;
                R.Top := R.Bottom - C + i;
                Canvas.Pen.Color := lc;
                Canvas.MoveTo(R.Left, R.Bottom);
                Canvas.LineTo(R.Right, R.Top);
                Inc(R.Left);
                Inc(R.Top);
                Canvas.Pen.Color := dc;
                Canvas.MoveTo(R.Left, R.Bottom);
                Canvas.LineTo(R.Right, R.Top);
                Inc(R.Left);
                Inc(R.Top);
                Canvas.Pen.Color := dc;
                Canvas.MoveTo(R.Left, R.Bottom);
                Canvas.LineTo(R.Right, R.Top);
                inc(i, 4);
                if i >= c then break;
              end;
            end;
            end;
        end;
      end;
    finally
      Canvas.Handle := DH;
    end;
    R := ClientRect;
    with R do
      Canvas.Draw(Left, Top, Bitmap);
    finally
    Bitmap.Free;
  end;

end;

procedure TElStatusBar.TriggerPanelResizeEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelResize)) then
    FOnPanelResize(Self, Panel);
end;

procedure TElStatusBar.TriggerPanelDrawEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelDraw)) then
    FOnPanelDraw(Self, Panel);
end;

procedure TElStatusBar.DrawPanel(Panel : TElStatusPanel);
var
  R : TRect;
  RClip: TRect;
  AL : integer;
  ws: WideString;
  F : TCustomForm;
  dy: integer;
  ds: cardinal;
  LUseThemeMode: TLMDThemeMode;
  LDetail: TThemedStatus;
  LDetails: TThemedElementDetails;
begin
  LUseThemeMode := UseThemeMode;
  R := Panel.PanelRect;
  RClip := Canvas.ClipRect;
  LDetail := tsPane;
  if not IsRectEmpty(R) then
  begin
    if LUseThemeMode <> ttmNone then
    begin
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
      end
      else
      begin
        // sp := SP_PANE;
        if FSizeGrip then
        begin
          F := GetParentForm(Self);
          if (TForm(F).BorderStyle in [bsSizeable, bsSizeToolWin]) and
            not IsZoomed(f.Handle) then
          begin
            if Panel = Panels.LastVisiblePanel then
             // sp := SP_GRIPPERPANE;
             LDetail := tsGripperPane;
          end;
        end;
        LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetail, R, LMDRectToPtr(RClip));

        R := LMDThemeServices.ContentRect(LUseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), R);

      end;
    end
    else
    begin
      if Panel.FBevel = epbLowered then
      begin

        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);
      end
      else
      if Panel.FBevel = epbRaised then
      begin

        DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER or BDR_RAISEDOUTER, BF_TOPLEFT);
        DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      end;
      InflateRect(R, -2, -2);
    end;
    if Panel.FStyle = epsOwnerDraw then
      TriggerPanelDrawEvent(Panel)
    else
    if Panel.Style = epsText then
    begin
      InflateRect(R, -1, 0);
        if IsRectEmpty(R) then Exit;
      if Assigned(Images) and LMDInRange(Panel.FImageIndex, 0, Images.Count - 1) then
      begin
          dy := max(R.Bottom - R.Top - Images.Height, 0) div 2;
          ds := ILD_NORMAL;
          case Images.DrawingStyle of
            dsTransparent: ds := ILD_TRANSPARENT;
            dsSelected: ds := ILD_SELECTED;
            dsFocus: ds := ILD_FOCUS;
          end;
          ImageList_DrawEx(FImageList.Handle, Panel.ImageIndex, Canvas.Handle, R.Left + 1, R.Top + dy, 0, 0,
            ColortoRGB(Color), clNone, ds);
          R.Left := R.Left + Images.Width + 2;
      end;
      case Panel.FAlignment of
        taCenter : AL := DT_CENTER;
        taRightJustify : AL := DT_RIGHT;
      else
        AL := DT_LEFT;
      end;
      if Panel.IsHTML then
      begin
        FRender.Data.DefaultColor := Font.Color;
        FRender.Data.DefaultBgColor := clNone;
        FRender.Data.DefaultStyle := Font.Style;
        FRender.Data.DefaultHeight := Font.Height;
        FRender.Data.DefaultFont := Font.Name;
        FRender.Data.Charset := Font.Charset;

        FRender.PrepareText(Panel.Text, 0, false);
        if FRender.Data.TextSize.cy < (R.Bottom - R.Top) then
          R.Top := R.Top + max(R.Bottom - R.Top - FRender.Data.TextSize.cy, 0) div 2;
        FRender.DrawText(Canvas, Point(0, 0), R, clNone);
      end
      else
      if LUseThemeMode <> ttmNone then
      begin
        Canvas.Brush.Style := bsClear;
        ws := Panel.Text;
        if ws <> '' then
        begin
          LDetails.Element := teStatus;
          LDetails.Part := IfThen(LDetail = tsPane, SP_PANE, SP_GRIPPERPANE);
          LDetails.State := 0;
          LMDThemeServices.DrawThemeText(LUseThemeMode, Canvas.Handle, LDetails, ws, -1, AL or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, 0, R);
        end;

        end
      else
      begin
        Canvas.Brush.Style := bsClear;
        LMDDrawText(Canvas.Handle, Panel.Text, -1, R, AL or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
      end;
    end;
  end;
end;

procedure TElStatusBar.UpdatePanels;
var i : integer;
begin
  if FPanels.Count = 0 then
    SimplePanel := true;
  for i := 0 to Panels.Count - 1 do
    Panels[i].UpdateControl;
  Invalidate;
end;

procedure TElStatusBar.Notification(AComponent : TComponent; Operation :
  TOperation);
var
  i : integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TControl) then
  begin
    for i := 0 to FPanels.Count - 1 do
    begin
      if Panels[i].Control = AComponent then Panels[i].Control := nil;
      if Panels[i].FOldParent = AComponent then Panels[i].FOldParent := nil;
    end;
  end;
end;

procedure TElStatusBar.WMERASEBKGND(var Msg : TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TElStatusBar.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;
  IntLButtonDown(Msg.XPos, Msg.YPos);
end;

procedure TElStatusBar.WMLButtonUp(var Msg : TWMLButtonUp);
begin
  inherited;
  IntLButtonUp(Msg.XPos, Msg.YPos);
end;

function TElStatusBar.PanelAtPoint(Pos : TPoint) : TElStatusPanel;
var
  i : integer;
  P : TElStatusPanel;
begin
  result := nil;
  if SimplePanel then exit;
  for i := 0 to Panels.Count - 1 do
  begin
    P := Panels[i];
    if (P.Visible) and (P.Left <= Pos.X) and (P.Right >= Pos.X) then
    begin
      result := P;
      exit;
    end;
  end;
end;

procedure TElStatusBar.WMSize(var Msg : TWMSize);
begin
  inherited;
  if not ((csLoading in ComponentState) or FIgnoreSize) then
    UpdatePanels;

//  Invalidate;
end;

procedure TElStatusBar.TriggerPanelClickEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelClick)) then FOnPanelClick(Self, Panel);
end;

procedure TElStatusBar.TriggerPanelDblClickEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelDblClick)) then FOnPanelDblClick(Self, Panel);
end;

procedure TElStatusBar.WMMouseMove(var Msg : TWMMouseMove);
begin
  inherited;
  IntMouseMove(Msg.XPos, Msg.YPos);
end;

procedure TElStatusBar.DrawDragLine;
begin
  FLineVis := not FLineVis;
  PatBlt(Canvas.Handle, FLine, 0, 1, Height, PATINVERT);
  end;

procedure TElStatusBar.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  inherited;
  TriggerPanelDblClickEvent(PanelAtPoint(Point(Msg.XPos, Msg.YPos)));
end;

procedure TElStatusBar.WMNCHitTest;
var
  P : TPoint;

  function InGrip(Point : TPoint) : boolean;
  var
    r : TRect;
  begin
    R := ClientRect;
    R.Left := R.Right - R.Bottom + hMargin;
    result := PtInRect(R, Point);
  end;

begin
  if not FSizeGrip then
  begin
    inherited;
    exit;
  end;
  P := ScreenToClient(Point(Message.XPos, Message.YPos));
  if InGrip(P) and (TForm(Parent).WindowState = wsNormal)
    and (TForm(Parent).BorderStyle in [bsSizeable, bsSizeToolWin]) then
    Message.Result := HTBOTTOMRIGHT
  else
    inherited;
end;

procedure TElStatusBar.Save;
var
  SaveKey, CKey : string;
  i : integer;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElStatusBar', true) then
    begin
      for i := 0 to FPanels.Count - 1 do // Iterate
      begin
        CKey := 'Panel' + IntToStr(i);
        FStorage.WriteBool(CKey, 'Visible', Panels[i].Visible);
        FStorage.WriteInteger(CKey, 'Width', Panels[i].Width);
      end; // for
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end; {Save}

procedure TElStatusBar.Restore;
var
  SaveKey, CKey : string;
  i, j : integer;
  b : boolean;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElStatusBar', false) then
    begin
      for i := 0 to FPanels.Count - 1 do // Iterate
      begin
        CKey := 'Panel' + IntToStr(i);
        if FStorage.ReadBool(CKey, 'Visible', true, b) then Panels[i].Visible := b;
        if FStorage.ReadInteger(CKey, 'Width', 100, j) then Panels[i].Width := j;
      end; // for
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end; {Restore}

procedure TElStatusBar.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      if (Screen.Cursor = crHSplit) and (not FPressed) then Screen.Cursor := FOldCursor;
      FHintPanel := nil;
    end;
end; {CMMouseLeave}

procedure TElStatusBar.CMHintShow(var Msg : TCMHintShow);  { private }

begin
  inherited;

  IntHintShow(Msg.HintInfo^);

end;

procedure TElStatusBar.SetBevel(newValue : TElStatusPanelBevel);
{ Sets data member FBevel to newValue. }
begin
  if (FBevel <> newValue) then
  begin
    FBevel := newValue;
  end;  { if }
end;  { SetBevel }

destructor TElStatusBar.Destroy;
begin
  FHChLink.Free;

  FRender.Free;
  FRender := nil;

  ImageForm := nil;
  FImgFormChLink.Free;
  FImgFormChLink := nil;
  inherited;
  FPanels.Free;
end;

constructor TElStatusBar.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  ControlStyle :=
    [csClickEvents, {csOpaque, }csDoubleClicks,
     csReplicatable, csAcceptsControls , csReflector];
  Color := clBtnFace;

  PInteger(@Font.Color)^ := clBtnText;  //?

  Height := 19;
  Align := alBottom;
  FPanels := TElStatusPanels.Create(Self);
  FSimplePanel := true;
  FSizeGrip := True;
  Bevel := epbNone;

  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;

  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;

  FHChLink := TChangeLink.Create;
  FHChLink.OnChange := ImagesChanged;
end;

procedure TElStatusBar.SetSimpleTextIsHTML(Value: Boolean);
begin
  if FSimpleTextIsHTML <> Value then
  begin
    FSimpleTextIsHTML := Value;
    Invalidate;
  end;
end;

procedure TElStatusBar.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }
{
function TElStatusBar.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiStatus;
end;
}

procedure TElStatusBar.IntHintShow(var HintInfo : THintInfo);
var
  Panel : TElStatusPanel;

  {$ifdef LMD_UNICODE}
  T: WideChar;
  WS: WideString;
  l : integer;
  S : String;
  {$endif}

begin
  Panel := PanelAtPoint(HintInfo.CursorPos);
  if (Panel <> nil) and (Panel.Hint <> '') then
    HintInfo.HintStr := Panel.Hint;
  FHintPanel := Panel;

  {$ifdef LMD_UNICODE}
  if (Panel <> nil) and (Panel.Hint <> '') then
    WS := Panel.Hint
  else
    WS := FHint;

  if Length(WS) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  if HintInfo.HintStr = GetShortHint(inherited Hint) then
  begin
    WS := LMDWideGetShortHint(WS);
    S := WS;
  end
  else
    S := WS;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);
  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
  {$endif}
end;

procedure TElStatusBar.IntLButtonDown(X, Y : integer);
var
  P : TElStatusPanel;
  i : integer;
begin
  P := PanelAtPoint(Point(X, Y));
  FPressed := true;
  FPressedPanel := P;
  SetCapture(Handle);
  if (P = nil) and (not SimplePanel) and FResizablePanels then
  begin
    FResizePanel := nil;
    for i := 0 to Panels.Count - 1 do
      if Panels[i].Visible and (Panels[i].Right < X) then
        FResizePanel := Panels[i];
    if (FResizePanel <> nil) and (FResizePanel.FResizable) then
    begin
      FLine := FResizePanel.Right;
      FDelta := X - FLine;
      InitDragLine;
      DrawDragLine(false);
    end
    else
      FResizePanel := nil;
  end;
end;

procedure TElStatusBar.IntLButtonUp(X, Y : integer);
begin
  ReleaseCapture;
  if (FPressedPanel <> nil) and (FResizePanel = nil) then
    TriggerPanelClickEvent(FPressedPanel)
  else
  begin
    if Screen.Cursor = crHSplit then Screen.Cursor := FOldCursor;
    if (FResizePanel = nil) then
      if Assigned(OnClick) then OnClick(Self);
  end;
  if FResizePanel <> nil then
  begin
    DrawDragLine(true);
    FResizePanel.Width := FLine - FResizePanel.Left;
    Self.TriggerPanelResizeEvent(FResizePanel);
    DeinitDragLine;
  end;
  FResizePanel := nil;
  FPressed := false;
end;

procedure TElStatusBar.IntMouseMove(X, Y : integer);

var Panel : TElStatusPanel;
    AMsg  : TMessage;
    begin
  if (FResizePanel <> nil) then
  begin
    if (X - FDelta >= FResizePanel.Left) then
    begin
      DrawDragLine(true);
      FLine := X - FDelta;
      DrawDragLine(false);
    end;
  end;
  if (not FPressed) then
  begin
    Panel := PanelAtPoint(Point(X, Y));
    if (FHintPanel <> nil) and (FHintPanel <> Panel) and (Panel <> nil) and
        ShowHint and (Panel.Hint <> '') then
    begin
      ZeroMemory(@AMsg, sizeof(AMsg));
      TWMMouse(AMsg).XPos := -10000;
      TWMMouse(AMsg).YPos := -10000;
      TWMMouse(AMsg).Msg  := WM_MOUSEMOVE;
      TWMMouse(AMsg).Keys := 0;
      TWMMouse(AMsg).Result := 0;
      Application.HintMouseMessage(Self, AMsg);
      TWMMouse(AMsg).Pos := SmallPoint(X, Y);
      Application.HintMouseMessage(Self, AMsg);
      end;
  end;

  if (not FPressed)
    and (not FSimplePanel)
    and FResizablePanels
    and (PanelAtPoint(Point(X, Y)) = nil)
    and (not (csDesigning in ComponentState)) then
  begin
    if Screen.Cursor <> crHSplit then
    begin
      FOldCursor := Screen.Cursor;
      Screen.Cursor := crHSplit;
    end
  end
  else
  if (not FPressed) and (Screen.Cursor = crHSplit) then
    Screen.Cursor := FOldCursor;
end;

procedure TElStatusBar.InitDragLine;
begin
  end;

procedure TElStatusBar.DeinitDragLine;
begin
end;

procedure TElStatusBar.Resize;
begin
  Inherited;
end;

{$ifdef LMD_UNICODE}
procedure TElStatusBar.SetHint(Value: TLMDString);

var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$ENDIF}

procedure TElStatusBar.ImageFormChange(Sender : TObject);
begin
  if (HandleAllocated) then
    Invalidate;
end;

procedure TElStatusBar.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    if HandleAllocated and (not (csDestroying in ComponentState)) then
    begin
    RecreateWnd;
      Perform(CM_COLORCHANGED, 0, 0);
    end;
  end;
end;

procedure TElStatusBar.Loaded;
begin
  inherited;
  UpdatePanels;
end;

procedure TElStatusBar.SetImageList(newValue: TCustomImageList);
begin
  if FImageList <> newValue then
  begin
    if Assigned(FImageList) then
      FImageList.UnRegisterChanges(FHChLink);
    FImageList := newValue;
    FImageList.RegisterChanges(FHChLink);
    Invalidate;
  end;
end;

procedure TElStatusBar.ImagesChanged(Sender : TObject);
begin
  if HandleAllocated then
    Invalidate;
end;

end.
