unit LMDCaptionButtons;
{$I lmdcmps.INC}

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

LMDCaptionButtons unit (RM)
---------------------------
Special component for displaying small btns in the caption of a form

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, ImgList,
  LMDClass, LMDCont, LMDBaseController, LMDCustomComponent, LMDWndProcComponent,
  LMDButtonLayout, LMD3DCaption, LMDCustomImageList, LMDDwmAPI;

type
  { ---------------------------- TLMDCaptionButton --------------------------- }
  TLMDCaptionButton = class (TCollectionItem)
  private
    FGlyph        : TBitmap;
    FLayout       : TLMDButtonLayout;
    FImageIndex,
    FGroupIndex,
    FWidth,
    FDistance     : Integer;
    FAutoSize,
    FFlat,
    FTransparent,
    FPressed,
    FVisible,
    FShowHint,
    FEnabled      : Boolean;
    FHint,
    FCaption      : String;
    FFont         : TFont;
    FFont3D       : TLMD3DCaption;
    FColor        : TColor;
    FDropDownMenu,
    FPopupMenu    : TPopupMenu;
    FRect         : TRect;
    FOnMouseEnter,
    FOnMouseExit,
    FOnClick,
    FOnDblClick   : TNotifyEvent;

    procedure SetGlyph (aValue : TBitmap);
    procedure SetLayout (aValue : TLMDButtonLayout);
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetString (index : Integer; aValue : String);
    procedure SetInteger (index, aValue : Integer);
    procedure SetColor (aValue : TColor);
    procedure Set3DCaption (aValue : TLMD3DCaption);
    procedure SetPopupMenu (aValue : TPopupMenu);
    procedure SetDropDownMenu (aValue : TPopupMenu);
    procedure SetFont (aValue : TFont);
    procedure SetEvent (index: Integer; anEvent : TNotifyEvent);
  protected
    //only needed if transparent and flat are enabled
    FBack         : TBitmap;

    procedure Notification (aComponent : TComponent; Operation : TOperation);
    procedure GetChange (Sender : TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure FreeBack;

    property DisplayRect : TRect read FRect write FRect;
    property Pressed : Boolean index 3 read FPressed write SetBoolean default false;
  published
    //autosize the button according to text and glyph width
    property AutoSize : Boolean index 6 read FAutoSize write SetBoolean default false;
    //hint text to be displayed (if Showhint is enabled) if the mouse moves above the button
    property Hint : String index 0 read FHint write SetString;
    //enable if you want to see a hint window containing the Hint string if the mouse moves above the button
    property ShowHint : Boolean index 0 read FShowHint write SetBoolean default false;
    //glyph to be displayed on the button
    property Glyph : TBitmap read FGlyph write SetGlyph;
    //Buttons with the same group index will only allow one to be pressed
    property GroupIndex : Integer index 3 read FGroupIndex write SetInteger default 0;
    property Layout : TLMDButtonLayout read FLayout write SetLayout;
    //if not enabled the button will not work (can't be clicked!)
    property Enabled : Boolean index 1 read FEnabled write SetBoolean default true;
    //text to be displayed as caption of the button
    property Caption : String index 1 read FCaption write SetString;
    //distance from this button to the pred button
    property Distance : Integer index 0 read FDistance write SetInteger default 0;
    //if you assign a popupmenu here this menu will drop down if the button is clicked
    property DropDownMenu : TPopupMenu read FDropDownMenu write SetDropDownMenu;
    //width of the button, if width is -1 the buttons will have the same width and height
    property Width : Integer index 1 read FWidth write SetInteger default -1;
    //if not visible the button will not be painted
    property Visible : Boolean index 2 read FVisible write SetBoolean default true;
    //color of the button background
    property Color : TColor read FColor write SetColor default clBtnFace;
    //font 3D effects of the button caption
    property Font3D : TLMD3DCaption read FFont3D write Set3DCaption;
    //this menu will be opened if the right mouse button is clicked above the button
    property PopupMenu : TPopupMenu read FPopupMenu write SetPopupMenu;
    //font settings of the button caption
    property Font : TFont read FFont write SetFont;
    //if transparent is true the button will not fill its background and the caption bar background is used
    property Transparent : Boolean index 4 read FTransparent write SetBoolean default false;
    //if flat is enabled the buttons will have no border til the mouse moves above them
    property Flat : Boolean index 5 read FFlat write SetBoolean default false;
    //the glyph can be taken from an imagelist, this property specifies the image number
    property ImageIndex : Integer index 2 read FImageIndex write SetInteger default -1;

    property OnClick : TNotifyEvent index 0 read FOnClick write SetEvent;
    property OnDblClick : TNotifyEvent index 1 read FOnDblClick write SetEvent;
    property OnMouseEnter : TNotifyEvent index 2 read FOnMouseEnter write SetEvent;
    property OnMouseExit : TNotifyEvent index 3 read FOnMouseExit write SetEvent;
  end;

  { ------------------------------- TLMDCapButtons --------------------------- }
  TLMDCapButtons = class (TCollection)
  private
    FOwner  : TLMDWndProcComponent;
    function GetItem(Index: Integer): TLMDCaptionButton;
    procedure SetItem(Index: Integer; Value: TLMDCaptionButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure SwitchSiblings (ofBtn : Integer);
    procedure FreeBacks;
  public
    constructor Create(Owner : TLMDWndProcComponent);
    destructor Destroy; override;
    function Add: TLMDCaptionButton;
    property Items[Index: Integer]: TLMDCaptionButton read GetItem write SetItem; default;
  end;

  TLMDCaptionButtonAlignment = (cbLeft, cbRight);

  TLMDCaptionButtonClickEvent = procedure (Sender : TObject; Index : Integer) of object;

  { --------------------------- TLMDCaptionButtons --------------------------- }
  TLMDCaptionButtons = class(TLMDWndProcComponent)
  private
    FCapButtons : TLMDCapButtons;
    FAlignment  : TLMDCaptionButtonAlignment;
    FHintTimerId: TLMDTimer;
    FMouseAbove,
    FToRelease  : Integer;
    FOnMouseEnter,
    FOnMouseExit,
    FOnDblClick,
    FOnClick    : TLMDCaptionButtonClickEvent;
    FImageList  : TCustomImageList;
    FListIndex  : Integer;
    FChangeLink : TChangeLink;
    HintWnd     : THintWindow;

    //needed internally
    FCurrentHint: String;
    FHintRect   : TRect;
    FUseGlobalTimer: Boolean;

    procedure SetCapButtons (aValue : TLMDCapButtons);
    procedure SetAlignment (aValue : TLMDCaptionButtonAlignment);
    procedure SetMouseAbove (aValue : Integer);
    procedure SetImageList (aValue : TCustomImageList);
    procedure SetIndex (aValue : Integer);
  protected
    //-- 7.02 --
    procedure DoThemeChange;
    function UseXP: Boolean;
    //--

    function HasControl : Boolean;
    procedure GetIMLChange(Sender:TObject);
    procedure DrawButton (index : Integer; toCanvas : TCanvas);
    procedure DrawButtons;
    procedure WndProc(var Message: TMessage); override;
    procedure DesignEnabledChanged; override;
    procedure EnabledChanged; override;
    procedure Click (index : Integer);
    procedure DblClick (index : Integer);
    procedure UnClick;
    property MouseAbove : Integer read FMouseAbove write SetMouseAbove;
    property Alignment : TLMDCaptionButtonAlignment read FAlignment write SetAlignment default cbRight;
    procedure Loaded; override;
    procedure Notification (aComponent : TComponent; Operation : TOperation); override;
    procedure ActivateHideTimer;
    procedure DoHideTimerEvent(Sender : TObject);
    procedure ActivateHint;
    procedure DoTimerEvent(Sender : TObject);
    procedure RemoveTimer;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure NCPaint;
  published
    property About;
    //make caption buttons visble at design time
    property Enabled;
    property DesignEnabled;
    property Buttons : TLMDCapButtons read FCapButtons write SetCapButtons;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ListIndex:Integer read FListIndex write SetIndex default 0;
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
    property OnClick : TLMDCaptionButtonClickEvent read FOnClick write FOnClick;
    property OnDblClick : TLMDCaptionButtonClickEvent read FOnDblClick write FOnDblClick;
    property OnMouseEnter : TLMDCaptionButtonClickEvent read FOnMouseEnter write FOnClick;
    property OnMouseExit : TLMDCaptionButtonClickEvent read FOnMouseExit write FOnDblClick;
  end;

implementation

uses
  Types,
  UxTheme, Themes,
  LMDProcs, LMDGraphUtils, LMDGraph, LMDSysIn, LMDThemes;

{ ---------------------- private --------------------------------------------- }
procedure TLMDCaptionButton.SetGlyph (aValue : TBitmap);
begin
  FGlyph.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetLayout (aValue : TLMDButtonLayout);
begin
  FLayout.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0: FShowHint := aValue;
    1: if FEnabled <> aValue then
         begin
           FEnabled := aValue;
           Changed (false);
         end;
    2: if FVisible <> aValue then
         begin
           FVisible := aValue;
           Changed (true);
         end;
    3: if FPressed <> aValue then
         begin
           if GroupIndex <> 0 then
             TLMDCapButtons(Collection).SwitchSiblings (self.Index);
           FPressed := aValue;
           Changed (false);
         end;
    4: if FTransparent <> aValue then
         begin
           FTransparent := aValue;
           Changed (false);
         end;
    5: if FFlat <> aValue then
         begin
           FFlat := aValue;
           Changed (false);
         end;
    6: if FAutoSize <> aValue then
         begin
           FAutoSize := aValue;
           Changed (true);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetString (index : Integer; aValue : String);
begin
  case index of
    0: FHint := aValue;
    1: if FCaption <> aValue then
         begin
           FCaption := aValue;
           GetChange (self);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetInteger (index, aValue : Integer);
begin
  case index of
    0: if FDistance <> aValue then
         begin
           FDistance := aValue;
           Changed (true);
         end;
    1: if FWidth <> aValue then
         begin
           FWidth := aValue;
           Changed (true);
         end;
    2: if FImageIndex <> aValue then
         begin
           FImageIndex := aValue;
           GetChange (self);
         end;
    3: if FGroupIndex <> aValue then
         begin
           FGroupIndex := aValue;
           Changed (true);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetColor (aValue : TColor);
begin
  if FColor <> aValue then
    begin
      FColor := aValue;
      Changed (false);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.Set3DCaption (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetPopupMenu (aValue : TPopupMenu);
begin
  FPopupMenu := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetDropDownMenu (aValue : TPopupMenu);
begin
  FDropDownMenu := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.SetEvent (index : Integer; anEvent : TNotifyEvent);
begin
  case index of
    0 : FOnClick := anEvent;
    1 : FOnDblClick := anEvent;
    2 : FOnMouseEnter := anEvent;
    3 : FOnMouseExit := anEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.Notification (aComponent : TComponent; Operation : TOperation);
begin
  if (Operation = opRemove) and (aComponent = FPopupMenu) then
    FPopupMenu := nil;
  if (Operation = opRemove) and (aComponent = FDropDownMenu) then
    FDropDownMenu := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.GetChange (Sender : TObject);
begin
  if FAutoSize then
    Changed (true)
  else
    Changed (false);
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDCaptionButton.Create(Collection: TCollection);
begin
  FWidth := -1;
  FDistance := 0;
  FColor := clBtnFace;
  FFlat := false;
  FEnabled := true;
  FShowHint := false;
  FTransparent := false;
  FVisible := true;
  FAutoSize := false;
  inherited Create (Collection);

  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GetChange;
  FLayout := TLMDButtonLayout.Create;
  FLayout.OnChange := GetChange;
  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;
  FFont := TFont.Create;
  FFont.OnChange := GetChange;
  FBack := nil;
  FPopupMenu := nil;
  FDropDownMenu := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCaptionButton.Destroy;
begin
  if FBack <> nil then
    begin
      FBack.Free;
      FBack := nil;
    end;

  FFont.OnChange := nil;
  FFont.Free;
  FFont3D.OnChange := nil;
  FFont3D.Free;
  FLayout.OnChange := nil;
  FLayout.Free;
  FGlyph.OnChange := nil;
  FGlyph.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.Assign(Source: TPersistent);
var
  S: TLMDCaptionButton;
begin
  if Source is TLMDCaptionButton then
    begin
      S := TLMDCaptionButton(Source);
      Caption := S.Caption;
      Hint := S.Hint;
      Glyph.Assign (S.Glyph);
      Enabled := S.Enabled;
      Visible := S.Visible;
      Transparent := S.Transparent;
      Distance := S.Distance;
      ShowHint := S.ShowHint;
      Flat := S.Flat;
      Color := S.Color;
      Font.Assign (S.Font);
      Font3D.Assign (S.Font3D);
      Layout.Assign (S.Layout);
      Width := S.Width;
      AutoSize := S.AutoSize;
      OnClick := S.OnClick;
      OnDblClick := S.OnDblClick;
      OnMouseEnter := S.OnClick;
      OnMouseExit := S.OnClick;
      PopupMenu :=S.PopupMenu;
      DropDownMenu:=S.DropDownMenu;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButton.FreeBack;
begin
  if Assigned (FBack) then
    FBack.Free;
  FBack := nil;
end;

{ ******************* TLMDCapButtons ************************************* }
function TLMDCapButtons.GetItem(Index: Integer): TLMDCaptionButton;
begin
  result := TLMDCaptionButton(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCapButtons.SetItem(Index: Integer; Value: TLMDCaptionButton);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCapButtons.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCapButtons.Update(Item: TCollectionItem);
begin
  if (csDesigning in FOwner.ComponentState) and not TLMDCaptionButtons(FOwner).DesignEnabled then exit;
  if Item <> nil then
    TLMDCaptionButtons(FOwner).DrawButton (Item.index, nil)
  else
    //TLMDCaptionButtons(FOwner).DrawButtons;
    //changed 15 Jan 2001, JH, otherwise a width (width gets smaller) change of
    //a btn will cuase btns rests in the form caption!
    RedrawWindow(TLMDCaptionButtons(FOwner).WndHandle, nil, 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCapButtons.SwitchSiblings (ofBtn : Integer);
var
  gi,
  i : Integer;
begin
  if ofBtn >= Count then exit;
  gi := Items[ofBtn].GroupIndex;
  for i := 0 to Count - 1 do
    if (Items[i].GroupIndex = gi) and (Items[i].Pressed) and (i <> ofBtn) then
      begin
        Items[i].Pressed := false;
        TLMDCaptionButtons(FOwner).DrawButton (i, nil);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCapButtons.FreeBacks;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].FreeBack;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCapButtons.Create(Owner : TLMDWndProcComponent);
begin
  inherited Create(TLMDCaptionButton);
  FOwner := Owner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCapButtons.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCapButtons.Add: TLMDCaptionButton;
begin
  result := TLMDCaptionButton(inherited Add);
end;

{ ********************** TLMDCaptionButtons ********************************** }

{ -------------------------- private ----------------------------------------- }
procedure TLMDCaptionButtons.SetCapButtons (aValue : TLMDCapButtons);
begin
  FCapButtons.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.SetAlignment (aValue : TLMDCaptionButtonAlignment);
begin
  FAlignment := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.SetMouseAbove (aValue : Integer);
var
  i : Integer;
  aRect:TRect;
begin
  if aValue <> FMouseAbove then
    begin
      //hide the hint window whenever the btn changed the mouse is currently above
      HintWnd.ReleaseHandle;
      UnClick;
      if FMouseAbove <> -1 then
        begin
          if Assigned (FCapButtons[FMouseAbove].OnMouseExit) then FCapButtons[FMouseAbove].OnMouseExit (FCapButtons[FMouseAbove]);
          if Assigned (FOnMouseExit) then FOnMouseExit (self, FMouseAbove);
          if FCapButtons[FMouseAbove].Flat or UseXP then
            begin
              i := FMouseAbove;
              FMouseAbove := -1;
              DrawButton (i, nil);
            end;
        end;
      FMouseAbove := aValue;
      if FMouseAbove <> -1 then
        begin
          //if there is a hint available show it
          if (FCapButtons[FMouseAbove].Hint <> '') and (FCapButtons[FMouseAbove].ShowHint) then
            begin
              aRect := Rect (0,0,1000,1000);
              LMDDrawTextCalcExt (HintWnd.Canvas, FCapButtons[FMouseAbove].Hint, nil, aRect, HintWnd.Canvas.Font, true, false, 0, 0);
              OffSetRect (aRect, FCapButtons[FMouseAbove].FRect.Right + WndOwner.Left, FCapButtons[FMouseAbove].FRect.Bottom + WndOwner.Top);
              inc(aRect.Right, 4);

              FHintRect := aRect;
              FCurrentHint := FCapButtons[FMouseAbove].Hint;

              //activate the timer which will wait Application.HintPause ms before displaying the hint
              ActivateHint;
            end;
          if Assigned (FOnMouseEnter) then FOnMouseEnter (self, FMouseAbove);
          if Assigned (FCapButtons[FMouseAbove].OnMouseEnter) then FCapButtons[FMouseAbove].OnMouseEnter (FCapButtons[FMouseAbove]);
          if FCapButtons[FMouseAbove].Flat or UseXP then
            DrawButton (FMouseAbove, nil);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionButtons.SetImageList(aValue : TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionButtons.SetIndex(aValue : Integer);
begin
  if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  if FImageList<>nil then
    GetIMLChange(nil);
end;

{ --------------------------- proctected ------------------------------------- }
procedure TLMDCaptionButtons.DoThemeChange;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionButtons.UseXP: Boolean;
begin
  result:=LMDApplication.UseXPThemes;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCaptionButtons.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionButtons.GetIMLChange(Sender:TObject);
begin
  GetChange(sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DrawButton (index : Integer; toCanvas : TCanvas);
var
  paintDC : HDC;
  aRect: TRect;
  hCanvas : TCanvas;
  rgn : HRGN;
  styles : TLMDDrawTextStyles;
  g      : TBitmap;
  flag   : Word;
  //button   : TThemedWindow;
begin
  //if there is no canvas we shall paint to create one
  if toCanvas = nil then
    begin
      paintDC := GetWindowDC (WndHandle);
      hCanvas := TCanvas.Create;
      hCanvas.Handle := paintDC;
    end
  else
    begin
      paintDC:=0;
      hCanvas := toCanvas;
    end;

  if not Assigned(hCanvas) then exit;

  aRect := FCapButtons[index].DisplayRect;

  //if this is a transparent button we nedd to save the back (TLMDFormStyler could have painted something there :-])
  if FCapButtons[index].Transparent then
    if (FCapButtons[index].FBack = nil) then //we have to store the back once
      begin
        FCapButtons[index].FBack := TBitmap.Create;
        FCapButtons[index].FBack.Width := aRect.Right - aRect.Left;
        FCapButtons[index].FBack.Height := aRect.Bottom - aRect.Top;

        FCapButtons[index].FBack.Canvas.CopyRect (FCapButtons[index].FBack.Canvas.ClipRect, hCanvas, aRect);
      end
    else //or (in the other cases) have to restore the back
      hCanvas.CopyRect (aRect, FCapButtons[index].FBack.Canvas, FCapButtons[index].FBack.Canvas.ClipRect);

  //if the button is not transparent paint back
  hCanvas.Brush.Color := FCapButtons[index].Color;
  if (not FCapButtons[index].Transparent) then
    hCanvas.FillRect (aRect);

  if UseXP then
    begin
      flag := CBS_NORMAL;
      if FMouseAbove = index then
        flag := CBS_HOT;
      if FCapButtons[index].Pressed then
        flag := CBS_PUSHED;
      if IsThemePartDefined (ThemeServices.Theme[teWindow], WP_SYSBUTTON, flag) then
        DrawThemeBackGround (ThemeServices.Theme[teWindow], hCanvas.Handle, WP_SYSBUTTON, flag, aRect, nil)
      else
        if FCapButtons[index].Pressed then
          LMDDrawStdFrame (hCanvas, aRect, lsLoweredExt{lsLoweredSpb}, 0)
        else
          if (not FCapButtons[index].Flat) or (FMouseAbove = index) then
            LMDDrawStdFrame (hCanvas, aRect, lsRaisedExt{lsRaisedSpb}, 0);
      {button := twSysButtonNormal;
      if FMouseAbove = index then
        button := twSysButtonHot;
      if FCapButtons[index].Pressed then
        button := twSysButtonPushed;

      if IsThemePartDefined (ThemeServices.Theme[teWindow], WP_SYSBUTTON, flag) then
        LMDThemeServices.DrawElement(ttmPlatform, hCanvas.Handle, button, aRect)}
    end
  else
    begin
      //paint button bevel
      if FCapButtons[index].Pressed then
        LMDDrawStdFrame (hCanvas, aRect, lsLoweredExt{lsLoweredSpb}, 0)
      else
        if (not FCapButtons[index].Flat) or (FMouseAbove = index) then
          LMDDrawStdFrame (hCanvas, aRect, lsRaisedExt{lsRaisedSpb}, 0);
    end;
  //paint glyph and caption
  InflateRect (aRect, 1, 1);

  rgn := CreateRectRgnIndirect (aRect);
  SelectClipRgn (hCanvas.Handle, rgn);

  hCanvas.Font := FCapButtons[index].Font;

  if FCapButtons[index].Enabled then
    styles := [dtEnabled]
  else
    styles := [];

  if (FImageList = nil) or ((Assigned (FCapButtons[index].Glyph)) and (not FCapButtons[index].Glyph.Empty)) then
    LMDDrawTextAndGlyph (hCanvas, FCapButtons[index].Caption, FCapButtons[index].Font3D, aRect, FCapButtons[index].Glyph, nil, FCapButtons[index].Layout, false, false, true, styles, 0)
  else
    begin
      g := TBitmap.Create;
      try
        LMDIMLItemBitmap(FImageList, FListIndex, FCapButtons[index].ImageIndex, g);
        LMDDrawTextAndGlyph (hCanvas, FCapButtons[index].Caption, FCapButtons[index].Font3D, aRect, g, nil, FCapButtons[index].Layout, false, false, true, styles, 0)
      finally
        g.Free;
      end;
    end;

  //clear all allocated things
  if Rgn<>0 then
    if DeleteObject(Rgn) then SelectClipRgn(hCanvas.Handle, 0);

  if toCanvas = nil then
    begin
      ReleaseDC (Wndhandle, paintDC); //added by JH Feb 2002
      hCanvas.Handle := 0;
      hCanvas.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DrawButtons;
var
  x, x2,
  w,
  i : Integer;
  flags : Word;
  dRect,
  rText,
  aRect : TRect;
  toCanvas : TCanvas;
  g : TBitmap;
begin
  if not IsWindowVisible (WndHandle) then exit; //JH Jan 2002, added, otherwise
                                                //this method will be called in XP
                                                //before the window is visible
                                                //this prevents correct transparency
  //paint all buttons -> create one canvas for all
  toCanvas := TCanvas.Create;
  try
    toCanvas.Handle := GetWindowDC (WndHandle);

    //get caption bar parameters
    flags := 0;
    LMDNCCalcDrawingArea(WNDHandle, dRect, rText, flags);

    InflateRect (dRect, -2, -2);

    x := 0; //and the compiler will be happy ...
    case FAlignment of
      cbLeft : x := rText.Left; //+ Width of Text
      cbRight : x := rText.Right;
    end;

    //paint each button
    for i := 0 to FCapButtons.Count - 1 do
      if FCapButtons[i].Visible then
        begin
          w := dRect.Bottom - dRect.Top + 2;
          if FCapButtons[i].Width <> -1 then
            w := FCapButtons[i].Width;

          if FCapButtons[i].FAutoSize then
            begin
              aRect := Rect (0, dRect.Top, 1000, dRect.Bottom);
              if (FImageList = nil) or ((Assigned (FCapButtons[i].Glyph)) and (not FCapButtons[i].Glyph.Empty)) then
                begin
                  rText := Rect (0, 0, FCapButtons[i].Glyph.Width, FCapButtons[i].Glyph.Height);
                  LMDDrawTextAndGlyphExt(toCanvas, FCapButtons[i].Caption, FCapButtons[i].Font3D, aRect, FCapButtons[i].Glyph.Canvas, rText, nil, FCapButtons[i].Glyph.TransparentColor,FCapButtons[i].Layout, false, false, true, [dtCalculate], 0)
                end
              else
                begin
                  g := TBitmap.Create;
                  try
                    LMDIMLItemBitmap(FImageList, FListIndex, FCapButtons[i].ImageIndex, g);
                    rText := Rect (0, 0, g.Width, g.Height);
                    LMDDrawTextAndGlyphExt(toCanvas, FCapButtons[i].Caption, FCapButtons[i].Font3D, aRect, g.Canvas, rText, nil, g.TransparentColor,FCapButtons[i].Layout, false, false, true, [dtCalculate], 0);
                  finally
                    g.Free;
                  end;
                end;
              w := rText.Right - rText.Left;
            end;

          x2 := 0;
          case FAlignment of
            cbLeft : begin inc (x, FCapButtons[i].Distance); x2 := x; inc (x2, w); end;
            cbRight : begin dec (x, FCapButtons[i].Distance); x2 := x; dec (x2, w); end;
          end;
          if x < x2 then
            aRect := Rect (x, dRect.Top, x2, dRect.Bottom)
          else
            aRect := Rect (x2, dRect.Top, x, dRect.Bottom);

          FCapButtons[i].DisplayRect := aRect;

          DrawButton (i, toCanvas);

          x := x2;
        end
      else
        FCapButtons[i].DisplayRect := Rect (0,0,0,0);
  finally
    //clear all allocated ressorces
    ReleaseDC (WndHandle, toCanvas.Handle); //added by JH Feb 2002
    toCanvas.Handle := 0;
    toCanvas.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.WndProc(var Message: TMessage);
var
  i : Integer;
  yPoint : TPoint;
  {$ifdef LMDX64}
  mPoint : TPoint;
  {$else}
  mPoint : TSmallPoint;
  {$endif}
  tempMsg:TMsg;

  procedure getButton;
  begin
    i := 0;

    {$ifdef LMDX64}
    mPoint := TPoint(Message.lParam);
    {$else}
    mPoint := TSmallPoint(Message.lParam);
    {$endif}

    yPoint := {WndOwner.ScreenToClient} (Point(mPoint.x - WndOwner.Left, mPoint.y - WndOwner.Top));

    //***
    //the following lines will recalculate the mouse pos by the owning MDI form left, top parameters
    //because MDI child window coordinates are always relative to this form ...
    if WndOwner.FormStyle = fsMDIChild then
      begin
        yPoint := (Point(yPoint.x - Application.MainForm.Left, yPoint.y - Application.MainForm.Top));

        //take away the height of the MDI parent form's caption bar
        yPoint.Y := yPoint.Y - GetSystemMetrics (SM_CYCAPTION);

        //border calculation (of MDI parent and child form)
        dec (yPoint.X, GetSystemMetrics (SM_CXFIXEDFRAME)*2);
        dec (yPoint.Y, GetSystemMetrics (SM_CYFIXEDFRAME)*2);
      end;

    while (i < FCapButtons.Count) and not (PtInRect (FCapButtons[i].DisplayRect, yPoint)) do
      inc(i);
  end;

begin

  case Message.Msg of
//    WM_SIZE: RedrawWindow(WndHandle, nil, 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
//    WM_ACTIVATE,
    WM_NCActivate,
    WM_NCPAINT : begin
                   inherited WndProc (Message);
                   //remove any existing background bitmaps (JH Jan 2002)
                   FCapButtons.FreeBacks;
                   UnClick;
                   DrawButtons;
                   exit;
                 end;
    WM_NCLBUTTONDOWN :
                 begin
                   getButton;
                   if i < FCapButtons.Count then
                     MouseAbove := i
                   else
                     MouseAbove := -1;
                   if (i < FCapButtons.Count) and FCapButtons[i].Enabled then
                     begin
                       //added June 04, JH
                       //without this line a non focused window will not get
                       //focused (as it usually happens as soon as you click
                       //on the caption bar)
                       WndOwner.SetFocus;
                       //this line hides the hint window if a btn has been clicked
                       HintWnd.ReleaseHandle;
                       Click (i);
                       yPoint := Point(FCapButtons[i].DisplayRect.Left, FCapButtons[i].DisplayRect.Bottom);
                       ClientToScreen (WndHandle, yPoint);
                       yPoint.Y := yPoint.Y - (WndOwner.Height - WndOwner.ClientHeight) + (WndOwner.Width - WndOwner.ClientWidth) div 2;
                       yPoint.X := yPoint.X - (WndOwner.Width - WndOwner.ClientWidth) div 2;
                       if (FCapButtons[i].DropDownMenu <> nil) then
                         begin
                           FCapButtons[i].DropDownMenu.Popup (yPoint.X, yPoint.Y);
                           //added by JH, June 04
                           while PeekMessage(tempMsg,HWND(0),WM_MOUSEFIRST,WM_MOUSELAST,PM_REMOVE) do ;
{                          if GetCapture<>0 then  ????????????????????
                           SendMessage(GetCapture,WM_CANCELMODE,0,0);}
                           MouseAbove := -1;
                           //til here - these line take care of an opened popupmenu
                           //so that the menu is closed BEFORE anything else can happen
                         end;
                       exit;
                     end;
                 end;
    WM_NCRBUTTONDOWN :
                 begin
                   getButton;
                   if (i < FCapButtons.Count) and (FCapButtons[i].PopupMenu <> nil) then
                     begin
                       FCapButtons[i].PopupMenu.Popup (mPoint.X, mPoint.Y);
                       exit;
                     end;
                 end;
    WM_NCLBUTTONDBLCLK :
                 begin
                   getButton;
                   if i < FCapButtons.Count then
                     begin
                       DblClick (i);
                       exit;
                     end;
                 end;
    WM_MOUSELEAVE : MouseAbove := -1;
    WM_MOUSEMOVE,
    WM_NCMOUSEMOVE :
                 begin
                   getButton;
                   if i < FCapButtons.Count then
                     MouseAbove := i
                   else
                     MouseAbove := -1;
                 end;
    WM_NCLBUTTONUP :
                 begin
                   if FToRelease <> -1 then
                     begin
                       if Assigned (FCapButtons[FToRelease].OnClick) then FCapButtons[FToRelease].OnClick (FCapButtons[FToRelease]);
                       if Assigned (FOnClick) then FOnClick (self, FToRelease);
                     end;
                   UnClick;
                 end;
    WM_KILLFOCUS :
                begin
                  //added for ensxuring that on focus loss the buttons are redrawn!!
                  MouseAbove := -1;
                  UnClick;

                  //if the form looses the focus (another one is brought to front)
                  //we should hide the hint window
                  if Assigned (HintWnd) then //if added April 02, otherwise, if designenabled was true an av was raised during design time on focus remove ...
                    HintWnd.ReleaseHandle;
                end;
    WM_THEMECHANGED :
                begin
                  //restore saved button backgrounds
                  DoThemeChange; //vb aug 2005
                  FCapButtons.FreeBacks;
                end;
  end;
  inherited WndProc (Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DesignEnabledChanged;
begin
  inherited DesignEnabledChanged;
  RedrawWindow(WndHandle, nil, 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.EnabledChanged;
begin
   if LMDSIWindowsVistaUp then
     if Enabled then
       begin
          if LMDWndIsDwmEnabled(WndHandle) then
            LMDWndDwmDisable(WndHandle);
       end
     else
       begin
         if LMDDwmEnabled and not LMDWndIsDwmEnabled(WndHandle) then
           LMDWndDwmEnable(WndHandle);
       end;

  //repaint form caption
  NCPaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.Click (index : Integer);
begin
  FCapButtons[index].Pressed := true;
  FToRelease := index;
  DrawButton (index, nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DblClick (index : Integer);
begin
  if Assigned (FCapButtons[index].OnDblClick) then FCapButtons[index].OnDblClick (FCapButtons[index]);
  if Assigned (FOnDblClick) then FOnDblClick (self, index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.UnClick;
begin
  if FToRelease <> -1 then
    begin
      if FCapButtons[FToRelease].GroupIndex = 0 then
        begin
          FCapButtons[FToRelease].Pressed :=false;
          DrawButton (FToRelease, nil);
        end;
      //if group btn release will be done in OnClick of another button of this group
      FToRelease := -1;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.ActivateHideTimer;
begin
  //remove any existing timer
  RemoveTimer;
  //HintHidePause is given in ms
  FHintTimerId:=TLMDTimer.Create(Application.HintHidePause, DoHideTimerEvent, true, FUseGlobalTimer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DoHideTimerEvent(Sender : TObject);
begin
  HintWnd.ReleaseHandle;
  //let's remove the timer for saving ressources
  RemoveTimer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.RemoveTimer;
begin
  //if no timer get out here
  if not Assigned(FHintTimerId) then exit;
  //remove the currently running timer -> showhint or hidehint
  FHintTimerId.Enabled:=False;
  //let's remove the timer
  FreeAndNil(FHintTimerId);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.ActivateHint;
begin
  //perhaps there is already a timer running -> let's remove it
  RemoveTimer;
  //HintPause is given in ms, let's fetch a new timer
  FHintTimerId:=TLMDTimer.Create(Application.HintPause, DoTimerEvent, true, FUseGlobalTimer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.DoTimerEvent(Sender : TObject);
begin
  //deactivate the timer -> only needs to be executed once!
  FHintTimerId.Enabled := false;

  HintWnd.ActivateHint (FHintRect, FCurrentHint);

  //let's activate the hide timer -> will stop and remove the show timer itself
  ActivateHideTimer;
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDCaptionButtons.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FHandleMDI := true;
  //owner is TForm otherwise inherited create will cancel
  FMouseAbove := -1;
  FToRelease := -1;
  FCapButtons := TLMDCapButtons.Create (self);
  FAlignment := cbRight;

  FListIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;

  HintWnd := nil;
  FHintTimerId:=nil;
  //HintWnd := THintWindow.Create(self); rem JH 20.03.01
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCaptionButtons.Destroy;
begin
  if Assigned(HintWnd) then
    HintWnd.Free;
  HintWnd := nil;

  RemoveTimer;

  FChangeLink.OnChange:=nil;
  FChangeLink.Free;
  FChangeLink := nil;

  FCapButtons.Free;
  FCapButtons := nil;

  //15 Jan 2001, JH:
  //if the component is to be deleted the form caption should be repainted
  //otherwise some btns could stay there ...
  if (csDesigning in ComponentState) and DesignEnabled then
    RedrawWindow(WndHandle, nil, 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionButtons.NCPaint;
begin
  if ValidOwner then
    SendMessage(WndOwner.Handle,WM_NCPaint,0,0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.Loaded;
begin
  inherited Loaded;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(ImageList) or
     LMDIsGlobalIdent(ImageList) then GetIMLChange(nil);
  //Let's create a hint window according to the global hint window style
  //Note: The global hint class must be set before this is called =>
  //      a hint component must be created before this one!!!
  HintWnd := HintWindowClass.Create(Self); //added JH 20.03.01
  HintWnd.Color := Application.HintColor;
  // 7.11
  if LMDDwmEnabled and Enabled and LMDWndIsDwmEnabled(WndHandle) then
    LMDWndDwmDisable(WndHandle);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionButtons.Notification (aComponent : TComponent; Operation : TOperation);
var
  i : Integer;
begin
  inherited Notification (aComponent, Operation);
  if FCapButtons <> nil then
    for i := 0 to FCapButtons.Count - 1 do
      FCapButtons[i].Notification (aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end;

end.
