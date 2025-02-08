unit LMDSpltA;
{$I lmdcmps.inc}
{$R-}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Windows, Consts, Classes, SysUtils, graphics, Messages, Controls,
  Menus, Forms,
  lmdclass, LMDGraph, lmdprocs, lmdutils, LMDgraphUtils, LMDCustomControl,
  LMDObject;


Type

  TLMDSplitWidth=0..20;
  TLMDSplitDirection=(sdHorizontal, sdVertical);
  TLMDSplitterPlace=(ossEven, ossOdd);

  TLMDSplitPane=class(TScrollBox)
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner : TComponent);override;
  published
    property BorderStyle stored false;
    property Height stored False;
    property Left stored False;
    property ParentColor stored false;
    property TabOrder stored False;
    property Top stored False;
    property Width stored False;
  end;

  TLMDCustomSplitControl=class;

  {------------------------ TLMDSplitterWindow --------------------------------}
  TLMDPaneInfo=class(TLMDObject)
    private
      FAutoScroll:Boolean;
      FColor: TColor;
      FIndex:Integer;
      Bounds: TRect;
      procedure SetAutoScroll(aValue:Boolean);
      procedure SetColor(aValue:TColor);
    public
      constructor CreateExt(aOwner:TLMDCustomSplitControl; index:Integer; foc:TNotifyEvent);
      procedure Assign(Source:TPersistent); override;
      property Index: Integer read FIndex write FIndex;
    published
      property AutoScroll:Boolean read FAutoScroll write SetAutoScroll default True;
      property Color: TColor read FColor write SetColor default clBtnFace;
    end;

  {------------------------ TLMDCustomSplitter --------------------------------}
  TLMDCustomSplitter=class(TLMDObject)
    private
      FColor: TColor;
      FDirection: TLMDSplitDirection;
      FMin, FMax: integer;
      FPosition: integer;
      FWidth: TLMDSplitWidth;
      Bounds{, PreviousBounds}: TRect;
      Within: TRect; {Slider can be moved within this rect}
      procedure SetColor(aValue: TColor);
      procedure SetDirection(aValue: TLMDSplitDirection);
      procedure SetIntegers(index: Integer; aValue: Integer);
      procedure SetWidth(aValue: TLMDSplitWidth);
    protected
      procedure Change;override;
    public
      NoUpdate: Boolean;
      constructor Create(Owner:TPersistent=nil);override;
      procedure Assign(Source:TPersistent); override;
      property Direction: TLMDSplitDirection read FDirection write SetDirection default sdVertical;
    published
      property Color: TColor read FColor write SetColor default clBtnFace;
      property Min: Integer index 0 read FMin write SetIntegers default 0;
      property Max: Integer index 1 read FMax write SetIntegers default 0;
      property Position: Integer index 2 read FPosition write SetIntegers default 50;
      property Width: TLMDSplitWidth read FWidth write SetWidth default 3;
    end;

  TLMDMainSplitter=class(TLMDCustomSplitter)
    published
      property Direction;
    end;

  TLMDSplitChangeEvent = procedure(Sender: TObject; Splitter: TLMDCustomSplitter) of Object;
  {------------------------- TLMDCustomSplitControl ---------------------------}
  TLMDCustomSplitControl=class(TLMDCustomControl)
    private
      FBorderStyle: TLMDBorderStyle;
      FBorderWidth: Byte; {0..2}

      FSplitterMain: TLMDMainSplitter;
      FSplitter2, FSplitter3: TLMDCustomSplitter;

      FPaneList,
      FPaneInfoList:TList;

      FSplitterPlace: TLMDSplitterPlace;
        {just determines whether 2nd Splitter is right/left, above/under main}

      FOnSplitChange: TLMDSplitChangeEvent;
      FOnResize,
      FOnSplitChanging:TNotifyEvent;

      ActiveSplitter: integer; {-1,0..2}

      PtMouseDown: TPoint; {stores the point where the drag begins}
      OldCursor: TCursor;
      SplitterCount: integer; {1..3}
      WindowCount: integer; {2..4}

      procedure SetBorderStyle(aValue: TLMDBorderStyle);
      procedure SetSplitterPlace(aValue: TLMDSplitterPlace);
      procedure SetMainSplitter(aValue: TLMDMainSplitter);

      procedure ClearPanes;
      procedure UpdatePane(index:Integer);
      procedure UpdatePaneInfos;

      procedure WMEraseBkGnd(var Message : TWMEraseBkGnd);message WM_ERASEBKGND;
      procedure WMParentNotify(var Message: TWMParentNotify);  message WM_PARENTNOTIFY;
      procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
      procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    protected
      procedure SetPaneInfo(index: integer; aValue: TLMDPaneInfo);
      procedure SetSplitter(index: integer; aValue: TLMDCustomSplitter);
      
      procedure WndProc(var Message: TMessage); override;
      {required by descendants}
      function GetPane(index:integer):TLMDSplitPane;
      function GetPaneInfo(index:integer):TLMDPaneInfo;
      {-----}
      procedure AdjustSplitters; virtual;
      procedure AdjustWindowBounds; virtual;
        {funtion changes for 2,3,4 windows and returns the bounds of a window
         (windows are indexed without special meaning with 0..3)}
      procedure CreateParams(var Params:TCreateParams);override;

      procedure DrawWindowEdge(index: integer);
        {draws a border for the window using the DrawEdge function}
      procedure DrawSplitterInverse(index: integer);
        {draws the inverse rect while moving the splitter}
      procedure GetChange(Sender: TObject); override;
      function GetChildOwner: TComponent; override;
      procedure Loaded;override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure Paint; override;
      procedure ReadState(Reader: TReader); override;
      procedure Resize;  override;
      procedure UpdatePanes;
      function MouseOverSlider(x,y: Integer): Integer;
      function GetSplitter(index: integer): TLMDCustomSplitter;{ virtual;}
      property SplitterPlace: TLMDSplitterPlace read FSplitterPlace write SetSplitterPlace;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy;override;
      procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
      procedure SwapPanes(first, second:Integer);
      procedure RotatePanes;

      property Pane[index:Integer]:TLMDSplitPane read GetPane;
      property PaneInfo[index:Integer]:TLMDPaneInfo read GetPaneInfo;
    published
      property About;
      property Align;
      property BorderStyle: TLMDBorderStyle read FBorderStyle write SetBorderStyle default lsLoweredSpb;
      property Cursor stored false;
      property Enabled;
      property Font;

      property Pane1: TLMDPaneInfo index 0 read GetPaneInfo write SetPaneInfo stored false;
      property Pane2: TLMDPaneInfo index 1 read GetPaneInfo write SetPaneInfo stored false;

      {property ParentColor;}
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property SplitterMain: TLMDMainSplitter read FSplitterMain write SetMainSplitter;
      property Visible;

      property OnResize:TNotifyEvent read FOnResize write FOnResize;
      property OnSplitChange: TLMDSplitChangeEvent read FOnSplitChange write FOnSplitChange;
      property OnSplitChanging: TNotifyEvent read FOnSplitChanging write FOnSplitChanging;

      // V4 enhancements
      property Anchors;
      property Constraints;
      //property OnEndDock;
      //property OnStartDock;
    end;

  {------------------------- TLMD2PaneSplitCtrl -------------------------------}
  TLMD2PaneSplitCtrl=class(TLMDCustomSplitControl)
  end;

  {------------------------- TLMD4PaneSplitCtrl -------------------------------}
  TLMD4PaneSplitCtrl=class(TLMDCustomSplitControl)
    protected
      procedure GetChange(Sender: TObject); override;
      procedure AdjustWindowBounds; override;
      procedure AdjustSplitters; override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy;override;
    published
      property Pane3: TLMDPaneInfo index 2 read GetPaneInfo write SetPaneInfo stored false;
      property Pane4: TLMDPaneInfo index 3 read GetPaneInfo write SetPaneInfo stored false;
      property Splitter2: TLMDCustomSplitter index 1 read GetSplitter write SetSplitter;
    end;

  {------------------------- TLMD3PaneSplitCtrl -------------------------------}
  TLMD3PaneSplitCtrl=class(TLMDCustomSplitControl)
    protected
      procedure AdjustWindowBounds; override;
      procedure AdjustSplitters; override;
      procedure GetChange(Sender: TObject); override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy;override;
    published
      property Pane3: TLMDPaneInfo index 2 read GetPaneInfo write SetPaneInfo stored false;
      property Splitter2: TLMDCustomSplitter index 1 read GetSplitter write SetSplitter;
      property SplitterPlace;
    end;

  {------------------------- TLMD4Pane3SplitCtrl ------------------------------}
  TLMD4Pane3SplitCtrl=class(TLMDCustomSplitControl)
    protected
      procedure AdjustWindowBounds; override;
      procedure AdjustSplitters; override;
      procedure GetChange(Sender: TObject); override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy;override;
    published
      property Pane3: TLMDPaneInfo index 2 read GetPaneInfo write SetPaneInfo stored false;
      property Pane4: TLMDPaneInfo index 3 read GetPaneInfo write SetPaneInfo stored false;
      property Splitter2: TLMDCustomSplitter index 1 read GetSplitter write SetSplitter;
      property Splitter3: TLMDCustomSplitter index 2 read GetSplitter write SetSplitter;
      property SplitterPlace;
    end;


implementation
const
  TWO_SPLITTERS=11;

var
  Registered:Boolean;

{helper}
{------------------------------------------------------------------------------}
function GetSplitCursor(direction: TLMDSplitDirection):TCursor;
begin
  if direction=sdVertical then result:=crHSplit else result:=crVSplit;
end;

{*********************** TLMDPaneInfo *****************************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDPaneInfo.SetAutoScroll(aValue: Boolean);
begin
  if FAutoScroll<>aValue then
    begin
      FAutoScroll:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPaneInfo.SetColor(aValue: TColor);
begin
  if FColor<>aValue then
    begin
      FColor:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDPaneInfo.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDPaneInfo then
    begin
      FColor:=TLMDPaneInfo(Source).Color;
      Bounds:=TLMDPaneInfo(Source).Bounds;
      FAutoScroll:=TLMDPaneInfo(Source).AutoScroll;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
constructor TLMDPaneInfo.CreateExt(aOwner:TLMDCustomSplitControl; index:Integer; foc:TNotifyEvent);
begin
  inherited Create;
  FAutoScroll:=True;
  FColor:=clBtnFace;
  FIndex:=Index;
  OnChange:=foc;
  Bounds:=Rect(0,1,0,1);
end;

{*********************** TLMDCustomSplitter ***********************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDCustomSplitter.SetColor(aValue: TColor);
begin
  if FColor<>aValue then
    begin
      FColor:=aValue;
      if not NoUpdate then Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitter.SetDirection(aValue: TLMDSplitDirection);
begin
  if FDirection<>aValue then
    begin
      FDirection:=aValue;
      if not NoUpdate then Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitter.SetIntegers(index: Integer; aValue: Integer);
begin
  case index of
    0: if FMin=aValue then exit else FMin:=aValue;
    1: if FMax=aValue then exit else FMax:=aValue;
    2: if FPosition=aValue then exit else FPosition:=aValue;
  end;
  if not NoUpdate then Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitter.SetWidth(aValue: TLMDSplitWidth);
begin
  if FWidth<>aValue then
    begin
      FWidth:=aValue;
      if not NoUpdate then Change;
    end;
end;
{------------------------- Protected ------------------------------------------}
procedure TLMDCustomSplitter.Change;
begin
  inherited Change;
end;
{------------------------- Public ---------------------------------------------}
procedure TLMDCustomSplitter.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDCustomSplitter then
    begin
      FColor:=TLMDCustomSplitter(Source).Color;
      FDirection:=TLMDCustomSplitter(Source).Direction;
      FMin:=TLMDCustomSplitter(Source).Min;
      FMax:=TLMDCustomSplitter(Source).Max;
      FPosition:=TLMDCustomSplitter(Source).Position;
      if not NoUpdate then Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomSplitter.Create;
begin
  inherited Create;
  NoUpdate:=False;
  FColor:=clBtnFace;
  FDirection:=sdVertical;
  FMin:=0;
  FMax:=0;
  FPosition:=50;
  FWidth:=3;
end;

{-------------------------- TLMDSplitPane -------------------------------------}
{-------------------------- Private -------------------------------------------}
{-------------------------- Protected -----------------------------------------}
procedure TLMDSplitPane.ReadState(Reader: TReader);
var
  tmp:TComponent;
begin
  if Reader.Parent is TLMDCustomSplitControl then
    begin
      tmp:=Reader.Owner;
      Reader.Owner:=Reader.Root;
      try
        TLMDCustomSplitControl(Reader.Parent).FPaneList.Add(Self);
        inherited ReadState(Reader);
      finally
        Reader.Owner:=tmp;
      end;
    end
  else
    inherited ReadState(Reader);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDSplitPane.Create(AOwner : TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle + [csAcceptsControls]-[csReplicatable];
  BorderStyle:=bsNone;
end;

{********************** class TLMDCustomSplitControl **************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDCustomSplitControl.SetBorderStyle(aValue: TLMDBorderStyle);
begin
  if FBorderStyle<>aValue then
    begin
      FBorderStyle:=aValue;
      FBorderWidth:=LMDDrawStdFrameExt(FBorderStyle);
      GetChange(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.SetPaneInfo(index: integer; aValue: TLMDPaneInfo);
begin
  if Index<FPaneInfoList.Count then
    TLMDPaneInfo(FPaneInfoList[index]).Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.SetSplitterPlace(aValue: TLMDSplitterPlace);
begin
  if FSplitterPlace<>aValue then
    begin
      FSplitterPlace:=aValue;
      GetChange(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.SetMainSplitter(aValue: TLMDMainSplitter);
begin
  FSplitterMain.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.SetSplitter(index: integer; aValue: TLMDCustomSplitter);
begin
  case index of
    1: if Assigned(FSplitter2) then FSplitter2.Assign(aValue);
    2: if Assigned(FSplitter3) then FSplitter3.Assign(aValue);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.ClearPanes;
begin
  while FPaneList.Count>0 do
    begin
      TLMDSplitPane(FPaneList[Pred(FPaneList.Count)]).Free;
      FPaneList.Delete(Pred(FPaneList.Count));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.UpdatePane(index:Integer);
begin
  if csReading in ComponentState then Exit;
  with TLMDSplitPane(Pane[Index]) do
    begin
      AutoScroll:=PaneInfo[Index].AutoScroll;
      Color:=PaneInfo[Index].Color;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.UpdatePaneInfos;
var
  i:Integer;
begin
  for i:=0 to Pred(FPaneList.Count) do
    with PaneInfo[i] do
      begin
        BeginUpdate;
        Index:=i;
        AutoScroll:=TLMDSplitPane(Pane[i]).AutoScroll;
        Color:=TLMDSplitPane(Pane[i]).Color;
        EndUpdate(False);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if csDesigning in ComponentState then
    inherited
  else
    Message.Result:=1; {nothing to do here}
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.WMParentNotify(var Message: TWMParentNotify);
var
  i:Integer;
  b:Boolean;
begin
  inherited;
  if (csDesigning in ComponentState) and (Message.Event=WM_LBUTTONDOWN) then
    begin
      b:=False;
      for i:=0 to Pred(WindowCount) do
        if (Controls[0]<>Pane[i]) and PtInRect(Pane[i].BoundsRect, Point(Message.XPos, Message.YPos)) then
          begin
            Pane[i].SendToBack;
            b:=True;
            break;
          end;
        if not b then exit;

      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message do
    if CursorWnd = Handle then
      case Integer(HitTest) of
        HTCLIENT:
          begin
            if csDesigning in ComponentState then
              Windows.SetCursor(Screen.Cursors[Cursor])
            else
              inherited;
          end;
        HTERROR:
          inherited;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.WndProc(var Message: TMessage);
var
  i: integer;
begin
  if csDesigning in ComponentState then
    case Message.Msg of
        WM_LBUTTONDOWN,WM_LBUTTONUP,WM_MOUSEMOVE:
          if ActiveSplitter=-1 then
            begin
              i:=MouseOverSlider(TWMMouse(Message).XPos,TWMMouse(Message).YPos);
              if i>-1 then
                Dispatch(Message)
              else
                begin
                  if Cursor<>crDefault then Cursor:=crDefault;{}
                  inherited WndProc(Message);
                end;
            end
          else
            Dispatch(Message);
      else
        inherited WndProc(Message);
    end
  else
    inherited WndProc(Message);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustomSplitControl.AdjustWindowBounds;
begin
  if (csLoading in ComponentState) then exit;
  if FSplitterMain.Direction=sdVertical then
    begin
      PaneInfo[0].Bounds:=Rect(0,0,FSplitterMain.Bounds.Left,
       Self.Height);
      PaneInfo[1].Bounds:=Rect(FSplitterMain.Bounds.Right,0,
       Self.Width,Self.Height);
    end
  else
    begin
      PaneInfo[0].Bounds:=Rect(0,0,Self.Width,FSplitterMain.Bounds.Top);
      PaneInfo[1].Bounds:=Rect(0,FSplitterMain.Bounds.Bottom,
       Self.Width,Self.Height);
    end;
  UpdatePanes;
end;


{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.AdjustSplitters;
begin
  if (csLoading in ComponentState) then exit;

  with FSplitterMain do
    begin
      NoUpdate:=True;
      if Direction=sdVertical then
        begin
          if Max>Self.Width-Width then Max:=Self.Width-Width;
          if Min>Self.Width-Max-Width then Min:=Self.Width-Max-Width;
          Within:=Rect(Min,0,Self.Width-Max,Self.Height);
          if Position>Self.Width-Max-Width then Position:=Self.Width-Max-Width;
          if Position<Min then Position:=Min;
          Bounds:=Rect(Position,0,Position+Width,Self.Height)
        end
      else
        begin
          if Max>Self.Height-Width then Max:=Self.Height-Width;
          if Min>Self.Height-Max-Width then Min:=Self.Height-Max-Width;
          Within:=Rect(0,Min,Self.Width,Self.Height-Max);
          if Position>Self.Height-Max-Width then Position:=Self.Height-Max-Width;
          if Position<Min then Position:=Min;
          Bounds:=Rect(0,Position,Self.Width,Position+Width);
        end;
      NoUpdate:=False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.DrawWindowEdge(index: integer);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.DrawSplitterInverse(index: integer);
var
  extra: integer;
  P1,P2: TPoint;
  DC: HDC;
begin
  if ActiveSplitter=-1 then exit;
  if index=TWO_SPLITTERS then
    begin
      DrawSplitterInverse(0);
      DrawSplitterInverse(1);
      exit;
    end;
  extra:=FBorderWidth+1;
  with GetSplitter(index) do
    begin
      P1:=ClientToScreen(Bounds.TopLeft);
      P2:=ClientToScreen(Bounds.BottomRight);
      DC:=GetDC(0);
      try
        if Direction=sdVertical then
          BitBlt(DC,P1.x-extra,P1.y,P2.x-P1.x+extra,P2.y-P1.y,0,0,0,DSTINVERT)
        else
          BitBlt(DC,P1.x,P1.y-extra,P2.x-P1.x,P2.y-P1.y+extra,0,0,0,DSTINVERT);
      finally
        ReleaseDC(0,DC);
      end;
    end;
end;


{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.GetChange(Sender: TObject);
begin
  if sender is TLMDPaneInfo then
    UpdatePane(TLMDPaneInfo(Sender).Index)
  else
    begin
      AdjustSplitters;
      AdjustWindowBounds;
      if not (csLoading in ComponentState) then Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSplitControl.GetPane(index:integer):TLMDSplitPane;
begin
  if index<FPaneList.Count then
    result:=TLMDSplitPane(FPaneList[index])
  else
    result:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSplitControl.GetPaneInfo(index:integer):TLMDPaneInfo;
begin
  if index<FPaneInfoList.Count then
    result:=TLMDPaneInfo(FPaneInfoList[index])
  else
    result:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSplitControl.GetSplitter(Index: Integer): TLMDCustomSplitter;
begin
  result:=nil;
  case index of
    0: result:=FSplitterMain;
    1: if Assigned(FSplitter2) then result:=FSplitter2 else result:=nil;
    2: if Assigned(FSplitter3) then result:=FSplitter3 else result:=nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i:=0 to Pred(FPaneList.Count) do Proc(Pane[i]);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSplitControl.GetChildOwner: TComponent;
begin
  result:=self
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.Loaded;
begin
  inherited Loaded;
  if not ((Parent is TLMDSplitPane) and (Align<>alNone)) then
    begin
      AdjustSplitters;
      AdjustWindowBounds;
    end;
  UpdatePaneInfos;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSplitControl.MouseOverSlider(x,y: Integer): Integer;
var
  i: Integer;
  b,bExtra: Boolean;
begin
  b:=False;
  bExtra:=False;
  i:=0;
  repeat
    if PtInRect(LMDExpandRect(GetSplitter(i).Bounds, FBorderWidth), Point(x,y)) then
      if i=0 then
        bExtra:=True
      else
        b:=True;
    i:=i+1;
  until (i>=SplitterCount) or b;

  {two-splitter-movement only with 4windows, 2splitters}
  if (bExtra and b) and not ((WindowCount=4) and (SplitterCount=2)) then
    b:=false;
  if (bExtra and not b) then
    result:=0
  else if (bExtra and b) then
    result:=TWO_SPLITTERS
  else if b then
    result:=i-1
  else
    result:=-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button=mbLeft) and (ActiveSplitter=-1) then
    begin
      i:=MouseOverSlider(x,y);
      if i>-1 then
        begin
          PtMouseDown:=Point(x,y);
          ActiveSplitter:=i;
          DrawSplitterInverse(i);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,Active,Splitters: integer;
begin
  Splitters:=1;
  if ActiveSplitter>-1 then
    begin
      DrawSplitterInverse(ActiveSplitter);
      if ActiveSplitter=TWO_SPLITTERS then
        begin
          Active:=0;
          Splitters:=2;
        end
      else
        Active:=ActiveSplitter;

      for i:=Active to Active+Splitters-1 do
        with GetSplitter(i) do
          begin
            if (Splitters=2) and (i=0) then NoUpdate:=True;
            if Direction=sdVertical then
              Position:=Bounds.Left
            else
              Position:=Bounds.Top;
            if (Splitters=2) and (i=0) then NoUpdate:=False;
          end;
      if Assigned(FOnSplitChange) then
        FOnSplitChange(Self, GetSplitter(Active));
      ActiveSplitter:=-1;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  i,Active,Splitters: integer;
begin
  Splitters:=1;
  if ActiveSplitter=-1 then
    begin
      i:=MouseOverSlider(x,y);
      if i>-1 then
        if i=TWO_SPLITTERS then
          begin
            if ((Cursor<>crHSplit) and (Cursor<>crVSplit) and (Cursor<>crCross)) then
              OldCursor:=Cursor;
            Cursor:=crCross;
          end
        else
          begin
            if ((Cursor<>crHSplit) and (Cursor<>crVSplit) and (Cursor<>crCross)) then
              OldCursor:=Cursor;
            Cursor:=GetSplitCursor(GetSplitter(i).Direction);
          end
      else
        if (Cursor<>OldCursor) then Cursor:=OldCursor
    end
  else
    begin
      if Assigned(FOnSplitChanging) then FOnSplitChanging(Self);

      if ActiveSplitter=TWO_SPLITTERS then
        begin
          Active:=0;
          Splitters:=2;
        end
      else
        Active:=ActiveSplitter;

      DrawSplitterInverse(ActiveSplitter);
      for i:=Active to Active+Splitters-1 do
        with GetSplitter(i) do
          begin
            if Direction=sdVertical then
              begin
                if x<Within.Left+(PtMouseDown.x-Bounds.Left) then
                  x:=Within.Left+(PtMouseDown.x-Bounds.Left)
                else if x>Within.Right-(Bounds.Right-PtMouseDown.x) then
                  x:=Within.Right-(Bounds.Right-PtMouseDown.x);
                OffSetRect(Bounds,x-PtMouseDown.x,0);
              end
            else
              begin
                if y<Within.Top+(PtMouseDown.y-Bounds.Top) then
                  y:=Within.Top+(PtMouseDown.y-Bounds.Top)
                else if y>Within.Bottom-(Bounds.Bottom-PtMouseDown.y) then
                  y:=Within.Bottom-(Bounds.Bottom-PtMouseDown.y);
                OffSetRect(Bounds,0,y-PtMouseDown.y);
              end;
          end;
      DrawSplitterInverse(ActiveSplitter);
      PtMouseDown:=Point(x,y);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.Paint;
var
  temp: TRect;
  i: integer;
begin
  for i:=0 to SplitterCount-1 do
    begin
      Canvas.Pen.Style:=psSolid;
      Canvas.Pen.Color:=GetSplitter(i).Color;
      Canvas.Brush.Style:=bsSolid;
      Canvas.Brush.Color:=GetSplitter(i).Color;
      temp:=GetSplitter(i).Bounds;
      if (temp.Right-temp.Left>0) and
       (temp.Bottom-temp.Top>0) then
        Canvas.FillRect(temp);
    end;
  for i:=0 to WindowCount-1 do
    begin
      temp:=PaneInfo[i].Bounds;
      if (temp.Right-temp.Left>1) and
       (temp.Bottom-temp.Top>1) then
      LMDDrawStdFrame(Canvas,temp,FBorderStyle,0);
      if (csDesigning in ComponentState) then
        if Pane[i]=Controls[0] then
          begin
            Canvas.Brush.Color:=clWhite;
            Canvas.Brush.Style:=bsCross;
            {Canvas.FrameRect(PaneInfo[i].Bounds); }
            Canvas.FrameRect(LMDExpandRect(PaneInfo[i].Bounds, -FBorderWidth+1));
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.ReadState(Reader: TReader);
var
  tmp:TComponent;
begin
  ClearPanes;
  tmp:=Reader.Owner;
  Reader.Owner:=Self;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner:=tmp;
  end;
end;


{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.Resize;
begin
  inherited;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.UpdatePanes;
var
  i:Integer;
  tmp:TRect;
begin
  for i:=0 to Pred(FPaneList.Count) do
    case FBorderStyle of
      lsLoweredSpb, lsRaisedSpb:
        begin
          tmp:=PaneInfo[i].Bounds;
          if FBorderStyle=lsLoweredSpb then
            LMDAdjustRectExt(tmp, 2,2,-1,-1)
          else
            LMDAdjustRectExt(tmp, 1,1,-2,-2);
          Pane[i].BoundsRect:=tmp;
        end;
    else
      Pane[i].BoundsRect:=LMDExpandRect(PaneInfo[i].Bounds, -FBorderWidth);
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomSplitControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Exclude(FComponentStyle, csInheritable);
  
  FSplitterPlace:=ossEven;
  FPaneList:=TList.Create;
  FPaneInfoList:=TList.Create;
  {Standard behaviour, 2 Panes}
  FPaneList.Add(TLMDSplitPane.Create(Self));
  FPaneList.Add(TLMDSplitPane.Create(Self));
  TLMDSplitPane(FPaneList[0]).Parent:=self;
  TLMDSplitPane(FPaneList[1]).Parent:=self;

  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 0, GetChange));
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 1, GetChange));


  FSplitterMain:=TLMDMainSplitter.Create;
  FSplitterMain.OnChange:=GetChange;

  ActiveSplitter:=-1;
  FBorderStyle:=lsLoweredSpb;
  FBorderWidth:=2;

  Height:=100;
  SplitterCount:=1;
  Width:=200;
  WindowCount:=2;

  if csDesigning in ComponentState then
    begin
      AdjustSplitters;
      AdjustWindowBounds;
    end;

  if not Registered then
    begin
      RegisterClass(TLMDSplitPane);
      Registered:=True;
    end;

 TabStop:=False;

 ControlStyle:=ControlStyle+[csDesignInteractive]-[csReplicatable];
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSplitControl.Destroy;
begin
  ClearPanes;
  while FPaneInfoList.Count>0 do
    begin
      TLMDPaneInfo(FPaneInfoList[Pred(FPaneInfoList.Count)]).Free;
      FPaneInfoList.Delete(Pred(FPaneInfoList.Count));
    end;
  FPaneList.Free;
  FPaneInfoList.Free;
  FSplitterMain.OnChange:=nil;
  FSplitterMain.Destroy;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.SwapPanes(first, second:Integer);
var
  i:Integer;
begin
  if (first in [0..FPaneList.Count-1]) and (second in [0..FPaneList.Count]) then
    begin
      FPaneList.ExChange(first, second);
      UpdatePaneInfos;
      For i:=0 to Pred(WindowCount) do TLMDSplitPane(FPaneList[i]).TabOrder:=i;
    end
  else
    exit;
  AdjustSplitters;
  AdjustWindowBounds;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSplitControl.RotatePanes;
var
  i:Integer;
begin
  FPaneList.Move(Pred(WindowCount), 0);
  UpdatePaneInfos;
  For i:=0 to Pred(WindowCount) do TLMDSplitPane(FPaneList[i]).TabOrder:=i;
  Pane[Pred(WindowCount)].SendToBack;

  AdjustSplitters;
  AdjustWindowBounds;
  if csDesigning in ComponentState then Invalidate;
end;

{********************** class TLMD4PaneSplitCtrl ******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMD4PaneSplitCtrl.GetChange(Sender: TObject);
begin
  if FSplitterMain.Direction=sdVertical then
    FSplitter2.Direction:=sdHorizontal
  else
    FSplitter2.Direction:=sdVertical;
  inherited GetChange(Sender);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMD4PaneSplitCtrl.AdjustWindowBounds;
var
  s1,s2: TLMDCustomSplitter;
begin
  if (csLoading in ComponentState) then exit;

  if not assigned(FSplitterMain) then exit;
  if not assigned(FSplitter2) then exit;
  if FSplitterMain.Direction=sdVertical then
    begin
      s1:=TLMDCustomSplitter(FSplitterMain);
      s2:=FSplitter2;
    end
  else
    begin
      s2:=TLMDCustomSplitter(FSplitterMain);
      s1:=FSplitter2;
    end;
  PaneInfo[0].Bounds:=Rect(0,0,s1.Bounds.Left, s2.Bounds.Top);
  PaneInfo[1].Bounds:=Rect(s1.Bounds.Right,0, Self.Width,s2.Bounds.Top);
  PaneInfo[3].Bounds:=Rect(0,s2.Bounds.Bottom, s1.Bounds.Left,Self.Height);
  PaneInfo[2].Bounds:=Rect(s1.Bounds.Right,s2.Bounds.Bottom, Self.Width,Self.Height);
  UpdatePanes;
end;

{------------------------------------------------------------------------------}
procedure TLMD4PaneSplitCtrl.AdjustSplitters;
begin
  if (csLoading in ComponentState) then exit;
  inherited AdjustSplitters;
  if not Assigned(FSplitter2) then exit;
  with FSplitter2 do
    begin
      NoUpdate:=True;
      if Direction=sdVertical then {MainSplitter.Direction=sdHorizontal}
        begin
          if Max>Self.Width-Width then Max:=Self.Width-Width;
          if Min>Self.Width-Max-Width then Min:=Self.Width-Max-Width;
          Within:=Rect(Min,0,Self.Width-Max,Self.Height);
          if Position>Self.Width-Max-Width then Position:=Self.Width-Max-Width;
          if Position<Min then Position:=Min;
          Bounds:=Rect(Position,0,Position+Width,Self.Height)
        end
      else
        begin
          if Max>Self.Height-Width then Max:=Self.Height-Width;
          if Min>Self.Height-Max-Width then Min:=Self.Height-Max-Width;
          Within:=Rect(0,Min,Self.Width,Self.Height-Max);
          if Position>Self.Height-Max-Width then Position:=Self.Height-Max-Width;
          if Position<Min then Position:=Min;
          Bounds:=Rect(0,Position,Self.Width,Position+Width);
        end;
      NoUpdate:=False;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMD4PaneSplitCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPaneList.Add(TLMDSplitPane.Create(Self));
  FPaneList.Add(TLMDSplitPane.Create(Self));
  TLMDSplitPane(FPaneList[2]).Parent:=self;
  TLMDSplitPane(FPaneList[3]).Parent:=self;
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 2, GetChange));
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 3, GetChange));

  FSplitter2:=TLMDCustomSplitter.Create;
  FSplitter2.OnChange:=GetChange;
  FSplitter2.Direction:=sdHorizontal;
  SplitterCount:=2;
  WindowCount:=4;
end;

{------------------------------------------------------------------------------}
destructor TLMD4PaneSplitCtrl.Destroy;
begin
  FSplitter2.OnChange:=nil;
  FSplitter2.Destroy;
  inherited Destroy;
end;

{********************** class TLMD3PaneSplitCtrl ******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMD3PaneSplitCtrl.AdjustWindowBounds;
begin
  if (csLoading in ComponentState) then exit;
  if not assigned(FSplitterMain) then exit;
  if not assigned(FSplitter2) then exit;

  if FSplitterMain.Direction=sdVertical then
    if SplitterPlace=ossEven then
      begin
        PaneInfo[0].Bounds:=Rect(0,0,FSplitterMain.Bounds.Left,Self.Height);
        PaneInfo[1].Bounds:=Rect(FSplitterMain.Bounds.Right,0,Self.Width,FSplitter2.Bounds.Top);
        PaneInfo[2].Bounds:=Rect(FSplitterMain.Bounds.Right,FSplitter2.Bounds.Bottom,
                                 Self.Width,Self.Height);
      end
    else
      begin
        PaneInfo[0].Bounds:=Rect(0,0,FSplitterMain.Bounds.Left, FSplitter2.Bounds.Top);
        PaneInfo[2].Bounds:=Rect(0,FSplitter2.Bounds.Bottom,FSplitterMain.Bounds.Left, Self.Height);
        PaneInfo[1].Bounds:=Rect(FSplitterMain.Bounds.Right,0,Self.Width,Self.Height);
      end
  else
    if SplitterPlace=ossEven then
      begin
        PaneInfo[0].Bounds:=Rect(0,0,Self.Width, FSplitterMain.Bounds.Top);
        PaneInfo[2].Bounds:=Rect(0,FSplitterMain.Bounds.Bottom,FSplitter2.Bounds.Left,
                                 Self.Height);
        PaneInfo[1].Bounds:=Rect(FSplitter2.Bounds.Right,FSplitterMain.Bounds.Bottom,
                                 Self.Width,Self.Height);
      end
    else
      begin
        PaneInfo[0].Bounds:=Rect(0,0,FSplitter2.Bounds.Left, FSplitterMain.Bounds.Top);
        PaneInfo[1].Bounds:=Rect(FSplitter2.Bounds.Right,0,Self.Width, FSplitterMain.Bounds.Top);
        PaneInfo[2].Bounds:=Rect(0,FSplitterMain.Bounds.Bottom, Self.Width,Self.Height);
      end;
   UpdatePanes;
end;

{------------------------------------------------------------------------------}
procedure TLMD3PaneSplitCtrl.AdjustSplitters;
begin
  if (csLoading in ComponentState) then exit;
  inherited AdjustSplitters;
  if not assigned(FSplitter2) then exit;
  with FSplitter2 do
    begin
      NoUpdate:=True;
      if Direction=sdVertical then {MainSplitter.Direction=sdHorizontal}
        begin
          if Max>Self.Width-Width then Max:=Self.Width-Width;
          if Min>Self.Width-Max-Width then Min:=Self.Width-Max-Width;
          if Position>Self.Width-Max-Width then Position:=Self.Width-Max-Width;
          if Position<Min then Position:=Min;
          if FSplitterPlace=ossOdd then
            begin
              Within:=Rect(Min,0,Self.Width-Max,FSplitterMain.Bounds.Top);
              Bounds:=Rect(Position,0,Position+Width,FSplitterMain.Bounds.Top)
            end
          else
            begin
              Within:=Rect(Min,FSplitterMain.Bounds.Bottom,Self.Width-Max,Self.Width);
              Bounds:=Rect(Position,FSplitterMain.Bounds.Bottom,Position+Width,
               Self.Height)
            end;
        end
      else
        begin
          if Max>Self.Height-Width then Max:=Self.Height-Width;
          if Min>Self.Height-Max-Width then Min:=Self.Height-Max-Width;
          if Position>Self.Height-Max-Width then Position:=Self.Height-Max-Width;
          if Position<Min then Position:=Min;
          if FSplitterPlace=ossOdd then
            begin
              Within:=Rect(0,Min,FSplitterMain.Bounds.Left,Self.Height-Max);
              Bounds:=Rect(0,Position,FSplitterMain.Bounds.Left,Position+Width);
            end
          else
            begin
              Within:=Rect(FSplitterMain.Bounds.Right,Min,Self.Width,Self.Height-Max);
              Bounds:=Rect(FSplitterMain.Bounds.Right,Position,
               Self.Width,Position+Width);
            end;
        end;
      NoUpdate:=False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMD3PaneSplitCtrl.GetChange(Sender: TObject);
begin
  if FSplitterMain.Direction=sdVertical then
    FSplitter2.Direction:=sdHorizontal
  else
    FSplitter2.Direction:=sdVertical;
  inherited GetChange(Sender);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMD3PaneSplitCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPaneList.Add(TLMDSplitPane.Create(Self));
  TLMDSplitPane(FPaneList[2]).Parent:=self;
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 2, GetChange));

  FSplitter2:=TLMDCustomSplitter.Create;
  FSplitter2.OnChange:=GetChange;
  FSplitter2.Direction:=sdHorizontal;
  SplitterCount:=2;
  WindowCount:=3
end;

{------------------------------------------------------------------------------}
destructor TLMD3PaneSplitCtrl.Destroy;
begin
  FSplitter2.OnChange:=nil;
  FSplitter2.Destroy;
  inherited Destroy;
end;

{********************** class TLMD4Pane3SplitCtrl *****************************}
{------------------------- Protected ------------------------------------------}
procedure TLMD4Pane3SplitCtrl.GetChange(Sender: TObject);
begin
  if FSplitterMain.Direction=sdVertical then
    begin
      FSplitter2.Direction:=sdHorizontal;
      FSplitter3.Direction:=sdHorizontal
    end
  else
    begin
      FSplitter2.Direction:=sdVertical;
      FSplitter3.Direction:=sdVertical;
    end;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMD4Pane3SplitCtrl.AdjustWindowBounds;
begin
  if (csLoading in ComponentState) then exit;
  if not assigned(FSplitterMain) then exit;
  if not assigned(FSplitter2) then exit;
  if FSplitterMain.Direction=sdVertical then
    begin
      PaneInfo[0].Bounds:=Rect(0,0,FSplitterMain.Bounds.Left,FSplitter2.Bounds.Top);
      PaneInfo[1].Bounds:=Rect(FSplitterMain.Bounds.Right,0,Self.Width, FSplitter3.Bounds.Top);
      PaneInfo[3].Bounds:=Rect(0,FSplitter2.Bounds.Bottom,FSplitterMain.Bounds.Left, Self.Height);
      PaneInfo[2].Bounds:=Rect(FSplitterMain.Bounds.Right,FSplitter3.Bounds.Bottom,
                          Self.Width,Self.Height);
    end
  else
    begin
      PaneInfo[0].Bounds:=Rect(0,0,FSplitter2.Bounds.Left,FSplitterMain.Bounds.Top);
      PaneInfo[1].Bounds:=Rect(FSplitter2.Bounds.Right,0,Self.Width, FSplitterMain.Bounds.Top);
      PaneInfo[3].Bounds:=Rect(0,FSplitterMain.Bounds.Bottom,FSplitter3.Bounds.Left, Self.Height);
      PaneInfo[2].Bounds:=Rect(FSplitter3.Bounds.Right,FSplitterMain.Bounds.Bottom,
                               Self.Width,Self.Height);
    end;
  UpdatePanes;
end;

{------------------------------------------------------------------------------}
procedure TLMD4Pane3SplitCtrl.AdjustSplitters;
var
  i: integer;
begin
  if (csLoading in ComponentState) then exit;
  inherited AdjustSplitters;
  if not assigned(FSplitter2) then exit;
  if not assigned(FSplitter3) then exit;
  for i:=1 to 2 do
    with GetSplitter(i) do
      begin
        NoUpdate:=True;
        if Direction=sdVertical then {MainSplitter.Direction=sdHorizontal}
          begin
            if Max>Self.Width-Width then Max:=Self.Width-Width;
            if Min>Self.Width-Max-Width then Min:=Self.Width-Max-Width;
            if Position>Self.Width-Max-Width then Position:=Self.Width-Max-Width;
            if Position<Min then Position:=Min;
            if i=1 then
              begin
                Within:=Rect(Min,0,Self.Width-Max,FSplitterMain.Bounds.Top);
                Bounds:=Rect(Position,0,Position+Width,FSplitterMain.Bounds.Top)
              end
            else
              begin
                Within:=Rect(Min,FSplitterMain.Bounds.Bottom,Self.Width-Max,Self.Width);
                Bounds:=Rect(Position,FSplitterMain.Bounds.Bottom,Position+Width,
                 Self.Height)
              end;
          end
        else
          begin
            if Max>Self.Height-Width then Max:=Self.Height-Width;
            if Min>Self.Height-Max-Width then Min:=Self.Height-Max-Width;
            if Position>Self.Height-Max-Width then Position:=Self.Height-Max-Width;
            if Position<Min then Position:=Min;
            if i=1 then
              begin
                Within:=Rect(0,Min,FSplitterMain.Bounds.Left,Self.Height-Max);
                Bounds:=Rect(0,Position,FSplitterMain.Bounds.Left,Position+Width);
              end
            else
              begin
                Within:=Rect(FSplitterMain.Bounds.Right,Min,Self.Width,Self.Height-Max);
                Bounds:=Rect(FSplitterMain.Bounds.Right,Position,
                 Self.Width,Position+Width);
              end;
          end;
        NoUpdate:=False;
      end;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMD4Pane3SplitCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPaneList.Add(TLMDSplitPane.Create(Self));
  FPaneList.Add(TLMDSplitPane.Create(Self));
  TLMDSplitPane(FPaneList[2]).Parent:=self;
  TLMDSplitPane(FPaneList[3]).Parent:=self;
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 2, GetChange));
  FPaneInfoList.Add(TLMDPaneInfo.CreateExt(Self, 3, GetChange));


  FSplitter2:=TLMDCustomSplitter.Create;
  FSplitter2.Direction:=sdHorizontal;
  FSplitter3:=TLMDCustomSplitter.Create;
  FSplitter3.Direction:=sdHorizontal;
  FSplitter2.OnChange:=GetChange;
  FSplitter3.OnChange:=GetChange;
  SplitterCount:=3;
  WindowCount:=4;
end;

{------------------------------------------------------------------------------}
destructor TLMD4Pane3SplitCtrl.Destroy;
begin

  FSplitter2.OnChange:=nil;
  FSplitter2.Destroy;
  FSplitter3.OnChange:=nil;
  FSplitter3.Destroy;
  inherited Destroy;
end;

initialization
  Registered:=False;
end.
