unit LMDCustomSwitch;
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

LMDCustomSwitch unit ()
-----------------------

Changes
-------
Release 8.02 (November 2007)
+ OnChange event added

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls,
  LMDGraphicControl, LMDCaption, LMDCustomControl, LMDBevel, Messages;

type
  {------------------------ TLMDCustomSwitch ----------------------------------}
  TLMDCustomSwitch = class(TLMDGraphicControl)
  private
    FChecked,
    FCheckedLeft: Boolean;
    FCaptionOn,
    FCaptionOff: TLMDCaption;
    FSlope,
    FSideLength: Byte;
    FOnColor,
    FOffColor,
    FTopColor,
    FSideColor: TColor;
    {Internal used variable}
    LabelLen: Integer;
    FOnChange: TNotifyEvent;
    procedure SetCaption(Index:Integer;Value: TLMDCaption);
    procedure SetChecked(Value: Boolean);
    procedure SetCheckedLeft(Value: Boolean);
    procedure SetColor(Index:Integer; Value: TColor);
    procedure SetSlope(Value: Byte);
    procedure SetSideLength(Value: Byte);
  protected
    procedure GetChange(Sender:TObject); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint;override;
    procedure Toggle;virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property Checked: Boolean read FChecked write SetChecked default False;
  published
    property About;
    property Bevel;
    property CaptionChecked: TLMDCaption index 0 read FCaptionOn write SetCaption;
    property CaptionUnChecked: TLMDCaption index 1 read FCaptionOff write SetCaption;
    property CheckedLeft: Boolean read FCheckedLeft write SetCheckedLeft default True;
    property Color;
    property ColorChecked:TColor index 0 read FOnColor write SetColor default clRed;
    property ColorUnChecked:TColor index 1 read FOffColor write SetColor default clMaroon;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SideColor:TColor index 3 read FSideColor write SetColor default clSilver;
    property SideLength:Byte read FSideLength write SetSideLength default 6;
    property Slope:Byte read FSlope write SetSlope default 6;
    property Transparent;
    property TopColor:TColor index 2 read FTopColor write SetColor default clSilver;
    property Visible;

    // 8.02
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    // ---
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

  end;

{------------------------ TLMDWCustomSwitch ----------------------------------}
  TLMDWCustomSwitch = class(TLMDCustomControl)// TLMDGraphicControl)
  private
    FBevel: TLMDBevel;
    FChecked,
    FCheckedLeft: Boolean;
    FCaptionOn,
    FCaptionOff: TLMDCaption;
    FSlope,
    FSideLength: Byte;
    FOnColor,
    FOffColor,
    FTopColor,
    FSideColor: TColor;
    {Internal used variable}
    LabelLen: Integer;
    FOnChange: TNotifyEvent;

    procedure SetCaption(Index:Integer;Value: TLMDCaption);
    procedure SetChecked(Value: Boolean);
    procedure SetCheckedLeft(Value: Boolean);
    procedure SetColor(Index:Integer; Value: TColor);
    procedure SetSlope(Value: Byte);
    procedure SetSideLength(Value: Byte);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMFocusChanged(var Msg : TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure SetBevel(const aValue: TLMDBevel);
    protected
    procedure KeyPress(var Key: Char); override;
    procedure GetChange(Sender:TObject); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint;override;
    procedure Toggle;virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property Checked: Boolean read FChecked write SetChecked default False;
  published
    property About;
    property Bevel: TLMDBevel read FBevel write SetBevel;
    property CaptionChecked: TLMDCaption index 0 read FCaptionOn write SetCaption;
    property CaptionUnChecked: TLMDCaption index 1 read FCaptionOff write SetCaption;
    property CheckedLeft: Boolean read FCheckedLeft write SetCheckedLeft default True;
    property Color;
    property ColorChecked:TColor index 0 read FOnColor write SetColor default clRed;
    property ColorUnChecked:TColor index 1 read FOffColor write SetColor default clMaroon;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SideColor:TColor index 3 read FSideColor write SetColor default clSilver;
    property SideLength:Byte read FSideLength write SetSideLength default 6;
    property Slope:Byte read FSlope write SetSlope default 6;
    property Transparent;
    property TopColor:TColor index 2 read FTopColor write SetColor default clSilver;
    property Visible;

    // 8.02
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    // ---
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Types, LMDClass,
  LMDGraph, LMDConst;

{************************ Class TLMDCustomSwitch ******************************}
{Used arrays by all LMDSwitch objects}
var
  TopShape:array[0..2] of TPoint;
  OnShape, OffShape, SideShape:array[0..3] of TPoint;

{----------------------- Private ----------------------------------------------}
procedure TLMDCustomSwitch.SetCaption(Index:Integer;Value:TLMDCaption);
begin
  case Index of
    0:FCaptionOn.Assign(Value);
    1:FCaptionOff.Assign(Value);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
    begin
      FChecked:=Value;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.SetCheckedLeft(Value: Boolean);
begin
  if FCheckedLeft <> Value then
  begin
    FCheckedLeft:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.SetSlope(Value: Byte);
begin
  if FSlope <> Value then
  begin
    FSlope:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.SetSideLength(Value: Byte);
begin
  if (FSideLength <> Value) and (Value < Width - 4) then
  begin
    FSideLength:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.SetColor(Index:Integer; Value:TColor);
begin

  case index of
  0: if FOnColor=Value then exit else FOnColor:=Value;
  1: if FOffColor=Value then exit else FOffColor:=Value;
  2: if FTopColor=Value then exit else FTopColor:=Value;
  3: if FSideColor=Value then exit else FSideColor:=Value;
  end;
  GetChange(nil);
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDCustomSwitch.GetChange(Sender:TObject);
begin
  If ((Sender=FCaptionOff) and (FChecked)) or ((Sender=FCaptionOn) and (not FChecked)) then exit;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button,Shift,X,Y);
  if (Button = mbLeft) then
    if ((LabelLen > 0) and (X > Bevel.BevelExtend+LabelLen)) or
       ((LabelLen < 0) and (X < Bevel.BevelExtend+Abs(LabelLen))) then Toggle;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.Paint;
var
  IRect:TRect;
  tempcap:TLMDCaption;
  Side, LabelOfs:Integer;

begin

  if not Transparent then
    with Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := Color;
        with ClientRect do
          FillRect(Rect(Left, Height-FSlope, Width, Height+1));
      end;

  Irect:=Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height - FSlope), Transparent);

  {Vorbereitungen}
  IRect.Bottom:=Height - (FSlope+1) - 2 * IRect.Top;   {Schalterhöhe = Height - Ofs - Neigung}
  IRect.Right:=Width - 2 * IRect.Left-1;                  {Schalterbreite = Width - 2 * Ofs}

  LabelLen:=IRect.Right div 2;

  LabelOfs:=LabelLen + IRect.Left;
  Side:=FSideLength;

  if (not FChecked and FCheckedLeft) or (not FCheckedLeft and FChecked) then
    begin
      LabelLen:=-LabelLen;
      Side:=-FSideLength;
    end;

  TopShape[0].X:=LabelOfs;          {Vektoren von obere Dreieckfläche berechnen}
  TopShape[0].Y:=IRect.Top;
  TopShape[1].X:=LabelOfs + LabelLen - Side;
  TopShape[1].Y:=IRect.Top + FSlope;
  TopShape[2].X:=LabelOfs + LabelLen;
  TopShape[2].Y:=IRect.Top;

  OnShape[0].X:=LabelOfs - LabelLen;   {Vektoren der "EIN" Frontseite berechnen}
  OnShape[0].Y:=IRect.Top;
  OnShape[1]:=TopShape[0];
  OnShape[2].X:= TopShape[0].X;
  OnShape[2].Y:= IRect.Top + IRect.Bottom;;
  OnShape[3].X:=OnShape[0].X;
  OnShape[3].Y:=OnShape[2].Y;

  OffShape[0]:=TopShape[0];            {Vektoren der "AUS" Frontseite berechnen}
  OffShape[1]:=TopShape[1];
  OffShape[2].X:=OffShape[1].X;
  OffShape[2].Y:=OffShape[1].Y + IRect.Bottom;
  OffShape[3].X:=OffShape[0].X;
  OffShape[3].Y:=OnShape[2].Y;

  SideShape[0]:=OffShape[1];               {Vektoren der Seitenfläche berechnen}
  SideShape[1]:=TopShape[2];
  SideShape[2].X:=SideShape[1].X;
  SideShape[2].Y:=IRect.Top + IRect.Bottom;
  SideShape[3]:=OffShape[2];

  {Zielrechteck für Schriftausgabe}
  If LabelLen > 0 then LabelOfs:=IRect.Left;

  IRect:=Rect(LabelOfs+1, IRect.Top, LabelOfs+Abs(LabelLen), IRect.Top+IRect.Bottom);

  {---------------------- Zeichenroutinen -------------------------------------}
  with Canvas do
    begin
      Pen.Color:=clBlack;                      {Polygonumrandung ist schwarz}
      Brush.Style:=bsSolid;                    {Füllfläche ist geschlossen}

      Brush.Color:=FTopColor;
      Polygon(TopShape);                       {Top des Schalters zeichnen}
      Brush.Color:=FSideColor;
      Polygon(SideShape);                      {Seite des Schalters zeichnen}

      Brush.Color:=FOffColor;
      Polygon(OffShape);                       {Off Seite des Schalters zeichnen}

      if FChecked then
        begin
          Brush.Color:=FOnColor ;
          tempCap:=FCaptionOn;
        end
      else
        begin
          Brush.Color:=FOffColor;
          tempCap:=FCaptionOff;
        end;
      Polygon(OnShape);                        {On Seite des Schalters zeichnen}

      {Text ausgeben}
      {------------------------------------------------------------------------}
      if tempcap.Caption<>'' then
        tempcap.DrawCaption(Canvas, '', IRect, [TLMDDrawTextStyle(Enabled), dtClip],
                            Canvas.Brush.Color, MakeLong(Left, Top));
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSwitch.Toggle;
begin
  FChecked:=not FChecked;
  if Assigned(FOnChange) then
    FOnChange(self);
  GetChange(nil);
end;

{------------------------ Public ----------------------------------------------}
constructor TLMDCustomSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  {--> hier noch RessourcenWerte einfügen}
  FCaptionOn:=TLMDCaption.CreateParams(IDS_ON, 'Arial', 8, clBlack, GetChange);
  FCaptionOff:=TLMDCaption.CreateParams(IDS_OFF, 'Arial', 8, clBlack, GetChange);

  FSlope:=6;
  FSideLength:=6;
  FChecked:=False;
  FCheckedLeft:=True;

  FOnColor:=clRed;
  FOffColor:=clMaroon;
  FTopColor:=clSilver;
  FSideColor:=clSilver;

  ControlStyle := ControlStyle + [csReplicatable];
  SetBounds(Left,Top,83,18 + FSlope);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSwitch.Destroy;
begin
  FCaptionOn.OnChange:=nil;
  FCaptionOff.OnChange:=nil;
  FCaptionOn.Free;
  FCaptionOff.Free;
  inherited Destroy;
end;

{****************** Class TLMDWCustomSwitch ***********************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDWCustomSwitch.SetCaption(Index:Integer;Value:TLMDCaption);
begin
  case Index of
    0:FCaptionOn.Assign(Value);
    1:FCaptionOff.Assign(Value);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
    begin
      FChecked:=Value;
      // InvalidateControl;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetCheckedLeft(Value: Boolean);
begin
  if FCheckedLeft <> Value then
  begin
    FCheckedLeft:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetSlope(Value: Byte);
begin
  if FSlope <> Value then
  begin
    FSlope:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetSideLength(Value: Byte);
begin
  if (FSideLength <> Value) and (Value < Width - 4) then
  begin
    FSideLength:=Value;
    GetChange(nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.WMSetFocus(var Message: TWMSetFocus); //TODO: Remove
begin
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.WMKillFocus(var Message: TWMKillFocus);
begin
  Invalidate
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.CMFocusChanged(var Msg : TCMFocusChanged);
begin
  inherited;
  if Msg.Sender = Self then
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetColor(Index:Integer; Value:TColor);
begin

  case index of
  0: if FOnColor=Value then exit else FOnColor:=Value;
  1: if FOffColor=Value then exit else FOffColor:=Value;
  2: if FTopColor=Value then exit else FTopColor:=Value;
  3: if FSideColor=Value then exit else FSideColor:=Value;
  end;
  GetChange(nil);
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDWCustomSwitch.GetChange(Sender:TObject);
begin
  If ((Sender=FCaptionOff) and (FChecked)) or ((Sender=FCaptionOn) and (not FChecked)) then exit;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button,Shift,X,Y);
  if (Button = mbLeft) then
    if ((LabelLen > 0) and (X > Bevel.BevelExtend+LabelLen)) or
       ((LabelLen < 0) and (X < Bevel.BevelExtend+Abs(LabelLen))) then Toggle;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.Paint;
var
  IRect:TRect;
  tempcap:TLMDCaption;
  Side, LabelOfs:Integer;
  LSaveColor: TColor;
begin

  if not Transparent then
    with Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := Color;
        with ClientRect do
          FillRect(Rect(Left, Height-FSlope, Width, Height+1));
      end;

   Irect:=Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height - FSlope), Transparent);

  {Vorbereitungen}
  IRect.Bottom:=Height - (FSlope+1) - 2 * IRect.Top;   {Schalterhöhe = Height - Ofs - Neigung}
  IRect.Right:=Width - 2 * IRect.Left-1;                  {Schalterbreite = Width - 2 * Ofs}

  LabelLen:=IRect.Right div 2;

  LabelOfs:=LabelLen + IRect.Left;
  Side:=FSideLength;

  if (not FChecked and FCheckedLeft) or (not FCheckedLeft and FChecked) then
    begin
      LabelLen:=-LabelLen;
      Side:=-FSideLength;
    end;

  TopShape[0].X:=LabelOfs;
  TopShape[0].Y:=IRect.Top;
  TopShape[1].X:=LabelOfs + LabelLen - Side;
  TopShape[1].Y:=IRect.Top + FSlope;
  TopShape[2].X:=LabelOfs + LabelLen;
  TopShape[2].Y:=IRect.Top;

  OnShape[0].X:=LabelOfs - LabelLen;
  OnShape[0].Y:=IRect.Top;
  OnShape[1]:=TopShape[0];
  OnShape[2].X:= TopShape[0].X;
  OnShape[2].Y:= IRect.Top + IRect.Bottom;;
  OnShape[3].X:=OnShape[0].X;
  OnShape[3].Y:=OnShape[2].Y;

  OffShape[0]:=TopShape[0];
  OffShape[1]:=TopShape[1];
  OffShape[2].X:=OffShape[1].X;
  OffShape[2].Y:=OffShape[1].Y + IRect.Bottom;
  OffShape[3].X:=OffShape[0].X;
  OffShape[3].Y:=OnShape[2].Y;

  SideShape[0]:=OffShape[1];
  SideShape[1]:=TopShape[2];
  SideShape[2].X:=SideShape[1].X;
  SideShape[2].Y:=IRect.Top + IRect.Bottom;
  SideShape[3]:=OffShape[2];


  If LabelLen > 0 then LabelOfs:=IRect.Left;
  IRect:=Rect(LabelOfs+1, IRect.Top, LabelOfs+Abs(LabelLen), IRect.Top+IRect.Bottom);

  {---------------------- Zeichenroutinen -------------------------------------}
  with Canvas do
    begin
      Pen.Color:=clBlack;
      Brush.Style:=bsSolid;

      Brush.Color:=FTopColor;
      Polygon(TopShape);         
      Brush.Color:=FSideColor;
      Polygon(SideShape);        

      Brush.Color:=FOffColor;
      Polygon(OffShape);         

      if FChecked then
        begin
          Brush.Color:=FOnColor ;
          tempCap:=FCaptionOn;
        end
      else
        begin
          Brush.Color:=FOffColor;
          tempCap:=FCaptionOff;
        end;
      Polygon(OnShape);

      {Text ausgeben}
      {------------------------------------------------------------------------}
      if tempcap.Caption<>'' then
        tempcap.DrawCaption(Canvas, '', IRect, [TLMDDrawTextStyle(Enabled), dtClip],
                            Canvas.Brush.Color, 0{MakeLong(Left, Top)});
      //inherited; VB Aug 2010 <-- causes incorrect look (empty rect) in classic mode
      if Focused then
      begin
        LSaveColor := Canvas.Brush.Color;
        Canvas.Brush.Color := clWindow;
        Canvas.DrawFocusRect(Bounds(0, 0, Width, Height));
        Canvas.Brush.Color := LSaveColor;
      end;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.Toggle;
begin
  FChecked:=not FChecked;
  if Assigned(FOnChange) then
    FOnChange(self);
  GetChange(nil);
end;

{------------------------ Public ----------------------------------------------}
constructor TLMDWCustomSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  {--> hier noch RessourcenWerte einfügen}
  FCaptionOn:=TLMDCaption.CreateParams(IDS_ON, 'Arial', 8, clBlack, GetChange);
  FCaptionOff:=TLMDCaption.CreateParams(IDS_OFF, 'Arial', 8, clBlack, GetChange);

  FSlope:=6;
  FSideLength:=6;
  FChecked:=False;
  FCheckedLeft:=True;

  FOnColor:=clRed;
  FOffColor:=clMaroon;
  FTopColor:=clSilver;
  FSideColor:=clSilver;

  ControlStyle := ControlStyle + [csReplicatable];
  SetBounds(Left,Top,83,18 + FSlope);

  FBevel := TLMDBevel.Create(Self);
  FBevel.OnChange := GetChange;
  TabStop := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDWCustomSwitch.Destroy;
begin
  FCaptionOn.OnChange:=nil;
  FCaptionOff.OnChange:=nil;
  FCaptionOn.Free;
  FCaptionOff.Free;
  FBevel.OnChange := nil;
  FBevel.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.KeyPress(var Key: Char);
begin
  if Ord(Key) = VK_SPACE then
    Toggle;
end;

{------------------------------------------------------------------------------}
procedure TLMDWCustomSwitch.SetBevel(const aValue: TLMDBevel);
begin
  FBevel.Assign(aValue);
  Perform (CM_LMDBEVELCHANGED, 0, 0);
end;

end.
