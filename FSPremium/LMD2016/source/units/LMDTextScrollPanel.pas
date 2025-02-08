unit LMDTextScrollPanel;
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

LMDTextScrollPanel unit (JH)
----------------------------

Panel component which can be used as viewer for large texts

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, StdCtrls, Controls, Classes, Graphics,
  LMDCustomMemo, LMDGraph, LMDTextCustomPanel, LMDSBar;

type
  TLMDTextScrollBarKind = LMDCustomMemo.TLMDMemoScrollBarKind;

  TLMDTextScrollPanel = class (TLMDTextCustomPanel)
  private
    FScrollStep,
    FPos     : TPoint;
    FVScroll,
    FHScroll : TLMDScrollBar;
    FTextSize: TRect;

    FVSet,
    FHSet    : TLMDScrollBarObject;
    FScrollBars: TLMDTextScrollBarKind;
    procedure SetTextSize (const aValue: TRect);
    procedure SetInteger(Index, aValue:Integer);
    function GetInteger(Index:Integer):Integer;
    procedure SetScrollBarObject (index: Integer; aValue: TLMDScrollBarObject);
    procedure SetScrollBars (aValue : TLMDTextScrollBarKind);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure DoVScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure DoHScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure DoTxtChange (Sender: TObject); override;
    procedure UpdateAndRefresh;
    procedure DrawCaption(aRect:TRect; aAlignment:TLMDAlignment); override;
    procedure AlignControls (AControl: TControl; var ARect: TRect); override;
    function GetClientRect: TRect; override;
    procedure SetupScrollBars;
    property TextSize : TRect read FTextSize write SetTextSize;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property VertScrollBar : TLMDScrollBarObject index 0 read FVSet write SetScrollBarObject;
    property HorizScrollBar : TLMDScrollBarObject index 1 read FHSet write SetScrollBarObject;
    property Lines;
    property Anchors;
    property TabStop;
    property WordWrap;

    property OnLinkClick;

    property ScrollBars : TLMDTextScrollBarKind read FScrollBars write SetScrollBars default skBoth;
    property ScrollX: Integer index 0 read GetInteger write SetInteger default -1;
    property ScrollY: Integer index 1 read GetInteger write SetInteger default -1;

    // RM
    property TextContainer;
    property TextIndex;
    property CheckContainerLinks;
    // ---

     // 7.01
    property NoHandleUpdate;
    // 7.0
    property FDSupport;

    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    property About;
    property Align;
    property Alignment;

    property FaceController;
    property BackFX;
    property BackFXPass;

    property Bevel;
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FillObject;
    property Font;
    property FontFX;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Locked;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Transparent;
    property TransparentBorder;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;    
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation
uses
  sysutils;
{************************ TLMDTextScrollPanel *********************************}
{ -------------------------- Private ----------------------------------------- }
procedure TLMDTextScrollPanel.SetTextSize (const aValue: TRect);
var
  cRect: TRect;
begin
  cRect := GetClientRect;
  FTextSize := aValue;

{  if Assigned (FHScroll) then
    FHScroll.Max := FTextSize.Right - cRect.Right;
  if Assigned (FVScroll) then
    FVScroll.Max := FTextSize.Bottom - cRect.Bottom;}
  SetupScrollBars;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.SetInteger(Index, aValue:Integer);
begin
  case Index of
    0: FScrollStep.X:=aValue;
    1: FScrollStep.Y:=aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextScrollPanel.GetInteger(Index:Integer):Integer;
begin
  case Index of
    0: result:=FScrollStep.X;
    1: result:=FScrollStep.Y;
    else Result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.SetScrollBarObject (index: Integer; aValue: TLMDScrollBarObject);
begin
  case index of
    0: FVSet.Assign (aValue);
    1: FHSet.Assign (aValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.SetScrollBars (aValue : TLMDTextScrollBarKind);

{var
  aRect : TRect; //needed for the alignment of scrollbars

          {procedure CreateVScroll;
          begin
            FVScroll := TLMDScrollBar.Create (self);
            FVScroll.Parent := self;
            FVScroll.CanBeFocused := false;
            FVScroll.Kind := LMDSBar.skVertical;
            FVScroll.Width := 16;
            FVScroll.Min := 0;
            FVScroll.Max := 0;
            FVScroll.ThumbMode := tmAuto;
            FVScroll.OnScroll := DoOnVScroll;
            FVScrollObj.AssignToScrollBar (FVScroll);
          end;
          procedure CreateHScroll;
          begin
            FHScroll := TLMDScrollBar.Create (self);
            FHScroll.Parent := self;
            FHScroll.CanBeFocused := false;
            FHScroll.ThumbMode := tmAuto;
            FHScroll.OnScroll := DoOnHScroll;
            FHScroll.Min := 0;
            FHScroll.Max := 0;
            if (Alignment <> taLeftJustify) or not FWordWrap then
              begin
                FHScroll.Enabled := false;
                if FScrollBars = skAuto then
                  FHScroll.Visible := false;
              end;
            FHScrollObj.AssignToScrollBar (FHScroll);
          end;}

begin
  {if aValue <> FScrollBars then
    begin
      FScrollBars := aValue;
      case FScrollBars of
        skNone : begin
                   if FHScroll <> nil then
                     begin
                       FHScroll.Free;
                       FHScroll := nil;
                     end;
                   if FVScroll <> nil then
                     begin
                       FVScroll.Free;
                       FVScroll := nil;
                     end;
                 end;
        skVertical :
                 begin
                   if FHScroll <> nil then
                     begin
                       FHScroll.Free;
                       FHScroll := nil;
                     end;
                   if FVScroll = nil then
                     CreateVScroll;
                 end;
        skHorizontal :
                 begin
                   if FVScroll <> nil then
                     begin
                       FVScroll.Free;
                       FVScroll := nil;
                     end;
                   if FHScroll = nil then
                     CreateHScroll;
                 end;
        skBoth :
                 begin
                   if FHScroll = nil then
                     CreateHScroll;
                   if FVScroll = nil then
                     CreateVScroll;
                 end;
        skAuto :
                 begin
                   if FVScroll = nil then
                     CreateVScroll;
                   //FHScroll and FVScroll had been mixed up here
                   FVScroll.Visible := FFirstRowOut <> 1;//(FRows > FLastRowOut);, JH March 2001
                   if FHScroll = nil then
                     CreateHScroll;
                   //make the horizontal scrollbar always visible (iff it could happen that a row gets too long)
                   FHScroll.Visible := not FWordWrap;// or (ALignment <> taLeftJustify));
                 end;
      end; //end case
      if not (csDestroying in ComponentState) then
        begin
          aRect := Rect (0,0,0,0);
          AlignControls (nil, aRect);
          Paint;
        end;
    end; //end if}
end; //end procedure

{ ----------------------------------- protected ------------------------------ }
procedure TLMDTextScrollPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer);
begin
  SetFocus;
  inherited MouseDown (Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.KeyUp(var Key: Word; Shift: TShiftState);
var i:  Integer;
begin
  inherited KeyUp (Key, Shift);
  case Key of
    VK_DOWN: begin i := FPos.Y - 1; DoVScroll (self, scLineDown, i); end;
    VK_UP: begin i := FPos.Y + 1; DoVScroll (self, scLineUp, i); end;
    VK_NEXT: begin i := FPos.Y - Height; DoVScroll (self, scPageDown, i); end;
    VK_PRIOR: begin i := FPos.Y + Height; DoVScroll (self, scPageUp, i); end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.DoVScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  fs,
  fo: TPoint;
  aRect:TRect;
begin
  fs := FScrollStep;
  if fs.Y = -1 then fs.Y := 2; //dummy default value
  fo := FPos;
  case ScrollCode of
    scLineUp    : if FPos.Y-fs.Y >= -FVScroll.Max then dec(FPos.y, fs.Y) else FPos.Y := -FVScroll.Max;
    scLineDown  : if FPos.Y+fs.Y <= 0 then inc(FPos.Y, fs.Y) else FPos.Y := 0;
    scPageUp    : if FPos.Y-Height > -FVScroll.Max then dec(FPos.y, Height) else FPos.Y := -FVScroll.Max;
    scPageDown  : if FPos.Y + Height < 0 then inc(FPos.Y, Height) else FPos.Y := 0;
    scPosition  :;
    scTrack     : FPos.Y := -ScrollPos;
    scTop       :;
    scBottom    :;
    scEndScroll :;
  end;
  ScrollPos := abs (FPos.Y);
  if fo.y <> FPos.y then
    begin
      aRect := ClientRect;
      dec (aRect.Right, FVScroll.Width + Bevel.BevelExtend);
      dec (aRect.Bottom, FHScroll.Height + Bevel.BevelExtend);
      inc (aRect.Top, Bevel.BevelExtend);
      inc (aRect.Left, Bevel.BevelExtend);

      InvalidateRect (Handle, @aRect, true);
      //Paint;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.DoHScroll (Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  fs,
  fo: TPoint;
  aRect:TRect;
begin
  if fs.X = -1 then fs.X := 2; //dummy default value
  fo := FPos;
  case ScrollCode of
    scLineUp    : if FPos.X-fs.X>= -FHScroll.Max then dec(FPos.X, fs.X) else FPos.X := -FHScroll.Max;
    scLineDown  : if FPos.X+fs.X <= 0 then inc(FPos.X, fs.X) else FPos.X := 0;
    scPageUp    : if FPos.X-Width > -FHScroll.Max then dec(FPos.X, Width) else FPos.X := -FHScroll.Max;
    scPageDown  : if FPos.X + Width < 0 then inc(FPos.X, Width) else FPos.X := 0;
    scPosition  :;
    scTrack     : FPos.X := -ScrollPos;
    scTop       :;
    scBottom    :;
    scEndScroll :;
  end;
  ScrollPos := abs (FPos.X);
  if fo.x <> FPos.x then
    begin
      aRect := ClientRect;
      dec (aRect.Right, FVScroll.Width + Bevel.BevelExtend);
      dec (aRect.Bottom, FHScroll.Height + Bevel.BevelExtend);
      inc (aRect.Top, Bevel.BevelExtend);
      inc (aRect.Left, Bevel.BevelExtend);

      InvalidateRect (Handle, @aRect, false);
      //      Paint;
    end;
//    Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.DoTxtChange (Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  TextSettings.Parent := self;
  TextSettings.Parse (GetTextLines);
  UpdateAndRefresh;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.UpdateAndRefresh;
var
  aRect: TRect;
begin
  aRect := ClientRect;
  dec (aRect.Right, FVScroll.Width);
  dec (aRect.Bottom, FHScroll.Height);
  FTextSize := TextSettings.GetClientRect (Canvas, aRect, Font, false, WordWrap);
  SetupScrollBars;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.AlignControls (AControl: TControl; var ARect: TRect);
begin
  inherited AlignControls (AControl, aRect);
  FVScroll.Top := Bevel.BevelExtend;
  FVScroll.Left := Width - FVScroll.Width - Bevel.BevelExtendRight;
  FVScroll.Height := Height -  FHScroll.Height - Bevel.BevelExtend * 2;
  FHScroll.Top := Height - FHScroll.Height - Bevel.BevelExtend;
  FHScroll.Width := Width - FVScroll.Width - Bevel.BevelExtend * 2;
  FHScroll.Left := Bevel.BevelExtend;
  UpdateAndRefresh;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextScrollPanel.GetClientRect: TRect;
begin
  result := inherited GetClientRect;
  //dec (result.Right, FVScroll.Width);
  //dec (result.Bottom, FHScroll.Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.SetupScrollBars;
begin
  FVScroll.Max := FTextSize.Bottom - Height + FHScroll.Height + Bevel.BevelExtend * 2;
  FHScroll.Max := FTextSize.Right - (Width {- Bevel.BevelExtend * 2?}) + FVScroll.Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextScrollPanel.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
var
  R:      TRect;
  myFont: TFont;
begin
  myFont := TFont.Create;
  try
    myFont.Assign(self.Font);
    myFont.Color := GetThemedTextColor;
    Canvas.Font  := myFont;

    R := aRect;
    dec (R.Right, FVScroll.Width);
    dec (R.Bottom, FHScroll.Height);
    TextSettings.Render(Canvas, R, FPos, myFont, Color, false, WordWrap)
  finally
    myFont.Free;
  end;
end;

{ -------------------------------- public ------------------------------------ }
constructor TLMDTextScrollPanel.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];

  FVSet := TLMDScrollBarObject.Create;
  FHSet := TLMDScrollBarObject.Create;
  FScrollBars:=skBoth;

  FHScroll := TLMDScrollBar.Create (Self);
  FHScroll.Parent := self;
  FHScroll.OnScroll := DoHScroll;
  FHScroll.CanBeFocused := false;
  FHScroll.ThumbLength := 0;

  FVScroll := TLMDScrollBar.Create (Self);
  FVScroll.Parent := self;
  FVScroll.BeginUpdate;
  FVScroll.Kind := skVertical;
  FVScroll.EndUpdate(false);
  FVScroll.Width := 18;
  FVScroll.OnScroll := DoVScroll;
  FVScroll.CanBeFocused := false;

  FScrollStep := Point (-1, -1);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextScrollPanel.Destroy;
begin
  FreeAndNil(FHSet);
  FreeAndNil(FVSet);
  inherited Destroy;
end;

end.
