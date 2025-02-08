unit LMDRTFLabel;
{$I LMDCmps.inc}
{

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

LMDRTFLabel unit (RM)
---------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Controls, Graphics, Messages, stdctrls, extctrls, Menus,
  Themes, LMDTypes, LMDRTFBase, LMDRTFStorage, LMDRTFRichEdit, LMDRTFHyperText;

type

  TLMDRTFFrameSide = (fsLeft, fsTop, fsRight, fsBottom);
  TLMDRTFFrameSides = set of TLMDRTFFrameSide;

  TLMDRTFBevelStyle = (bvNone, bvLovered, bvRaised);

  TLMDRTFBevel = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FStyleOuter: TLMDRTFBevelStyle;
    FStyleInner: TLMDRTFBevelStyle;
    FBorderSides: TLMDRTFFrameSides;
    procedure SetBorderSides(const Value: TLMDRTFFrameSides);
    procedure SetStyleInner(const Value: TLMDRTFBevelStyle);
    procedure SetStyleOuter(const Value: TLMDRTFBevelStyle);
  protected
    procedure Change; dynamic;
  public
    constructor Create;
    procedure PaintBevel(aCanvas: TCanvas; const aClientRect: TRect;
                aTransparent: Boolean; SB: integer);
    function ClientRect(const aRect: TRect; SB: integer): TRect;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  published
    property BorderSides: TLMDRTFFrameSides read FBorderSides write SetBorderSides default [fsLeft, fsTop, fsRight, fsBottom];
    property StyleInner: TLMDRTFBevelStyle read FStyleInner write SetStyleInner default bvNone;
    property StyleOuter: TLMDRTFBevelStyle read FStyleOuter write SetStyleOuter default bvNone;
  end;

  TLMDRTFScrollStyle = (ssLoop, ssLoopReverse, ssOnce);
  TLMDRTFScrollDirection = (sdBottomToTop, sdLeftToRight, sdRightToLeft, sdTopToBottom);

{ **************************  TLMDCustomRichLabel  ************************* }

  TLMDImageRichEdit = class(TLMDRichEdit)
  private
    FBackColor: TColor;
  protected
    function GetThemedBkColor: TColor; override;
  public
    constructor Create(ABackColor: TColor); reintroduce;
  end;

  TLMDCustomRichLabel = class(TLMDRichGraphicControl)
  private
    FLines: TStrings;
    FTransparent: Boolean;
    FAutoURLDetect: Boolean;
    FAutoURLPopup: Boolean;
    FRichStorage: TLMDRichStorage;
    FRichStorageItem: LongInt;
    FStorageLink: TLMDRTFChangeLink;
    FOnURLClick,
    FOnLinkClick: TLMDRichURLClickEvent;
    FAllowObjects: Boolean;
    FBevel: TLMDRTFBevel;
    FWordWrap: Boolean;
    FHyperText: TLMDRichHyperText;
    FLinkStorage: TLMDRichHyperLinks;
    FAlphaBlend : boolean;
    FAlphaBlendValue : byte;
    FPopupMenu: TPopupMenu;
    procedure SetLines(const Value: TStrings);
    procedure SetTransparent(const Value: Boolean);
    procedure SetAutoURLDetect(const Value: Boolean);
    procedure SetStorage(const Value: TLMDRichStorage);
    procedure SetStorageItem(const Value: LongInt);
    procedure UpdateFromStorage;
    procedure LinesChanged(Sender: TObject);
    procedure BevelChanged(Sender: TObject);
    procedure StorageDataChanged(Sender: TObject);
    procedure SetAllowObjects(const Value: Boolean);
    function IsLinesStored: Boolean;
    procedure SetBevel(const Value: TLMDRTFBevel);
    procedure SetWordWrap(const Value: Boolean);
    function IsLink(XPos, YPos: Longint): boolean;
    function IsURL(const aText: string): Boolean;
    procedure DoLinkClick(XPos, YPos: Longint; amButton: TMouseButton);
    procedure MarkRichEdit(aEditor: TLMDRichEdit);
    procedure SetAlphaBlend(const Value : boolean);
    procedure SetAlphaBlendValue(const Value : byte);
    function  IsValidRichStorageItem: Boolean;
    procedure PopupItemClick(Sender: TObject);
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMMouse); message WM_RBUTTONDOWN;
    {$IFDEF LMDCOMP12}
    procedure CMThemeChanged(var Message: TMessage); message CM_THEMECHANGED;
    {$ENDIF}
  protected
    FCursor: TCursor;
    FLinkmap: TBitmap;
    FSourceBitmap: TBitmap;
    FSourceLinkmap: TBitmap;
    FVSBMode: integer;
    FDeltaX: Integer;
    FDeltaY: Integer;
    function  ImageWidth: Integer; virtual;
    function  ImageHeight: Integer; virtual;
    procedure UpdateImage; virtual;
    procedure Paint; override;
    function  GetThemedBkColor: TColor;
    procedure URLClick(const URLText: string; Button: TMouseButton); dynamic;
    procedure LinkClick(const LinkText: string; Button: TMouseButton); dynamic;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure LoadTextProperty(Reader: TReader);
    procedure LoadLinkProperty(Reader: TReader);
    procedure LoadStorageIndexProperty(Reader: TReader);
    procedure SetOffset(aDeltaX, aDeltaY: integer); virtual;
    procedure SetStartDelta;
    function  GetLinkIndex(XPos, YPos: Longint; var Index: integer): Boolean;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property AllowObjects: Boolean read FAllowObjects write SetAllowObjects default False;
    property AlphaBlend : boolean read FAlphaBlend write SetAlphaBlend default false;
    property AlphaBlendValue : byte read FAlphaBlendValue write SetAlphaBlendValue default 255;
    property AutoURLDetect: Boolean read FAutoURLDetect write SetAutoURLDetect default True;
    property AutoURLPopup: Boolean read FAutoURLPopup write FAutoURLPopup default True;
    property Bevel: TLMDRTFBevel read FBevel write SetBevel;
    property Lines: TStrings read FLines write SetLines stored IsLinesStored;
    property RichStorage: TLMDRichStorage read FRichStorage write SetStorage;
    property RichStorageItem: LongInt read FRichStorageItem write SetStorageItem default -1;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default true;
    property OnURLClick: TLMDRichURLClickEvent read FOnURLClick write FOnURLClick;
    property OnLinkClick: TLMDRichURLClickEvent read FOnLinkClick write FOnLinkClick;
  end;

{ **************************  TLMDRichLabel  ******************************* }
  TLMDRichLabel = class(TLMDCustomRichLabel)
  published
    property AutoURLDetect;
    property AutoURLPopup;
    property AllowObjects;
    property AlphaBlend;
    property AlphaBlendValue;
    property Align;
    property Anchors;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property Lines;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RichStorage;
    property RichStorageItem;
    property ShowHint;
    property Transparent;
    property WordWrap;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;

  end;

{ **************************  TLMDCustomRichScrollText  ********************* }
  TLMDCustomRichScrollText = class(TLMDCustomRichLabel)
  private
    FScrollStyle: TLMDRTFScrollStyle;
    FScroll: Boolean;
    FDirection: TLMDRTFScrollDirection;
    FTicks: Longint;
    FTimer: TTimer;
    FStep: Longint;
    FMaxWidth: Integer;
    FMaxHeight: Integer;
    function GetDelay: Longint;
    procedure SetScrollStyle(const Value: TLMDRTFScrollStyle);
    procedure SetScroll(const Value: Boolean);
    procedure SetDirection(const Value: TLMDRTFScrollDirection);
    procedure SetDelay(value: Longint);
    procedure ScrollByTimer(Sender: TObject);
    procedure Complete;
    procedure SetMaxHeight(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
  protected
    function  ImageWidth: Integer; override;
    function  ImageHeight: Integer; override;
    procedure Paint; override;
//    procedure SetOffset(aDeltaX, aDeltaY : integer); override;
  public
    procedure StepIt; virtual;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Direction: TLMDRTFScrollDirection read FDirection write SetDirection default sdBottomToTop;
    property ScrollStyle: TLMDRTFScrollStyle read FScrollStyle write SetScrollStyle default ssLoop;
    property Scroll: Boolean read FScroll write SetScroll default false;
    property Step: Longint read FStep write FStep default 10;
    property Delay: Longint read GetDelay write SetDelay default 200;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 3000;
    property MaxHeight: Integer read FMaxHeight write SetMaxHeight default 3000;
  end;

{ **************************  TLMDRichScrollText  ********************* }
  TLMDRichScrollText = class(TLMDCustomRichScrollText)
  published
    property AlphaBlend;
    property AlphaBlendValue;
    property Direction;
    property ScrollStyle;
    property Scroll;
    property AutoURLDetect;
    property AutoURLPopup;
    property Align;
    property Anchors;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property Lines;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RichStorage;
    property RichStorageItem;
    property ShowHint;
    property Transparent;
    property WordWrap;
    property MaxWidth;
    property MaxHeight;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property Step;
    property Delay;
  end;

{ **************************  TLMDCustomRichScrollBox  ********************* }
  TLMDCustomRichScrollBox = class(TLMDCustomRichLabel)
  private
    FHScrollBar: TScrollBar;
    FVScrollBar: TScrollBar;
    procedure UpdateBarsPos;
    procedure UpdateBars;
    procedure ScrollBarChange(Sander: TObject);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMVisibleChanged(var aMessage: TMessage); message CM_VISIBLECHANGED;
  protected
    procedure Paint; override;
    procedure UpdateImage; override;
    procedure SetParent(aParent: TWinControl); override;
    procedure SetOffset(aDeltaX, aDeltaY: integer); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

  { **************************  TLMDRichScrollBar  *************************** }
  TLMDRichScrollBar = class(TScrollBar)
  private
    FScrollBox: TLMDCustomRichScrollBox;
  public
    constructor Create(aOwner: TComponent; aScrollBox: TLMDCustomRichScrollBox);reintroduce;
    destructor Destroy; override;
  end;

{ **************************  TLMDRichScrollBox  ********************* }
  TLMDRichScrollBox = class(TLMDCustomRichScrollBox)
  public
  published
    property AutoURLDetect;
    property AutoURLPopup;
    property Align;
    property Anchors;
    property AlphaBlend;
    property AlphaBlendValue;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property Lines;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RichStorage;
    property RichStorageItem;
    property ShowHint;
    property Transparent;
    property WordWrap;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  SysUtils, Forms, ClipBrd, RichEdit,
  LMDRTFHyperTextStorage, LMDProcs, LMDGraphUtils, LMDConversion;

{ **************************  TLMDCustomRichLabel  ************************* }
{ -------------------------------------------------------------------------- }

{$IFDEF LMDCOMP12}
procedure TLMDCustomRichLabel.CMThemeChanged(var Message: TMessage);
begin
  UpdateImage;
end;
{$ENDIF}

constructor TLMDCustomRichLabel.Create(aOwner: TComponent);
begin
  inherited;
  ControlStyle:= ControlStyle + [csOpaque];
  FSourceBitmap:= TBitmap.Create;
  FSourceLinkmap:= TBitmap.Create;
  FVSBMode:= 0;
  FLinkmap:= TBitmap.Create;
  FLinkmap.Canvas.Brush.Color:= 0;
  FLinkmap.Canvas.Brush.Style:= bsSolid;

  FCursor:= Cursor;
  FLines:= TStringList.Create;
  FLinkStorage:= TLMDRichHyperLinks.Create;
  FHyperText:= TLMDRichHyperText.Create;
  TStringList(FLines).OnChange:= LinesChanged;
  Width:= 100;
  Height:= 100;
  FTransparent:= false;
  FRichStorage:= nil;
  FRichStorageItem:= -1;
  FStorageLink:= TLMDRTFChangeLink.Create;
  FStorageLink.OnChange:= StorageDataChanged;
  FBevel:= TLMDRTFBevel.Create;
  FBevel.OnChange:= BevelChanged;
  FWordWrap:= true;
  FAutoURLDetect := True;
  FAutoURLPopup := True;
  FAllowObjects := False;
  SetStartDelta;
  FAlphaBlend := False;
  FAlphaBlendValue := 255;
end;

{ -------------------------------------------------------------------------- }

destructor TLMDCustomRichLabel.Destroy;
begin
  FLines.Free;
  FSourceBitmap.Free;
  FSourceLinkmap.Free;
  FLinkMap.Free;
  FLinkStorage.Free;
  FStorageLink.Free;
  FHyperText.Free;
  FBevel.Free;
  inherited;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetStartDelta;
var
  R: TRect;
begin
  R:= FBevel.ClientRect(ClientRect, FVSBMode);
  FDeltaX:= -R.Left;
  FDeltaY:= -R.Top;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetOffset(aDeltaX, aDeltaY: integer);
var
  R: TRect;
begin
  R:= FBevel.ClientRect(ClientRect, FVSBMode);
//  FDeltaX:= -R.Left + aDeltaX;
  FDeltaY:= -R.Top + aDeltaY;
{  if (aDeltaX <= (R.Right - R.Left) div 2) and (aDeltaY <= (R.Bottom - R.Top)
    div
    2) then
    begin
      FDeltaX:= -R.Left + (R.Right - R.Left) div 2 + aDeltaX;
      FDeltaY:= -R.Top - (R.Bottom - R.Top) div 2 + aDeltaY;
    end;

  if (aDeltaX <= (R.Right - R.Left) div 2) and (aDeltaY > (R.Bottom - R.Top) div
    2) then
    begin
      FDeltaX:= -R.Left + (R.Right - R.Left) div 2 + aDeltaX;
      FDeltaY:= -R.Top + (R.Bottom - R.Top) div 2 + aDeltaY;
    end;

  if (aDeltaX > (R.Right - R.Left) div 2) and (aDeltaY <= (R.Bottom - R.Top) div
    2) then
    begin
      FDeltaX:= -R.Left - (R.Right - R.Left) div 2 + aDeltaX;
      FDeltaY:= -R.Top - (R.Bottom - R.Top) div 2 + aDeltaY;
    end;

  if (aDeltaX > (R.Right - R.Left) div 2) and (aDeltaY > (R.Bottom - R.Top) div
    2) then
    begin
      FDeltaX:= -R.Left - (R.Right - R.Left) div 2 + aDeltaX;
      FDeltaY:= -R.Top + (R.Bottom - R.Top) div 2 + aDeltaY;
    end;}

end;

{ -------------------------------------------------------------------------- }

function  iMin(V1, V2: integer): integer;
begin
  if  V1 < V2 then
    Result := V1
  else
    Result := V2;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichLabel.Paint;
var
  R0, R, R1, R2 : TRect;
  tmpCanvas     : TCanvas;
  Ahdc          : HDC;
  bf            : BLENDFUNCTION;
  Ahbitmap      : HBITMAP;

  bmi           : BITMAPINFO;
  pvBits        : pointer;
  ulBitmapWidth,
  ulBitmapHeight : ULONG;

  procedure NormalizeRect(var R: TRect);

    procedure CheckBounds(var L, R: integer);
      var
        T: integer;
    begin
      if  L > R then
        begin
          T := L;
          L := R;
          R := T;
        end;
      if  L < 0 then
        begin
          inc(R, -L);
          L := 0;
        end;
    end;

  begin
    CheckBounds(R.Top, R.Bottom);
    CheckBounds(R.Left, R.Right);
  end;

begin
  if Parent = nil then
    Exit;

  FBevel.PaintBevel(Canvas, ClientRect, FTransparent, FVSBMode);
  R0:= FBevel.ClientRect(ClientRect, FVSBMode);
//  dec(R0.Right, 1);

  if  FVSBMode > 0  then
    dec(R0.Right, FVSBMode);

  R := R0;
  InflateRect(R, -2, -2);
  R1:= R;
  OffsetRect(R1, FDeltaX, FDeltaY);

  if not FTransparent then
  begin
    Canvas.Brush.Color := GetThemedBkColor; // Color;
    Canvas.FillRect(Rect(R0.Left, R0.Top, R0.Right, R0.Top + 2));
    Canvas.FillRect(Rect(R0.Left, R0.Top, R0.Left + 2, R0.Bottom));
    Canvas.FillRect(Rect(R0.Left, R0.Bottom - 2, R0.Right, R0.Bottom));
    Canvas.FillRect(Rect(R0.Right - 3, R0.Top, R0.Right, R0.Bottom));
    R2 := R;
    Canvas.copymode:= cmSrcCopy;

    Canvas.Brush.Color := GetThemedBkColor; // Color;

    if  R1.Top < 0  then
      R2.Bottom := -R1.Top + R2.Top
    else
    if  R1.Bottom > FSourceBitmap.Height  then
      R2.Top := R2.Bottom - (R1.Bottom - FSourceBitmap.Height)
    else
      R2.Top := R2.Bottom;

    Canvas.FillRect(R2);
    R2 := R;

    if  R1.Left < 0  then
      R2.Right := -R1.Left + R2.Left
    else
    if  R1.Right > FSourceBitmap.Width  then
      R2.Left := R2.Right - (R1.Right - FSourceBitmap.Width)
    else
      R2.Left := R2.Right;

    Canvas.FillRect(R2);
  end
  else
    Canvas.CopyMode := cmSrcAnd;

  FLinkmap.Canvas.FillRect(Rect(0, 0, Width, Height));
  FLinkmap.Canvas.CopyRect(R, FSourceLinkmap.Canvas, R1);

//  Canvas.copymode:= cmSrcAnd;

  R2 := R;

  if  (FDeltaY = 0) or (FDeltaY = -R.Top)  then
  begin
    R1.Top := 0;
    R1.Bottom := iMin(FSourceBitmap.Height, R.Bottom - R.Top);
    R2.Bottom := R1.Bottom + R2.Top;
  end
  else
  if  FDeltaY < 0 then
  begin
    R1.Top := 0;
    R2.Top := -FDeltaY;
    R1.Bottom := iMin(FSourceBitmap.Height, R2.Bottom - R2.Top);
    R2.Bottom := R1.Bottom + R2.Top;
  end
  else
  begin
    R1.Top := FDeltaY;
    R1.Bottom := iMin(FSourceBitmap.Height, R2.Bottom - R2.Top + R1.Top);
    R2.Bottom := iMin(R2.Top + (R1.Bottom - R1.Top), R2.Bottom);
  end;

  if (FDeltaX = 0) or (FDeltaX = -R.Left)  then
  begin
    R1.Left := 0;
    R1.Right := iMin(FSourceBitmap.Width, R.Right - R.Left);
    R2.Right := R1.Right + R2.Left;
  end
  else if FDeltaX < 0 then
  begin
    R1.Left := 0;
    R2.Left := -FDeltaX;
    R1.Right := iMin(FSourceBitmap.Width, R2.Right - R2.Left);
    R2.Right := R1.Right + R2.Left;
  end
  else
  begin
    R1.Left := FDeltaX;
    R1.Right := iMin(FSourceBitmap.Width, R2.Right - R2.Left + R1.Left);
    R2.Right := iMin(R2.Left + (R1.Right - R1.Left), R2.Right);
  end;

  NormalizeRect(R1);
  NormalizeRect(R2);

  if FAlphaBlend and (AlphaBlendValue < 255) and
     (Win32Platform = VER_PLATFORM_WIN32_NT)then
  begin
    if not FTransparent then
    begin
      Canvas.Brush.Color := GetThemedBkColor; // Color;
      Canvas.FillRect(R);
    end;
    tmpCanvas := TCanvas.Create;
    Ahdc := CreateCompatibleDC(Canvas.Handle);
    Ahbitmap := 0;
    try
      ulBitmapWidth := Width;
      ulBitmapHeight := Height;
      ZeroMemory(@bmi, sizeof(BITMAPINFO));
      bmi.bmiHeader.biSize := sizeof(BITMAPINFOHEADER);
      bmi.bmiHeader.biWidth := ulBitmapWidth;
      bmi.bmiHeader.biHeight := ulBitmapHeight;
      bmi.bmiHeader.biPlanes := 1;
      bmi.bmiHeader.biBitCount := 32;
      bmi.bmiHeader.biCompression := BI_RGB;
      bmi.bmiHeader.biSizeImage := ulBitmapWidth * ulBitmapHeight * 4;

      Ahbitmap := CreateDIBSection(Ahdc, bmi, DIB_RGB_COLORS, pvBits, 0, 0);
      SelectObject(Ahdc, Ahbitmap);

      tmpCanvas.Handle := ahdc;
      tmpCanvas.Brush.Color := GetThemedBkColor; // Color;
      tmpCanvas.FillRect(Rect(0,0,Width, Height));
      FSourceBitmap.TransparentColor := clWhite;
//      tmpCanvas.copymode:= cmSrcCopy;//cmSrcAnd;
      tmpCanvas.CopyRect(R2, FSourceBitmap.Canvas, R1);

      bf.BlendOp := AC_SRC_OVER;
      bf.BlendFlags := 0;
      bf.AlphaFormat := 0;
      bf.SourceConstantAlpha := FAlphaBlendValue;

      LMDAlphaBlend(Canvas.Handle, 0, 0, ulBitmapWidth,
                     ulBitmapHeight, Ahdc, 0, 0, ulBitmapWidth,
                     ulBitmapHeight, bf);
    finally
      if AHBitmap <> 0 then DeleteObject(Ahbitmap);
      DeleteDC(Ahdc);
      tmpCanvas.Free;
    end;
  end
  else
  begin
    if FTransparent then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.BrushCopy(R2, FSourceBitmap, R1, FSourceBitmap.TransparentColor);
    end
    else
      Canvas.CopyRect(R2, FSourceBitmap.Canvas, R1);
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichLabel.SetAlphaBlend(const Value : boolean);
begin
  if FAlphaBlend = Value then Exit;
  FAlphaBlend := Value;
  Invalidate;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichLabel.SetAlphaBlendValue(const Value : byte);
begin
  if FAlphaBlendValue <> Value then
    begin
      FAlphaBlendValue := Value;
      Invalidate;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetAutoURLDetect(const Value: Boolean);
begin
  if FAutoURLDetect <> Value then
    begin
      FAutoURLDetect:= Value;
      UpdateImage;
      Invalidate;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetLines(const Value: TStrings);
var
  Stream: TMemoryStream;
begin
  if  Assigned(Value) and Value.ClassNameIs('TRichEditStrings') then
    begin
      Stream := TMemoryStream.Create;
      try
        Value.SaveToStream(Stream);
        Stream.Position := 0;
        FLines.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end
  else
    FLines.Assign(Value)
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
    begin
      FTransparent:= Value;
      if FTransparent then
      begin
        ControlStyle:= ControlStyle - [csOpaque];
        UpdateImage;
      end
      else
        ControlStyle:= ControlStyle + [csOpaque];
      Invalidate;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.URLClick(const URLText: string;
  Button:  TMouseButton);
var
  Itm: TMenuItem;
  P: TPoint;
begin
  if IsValidRichStorageItem
    and Assigned(FRichStorage.Items[FRichStorageItem].OnURLClick) then
    OnURLClick(Self, URLText, Button);
  if Assigned(OnURLClick) then
    OnURLClick(Self, URLText, Button)
  else
    begin
      if  Button = mbLeft  then
        LMDFireURL(URLText)
      else
      if  (Button = mbRight) and AutoURLPopup  then
        begin
          if  not Assigned(FPopupMenu)  then
            begin
              FPopupMenu := TPopupMenu.Create(self);
              Itm := TMenuItem.Create(FPopupMenu);
            Itm.Tag := 1;
            Itm.Caption := '&Open ...';
              Itm.OnClick := PopupItemClick;
              FPopupMenu.Items.Add(Itm);
              Itm := TMenuItem.Create(FPopupMenu);
              Itm.Tag := 2;
              Itm.Caption := '&Copy Shortcut';
              Itm.OnClick := PopupItemClick;
              FPopupMenu.Items.Add(Itm);
            end;

          GetCursorPos(P);
          FPopupMenu.Popup(P.X, P.Y);
        end;
    end;
end;

{ -------------------------------------------------------------------------- }

type
  THackPopupMenu = class(TPopupMenu)
  end;

procedure TLMDCustomRichLabel.PopupItemClick(Sender: TObject);
var
  URL: string;
  P: TPoint;
  Index: integer;
begin
  P := THackPopupMenu(TMenuItem(Sender).GetParentMenu).PopupPoint;
  P := self.ScreenToClient(P);

  if  GetLinkIndex(P.X, P.Y, Index) then
    begin
      URL := FLinkStorage[Index].LinkAddress;
    case  TComponent(Sender).Tag of
        1:  LMDFireURL(URL);
        2:  ClipBoard.AsText := URL;
      end;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.LinkClick(const LinkText: string;
  Button: TMouseButton);
var
  S: TMemoryStream;
  R: TRect;
  P: TPoint;
  FRichEdit: TLMDRichEdit;
  PrevEditor: TLMDRichEdit;
  tmp:Integer;
  I : Integer;
begin
  if Button = mbLeft then
    begin
      tmp := 0;
      PrevEditor := nil;

      if not Assigned(Parent) or (csLoading in ComponentState) then Exit;
      if (RichStorage <> nil) and (FRichStorageItem >= 0) then
        begin
          if (TObject(RichStorage) is TLMDRichHyperTextStorage) then
            begin
              tmp := TLMDRichHyperTextStorage(RichStorage).GetNamedIndex(LinkText);
              if tmp >= 0 then
                begin
                  RichStorageItem := tmp;
                  SetOffset(0, 0);
                end;
            end;
        end;

      if tmp < 0 then
        begin
          R := FBevel.ClientRect(ClientRect, FVSBMode);
          InflateRect(R, -2, -2);
          FRichEdit:= TLMDRichEdit.Create(nil);
          FRichEdit.PageMargins.AsRect:= Rect(0, 0, 0, 0);
          FRichEdit.Visible:= false;
          FRichEdit.Parent:= Parent;

          try
            FRichEdit.Font:= Font;
            FRichEdit.ClientWidth := R.Right - R.Left;
            FRichEdit.ClientHeight := R.Bottom - R.Top;
            FRichEdit.AutoURLDetect:= AutoURLDetect;
            FRichEdit.AllowObjects:= AllowObjects;
            FRichEdit.BiDiMode:= BiDiMode;

            if WordWrap then
            begin
              FRichEdit.PageRect.Left:= 0;
              FRichEdit.PageRect.Top:= 0;
              FRichEdit.PageRect.Right:= LMDPixelsXTo(R.Right - R.Left, FRichEdit.Measurement);
              FRichEdit.PageRect.Bottom:= 0;
            end
            else
            begin
              FRichEdit.PageRect.Left:= 0;
              FRichEdit.PageRect.Top:= 0;
              FRichEdit.PageRect.Right:= 0;
              FRichEdit.PageRect.Bottom:= 0;
            end;

            if IsValidRichStorageItem then
              begin
                if (TObject(RichStorage) is TLMDRichHyperTextStorage) then
                  PrevEditor:= TLMDRichHyperTextStorage(RichStorage).HyperText.Editor;
                FRichEdit.RichStorage:= RichStorage;
                FRichEdit.RichStorageItem:= RichStorageItem;
              end
            else
              begin
                S:= TMemoryStream.Create;
                try
                  Lines.SaveToStream(S);
                  S.Position := 0;
                  FRichEdit.Lines.Clear;
                  FRichEdit.Lines.LoadFromStream(S);
                finally
                  S.Free;
                end;
              end;

            FHyperText.Editor:= FRichEdit;
            P:= FHyperText.GetBookMarkPos(LinkText);

            if  WordWrap then
              P.X := 0
            else
              begin
              end;

            I := FSourceBitmap.Height - (R.Bottom - R.Top);
            if (P.Y > I) and (I > 0) then
              P.Y := FSourceBitmap.Height - (R.Bottom - R.Top) + R.Top;

            SetOffset(P.x, p.y);
            Invalidate;
          finally
            FRichEdit.RichStorage:= nil;
            FRichEdit.Parent:= nil;
            FRichEdit.Free;
            if RichStorage <> nil then
              if (TObject(RichStorage) is TLMDRichHyperTextStorage) then
                TLMDRichHyperTextStorage(RichStorage).HyperText.Editor:= PrevEditor;
          end;
        end;
    end;

  if IsValidRichStorageItem and
    Assigned(FRichStorage.Items[FRichStorageItem].OnLinkClick) then
    FRichStorage.Items[FRichStorageItem].OnLinkClick(Self, LinkText, Button);
  if Assigned(FOnLinkClick) then FOnLinkClick(Self, LinkText, Button);
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetStorage(const Value: TLMDRichStorage);
begin
  if FRichStorage <> nil then FRichStorage.UnRegisterChanges(FStorageLink);
  FRichStorage:= Value;
  if FRichStorage <> nil then FRichStorage.RegisterChanges(FStorageLink);
  UpdateFromStorage;
end;

{ -------------------------------------------------------------------------- }

function  TLMDCustomRichLabel.IsValidRichStorageItem: Boolean;
begin
  Result := Assigned(FRichStorage) and (FRichStorageItem >= 0)
    and (FRichStorage.Count > FRichStorageItem);
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetStorageItem(const Value: LongInt);
begin
  FRichStorageItem:= Value;
  UpdateFromStorage;
end;

{ -------------------------------------------------------------------------- }

function TLMDCustomRichLabel.ImageHeight: Integer;
begin
  Result := 3000;
end;

function TLMDCustomRichLabel.ImageWidth: Integer;
begin
  Result := 3000;
end;

function TLMDCustomRichLabel.IsLinesStored: Boolean;
begin
  Result:= not Assigned(FRichStorage)
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.StorageDataChanged(Sender: TObject);
begin
  UpdateFromStorage
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.UpdateFromStorage;
begin
  if IsValidRichStorageItem then
    Lines.Assign(FRichStorage.Items[FRichStorageItem].Lines)
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetAllowObjects(const Value: Boolean);
begin
  if FAllowObjects <> Value then
    begin
      FAllowObjects:= Value;
      UpdateImage;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichLabel.LoadTextProperty(Reader: TReader);
var
  S: TStringStream;
begin
  S:= TStringStream.Create(Reader.ReadString);
  try
    Lines.LoadFromStream(S);
  finally
    S.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichLabel.LoadLinkProperty(Reader: TReader);
begin
  AutoURLDetect:= Reader.ReadBoolean
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichLabel.LoadStorageIndexProperty(Reader: TReader);
begin
  RichStorageItem:= Reader.ReadInteger;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.LinesChanged(Sender: TObject);
begin
  SetStartDelta;
  UpdateImage;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichLabel.DefineProperties(Filer: TFiler);
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('Text', LoadTextProperty, nil, false);
  Filer.DefineProperty('AutoLinkEnabled', LoadLinkProperty, nil, false);
  Filer.DefineProperty('RichStorageIndex', LoadStorageIndexProperty, nil, false);
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.Notification(aComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (aComponent = FRichStorage) then
    begin
      FRichStorage:= nil;
      Lines.Clear;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.UpdateImage;
const
  ENUM_CURRENT_SETTINGS = DWORD(-1);
var
  LastChar : LongInt;
  S : TMemoryStream;
  R : TRect;
  FRichEdit : TLMDRichEdit;
  PrevEditor : TLMDRichEdit;
  Wd, Hg : integer;
  OldCurs : TCursor;
  Smoothing : TLMDSmoothingType;
//  DevModeCurrent: TDeviceMode;
begin
  PrevEditor := nil;
  if not Assigned(Parent) or (csLoading in ComponentState) then Exit;

  R := FBevel.ClientRect(ClientRect, FVSBMode);

  Wd := R.Right - R.Left - 4;
  Hg := R.Bottom - R.Top - 4;
  FSourceBitmap.Free;
  FSourceBitmap := TBitMap.Create;
  FSourceBitmap.Transparent := true;
  FSourceBitmap.TransparentColor := GetThemedBkColor; // Color;
  FSourceBitmap.Canvas.Brush.Color := GetThemedBkColor; // Color;
  FLinkStorage.Clear;

  if  (Wd = 0) or (Hg = 0) or (Lines.Count = 0) then
    exit;

  OldCurs := Screen.Cursor;
  FRichEdit := TLMDImageRichEdit.Create(GetThemedBkColor);
  try
    Screen.Cursor := crHourGlass;
    FRichEdit.Mode := edModeAppOnly;
    FRichEdit.PageMargins.AsRect := Rect(0, 0, 0, 0);
    FRichEdit.Visible := false;
    FRichEdit.Parent := Parent;
//    FRichEdit.Color := GetThemedBkColor; // Color;
    FRichEdit.Font := Font;
    FRichEdit.AutoURLDetect := AutoURLDetect;
    FRichEdit.AllowObjects := AllowObjects;
    FRichEdit.BiDiMode := BiDiMode;
    FRichEdit.WordWrap := WordWrap;
    FRichEdit.PageRect.Left := 0;
    FRichEdit.PageRect.Top := 0;
    FRichEdit.PageRect.Right := 0;
    FRichEdit.PageRect.Bottom := 0;
    FRichEdit.HandleNeeded;

    if IsValidRichStorageItem then
    begin
      if (TObject(RichStorage) is TLMDRichHyperTextStorage) then
        PrevEditor:= TLMDRichHyperTextStorage(RichStorage).HyperText.Editor;
      FRichEdit.RichStorage := RichStorage;
      FRichEdit.RichStorageItem := RichStorageItem;
    end
    else
    begin
      S := TMemoryStream.Create;
      try
        Lines.SaveToStream(S);
        S.Position := 0;
        FRichEdit.Lines.Clear;
        FRichEdit.Lines.LoadFromStream(S);
      finally
        S.Free;
      end;
    end;
{
    DevModeCurrent.dmSize := SizeOf(DevModeCurrent);
    EnumDisplaySettings(nil, ENUM_CURRENT_SETTINGS, DevModeCurrent);

    if  DevModeCurrent.dmBitsPerPel = 16  then
      FSourceBitmap.PixelFormat := pf15bit;

    FSourceBitmap.PixelFormat := pf15bit;
}

    if  Transparent then
      Smoothing := stInactive
    else
      Smoothing := stSystem;

    LastChar := 0;
    FRichEdit.Render(FSourceBitmap, Wd, Hg, ImageWidth, ImageHeight,
                     Abs(FVSBMode), Abs(FVSBMode), LastChar, Smoothing);
    Wd := FSourceBitmap.Width;
    Hg := FSourceBitmap.Height;
    FLinkmap.Free;
    FLinkmap := TBitmap.Create;
    FLinkmap.Height := Hg;
    FLinkmap.Width := Wd;
    FSourceLinkmap.Width := Wd;
    FSourceLinkmap.Height := Hg;
    FSourceLinkmap.Canvas.FillRect(Rect(0, 0, Wd, Hg));
    LastChar := 0;
    MarkRichEdit(FRichEdit);
    FRichEdit.Render(FSourceLinkmap, LastChar);
  finally
    FRichEdit.RichStorage := nil;
    FRichEdit.Parent := nil;
    FRichEdit.Free;
    if Assigned(RichStorage)  then
      if (TObject(RichStorage) is TLMDRichHyperTextStorage) then
        TLMDRichHyperTextStorage(RichStorage).HyperText.Editor:= PrevEditor;
    Screen.Cursor := OldCurs;
  end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.Resize;
begin
  inherited; //VB Dec 2008 - (BTS #676)
  UpdateImage;
  Invalidate;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetBevel(const Value: TLMDRTFBevel);
begin
  if FBevel <> Value then
    begin
      FBevel.Assign(Value);
      Invalidate;
    end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.BevelChanged(Sender: TObject);
begin
  UpdateImage;
  Invalidate;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.Loaded;
begin
  inherited;
  UpdateImage;
  Invalidate;
  FCursor:=Cursor;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
    begin
      FWordWrap:= Value;
      UpdateImage;
      Invalidate;
    end;
end;

{ -------------------------------------------------------------------------- }

function TLMDCustomRichLabel.IsURL(const aText: string): Boolean;
const
  urlPrefix: array[0..10] of string =
  ('http:', 'ftp:', 'telnet:', 'gopher:', 'prospero:', 'nntp:', 'wais:',
    'mailto:', 'news:', 'www.', 'ftp.');
var
  I: LongInt;
begin
  Result := False;

  for I:= Low(urlPrefix) to High(urlPrefix) do
    if  SameText(urlPrefix[I], Copy(aText, 0, Length(urlPrefix[I]))) then
      begin
        Result := True;
        Break;
      end;

  if  not Result  then
    begin
      i := Pos('@', aText);
      Result:= (i > 0) and (Pos('.', Copy(aText, i + 1, MAXINT)) > 0);
    end;
end;

{ -------------------------------------------------------------------------- }

function  TLMDCustomRichLabel.GetLinkIndex(XPos, YPos: Longint; var Index: integer): Boolean;
var
  Idx: Byte;
  P: integer;
begin
  Index := -1;
  Result := False;

  if  (XPos >= 0) and (XPos < FLinkmap.Width)
      and (YPos >= 0) and (YPos < FLinkmap.Height)  then
    begin
      P := FLinkmap.Canvas.Pixels[XPos, YPos];

      if (P = 0) or (P = -1) then
        Exit;

//      Idx := round(((P - (P div 8)) / 8));
      Idx := P div 8;

      if (Idx <= FLinkStorage.Count) and (Idx > 0) then
        begin
          Index := Idx - 1;
          Result := True;
        end;
    end;
end;

function TLMDCustomRichLabel.GetThemedBkColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scWindow)
  else
  {$ENDIF}
    Result := Self.Color;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichLabel.DoLinkClick(XPos, YPos: Longint;
  amButton: TMouseButton);
var
  Index: integer;
begin
  if  GetLinkIndex(XPos, YPos, Index) then
    begin
      if not FLinkStorage[Index].LinkType then
        UrlClick(FLinkStorage[Index].LinkAddress, amButton)
      else
        LinkClick(FLinkStorage[Index].LinkAddress, amButton);
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichLabel.WMMouseMove(var Message: TWMMouse);
begin
  inherited;
  if IsLink(Message.XPos, Message.YPos) then
    begin
      if Cursor <> crHandPoint then
        FCursor := Cursor;
      Cursor := crHandPoint;
    end
  else
    Cursor := FCursor;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichLabel.WMLButtonDown(var Message: TWMMouse);
begin
  inherited;
  if IsLink(Message.XPos, Message.YPos) then
    DoLinkClick(Message.XPos, Message.YPos, mbLeft);
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichLabel.WMRButtonDown(var Message: TWMMouse);
begin
  inherited;
  if IsLink(Message.XPos, Message.YPos) then
    DoLinkClick(Message.XPos, Message.YPos, mbRight);
end;

{ -------------------------------------------------------------------------- }

function TLMDCustomRichLabel.IsLink(XPos, YPos: Longint): boolean;
var
  Index: integer;
begin
  Result := GetLinkIndex(XPos, YPos, Index) and (Index >= 0);
end;

procedure TLMDCustomRichLabel.MarkRichEdit(aEditor: TLMDRichEdit);
const
  eot = #$0;

  function IsDelimiter(C: Char): Boolean;
  begin
    Result := (C = ' ') or (C = #10) or (C = #13) or (C = #9) or
              (C = '"') or (C = '#') or (C = '$') or (C = '`') or (C = '(') or (C = ')') or (C = '<') or (C = '>');
              {(C = '&') or (C = '''') or (C = '(') or (C = ')') or (C = '~') or
              (C = '_') or (C = '-') or (C = '+') or (C = '=') or (C = '!') or
              (C = '%') or (C = '|') or (C = '|') or (C = '?')};
              // RM My-2005
  end;

type
  TCharType = (ctDelimiter, ctText);

var
  CPos: Longint;
  SelStart: Longint;
  SelLength: Longint;
  SelType: TCharType;
  Ch: Char;

  function GetNextChar: Char;
  var
    TextRange: TTextRangeA;
    BB: array [0..1] of Char;
  begin
    TextRange.chrg.cpMin:= CPos;
    TextRange.chrg.cpMax:= CPos + 1;
  TextRange.lpstrText := @BB;
  if aEditor.Perform(EM_GETTEXTRANGE, 0, TLMDPtrInt(@TextRange)) = 0 then
    Result := eot
      else begin
      Result := BB[0];
      end;

      Inc(CPos);
  end;

  function GetCharType(aChar: Char): TCharType;
  begin
    if IsDelimiter(aChar) then
      Result:= ctDelimiter
    else
      Result:= ctText;
  end;

  procedure MarkText;
  var
    Cl: Longint;
    CLink: TLMDRichHyperLink;
  begin
    Cl:= 0;
    aEditor.SetSelRange(SelStart, SelLength);

    if aEditor.SelAttributes.Link then
      if IsURL(aEditor.SelText) then
        begin
          aEditor.SelAttributes.Link:= False;
          CLink:= FLinkStorage.Add;
          CLink.LinkType:= False;
          CLink.LinkAddress:= aEditor.SelText;
          Cl:= (CLink.Index + 1) * 8;
        end;
    aEditor.SelAttributes.Color:= Cl;
    aEditor.SelAttributes.BackColor:= Cl;
  end;

begin
  aEditor.Lines.BeginUpdate;
  try
    aEditor.SelectAll;
    aEditor.SelAttributes.Protected := False;
    aEditor.SelLength := 0;

    CPos:= 0;
    SelStart:= 0;
    SelLength:= 0;
    SelType:= ctDelimiter;

    aEditor.Color:= 0;

    Ch:= GetNextChar;
    while Ch <> eot do
      begin
        if SelType <> GetCharType(Ch) then
          begin
            MarkText;
            SelType:= GetCharType(Ch);
            SelStart:= SelStart + SelLength;
            SelLength:= 1;
          end
        else
          Inc(SelLength);
        Ch:= GetNextChar;
      end;
    if SelLength > 0 then
      MarkText;
    FHyperText.Editor:= aEditor;
    FHyperText.MarkLinksForLabel(FLinkStorage);
  finally
    aEditor.Lines.EndUpdate;
  end;
end;

{ **************************  TLMDCustomRichScrollText  ******************** }
{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.Complete;
const
  InvDirs: array[TLMDRTFScrollDirection] of TLMDRTFScrollDirection =
  (sdTopToBottom, sdRightToLeft, sdLeftToRight, sdBottomToTop);
begin
  case ScrollStyle of
    ssLoop: FTicks:= 0;
    ssOnce: Scroll:= false;
    ssLoopReverse:
      begin
        FDirection:= InvDirs[Direction];
        Scroll:= true;
      end;
  end;
end;

{ -------------------------------------------------------------------------- }

constructor TLMDCustomRichScrollText.Create(aOwner: TComponent);
begin
  inherited;
  FTimer:= TTimer.Create(self);
  FTimer.Enabled:= false;
  FStep:= 10;
  FTimer.Interval:= 200;
  FTimer.OnTimer:= ScrollByTimer;
  FMaxWidth := 3000;
  FMaxHeight := 3000;
end;

{ -------------------------------------------------------------------------- }

destructor TLMDCustomRichScrollText.Destroy;
begin
  FTimer.Enabled:= false;
  FreeAndNil( FTimer);
  inherited;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.Paint;
var
  R: TRect;
begin
  if Parent = nil then Exit;

  if  Scroll  then
    begin
      R:= FBevel.ClientRect(ClientRect, FVSBMode);
      case Direction of
        sdBottomToTop: FDeltaY:= -R.Top - (Height - FTicks);
        sdLeftToRight: FDeltaX:= -R.Left - (FTicks - FSourceBitmap.Width);
        sdRightToLeft: FDeltaX:= -R.Left - (Width - FTicks);
        sdTopToBottom: FDeltaY:= -R.Top - (FTicks - FSourceBitmap.Height);
      end;
    end
  else
    begin
      FDeltaY := 0;
      FDeltaX := 0;
    end;
  inherited Paint;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.ScrollByTimer(Sender: TObject);
begin
  StepIt;
  if Direction in [sdBottomToTop, sdTopToBottom] then
    begin
      if FTicks > FSourceBitmap.Height + Height then
        Complete
    end
  else if FTicks > FSourceBitmap.Width + Width then
    Complete;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.SetDirection(
  const Value: TLMDRTFScrollDirection);
begin
  if FDirection <> Value then
    begin
      FDirection:= Value;
      Scroll:= false;
      SetStartDelta;
      Invalidate;
    end;
end;

procedure TLMDCustomRichScrollText.SetMaxHeight(const Value: Integer);
begin
  if FMaxHeight <> Value then
  begin
    FMaxHeight := Value;
    UpdateImage;
    Invalidate;
  end;
end;

procedure TLMDCustomRichScrollText.SetMaxWidth(const Value: Integer);
begin
  if FMaxWidth <> Value then
  begin
    FMaxWidth := Value;
    UpdateImage;
    Invalidate;
  end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.SetScroll(const Value: Boolean);
begin
  FScroll:= Value;
  FTicks:= 0;
  SetStartDelta;
  if not (csDesigning in ComponentState) then begin
    Invalidate;
    FTimer.Enabled:= Value;
  end;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.SetScrollStyle(const Value:
  TLMDRTFScrollStyle);
begin
  if FScrollStyle <> Value then
    begin
      FScrollStyle:= Value;
      SetStartDelta;
      Scroll:= false;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichScrollText.SetDelay(value : Longint);
begin
  if Assigned(FTimer) then FTimer.Interval := value;
end;

{ -------------------------------------------------------------------------- }
function  TLMDCustomRichScrollText.GetDelay: Longint;
begin
  if assigned(FTimer) then
    result := FTimer.Interval
  else
    result := 200;
end;
function TLMDCustomRichScrollText.ImageHeight: Integer;
begin
  Result := FMaxHeight;
end;

function TLMDCustomRichScrollText.ImageWidth: Integer;
begin
  Result := FMaxWidth;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollText.StepIt;
begin
  Inc(FTicks, FStep);
  try
    if FTransparent then
      Invalidate
    else
      Paint;
  except
    Scroll:= false;
  end;
end;

{ **************************  TLMDCustomRichScrollBox  ********************* }
{ -------------------------------------------------------------------------- }

constructor TLMDCustomRichScrollBox.Create(aOwner: TComponent);
begin
  inherited;
  ParentColor := False;
  FHScrollBar:= TLMDRichScrollBar.Create(nil, Self);
  FHScrollBar.Visible:= False;
  FHScrollBar.TabStop := False;
  FHScrollBar.Kind:= sbHorizontal;
  FHScrollBar.OnChange:= ScrollBarChange;
  FVScrollBar:= TLMDRichScrollBar.Create(nil, Self);
  FVScrollBar.Visible:= False;
  FVScrollBar.TabStop := False;
  FVScrollBar.Kind:= sbVertical;
  FVScrollBar.OnChange:= ScrollBarChange;
  FVSBMode:= -(FVScrollBar.Width + 1);
  UpdateBarsPos;
end;

{ -------------------------------------------------------------------------- }

destructor TLMDCustomRichScrollBox.Destroy;
begin
  if Assigned(FHScrollBar) then FreeAndNil( FHScrollBar);
  if Assigned(FVScrollBar) then FreeAndNil( FVScrollBar);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRichScrollBox.CMVisibleChanged(var aMessage: TMessage);
begin
  inherited;
  UpdateBars;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomRichScrollBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FHScrollBar) then FHScrollBar.Enabled := Enabled;
  if Assigned(FVScrollBar) then FVScrollBar.Enabled := Enabled;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomRichScrollBox.UpdateBars;
var
  CW, CH, SW, SH: integer;
  V, H: Boolean;
begin
//  if  csDesigning in ComponentState   then  System.Exit;
  V := False;
  H := False;

  if  Visible and Assigned(FSourceBitmap)  then
    begin
      CW := ClientWidth - 4;
      CH := ClientHeight - 4;
      SW := FSourceBitmap.Width;
      SH := FSourceBitmap.Height;
      V := (SH > 0) and (CH > 0) and (SH > CH);
      H := (SW > 0) and (CW > 0) and (SW > CW);

      if  V and not H then
        H := (SW > (CW - FVScrollBar.Width));

      if  not V and H then
        V := (SH > (CH - FHScrollBar.Height));
    end;

  FVScrollBar.Visible:= V;
  FHScrollBar.Visible:= H and not WordWrap;

  if  V then
    FVSBMode:= Abs(FVSBMode)
  else
    FVSBMode:= -Abs(FVSBMode);

//  FVSBResult;
//  FHScrollBar.Visible:= Visible and ((FSourceBitmap.Width {/ (FLPY div
//    GetDeviceCaps(Canvas.Handle, LOGPIXELSY))}) >= Width);
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollBox.SetOffset(aDeltaX, aDeltaY: integer);
begin
  if Assigned(FHScrollBar){ and FHScrollBar.Visible} then
    FHScrollBar.Position:= aDeltaX;
  if Assigned(FVScrollBar) {and FVScrollBar.Visible} then
    FVScrollBar.Position:= aDeltaY;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichScrollBox.Paint;
var
  R: TRect;
begin
  if Parent = nil then Exit;
  R:= ClientRect;

  if Assigned(FHScrollBar) and FHScrollBar.Visible then
    begin
      R.Bottom:= R.Bottom - FHScrollBar.Height;
      FDeltaX:= FHScrollBar.Position - R.Left;
    end
  else
    FDeltaX:= -R.Left;

  if Assigned(FVScrollBar) and FVScrollBar.Visible then
    begin
      R.Right:= R.Right - FVScrollBar.Width;
      FDeltaY:= FVScrollBar.Position - R.Top;
    end
  else
    FDeltaY:= -R.Top;

  R:= FBevel.ClientRect(R, FVSBMode);
  InflateRect(R, -2, -2);

//  FDeltaX:= FHScrollBar.Position - R.Left;
//  FDeltaY:= FVScrollBar.Position - R.Top;
  inherited Paint;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollBox.ScrollBarChange(Sander: TObject);
begin
//  if  csDesigning in ComponentState   then  System.Exit;
  Invalidate;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDCustomRichScrollBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  UpdateBarsPos;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichScrollBox.SetParent(aParent: TWinControl);
begin
  inherited;
  if Assigned(FHScrollBar) then FHScrollBar.Parent:= Parent;
  if Assigned(FVScrollBar) then FVScrollBar.Parent:= Parent;
  UpdateBarsPos;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichScrollBox.UpdateBarsPos;
begin
  if csLoading in ComponentState then exit;

  if Assigned(FHScrollBar) then
    begin
      FHScrollBar.Top:= Top + Height - FHScrollBar.Height;
      FHScrollBar.Left:= Left;
      FHScrollBar.Width:= Width;
      if Assigned(FVScrollBar) and FVScrollBar.Visible then
        FHScrollBar.Width:= FHScrollBar.Width - FHScrollBar.Height;
    end;

  if Assigned(FVScrollBar) then
    begin
      FVScrollBar.Left:= Left + Width - FVScrollBar.Width;
      FVScrollBar.Top:= Top;
      FVScrollBar.Height:= Height;
      if Assigned(FHScrollBar) and FHScrollBar.Visible then
        FVScrollBar.Height:= FVScrollBar.Height - FVScrollBar.Width;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDCustomRichScrollBox.UpdateImage;
var
  i, tmp: integer;
  R: TRect;
begin
  if not Assigned(Parent) or (csLoading in ComponentState) then Exit;
  inherited UpdateImage;
  UpdateBars;
  R:= FBevel.ClientRect(ClientRect, FVSBMode);
  InflateRect(R, -2, -2);

  if FHScrollBar.Visible then
    begin
      FHScrollBar.Position := 0;
      FHScrollBar.Min := 0;
  //    FHScrollBar.PageSize:= Width;
      tmp:=FSourceBitmap.Width - FHScrollBar.Width;
      if tmp<0 then tmp:=0;
      FHScrollBar.Max:=tmp;
      FHScrollBar.SmallChange:= 10;
      FHScrollBar.LargeChange:= FHScrollBar.Width - 4;
    end;

  if FVScrollBar.Visible then
    begin
      if  (FSourceBitmap.Height = 0) or (Lines.Count = 0) then
        FVScrollBar.Visible := False
      else
        begin
          i := FSourceBitmap.Height div Lines.Count;
          FVScrollBar.Position := 0;
          FVScrollBar.Min := 0;
          FVScrollBar.Max := FSourceBitmap.Height - (R.Bottom - R.Top) + 4;
          FVScrollBar.SmallChange:= i;//10;
          FVScrollBar.LargeChange:= (R.Bottom - R.Top) - 4;
    //    FVScrollBar.PageSize := i - GetSystemMetrics(SM_CYVSCROLL);
        end;
    end;
  UpdateBarsPos;
end;

{ **************************** TLMDRTFBevel ********************************** }
{ ----------------------------- private -------------------------------------- }
procedure TLMDRTFBevel.SetBorderSides(const Value: TLMDRTFFrameSides);
begin
  FBorderSides:= Value;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFBevel.SetStyleInner(const Value: TLMDRTFBevelStyle);
begin
  FStyleInner:= Value;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFBevel.SetStyleOuter(const Value: TLMDRTFBevelStyle);
begin
  FStyleOuter:= Value;
  Change;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDRTFBevel.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self)
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRTFBevel.Create;
begin
  inherited;
  FBorderSides:= [fsLeft, fsTop, fsRight, fsBottom];
end;

{------------------------------------------------------------------------------}
function TLMDRTFBevel.ClientRect(const aRect: TRect; SB: integer): TRect;
var
  BevelSize: Integer;
  BevelWidth: Integer;
begin
  Result:= aRect;
  if (aRect.Right - aRect.Left >= 3) and (aRect.Bottom - aRect.Top >= 3) then
    begin
      BevelSize := 0;
      BevelWidth := 1;  //  ???
      if StyleOuter <> bvNone then Inc(BevelSize, BevelWidth);
      if StyleInner <> bvNone then Inc(BevelSize, BevelWidth);

      if  fsLeft in BorderSides then  inc(Result.Left, BevelSize);
      if  fsTop in BorderSides then  inc(Result.Top, BevelSize);
      if  (fsRight in BorderSides) and (SB <= 0) then  dec(Result.Right, BevelSize);
      if  fsBottom in BorderSides then  dec(Result.Bottom, BevelSize);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFBevel.PaintBevel(aCanvas: TCanvas; const aClientRect: TRect;
    aTransparent: Boolean; SB: integer);

  procedure BevelLine(C: TColor; X1, Y1, X2, Y2: Integer);
  begin
    with aCanvas do
      begin
        Pen.Color:= C;
        MoveTo(X1, Y1);
        LineTo(X2, Y2);
      end;
  end;

var
  Color1, Color2: TColor;

  procedure DrawBevel(const aClientRect: TRect);
  begin
    if fsTop in BorderSides then
      BevelLine(Color1, aClientRect.Left, aClientRect.Top,
        aClientRect.Right, aClientRect.Top);
    if fsBottom in BorderSides then
      BevelLine(Color2, aClientRect.Left, aClientRect.Bottom -1,
        aClientRect.Right, aClientRect.Bottom - 1);
    if fsLeft in BorderSides then
      BevelLine(Color1, aClientRect.Left, aClientRect.Top,
        aClientRect.Left, aClientRect.Bottom);
    if (fsRight in BorderSides) and (SB <= 0) then
      BevelLine(Color2, aClientRect.Right - 1, aClientRect.Top,
        aClientRect.Right - 1, aClientRect.Bottom);
(*
    if fsTop in BorderSides then
      BevelLine(Color1, aClientRect.Left + 1, aClientRect.Top + 1,
        aClientRect.Right, aClientRect.Top{ + 1});
    if fsBottom in BorderSides then
      BevelLine(Color2, aClientRect.Left, aClientRect.Bottom{ - 1},
        aClientRect.Right, aClientRect.Bottom{ - 1});
    if fsLeft in BorderSides then
      BevelLine(Color1, aClientRect.Left + 1, aClientRect.Top + 1,
        aClientRect.Left + 1, aClientRect.Bottom);
    if fsRight in BorderSides then
      BevelLine(Color2, aClientRect.Right - 1, aClientRect.Top,
        aClientRect.Right - 1, aClientRect.Bottom);
*)
  end;

var
  R: TRect;
begin
  R := aClientRect;

  if  SB > 0  then
    dec(R.Right, SB);

  with aCanvas do
    begin
      Pen.Style:= psSolid;
      Pen.Mode:= pmCopy;
      Pen.Color:= clBlack;
      Brush.Style:= bsSolid;
      Pen.Width:= 1;

      if StyleOuter <> TLMDRTFBevelStyle(bvNone) then
        begin
          if StyleOuter = TLMDRTFBevelStyle(bvLowered) then
            begin
              Color1:= clBtnShadow;
              Color2:= clBtnHighlight;
            end
          else
            begin
              Color1:= clBtnHighlight;
              Color2:= clBtnShadow;
            end;
          DrawBevel(R);
        end;

      if StyleInner <> TLMDRTFBevelStyle(bvNone) then
        begin
          if StyleInner = TLMDRTFBevelStyle(bvLowered) then
            begin
              Color1:= clBtnShadow;
              Color2:= clBtnHighlight;
            end
          else
            begin
              Color1:= clBtnHighlight;
              Color2:= clBtnShadow;
            end;
          InflateRect(R, -1, -1);
          DrawBevel(R);
        end;
    end;
end;

{ ************************** TLMDRichScrollBar ********************************}
{----------------------------- public -----------------------------------------}
constructor TLMDRichScrollBar.Create(aOwner: TComponent; aScrollBox: TLMDCustomRichScrollBox);
begin
  inherited Create( aOwner);
  FScrollBox:= aScrollBox;
  Anchors := [akLeft,akTop];
end;
{------------------------------------------------------------------------------}
destructor TLMDRichScrollBar.Destroy;
begin
  if FScrollBox.FHScrollBar = Self then FScrollBox.FHScrollBar:= nil;
  if FScrollBox.FVScrollBar = Self then FScrollBox.FVScrollBar:= nil;
  inherited;
end;

{ TLMDImageRichEdit }

constructor TLMDImageRichEdit.Create(ABackColor: TColor);
begin
  inherited Create(nil);
  FBackColor := ABackColor;
end;

function TLMDImageRichEdit.GetThemedBkColor: TColor;
begin
  Result := FBackColor;
end;

end.
