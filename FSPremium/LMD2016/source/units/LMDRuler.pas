unit LMDRuler;
interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, menus, Forms,
  LMDClass, lmdgraph, LMDCustomPanel;

type

  TLMDMeasureEvent=procedure(Sender :TObject; MeasureStart, MeasureEnd,
                             Delta:integer; IsHorzRuler :Boolean) of object;

  TLMDAlignDir=(adRulertoControl, adControltoRuler, adNone);

  TLMDRulerOption=(roUseTickColor, roRevertLabels, roRevertTicks, roNoSmallTicks);
  TLMDRulerOptions=set of TLMDRulerOption;

  TLMDRuler = class(TLMDCustomPanel)
  private
    FBorderStyle:TLMDBorderStyle;
    FCAlign:TLMDAlignDir;
    FControl:TControl;
    FScaleFactor:Integer;
    FLeftMargin,
    FRightMargin,
    FLabelMargin:Integer;
    FOptions:TLMDRulerOptions;

    {?????}
    FLeftVal, FRightVal :integer;

    {distance markers}
    FBigDist,
    FNormalDist,
    FSmallDist:Integer;
    {colors for distance markers}
    FBigColor,
    FNormalColor,
    FSmallColor:TColor;

    {internal status variables}
    FIsPainting:Boolean;
    FIsMeasuring:Boolean;
    FCurrentPos:TPoint;
    FHorz:Boolean;
    FPenVisible:Boolean;

    {measuring feature}
    FMeasureEnd,  {Koordinaten}
    FMeasureStart:integer;
    FMeasureColor:TColor;

    FInternal:TRect;

    {added Event}
    FOnMeasure:TLMDMeasureEvent;
    procedure SetAlignDir(aDir:TLMDAlignDir);
    procedure SetBorderStyle(aValue:TLMDBorderstyle);
    procedure SetColor(Index:Integer; aColor:TColor);
    procedure SetControl(aControl:TControl);
    procedure SetHorizontal(aValue:Boolean);
    procedure SetInteger(Index:Integer; aValue:integer);
    procedure SetOptions(aValue:TLMDRulerOptions);
    function CheckRange(x,y:Integer):Boolean;
    function GetBevelExtend:Integer;
    function HasControl:Boolean;
  protected
    procedure DrawPositionTick(ACanvas:TCanvas; ax,ay :integer);
    procedure Loaded;override;
    procedure Notification(AComponent:TComponent; Operation: TOperation); override;
    procedure Paint; override;

    property PenVisible:Boolean read FPenVisible write FPenVisible;
  public
    procedure DefaultHandler(var Message); override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    {Resizing}
    procedure DoControlResize;
    {Position}
    procedure DrawTick(ax,ay:integer);
    procedure DrawNotTick;
    {Measure}
    procedure BeginMeasure(ax,ay:integer);
    procedure Measure(ax,ay:integer);
    procedure EndMeasure;

    property MeasureStart:integer read FMeasureStart;
    property BevelExtend:Integer read GetBevelExtend;
  published

    Property About;
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    
    {Zusätzlich}
    property AlignControl:TLMDAlignDir read fcAlign write SetAlignDir default adNone;
    property BigDist:Integer index 0 read FBigDist write SetInteger default 50;
    property BigColor:TColor index 0 read FBigColor write SetColor default clBlack;
    property BorderStyle:TLMDBorderStyle read FBorderStyle write SetBorderStyle default lsLowered;
    property Control: TControl read FControl write SetControl stored HasControl;
    property Horizontal : Boolean read FHorz write SetHorizontal default True;
    property LabelMargin:Integer index 8 read FLabelMargin write SetInteger default 1;
    property LeftMargin:Integer index 3 read FLeftMargin write SetInteger default 0;
    property LeftVal:Integer index 6 read FLeftVal write SetInteger default 0;
    property MeasureColor:TColor read FMeasureColor write FMeasureColor default clNavy;
    property NormalDist:Integer index 1 read FNormalDist write SetInteger default 10;
    property NormalColor:TColor index 1 read FNormalColor write SetColor default clBlack;
    property Options:TLMDRulerOptions read FOptions write SetOptions default [];
    property RightMargin:Integer index 4 read FRightMargin write SetInteger default 0;
    property RightVal:Integer index 7 read FRightVal write SetInteger default 1000;
    property ScaleFactor:Integer index 5 read FScalefactor write SetInteger default 1;
    property SmallDist:Integer index 2 read FSmallDist write SetInteger default 5;
    property SmallColor:TColor index 2 read FSmallColor write SetColor default clBlack;

    {Events}
    property OnMeasure:TLMDMeasureEvent read FOnMeasure write FOnMeasure;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation
uses
  lmdutils, LMDGraphUtils, lmdprocs;

const
  er_SmallTick = 7;
  er_NormalTick = 9;
  er_BigTick =12;

{*************************** Class TLMDRuler **********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDRuler.SetAlignDir(aDir:TLMDAlignDir);
begin
  if adir<>fcalign then
    begin
      FCAlign:=aDir;
      if Hascontrol then DoControlresize;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetBorderStyle(aValue:TLMDBorderstyle);
begin
  if aValue<>FBorderStyle then
    begin
      FBorderStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetColor(Index:Integer; aColor:TColor);
begin
  case index of
    0:if aColor=FBigColor then exit else FBigColor:=aColor;
    1:if aColor=FNormalColor then exit else FNormalColor:=aColor;
    2:if aColor=FSmallColor then exit else FSmallColor:=aColor;
  end;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetControl(aControl:TControl);
begin
  if (assigned(aControl)) and (aControl.Parent<>nil) and (aControl<>Self) then
    begin
      FControl := AControl;
      Parent := AControl.Parent;
      DoControlResize;
      if aControl <> nil then aControl.FreeNotification(Self);
    end
  else
    FControl := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetHorizontal(aValue:Boolean);
begin
  if aValue<>FHorz then
    begin
      FHorz:=AValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetInteger(Index:Integer; aValue:integer);
begin
  case Index of
    0:if (FBigDist=aValue) or (aValue<FNormalDist) then exit else FBigDist:=aValue;
    1:if (FNormalDist=aValue) or (aValue<FSmallDist)
          or (aValue>FBigDist) then exit else FNormalDist:=aValue;
    2:if (FSmallDist=aValue) or (aValue>FNormalDist) or (aValue=0) then exit else FSmallDist:=aValue;
    3:if (FLeftMargin=aValue) or (aValue<0) then exit else FLeftMargin := aValue;
    4:if (FRightMargin=aValue) or (aValue<0) then exit else FRightMargin := aValue;
    5:if (FScaleFactor=aValue) or (aValue<1) or (aValue>50) then exit else
        FScaleFactor:=aValue;
    6:if (FLeftVal=aValue) or {(aValue<0) or } (aValue>FRightVal) then exit else
       FLeftVal:=aValue;
    7:if (FRightVal=aValue) or {(aValue<0) or} (aValue<FLeftVal) then exit else
       FRightVal:=aValue;
    8:if (aValue=FLabelMargin) or (aValue<0) then exit else FLabelMargin:=aValue;
  end;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.SetOptions(aValue:TLMDRulerOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRuler.CheckRange(x,y:Integer):Boolean;
begin
  result:=false;
  if x>-1 then
    if (x<FInternal.Left) or (x>FInternal.Right) then exit;
  if y>-1 then
    if (y<FInternal.Top) or (y>FInternal.Bottom) then exit;
  if (x<0) and (y<0) then exit;
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDRuler.GetBevelExtend:Integer;
begin
  result:=LMDDrawStdFrameExt(FBorderStyle);
end;

{------------------------------------------------------------------------------}
function TLMDRuler.HasControl:boolean;
begin
  result:=Assigned(FControl);
end;

{----------------------------  Protected---------------------------------------}
procedure TLMDRuler.DefaultHandler(var Message);
begin
  inherited DefaultHandler(Message);

  with TMessage(Message) do
    case Msg of
      WM_NCDestroy, WM_Destroy:
      begin
        DoControlResize;
      end;
    end;
end;

{---------------------------------------------------------------------------}
procedure TLMDRuler.DrawPositionTick(ACanvas:TCanvas; ax,ay :integer);
var
  OldRop:integer;
  ext:Integer;

begin
  if (csDesigning in ComponentState) or
     (csLoading in ComponentState) or (FIsPainting) then exit;

  ext:=BevelExtend;

  with ACanvas, FCurrentpos do
    begin
      OldRop:=SetRop2(ACanvas.Handle, R2_NOT);
      If not FHorz then
        begin
          if not CheckRange(-1, ay) then exit;
          Moveto(Ext, y);
          LineTo(Width-Ext, y);
          if FPenVisible then
            begin
              Moveto(Ext, ay);
              LineTo(Width-Ext, ay);
            end
          else
            begin
              Moveto(Ext, y);
              LineTo(Width-Ext, y);
            end;
        end
      else
        begin
          if not CheckRange(ax, -1) then exit;
          Moveto(x,Ext);
          LineTo(x, Height-Ext);
          if FPenVisible then
            begin
              Moveto(ax, Ext);
              LineTo(Ax, Height-Ext);
            end
          else
            begin
              Moveto(x,Ext);
              LineTo(x, Height-Ext);
            end;
        end;
    end;
  FCurrentPos:=Point(ax, ay);
  SetRop2(aCanvas.Handle, OldRop);
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.Loaded;
begin
  inherited Loaded;
  DoControlResize;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.Notification(AComponent:TComponent;Operation:TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (AComponent=Control) and (Operation = opRemove) then FControl := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.Paint;
var
  tw,bw,th,i, eValue, fasth, fastw, tmp, db, dn,
  vh, bs, ns, ss, to1, to2:integer;
  onlyatbig,onlyatbigv, doSmall:boolean;
  outstring :string;
  aRect :TRect;

  procedure DrawHTick(pos:Integer);
  begin
    outstring:=inttostr(FLeftVal+round(i /FScaleFactor));
    with Canvas do
      begin
        tw:=TextWidth(outstring);
        MoveTo(pos, vh);
        if (i mod db)=0 then
          begin
            pen.Color:=FBigColor;
            MoveTo(pos, vh);
            Lineto(pos, vh-bs);
            if roUseTickColor in FOptions then Font.Color:=FBigColor;
            Font.Style := [fsBold];
            TextOut(pos-tw div 2, to1, outstring);
            Font.Style := [];
          end
        else
          if (i mod dn)=0 then
            begin
              if not onlyatbig then
                begin
                  if roUseTickColor in FOptions then Font.Color:=FNormalColor;
                  TextOut(pos-tw div 2, to2, outstring);
                  MoveTo(pos, vh);
                end;
              pen.Color:=FNormalColor;
              Lineto(pos, vh-bs)
            end
          else
            if doSmall then
              begin
                pen.Color:=FSmallColor;
                LineTo(pos, vh-ss);
              end;
      end;
    end;

    procedure DrawVTick(pos:Integer);
    begin
      outstring := inttostr(LeftVal+(i div FScaleFactor));
      with Canvas do
        begin
          MoveTo(vh, pos);
          if (i mod db)=0 then
            begin
              if roUseTickColor in FOptions then Font.Color:=FBigColor;
              Font.Style := [fsBold];
              TextOut(to1, pos-th div 2, outstring);
              Font.Style := [];
              pen.Color:=FBigColor;
              MoveTo(vh, pos);
              Lineto(vh-bs, pos)
            end
          else
            if (i mod dn)=0 then
              begin
                if not onlyatbigv then
                  begin
                    if roUseTickColor in FOptions then Font.Color:=FNormalColor;
                    TextOut(to2, pos-th div 2, outstring);
                    MoveTo(vh, pos);
                  end;
                pen.Color:=FNormalColor;
                Lineto(vh-ns,pos)
              end
            else
              if doSmall then
                begin
                  pen.Color:=FSmallColor;
                  LineTo(vh-ss, pos);
                end;
        end;
    end;

begin
  FIsPainting := true;
  FCurrentPos:=Point(-1,-1);
  FillControl;

  bw:=LMDDrawStdFrameExt(FBorderStyle);

  fastH:=Height-bw;
  fastw:=Width-bw;

  eValue:=(FRightVal-FLeftVal)*FScaleFactor;
   if FHorz then
     begin
       if eValue>fastw-bw then eValue:=fastw-bw
     end
   else
     if eValue>fasth-bw then eValue:=fasth-bw;

  SetRectEmpty(FInternal);
  {Fette Schrift berücksichtigen}
  try
    if eValue<1 then exit;

    if not (roRevertLabels in FOptions) then
      tmp:=0
    else
      if FHorz then tmp:=fastw else tmp:=fasth;

    db:=FBigDist*FScaleFactor;
    dn:=FNormalDist*FScaleFactor;

    with Canvas do
      begin
        Font:=Self.Font;
        Font.Style :=Font.Style +[fsbold];
        tw := TextWidth(inttostr(FRightVal));
        th := TextHeight('9');
        Font.Style:=Font.Style -[fsbold];
        brush.Style:=bsClear;

        if tw>FNormalDist*FScaleFactor then onlyatBig := true else onlyatBig := false;
        if th>FNormalDist*FScaleFactor then onlyatBigv := true else onlyatBigv := false;

        doSmall:=not (roNoSmallTicks in FOptions);

        if roRevertTicks in FOptions then
          begin
            bs:=-er_BigTick;
            ns:=-er_NormalTick;
            ss:=-er_SmallTick;
            vh:=bw+1;
            if FHorz then to2:=fasth-th-FLabelMargin else to2:=fastw-tw-FLabelMargin;
            to1:=to2+2;
          end
        else
          begin
            bs:=er_BigTick;
            ns:=er_NormalTick;
            ss:=er_SmallTick;
            to1:=FlabelMargin+1;
            to2:=to1+2;
            if FHorz then vh:=fasth-1 else vh:=fastw-1;
          end;

        i:=FSmallDist*FScaleFactor;
        if FHorz then
          begin

            while i<eValue do
              begin
                DrawHTick(Abs(tmp-i));
                inc(i, FSmallDist*FScaleFactor);
              end;

            if tmp=0 then
              FInternal:=Rect(bw, bw, i, fasth)
            else
              FInternal:=Rect(tmp-i, bw, fastw, fasth);

            {Seitenränder}
            if FLeftMargin>0 then
              begin
                aRect:=Rect(0, bw+1, FLeftMargin*FScaleFactor, fasth-1);
                if roRevertLabels in FOptions then
                  begin
                    Dec(FInternal.Right, FLeftMargin*FScaleFactor);
                    OffsetRect(aRect, fastw-aRect.Right, 0);
                  end
                else
                  begin
                    OffsetRect(aRect, bw, 0);
                    Inc(FInternal.Left, FLeftMargin*FScaleFactor);
                  end;
                InvertRect(Handle, aRect);
              end;

            i:=(FRightVal-FRightMargin)*FScaleFactor;
            if (FRightMargin>0) and (i<eValue) then
              begin
                aRect:=Rect(0, bw+1, FRightMargin*FScaleFactor, fasth-1);
                if roRevertLabels in FOptions then
                  begin
                    OffsetRect(aRect, fastw-((FRightVal-FLeftVal)*FScaleFactor)+1, 0);
                    Inc(FInternal.Left, FRightMargin*FScaleFactor);
                  end
                else
                  begin
                    OffsetRect(aRect, bw+i-1, 0);
                    Dec(FInternal.Right, FRightMargin*FScaleFactor);
                  end;
                InvertRect(Handle, aRect);
              end;
          end
        else
          begin
            while i<eValue do
              begin
                DrawVTick(Abs(tmp-i));
                inc(i, FSmallDist*FScalefactor); {... und weiter}
              end;

            if tmp=0 then
              FInternal:=Rect(bw, bw, fastw, i)
            else
              FInternal:=Rect(bw, tmp-i, fastw, fasth);

            {Seitenränder}
            if FLeftMargin>0 then
              begin
                aRect:=Rect(bw+1, 0, fastw-1, FLeftMargin*FScaleFactor);
                if roRevertLabels in FOptions then
                  begin
                    Dec(FInternal.Bottom, FLeftMargin*FScaleFactor);
                    OffsetRect(aRect, 0, fasth-aRect.Bottom)
                  end
                else
                  begin
                    Inc(FInternal.Top, FLeftMargin*FScaleFactor);
                    OffsetRect(aRect, 0, bw);
                  end;
                InvertRect(Handle, aRect);
              end;

            i:=(FRightVal-FRightMargin)*FScaleFactor;
            if (FRightMargin>0) and (i<eValue) then
              begin
                aRect:=Rect(bw+1, 0 , fastw-1, FRightMargin*FScaleFactor);
                if roRevertLabels in FOptions then
                  begin
                    OffsetRect(aRect, 0, fastH-((FRightVal-FLeftVal)*FScaleFactor)+1);
                    Inc(FInternal.Top, FRightMargin*FScaleFactor);
                  end
                else
                  begin
                    OffsetRect(aRect, 0, bw+i-1);
                    Dec(FInternal.Bottom, FRightMargin*FScaleFactor);
                  end;
                InvertRect(Handle, aRect);
              end;
          end;
    end;
  finally
    {Border}
    aRect:=ClientRect;
    LMDDrawStdFrame(Canvas, aRect, FBorderStyle, 0);
    FIsPainting := false;
  end;
end;

{----------------------------  Public -----------------------------------------}
constructor TLMDRuler.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ControlStyle:=ControlStyle-[csAcceptsControls];
  FBorderStyle:=lsSingleLowered;
  FCAlign:=adNone;

  FLeftVal:=0;
  FRightVal:=1000;

  FLeftMargin := 0;   {Ränder}
  FRightMargin := 0;

  FCurrentPos.x := -1;
  FCurrentPos.y := -1;

  FSmallDist :=5;   {Default-Abstände der Striche}
  FSmallColor:=clBlack;
  FNormalDist :=10;
  FNormalColor:=clBlack;
  FBigDist := 50;
  FNormalColor:=clBlack;

  FLabelMargin:=1;
  FScaleFactor := 1;  {Skalierung}
  FHorz:=True;

  FIsPainting := true;
  FPenVisible := false;

  FMeasureStart :=0;
  FMeasureEnd :=0;
  FIsMeasuring := false;
  FMeasureColor := clNavy;
  FOnMeasure := nil;

end;

{------------------------------------------------------------------------------}
destructor TLMDRuler.Destroy;
begin
  FControl := nil;
  FOnMeasure := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.DoControlResize;
var
  Ext, tmp:Integer;
begin
  ext:=BevelExtend;
  if (HasControl) and (Align=alNone) then
    begin
      case fcalign of
        adRulerToControl:
          if FHorz then
            SetBounds(FControl.Left, FControl.Top-Height, FControl.Width,
                      2*Canvas.TextHeight('9') + 2*Ext)
          else
            begin
              tmp:=Canvas.Textwidth('9')*6+ 2*Ext;
              SetBounds(FControl.Left-tmp, FControl.Top, tmp, FControl.Height);
            end;
      adControltoRuler:
        if FHorz then
          begin
            Height := 2*Canvas.TextHeight('9') + 2*Ext;
            FControl.SetBounds(Left, Top+Height, Width, FControl.Height);
          end
        else
          begin
            Width := Canvas.Textwidth('9')*6+ 2*Ext;
            FControl.SetBounds(Left+Width, Top, FControl.Width, Height);
          end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.DrawTick(ax,ay :integer);
begin
  FPenVisible := true;
  DrawPositionTick(Canvas, ax, ay);
  FPenVisible := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.DrawNotTick;
var
  OldRop, ext:integer;
begin

  ext:=LMDDrawStdFrameExt(FBorderStyle);
  with Canvas, FCurrentpos do
    begin
      OldRop := SetRop2(Canvas.Handle, R2_NOT);
      If not FHorz then
        begin
          Moveto(Ext, y);
          LineTo(Width-Ext, y);
        end
      else
        begin
          Moveto(x, Ext);
          LineTo(x, Height-Ext);
        end;
    end;

  SetRop2(Canvas.Handle, OldRop);
end;

{Measuring function}
{------------------------------------------------------------------------------}
procedure TLMDRuler.BeginMeasure(ax, ay: integer);
begin
  if FIsMeasuring then exit;
  if FHorz then
    begin
      if CheckRange(ax, -1) then FMeasureStart:=ax else exit;
    end
  else
    if CheckRange(-1, ay) then FMeasureStart:=ay else exit;
  FIsMeasuring := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.Measure(ax, ay: integer);
var
  bw:Integer;
  st1, st2:Integer;

begin
  if not FIsMeasuring then exit;

  if FHorz then
    begin
      if CheckRange(ax,-1) then st2:=ax else exit;
    end
  else
    if CheckRange(-1,ay) then st2:=ay else exit;

  st1:=FMeasureStart;
  if st2<st1 then LMDSwapInt(st1, st2);

  bw:=BevelExtend;

  with Canvas do
    begin
      Moveto(bw,bw);
      if FHorz then
        begin
          Pen.Color := clWhite;
          LineTo(st1, bw);
          Pen.Color := FMeasureColor;
          Lineto(st2, bw);
          Pen.Color := clWhite;
          LineTo(FInternal.Right, bw);
        end
      else
        begin
          Pen.Color := clWhite;
          LineTo(bw, st1);
          Pen.Color := FMeasureColor;
          Lineto(bw, st2);
          Pen.Color := clWhite;
          LineTo(bw, FInternal.Bottom);
        end;
    end;

  if Assigned(FOnMeasure) then
    FOnMeasure(Self,st1, st2, (st2-st1), FHorz);
end;

{------------------------------------------------------------------------------}
procedure TLMDRuler.EndMeasure;
var
  bw:Integer;
begin
  bw:=BevelExtend;
  with Canvas do
    begin
      Moveto(bw,bw);
      Pen.Color := Color;
      if FHorz then
        LineTo(Width-bw, bw)
      else
        LineTo(bw, Height-bw);
     end;
  FIsMeasuring := False;
end;

end.
