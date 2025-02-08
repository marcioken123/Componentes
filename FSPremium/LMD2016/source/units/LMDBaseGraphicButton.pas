unit LMDBaseGraphicButton;
{$I lmdcmps.Inc}

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

LMDBaseGraphicButton unit (RM)
------------------------------
Special base class for non focusable (non handled) button controls.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Controls, Menus, Graphics, ActnList, ImgList,
  LMDClass, LMDGlyph, LMDGraph, LMDShadow, LMDFXCaption, LMDButtonLayout,
  LMDButtonBase, LMDBaseGraphicControl, LMDProcs, LMDPngImage;

type
  TLMDSpeedButtonActionLink = class(TControlActionLink)
  protected
    FClient: TLMDBaseGraphicControl;
    procedure AssignClient(AClient : TObject); override;
    function IsCheckedLinked : Boolean; override;
    function IsImageIndexLinked : Boolean; override;
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
  end;

  {----------------------TLMDBaseGraphicButton---------------------------------}
  TLMDBaseGraphicButton = class(TLMDBaseGraphicControl)
  private
    FRepeatedClick,
    FAllowMouseOver,
    FAllowShadow       : Boolean;
    FButtonLayout      : TLMDButtonLayout;
    FFontFx            : TLMDFxCaption;

    FRepeatingDelay,
    FRepeatingInterval : Word;

    //4.0
    FDropDownCombo     : Boolean;
    FDropdownComboWidth: Integer;
    FOnDropDown        : TNotifyEvent;
    // --

    //4.01
    FHideHint          : Boolean;
    //5.0
    FUseCaption        : Boolean;

    //
    FDropDown          : TPopupMenu;
    FEnterColor        : TColor;
    FDropDownIndent,
    FGroupIndex        : Integer;
    FDisabledGrayed,
    FDropDownRight,
    FEnterColorChange,
    //FMouseOver,
    FMultiLine,
    FPressed,
    FPrepareDrag       : Boolean;
    {used only for ShapeButtons, OfficeButtons and ExplorerButtons:}
    FTimerID           : array[0..1] of TLMDTimer;
    {ident for global timer: belongs to office button bevels}
    {ident for global timer: belongs to repeated clicks}
    {internal flags}
    FInternal          : Integer;
    FUseGlobalTimer: Boolean;
    FAutoSize: Boolean;

    // RM 6.11
    function GetMouseOver:Boolean;
    // -------
    procedure SetButtonLayout(aValue: TLMDButtonLayout);
    procedure SetDropDown(aValue: TPopupMenu);
    procedure SetDropDownCombo(aValue:Boolean);
    procedure SetDropDownComboWidth(aValue: Integer);
    procedure SetDropDownIndent(aValue: Integer);
    procedure SetDropDownRight(aValue:Boolean);
    procedure SetEnterColor(aValue:TColor);
    procedure SetEnterColorChange(aValue:Boolean);
    procedure SetFontFx(aValue:TLMDFxCaption); virtual;
    procedure SetGlyph(aValue: TBitmap); virtual;
    procedure SetGroupIndex(Value: Integer);
    // LMD 6.11
    //procedure SetMouseOver(Value: Boolean);
    procedure SetMultiLine(aValue:Boolean);
    procedure SetNumGlyphs(aValue: TLMDNumGlyphs);
    procedure SetRepeatedClick(aValue: Boolean);
    procedure SetRepeatingInterval(aValue: Word);
    procedure SetUseCaption(aValue:Boolean);

    procedure SetTransparent(aValue: Boolean);
    function GetDroppedState:Boolean;
    function GetGlyph:TBitmap;
    function GetCaption:String;
    function GetNumGlyphs:TLMDNumGlyphs;

    {TP - 3.01}
    procedure ExecuteRepeatedClick(Sender:TObject);
    {Messages}
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
    procedure CMTextChanged(var Message:TMessage);message CM_TEXTCHANGED;
    {procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;}
    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure SetAutoSizeProp(const Value: Boolean);
    function GetPngGlyph: TLMDPngObject;
    procedure SetPngGlyph(const Value: TLMDPngObject);
    procedure SetUsePngGlyph(const Value: boolean);
  protected
    FShadowDepth       : TLMDShadowDepth;
    FState,
    FOldState          : TLMDButtonState;
    FAllowAllUp,
    FAllowTransparency,
    FUsed,
    FTransparent       : Boolean;
    FGlyph             : TObject;
    FPngGlyph          : TLMDPngObject;
    FUsePngGlyph            : boolean;
    FGlyphRect: TRect;
    FTextRect: TRect;
    procedure SetPressed(Value: Boolean);
    function GetAllowAllUp : Boolean;
    procedure SetAllowAllUp(Value: Boolean);
    function HasIML:Boolean;
    function IsCustom:Boolean; virtual;
    procedure InformOptionSet; virtual;

    // Returns true, if OptionSet with HotState is supported
    function IsHotOptionsetMode:Boolean;virtual;
    // Returns true if we support any "Hot" mode
    function IsHotState:Boolean; virtual;
    //return true if the control has to be repainted on mouse enter / exit events
    function RepaintOnMouse: Boolean; virtual;
    //return true if the background of the control has to be repainted before its front is redrawn
    function RestoreBack: Boolean; virtual;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);override;
    function ActionChangeable:Boolean;virtual;
    procedure ActivateTimer(aSession: integer; anInterval:Word; aCallFunc: TNotifyEvent);
    procedure DeActivateTimer(aSession: integer);
    function CheckOptimized:Boolean;override;
    procedure DoRepeatedClick;virtual;
    function  GetThemedTextColor: TColor; virtual;
    procedure DrawGlyphAndText(aCanvas: TCanvas; aRect: TRect); virtual;
    function ButtonColorChange: Boolean; virtual;
    procedure FontChange(Sender:TObject);
    function GetPalette: HPALETTE; override;
    procedure GetIMLChange(Sender:TObject); override;
    procedure Loaded; override;
    procedure MouseDown(Button:TMouseButton; Shift:TShiftState; X, Y: Integer); override;
    procedure MouseEnter;override;
    procedure MouseExit;override;
    procedure MouseMove(Shift:TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure StateChange(NewState:TLMDButtonState;ForceUpdate:Boolean=false);
    function VerifyTransparency(X, Y: Integer): Boolean; virtual;
    procedure VerifyMouseOver(Sender:TObject); virtual;
    function GetActionLinkClass: TControlActionLinkClass; override;

    property DisabledGrayed: Boolean read FDisabledGrayed write FDisabledGrayed default true;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure EndRepeatedClick;

    // RM: should be public
    procedure Click; override;
    // ---
    procedure DropDown;
    function GetNeededSizeRect: TRect; virtual;
    function isTransparentSet: Boolean; override;

    {read only}
    property Dropped:Boolean read GetDroppedState;
    property AllowMouseOver: Boolean read FAllowMouseover write FAllowMouseover;
    property AllowTransparency: Boolean read FAllowTransparency write FAllowTransparency;
    property MouseOver: Boolean read GetMouseOver;// write SetMouseOver;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property DropDownCombo:Boolean read FDropDownCombo write SetDropDownCombo default false;
    property DropDownComboWidth:Integer read FDropdownComboWidth write SetDropDownComboWidth default 12;
    property DropDownMenu: TPopupMenu read FDropDown write SetDropDown stored True;
    property DropDownIndent: Integer read FDropDownIndent write SetDropDownIndent default 0;
    property DropDownRight:Boolean read FDropDownRight write SetDropDownRight default false;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Pressed: Boolean read FPressed write SetPressed default False;
    property Down:Boolean read FPressed write SetPressed;
    property MultiLine:Boolean read FMultiLine write SetMultiLine default false;

    //7.0
    property ButtonLayout: TLMDButtonLayout read FButtonLayout write SetButtonLayout;
    property EnterColor: TColor read FEnterColor write SetEnterColor default clCaptionText;
    property EnterColorChange: Boolean read FEnterColorChange write SetEnterColorChange default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustom;
    property FontFX:TLMDFxCaption read FFontFx write SetFontFx;
    property Font;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property NumGlyphs: TLMDNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property RepeatedClick: Boolean read FRepeatedClick write SetRepeatedClick default False;
    property RepeatingInterval: Word read FRepeatingInterval write SetRepeatingInterval default 100;
    property RepeatingDelay : Word read FRepeatingDelay write FRepeatingDelay default 500;
    property UseCaption:Boolean read FUseCaption write SetUseCaption default True;
    property OnDropDown:TNotifyEvent read FOnDropDown write FOnDropDown;
  published
    property About;
    property Caption;
    property Color;
    property Enabled;
    //4.01
    property HideHint:Boolean read FHideHint write FHideHint default True;
    //----
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    // 7.0 RM
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // 8.0 AH
    property AutoSize: Boolean read FAutoSize write SetAutoSizeProp;
    // ---
    property Visible;
    {events}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    {4.0}
    //properties
    property Action;
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    property PngGlyph: TLMDPngObject read GetPngGlyph write SetPngGlyph;
    property UsePngGlyph  : boolean read FUsePngGlyph write SetUsePngGlyph default false;
  end;

implementation
uses
  Types, Forms, Consts, SysUtils,
  LMDCustomControl, LMDUtils, LMDGraphUtils, LMDBase, LMDCont, LMDCustomScrollBox,
  LMDImageList, LMDImageListConnector, LMDCustomImageList, LMDPNGImageList;

{************************ class TLMDBaseGraphicButton *************************}
{------------------------- Private --------------------------------------------}
procedure TLMDBaseGraphicButton.SetFontFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetDropDown(aValue: TPopupMenu);
begin
  if aValue<>FDropDown then
    begin
      FDropDown:=aValue;
      if FDropDown<>nil then FDropDown.FreeNotification(Self);
      FUsed:=Assigned(FDropDown) and FDropDownCombo;
      if FDropDownCombo then GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetDropDownComboWidth(aValue:Integer);
begin
  if FDropdownComboWidth <> aValue then
    begin
      if not (csLoading in ComponentState) then
      if FDropDownCombo then
        Width := Width-FDropDownComboWidth+aValue;
      FDropdownComboWidth:=aValue;
      FUsed := Assigned(FDropDown) and FDropDownCombo;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetDropDownCombo(aValue:Boolean);
begin
  if aValue<>FDropDownCombo then
    begin
      FDropDownCombo:=aValue;
      if not (csLoading in ComponentState) then
         if FDropdownCombo then
           Width:=Width+FDropDownComboWidth
         else
           Width:=Width-FDropDownComboWidth;
      FUsed:=Assigned(FDropDown) and FDropDownCombo;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetDropDownIndent(aValue: Integer);
begin
  if aValue<>FDropDownIndent then
    begin
      FDropDownIndent:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetDropDownRight(aValue:Boolean);
begin
  if aValue<>FDropDownRight then
    begin
      FDropDownRight:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetEnterColor(aValue:TColor);
begin
  if aValue<>FEnterColor then
    begin
      FEnterColor:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetEnterColorChange(aValue:Boolean);
begin
  if aValue <> FEnterColorChange then
    begin
      FEnterColorChange:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetPressed(Value: Boolean);
begin
  if FGroupIndex=0 then Value:=False;
  if Value<>FPressed then
    begin
      if FPressed and (not FAllowAllUp) then Exit;
      FPressed:=Value;
      if Value then
        begin
          FState:=bsOptionSet;
          Invalidate;
          InformOptionSet;
        end
      else
        begin
          FState:=bsUp;
          Invalidate;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetRepeatedClick(aValue: Boolean);
begin
  if aValue<>FRepeatedClick then
    begin
      FRepeatedClick:=aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetRepeatingInterval(aValue: Word);
begin
  if aValue<>FRepeatingInterval then
    begin
      FRepeatingInterval:=aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetTransparent(aValue: Boolean);
begin
  if aValue<>FTransparent then
    begin
      FTransparent:=aValue;
      if FTransparent then
        ControlStyle:=ControlStyle-[csOpaque]
      else
        ControlStyle:=ControlStyle+[csOpaque];
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetMultiLine(aValue: Boolean);
begin
  if aValue<>FMultiLine then
    begin
      FMultiLine:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetUseCaption(aValue: Boolean);
begin
  if aValue<>FUseCaption then
    begin
      FUseCaption:=aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetButtonLayout(aValue: TLMDButtonLayout);
begin
  FButtonLayout.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetGlyph(aValue:TBitmap);
begin
  if not (csLoading in ComponentState) then
    if ImageList<>nil then ImageList:=nil;
  TLMDGlyph(FGlyph).Glyph:=aValue;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetNumGlyphs(aValue: TLMDNumGlyphs);
begin
  if aValue<>TLMDGlyph(FGlyph).NumGlyphs then
    begin
      TLMDGlyph(FGlyph).NumGlyphs:=aValue;
      Invalidate; // 7.03.02 RM
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex<>Value then
    begin
      FGroupIndex:=Value;
      InformOptionSet;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TLMDSpeedButtonActionLink;
end;

function TLMDBaseGraphicButton.GetAllowAllUp : Boolean;
begin
  result := FAllowAllUp;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp<>Value then
    begin
      FAllowAllUp:=Value;
      InformOptionSet;
    end;
end;

procedure TLMDBaseGraphicButton.SetAutoSizeProp(const Value: Boolean);
begin
  if (FAutoSize <> Value) then
  begin
    FAutoSize := Value;
    if FAutoSize then
      Invalidate;
  end;
end;

// LMD 6.11
{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetMouseOver:Boolean;
begin
  result:=FState=bsMouseOver;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.HasIML:Boolean;
begin
  result:=(ImageList<>nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetDroppedState:Boolean;
begin
  Result:=FState=bsDropDownOpen;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetGlyph: TBitmap;
begin
  Result:=TLMDGlyph(FGlyph).Glyph;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetNumGlyphs:TLMDNumGlyphs;
begin
  Result:=TLMDGlyph(FGlyph).NumGlyphs;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.InformOptionSet;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin

    Msg.LParam:= LPARAM(Self);

    Msg.Msg:=CM_BUTTONPRESSED;
    Msg.WParam:=FGroupIndex;
    Msg.Result:=0;
    Parent.Broadcast(Msg);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.IsCustom:Boolean;
begin
  // ToDo!!!
  result:=HasIML;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicButton.IsHotOptionsetMode: Boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicButton.IsHotState:Boolean;
begin
  result:=(TLMDGlyph(FGlyph).Style=gsExplorer);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.RepaintOnMouse: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.RestoreBack: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetCaption:string;
begin
  if FUseCaption then result:=Caption else result:='';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.StateChange(NewState:TLMDButtonState; ForceUpdate:Boolean=false);
var
  DoRepaint: Boolean;
begin
  DoRepaint:=True;

  if Owner is TForm then
    with TForm(Owner) do
      case FormStyle of
        fsMDIForm, fsMDIChild:
          if not Application.Active then
            if (FInternal=1) and (NewState=bsMouseOver) then
              NewState:=bsUp
            else
              exit;
      end;

  if (NewState<>FState) or ForceUpdate then
    begin
      if not (TLMDGlyph(FGlyph).Style = gsExplorer) then
        if not RepaintOnMouse and (NumGlyphs < Ord(bsMouseOver) + 1) then
          if not (FAllowMouseOver and FEnterColorChange) then
            if not ButtonColorChange then  // ShapeButtons and MMButtons
              if ((FState = bsMouseOver) and (NewState = bsUp)) or
                 ((NewState = bsMouseOver) and (FState = bsUp)) then
                DoRepaint:=False;

      if (NumGlyphs<Ord(bsOptionSet)) then
        if ((FState=bsMouseOver) and (NewState=bsOptionSet)) or
           ((NewState=bsMouseOver) and (FState=bsOptionSet)) then
            DoRepaint:=False;

      if (NewState=bsMouseOver) and not (FState=bsOptionSet) then
        FOldState:=bsUp
      else
        FOldState:=FState;

      FState:=NewState;

      if DoRepaint and not (Visible=False) then
        if Transparent and not CheckOptimized then
          Invalidate
        else
          Paint;

      if FAllowMouseOver then
        begin
          if (FState<>bsMouseOver) and (Assigned(FTimerID[LMDBTNTIMERBORDER])) then
            DeActivateTimer(LMDBTNTIMERBORDER);
          if (FState=bsMouseOver) and (not Pressed) then
            ActivateTimer(LMDBTNTIMERBORDER, 100, VerifyMouseOver);
        end;

    end;

end;

{TP}
{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.ExecuteRepeatedClick(Sender:TObject);
begin
  // 6.11 --> replaced check for mousever
  if FState=bsDown then DoRepeatedClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TComponent;
  b: Boolean;
begin
  if Message.WParam = WPARAM(FGroupIndex) then
    begin

      Sender:=TComponent(Message.LParam);

      if  not Assigned(Sender)  then
        exit;

      b:=TLMDBaseGraphicButton(Sender).Pressed;
      if Sender <> Self then
        begin
          if b and FPressed then
            begin
              FPressed:=False;
              // RM 06-June-2002
              // LMD 6.11
              if MouseOver and IsHotState then
                begin
                  //FOldState:=bsUp;
                  FState:=bsMouseOver
                end
              else
              //----
                begin
                  // 7.05
                  if Enabled then
                    FState:=bsUp
                  else
                    FState:=bsDisabledUp;
                end;
              Invalidate;
            end;
            FAllowAllUp:=TLMDBaseGraphicButton(Sender).AllowAllUp;
        end
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and (Parent<>nil) and TWinControl(Parent).Enabled and Parent.Showing then
      begin
        if FDropDown <> nil then
          begin
            if FState=bsDropDownOpen then
              StateChange(bsMouseOver)
            else
              DropDown;
          end
        else
          if (GroupIndex<>0) and not ((FAllowAllUp=False) and (FState=bsOptionSet)) then
            begin
              if FAllowMouseOver then
                begin
                  SetPressed(not FPressed);
                  if FPressed then
                    {RM}
                    begin
                      StateChange(bsOptionSet);
                      Click;
                    end
                    {----}
                  else
                    StateChange(bsUp);
                end
              else
                SetPressed(not FPressed);
            end
          else
            if (GroupIndex=0) then
              begin
                // LMD 6.11
                {RM}
                Click;
                {----}
              end;
        Result:=1;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not Enabled then
    begin
      if FPressed then
        FState:=bsDisabledDown
      else
        FState:=bsDisabledUp
    end
  else
    if FPressed then
      FState:=bsOptionSet
    else
      FState:=bsUp;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.CMFontChanged(var Message: TMessage);
begin
  FontChange(Font);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.CMTextChanged(var Message:TMessage);
begin
  if Transparent or not CheckOptimized then  // changed 7.11
    Invalidate
  else
    if (Visible or (csDesigning in ComponentState) and
         not (csNoDesignVisible in ControlStyle)) and
       (Parent <> nil) and Parent.HandleAllocated then
      Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
  if FPressed then DblClick;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDBaseGraphicButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with Glyph do
        begin
          Width := ImageList.Width;
          Height := ImageList.Height;
          Canvas.Brush.Color := clFuchsia;
          Canvas.FillRect(Rect(0,0, Width, Height));
          ImageList.Draw(Canvas, 0, 0, Index);
        end;
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if not ActionChangeable then exit;
  if Sender is TCustomAction then
  begin
    with TCustomAction(Sender) do
    begin
       if (ActionList <> nil) and (ActionList.Images <> nil) and
         (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
         CopyImage(ActionList.Images, ImageIndex)
       else
         if not (csLoading in ComponentState) then Glyph:=nil;
       if not CheckDefaults or not Assigned(Self.OnClick) then
         Self.OnClick := TCustomAction(Sender).OnExecute;
     end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.ActionChangeable:Boolean;
begin
  result:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.ActivateTimer(aSession: integer; anInterval:Word; aCallFunc: TNotifyEvent);
begin
  if (aSession>1) then exit;
  if Assigned(FTimerID[aSession]) then exit;
  {get a global timer-id}
  FTimerID[aSession]:=TLMDTimer.Create(anInterval, aCallFunc, True, FUseGlobalTimer);
  {LMDApplication.Timer[FTimerId[aSession]].Enabled:=True;
  if FTimerId[aSession]=0 then
    raise EOutOfResources.Create(SNoTimers);}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.DeActivateTimer(aSession: integer);
begin
  {free timer...}
  if not Assigned(FTimerID[aSession]) then exit;
  //if LMDApplication.Timers.IndexOf(FTimerID[aSession])<0 then exit;
  //nr:=FTimerID[aSession]; FTimerID[aSession]:=0;
  FTimerID[aSession].Enabled:=False;
  FTimerID[aSession].OnTimer:=nil;
  FTimerID[aSession].Free;
  FTimerID[aSession]:=nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.isTransparentSet: Boolean;
begin
  result := FTransparent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.CheckOptimized:Boolean;
begin
  result := BackBitmapCheck;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.DrawGlyphAndText(aCanvas: TCanvas;
  aRect: TRect);
var
  flags:Longint;
  fdis: TLMDDrawTextStyle;
  LWidth: Integer;
  LTmpGlyph: TLMDGlyph;
  LPngObj: TLMDPNGObject;
begin
  aCanvas.Font       := Self.Font;
  aCanvas.Font.Color := GetThemedTextColor;

  if (FState in [bsMouseOver, bsOptionSet, bsDown, bsDragOver, bsDropDownOpen])
     and FAllowMouseOver and FEnterColorChange then
    aCanvas.Font.Color := FEnterColor;

  flags := DrawTextBiDiModeFlags(0);
  fdis  := TLMDDrawTextStyle(Enabled);

  if not FDisabledGrayed then
    fdis := dtEnabled; //force Enabled look, even if disabled

  if (FUsePngGlyph and not FPngGlyph.Empty) or (Assigned(ImageList) and
     (ImageList is TLMDPNGImageList) and (ImageIndex >=0) and
     (ImageIndex < ImageList.Count)) then
  begin
    LTmpGlyph := TLMDGlyph.Create;
    try
      if FUsePngGlyph then
        LPngObj := FPngGlyph
      else
        LPngObj := TLMDPNGImageList(ImageList).PNG[ImageIndex];

      if LPngObj <> nil then
      begin
        LTmpGlyph.Glyph.Width  := LPngObj.Width;
        LTmpGlyph.Glyph.Height := LPngObj.Height;
      end;

      LTmpGlyph.DrawButtonGlyphAndText(aCanvas, GetCaption, FFontFx, aRect,
                                       FState, ButtonLayout, [fdis, dt3DDisabled,
                                       dtRectGlyphText], FMultiLine, flags);
      FGlyphRect := LTmpGlyph.GlyphRect;
      FTextRect  := LTmpGlyph.TextRect;

      if LPngObj <> nil then
        LPngObj.Draw(aCanvas, FGlyphRect);
    finally
      LTmpGlyph.Free;
    end
  end
  else
  begin
    TLMDGlyph(FGlyph).DrawButtonGlyphAndText(aCanvas, GetCaption, FFontFx, aRect,
                                             FState, ButtonLayout, [fdis,
                                             dt3DDisabled, dtRectGlyphText],
                                             FMultiLine, flags);
    FGlyphRect := TLMDGlyph(FGlyph).GlyphRect;
    FTextRect  := TLMDGlyph(FGlyph).TextRect;
  end;

  if {(TLMDGlyph(FGlyph).DrawnRect.Left < 0) and }(FAutoSize) then
  begin
    LWidth := LMDRectWidth(TLMDGlyph(FGlyph).DrawnRect) + ButtonLayout.Spacing * 2;
    if (LWidth > 0) and (Width <> LWidth) then
      Width := LWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.DoRepeatedClick;
begin
  //after first call of this function set interval speed
  if Assigned(FTimerId[LMDBTNTIMERREPEATED]) then
    FTimerId[LMDBTNTIMERREPEATED].Interval:=FRepeatingInterval;
  Click;
end;

{ ---------------------------------------------------------------------------- }
Procedure TLMDBaseGraphicButton.FontChange(Sender:TObject);
begin
  if sender=Font then
    ParentFont:=False;
  if not (csLoading in ComponentState) then
  begin
    Canvas.Font:=self.Font;
    if (FFontFx.Angle<>0) and not LMDIsTrueTypeFontCheck(Canvas) then
    if Sender=Font then FontFx.Angle:=0 else Font.Name:=LMD_DEFAULTFONT;
    GetChange(Sender);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.GetIMLChange(Sender:TObject);
var
  tmp:TBitmap;
  index: integer;
begin
  if not IMLEmpty then
  begin
    tmp:=TBitmap.Create;
    try
      {$IFDEF LMD_FORCELISTINDEXUSE}
      index := ListIndex;
      {$ELSE}
      if (ImageList is TLMDImageList) or
         (ImageList is TLMDImageListConnector) then
        index := ListIndex
      else
        index := ImageIndex;
      {$ENDIF}
      LMDIMLItemBitmap(ImageList, index, ImageIndex, tmp);
      TLMDGlyph(FGlyph).Glyph:=tmp;
    finally
      tmp.Free;
    end;
  end
  else
    TLMDGlyph(FGlyph).Glyph:=nil;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.Invalidate;
begin
  inherited Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.EndRepeatedClick;
begin
  if RepeatedClick then DeActivateTimer(LMDBTNTIMERREPEATED);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.ButtonColorChange: Boolean;
begin
  result:=false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetPalette: HPALETTE;
begin
  Result:=Glyph.Palette;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.Loaded;
begin
  inherited Loaded;
  FUsed:=Assigned(FDropDown) and FDropDownCombo;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(ImageList) or
     LMDIsGlobalIdent(ImageList) then GetIMLChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewState: TLMDButtonState;
  aRect, bRect:TRect;

  procedure setRect;
  begin
    aRect:=ClientRect;
    if FUsed then
      begin
        bRect:=Rect(aRect.Right-FDropDownComboWidth, aRect.Top, aRect.Right, aRect.Bottom);
        aRect.Right:=bRect.Left;
      end;
  end;

begin
  inherited MouseDown(Button,Shift,X,Y);
  if FAllowTransparency then if not VerifyTransparency(x,y) then exit;

  NewState:=FState;
  if Enabled and (Button=mbLeft) then
    try
      if FDropDown <> nil then
        begin
          if FState=bsDropDownOpen then
            begin
              NewState:=bsMouseOver;
              exit;
            end
          else
            if not FUsed then
              begin
                DropDown;
                exit;
              end
            else
              begin
                setRect;
                if PtInRect(bRect,Point(X,Y)) then
                  begin
                    DropDown;
                    exit;
                  end;
              end;
        end;

      FPrepareDrag := True;
      if (FOldState=bsOptionSet) and (FState=bsMouseOver) and (FGroupIndex<>0) then
        NewState:=bsOptionSet
      else
        if not (FPressed) then
          begin
            NewState:=bsDown;
            {TP}
            if FRepeatedClick then
              begin
                DoRepeatedClick;
                ActivateTimer(LMDBTNTIMERREPEATED, FRepeatingDelay, ExecuteRepeatedClick)
              end;
          end;

    finally
      StateChange(NewState);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.MouseEnter;
begin
  if FAllowTransparency then exit;
  inherited MouseEnter;
  // 6.11
  if (csDesigning in ComponentState) then exit;
  // 7.0 --> IsHotOptionset
  if ((FState=bsUp) or ((FState=bsOptionSet) and isHotOptionsetMode)) and FAllowMouseOver and Enabled then
    begin
      if FState=bsOptionSet then
        StateChange(bsOptionSet, true)
      else
        StateChange(bsMouseOver);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.MouseExit;
begin
  inherited MouseExit;
  if (csDesigning in ComponentState) then exit;
  // 6.11
  //MouseOver:=False; //order changed, JH, 28.11.01
  if (FState=bsMouseOver) or ((FState=bsOptionSet) and isHotOptionsetMode) then
    begin
      if FState=bsOptionSet then
        StateChange(bsOptionSet, true)
      else
        StateChange(FOldState);
    end;
  if FHideHint then Application.HideHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  InRect: Boolean;
  NewState: TLMDButtonState;
begin
  if FState=bsDropDownOpen then exit;
  inherited MouseMove(Shift, X, Y);
  if not Enabled then exit;

  NewState:=FState;
  if FAllowTransparency then
    begin
      InRect:=VerifyTransparency(x,y);

      if FAllowShadow and (FState=bsDown) and not InRect then
        InRect:=VerifyTransparency(x+FShadowDepth-1,y+FShadowDepth-1);
      {}
      if FAllowMouseOver and InRect
       and (not ((FGroupIndex<>0) and (FState=bsOptionSet))) then
        NewState:=bsMouseOver
      else
        if FState=bsMouseOver then NewState:=FOldState;
    end
  else
    InRect:=(X>=0) and (X<=ClientWidth) and (Y>=0) and (Y<=ClientHeight);

  if FPrepareDrag then
    begin
      if InRect then
        if FPressed then
          NewState:=bsOptionSet
        else NewState:=bsDown
      else
        if not ((FGroupIndex<>0) and (FState<>bsDown))then NewState:=bsUp;
    end;

  StateChange(NewState);

  //these lines of code are executed if a mouse enter event got lost
  if InRect and not MouseOver then
    begin
      inherited MouseEnter;
      // 6.11
      //MouseOver:=True;
      if (FState=bsUp) and FAllowMouseOver then
        StateChange(bsMouseOver);
    end;
  //MouseOver:=InRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var
  InRect, NoChange, lPressed: Boolean;
  NewState, lOldState: TLMDButtonState;
  CursorPos: TPoint;
  TempRect: TRect;

  procedure ButtonReset;
  begin
    {find the right state after the click method was actuated...}
    if (NumGlyphs>2) or IsHotState then
      begin
        GetCursorPos(CursorPos);
        TempRect:=GetScreenRect(ClientRect);
        CursorPos.X:=CursorPos.X-TempRect.Left;
        CursorPos.Y:=CursorPos.Y-TempRect.Top;
        if FAllowTransparency then
          InRect:=VerifyTransparency(CursorPos.X,CursorPos.Y)
        else
          InRect:=(CursorPos.X>=0) and (CursorPos.X<ClientWidth)
           and (CursorPos.Y>=0) and (CursorPos.Y<=ClientHeight);
        if InRect then
          if (not NoChange) and (FState<>bsDisabledUp) and
           (FState<>bsDisabledDown) then
             begin
               FInternal:=1;
               if (NewState=bsUp) then NewState:=bsMouseOver;
               StateChange(NewState);
               FInternal:=0;
             end;
        if not InRect then
          if (not NoChange) and (FState<>bsDisabledUp) and (FState<>bsDisabledDown) then
            StateChange(NewState);
      end;
  end;

begin
  if FState=bsDropDownOpen then exit;
  inherited MouseUp(Button, Shift, X, Y);
  if not FPrepareDrag then exit;
  NoChange:=False;
  FPrepareDrag := False;
  InRect:=False;

  {TP}
  if RepeatedClick then DeActivateTimer(LMDBTNTIMERREPEATED);

  if FAllowTransparency then
    InRect:=VerifyTransparency(x,y);
    if FAllowShadow and (FState=bsDown) and not InRect then
     InRect:=VerifyTransparency(x+FShadowDepth-1,y+FShadowDepth-1)
  else
    InRect:=(X>=0) and (X<ClientWidth) and (Y>=0) and (Y<=ClientHeight);

  if (FState=bsDisabledDown) or (FState=bsDisabledUp) then
    NewState:=FState
  else
    NewState:=bsUp;

  if not (FGroupIndex=0) then
    begin
      if InRect then
        begin
          if (FState=bsOptionSet) and not FAllowAllUp then exit;
          if FAllowMouseOver then
            begin
              SetPressed(not FPressed);
              if FPressed then NewState:=FState else NewState:=bsUp{bsMouseOver};
            end
          else
            begin
              SetPressed(not FPressed);
              NoChange:=True;
            end
        end
      else
        if FPressed then
          NewState:=bsOptionSet;
    end
  else
    if InRect and AllowMouseOver then
      if not((FState=bsDisabledDown) or (FState=bsDisabledUp)) then
        NewState:=bsMouseOver{bsUp};

  if (not InRect) and (not NoChange) then
    StateChange(NewState);

  if InRect then
    begin
      {if Explorer Style: stay pressed until Click event handler is executed...}
      if (NumGlyphs<3) and (not (TLMDGlyph(FGlyph).Style=gsExplorer)) and (not NoChange) then
        StateChange(NewState);

      lOldState := FState;
      lPressed := FPressed;
      if not FRepeatedClick then Click;

      // VB Newsgroup issue fix (lmdtools 17-05-2010)
      if (FState = lOldState) and (lPressed = FPressed) then
        // RM 28-12-2001
        ButtonReset;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FDropDown) then FDropDown:=nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.VerifyTransparency(X, Y: Integer): Boolean;
begin
  if (X>=0) and (Y>=0) and (X<=Width) and (Y<=Height) then Result:=True else Result:=False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.VerifyMouseOver(Sender: TObject);
var
  TempRect: TRect;
  CursorPos: TPoint;
  InRect: Boolean;
begin
  {see whether the mouse is not in the button...}
  GetCursorPos(CursorPos);
  TempRect:=GetScreenRect(ClientRect);
  CursorPos.X:=CursorPos.X-TempRect.Left;
  CursorPos.Y:=CursorPos.Y-TempRect.Top;
  if FAllowTransparency then
    InRect:=VerifyTransparency(CursorPos.X,CursorPos.Y)
  else
    InRect:=(CursorPos.X>=0) and (CursorPos.X<ClientWidth)
     and (CursorPos.Y>=0) and (CursorPos.Y<=ClientHeight);

  // RM 06-June-2002  --> and (not Pressed) added
  if Enabled and (not Pressed) and not InRect then
    begin
      {DeActivateTimer;}
      StateChange(bsUp);
    end;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDBaseGraphicButton.Click;
//var
//  myClick:TNotifyEvent;
begin
//  myClick:=onClick;
//  if Assigned(MyClick) then MyClick(Self);
  inherited Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.DropDown;
var
  pt:TPoint;
  tempmsg:TMsg;
begin
  if Assigned(FDropDown) and not Dropped then
    begin
      StateChange(bsDropDownOpen);
      if Assigned(FOnDropDown) then FOnDropDown(self);
      if FDropDownRight then
        begin
          pt:=ClientToScreen(Point(Width,0));
          FDropDown.Popup(pt.X,pt.Y+FDropDownIndent);
        end
      else
        begin
          pt:=ClientToScreen(Point(0,Height));
          FDropDown.Popup(pt.X+FDropDownIndent,pt.Y);
        end;
      while PeekMessage(tempMsg,HWND(0),WM_MOUSEFIRST,WM_MOUSELAST,PM_REMOVE) do ;
      if GetCapture<>0 then
        SendMessage(GetCapture,WM_CANCELMODE,0,0);
      StateChange(bsMouseOver);
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetNeededSizeRect: TRect;
var
  aRect: TRect;
begin
  aRect := Rect (0, 0, TLMDGlyph(FGlyph).Glyph.Width, TLMDGlyph(FGlyph).Glyph.Height);
  result := LMDDrawTextAndGlyphExt(Canvas, GetCaption, FontFX, result, TLMDGlyph(FGlyph).Glyph.Canvas,
                       aRect,
                       nil, clNone, ButtonLayout, MultiLine, true, Transparent, [dtCalculate], 0).CompleteRect;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDBaseGraphicButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHideHint:=True;

  ControlStyle:=ControlStyle+[csCaptureMouse, csDoubleClicks, csOpaque]-[csSetCaption];
  FDropDownComboWidth:=12;
  FFontFx:=TLMDFxCaption.Create;
  FFontFx.OnChange:=FontChange;

  FGlyph:=TLMDGlyph.Create;
  TLMDGlyph(FGlyph).OnChange := GetChange;

  FButtonLayout:=TLMDButtonLayout.Create;
  FButtonLayout.OnChange:=GetChange;

  FAllowAllUp:=False;
  FAllowMouseOver:=False;
  FAllowShadow:=False;
  FAllowTransparency:=True;
  FDropDown := nil;
  FDropDownIndent:=0;
  FDropDownRight:=False;
  FEnterColor:=clCaptionText;
  FDisabledGrayed := true;
  FEnterColorChange:=False;
  FGroupIndex:=0;
  FInternal:=0;
  FRepeatedClick:=False;
  FRepeatingInterval:=100;
  FRepeatingDelay:=500;
  FShadowDepth:=0;
  FState:=bsUp;
  FTimerID[0]:=nil;
  FTimerID[1]:=nil;
  FTransparent:=False;
  //5.0
  FUseCaption:=true;
  Width:=25;
  Height:=25;
  FUsePngGlyph := false;
  FPngGlyph := TLMDPNGObject.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBaseGraphicButton.Destroy;
begin
  DeActivateTimer(0);
  DeActivateTimer(1);

  FButtonLayout.OnChange:=nil;
  TLMDGlyph(FGlyph).OnChange:=nil;
  FFontFx.OnChange:=nil;
  FreeAndNil(FButtonLayout);
  FreeAndNil(FFontFx);
  TLMDGlyph(FGlyph).Free;
  FGlyph:=nil;
  FPngGlyph.Free;  
  inherited Destroy;
end;

{ TLMDSpeedButtonActionLink }

procedure TLMDSpeedButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited;
  FClient := TLMDBaseGraphicButton(AClient);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpeedButtonActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpeedButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpeedButtonActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpeedButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetPngGlyph: TLMDPngObject;
begin
  result := FPngGlyph;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGraphicButton.GetThemedTextColor: TColor;
begin
  Result := Font.Color;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetPngGlyph(const Value: TLMDPngObject);
begin
  FPngGlyph.Assign(Value);
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGraphicButton.SetUsePngGlyph(const Value: boolean);
begin
  FUsePngGlyph := Value;
  Invalidate;  
end;

end.
