unit LMDObj;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative ()
  # Created:            1996
  # Description:        Outdated button control. Kept for backward compatibility.
  #                     Please do not use this component in new projects.
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:             RM
  # Date:               August 2003
  # Description:        Renamed TFrame class to TLMDAniFrame to avoid
  #                     ambiguity errors in CBuilder
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}


interface

uses
  Windows, SysUtils, Messages, Classes, Forms, ExtCtrls, Graphics,
  Controls, Menus, Dialogs, RTLConsts,
  LMDConst, LMDClass, LMDGraph, LMDBase, LMDBaseGraphicControl, LMDGraphicControl,
  LMDPointList, LMDBaseMeter, LMDSmallBar, LMDCustomPanelFill, LMDGradient,
  LMDCaption, LMDTransparent, LMDSimpleBevel, LMDCustomComponent, LMDShape, LMDObject;

const
  {Own Component Message, used for Clip-Components}
  CM_ClipChanged=CM_BASE+99;

  {res-Strings}
  {TLMDAniImage}
  IDS_NOANICLIP=16549;

  {TLMDClip}
  IDS_NOTMATCH=16552;
  IDS_BMPWIDTH=16556;
  IDS_BMPHEIGHT=16557;
  IDS_CLIPEMPTY=16553;
  IDS_INVALIDVALUE=16554;
  IDS_INVALIDRECT=16555;

Type
  {only for compatibility}
  TLMDBackmode=(tmNone, tmCenter, tmGradient,tmTile, tmStretch);
  TBackMode=TLMDBackMode;

  {TLMDOldBitmapStyle}
  TLMDOldBitmapStyle=(sbNone, sbAutosize, sbCenter, sbStretch, sbTile);

  {Animation Styles}
  TLMDAnStyle=(anOPShowLast, anOPFirst, anOPOldCell, anOPInvisible, anLoop, anLoopInvisible);

  {Types for TLMDFrameList and TLMDAniClip}
  TFramePos=record
    startpic:WORD;
    EndPic:WORD;
  end;

  PFrame=^TLMDAniFrame;
  TLMDAniFrame=record
    Name:String[24];
    IndexNr:Word;
    Pos:TFramePos;
    Unused:WORD;
  end;

  {Animation Event}
  TLMDAnimationEvent=procedure(Sender:TObject;const info:TLMDAniFrame;const pos:Word;
                               var Cancel:Boolean) of object;

  {---------------------- TLMDApp ---------------------------------------------}
  TLMDApp = class(TLMDCustomComponent)
  private
    FTitle:String;
    FHelpFile:TFileName;
    FHintColor:TColor;
    FHintPause:Integer;
    FHintHidePause:Integer;
    FHintShortPause:Integer;
    FShowHint:Boolean;
    FPicture:TPicture;
    FUpdateFormatSettings:Boolean;

    FOnHint:TNotifyEvent;
    FOnShowHint:TShowHintEvent;
    FOnActivate:TNotifyEvent;
    FOnDeactivate:TNotifyEvent;
    FOnException:TExceptionEvent;
    FOnMessage:TMessageEvent;
    FOnHelp:THelpEvent;
    FOnIdle:TIdleEvent;
    FOnRestore:TNotifyEvent;
    FOnMinimize:TNotifyEvent;
    procedure SetIcon(aValue:TIcon);
    function  GetIcon:TIcon;
  protected
    procedure Loaded;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property About;
    property HintColor:TColor read FHintColor write FHintColor default clInfoBk;
    property HintPause:Integer read FHintPause write FHintPause default 500;
    property HintHidePause:Integer read FHintHidePause write FHintHidePause default 2500;
    property HintShortPause:Integer read FHintShortPause write FHintShortPause default 50;
    property Icon:TIcon read GetIcon write SetIcon;
    Property HelpFile:TFilename read FHelpFile write FHelpFile;
    property ShowHint:Boolean read FShowHint write FShowHint default true;
    property Title:String read FTitle write FTitle;
    property UpdateFormatSettings:Boolean read FUpdateFormatSettings write FUpdateFormatSettings default true;

    property OnActivate:TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate:TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnException:TExceptionEvent read FOnException write FOnException;
    property OnHelp:THelpEvent read FOnHelp write FOnHelp;
    property OnIdle:TIdleEvent read FOnIdle write FOnIdle;
    property OnMessage:TMessageEvent read FOnMessage write FOnMessage;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnShowHint:TShowHintEvent read FOnShowHint write FOnShowHint;
  end;

  {------------------------- TLMDScreenCanvas ---------------------------------}
  TLMDScreenCanvas = class(TLMDCustomComponent)
  private
    FBitmap: TBitmap;
    FCanvas: TCanvas;
    FSaveBack: Boolean;
    Painting: Boolean;
    function GetInteger(Index:Integer):Integer;
  protected
    function GetCanvas:TCanvas;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginPaint;
    procedure EndPaint;
    procedure Invalidate;
    {procedure RestoreScreen;}
    procedure SaveScreen;

    property Bitmap: TBitmap read FBitmap;
    property Canvas: TCanvas read GetCanvas;
    property Height: Integer index 0 read GetInteger;
    property Width: Integer index 1 read GetInteger;
  published
    property About;
    property SaveBackground: Boolean read FSaveBack write FSaveBack default false;
  end;

  {---------------------- TLMDFrameList----------------------------------------}
  TLMDFrameList = class(TLMDObject)
  private
    FList:TList;
    function GetCount:Word;
    function GetEmpty:Boolean;
    function GetFrame(index:WORD):PFrame;
    function GetFrameByIndex(indexnr:WORD):PFrame;
    function GetFrameByName(index:String):PFrame;
    procedure DisposeItem(p:PFrame);
    function NewItem(const aFrame:TLMDAniFrame):PFrame;
  public
    constructor Create(Owner:TPersistent=nil);override;
    destructor Destroy;override;
    procedure Add(aValue:TLMDAniFrame);virtual;
    procedure AddValue(name:string;index,start,ende:Word);virtual;
    procedure Assign(Source:TPersistent);override;
    Procedure Clear;virtual;
    function Delete(index:Word):Boolean;virtual;
    function Remove(p:PFrame):Boolean;virtual;
    property Count:WORD read GetCount;
    property Empty:Boolean read GetEmpty;
    property Frame[index:Word]:PFrame read GetFrame;default;
    property FrameByIndex[Indexnr:Word]:PFrame read GetFrameByIndex;
    property FrameByName[index:String]:PFrame read GetFrameByName;
  end;

  {********************** Objects *********************************************}
  {----------------------TLMDAnimation-----------------------------------------}
  TLMDAnimation = class(TLMDObject)
  private
    FIntervall:Word;
    FLoopReverse:Boolean;
    FPlayForward:Boolean;
    FStyle:TLMDAnStyle;
    procedure SetBool(index:integer; aValue:Boolean);
    procedure SetInterval(aValue:Word);
    procedure SetStyle(aValue:TLMDAnStyle);
  public
    constructor Create(Owner:TPersistent=nil);override;
  published
    property Interval:WORD read FIntervall write SetInterval default 200;
    property LoopReverse:Boolean index 0 read FLoopReverse write SetBool default false;
    property PlayForward:Boolean index 1 read FPlayForward write SetBool default True;
    property Style:TLMDAnStyle read FStyle write Setstyle default anOPShowLast;
  end;

  {----------------------TLMDClip----------------------------------------------}
  TLMDClip = class(TLMDObject)
  private
    FBitmap:TBitmap;
    FTempBmp:TBitmap;
    FColumns:WORD;
    FRows:WORD;
    procedure SetBitmap(aValue:TBitmap);
    procedure SetColumns(aValue:WORD);
    procedure SetRows(aValue:WORD);
    function GetCount:Word;
    function GetCellExtend(Index:Integer):WORD;
    procedure DefaultValues;
  protected
    function CheckEmpty:Boolean;virtual;
    procedure GetBitmapChange(Sender:TObject);virtual;
    function GetEmpty:Boolean;virtual;
    function GetLastBitmap:TBitmap;virtual;
  public
    constructor Create(Owner:TPersistent=nil);override;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent); override;
    Procedure FreeClip;
    Procedure FreeLastBitmap;virtual;
    function GetArea(aRect:TRect):TBitmap;virtual;
    function GetCell(Cell:WORD):TBitmap;virtual;
    function GetCellXY(X,Y:WORD):TBitmap;virtual;
    procedure LoadBitmap(const Filename: string);
    procedure LoadFromFile(const Filename: string);virtual;
    procedure LoadFromStream(Stream:TStream);virtual;
    procedure SaveBitmap(const filename: string);
    procedure SaveToFile(const Filename: string);virtual;
    procedure SaveToStream(Stream:TStream);virtual;

    property CellX:WORD index 0 read GetCellExtend;
    property CellY:WORD index 1 read GetCellExtend;
    property Count:WORD read GetCount;
    property Empty:Boolean read GetEmpty;
    property LastBitmap:TBitmap read GetLastBitmap;
  published
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property Columns:WORD read FColumns write SetColumns default 0;
    property Rows:WORD read FRows write SetRows default 0;
  end;

  {----------------------TLMDAniClip-------------------------------------------}
  TLMDAniClip = class(TLMDObject)
  private
    FClip:TLMDClip;
    FFrameList:TLMDFrameList;
    procedure SetClip(aValue:TLMDClip);
    function Getall:TLMDAniFrame;
    function GetCount:WORD;
    function GetFrame(index:WORD):TLMDAniFrame;
    function GetFramePos(index:WORD):TFramePos;
    function GetFrameByIndex(indexnr:WORD):TLMDAniFrame;
    function GetFrameByName(index:String):TLMDAniFrame;
  protected
    function GetEmpty:Boolean;virtual;
    procedure DefineProperties(Filer: TFiler);override;
    procedure ReadData(Reader:TReader);virtual;
    procedure WriteData(Writer:TWriter);virtual;
  public
    constructor Create(Owner:TPersistent=nil);override;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent);override;
    procedure FreeAniClip;virtual;
    function GetCell(Cell:WORD):TBitmap;virtual;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(Stream:TStream);
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(Stream:TStream);

    property Count:WORD read GetCount;
    property Empty:Boolean read GetEmpty;
    property FramePos[index:Word]:TFramePos read GetFramePos;
    property Frame[index:Word]:TLMDAniFrame read GetFrame;default;
    property FrameByIndex[Indexnr:Word]:TLMDAniFrame read GetFrameByIndex;
    property FrameByName[index:String]:TLMDAniFrame read GetFrameByName;
    property List:TLMDFrameList read FFrameList;
  published
    Property Clip:TLMDClip read FClip write SetClip;
  end;

  {----------------------TLMDAniPicClip----------------------------------------}
  TLMDAniPicClip = class(TLMDCustomComponent)
  private
    FAniClip:TLMDAniClip;
    FOnChange:TNotifyEvent;
    procedure SetAniClip(aValue:TLMDAniClip);
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  published
    Property About;
    Property AniClip:TLMDAniClip read FAniClip write SetAniClip;
  end;

  {----------------------TLMDPicClip---------------------------------------}
  TLMDPicClip = class(TLMDCustomComponent)
  private
    FClip:TLMDClip;
    FOnChange:TNotifyEvent;
    procedure SetClip(aValue:TLMDClip);
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function GetCell(Cell:WORD):TBitmap;
    function GetCellXY(X,Y:WORD):TBitmap;
    function GetArea(aRect:TRect):TBitmap;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  published
    Property About;
    Property Clip:TLMDClip read FClip write SetClip;
  end;

  {-------------------TLMDCustomImage------------------------------------------}
  TLMDCustomImage=class(TLMDGraphicControl)
  private
    FStyle:TLMDOldBitmapStyle;
    FTransparent:TLMDTransparent;
    FBackGround:TBitmap;
    FRestoreBack:Boolean;
    procedure SetStyle(aValue:TLMDOldBitmapStyle);
    procedure SetTransparent(aValue:TLMDTransparent);
    procedure TransBlt(srcB:TBitmap; x,y:integer; TCol:TColor);
    function  GetTransMode:Boolean;
    procedure CMClipChanged(var Message:TMessage); message CM_ClipChanged;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure GetControlChange(Sender:TObject);virtual;
    procedure GetTransparentChange(Sender:TObject);virtual;
    procedure Loaded;override;
    procedure PaintImage(aBitmap:TBitmap; aRect:TRect);virtual;
    property  RestoreBack:Boolean read FRestoreback write FRestoreback;
    property  TransMode:Boolean read GetTransMode;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Style:TLMDOldBitmapStyle read FStyle write SetStyle default sbNone;
    property Transparent:TLMDTransparent read FTransparent write SetTransparent;
  end;

  {-------------------TLMDAniImage---------------------------------------------}
  TLMDAniImage = class(TLMDCustomImage)
  private
    FACounter:Word;               {internal counter for animation}
    FADirection:Boolean;          {internal direction flag}
    FAPlaying:Boolean;            {internal flag}
    FActualAniClip:TLMDAniClip;
    FAniClip:TLMDAniClip;
    FAnimation:TLMDAnimation;
    FCell:Word;
    FControl:TLMDAniPicClip;
    FCount:Word;
    FEndPic:Word;                 {setting for control}
    FFlag:Byte;                   {internal flag}
    FFrame:Word;
    FMakeVisible:Boolean;
    FStartPic:Word;               {setting for control}
    FTimer:TTimer;
    {Events}
    FChangeCell,
    FEndEvent,
    FStartEvent:TLMDAnimationEvent;
    procedure SetActiveClip;
    function SetActiveValues(flag:Byte; const aValue):Boolean;
    procedure SetAniClip(aValue:TLMDAniClip);
    procedure SetControl(AControl:TLMDAniPicClip);
    procedure SetCell(aValue:WORD);
    procedure SetFrame(aValue:WORD);
    procedure SetFrameIndex(aValue:Word);
    procedure SetFrameName(aValue:String);
    procedure SetValues;
    function GetControl:TLMDAniPicClip;
    function GetClips:Word;
    function GetFrame(index:WORD):TLMDAniFrame;
    function GetFrameByIndex(indexnr:WORD):TLMDAniFrame;
    function GetFrameByName(index:String):TLMDAniFrame;
    function GetFrames:Word;
    function GetFrameIndex:Word;
    function GetFrameName:String;
    function GetList:TLMDFrameList;
    function GetRealCell(aValue:Word):TBitmap;
    procedure GetTimer(Sender:TObject);
    procedure Move(aValue:LongInt);
    function HasControl:boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure GetChange(Sender:TObject);override;
    procedure GetControlChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    function GetPalette:HPalette;override;
    procedure Loaded;override;
    procedure Notification(AComponent:TComponent;Operation: TOperation); override;
    procedure Paint;Override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    {Play/Stop -Routines}
    procedure Play;
    procedure PlayFrameByName(aName:String; aStyle:TLMDAnStyle);
    procedure PlayFrameByIndex(aIndex:Word; aStyle:TLMDAnStyle);
    procedure Stop;

    {Movement-Routines}
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prev;

    property Clips:Word read GetClips;
    property Empty:Boolean read GetEmpty;
    property Count:Word read GetFrames;
    property Frame[index:Word]:TLMDAniFrame read GetFrame;
    property FrameByIndex[Indexnr:Word]:TLMDAniFrame read GetFrameByIndex;
    property FrameByName[index:String]:TLMDAniFrame read GetFrameByName;
    property List:TLMDFrameList read GetList;
  published
    {ani-specific images}
    property AniClip:TLMDAniClip read FAniClip write SetAniClip;
    property AniControl:TLMDAniPicClip read GetControl write SetControl stored HasControl;
    property Animation:TLMDAnimation read FAnimation write FAnimation;
    property Cell:WORD read FCell write SetCell default 0;
    property FrameNr:Word read FFrame write SetFrame default 0;
    property FrameIndex:WORD read GetFrameIndex write SetFrameIndex stored false;
    property FrameName:String read GetFrameName write SetFrameName stored false;
    property MakeVisible:Boolean read FMakeVisible write FMakeVisible default True;

    property About;
    property Align;
    property Bevel;

    property DragCursor;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    Property ShowHint;
    property Style;
    property Transparent;
    Property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    {Custom Events}
    property OnFrameStart:TLMDAnimationEvent read FStartEvent write FStartEvent;
    property OnFrameEnd:TLMDAnimationEvent read FEndEvent write FEndEvent;
    property OnChangeCell:TLMDAnimationEvent read FChangeCell write FChangeCell;
  end;

  {-------------------------- TLMDImage ---------------------------------------}
  TLMDImage = class(TLMDCustomImage)
  private
    FCell:WORD;
    FClip:TLMDClip;
    FActualClip:TLMDClip;
    FControl:TLMDPicClip;
    procedure SetActiveClip;
    procedure SetCell(aValue:WORD);
    procedure SetClip(aValue:TLMDClip);
    procedure SetControl(AControl:TLMDPicClip);
    function GetClips:Word;
    function GetControl:TLMDPicClip;
    {function HasControl:boolean;}
  protected
    procedure GetChange(Sender:TObject);override;
    procedure GetControlChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    function GetPalette:HPalette;override;
    procedure Loaded;override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure Paint;Override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Empty:Boolean read GetEmpty;
    property Count:Word read GetClips;
  published
    property About;
    property Align;
    property Bevel;
    property Cell:WORD read FCell write SetCell default 0;
    property Clip:TLMDClip read FClip write SetClip;
    property ClipControl:TLMDPicClip read GetControl write Setcontrol;
    property DragCursor;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    Property ShowHint;
    property Style;
    property Transparent;
    Property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag; 
  end;

  TMeterStyle=(msBar, msSmallBar, msBitmap, msGradient, msOwnerDraw);
  TMeterBitmapStyle=(bmTile, bmStretch, bmTileInvert);
  TOnDrawEvent=procedure(Sender:TObject;aBitmap:TBitmap) of object;

  {---------------------- Object TLMDBmpOptions -------------------------------}
  TLMDBmpOptions = class(TLMDObject)
  private
    FBitmap:TBitmap;
    FBitmapStyle:TMeterBitmapStyle;
    Procedure SetBitmap(aValue:TBitmap);
    Procedure SetBitmapStyle(aValue:TMeterBitmapStyle);
  public
    constructor Create(Owner:TPersistent=nil);override;
    destructor Destroy;override;
  published
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property BitmapStyle:TMeterBitmapStyle read FBitmapStyle write SetBitmapStyle default bmStretch;
  end;

  {---------------------- Class TLMDMeter -------------------------------------}
  TLMDMeter = class(TLMDBaseMeter)
  private
    FBarOptions:TBrush;
    FBmpOptions:TLMDBmpOptions;
    FGradientOptions:TLMDGradient;
    FSmBarOptions:TLMDSmallBar;
    FStyle:TMeterstyle;
    FOnDrawEvent:TOnDrawEvent;
    procedure SetBarOptions(aValue:TBrush);
    procedure SetBmpOptions(aValue:TLMDBmpOptions);
    procedure SetGradient(aValue:TLMDGradient);
    procedure SetMeterstyle(aValue:TMeterstyle);
    procedure SetSmBarOptions(aValue:TLMDSmallBar);
  protected
    function CorrectBounds:Boolean;override;
    procedure DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);override;
    function GetPalette:HPalette;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    Property About;
    Property Align;
    property Alignment;
    Property Bevel;
    Property Color;
    Property Caption;
    property Direction;
    property DragCursor;
    property DragMode;
    Property Enabled;
    Property Font;
    property MaxValue;
    Property MinValue;
    Property OptionsBar:TBrush read FBarOptions write SetBarOptions;
    Property OptionsBmp:TLMDBmpOptions read FBmpOptions write SetBmpOptions;
    property OptionsGradient:TLMDGradient read FGradientOptions write SetGradient;
    property OptionsSmallBar:TLMDSmallBar read FSmBarOptions write SetSmBarOptions;
    Property OptionsText;
    property ParentColor;
    Property ParentFont;
    Property ParentShowHint;
    Property PopupMenu;
    property PercentValue;
    Property ShowHint;
    Property StyleMeter:TMeterstyle read FStyle write SetMeterStyle default msSmallBar;
    Property UserValue;
    Property UseFontColor;
    Property Visible;

    Property OnDraw:TOnDrawEvent read FOnDrawEvent write FOnDrawEvent;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  {------------------------- TLMDPanel ----------------------------------------}
  TLMDPanel = class(TLMDCustomPanelFill)
  private
    FBackMode:TLMDBackMode;
    FBitmap:TBitmap;
    FGradient:TLMDGradient;
    Procedure SetBackMode(aValue:TLMDBackMode);
    Procedure SetBitmap(aValue:TBitmap);
    procedure SetGradient(aValue:TLMDGradient);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure GetChange(Sender:TObject);override;
    function GetPalette:HPalette;override;
    Procedure Paint;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    Property About;
    property Align;
    property Alignment;
    Property Background:TLMDBackMode read FBackMode write SetBackmode default tmNone;
    property Bevel;
    Property Bitmap:TBitmap read FBitmap write SetBitmap;
    property Caption;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property FontFX;
    property Gradient:TLMDGradient read FGradient write SetGradient;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
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
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

  {------------------------ TLMDTile ------------------------------------------}
  TLMDTile = class(TLMDGraphicControl)
  private
    FBitmap:TBitmap;
    FGradient:TLMDGradient;
    FTileMode:TLMDBackMode;
    {FTransparent:TLMDTransparent;}
    procedure SetBitmap(aValue:TBitmap);
    procedure SetGradient(aValue:TLMDGradient);
    procedure SetTileMode(aValue:TLMDBackMode);
  protected
    procedure Paint;override;
    procedure GetChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    function GetPalette:HPalette;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    Property About;
    property Align;
    Property Bitmap:TBitmap read FBitmap write SetBitmap;
    Property Bevel;
    property DragCursor;
    property DragMode;
    Property Gradient:TLMDGradient read FGradient write SetGradient;
    property ParentShowHint;
    property PopupMenu;
    Property ShowHint;

    Property TileMode:TLMDBackMode read FTileMode write SetTilemode default tmNone;
    {property TransparentStyle:TLMDTransparent read FTransparent write FTransparent;}
    Property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag; 
  end;

const
  {TLMDAniClip - various constants}
  PCLSignature:String[5]='PCL11';
  ALLPIC:WORD=$FFFF;
  ALLPICS:String[3]='ALL';

  {Signature for TLMDPicClip-Files}
  PCPSignature:String[5]='PCP11';

procedure TransparentBlt(aCanvas:TCanvas; x,y:Integer; bSrc:TBITMAP;
                         cx, cy, cw, ch:Integer; transColor:TColor);

implementation
uses
  consts, lmdutils, LMDGraphUtils, lmdprocs{, lmdpecst};


{------------------------------------------------------------------------------}
procedure TransparentBlt(aCanvas:TCanvas; x,y:Integer; bSrc:TBITMAP;
                         cx, cy, cw, ch:Integer; transColor:TColor);
var BMono, BMonoInvert, BMem:TBITMAP;
    crBack:TCOLORREF;
const
  ROP_DSPDxax = $00E20746;

begin

  if bSrc.Empty then exit;

  BMono:=TBitmap.Create;
  BMonoInvert:=TBitmap.Create;
  BMem:=TBitmap.Create;
  try
    {0. Prepare Bitmaps}

    BMono.Height:=ch;
    BMono.Width:=cw;
    BMono.MonoChrome:=True;

    BMonoInvert.Height:=ch;
    BMonoInvert.Width:=cw;
    BMonoInvert.MonoChrome:=True;

    BMem.Height:=ch;
    BMem.Width:=cw;

    {1. Create monochrome mask}
    crBack:=SetBkColor(BSrc.Canvas.Handle, transColor);
    BitBlt(BMono.Canvas.Handle, 0, 0, cw, ch, BSrc.Canvas.Handle, cx, cy, SRCCOPY);
    SetBkColor(BSrc.Handle, crBack);

    {2. Create inverted mask copy}
    BitBlt(BMonoInvert.Canvas.Handle, 0, 0, cw, ch, BMono.Canvas.Handle, cx, cy, NOTSRCCOPY);

    {3. save SrcBitmap and combine with inverted mask}
    BitBlt(BMem.Canvas.Handle, 0, 0, cw, ch, BSrc.Canvas.Handle, cx,cy, SRCCOPY);
    BitBlt(BMem.Canvas.Handle, 0, 0, cw, ch, BMonoInvert.Canvas.Handle, cx, cy, SRCAND);

    {4. Combine Mask with Destination}
    BitBlt(aCanvas.Handle, x, y, cw, ch, BMono.Canvas.Handle, 0, 0, SRCAND);

    {5. Combine inverted src with destination}
    BitBlt(aCanvas.Handle, x, y, cw, ch, bMem.Canvas.Handle, 0, 0, SRCPAINT);
  finally
    BMono.Free;
    BMonoInvert.Free;
    BMem.Free;
  end;
end;

{*************************** Class TLMDApp ************************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDApp.SetIcon(aValue:TIcon);
begin
  FPicture.Icon.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function  TLMDApp.GetIcon:TIcon;
begin
  result:=FPicture.Icon;
end;

{---------------------------- Protected ---------------------------------------}
Procedure TLMDApp.Loaded;
begin

  inherited loaded;
  if not (csDesigning in ComponentState) then
    with Application do
      begin

        if FileExists(FHelpFile) then
          HelpFile:=FHelpFile
        else
          Helpfile:=ExtractFileName(HelpFile);

        if not FPicture.Icon.Empty then Icon.Assign(FPicture.Icon);

        {Release object}
        FPicture.Destroy;
        FPicture:=nil;

        ShowHint:=FShowHint;
        if FTitle<>'' then Title:=FTitle;
        HintPause:=FHintPause;
        HintColor:=FHintColor;
        HintShortPause:=FHintShortPause;
        HintHidePause:=FHintHidePause;
        UpdateFormatSettings:=FUpdateFormatSettings;

        if Assigned(FOnHint) then OnHint:=FOnHint;
        if Assigned(FOnShowHint) then OnShowHint:=FOnShowHint;
        if Assigned(FOnActivate) then OnActivate:=FOnActivate;
        if Assigned(FOnDeactivate) then OnDeActivate:=FOnDeactivate;
        if Assigned(FOnMessage) then OnMessage:=FOnMessage;
        if Assigned(FOnHelp) then OnHelp:=FOnHelp;
        if Assigned(FOnIdle) then OnIdle:=FOnIdle;
        if Assigned(FOnRestore) then OnRestore:=FOnRestore;
        if Assigned(FOnMinimize) then OnMinimize:=FOnMinimize;

        if Assigned(FOnException) then OnException:=FOnException;
      end;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDApp.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FPicture:=TPicture.Create;
  with Application do
    begin
      FHelpFile:=HelpFile;
      if icon<>nil then FPicture.Icon.Assign(Icon);
      FShowHint:=ShowHint;
      FTitle:='';
      FHintPause:=HintPause;
      FHintColor:=HintColor;
      FHintShortPause:=HintShortPause;
      FHintHidePause:=HintHidePause;
      FUpdateFormatSettings:=UpdateFormatSettings;
    end;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, True) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

{------------------------------------------------------------------------------}
Destructor TLMDApp.Destroy;
begin
  if FPicture<>nil then FPicture.Destroy;
  inherited Destroy;
end;

{************************* Class TLMDScreenCanvas ****************************}
{--------------------------- Private ------------------------------------------}
function TLMDScreenCanvas.GetInteger(Index:Integer):Integer;
begin
  case index of
    0: result:=Screen.Height;
    1: result:=Screen.Width;
  else
    result:=0;
  end;
end;

{--------------------------- Protected ----------------------------------------}
function TLMDScreenCanvas.GetCanvas:TCanvas;
begin
  if not Painting then raise Exception.Create('Error TLMDScreenCanvas:'#13'No BeginPaint call!'#13'Action terminated...');
  Result:=FCanvas;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDScreenCanvas.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FSaveBack:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDScreenCanvas.Destroy;
begin
  FBitmap.Free;
  EndPaint;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenCanvas.BeginPaint;
var
  DC: HDC;
begin
  if Painting then exit;
  FCanvas:=TCanvas.Create;
  DC:=GetDC(0);      {0 will get the screen's DC}
  FCanvas.Handle:=DC;{let the implemented canvas be the screen's DC}
  Painting:=True;
  if SaveBackGround then SaveScreen;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenCanvas.EndPaint;
begin
  if not Painting then exit;
  ReleaseDC(0, FCanvas.Handle);
  FCanvas.Free;
  Painting:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenCanvas.Invalidate;
begin
  InvalidateRect(0,nil, true);
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenCanvas.SaveScreen;
var
  tempCanvas:TCanvas;
  DC:HDC;

begin

  If Painting then
    tempCanvas:=FCanvas
  else
    begin
      tempCanvas:=TCanvas.Create;
      DC:=GetDC(0);         {0 will get the screen's DC}
      tempCanvas.Handle:=DC;{let the implemented canvas be the screen's DC}
    end;

  FBitmap.Free;
  FBitmap:=TBitmap.Create;
  FBitmap.Width:=Screen.Width;
  FBitmap.Height:=Screen.Height;
  BitBlt(FBitmap.Canvas.Handle,0,0,Screen.Width,Screen.Height,tempCanvas.Handle,
    0,0,SRCCOPY);

  if not Painting then
    begin
      ReleaseDC(0, tempCanvas.Handle);
      tempCanvas.Handle:=0;
      tempCanvas.Free;
    end;

end;

{************************ Object TLMDFrameList *******************************}
{------------------------- Private---------------------------------------------}
Function TLMDFrameList.GetCount:Word;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.GetEmpty:Boolean;
begin
  result:=FList.Count=0;
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.GetFrame(index:WORD):PFrame;
begin
  if Getempty or (not (index in [0..FList.Count-1])) then
    raise Exception.Create(SListIndexError)
  else
    result:=FList[index];
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.GetFrameByIndex(indexnr:WORD):PFrame;
var i:Integer;
begin

  result:=nil;
  if not Getempty then
    for i:=0 to FList.Count-1 do
      if indexnr=TLMDAniFrame(FList[i]^).indexnr then
        begin
          result:=FList[i];
          TLMDAniFrame(result^).unused:=i;
          break;
        end;
  if result=nil then
    raise Exception.Create(SListIndexError);
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.GetFrameByName(index:String):PFrame;
var i:Integer;
begin

  result:=nil;
  if not Getempty then
    for i:=0 to FList.Count-1 do
      if index=TFrame(FList[i]^).name then
        begin
          result:=FList[i];
          TLMDaniFrame(result^).unused:=i;
          break;
        end;
  if result=nil then
    raise exception.Create(SListIndexError);
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.NewItem(const aFrame:TLMDAniFrame): PFrame;
begin
  GetMem(Result, sizeof(TLMDAniFrame));
  result^:=aFrame;
end;

{------------------------------------------------------------------------------}
procedure TLMDFrameList.DisposeItem(p:PFrame);
begin
  FreeMem(p, sizeof(TFrame));
end;

{------------------------- Public----------------------------------------------}
constructor TLMDFrameList.Create;
begin
  inherited Create;
  FList:=TList.Create;
end;

{------------------------------------------------------------------------------}
Destructor TLMDFrameList.Destroy;
begin
  Clear;
  FList.free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFrameList.Add(aValue:TLMDAniFrame);
begin
  FList.Add(NewItem(aValue));
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDFrameList.AddValue(name:string; index, start, ende:WORD);
var
  temp:TLMDAniFrame;
begin

  temp.Name := ShortString(name);
  temp.indexnr:=index;
  temp.pos.startpic:=start;
  temp.pos.endpic:=ende;
  FList.Add(NewItem(temp));
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDFrameList.Assign(Source: TPersistent);
var
  anz, i:WORD;

begin
  if Source=self then exit;
  if Source is TLMDFrameList then
    begin
      Clear;
      anz:=TLMDFrameList(Source).Count;
      if anz>0 then
        begin
          FList.Capacity:=anz;
          for i:=0 to anz-1 do
            FList.Add(NewItem(TLMDAniFrame(TLMDFrameList(Source).Frame[i]^)));
        end;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDFrameList.Clear;
var i:integer;
begin

  if FList.Count>0 then
    for i:=0 to FList.count-1 do DisposeItem(FList[i]);
  FList.Clear;
  Change;
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.Delete(index:Word):Boolean;
begin

  result:=true;
  if index<FList.Count then
    begin
      DisposeItem(FList[index]);
      FList.Delete(index);
      FList.Pack;
      Change;
      result:=true;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFrameList.Remove(p:PFrame):Boolean;
var i:Integer;

begin
  result:=false;
  if FList.Count>0 then
    for i:=0 to FList.count-1 do
      if FList[i]=p then
        begin
          DisposeItem(FList[i]);
          FList.Delete(i);
          FList.Pack;
          result:=true;
          Change;
          break;
        end;
end;

{************************ Object TLMDAnimation ********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDAnimation.SetBool(index:integer; aValue:Boolean);
begin
  case index of
    0: if aValue<>FLoopReverse then begin FLoopReverse:=aValue;Change; end;
    1: if aValue<>FPlayForward then begin FPlayForward:=aValue;Change; end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAnimation.SetInterval(aValue:Word);
begin
    if aValue<>FIntervall then
      begin
        FIntervall:=aValue;
        Change;
      end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDAnimation.SetStyle(aValue:TLMDAnStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDAnimation.Create;
begin
  inherited Create;
  FIntervall:=200;
  FStyle:=anOPShowLast;
  FPlayForward:=True;
  FLoopReverse:=False;

end;

{************************ Object TLMDClip *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDClip.SetBitmap(aValue:TBitmap);
begin
  if aValue<>FBitmap then
    begin
      FBitmap.Assign(aValue);
      DefaultValues;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SetColumns(aValue:WORD);
begin

  if empty or (aValue=0) then exit;

  if aValue<>FColumns then
    if (FBitmap.Width mod aValue)=0 then
      begin
        FColumns:=aValue;
        Change;
      end
    else
      raise Exception.CreateFmt(LoadStr(IDS_NotMatch), [aValue, FBitmap.Width, Loadstr(IDS_BMPWIDTH)]);

end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SetRows(aValue:WORD);
begin

  if empty or (aValue=0) then exit;

  if aValue<>FRows then
    if (FBitmap.Height mod aValue)=0 then
      begin
        FRows:=aValue;
        Change;
      end
    else
      raise Exception.CreateFmt(LoadStr(IDS_NotMatch), [aValue, FBitmap.Height, LoadStr(IDS_BMPHeight)]);

end;

{------------------------------------------------------------------------------}
procedure TLMDClip.DefaultValues;
var temp:Byte;
begin
  if empty then temp:=0 else temp:=1;
  FRows:=temp;FColumns:=temp;
  FTempBmp.Free;
  FTempBmp:=TBitmap.Create;
end;

{------------------------------------------------------------------------------}
Function TLMDClip.GetCount;
begin
  result:=FRows*FColumns;
end;

{------------------------------------------------------------------------------}
Function TLMDClip.GetCellExtend(Index:Integer):WORD;
begin

  result:=0;
  case index of
    0:if FColumns<>0 then result:=FBitmap.Width Div FColumns;
    1:if FRows<>0 then result:=FBitmap.Height Div FRows;
  end;

end;

{------------------------ Protected -------------------------------------------}
function TLMDClip.GetEmpty:Boolean;
begin
  result:=FBitmap.Empty;
end;

{------------------------------------------------------------------------------}
function TLMDClip.CheckEmpty:Boolean;
begin
  result:=FBitmap.Empty;
  if result then raise Exception.Create(LoadStr(IDS_CLIPEMPTY));
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.GetBitmapChange(Sender:TObject);
begin
  DefaultValues;
  Change;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDClip.Create;
begin
  inherited Create;
  FBitmap:=TBitmap.Create;
  FTempBmp:=TBitmap.Create;
  FBitmap.OnChange:=GetBitmapChange;  {Version 1.2}
  DefaultValues;
end;

{------------------------------------------------------------------------------}
Destructor TLMDClip.Destroy;
begin
  FBitmap.OnChange:=nil;
  FBitmap.Free;
  FTempBmp.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDClip.GetCell(Cell:WORD):TBitmap;
begin
  result:=nil;
  if Checkempty then exit;
  result:=GetCellXY(Cell MOD FColumns, Cell DIV FColumns);
end;

{------------------------------------------------------------------------------}
function TLMDClip.GetCellXY(X,Y:WORD):TBitmap;
var aWidth, aHeight:WORD;

begin

  result:=nil;
  if Checkempty then exit;
  if not ((X in [0..(FColumns-1)]) and (Y in [0..(FRows-1)])) then
    raise Exception.Create(LoadStr(IDS_INVALIDVALUE))
  else
    begin
      aWidth:=FBitmap.Width Div FColumns;
      aHeight:=FBitmap.Height DIV FRows;

      FTempBmp.Height:=aHeight;
      FTempBmp.Width:=aWidth;

      FTempBmp.Canvas.copyrect(Rect(0,0,aWidth, aHeight), FBitmap.Canvas,
                      Rect(X*aWidth, Y*aHeight, (X+1)*aWidth, (Y+1)*aHeight));
      result:=FTempBmp;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDClip.GetLastBitmap:TBitmap;
begin
  if FTempBmp.Empty then
    result:=nil
  else
    result:=FTempBmp;
end;

{------------------------------------------------------------------------------}
function TLMDClip.GetArea(aRect:TRect):TBitmap;
var destRect:TRect;

begin

  result:=nil;
  if Checkempty then exit;
  if LMDRectInRect(aRect, Rect(0,0, FBitmap.Width, FBitmap.Height)) then
    begin
      destRect:=Rect(0,0, abs(aRect.Right-aRect.Left), abs(aRect.Bottom-aRect.Top));
      FTempBmp.Height:=destrect.bottom;
      FTempBmp.Width:=destrect.Right;
      FTempBmp.Canvas.copyrect(destrect, FBitmap.Canvas,aRect);
    end
  else
    raise Exception.Create(LoadStr(IDS_INVALIDRECT))

end;

{------------------------------------------------------------------------------}
procedure TLMDClip.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDClip then
    begin
      if TLMDClip(source).Empty then
        FreeClip
      else
        begin
          FBitmap.assign(TLMDClip(Source).Bitmap);
          FRows:=TLMDClip(Source).Rows;
          FColumns:=TLMDClip(Source).Columns;
        end;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.FreeClip;
begin
  FBitmap.Free;
  FBitmap:=TBitmap.Create;
  DefaultValues;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.FreeLastBitmap;
begin
  FTempBmp.Free;
  FTempBmp:=TBitmap.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.LoadBitmap(const FileName: string);
begin
   if fileexists(filename) then
     begin
       FreeClip;
       FBitmap.LoadFromfile(FileName);
       DefaultValues;
       Change;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.LoadFromFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SaveBitmap(const FileName: string);
begin
  FBitmap.SaveTofile(FileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SaveToFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.LoadFromStream(Stream:TStream);
var temp:String[5];
    c, r:WORD;
const oldsign:string[5]='PCP10';

begin

   FreeClip;
   with stream do
     begin
       read(temp, sizeof(PCPSignature));
       if (temp<>PCPSignature) and (temp<>oldsign) then
         raise Exception.Create(SFOpenError)
       else
         begin
           if temp=oldsign then position:=256;
           read(r, sizeof(r));
           read(c, sizeof(c));
           FBitmap.LoadFromStream(Stream);
           FRows:=r;
           FColumns:=c;
         end;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SaveToStream(Stream:TStream);

  procedure WriteWord(t:Word);
    begin
      stream.write(t, sizeof(t));
    end;

begin

  with stream do
    begin
      write(PCPSignature, sizeof(PCPSignature));
      writeword(FRows);
      writeword(FColumns);
      FBitmap.SaveToStream(Stream);
    end;

end;


{************************ Object TLMDAniClip **********************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDAniClip.SetClip(aValue:TLMDClip);
begin

  if aValue<>FClip then
    FClip.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetAll:TLMDAniFrame;
begin
  if GetEmpty then
    Exception.Create(SListIndexError)
  else
    with result do
      begin
        Unused:=ALLPIC;
        name:=ALLPICS;
        indexnr:=ALLPIC;
        pos.startpic:=0;
        if FClip.Count>0 then
          pos.endpic:=FClip.Count-1
        else
          pos.endpic:=0;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetCount:WORD;
begin
  result:=FFrameList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetFrame(index:WORD):TLMDAniFrame;
begin
  if (index=ALLPIC) or ((FFrameList.Count=0) and (index=0)) then
    result:=GetAll
  else
    result:=TLMDAniFrame(FFrameList.Frame[index]^);
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetFramePos(index:WORD):TFramePos;
begin
  if (index=ALLPIC) or ((FFrameList.Count=0) and (index=0)) then
    result:=GetAll.Pos
  else
    result:=TLMDAniFrame(FFrameList.Frame[index]^).Pos;
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetFrameByIndex(indexnr:WORD):TLMDAniFrame;
begin
  if IndexNr<>ALLPIC then
    result:=TLMDAniFrame(FFrameList.FrameByIndex[indexnr]^)
  else
    result:=GetAll;
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetFrameByName(index:String):TLMDAniFrame;
begin
  if ShortString(Index) <> ALLPICS then
    result:=TLMDAniFrame(FFrameList.FrameByName[index]^)
  else
    result:=GetAll;
end;

{------------------------- Protected ------------------------------------------}
function TLMDAniClip.GetEmpty:Boolean;
begin
  result:=FClip.Empty {and FFrameList.Empty};
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('FrameList', ReadData, WriteData, List.Count<>0);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.ReadData(Reader:TReader);
var
  tmp:TLMDAniFrame;
  fstring: String;
begin

  FFrameList.Clear;
  Reader.ReadListBegin;
  FFrameList.BeginUpdate;
  while not Reader.EndOfList do
    with reader do
      begin
        fString := ReadString;
        tmp.Name := ShortString(fString);
        tmp.Indexnr := ReadInteger;
        tmp.Pos.StartPic := ReadInteger;
        tmp.Pos.EndPic:=ReadInteger;
        FFrameList.Add(tmp);
      end;
  FFrameList.EndUpdate(False);
  Reader.ReadListEnd;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.WriteData(Writer:TWriter);
var i:WORD;
begin
  Writer.WriteListBegin;
  for i:= 0 to List.Count - 1 do
    with TLMDAniFrame(FFrameList.Frame[i]^) do
      begin
        Writer.WriteString({$IFDEF LMD_NATIVEUNICODE}String{$ENDIF}(name));
        Writer.WriteInteger(indexnr);
        Writer.WriteInteger(pos.startpic);
        Writer.WriteInteger(pos.endpic);
      end;
  Writer.WriteListEnd;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDAniClip.Create;
begin
  inherited Create;
  FFrameList:=TLMDFrameList.Create;
  FClip:=TLMDClip.Create;
  FClip.OnChange:=GetChange; {Version 1.2}
end;

{------------------------------------------------------------------------------}
Destructor TLMDAniClip.Destroy;
begin
  FClip.Free;
  FFrameList.OnChange:=nil;
  FFrameList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDAniClip then
    begin
      if TLMDAniClip(source).Empty then
        FreeAniClip
      else
        begin
          FClip.assign(TLMDAniClip(Source).Clip);
          FFrameList.Assign(TLMDAniClip(source).List);
        end;
      change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.FreeAniClip;
begin
  {remove all data}
  FFrameList.Clear;
  FClip.FreeClip;
end;

{------------------------------------------------------------------------------}
function TLMDAniClip.GetCell(Cell:Word):TBitmap;
begin
  result:=FClip.GetCell(Cell);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.LoadFromFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.SaveToFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
Function GetStringSH(Stream:TStream):String;
var
  temp:Byte;
begin
  stream.read(temp, sizeof(temp));
  SetLength(result, temp);
  stream.read(Pointer(result)^, temp);
end;

{------------------------------------------------------------------------------}
Function GetString(Stream:TStream):String;
var
  temp:Integer;
begin
  stream.read(temp, sizeof(integer));
  SetLength(result, temp);
  stream.read(Pointer(result)^, temp)
end;

{------------------------------------------------------------------------------}
Procedure WriteString(Stream:TStream; w:String);
var
  temp:integer;
begin
  temp:=length(w);
  stream.write(temp, sizeof(integer));
  stream.write(Pointer(w)^, temp);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.LoadFromStream(Stream:TStream);
var
  i:integer;
  temp:String[5];
  tempf:TLMDAniFrame;
  tempw, w:WORD;

const
  oldsign:String[5]='PCL10';

begin

   FreeAniClip;
   with stream do
     begin
       read(temp, sizeof(PCLSignature));
       if (temp<>PCLSignature) and (temp<>oldsign) then
         raise Exception.Create(SFOpenError)
       else
         begin
           if temp=oldsign then position:=256;
           {1. Restore FrameList Data}
           read(tempw, sizeof(tempw));
           if tempw>0 then
             for i:=0 to tempw-1 do
               with tempf do
                 begin
                   if temp='PCL10' then
                     name := ShortString(GetStringSH(Stream))
                   else
                     name := ShortString(GetString(Stream));

                   read(indexnr, sizeof(indexnr));
                   read(pos.startpic, sizeof(pos.startpic));
                   read(pos.endpic, sizeof(pos.endpic));
                   FFrameList.Add(tempf);
                 end;
           {2. Clip-Data}
           read(tempw, sizeof(tempw));
           read(w, sizeof(w));
           FClip.Bitmap.LoadFromStream(Stream);
           FClip.Rows:=tempw;
           FClip.Columns:=w;
         end;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniClip.SaveToStream(Stream:TStream);
var i:integer;

  procedure WriteWord(t:Word);
    begin
      stream.write(t, sizeof(t));
    end;

begin

  with stream do
    begin
      write(PCLSignature, sizeof(PCLSignature));
      {1. Save FrameList Data}
      writeword(FFrameList.Count);
      if FFrameList.Count>0 then
        for i:=0 to FFrameList.Count-1 do
          with TLMDAniFrame(FFrameList.Frame[i]^) do
            begin
              WriteString(stream, {$IFDEF LMDCOMP12}String{$ENDIF}(name));
              writeword(indexnr);
              writeword(pos.startpic);
              writeword(pos.endpic);
            end;
      {2. Clip-Data}
      writeword(FClip.Rows);
      writeword(FClip.Columns);
      FClip.Bitmap.SaveToStream(Stream);
    end;

end;

{************************ Class TLMDAniPicClip ********************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDAniPicClip.SetAniClip(aValue:TLMDAniClip);
begin

  if aValue<>FAniClip then
    begin
      FAniClip.Assign(aValue);
      Change;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDAniPicClip.Change;
var i: Integer;

begin
  If Assigned(FOnChange) then FOnChange(self);
  with owner as TWinControl do
    for i := 0 to ComponentCount-1 do
      if Components[i] is TControl then
        TControl(Components[i]).Perform(CM_CLIPCHANGED, 0, LongInt(self));
end;

{------------------------- Public----------------------------------------------}
constructor TLMDAniPicClip.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FAniClip:=TLMDAniClip.Create;
  FAniClip.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDAniPicClip.Destroy;
begin
  FAniClip.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{function TLMDAniPicClip.GetCell(Frame, Cell:WORD):TBitmap;
begin
  result:=FAniClip.GetCell(Cell);
end;}

{************************ Class TLMDPicClip ***********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDPicClip.SetClip(aValue:TLMDClip);
begin
  if aValue<>FClip then
    begin
      FClip.Assign(aValue);
      Change;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDPicClip.Change;
var i: Integer;

begin
  If assigned(FOnChange) then FOnChange(self);
  with owner as TWinControl do
    for i := 0 to ComponentCount-1 do
      if Components[i] is TControl then
        TControl(Components[i]).Perform(CM_CLIPCHANGED, 0, LongInt(self));
end;

{------------------------- Public----------------------------------------------}
constructor TLMDPicClip.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FClip:=TLMDClip.Create;
  FClip.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDPicClip.Destroy;
begin
  FClip.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDPicClip.GetCell(Cell:WORD):TBitmap;
begin
  result:=FClip.GetCell(Cell);
end;

{------------------------------------------------------------------------------}
function TLMDPicClip.GetCellXY(X,Y:WORD):TBitmap;
begin
  result:=FClip.GetCellXY(X,Y);
end;

{------------------------------------------------------------------------------}
function TLMDPicClip.GetArea(aRect:TRect):TBitmap;
begin
  result:=FClip.GetArea(aRect);
end;

{************************ Class TLMDCustomImage *******************************}
{------------------------- Private---------------------------------------------}
procedure TLMDCustomImage.SetStyle(aValue:TLMDOldBitmapStyle);
begin
  if FStyle<>aValue then
    begin
      FStyle:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.SetTransparent(aValue:TLMDTransparent);
begin
  FTransparent.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomImage.TransBlt(srcB:TBitmap; x,y:integer; TCol:TColor);
var aCanvas:TCanvas;
    back:TBitmap;
    DC:HDC;

begin

   if srcB.Empty then exit;

   back:=TBitmap.Create;
   try
     if FRestoreback or FBackground.Empty then
       begin
         aCanvas:=TCanvas.Create;
         try
           back.Height:=srcb.height;
           back.Width:=srcb.Width;

           {1. Get Handle to Desktop}
           DC:=GetDC(0);
           aCanvas.Handle:=DC;

           {2. Get Background-Bitmap}
           back.Canvas.copyrect(Rect(0,0, srcB.Width, srcB.Height), aCanvas,
                              GetScreenRect(Rect(x,y,x+srcB.Width, y+srcB.Height)));
           aCanvas.Handle:=0;
           ReleaseDC(0,DC);
         finally
           aCanvas.Free;
           if not back.Empty then FBackground.assign(back);
         end;
       end
     else
       back.assign(FBackground);
     FRestoreBack:=false;
     {3. Draw SrcB transparent on Background-Bitmap}
     TransparentBlt(back.Canvas, 0,0, srcB, 0,0, srcB.Width, srcB.Height, TCol);

     {Draw on Control's Canvas}
     Canvas.Draw(x,y,back);

   finally
     back.free;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.WMPaint(var Message: TWMPaint);
begin
  case FTransparent.Mode of
    tpRestoreback, tpRBTranspColor:
      FRestoreBack:=True;
  end;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImage.GetTransMode:Boolean;
begin
  case FTransparent.Mode of
    tpNone, tpTransparentColor:result:=false;
    tpRestoreBack, tpRBTranspColor:result:=true;
  else
    result:=false;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.GetTransparentChange(Sender:TObject);
begin

  If not TransMode then
    begin
      if assigned(FBackground) then FBackGround.Free;
      FBackGround:=TBitmap.Create;
      ControlStyle:=ControlStyle+[csOpaque];
    end
  else
    begin
      ControlStyle:=ControlStyle+[csOpaque];
      ControlStyle:=ControlStyle-[csOpaque];
      FRestoreBack:=True;
    end;
  GetChange(Sender);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustomImage.CMClipChanged(var Message: TMessage);
begin
  GetControlChange(TObject(message.LParam));
  message.result:=0;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.GetControlChange(Sender:TObject);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.Loaded;
begin
  inherited Loaded;
  if GetTransMode then
    ControlStyle:=ControlStyle-[csOpaque]
  else
    ControlStyle:=ControlStyle+[csOpaque]
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImage.PaintImage(aBitmap:TBitmap; aRect:TRect);
var i,j:Integer;
    temp:TBitmap;
begin

  temp:=nil;

  {draw the Bevel}
  if BevelExt>0 then
    aRect:=Bevel.PaintBevel(Canvas, aRect, True);

  if aBitmap=nil then exit;


  self.Canvas.Brush.Style:=bsSolid;

  if (Transparent.Mode=tpTransparentColor) and (FStyle<>sbTile) then
    begin
      temp:=TBitmap.Create;   {drawing directly drawing on Canvas results in Flicker :-(  }
      temp.height:=aBitmap.Height;
      temp.width:=aBitmap.Width;
      temp.Canvas.Brush.Color:=Transparent.Color;
      temp.Canvas.BrushCopy(Rect(0,0,aBitmap.Width, aBitmap.Height), aBitmap,
                            Rect(0,0,aBitmap.Width, aBitmap.Height),
                            aBitmap.TransparentColor);
    end;

  try
    {Drawing the Bitmap}
    case FStyle of
      sbNone, sbAutosize:
        case Transparent.Mode of
          tpTransparentColor:begin self.canvas.draw(aRect.Left, aRect.Top, temp);temp.free;end;
          tpRestoreBack:
              transblt(aBitmap, aRect.Left, aRect.top, aBitmap.TransparentColor );
          tpRBTranspColor:
              transblt(aBitmap, aRect.Left, aRect.top, Transparent.Color );
        else
          self.canvas.draw(aRect.Left, aRect.Top, aBitmap);
        end;
      sbTile:
        try
          temp:=TBitmap.Create;
          temp.Height:=aRect.Bottom-aRect.top;
          temp.Width:=aRect.Right-aRect.Left;
          temp.Canvas.Brush.Color:=Transparent.Color;

          {create offscreen-bitmap}
          for i:=0 to (temp.height div aBitmap.Height{CellY}) do
            for j:=0 to (temp.width div aBitmap.Width{CellX}) do
              if Transparent.Mode<>tpTransparentColor then
                temp.canvas.draw(j*aBitmap.Width{CellX},i*aBitmap.Height{CellY},aBitmap)
              else
                temp.Canvas.BrushCopy(Rect(j*aBitmap.Width, i*aBitmap.Height, j*aBitmap.Width+
                                aBitmap.Width, i*aBitmap.Height+aBitmap.Height), aBitmap,
                                Rect(0,0,aBitmap.Width, aBitmap.Height), aBitmap.TransparentColor);
          {draw the offscreen-bitmap}
          case Transparent.Mode of
            tpRestoreBack: transblt(temp, aRect.left, aRect.Top, aBitmap.TransparentColor);
            tpRBTranspColor: transblt(temp, aRect.left, aRect.Top, Transparent.Color);
          else
            canvas.draw(aRect.Left, aRect.Top, temp);
          end;
        finally
          temp.free;
        end;
      sbStretch:
        case Transparent.Mode of
          tpTransparentColor:begin canvas.StretchDraw(aRect, temp);temp.free;end;
          tpRestoreBack, tpRBTranspColor:
            try
              {transblt can't stretch a bitmap, therefore we have to do
               it before}
              temp:=TBitmap.Create;
              temp.Height:=aRect.Bottom-aRect.top;
              temp.Width:=aRect.Right-aRect.Left;
              temp.canvas.StretchDraw(Rect(0,0,temp.Width, temp.Height), aBitmap);
              if Transparent.Mode=tpRestoreBack then
                transblt(temp, aRect.Left, aRect.Top, aBitmap.TransparentColor)
              else
                transblt(temp, aRect.Left, aRect.Top, Transparent.Color)
            finally
              temp.free;
            end;
        else
          Canvas.StretchDraw(aRect, aBitmap);
        end;
      sbCenter:
          begin
            i:=(Width - aBitmap.Width) div 2;
            j:=(Height - aBitmap.Height) div 2;
            aRect:=Rect(i,j,i+aBitmap.Width,j+aBitmap.Height);
            case Transparent.Mode of
              tpTransparentColor:begin canvas.Stretchdraw(aRect, temp);temp.free;end;
              tpRestoreBack: transblt(aBitmap, i, j, aBitmap.TransparentColor);
              tpRBTranspColor: transblt(aBitmap, i, j, Transparent.Color);
            else
              canvas.Stretchdraw(aRect, aBitmap);
            end;
          end;
    end;{case 1}
  except
    on exception do exit;
  end;

end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FTransparent:=TLMDTransparent.Create;
  FTransparent.OnChange:=GetTransparentChange;
  FBackGround:=TBitmap.Create;
  FRestoreBack:=true;

end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomImage.Destroy;
begin
  FTransparent.OnChange:=nil;
  FTransparent.Free;
  FBackground.Free;
  inherited Destroy;
end;

{************************ Class TLMDAniImage **********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDAniImage.SetActiveClip;
var oldclip:TLMDAniClip;
begin

  oldclip:=FActualAniClip;
  If assigned(FControl) and (not FControl.AniClip.Empty) then
    FActualAniClip:=FControl.AniClip
  else
    FActualAniClip:=FAniClip;

  if not (csLoading in ComponentState) then
    if oldclip<>FActualAniClip then
      SetActiveValues(0, FFrame)
    else
      SetValues;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetValues;
begin

  if FActualAniClip=nil then exit;

  if FActualAniClip.Empty then FFrame:=0;
  if (FFrame+1>FActualAniClip.Count) and (FFrame<>ALLPIC) then {FFrame:=0;}
    if FActualAniClip.Count>0 then FFrame:=0 else FFrame:=ALLPIC;

  FStartPic:=FActualAniClip.FramePos[FFrame].StartPic;
  FEndPic:=FActualAniClip.FramePos[FFrame].EndPic;
  FCount:=FEndPic-FStartPic;
  if FCell>FCount then FCell:=0;

end;

{------------------------------------------------------------------------------}
function TLMDAniImage.SetActiveValues(flag:Byte; const aValue):Boolean;
begin

  result:=false;
  if FActualAniClip=nil then exit;

  case flag of
    0:begin {initialize everything}
        FCell:=0;FFrame:=0;
      end;
    1:;
    2,3: If GetFrames>0 then
         try
           if flag=2 then
             FFrame:=FActualAniClip.FramebyIndex[Word(aValue)].Unused
           else
             FFrame:=FActualAniClip.FramebyName[String(aValue)].Unused;
           FCell:=0;
           result:=true;
         except
           on exception do exit;
         end;
  end;
  SetValues;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetAniClip(AValue:TLMDAniClip);
begin

  if FAniClip<>aValue then
    begin
      FAniClip.Assign(aValue);
      SetActiveClip;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetCell(aValue:Word);
begin
  FCell:=aValue;
  if not FACounter=ALLPIC then GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetControl(AControl:TLMDAniPicClip);
begin
  if AControl<>FControl then
    begin
      FControl:=AControl;
      SetActiveClip;
      GetChange(nil);
      if aControl <> nil then aControl.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetFrame(aValue:Word);
begin
  FFrame:=aValue;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetFrameIndex(aValue:Word);
begin
  {if not (csDesigning in ComponentState) then}
    If SetActiveValues(2, aValue) then GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.SetFrameName(aValue:String);
begin
 {if not (csDesigning in ComponentState) then}
   If SetActiveValues(3, aValue) then GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetControl:TLMDAniPicClip;
begin
  Result := FControl;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetClips:Word;
begin
  result:=0;
  if not FActualAniClip.Empty then result:=FCount+1;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrame(index:WORD):TLMDAniFrame;
begin
  result:=FActualAniClip.Frame[index];
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrameByIndex(indexnr:WORD):TLMDAniFrame;
begin
  result:=FActualAniClip.FrameByIndex[indexnr];
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrameByName(index:String):TLMDAniFrame;
begin
  result:=FActualAniClip.FrameByName[index];
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrames:Word;
begin
  if GetEmpty then result:=0 else result:=FActualAniClip.Count;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrameIndex:Word;
begin
  if Getempty then result:=0 else result:=FActualAniClip.Frame[FFrame].IndexNr;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetFrameName:String;
begin
  if GetEmpty then
    result:=LoadStr(IDS_NOANICLIP)
  else
    result:={$IFDEF LMDCOMP12}String{$ENDIF}(FActualAniClip.Frame[FFrame].Name);
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetList:TLMDFrameList;
begin
  result:=FActualAniClip.List;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetRealCell(aValue:Word):TBitmap;
begin
  result:=FActualAniClip.GetCell(FStartPic+aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.GetTimer(Sender:TObject);
var cancel:Boolean;
begin

  if (not visible and not (csDesigning in ComponentState))
     or (parent=nil) then stop;

  if FADirection then
    begin
      if FACounter=FCount then
        case FAnimation.Style of
          anLoop, anLoopInvisible:
            if FAnimation.LoopReverse then
              begin
                FADirection:=not FADirection;
                FACounter:=FCount;
              end
            else
              FACounter:=0;
          else
            begin
              Stop;exit;
            end;
        end
      else
        Inc(FACounter);
    end
  else
    if FACounter=0 then
      case FAnimation.Style of
        anLoop, anLoopInvisible:
           if FAnimation.LoopReverse then
             begin
               FADirection:=not FADirection;
               FACounter:=0;
             end
           else
             FACounter:=FCount;
        else
          begin
           Stop;exit;
          end;
      end
    else
      Dec(FACounter);

    if assigned(FChangeCell) then
      begin
        cancel:=false;
        FChangeCell(Self, GetFrame(FFrame), FACounter, cancel);
        If Cancel then Stop;
      end;

    PaintImage(GetRealCell(FACounter), GetClientRect);

end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.Move(aValue:Longint);
begin
  if FAPlaying or GetEmpty then exit;
  if aValue in [0..FCount] then
    begin
      FCell:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.HasControl:boolean;
begin
  result := assigned(FControl);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.WMPaint(var Message: TWMPaint);
begin
  case Transparent.Mode of
    tpRestoreback, tpRBTranspColor:
      if fFlag=0 then
        begin
          FFLag:=1;
          RestoreBack:=True;
          Invalidate;
          exit;
        end
      else
        dec(fflag);
  end;
  inherited;
end;

{------------------------------- Protected ------------------------------------}
procedure TLMDAniImage.GetChange(Sender:TObject);
begin

  if FAPlaying then Stop;
  SetValues;

  {if GetEmpty then exit;}
  if not (csReading in ComponentState) then
    if (Style=sbAutosize) and (not FActualAniClip.Empty) then
      SetBounds(Left, Top,
                FActualAniClip.Clip.CellX+(Bevel.BevelExtend*2),
                FActualAniClip.Clip.CellY+(Bevel.BevelExtend*2));
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.GetControlChange(Sender:TObject);
begin
  if sender=FControl then
    begin
      SetActiveClip;
      GetChange(Sender);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetEmpty:Boolean;
begin
  if FActualAniClip=nil then
    result:=true
  else
    result:=FActualAniClip.Empty;
end;

{------------------------------------------------------------------------------}
function TLMDAniImage.GetPalette:HPALETTE;
begin
  Result := 0;
  If not GetEmpty then
    if FActualAniClip.Clip.Bitmap<>nil then
      result:=FActualAniClip.Clip.Bitmap.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.Loaded;
begin
  inherited Loaded;
  SetActiveClip;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then
    begin
      FControl := nil;
      SetActiveClip;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.paint;
begin

  if GetEmpty then
    begin
      inherited Paint;
      Exit;
    end;

  {draw the Image}
  If FAPlaying then
    PaintImage(GetRealCell(FACounter), GetClientRect)
  else
    PaintImage(GetRealCell(FCell), GetClientRect);

end;

{------------------------- Public----------------------------------------------}
constructor TLMDAniImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FAniClip:=TLMDAniClip.Create;
  FAniClip.OnChange:=GetChange;
  FAnimation:=TLMDAnimation.Create;
  {vielleicht ändern?}
  FAnimation.OnChange:=GetChange;
  FTimer:=TTimer.Create(nil);
  FTimer.Enabled:=false;
  FTimer.OnTimer:=GetTimer;

  FActualAniClip:=nil;

  FAPlaying:=False;
  FFlag:=0;
  FMakeVisible:=true;
end;

{------------------------------------------------------------------------------}
Destructor TLMDAniImage.Destroy;
begin
  if FAPlaying then Stop;

  FActualAniClip:=nil;
  FControl:=nil;
  FAniClip.OnChange:=nil;
  FTimer.OnTimer:=nil;
  FAnimation.Free;
  FAniClip.Free;
  FTimer.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
Procedure TLMDAniImage.First;
begin
  Move(0);
end;

{------------------------------------------------------------------------------}
Procedure TLMDAniImage.Last;
begin
  Move(FCount);
end;

{------------------------------------------------------------------------------}
Procedure TLMDAniImage.Next;
begin
  Move(FCell+1);
end;

{------------------------------------------------------------------------------}
Procedure TLMDAniImage.Prev;
begin
  Move(FCell-1);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.Play;
var
  cancel:Boolean;

begin
  If GetEmpty then exit;
  If FAPlaying then Stop;

  FADirection:=FAnimation.PlayForward;
  if FADirection then FACounter:=0 else FACounter:=FCount;
  FTimer.Interval:=FAnimation.Interval;

  if assigned(FStartEvent) then
    begin
      Cancel:=false;
      FStartEvent(Self, GetFrame(FFrame), FACounter, cancel);
      If Cancel then Exit;
    end;

  FAPlaying:=True;
  if (not Visible) and not (csDesigning in ComponentState) then
    if FMakeVisible then
      Visible:=True
    else
      exit;

  {if Transmode then repaint{invalidate}{RestoreBack:=false;};

  PaintImage(GetRealCell(FACounter), GetClientRect);

  FTimer.Enabled:=true;

end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.PlayFrameByName(aName:String; aStyle:TLMDAnStyle);
begin
  If GetEmpty then exit;
  If SetActiveValues(2, aName) then
    begin
      FCell:=0;
      FAnimation.Style:=aStyle;
      Play;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.PlayFrameByIndex(aIndex:Word; aStyle:TLMDAnStyle);
begin
  If GetEmpty then exit;
  If SetActiveValues(3, aIndex) then
    begin
      FCell:=0;
      FAnimation.Style:=aStyle;
      Play;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniImage.Stop;
var cancel:Boolean;
begin

  if not FAPlaying then exit;

  FACounter:=ALLPIC;
  Cancel:=false;
  if assigned(FEndEvent) then
    FEndEvent(Self, GetFrame(FFrame), FACounter, cancel);

  FTimer.enabled:=false;
  case FAnimation.Style of
    anOPShowLast:FCell:=FCount;
    anOPFirst:FCell:=0;
    anOPInvisible,
    anLoopInvisible: If not (csDesigning in ComponentState) then Visible:=false;
  end;

  {Paint actual Cell}
  FAPlaying:=false;
  FACounter:=0;
  If (parent<>nil) and visible then PaintImage(GetRealCell(FCell), GetClientRect);

end;

{************************ Class TLMDImage *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDImage.SetActiveClip;
begin
  If assigned(FControl) and (not FControl.Clip.Empty) then
    FActualClip:=FControl.Clip
  else
    FActualClip:=FClip;
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.SetCell(aValue:WORD);
begin
  FCell:=aValue;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.SetClip(aValue:TLMDClip);
begin
  if FClip<>aValue then
    begin
      FClip.Assign(aValue);
      SetActiveClip;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.SetControl(aControl:TLMDPicClip);
begin
  if AControl<>FControl then
    begin
      FControl:=AControl;
      SetActiveClip;
      GetChange(nil);
      if aControl <> nil then aControl.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImage.GetClips:Word;
begin
  result:=0;
  if not FActualClip.Empty then
    result:=FActualClip.Count;
end;

{------------------------------------------------------------------------------}
function TLMDImage.GetControl:TLMDPicClip;
begin
  Result := FControl;
end;

{------------------------------------------------------------------------------}
{function TLMDImage.HasControl:boolean;
begin
  result := assigned(FControl);
end;

{------------------------------- Protected ------------------------------------}
procedure TLMDImage.GetChange(Sender:TObject);
begin

  if sender is TLMDClip then SetActiveClip; {Version 1.2}

  if GetEmpty then
    FCell:=0
  else
    begin
      if FCell>=FActualClip.Count then FCell:=0;
      if not (csReading in ComponentState) then
        if Style=sbAutosize then
          SetBounds(Left, Top, FActualClip.CellX+(Bevel.BevelExtend*2), FActualClip.CellY+(Bevel.BevelExtend*2));
    end;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.GetControlChange(Sender:TObject);
begin
  if sender=FControl then
    begin
      SetActiveClip;
      GetChange(Sender);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImage.GetEmpty:Boolean;
begin
  if FActualClip=nil then
    result:=True
  else
    Result := FActualClip.Empty;
end;

{------------------------------------------------------------------------------}
function TLMDImage.GetPalette:HPALETTE;
begin
  Result := 0;
  If not GetEmpty then
    if FActualClip.Bitmap<>nil then result:=FActualClip.Bitmap.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.Loaded;
begin
   inherited Loaded;
   SetActiveClip;
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then
    begin
      FControl := nil;
      SetActiveClip;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImage.Paint;
begin

  if GetEmpty then
    begin
      inherited Paint;
      Exit;
    end;

  {draw the Image}
  PaintImage(FActualClip.GetCell(FCell), GetClientRect);
end;

{------------------------- Public----------------------------------------------}
constructor TLMDImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FActualClip:=nil;
  FClip:=TLMDClip.Create;
  FClip.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDImage.Destroy;
begin
  FActualClip:=nil;
  FControl:=nil;
  FClip.OnChange:=nil;
  FClip.Free;
  inherited Destroy;
end;

{************************ Class TLMDBmpOptions ********************************}
{------------------------- Private --------------------------------------------}
Procedure TLMDBmpOptions.SetBitmap(aValue:TBitmap);
begin
  if aValue<>FBitmap then
    begin
      FBitmap.Assign(aValue);
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDBmpOptions.SetBitmapStyle(aValue:TMeterBitmapStyle);
begin
  if aValue<>FBitmapStyle then
    begin
      FBitmapStyle:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBmpOptions.Create;
begin
  inherited Create;
  FBitmapStyle:=bmStretch;
  FBitmap:=TBitmap.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDBmpOptions.Destroy;
begin
  FBitmap.Free;
  inherited destroy;
end;

{************************ Class TLMDMeter *************************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDMeter.SetBarOptions(aValue: TBrush);
begin
  FBarOptions.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDMeter.SetBmpOptions(aValue: TLMDBmpOptions);
begin
  FBmpOptions.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDMeter.SetGradient(aValue:TLMDGradient);
begin
  FGradientOptions.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDMeter.SetMeterStyle(aValue: TMeterstyle);
begin
  if FStyle<>aValue then
    begin
      FStyle:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMeter.SetSmBarOptions(aValue: TLMDSmallBar);
begin
  FSmBarOptions.Assign(aValue);
end;

{-------------------------------- Protected -----------------------------------}
function TLMDMeter.CorrectBounds:Boolean;
var
  smW:Integer;
begin
  result:=false;
  if FUpdate then exit;
  if (FStyle=msSmallBar) and (Align=alNone) and FSmBarOptions.Autosize then
    with FSmBarOptions do
      case Direction of
        mdHorizontal, mdHorizontalReverse:
          begin
            smw:=BarCount*(HSpace+GetBarExtend(Direction, Width-DblBevelExt, Height-DblBevelExt))
                 +HSpace+DblBevelExt;
            if width<>smw then
              begin
                Width:=smw;
                result:=true;
              end;
          end;
        mdVertical, mdVerticalReverse:
           begin
              smw:=BarCount*(HSpace+GetBarExtend(Direction, Width-DblBevelExt, Height-DblBevelExt))
                   +VSpace+DblBevelExt;
              if Height<>smw then
                begin
                  Height:=smw;
                  result:=true;
                end;
          end;
      end;
   FUpdate:=Result;
end;

{------------------------------------------------------------------------------}
procedure TLMDMeter.DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);
var
  flags:Word;
  nonsens:TBitmap;
  smw, i:Integer;

begin
  with aCanvas do
    case FStyle of
      msBar:
        begin
          Brush:=FBarOptions;
          pen.Style:=psClear;
          FillRect(dest);
          DrawCaption(aCanvas, dest, notDest, aRect, True, FBarOptions.Color);
        end;
      msBitmap:
        begin
          if FBmpOptions.Bitmap.Empty then Exit;
          case FBmpOptions.BitmapStyle of
            bmStretch:
              with dest, FBmpOptions.Bitmap do
                StretchBlt(aCanvas.Handle, Left, Top, Right, Bottom,
                           Canvas.Handle, 0, 0, Width, Height, SRCCOPY);
            bmTile:
              LMDBmpClipDraw(aCanvas, dest, FBmpOptions.Bitmap, DSF_TILE or DSF_CLIPRECT, 0, clBlack);
            bmTileInvert:
              begin
                LMDBmpClipDraw(aCanvas, aRect, FBmpOptions.Bitmap, DSF_TILE or DSF_CLIPRECT, 0, clBlack);
                InvertRect(aCanvas.Handle, notDest);
              end;
           end;
           DrawCaption(aCanvas, dest, notDest, aRect, false, clBlack);
        end;
      msGradient :
        with FGradientOptions do
          begin
             flags:=DSF_CLIPRECT;
             if PaletteRealize then flags:=flags or DSF_PaletteRealize;
             LMDGradientPaintExt(aCanvas, Dest, Style, ColorList, Palette, flags, 0);
             DrawCaption(aCanvas, dest, notDest, aRect, false, clBlack);
          end;
      msOwnerDraw:
        {it is nonsens to create a Bitmap first, but we want keep compatibility
         to version 1 for the event :-) }
        begin
          nonsens:=TBitmap.Create;
          try
            LMDBmpCreateFromRect(nonsens, aRect, Self.Color);
            If Assigned(FOnDrawEvent) then FOnDrawEvent(self, Nonsens);
            aCanvas.Draw(0,0,nonsens);
          finally
            nonsens.Free;
          end;
        end;
      msSmallbar :
        with FSmBarOptions, aRect do
          begin
            smw:=FSmBarOptions.GetBarExtend(Direction, Right, Bottom);
            {todraw...}
            flags:=Word(Round((PercentValue*0.01)*BarCount));
            Brush.Style:=bsSolid;
            Brush.Color:=BarColor;
            if smw=0 then
              with dest do FillRect(Rect(Left+HSpace, Top+VSpace, Right-HSpace, Bottom-VSpace))
            else
              for i:=0 to flags-1 do
                case Direction of
                  mdHorizontal       :FillRect(Rect(i*(smW+HSpace)+HSpace, VSpace, (i+1)*(smW+HSpace), Bottom-VSpace));
                  mdHorizontalReverse:FillRect(Rect((Barcount-i-1)*(smW+HSpace)+HSpace, VSpace,
                                                    (BarCount-i)*(smW+HSpace), Bottom-VSpace));
                  mdVertical         :FillRect(Rect(HSpace, i*(smW+VSpace)+VSpace, Right-HSpace,(i+1)* (smW+VSpace)));
                  mdVerticalReverse  :FillRect(Rect(HSpace, (BarCount-i-1)*(smW+VSpace)+VSpace,Right-HSpace,
                                                   (Barcount-i)*(smW+VSpace)));
                end;
             DrawCaption(aCanvas, dest, notDest, aRect, True, FSmBarOptions.BarColor);
          end
    end;

end;

{------------------------------------------------------------------------------}
function TLMDMeter.GetPalette: HPALETTE;
begin
  Result := 0;
  If FStyle in [msSmallBar, msBar, msOwnerDraw] then exit;
  if (FStyle=msBitmap) and (not FBmpOptions.Bitmap.Empty) then
    Result := FBmpOptions.Bitmap.Palette
  else
    if FStyle=msGradient then Result:=FGradientOptions.Palette;
end;

{************************ Public Routines *************************************}
{------------------------------------------------------------------------------}
constructor TLMDMeter.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FSmBarOptions:=TLMDSmallBar.Create;
  FBmpOptions:=TLMDBmpOptions.Create;
  FBarOptions:=TBrush.Create;
  FGradientOptions:=TLMDGradient.Create;

  FSmBarOptions.OnChange:=GetChange;
  FBarOptions.OnChange:=GetChange;
  FBmpOptions.OnChange:=GetChange;
  FGradientOptions.OnCHange:=GetChange;

  FStyle:=msSmallBar;
end;

{------------------------------------------------------------------------------}
Destructor TLMDMeter.Destroy;
begin
  FSmBarOptions.free;
  FBarOptions.free;
  FBmpOptions.Free;
  FGradientOptions.Free;
  inherited Destroy;
end;

{************************ Class TLMDPanel *************************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDPanel.SetBackMode(aValue:TLMDBackMode);
begin
  if aValue<>FBackMode then
    begin
      FBackMode:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDPanel.SetBitmap(aValue:TBitmap);
begin

  if aValue<>FBitmap then
    begin
      FBitmap.Assign(aValue);
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDPanel.SetGradient(aValue:TLMDGradient);
begin
  FGradient.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if not (FBackMode in [tmNone, FBackmode]) then
    Message.Result := 1
  else
    inherited;
end;

{------------------------------ Protected -------------------------------------}
Procedure TLMDPanel.GetChange(Sender:TObject);
begin
  if Sender=FGradient then PaletteChanged(false);
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDPanel.GetPalette: HPALETTE;
begin
  Result := 0;
  If FBackmode=tmNone then exit;

  if not (FBitmap.Empty and (FBackMode<>tmGradient)) then
    Result := FBitmap.Palette
  else
    if FBackMode=tmGradient then
      Result:=FGradient.Palette;
end;

{------------------------------------------------------------------------------}
Procedure TLMDPanel.Paint;
var
  aRect:TRect;
  flags:Word;

begin

  if FBackmode=tmNone then
    begin
      FillControl;
      inherited Paint;
      exit;
    end;

  {The Bevel...}
  if (FBackMode<>tmGradient) and FBitmap.Empty then
   begin
     FillControl;
     aRect:=Bevel.PaintBevel(Canvas, GetClientRect, False);
   end
  else
    begin
      aRect:=Bevel.PaintBevel(Canvas, GetClientRect, False);
      {Background}
      try
        case FBackMode of
          tmTile    :LMDBmpClipDraw(Canvas, aRect, FBitmap, DSF_TILE or DSF_CLIPRECT
                                    {$IFDEF VER100} or DSF_PALETTEREALIZE {$ENDIF}, 0, 0);
          tmStretch :Canvas.StretchDraw(aRect, FBitmap);
          tmCenter  :begin
                       FillControl;
                       if not FBitmap.Empty then
                         canvas.Stretchdraw(Rect((Width - FBitmap.Width) div 2, (Height - FBitmap.Height) div 2,
                                                ((Width - FBitmap.Width) div 2)+FBitmap.Width,
                                                ((Height - FBitmap.Height) div 2)+FBitmap.Height), FBitmap);
                     end;
          tmGradient:with FGradient do
                       begin
                         flags:=DSF_CLIPRECT;
                         if PaletteRealize then flags:=flags or DSF_PaletteRealize;
                         LMDGradientPaintExt(Canvas, aRect, FGradient.Style, ColorList, Palette, flags, 0);
                       end;
        end;
      except
        on exception do exit;
      end;
    end;
  {Drawing the Caption...}
  DrawCaption(aRect,Alignment);
end;

{------------------------- Public----------------------------------------------}
constructor TLMDPanel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FBackMode:=tmNone;

  FBitmap:=TBitmap.Create;
  FBitmap.OnChange:=GetChange;

  FGradient:=TLMDGradient.Create;
  FGradient.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDPanel.Destroy;
begin
  FBitmap.OnCHange:=nil;
  FGradient.OnChange:=nil;

  FGradient.Free;
  FBitmap.Free;
  inherited Destroy;
end;

{************************ Class TLMDTile **************************************}
{------------------------- Private --------------------------------------------}
Procedure TLMDTile.SetBitmap(aValue:TBitmap);
begin
  FBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDTile.SetGradient(aValue:TLMDGradient);
begin
  FGradient.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDTile.SetTileMode(aValue:TLMDBackMode);
begin
    if aValue<>FTileMode then
    begin
      FTileMode:=aValue;
      if FTileMode in [tmGradient, tmStretch, tmTile] then
        Transparent:=False
      else
        Transparent:=True;
      Invalidate;
    end;
end;

{------------------------- Protected ------------------------------------------}
Procedure TLMDTile.GetChange(Sender:TObject);
begin
 if Sender=FGradient then
    PaletteChanged(False);
 InvalidateControl;
end;

{------------------------------------------------------------------------------}
function TLMDTile.GetEmpty:Boolean;
begin
  result:=(FBitmap.Empty and (FTilemode<>tmGradient)) and (Bevel.BevelExtend=0)
end;

{------------------------------------------------------------------------------}
function TLMDTile.GetPalette: HPALETTE;
begin
  result:=0;
  if not (FBitmap.Empty and (FTilemode<>tmGradient)) then
    Result := FBitmap.Palette
  else
    if FTileMode=tmGradient then
      Result:=FGradient.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDTile.Paint;
var
  aRect:TRect;
  flags:WORD;

begin

  if GetEmpty then
    begin
      inherited Paint;
      Exit;
    end;

  aRect:=Bevel.PaintBevel(Canvas, GetClientRect, Transparent);

  flags:=0;
  try
    if FTileMode<>tmGradient then
      begin
        case FTileMode of
          tmNone:flags:=flags or DSF_CLIPRECT;
          tmCenter:flags:=flags or DSF_CLIPRECT or DSF_CENTER;
          tmStretch:flags:=flags or DSF_STRETCH;
          tmTile:flags:=flags or DSF_TILE or DSF_CLIPRECT;
        end;
        if Bevel.BevelExtend=0 then flags:=flags XOR DSF_CLIPRECT;
        flags:=flags or DSF_PALETTEREALIZE;
        LMDBmpClipDraw(Self.Canvas, aRect, FBitmap, flags, MakeLong(Left, Top),clBlack);
      end
    else
      with FGradient do
        begin
          {if Bevel.BevelExtend<>0 then flags:=DSF_CLIPRECT;}
          if PaletteRealize then flags:=flags or DSF_PaletteRealize or DSF_USEOFFSCREENBITMAP;
          LMDGradientPaintExt(Canvas, aRect, Style, ColorList, Palette, flags, 0{MakeLong(Left, Top)});
        end;
  except
    on exception do exit;
  end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDTile.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FTileMode:=tmNone;

  Transparent:=True;

  FGradient:=TLMDGradient.Create;
  FGradient.OnChange:=GetChange;

  FBitmap:=TBitmap.Create;
  FBitmap.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDTile.Destroy;
begin
  FBitmap.OnChange:=nil;
  FBitmap.Free;

  FGradient.OnChange:=nil;
  FGradient.Free;

  inherited Destroy;
end;

end.
