unit LMDCustomHeaderPanel;
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

LMDCustomHeaderPanel unit (JH)
------------------------------

Header panel control This panel can be hidden and redisplayed Displaying usually
knows two modes * unpinned: control will be closed again after selecting something
* pinned: control gets part of the parent control list, stays open until closed
again The TLMDHeaderPanelButton component is a default control button for this
component (for recalling the panel after it is close - it can be used - but must not).

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, Menus,
  LMDButtonBase, LMDMain, LMDCustomPanelFill, LMDSpeedButton, LMDGraph, LMDBevel;

type

  TLMDSysButtonMode = (sbPin, sbClose);
  TLMDHeaderOption = (hoHeaderButton, hoHideSysButton);
  TLMDHeaderOptions = set of TLMDHeaderOption;

  TLMDCloseEvent = procedure (Sender: TObject; wasPinned: Boolean) of object;

  TLMDCustomHeaderPanel= class(TLMDCustomPanelFill)
  private
    FBorderWidth,
    FHeaderHeight,
    FRealHeaderHeight : Integer;
    FHeaderButton,
    FSysButton        : TLMDSpeedButton;
    FDropMenu         : TPopupMenu;
//    FHTransparent,
    FShowMode         : Boolean;
    FBtnStyle         : TLMDUserButtonStyle;
    FSysBtnMode       : TLMDSysButtonMode;
    FOnClose          : TLMDCloseEvent;
    FHeaderOptions    : TLMDHeaderOptions;
    FOnModeChange,
    FOnHButton,
    FOnSButton,
    FOnOpen,
    FOnOpenFixed      : TNotifyEvent;
    FOldParentControl : TWinControl;

    FContainer           : TForm;
    FOldTransparent      : Boolean;
    FOldAlign            : TAlign;
    FOldPos              : TPoint;
    FOldParentRect       : TRect;
    FOldBevel            : TLMDBevel;

    procedure SetHeaderHeight(aValue: Integer);
    function  GetStyle: TLMDUserButtonStyle;
    procedure SetStyle(const aValue: TLMDUserButtonStyle);
    procedure SetDropMenu(aValue: TPopupMenu);
    procedure SetSysBtnMode(aValue: TLMDSysButtonMode);
    procedure SetHeaderOptions (aValue: TLMDHeaderOptions);

    function GetPinned: Boolean;
    function GetUnPinned: Boolean;

    procedure SetBorderWidth(aValue: Integer);
//    procedure DoHeaderFontChange(Sender: TObject);

    //header buttons OnClick event handlers
    procedure DoHeaderButtonClick(Sender: TObject);
    procedure DoHeaderButtonMouseDown(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState; X, Y: Integer);
    procedure DoSystemButtonClick(Sender: TObject);
    //calculates size of header elements
    procedure CalcHeaderSize;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnableChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMPaint(var message: TWMPaint); message WM_PAINT;
    procedure WMSize(var message: TWMSize); message WM_SIZE;
  protected
    procedure CreateWnd; override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DrawCaption(aRect: TRect; aAlignment: TLMDAlignment); override;
    procedure DoThemeChanged;override;

    procedure Restore;

    procedure DoOnOpen;
    procedure DoOnOpenFixed;
    procedure DoOnClose (wasPinned: Boolean);
    procedure DoClose(Sender: TObject);
    procedure Loaded; override;

    property HeaderHeight:Integer read FHeaderHeight write SetHeaderHeight default 0;
    property HeaderDropMenu:TPopupMenu read FDropMenu write SetDropMenu;
    property BorderWidth:Integer read FBorderWidth write SetBorderWidth;
    property OnHeaderButtonClick:TNotifyEvent read FOnHButton write FOnHButton;
    property OnSystemButtonClick:TNotifyEvent read FOnSButton write FOnSButton;
    //The ButtonStyle of the panel's system and header buttons
    property ButtonStyle: TLMDUserButtonStyle read GetStyle write SetStyle default ubsExplorerColored;
    //This event gets called, whenever the panel is opened unpinned
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    //This event gets called whenever the panel is pinned
    property OnOpenFixed: TNotifyEvent read FOnOpenFixed write FOnOpenFixed;
    //This event gets called whenever the panel is closed / hidden
    property OnClose: TLMDCloseEvent read FOnClose write FOnClose;
    //This event gets called whenever the  SysButtonMode changes, it is used internally by the TLMDHeaderPanelButton component
    property OnModeChange: TNotifyEvent read FOnModeChange write FOnModeChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Open;
    procedure OpenFixed;
    procedure Close;

    property RealHeaderHeight: Integer read FRealHeaderHeight;
    property HeaderButton: TLMDSpeedButton read FHeaderButton;
    property SysButtonMode: TLMDSysButtonMode read FSysBtnMode write SetSysBtnMode default sbClose;
    property Pinned: Boolean read GetPinned;
    property UnPinned: Boolean read GetUnPinned;
    property HeaderOptions: TLMDHeaderOptions read FHeaderOptions write SetHeaderOptions default [];
  end;

implementation

uses
  Types, Themes,
  LMDBase, LMDClass, LMDProcs, LMDGraphUtils, LMDThemes;

type
  lsbe = class (TLMDSpeedButton)
  public
    property Design;
    property DisabledGrayed;
  end;

{ ----------------------------- private -------------------------------------- }
procedure TLMDCustomHeaderPanel.SetHeaderHeight(aValue: Integer);
begin
  FHeaderHeight := aValue;
  CalcHeaderSize;
  if not ([csReading, csLoading]*ComponentState<>[]) then
    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function  TLMDCustomHeaderPanel.GetStyle: TLMDUserButtonStyle;
begin
  result := FBtnStyle;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.SetStyle(const aValue: TLMDUserButtonStyle);
begin
  FBtnStyle := aValue;
  FSysButton.Style:= aValue;
  FHeaderButton.Style := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.SetDropMenu(aValue: TPopupMenu);
begin
  if FDropMenu = aValue then exit;
  FDropMenu := aValue;
  FHeaderButton.DropDownMenu := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.SetSysBtnMode (aValue: TLMDSysButtonMode);
var
  FUp, FDn, Fhot : TBitmap;
  lTheme: TLMDThemeMode;

  procedure getImage (bmp: TBitmap; pin, hot, down: Boolean);
  var
    ims    : Integer;
    button : TThemedExplorerBar;
    aRect: TRect;
  begin
    ims := FRealHeaderHeight-2;
    //if ims<0 then exit;
    bmp.Width := ims;
    bmp.Height := ims;

    aRect := Rect (0, 0, ims, ims);

    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.Brush.Color := clOlive;
    bmp.Canvas.FillRect(aRect);

    if pin then
      begin
        button := tebHeaderPinNormal;
        if hot then
          button := tebHeaderPinHot;
        if down then
          button := tebHeaderPinPressed;
      end
    else
      begin
        button := tebHeaderCloseNormal;
        if hot then
          button := tebHeaderCloseHot;
        if down then
          button := tebHeaderClosePressed;
      end;
    LMDThemeServices.DrawElement(lTHeme, bmp.Canvas.Handle, button, aRect);
  end;

begin
  FSysBtnMode := aValue;
  if Assigned (FOnModeChange) then FOnModeChange (self);
  if FRealHeaderHeight=0 then CalcHeaderSize;
  //if not FSysButton.Visible then exit;

  FUp := TBitmap.Create;
  FDn := TBitmap.Create;
  FHot := TBitmap.Create;
  FHot.Width := 0;

  lTheme := UseThemeMode;
  try
    case aValue of
      sbPin : begin
                if lTheme<>ttmNone then
                  begin
                    getImage (FUp, true, false, false);
                    getImage (FDn, true, false, true);
                    getImage (FHot, true, true, false {!});
                  end
                else
                  begin
                    FDn.LoadFromResourceName(HInstance, IDB_HEADERPINDOWN);
                    FUp.LoadFromResourceName(hInstance, IDB_HEADERPINUP);
                    end;
              end
    else
      begin
        if lTheme<>ttmNone then
          begin
            getImage (FUp, false, false, false);
            getImage (FDn, false, false, true);
            getImage (FHot, false, true, false {});
          end
        else
          begin
            LMDGetSysButton(FUp);
            FDn.Width := 0;
          end;
      end;
    end;
    //set image size to bsUp, bsDiabledUp, bsMouseOver
    FSysButton.Glyph.Width := FUp.Width * 3;
    FSysButton.Glyph.Height := FUp.Height;
    FSysButton.Glyph.Canvas.Brush.Style := bsSolid;
    FSysButton.Glyph.Canvas.Brush.Color := clOlive;
    FSysButton.Glyph.Canvas.FillRect(Rect(0,0,FSysButton.Glyph.Width,  FSysButton.Glyph.Height));

    //up btn state bmp
    FSysButton.Glyph.Canvas.Draw (0, 0, FUp);
    //mouse over state bmp
    if FHot.Width = 0 then
      FSysButton.Glyph.Canvas.Draw (FUp.Width * 2, 0, FUp)
    else
      FSysButton.Glyph.Canvas.Draw (FUp.Width * 2, 0, FHot);
    FSysButton.NumGlyphs := 3;
    if FDn.Width <> 0 then
      begin
        //increase image size
        FSysButton.Glyph.Width := FUp.Width * 5;
        //dn btn state bmp
        FSysButton.Glyph.Canvas.Draw (FUp.Width * 4, 0, FDn);
        FSysButton.NumGlyphs := 5;
      end;
  finally
    FUp.Free;
    FDn.Free;
    FHot.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.SetHeaderOptions (aValue: TLMDHeaderOptions);
var
  b: Boolean;
begin
  if FHeaderOptions<>aValue then
    begin
     FHeaderOptions := aValue;

     //enabled - disable header button according to options
     b := hoHeaderButton in FHeaderOptions;
     FHeaderButton.ButtonLayout.Arrow := b;
     FHeaderButton.Enabled := b;
     //FHeaderButton.Visible:=hoHeaderButton in FHeaderOptions;

     FSysButton.Visible:=not (hoHideSysButton in FHeaderOptions);
     if not (csLoading in ComponentState) then
       CalcHeaderSize;
     Invalidate;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomHeaderPanel.GetPinned: Boolean;
begin
  result := SysButtonMode = sbClose;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomHeaderPanel.GetUnPinned: Boolean;
begin
  result := not GetPinned;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.SetBorderWidth(aValue: Integer);
begin
  //asdkljkl
  if FBorderWidth = aValue then exit;
  FBorderWidth := aValue;
  CalcHeaderSize;
  Invalidate;
  inherited BorderWidth := aValue;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDCustomHeaderPanel.DoHeaderFontChange(Sender: TObject);
begin
  CalcHeaderSize;
//  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoHeaderButtonClick(Sender: TObject);
begin
  if Assigned(FOnHButton) then FOnHButton(Self);
  Application.ProcessMessages;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoHeaderButtonMouseDown(Sender: TObject;
                                                        Button: TMouseButton;
                                                        Shift: TShiftState;
                                                        X, Y: Integer);
begin
  DoHeaderButtonClick (Sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoSystemButtonClick(Sender: TObject);
begin
  if Assigned(FOnSButton) then FOnSButton(Self);

  case SysButtonMode of
    sbPin:   //turn header panel from popup to visible control
             OpenFixed;
    sbClose: Close;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.CalcHeaderSize;
var
  h,
  t       : Integer;
  aRect   : TRect;
begin
  FSysButton.Left := Width - FSysButton.Width - 2 - Bevel.BevelExtend;
  FHeaderButton.Top := 1 + Bevel.BevelExtend;
  FHeaderButton.Left:= 1 + Bevel.BevelExtend;

  aRect := GetClientRect;
  LMDDrawTextCalcExt (Canvas, Caption, FHeaderButton.FontFX, aRect, Font, false,
                      false, 0, 0);

  h := aRect.Bottom + 2;

  if FSysButton.Visible then
    FHeaderButton.Width := FSysButton.Left - FHeaderButton.Left
  else
    FHeaderButton.Width:=FSysButton.BoundsRect.Right-FHeaderButton.Left;

  with FHeaderButton do
    if aRect.Right + ButtonLayout.ArrowIndent + ButtonLayout.ArrowSize * 2 + 2 < Width then
      Width := aRect.Right + ButtonLayout.ArrowIndent + ButtonLayout.ArrowSize *2 + 2;

  if FHeaderHeight = 0 then
    FRealHeaderHeight := aRect.Bottom + 4
  else
    FRealHeaderHeight := FHeaderHeight;

  if FSysButton.Height > FRealHeaderHeight - 2 then
    FRealHeaderHeight := FSysButton.Height + 2;

  if h + 2 < FRealHeaderHeight then
    h := FRealHeaderHeight - 2;

  t := (FRealHeaderHeight - FSysButton.Height) shr 2;

  if t < 0 then
    t := 0;
  t := t + 1 + Bevel.BevelExtend;

  if FSysButton.Top <> t then
    FSysButton.Top := t;

  if FHeaderButton.Height <> h then
    FHeaderButton.Height := h;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.CMVisibleChanged(var Message: TMessage);
begin
  NotifyControls (WM_CANCELMODE); //added Aug 02, JH
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.CMEnableChanged(var Message: TMessage);
begin
  inherited;

  lsbe(FHeaderButton).DisabledGrayed := not Enabled;

  FHeaderButton.Enabled := Enabled;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.CMTextChanged(var Message: TMessage);
begin
  //inherited; we do not need the inherited functions here ...
  if not Assigned (Parent) then exit;
  FHeaderButton.Caption := Caption;
  CalcHeaderSize;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.WMSize(var message: TWMSize);
begin
  inherited;
  CalcHeaderSize;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.WMPaint(var Message: TWMPaint);
var
  aRect: TRect;
begin
  //calc size of rect around header buttons
  aRect :=  Rect(Bevel.BevelExtend,Bevel.BevelExtend, Width-Bevel.BevelExtend,
                 FRealHeaderHeight+Bevel.BevelExtend);

  inherited;

  //draw frame around header buttons
  LMDDrawStdFrame (Canvas, aRect, lsSingleRaised, 0);
end;

{ ---------------------------- protected ------------------------------------- }
procedure TLMDCustomHeaderPanel.CreateWnd;
begin
  inherited;
  CalcHeaderSize;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited;
  Rect.Top := RealHeaderHeight + Bevel.BevelExtend;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DrawCaption(aRect: TRect; aAlignment: TLMDAlignment);
begin
  //do not draw the panel's caption
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoOnOpen;
begin
  if Assigned (FOnOpen) then FOnOpen (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoThemeChanged;
begin
  inherited;
  SetSysBtnMode(FSysBtnMode);
  FSysButton.ThemeMode := self.ThemeMOde;
  FHeaderButton.Thememode := self.ThemeMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoOnOpenFixed;
begin
  if Assigned (FOnOpenFixed) then FOnOpenFixed (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoOnClose(wasPinned: Boolean);
begin
  if Assigned (FOnClose) then FOnClose (self, wasPinned);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.DoClose(Sender: tObject);
begin
  //this method is called whenver the container form is loosing the focus
  //and if it is destroyed, while the first one is wanted the second call
  //(on destroying) has to be handled seperately (by ignoring this call)
  if Assigned(FContainer) and not (csDestroying in FContainer.ComponentState) then
    Close;
end;

{ ---------------------------- public ---------------------------------------- }
constructor TLMDCustomHeaderPanel.Create(aOwner:TComponent);
begin
  inherited Create (aOwner);
  //ControlStyle:=ControlStyle-[csParentBackground]+[csOpaque];
  ControlStyle:=ControlStyle{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF} +[csOpaque];

  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;
  {$ENDIF}


  FShowMode := true;
  FBtnStyle := ubsExplorerColored;
  //create the system button showing the pin or close bmp
  FSysButton := TLMDSpeedButton.Create(Self);
  FSysButton.Parent := self;
  FSysButton.Height := 17;
  FSysButton.Width := 17;
  FSysButton.Style := FBtnStyle;
  FSysButton.OnClick := DoSystemButtonClick;

  lsbe(FSysButton).Design := false;

  FSysBtnMode := sbClose;
  //create the header button
  FHeaderButton := TLMDSpeedButton.Create(Self);
  FHeaderButton.Parent := self;
  FHeaderButton.Height := 17;
  FHeaderButton.Style := FBtnStyle;
  //FHeaderButton.ButtonLayout.Arrow := true;
  FHeaderButton.ButtonLayout.ArrowSize := 5;
  FHeaderButton.Enabled:=false;
  //FHeaderButton.Visible:=false;

  lsbe(FHeaderButton).DisabledGrayed := false;
  lsbe(FHeaderButton).Design := false;

  FHeaderButton.OnMouseDown := DoHeaderButtonMouseDown;

  FHeaderOptions := [];

  FOldAlign := Align;
  FOldPos := Point (Left, Top);
  FOldTransparent := Transparent;
  FOldBevel := TLMDBevel.Create;
  DoubleBuffered := true;

  inherited HandleNonWinControls:=True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomHeaderPanel.Destroy;
begin
  if Assigned (FContainer) then
    FreeAndNil(FContainer);
  FreeAndNil(FOldBevel);
  FreeAndNil(FHeaderButton);
  FreeAndNil(FSysButton);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.Loaded;
begin
  inherited Loaded;
  FOldAlign := Align;
  FOldParentRect := Parent.BoundsRect;
  FOldPos := Point (Left, Top);
  FOldTransparent := Transparent;
  SysButtonMode := SysButtonMode; //self update
  FOldBevel.Assign (Bevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.Open;
var
  p : TPoint;

begin
  //method completely changed, Aug 02, JH
  //previously based upon direct API calls which caused many problems
  //(e.g. controls not focusbale in unpinned state)
  //now panel is moved to another form (FContainer), which is then displayed
  //if this windows is being deactivated it will be closed (no more mouse hook
  //necessary)

  SysButtonMode := sbPin;

  //remeber the origin of the header panel
  FOldPos :=  Point (Left,Top);
  //calculate the origin of the "flyping" / unpinned header control
  p := Parent.ClientToScreen (FOldPos);

  //check control size here!

  if Parent.Height < Height then Height := Parent.Height;

  FOldParentControl := Parent;
  FOldParentRect := Parent.BoundsRect;

  FOldTransparent := Transparent;
  Transparent := false;

  //remember user bevel settungs
  FOldBevel.Assign (Bevel);

  //set bevel to look of unpinned controls
  Bevel.BeginUpdate;
  Bevel.Mode := bmCustom;
  Bevel.StyleInner := bvLowered;
  Bevel.StyleOuter := bvRaised;
  Bevel.WidthOuter := 1;
  Bevel.BorderWidth := 2;
  Bevel.BorderInnerWidth := 0;
  Bevel.EndUpdate (false);

  //remember the alignment and switch over to none
  FOldAlign := Align;
  Align := alNone;

  //create container form
  FContainer:= TForm.Create(Parent);
  FContainer.BorderStyle := bsNone;

  //move the panel to the container form
  self.Parent := FContainer;

  //setup the new size (old size plus bevel extend) of the headerpanel
  SetBounds (0, 0, Width + Bevel.BevelExtend, Height + Bevel.BevelExtend);

  //setup size and position of container form
  FContainer.Width := Width + (FContainer.Width - FContainer.ClientWidth);
  FContainer.Height := Height + (FContainer.Height - FContainer.ClientHeight);
  FContainer.Left := p.X;
  FContainer.Top := p.Y;

  //if the container form looses the focus we will close it
  FContainer.OnDeActivate := DoClose;

  //make the headerpanel visible (on the container form now)
  visible := true;

  //show the container form
  FContainer.Show;

  DoOnOpen;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.Restore;
begin
  //we will only get in here if the control is opened unpinned!!

  //we are invisible

  //restore parent:
  //remove the control from the cotainer form and reinsert it into old parent
  //control
  if Assigned(FOldParentControl) then  // RM 18.01.2002
    Parent := FOldParentControl;

  //SetBounds moved here, otherwise previously added bevel (size) cannot be undone, June 02 JH
  SetBounds (FOldPos.x, FOldPos.y, Width - Bevel.BevelExtend, Height - Bevel.BevelExtend);

  //restore bevel of panel
  Bevel.BeginUpdate;
  Bevel.Assign (FOldBevel);
  Bevel.EndUpdate(false);

  CalcHeaderSize;

  //restore old tranparency and alignment settings
  Transparent := FOldTransparent;
  Align := FOldAlign;

  //remove the container form - it will be recreated if its needed again
  FContainer.Free;
  FContainer := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.OpenFixed;
begin
  //if FOldParent = 0 then Open;
  if SysButtonMode =  sbClose then exit; //seems as if we are opened
  SysButtonMode := sbClose;

  // Nothing to Restore when we are invisible
  if not Visible then
    begin
      Visible:=True;
    end
  else
    begin
      Visible := false;
      Restore;
      Visible := true;
    end;

  DoOnOpenFixed;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHeaderPanel.Close;
var
  p: Boolean;
begin
  Visible := false;

  if SysButtonMode = sbPin then
    Restore;

  p := Pinned;

  SysButtonMode := sbPin; //for header panel button!

  DoOnClose (p);
end;

end.
