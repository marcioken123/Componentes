unit LMDSplt;
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

LMDSplt unit  
--------------

ToDo
----
The implementation of an inverted resize btn is not yet finished

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Consts, Classes, Graphics,  Messages, Controls, Menus, Forms, StdCtrls,
  LMDClass, LMDTypes, LMDGraph, LMDProcs, LMDUtils, LMDBase, LMDScrollBox, LMDIniCtrl,
  LMDCustomBevelPanel;

const
  LMDMAXSPLITPANE:BYTE = 4;
  IDS_SPLITTERSAVE:String='SplitPanel';

type
  TLMDResizeButtonStyle = (rbsNoButton, rbsGripOnly, rbsGripWithArrows,
                           rbsFlatGripOnly, rbsFlatGripWithArrows);

  TLMDSplitterOrientation=(spHorzDown, spHorzUp, spVertRight, spVertLeft, spCross);
  TLMDSplitterPanelEvent = procedure(Sender: TObject; BarIndex:Integer) of object;

  {Ini-Support}
  TLMDSplitterIniSaveOption=(ssOrderVisible, ssPosition, soColor, soFont);
  TLMDSplitterIniSaveOptions=set of TLMDSplitterIniSaveOption;
  TLMDSplitterJump=(sjUpLeft, sjDnRight);

  TLMDSplitterPanel=class;

  {--------------------------- TLMDSplitterBarItem ----------------------------}
  TLMDSplitterBarItem = class(TCollectionItem)
  private
    FBorderStyle  : TLMDBorderStyle;
    FMaxAbs       : Integer;
    FMoved,
    FClosed       : Boolean;
    FResizeBtn : TLMDResizeButtonStyle;
    //FResizeBtn,
    FInvResizeBtn,
    FTransparent,
    FHorizontal   : Boolean;
    FLocked       : Boolean;
    FMoving       : Boolean;
    FPosition     : Integer;
    FGhostPosition: Integer;                  {if InstantUpdate is false}
    FPosPercent   : TLMDPercent;
    FSplitterJmp  : TLMDSplitterJump;
    FOldPos,      //needed for jumping back
    FMin,
    FMax          : Integer;
    FBtnColor,
    FColor        : TColor;
    FWidth        : Integer;
    FSplitControl : TLMDSplitterPanel;
    FMouseBtn,
    FSelect       : Boolean;
    FOnChange     : TNotifyEvent;
    FBtnRect      : TRect;
    procedure SetBorderStyle(aValue:TLMDBorderStyle);
    procedure SetInteger(index: Integer; aValue: Integer);
    procedure SetBoolean(index : Integer; aValue : Boolean);
    procedure SetLocked(aValue:Boolean);
    procedure SetPercent(aValue: TLMDPercent);
    procedure SetColor(index: Integer; aValue: TColor);
    procedure SetJumpDir (aValue : TLMDSplitterJump);
    procedure SetResizeBtn(aValue:TLMDResizeButtonStyle);
    procedure DoClick (Sender : TObject);
    // 6.1
    procedure ReadBoolean(Reader:TReader);
    function GetResizeBtn:Boolean;
  protected
    // compatibility with older versions
    procedure DefineProperties(Filer:TFiler);override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure TrimValues(aValue:Boolean);
    //Minimize will "close" the specified pane
    procedure Minimize;
    //Restore will restore the size of a previously closed pane
    procedure Restore;
    property Selected:Boolean read FSelect write FSelect;
    property Horizontal: Boolean read FHorizontal;
    property MouseAboveBtn : Boolean index 5 read FMouseBtn write SetBoolean default false;

    //6.1, new: ResizeButtonStyle
    property ResizeButton : Boolean read GetResizeBtn;
  published
    property OldPosition: Integer read FOldPos write FOldPos;
    property BorderStyle:TLMDBorderStyle read FBorderStyle write SetBorderStyle default lsNone;
    property Position: Integer index 0 read FPosition write SetInteger;
    property PosPercent: TLMDPercent read FPosPercent write SetPercent default 50;
    property Min: Integer index 1 read FMin write SetInteger default 0;
    property Max: Integer index 2 read FMax write SetInteger default 0;
    property Locked: Boolean read FLocked write SetLocked default False;
    property Color: TColor index 0 read FColor write SetColor default clBtnFace;
    property ResizeButtonStyle:TLMDResizeButtonStyle read FResizeBtn write SetResizeBtn default rbsNoButton;
    property ResizeDirection : TLMDSplitterJump read FSplitterJmp write SetJumpDir default sjUpLeft;
    property ResizeColor : TColor index 1 read FBtnColor write SetColor default clBtnFace;
    property Transparent : Boolean index 1 read FTransparent write SetBoolean default false;
    property Width: Integer index 3 read FWidth write SetInteger default 3;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

  {------------------------- TLMDSplitterBarItems -----------------------------}
  TLMDSplitterBarItems = class(TCollection)
  private
    FSplitControl: TLMDSplitterPanel;
    function GetItem(Index: Integer): TLMDSplitterBarItem;
    procedure SetItem(Index: Integer; Value: TLMDSplitterBarItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(SplitControl: TLMDSplitterPanel);
    function Add: TLMDSplitterBarItem;
    property Items[Index: Integer]: TLMDSplitterBarItem read GetItem write SetItem; default;
  end;

  {------------------------- TLMDSplitterBarPane ------------------------------}
  TLMDSplitterPane=class(TLMDScrollBox)
  private
    FPaneIndex:Integer;
    // 5.03
    FParentControl:TLMDSplitterPanel;
    FParentCtlXP:Boolean;
    procedure SetParentControl(aValue:TLMDSplitterPanel);
    procedure SetParentCtlXP(aValue: Boolean);
    // ----
    function GetAlign:TAlign;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMLMDParentCtlXPChanged(var Message: TMessage); message CM_LMDParentCtlXPChanged;
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
    // 5.03
    property ParentControl: TLMDSplitterPanel read FParentControl write SetParentControl;
    // ----
    property PaneIndex: Integer read FPaneIndex write FPaneIndex;
    property CtlXP default false; // compatibility
  published
    property ParentCtlXP:Boolean read FParentCtlXP write SetParentCtlXP default true;
    property Align:TAlign read GetAlign;
    property Height stored false;
    property Left stored False;
    property ParentColor {stored false};
    property TabOrder stored False;
    property Top stored False;
    property Width stored False;
    property ThemeMode default ttmNone;
    property ThemeGlobalMode;
  end;

  {------------------------ TLMDSplitterPanel ---------------------------------}
  TLMDSplitterPanel=class(TLMDCustomBevelPanel)
  private
    FSplitterCount : Integer;{default 1}
    FPanes         : TList;
    FBars          : TLMDSplitterBarItems;

    {value stored due to performance improvement}
    FBevelExtend   : Integer;
    FOrientation   : TLMDSplitterOrientation;
    FHitTest       : TPoint;      {Helps to get the right coordinates when handling
                                   the same called events}
    FActPt,                        {stores the actual point of move}
    FMouseDownPt   : TPoint;       {stores the point where the drag begins}
    FInstantUpdate,                {Bar is updated instantly when being moved}
    FInternal,
    FMoving        : Boolean;      {indicates that a Bar is being moved}
    FMovingBar     : Integer;      {index of Bar being moved}
    FMovable       : Boolean;      {Design Time: Splitters movable or fixed?}
    FOnSplitChange : TLMDSplitterPanelEvent;

    {Ini-Support}
    FIniLink       : TLMDIniCtrl;
    FIniUse        : TLMDIniUse;
    FSection, FKey : String;
    FIniOptions    : TLMDSplitterIniSaveOptions;
    FOnIniReadData,
    FOnIniWriteData:TLMDIniCtrlEvent;
    // 7.01
    FAutoResize: Boolean;
    // ----
    procedure SetIniLink(aValue:TLMDIniCtrl);
    procedure SetAutoResize(const Value: Boolean);
    function SaveKey:Boolean;
    function SaveSection:Boolean;
    {-----}
    function HasBars:Boolean;
    procedure SetBars(aValue: TLMDSplitterBarItems);
    procedure SetOrientation(aValue: TLMDSplitterOrientation);
    function GetBarRect(index:Integer): TRect;
    function GetPane(index:integer): TLMDSplitterPane;
    function GetPaneCount: Integer;
    function GetVisibleBarCount:Integer;
    function GetVisiblePaneCount: Integer;
    function GetVisiblePanes(index: Integer): TLMDSplitterPane;

    procedure ChangeSplitterBounds(aResize:Boolean=True);
    procedure ChangeSplitterOrientation;

    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
  protected
    procedure AlignControls(aControl:TControl;var aRect:TRect);override;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure DoReadData;dynamic;
    procedure DoWriteData;dynamic;
    procedure GetChange(Sender: TObject); override;
    function  GetEmpty:Boolean;override;
    procedure Loaded;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
    procedure Paint;override;
    procedure PaintSplitter;
    procedure ReadState(Reader: TReader); override;
    procedure Resize; override;
    procedure UpdateBar(Index:Integer);
    procedure UpdateBars;
    procedure ValidatePoint(var aPt: TPoint; OldPt: TPoint);
    // 6.0 (RM)
    procedure DoThemeChanged; override;
    // ---
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;

    //4.51 (RM)
    procedure EndUpdate(aValue:Boolean);override;
    //----

    function AddPane(aPane: TLMDSplitterPane):Integer;
    procedure ClearPanes;
    procedure ExChangePanes(first, second:Integer);
    procedure MovePane(oldindex, newindex:Integer);
    procedure RemovePane(aPane: TLMDSplitterPane);
    procedure RotatePanes;

    procedure WriteData;
    procedure ReadData;

    // Internal only
    property Movable:Boolean read FMovable write FMovable;
    property BarRect[index:Integer]: TRect read GetBarRect;
    property Panes[index:Integer]:TLMDSplitterPane read GetPane;
    property PaneCount:Integer read GetPaneCount;
    property VisibleBarCount:Integer read GetVisibleBarCount;
    property VisiblePaneCount: Integer read GetVisiblePaneCount;
    property VisiblePanes[index: Integer]: TLMDSplitterPane read GetVisiblePanes;
    property CtlXP default false;  // compatibility
  published
    property About;
    property BackFX;
    property InstantUpdate: Boolean read FInstantUpdate write FInstantUpdate default false;
    property Bevel;
    property Bars: TLMDSplitterBarItems read FBars write SetBars stored HasBars;
    property Orientation: TLMDSplitterOrientation read FOrientation write SetOrientation default spVertRight;
    property Transparent;

    property AutoResizePanes:Boolean read FAutoResize write SetAutoResize default true;

    {Ini-Support}
    property IniLink:TLMDIniCtrl read FIniLink write SetIniLink;
    property IniUse:TLMDIniUse read FIniUse write FIniUse default ioNone; {not active by default}
    property IniSaveOptions:TLMDSplitterIniSaveOptions read FIniOptions write FIniOptions default [ssPosition, ssOrderVisible];
    property Section:String read FSection write FSection stored SaveSection;
    property IniKey:String read FKey write FKey stored SaveKey;

    property Align;
    property Cursor; //stored false;
    property DragMode;
    property DragCursor;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property TabOrder;
    property TabStop;

    property ParentCtl3D;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;

    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSplitChange: TLMDSplitterPanelEvent read FOnSplitChange write FOnSplitChange;
    property OnResize;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    property ThemeMode default ttmNone;
    property ThemeGlobalMode;    
    //new ini-support
    property OnIniReadData:TLMDIniCtrlEvent read FOnIniReadData write FOnIniReadData;
    property OnIniWriteData:TLMDIniCtrlEvent read FOnIniWriteData write FOnIniWriteData;

    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
  end;

implementation

uses
  Types, SysUtils,
  LMDGraphUtils, LMDStrings;

var
  Registered:Boolean;

{*********************** TLMDSplitterBarItem **********************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDSplitterBarItem.SetBorderStyle(aValue:TLMDBorderStyle);
begin
  if aValue<>FBorderStyle then
    begin
      FBorderStyle:=aValue;
      Changed(True);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetInteger(index: Integer; aValue: Integer);
begin
  case Index of
    0:if aValue<>FPosition then
        begin
           FPosition:=aValue;
           TrimValues(false);
           if Assigned(FOnChange) then FOnChange(self);
           Changed(True);
           exit;
        end;
    1:if (aValue<>FMin) then FMin:=aValue else exit;
    2:if (aValue<>FMax) then FMax:=aValue else exit;
    3:if aValue<>FWidth then FWidth:=aValue else exit;
  end;
  TrimValues(false);
  Changed(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetBoolean(index : Integer; aValue : Boolean);
begin
  case index of
    1 : if aValue <> FTransparent then
          begin
            FTransparent := aValue;
            if Assigned(FOnChange) then FOnChange(self);
            Changed(True);
          end;
    {2 : if aValue <> FResizeBtn then
          begin
            FResizeBtn := aValue;
            Changed(True);
          end;}
    5 : if aValue <> FMouseBtn then
          begin
            FMouseBtn := aValue;
            Changed(True);
          end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetPercent(aValue: TLMDPercent);
begin
  if aValue<>FPosPercent then
     begin
       FPosPercent:=aValue;
       TrimValues(True);
       if Assigned(FOnChange) then FOnChange(self);
       Changed(True);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetColor(index : Integer; aValue: TColor);
begin
  case index of
    0 : if aValue<>FColor then
          begin
            FColor:=aValue;
            Changed(False);
          end;
    1 : if aValue <> FBtnColor then
          begin
            FBtnColor := aValue;
            Changed(true);
          end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetJumpDir (aValue : TLMDSplitterJump);
begin
  if aValue <> FSplitterJmp then
    begin
      FSplitterJmp := aValue;
      Changed(True);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetResizeBtn(aValue:TLMDResizeButtonStyle);
begin
     if FResizeBtn <> aValue then
      begin
         FResizeBtn := aValue;
         Changed(True);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.ReadBoolean(Reader:TReader);
begin
  if Reader.ReadBoolean then
    FResizeBtn:=rbsFlatGripWithArrows;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterBarItem.GetResizeBtn:Boolean;
begin
  result:=FResizeBtn<>rbsNoButton;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.DoClick (Sender : TObject);
var
  i : Integer;
begin
  if FOldPos = -1 then
    begin
      i := FPosition;
      if FSplitterJmp = sjUpLeft then
        PosPercent := 0
      else
        PosPercent := 100;
      FOldPos := i;
    end
  else
    begin
      Position := FOldPos;
      FOldPos := -1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.SetLocked(aValue: Boolean);
begin
  if aValue<>FLocked then
    begin
      FLocked:=aValue;
      Changed(False);
    end;
end;

{---------------------- Protected ---------------------------------------------}
procedure TLMDSplitterBarItem.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineProperty ('ResizeButton', ReadBoolean, nil, false);
end;

{---------------------- Public ------------------------------------------------}
constructor TLMDSplitterBarItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FResizeBtn := rbsNoButton;
  FPosition:=-1;
  FMin:=0;
  FMax:=0;
  FPosPercent:=50;
  FTransparent := false;
  FColor:=clBtnFace;
  FWidth:=3;
  FLocked:=False;
  FMoving:=False;
  FBorderStyle:=lsNone;
//  FResizeBtn := false;
  FSplitterJmp := sjUpLeft;
  FOldPos := -1;
  FBtnRect := Rect (0,0,0,0);
  FBtnColor := clBtnFace;
  FMouseBtn := false;
  FMoved := false;
  FClosed := false;
  FSplitControl:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDSplitterBarItem.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.Assign(Source: TPersistent);
begin
  if Source=Self then exit;
  if Source is TLMDSplitterBarItem then
    begin
      FPosition:=TLMDSplitterBarItem(Source).Position;
      FMin:=TLMDSplitterBarItem(Source).Min;
      FMax:=TLMDSplitterBarItem(Source).Max;
      FPosPercent:=TLMDSplitterBarItem(Source).PosPercent;
      FColor:=TLMDSplitterBarItem(Source).Color;
      FWidth:=TLMDSplitterBarItem(Source).Width;
      FMaxAbs:=TLMDSplitterBarItem(Source).FMaxAbs;
      FHorizontal:=TLMDSplitterBarItem(Source).FHorizontal;
      FLocked:=TLMDSplitterBarItem(Source).FLocked;
      FSplitControl:=TLMDSplitterBarItem(Source).FSplitControl;
      FTransparent:=TLMDSplitterBarItem(Source).Transparent;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.TrimValues(aValue:Boolean);
begin
  if FMaxAbs=0 then exit;

  if FMoving then
    begin
      if (FOldPos <> -1) and
         (FPosPercent<>Round((FPosition/FMaxAbs) * 100)) then FOldPos := -1;
      FPosPercent:=Round((FPosition/FMaxAbs) * 100);
      exit;
    end;

  if aValue or (FPosition=-1) then   //Percent value was set
    begin
      FPosition:=(FPosPercent*FMaxAbs) div 100;
      if FPosition<FMin then FPosition:=FMin;
      if FPosition>FMaxAbs-FMax then FPosition:=FMaxAbs-FMax;
    end
  else
    FPosPercent:=Round((FPosition/FMaxAbs) * 100);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.Minimize;
begin
  if FOldPos = -1 then
    DoClick (self);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItem.Restore;
begin
  if FOldPos <> -1 then
    DoClick (self);
end;

{*********************** TLMDSplitterBarItems ************************************}
{-------------------------- Private -------------------------------------------}
function TLMDSplitterBarItems.GetItem(Index: Integer): TLMDSplitterBarItem;
begin
  Result:=TLMDSplitterBarItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItems.SetItem(Index: Integer; Value: TLMDSplitterBarItem);
begin
  inherited SetItem(Index, Value);
end;

{---------------------- Protected ---------------------------------------------}
function TLMDSplitterBarItems.GetOwner: TPersistent;
begin
  Result:=FSplitControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItems.Update(Item: TCollectionItem);
begin
  if Item<>nil then
    FSplitControl.UpdateBar(Item.Index)
  else
    FSplitControl.UpdateBars;
end;

{---------------------- Public ------------------------------------------------}
constructor TLMDSplitterBarItems.Create(SplitControl: TLMDSplitterPanel);
begin
  inherited Create(TLMDSplitterBarItem);
  FSplitControl:=SplitControl;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterBarItems.Add: TLMDSplitterBarItem;
begin
  Result:=TLMDSplitterBarItem(inherited Add);
end;

{*********************** TLMDSplitterPane **************************************}
{---------------------- Private  ----------------------------------------------}
function TLMDSplitterPane.GetAlign:TAlign;
begin
  result:=alNone;
end;

// new 5.03 to allow correct support of inheritation
{------------------------------------------------------------------------------}
procedure TLMDSplitterPane.SetParentControl(aValue:TLMDSplitterPanel);
begin
  if FParentControl<>aValue then
    begin
      if FParentControl<>nil then FParentControl.RemovePane(Self);
      Parent:=aValue;
      if aValue<>nil then aValue.AddPane(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPane.SetParentCtlXP(aValue: Boolean);
begin
  if FParentCtlXP<>aValue then
    begin
      FParentCtlXP := aValue;
      if FParentControl<>nil then Perform(CM_LMDParentCtlXPChanged, 0, 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPane.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if csLoading in ComponentState then exit;
  if Assigned(ParentControl) then
    begin
      if ParentControl.FOrientation=spCross then ParentControl.FOrientation:=spVertRight;
      ParentControl.UpdateBars;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPane.CMLMDParentCtlXPChanged(var Message: TMessage);
begin
  if csLoading in ComponentState then exit;
  if Assigned(ParentControl) and FParentCtlXP then
      ThemeMode := ParentControl.ThemeMode;
end;

{---------------------- Protected ---------------------------------------------}
procedure TLMDSplitterPane.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLMDSplitterPanel then
    ParentControl:=TLMDSplitterPanel(Reader.Parent);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDSplitterPane.Create(AOwner : TComponent);
begin
  inherited Create(aOwner);
  FThemeMode := ttmNone;
  FParentCtlXP:=True;
  FPaneIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDSplitterPane.Destroy;
begin
  {5.07}
  if (ParentControl<>nil) {and not (csDestroying in ParentControl.ComponentState)} then
    ParentControl.RemovePane(Self);
  inherited Destroy;
end;

{*********************** TLMDSplitterPanel ************************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDSplitterPanel.SetBars(aValue: TLMDSplitterBarItems);
begin
  FBars.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.SetOrientation(aValue: TLMDSplitterOrientation);
begin
  if FOrientation<>aValue then
    begin
      if (aValue=spCross) then
        if (PaneCount<4) and not (csLoading in ComponentState) then exit;
      FOrientation:=aValue;
      ChangeSplitterOrientation;
      ChangeSplitterBounds;
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.SetAutoResize(const Value: Boolean);
begin
  FAutoResize := Value;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetPaneCount: Integer;
begin
  result:=FPanes.Count;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetVisibleBarCount:Integer;
var
  tmp:Integer;
begin
  tmp:=VisiblePaneCount;
  if tmp=0 then result:=0 else result:=tmp-1;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetVisiblePaneCount: Integer;
var
  i:Integer;
begin
  result:=0;
  if (csDesigning in ComponentState) then
    result:=PaneCount
  else
    for i:=0 to Pred(PaneCount) do
      if Panes[i].Visible then Inc(result);
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetVisiblePanes(index: integer): TLMDSplitterPane;
var
  i, c: Integer;
begin
  result:=nil;
  if (csDesigning in ComponentState) then
    result:=Panes[index]
  else
    begin
      c:=-1;
      for i:=0 to Pred(PaneCount) do
        if Panes[i].Visible then
          begin
            Inc(c);
            if c=index then
              begin
                result:=Panes[i];
                exit;
              end;
          end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetBarRect(index: Integer): TRect;
begin
  case VisiblePaneCount of
    0,1: SetRectEmpty(result);
    2:case FOrientation of
        spHorzUp, spHorzDown:
          result:=Bounds(FBevelExtend,FBevelExtend+FBars[0].Position,ClientWidth-DblBevelExt,FBars[0].Width);
        spVertRight, spVertLeft:
          result:=Bounds(FBevelExtend+FBars[0].Position,FBevelExtend,FBars[0].Width,ClientHeight-DblBevelExt);
      end;
    3:case FOrientation of
        spHorzUp: {horizontal slider: index 0}
          case index of
            0: result:=Bounds(FBevelExtend,FBevelExtend+FBars[0].Position,ClientWidth-DblBevelExt,FBars[0].Width);
            1: result:=Bounds(FBevelExtend+FBars[1].Position,FBevelExtend,FBars[1].Width,FBars[0].Position);
          end;
        spHorzDown:
          case index of
            0: result:=Bounds(FBevelExtend,FBevelExtend+FBars[0].Position,ClientWidth-DblBevelExt,FBars[0].Width);
            1: result:=Bounds(FBevelExtend+FBars[1].Position,FBevelExtend+FBars[0].Position+FBars[0].Width,
                        FBars[1].Width,ClientHeight-DblBevelExt-FBars[0].Position-FBars[0].Width);
          end;
        spVertRight:
          case index of
            0: result:=Bounds(FBevelExtend+FBars[0].Position,FBevelExtend,FBars[0].Width,ClientHeight-DblBevelExt);
            1: result:=Bounds(FBevelExtend+FBars[0].Position+FBars[0].Width,FBevelExtend+FBars[1].Position,
                              ClientWidth-DblBevelExt-FBars[0].Position-FBars[0].Width,FBars[1].Width);
          end;
        spVertLeft: {vertical slider: index 0}
          case index of
            0: result:=Bounds(FBevelExtend+FBars[0].Position,FBevelExtend,FBars[0].Width,ClientHeight-DblBevelExt);
            1: result:=Bounds(FBevelExtend,FBevelExtend+FBars[1].Position,FBars[0].Position,FBars[1].Width);
          end;
        end;
    4:case FOrientation of
        spHorzUp, spHorzDown: {horizontal slider: index 0}
          case index of
            0: result:=Bounds(FBevelExtend,FBevelExtend+FBars[0].Position,ClientWidth-DblBevelExt,FBars[0].Width);
            1: result:=Bounds(FBevelExtend+FBars[1].Position,FBevelExtend,FBars[1].Width,FBars[0].Position);
            2: result:=Bounds(FBevelExtend+FBars[2].Position,FBevelExtend+FBars[0].Position+FBars[0].Width,
                                       FBars[2].Width,ClientHeight-DblBevelExt-FBars[0].Position-FBars[0].Width);
          end;
        spVertRight, spVertLeft:
          case index of
            0: result:=Bounds(FBevelExtend+FBars[0].Position,FBevelExtend,FBars[0].Width,ClientHeight-DblBevelExt);
            1: result:=Bounds(FBevelExtend,FBevelExtend+FBars[1].Position,FBars[0].Position,FBars[1].Width);
            2: result:=Bounds(FBevelExtend+FBars[0].Position+FBars[0].Width,FBevelExtend+FBars[2].Position,
                        ClientWidth-DblBevelExt-FBars[0].Position-FBars[0].Width,FBars[2].Width);
          end;
        spCross:
          case index of {slider index 0 : vertical}
            0: result:=Bounds(FBevelExtend+FBars[0].Position,FBevelExtend,FBars[0].Width,ClientHeight-DblBevelExt);
            1: result:=Bounds(FBevelExtend,FBevelExtend+FBars[1].Position,ClientWidth-DblBevelExt,FBars[1].Width);
            2: SetRectEmpty(result);
          end;
      end;
    else
      SetRectEmpty(result);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ChangeSplitterBounds(aResize:Boolean=True);
var
  i, w, h: Integer;
begin
  if FInternal or (csLoading in ComponentState) then exit;

  {Cross...!}
  w:=ClientWidth-DblBevelExt;
  h:=ClientHeight-DblBevelExt;
  case VisiblePaneCount of
    0,1:;
    2: case FOrientation of
         spHorzUp, spHorzDown:
           FBars[0].FMaxAbs:=h-FBars[0].Width;
         spVertRight, spVertLeft:
           FBars[0].FMaxAbs:=w-FBars[0].Width;
       end;
    3: case FOrientation of
         spHorzUp, spHorzDown: {horizontal slider: index 0}
           begin
             FBars[0].FMaxAbs:=h-FBars[0].Width;
             FBars[1].FMaxAbs:=w-FBars[1].Width;
           end;
         spVertRight,spVertLeft: {vertical slider: index 0}
           begin
             FBars[0].FMaxAbs:=w-FBars[0].Width;
             FBars[1].FMaxAbs:=h-FBars[1].Width;
           end;
       end;
    4: case FOrientation of
         spHorzUp, spHorzDown: {horizontal slider: index 0}
           begin
             FBars[0].FMaxAbs:=h-FBars[0].Width;
             FBars[1].FMaxAbs:=w-FBars[1].Width;
             FBars[2].FMaxAbs:=w-FBars[2].Width;
           end;
         spVertRight, spVertLeft: {horizontal slider: index 0}
           begin
             FBars[0].FMaxAbs:=w-FBars[0].Width;
             FBars[1].FMaxAbs:=h-FBars[1].Width;
             FBars[2].FMaxAbs:=h-FBars[2].Width;
           end;
        spCross: {vertical slider: index 0}
          begin
            FBars[0].FMaxAbs:=w-FBars[0].Width;
            FBars[1].FMaxAbs:=h-FBars[1].Width;
          end;
        end;
  end;

  for i:=0 to Pred(VisibleBarCount) do
    FBars[i].TrimValues(aResize);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ChangeSplitterOrientation;
begin
  if (csDestroying in ComponentState) or (csLoading in ComponentState) then exit;
  case VisiblePaneCount of
  2: FBars[0].FHorizontal:=FOrientation in [spHorzUp, spHorzDown];
  3: begin
       FBars[0].FHorizontal:=FOrientation in [spHorzUp, spHorzDown];
       FBars[1].FHorizontal:=not FBars[0].Horizontal;
     end;
  4: begin
       FBars[0].FHorizontal:=FOrientation in [spHorzUp, spHorzDown];
       FBars[1].FHorizontal:=not FBars[0].Horizontal;
       if not (FOrientation=spCross) then FBars[2].FHorizontal:=not FBars[0].Horizontal;
     end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.SaveKey:Boolean;
begin
  result:=(FKey<>'') and (FKey<>IDS_SPLITTERSAVE);
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.SaveSection:Boolean;
begin
  result:=(FSection<>'') and (FSection<>IDS_COMMON);
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.HasBars:Boolean;
begin
  result:=FBars.Count>0;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  FHitTest := ScreenToClient(SmallPointToPoint(Message.Pos));
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.WMSize(var Message: TWMSize);
begin
  inherited;
  if CheckOptimized then Paint;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.WMSetCursor(var Message: TWMSetCursor);
var
  i, count: Integer;
  b: Boolean;
begin
  b:=false;
  with Message do
    if (HitTest=HTCLIENT) then
      begin
        count:=0;
        for i:=0 to Pred(VisibleBarCount) do
          if not FBars[i].Locked and PtInRect(BarRect[i], FHitTest) then Inc(count);

        //4.51, changes for removing flicker (RM)
        if count>0 then
          if count=2 then
            begin
              b:=true;
              Windows.SetCursor(Screen.Cursors[crCross])
            end
          else
            for i:=0 to Pred(VisibleBarCount) do
              if not FBars[i].Locked and PtInRect(BarRect[i], FHitTest) then
                begin
                  b:=true;

                  if FBars[i].Horizontal then
                    begin
                      if FBars[i].ResizeButtonStyle<>rbsNoButton then
                        if PtInRect (FBars[i].FBtnRect, FHitTest) then
                          begin
                            Windows.SetCursor(Screen.Cursors[crArrow]);
                            break;
                          end;

                      Windows.SetCursor(Screen.Cursors[crVSplit])
                    end
                  else
                    begin
                      if FBars[i].ResizeButtonStyle<>rbsNoButton then
                        if PtInRect (FBars[i].FBtnRect, FHitTest) then
                          begin
                            Windows.SetCursor(Screen.Cursors[crArrow]);
                            break;
                          end;

                      Windows.SetCursor(Screen.Cursors[crHSplit]);
                    end;
                  break;
                end;
      end;
  if not (csDesigning in ComponentState) then FHitTest:=Point(-1, -1);
  if not b then inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  i: Integer;
begin
  Message.Result := 0;
  if not FMovable then
    begin
      for i:=0 to Pred(VisibleBarCount) do
        FBars[i].Selected:=PtInRect(BarRect[i], FHitTest);
      inherited;
    end
  else
    begin
      if (MK_RBUTTON and Message.Keys=MK_RBUTTON) then
        begin
           for i:=0 to Pred(VisibleBarCount) do
             FBars[i].Selected:=PtInRect(BarRect[i], FHitTest);
          exit;
        end;
      if (MK_LBUTTON and Message.Keys=MK_LBUTTON) then
        begin
          for i:=0 to Pred(VisibleBarCount) do
            if PtInRect(BarRect[i], FHitTest) then
              begin
                Message.Result:=1;
                exit;
              end;
        end;
      if FMoving then Message.Result:=1;
    end;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDSplitterPanel.AlignControls(aControl:TControl;var aRect:TRect);

  procedure AdjustPane(index, x1, y1, x2, y2: integer);
  begin
    VisiblePanes[index].BoundsRect:=Rect(x1,y1,x2,y2);
  end;

begin
  inherited AlignControls(aControl, aRect);
  DisableAlign;
  with aRect do
    case VisiblePaneCount of
      0:;
      1: AdjustPane(0,Left,Top,Right,Bottom);
      2: case FOrientation of
           spHorzUp, spHorzDown:
             begin
               AdjustPane(0,Left,Top,Right,Top+FBars[0].Position);
               AdjustPane(1,Left,Top+FBars[0].Position+FBars[0].Width,Right,Bottom);
             end;
           spVertRight, spVertLeft:
             begin
               AdjustPane(0,Left,Top,Left+FBars[0].Position,Bottom);
               AdjustPane(1,Left+FBars[0].Position+FBars[0].Width,Top,Right,Bottom);
             end;
         end;
      3: case FOrientation of
           spHorzUp: {horizontal slider: index 0}
             begin
               AdjustPane(0,Left,Top,Left+FBars[1].Position,Top+FBars[0].Position);
               AdjustPane(1,Left+FBars[1].Position+FBars[1].Width,Top,Right,Top+FBars[0].Position);
               AdjustPane(2,Left,Top+FBars[0].Position+FBars[0].Width,Right,Bottom);
             end;
           spHorzDown:
             begin
               AdjustPane(0,Left,Top,Right,Top+FBars[0].Position);
               AdjustPane(1,Left+FBars[1].Position+FBars[1].Width,Top+FBars[0].Position+FBars[0].Width,Right,Bottom);
               AdjustPane(2,Left,Top+FBars[0].Position+FBars[0].Width,Left+FBars[1].Position,Bottom);
             end;
           spVertRight: {vertical slider: index 0}
             begin
               AdjustPane(0,Left,Top,Left+FBars[0].Position,Bottom);
               AdjustPane(1,Left+FBars[0].Position+FBars[0].Width,Top,Right,Top+FBars[1].Position);
               AdjustPane(2,Left+FBars[0].Position+FBars[0].Width,Top+FBars[1].Position+FBars[1].Width,Right,Bottom);
             end;
           spVertLeft:
             begin
               AdjustPane(0,Left,Top,Left+FBars[0].Position,Top+FBars[1].Position);
               AdjustPane(1,Left+FBars[0].Position+FBars[0].Width,Top,Right,Bottom);
               AdjustPane(2,Left,Top+FBars[1].Position+FBars[1].Width,Left+FBars[0].Position,Bottom);
             end;
         end;
      4:
       {Pane indices:
         0 1
         3 2         }
        case FOrientation of
        spHorzUp, spHorzDown: {horizontal slider: index 0 upper slider: index 1 lower slider: index 2}
          begin
            AdjustPane(0,Left,Top,Left+FBars[1].Position,Top+FBars[0].Position);
            AdjustPane(1,Left+FBars[1].Position+FBars[1].Width,Top,Right,Top+FBars[0].Position);
            AdjustPane(2,Left+FBars[2].Position+FBars[2].Width,Top+FBars[0].Position+FBars[0].Width,Right,Bottom);
            AdjustPane(3,Left,Top+FBars[0].Position+FBars[0].Width,Left+FBars[2].Position,Bottom);
          end;
        spVertRight, spVertLeft:{vertical slider: index 0
                               left slider: index 1
                               right slider: index 2}
          begin
            AdjustPane(0,Left,Top,Left+FBars[0].Position,Top+FBars[1].Position);
            AdjustPane(1,Left+FBars[0].Position+FBars[0].Width,Top,Right,Top+FBars[2].Position);
            AdjustPane(2,Left+FBars[0].Position+FBars[0].Width,Top+FBars[2].Position+FBars[2].Width,Right,Bottom);
            AdjustPane(3,Left,Top+FBars[1].Position+FBars[1].Width,Left+FBars[0].Position,Bottom);
          end;
        spCross: {vertical slider: index 0}
          begin
            AdjustPane(0,Left,Top,Left+FBars[0].Position,Top+FBars[1].Position);
            AdjustPane(1,Left+FBars[0].Position+FBars[0].Width,Top,Right,Top+FBars[1].Position);
            AdjustPane(2,Left+FBars[0].Position+FBars[0].Width,Top+FBars[1].Position+FBars[1].Width,Right,Bottom);
            AdjustPane(3,Left,Top+FBars[1].Position+FBars[1].Width,Left+FBars[0].Position,Bottom);
          end;
        end;
      end;
  EnableAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.DoReadData;

  procedure DoReadValues(aLink:TLMDIniCtrl);
  var
    tmp:String;
    aList:TStringList;
    i:Integer;
    tmplist:TList;

  begin
     aList:=TStringList.Create;
     with aLink do
       try
          //Panes Order/Visibility
         if ssOrderVisible in FIniOptions then
           begin
             tmp:=ReadString(FSection, FKey+'PaneO', '');
             if tmp<>'' then
               begin
                 LMDAnsiParseToStrList(tmp, IDS_DEFAULTDELIMITER , aList);
                 tmpList:=TList.Create;
                 if aList.Count=FPanes.Count then
                   try
                     for i:=0 to Pred(aList.Count) do
                       tmpList.Add(FPanes[StrToInt(aList[i])]);

                     //removed by JH FPanes.Clear; -> destroy FPanes
                     FPanes.Free;

                     FPanes:=tmpList;
                     tmplist:=nil;
                   finally
                     tmpList.Free;
                   end;
               end;
             tmp:=ReadString(FSection, FKey+'PaneV', '');
             if tmp<>'' then
               begin
                 LMDAnsiParseToStrList(tmp, IDS_DEFAULTDELIMITER , aList);
                 if aList.Count=FPanes.Count then
                   for i:=0 to Pred(aList.Count) do Panes[i].Visible:=(aList[i]='1');
               end;
           end;

          // Position
          if ssPosition in FIniOptions then
            begin
              tmp:=ReadString(FSection, FKey+'Bars', '');
              if tmp<>'' then
                begin
                  LMDAnsiParseToStrList(tmp, IDS_DEFAULTDELIMITER , aList);
                  if aList.Count=FBars.Count then
                    for i:=0 to Pred(aList.Count) do FBars[i].PosPercent:=StrToInt(aList[i]);
                end;
              tmp:=ReadString(FSection, FKey+'BarsOld', '');
              if tmp<>'' then
                begin
                  LMDAnsiParseToStrList(tmp, IDS_DEFAULTDELIMITER , aList);
                  if aList.Count=FBars.Count then
                    for i:=0 to Pred(aList.Count) do FBars[i].OldPosition:=StrToInt(aList[i]);
                end;
            end;

          // Color
          if (soColor in FIniOptions) then
            begin
              tmp:=ReadString(FSection, FKey+'Colors', '');
              if tmp<>'' then
                begin
                  LMDAnsiParseToStrList(tmp, IDS_DEFAULTDELIMITER , aList);
                  if aList.Count=FPanes.Count then
                    for i:=0 to Pred(aList.Count) do Panes[i].Color:=StringToColor(aList[i]);
                end;
            end;

          // Font
          if (soFont in FIniOptions) then
            begin
              tmp:=ReadString(FSection, FKey+'Fonts', '');
              if tmp<>'' then
                begin
                  LMDAnsiParseToStrList(tmp, '|' , aList);
                  if aList.Count=FPanes.Count then
                    for i:=0 to Pred(aList.Count) do
                      LMDAnsiStringToFont(aList[i], Panes[i].Font);
                end;
            end;
        finally
         aList.Free;
       end;
     if Assigned(FOnIniReadData) then FOnIniReadData(self, aLink, FSection);
  end;
begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    DoReadValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      DoReadValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniReadData) then FOnIniReadData(self, nil, FSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.DoWriteData;

  procedure WriteValues(aLink:TLMDIniCtrl);
  var
    i:Integer;
    tmp, tmp2:String;
  begin

    with aLink do
      begin
        //Order of Panes Panes
        tmp:='';tmp2:='';
        if ssOrderVisible in FIniOptions then
          begin
            for i:=0 to Pred(FPanes.Count) do
              begin
                tmp:=tmp+inttostr(Panes[i].PaneIndex);
                tmp2:=tmp2+inttostr(Ord(Panes[i].Visible));;
                if i<Pred(FPanes.Count) then
                  begin
                    tmp:=tmp+IDS_DEFAULTDELIMITER;
                    tmp2:=tmp2+IDS_DEFAULTDELIMITER;
                  end;
              end;
            WriteString(FSection, FKey+'PaneO', tmp);
            WriteString(FSection, FKey+'PaneV', tmp2);
          end
        else
          begin
            DeleteKey(FSection, FKey+'PaneO');
            DeleteKey(FSection, FKey+'PaneV');
          end;

        // Bar Positions
        tmp:='';
        if ssPosition in FIniOptions then
          begin
            for i:=0 to Pred(VisibleBarCount) do
              begin
                tmp:=tmp+inttostr(FBars[i].PosPercent);
                if i<Pred(VisibleBarCount) then tmp:=tmp+IDS_DEFAULTDELIMITER;
              end;
            WriteString(FSection, FKey+'Bars', tmp);
            tmp:='';
            for i:=0 to Pred(VisibleBarCount) do
              begin
                tmp:=tmp+inttostr(FBars[i].OldPosition);
                if i<Pred(VisibleBarCount) then tmp:=tmp+IDS_DEFAULTDELIMITER;
              end;
            WriteString(FSection, FKey+'BarsOld', tmp);
          end
        else
          DeleteKey(FSection, FKey+'Bars');

        // Pane Colors and Fonts
        tmp:='';tmp2:='';
        if (soColor in FIniOptions) or (soFont in FIniOptions) then
          begin
            for i:=0 to Pred(FPanes.Count) do
              begin
                if (soColor in FIniOptions) then tmp:=tmp+ColorToString(Panes[i].Color);
                if (soFont in FIniOptions) then tmp2:=tmp2+LMDAnsiFontToString(Panes[i].Font);
                if i<Pred(FPanes.Count) then
                  begin
                    tmp:=tmp+IDS_DEFAULTDELIMITER;
                    tmp2:=tmp2+'|';  // we need another Delimiter here
                  end;
              end;
            if (soColor in FIniOptions) then WriteString(FSection, FKey+'Colors', tmp) else DeleteKey(FSection, FKey+'Colors');
            if (soFont in FIniOptions) then WriteString(FSection, FKey+'Fonts', tmp2) else DeleteKey(FSection, FKey+'Fonts');
          end
        else
          begin
            DeleteKey(FSection, FKey+'Colors');
            DeleteKey(FSection, FKey+'Fonts');
          end;
      end;

    if Assigned(FOnIniWriteData) then FOnIniWriteData(self, aLink, FSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    WriteValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      WriteValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniWriteData) then FOnIniWriteData(self, nil, FSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.GetChange(Sender: TObject);
begin
  inherited GetChange(Sender);
  FBevelExtend:=BevelExt;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i:=0 to Pred(PaneCount) do Proc(TLMDSplitterPane(FPanes.Items[i]));
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetEmpty;
begin
  result:=(VisiblePaneCount=0) and inherited GetEmpty;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.GetPane(index:integer):TLMDSplitterPane;
begin
  if not Assigned(FPanes) or (index>Pred(FPanes.Count)) or (index<0) then
    result:=nil
  else
    result:=TLMDSplitterPane(FPanes.Items[index]);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.Loaded;
begin
  inherited Loaded;
  FBevelExtend:=Bevel.BevelExtend;

  if not (csDesigning in ComponentState) then
    try
      FInternal:=True;
      DoReadData;
    finally
      FInternal:=False;
    end;
  ChangeSplitterOrientation;
  ChangeSplitterBounds;
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if (Button=mbLeft) then
    begin
      MouseCapture:=True;
      FActPt:=Point(X,Y);
      FMouseDownPt:=FActPt;

      for i:=0 to Pred(VisibleBarCount) do
        if not FBars[i].Locked and PtInRect(BarRect[i], FActPt) then
          begin
            FMoving:=True;
            FMovingBar:=i;
            FBars[i].FMoving:=True;
            if not FInstantUpdate then
              FBars[i].FGhostPosition:=FBars[i].Position;
          end
        else
          FBars[i].Selected:=False;
      if FMoving then PaintSplitter;
    end ;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if (Button=mbLeft) and FMoving then
    begin
      FMoving:=False;
      PaintSplitter;
      for i:=0 to Pred(VisibleBarCount) do
        if FBars[i].FMoving then  // Enhancement by KJS, 30-June-2002
          if (not FInstantUpdate) and (Abs(Bars[i].Position -Bars[i].FGhostPosition) <=5)
             and PtInRect(Bars[i].FBtnRect, Point(X,Y)) then
            begin
              Bars[i].FMoving:=False;
              Bars[i].Selected:=False;
              Bars[i].DoClick(Self);
            end
          else
            begin
              if not FInstantUpdate then
                Bars[i].Position:=Bars[i].FGhostPosition;
              Bars[i].FMoving:=False;
              Bars[i].Selected:=False;
              if PtInRect (Bars[i].FBtnRect, Point(X,Y)) and not Bars[i].FMoved then
                Bars[i].DoClick(self);
              if Assigned(OnSplitChange) then FOnSplitChange(self, i);
              Bars[i].FMoved := false;
            end;
      ReAlign;
      MouseCapture:=False;
      {$IFNDEF LMDCOMP9}
      if csDesigning in Componentstate then
        GetParentForm(self).Designer.Modified;
      {$ENDIF}
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ValidPt, OldPt: TPoint;
  i: Integer;
begin
  if (ssLeft in Shift) and FMoving then
    begin
      OldPt:=FActPt;
      ValidPt:=Point(X,Y);
      ValidatePoint(ValidPt, OldPt);
      FActPt:=ValidPt;

      for i:=0 to Pred(VisibleBarCount) do
        begin
          //Bars[i].FMoving added 00/10/10 JH, otherwise 2 horiz/vert bars will move if one of them is dragged!
          if FInstantUpdate and Bars[i].FMoving then
            begin
              if Bars[i].Horizontal then
                Bars[i].Position:=Bars[i].Position+(FActPt.Y-OldPt.Y)
              else
                Bars[i].Position:=Bars[i].Position+(FActPt.X-OldPt.X);
            end
          else
            begin
              PaintSplitter;
              if Bars[i].Horizontal then
                Bars[i].FGhostPosition:=Bars[i].FGhostPosition+(FActPt.Y-OldPt.Y)
              else
                Bars[i].FGhostPosition:=Bars[i].FGhostPosition+(FActPt.X-OldPt.X);
              PaintSplitter;
            end;
          if Bars[i].FMoving then Bars[i].FMoved := true;
        end;
    end
  else
    if not (csDesigning in ComponentState) then
      for i:=0 to Pred(VisibleBarCount) do
         Bars[i].MouseAboveBtn := PtInRect (Bars[i].FBtnRect, Point(X,Y));

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.MouseExit;
var
  i : Integer;
begin
  for i:=0 to Pred(VisibleBarCount) do
     Bars[i].MouseAboveBtn := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.Notification(aComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(aComponent,Operation);
  if (Operation=opRemove) then
    if aComponent=FIniLink then FIniLink:=nil;
  if (Operation=opInsert) then
    begin
      // attach IniCtrl automatically
      if (FIniUse=ioUseLink) and (aComponent is TLMDIniCtrl) and not Assigned(FIniLink) then
      FIniLink := TLMDIniCtrl(aComponent);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.Paint;
var
  i:Integer;
begin

  if (VisiblePaneCount=0) and GetEmpty then
    begin
      inherited;
      if csDesigning in ComponentState then
        Canvas.TextOut(5,5,'No Panes (use Context Menu to add Panes).');
      exit;
    end;
  Bevel.PaintBevel(Canvas,ClientRect,false);
  for i:=0 to Pred(VisibleBarCount) do
    UpdateBar(i);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.PaintSplitter;
var
  i: Integer;
  P1,P2: TPoint;
  DC: HDC;
begin
  if not FInstantUpdate then  //changed 00/10/10 JH, otherwise DSTINVERT rests will be somewhere on the canvas
    for i:=0 to Pred(VisibleBarCount) do
      with Bars[i] do
        if FMoving then
          begin
            DC:=GetDC(0);
            try
              if Horizontal then
                begin
                  P1:=ClientToScreen(Point(BarRect[i].Left,FBevelExtend+FGhostPosition));
                  P2:=ClientToScreen(Point(BarRect[i].Right,FBevelExtend+FGhostPosition+Bars[i].Width));
                  BitBlt(DC,P1.X,P1.Y,P2.X-P1.X,P2.Y-P1.Y,0,0,0,DSTINVERT);
                end
              else
                begin
                  P1:=ClientToScreen(Point(FBevelExtend+FGhostPosition,BarRect[i].Top));
                  P2:=ClientToScreen(Point(FBevelExtend+FGhostPosition+Bars[i].Width,BarRect[i].Bottom));
                  BitBlt(DC,P1.X,P1.Y,P2.X-P1.X,P2.Y-P1.Y,0,0,0,DSTINVERT);
                end;
            finally
              ReleaseDC(0,DC);
            end;
          end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.Resize;
begin
  inherited Resize;
  if not (csLoading in ComponentState) and not FInternal then
    begin
      ChangeSplitterBounds(FAutoResize);
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.UpdateBar(Index:Integer);
var
  hRect,
  bRect,
  aRect:TRect;
  y, x,
  w: Integer;

  // modified by KJS (30-06-2002)
  procedure paintResizeBtn(invDir : boolean);
  var
    tmpw:Integer;
  begin
    with canvas do
      begin

        Canvas.Brush.Color := FBars[index].ResizeColor;
        FillRect (aRect);

        Canvas.Brush.Style := bsClear;

        Pen.Color := clGray;

        if ((FBars[index].FResizeBtn in [rbsGripWithArrows,rbsGripOnly]) or FBars[index].FMouseBtn) then
          begin
             Rectangle (aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);

             Pen.Color := clWhite;
             MoveTo (aRect.Left + 1, aRect.Bottom - 2);
             LineTo (aRect.Left + 1, aRect.Top + 1);
             LineTo (aRect.Right - 1, aRect.Top + 1);
             Pen.Color := clBlack;
          end;
        if FBars[index].FResizeBtn in [rbsGripWithArrows,rbsGripOnly] then

        //fill the btn background of the mouse is above it
        if FBars[index].FMouseBtn then
          begin
            Brush.Color := clBlue;
            LMDFillPattern(Canvas.Handle,aRect,
                           LMDApplication.GetBrushBitmap(TColor(GetWindowLong(self.Handle,4))));
          end;
        w := 4;
        tmpw:=bRect.Right-bRect.Left;
        if tmpw-4 < w then
          if tmpw>2 then
            w:=tmpw - 2
          else
            w:=1;

        if (FBars[index].Horizontal and (aRect.Bottom-aRect.Top >=6)) or
           (not FBars[index].Horizontal and (aRect.right-aRect.Left >=6)) then

        InflateRect (aRect, -3, -3);

        //paint the btn grip
        if FBars[index].Horizontal then
          begin
            y := aRect.Top + (aRect.Bottom - aRect.Top) div 2;
            x := aRect.Left + w * 2;
            Pen.Color := clBtnShadow;
            while x < aRect.Right - w do
              begin
                Rectangle (x, y, x + 2, y+2);
                Pixels[x, y] := clWhite;
                inc(x, w);
              end;
          end
        else
          begin
            y := aRect.Top + w * 2;
            x := aRect.Left + (aRect.Right - aRect.Left) div 2 - 1; {-1 because of grip dot size}
            Pen.Color := clBtnShadow;
            while y < aRect.Bottom - w do
              begin
                Rectangle (x, y, x + 2, y+2);
                Pixels[x, y] := clWhite;
                inc(y, w);
              end;
          end;
        //paint the direction arrows
        Pen.Color := clBlack;
        Brush.Color := clBlack;

        if FBars[index].fResizeBtn in [rbsGripWithArrows,rbsFlatGripWithArrows] then
          if (FBars[index].Horizontal) and (aRect.Right - aRect.Left >= w) then
            begin
              if (((FBars[index].ResizeDirection = sjUpLeft) and (FBars[index].FOldPos = -1)) or
                 ((FBars[index].ResizeDirection <> sjUpLeft) and (FBars[index].FOldPos <> -1))) and not invDir then
                begin
                  Polygon ([Point(aRect.Left + w div 2, y - w div 2 + 1),
                            Point(aRect.Left, y + 1),
                            Point(aRect.Left + w, y + 1)]);
                  Polygon ([Point(aRect.Right - w div 2, y - w div 2 + 1),
                            Point(aRect.Right, y + 1),
                            Point(aRect.Right - w, y + 1)]);
                end
              else
                begin
                  Polygon ([Point(aRect.Left + w div 2, Y + w div 2),
                            Point(aRect.Left, Y),
                            Point(aRect.Left + w, Y)]);
                  Polygon ([Point(aRect.Right - w div 2, Y + w div 2),
                            Point(aRect.Right, Y),
                            Point(aRect.Right - w, Y)]);
                end;
            end
          else
            if (aRect.Bottom - aRect.Top >= w) then
              begin
                if (((FBars[index].ResizeDirection = sjUpLeft) and (FBars[index].FOldPos = -1)) or
                   ((FBars[index].ResizeDirection <> sjUpLeft) and (FBars[index].FOldPos <> -1))) and not invDir then
                  begin
                    Polygon ([Point(x, aRect.Top + w div 2),
                              Point(x + w div 2, aRect.Top),
                              Point(x + w div 2, aRect.Top + w)]);
                    Polygon ([Point(x, aRect.Bottom - w div 2),
                              Point(x + w div 2, aRect.Bottom),
                              Point(x + w div 2, aRect.Bottom - w)]);
                  end
                else
                  begin
                    Polygon ([Point(x, aRect.Top + w div 2),
                              Point(x - w div 2, aRect.Top),
                              Point(x - w div 2, aRect.Top + w)]);
                    Polygon ([Point(x, aRect.Bottom - w div 2),
                              Point(x - w div 2, aRect.Bottom),
                              Point(x - w div 2, aRect.Bottom - w)]);
                  end;
              end;
      end;
  end;

begin
  if FInternal or (csLoading in ComponentState) then exit;
  with Canvas do
    begin
      aRect:=BarRect[Index];
      LMDDrawStdFrame(Canvas, aRect, FBars[Index].BorderStyle, 0);
      bRect := aRect; //remember width
      Brush.Color:=FBars[Index].Color;

      //that's needed because of LMDDrawStdFrame
      if FBars[Index].BorderStyle in [lsLoweredExt] then
        begin
          inc (aRect.Right);
          inc (aRect.Bottom);
        end;
      if FBars[Index].BorderStyle in [lsRaisedExt] then
        begin
          dec (aRect.Left);
          dec (aRect.Top);
        end;
      if (not FBars[Index].Transparent) or not CheckOptimized then
        FillRect(aRect)
      else
        BackDrawArea (Canvas, aRect, Point (0,0),{Point(aRect.Left, aRect.Top),} 0);
      if (FBars[Index].ResizeButtonStyle<> rbsNoButton) and
         (aRect.Right - aRect.Left > 0) and (aRect.Bottom- aRect.Top > 0) then
        begin
          w := 50;
          if {aRect.Bottom - aRect.Top < FBars[index].Width} FBars[index].Horizontal then
            begin
              aRect.Left := aRect.Left + (aRect.Right - aRect.Left) div 2 - w div 2;
              aRect.Right := aRect.Left + w;
            end
          else
            begin
              aRect.Top := aRect.Top + (aRect.Bottom - aRect.Top) div 2 - w div 2;
              aRect.Bottom := aRect.Top + w;
            end;

          if aRect.Right > BarRect[index].Right then aRect.Right := BarRect[index].Right;
          if aRect.Bottom > BarRect[index].Bottom then aRect.Right := BarRect[index].Bottom;
          if aRect.Left < BarRect[index].Left then aRect.Left := BarRect[index].Left;
          if aRect.Top < BarRect[index].Top then aRect.Top := BarRect[index].Top;

          //the implementation of an inverted resize btn is not yet finished
          FBars[index].FInvResizeBtn := false;

          if FBars[index].FInvResizeBtn then
            begin
              if FBars[index].Horizontal then
                OffsetRect (aRect, -w div 2, 0)
              else
                OffsetRect (aRect, 0, -w div 2);
              hRect := aRect;
            end;

          //paint resizebutton
          FBars[index].FBtnRect := aRect;
          paintResizeBtn (false);

          if FBars[index].FInvResizeBtn then
            begin
              aRect := hRect;
              w := 50;
              if FBars[index].Horizontal then
                OffsetRect (aRect, w, 0)
              else
                OffsetRect (aRect, 0, w);

              paintResizeBtn (true);
            end;

        end
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.UpdateBars;
begin
  if isUpdating or FInternal or ([csLoading, csDestroying] * ComponentState<>[]) then exit;
  ChangeSplitterOrientation;
  ChangeSplitterBounds;
  ReAlign;
  Paint;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ValidatePoint(var aPt: TPoint; OldPt: TPoint);
var
  i, Position: Integer;
begin
  for i:=0 to Pred(VisibleBarCount) do
    if FBars[i].FMoving then
      begin
        if FInstantUpdate then
          Position:=FBars[i].FPosition
        else
          Position:=FBars[i].FGhostPosition;

        if FBars[i].Horizontal then
          begin
            if (OldPt.Y-aPt.Y)>(Position-(FBars[i].Min)) then
              aPt.Y:=OldPt.Y-(Position-(FBars[i].Min));
            if (aPt.Y-OldPt.Y)>(FBars[i].FMaxAbs-FBars[i].Max-Position) then
              aPt.Y:=OldPt.Y+(FBars[i].FMaxAbs-FBars[i].Max-Position);
          end
        else
          begin
            if (OldPt.X-aPt.X)>(Position-(FBars[i].Min)) then
              aPt.X:=OldPt.X-(Position-(FBars[i].Min));
            if (aPt.X-OldPt.X)>(FBars[i].FMaxAbs-FBars[i].Max-Position) then
              aPt.X:=OldPt.X+(FBars[i].FMaxAbs-FBars[i].Max-Position);
          end
      end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDSplitterPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeMode := ttmNone;
  if not Registered then
    begin
      RegisterClass(TLMDSplitterPane);
      Registered:=True;
    end;

  FAutoResize:=True;
  ControlStyle:=[csCaptureMouse, csClickEvents, csOpaque, csDoubleClicks, csReplicatable];

  FOrientation:=spVertRight; { |-}
  FSplitterCount:=0; { | }
  FInternal:=True;

  // Bars
  FBars:=TLMDSplitterBarItems.Create(Self);

  // the standard two splitter pane
  FPanes:=TList.Create;
  FInstantUpdate:=False;
  Height:=100;
  Width:=200;
  TabStop:=False;
  FInternal:=False;
  FMovable:=True;
  FKey:=IDS_SPLITTERSAVE;
  FIniUse:=ioNone;
  FIniOptions:=[ssPosition, ssOrderVisible];
  FSection:=IDS_COMMON;

end;

{------------------------------------------------------------------------------}
destructor TLMDSplitterPanel.Destroy;
begin
  FInternal:=True;
  if not (csDesigning in ComponentState) then DoWriteData;

  //5.07
  ClearPanes;

  FPanes.Free;
  FPanes:=nil;
  FBars.Free;
  FBars:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.EndUpdate(aValue:Boolean);
begin
  inherited EndUpdate(false);
  if aValue then ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.DoThemeChanged;
begin
  inherited;
  NotifyControls (CM_LMDParentCtlXPCHANGED);
end;

{------------------------------------------------------------------------------}
function TLMDSplitterPanel.AddPane(aPane: TLMDSplitterPane):Integer;
begin
  result:=-1;
  if FPanes.Count=LMDMAXSPLITPANE then exit;
  FPanes.Add(APane);
  aPane.FParentControl:=Self;
  aPane.FPaneIndex:=Pred(FPanes.Count);
  result:=aPane.FPaneIndex;

  if FBars.Count<Pred(FPanes.Count) then
    begin
      FBars.Add;
      FBars[Pred(FBars.Count)].FSplitControl:=Self;
    end;

  if not FInternal then
    begin
      ChangeSplitterBounds;
      if not isUpdating then Realign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ClearPanes;
begin
  if not Assigned(FPanes) then exit;
  while FPanes.Count>0 do TLMDSplitterPane(FPanes[Pred(FPanes.Count)]).Free;
  FPanes.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.RemovePane(aPane: TLMDSplitterPane);
var
  i:Integer;
begin
  aPane.FParentControl:=nil;
  FPanes.Remove(aPane);
  for i:=0 to Pred(FPanes.Count) do TLMDSplitterPane(FPanes[i]).PaneIndex:=i;
  if FOrientation=spCross then FOrientation:=spVertRight;
  if FInternal then exit;
  if (FBars.Count>Pred(FPanes.Count)) and (FBars.Count>0) then
    TLMDSplitterBarItem(FBars.Items[Pred(FBars.Count)]).Free
  else
    UpdateBars;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ExChangePanes(first, second:Integer);
var
  i:Integer;
begin
  if PaneCount<2 then exit;
  FPanes.ExChange(first, second);
  for i:=0 to Pred(PaneCount) do TLMDSplitterPane(FPanes[i]).TabOrder:=i;
  if (not isUpdating) then ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.MovePane(oldindex, newindex:Integer);
var
  i:Integer;
begin
  if PaneCount<2 then exit;
  FPanes.Move(oldindex, newindex);
  for i:=0 to Pred(PaneCount) do TLMDSplitterPane(FPanes[i]).TabOrder:=i;
  if (not isUpdating) then ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.RotatePanes;
var
  i:Integer;
begin
  if PaneCount<2 then exit;
  FPanes.Move(Pred(PaneCount), 0);
  for i:=0 to Pred(PaneCount) do TLMDSplitterPane(FPanes[i]).TabOrder:=i;
  if (not isUpdating) then ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.WriteData;
begin
  DoWriteData;
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterPanel.ReadData;
begin
  DoReadData;
end;

end.
