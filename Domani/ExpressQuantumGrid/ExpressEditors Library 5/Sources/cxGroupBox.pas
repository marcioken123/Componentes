
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxGroupBox;

{$I cxVer.inc}

interface

uses
{$IFDEF VCL}
  Windows, Messages,
{$ENDIF}
  SysUtils, Classes, Controls, Graphics, Forms, cxControls, cxGraphics,
  cxLookAndFeels, cxContainer, cxEditPaintUtils, cxEdit,
  cxTextEdit, cxClasses, cxCheckBox, cxLookAndFeelPainters;

type
  TcxCaptionAlignment = (alTopLeft, alTopCenter, alTopRight,
    alBottomLeft, alBottomCenter, alBottomRight,
{$IFDEF VCL}
    alLeftTop, alLeftCenter, alLeftBottom,
    alRightTop, alRightCenter, alRightBottom,
{$ENDIF}
    alCenterCenter);

  { TcxGroupBoxButtonViewInfo }

  TcxGroupBoxButtonViewInfo = class(TcxEditButtonViewInfo)
  public
    Caption: string;
    Column, Row: Integer;
    function GetGlyphRect(ACanvas: TcxCanvas; AGlyphSize: TSize; AAlignment: TLeftRight; AIsPaintCopy: Boolean): TRect; virtual;
  end;

  { TcxGroupBoxViewInfo }

  TcxCustomGroupBox = class;

  TcxGroupBoxViewInfo = class(TcxCustomTextEditViewInfo)
  private
    function GetControlRect: TRect;
    function GetEdit: TcxCustomGroupBox;
  protected
    function GetButtonViewInfoClass: TcxEditButtonViewInfoClass; override;
    procedure InternalPaint(ACanvas: TcxCanvas); override;
    property ControlRect: TRect read GetControlRect;
  public
    Alignment: TLeftRight;
    CaptionBitmap: TBitmap;
    CaptionBitmapCanvas: TcxCanvas;
    CaptionRect: TRect;
    IsDesigning: Boolean;
    TextRect: TRect;
    constructor Create; override;
    destructor Destroy; override;
    property Edit: TcxCustomGroupBox read GetEdit;
  end;

  { TcxGroupBoxViewData }

  TcxGroupBoxViewData = class(TcxCustomEditViewData)
  private
    function GetCaptionRect(ACanvas: TcxCanvas): TRect;
    function GetEdit: TcxCustomGroupBox;
    procedure CalcRects(ACanvas: TcxCanvas; AEditViewInfo: TcxGroupBoxViewInfo);
  protected
    function GetContainerState(const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState;
      AIsMouseEvent: Boolean): TcxContainerState; override;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    function GetBorderColor: TColor; override;
    function GetBorderExtent: TRect; override;
    function GetClientExtent(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomEditViewInfo): TRect; override;
    function HasShadow: Boolean; override;
{$IFDEF VCL}
    class function IsNativeStyle(ALookAndFeel: TcxLookAndFeel): Boolean; override;
{$ENDIF}
    property Edit: TcxCustomGroupBox read GetEdit;
  end;

  { TcxButtonGroupViewData }

  TcxCustomButtonGroupProperties = class;

  TcxEditMetrics = record
    AutoHeightColumnWidthCorrection, AutoHeightWidthCorrection,
    ColumnWidthCorrection, WidthCorrection: Integer;
    ClientLeftBoundCorrection, ClientWidthCorrection, ColumnOffset: Integer;
    ButtonSize: TSize;
  end;

  { TcxButtonGroupViewInfo }

  TcxButtonGroupViewInfo = class(TcxGroupBoxViewInfo)
  protected
    procedure DrawEditButton(ACanvas: TcxCanvas; AButtonVisibleIndex: Integer); override;
    procedure DrawButtonCaption(ACanvas: TcxCanvas;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect); virtual; abstract;
    procedure DrawButtonGlyph(ACanvas: TcxCanvas;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect); virtual; abstract;
    function GetGlyphSize: TSize; virtual;
    function IsButtonGlypthTransparent(AButtonViewInfo: TcxGroupBoxButtonViewInfo): Boolean; virtual; abstract;
  public
    CaptionExtent: TRect;
    GlyphSize: TSize;
  end;

  TcxButtonGroupViewData = class(TcxGroupBoxViewData)
  private
    function GetProperties: TcxCustomButtonGroupProperties;
  protected
    procedure CalculateButtonPositions(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomEditViewInfo); virtual;
    procedure CalculateButtonViewInfos(AViewInfo: TcxCustomEditViewInfo); virtual;
    function GetDrawTextFlags: Integer; virtual;
    procedure GetEditMetrics(AAutoHeight: Boolean; ACanvas: TcxCanvas;
      out AMetrics: TcxEditMetrics); virtual; abstract;
    function GetCaptionRectExtent: TRect; virtual;
{$IFDEF VCL}
    procedure CalculateButtonNativeState(AViewInfo: TcxCustomEditViewInfo;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo); virtual; abstract;
{$ENDIF}
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    procedure CalculateButtonsViewInfo(ACanvas: TcxCanvas; const ABounds: TRect;
      const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
      AViewInfo: TcxCustomEditViewInfo; AIsMouseEvent: Boolean); override;
    function GetEditConstantPartSize(ACanvas: TcxCanvas;
      const AEditSizeProperties: TcxEditSizeProperties;
      var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo = nil): TSize; override;
    class function IsButtonNativeStyle(ALookAndFeel: TcxLookAndFeel): Boolean; virtual;
    property Properties: TcxCustomButtonGroupProperties read GetProperties;
  end;

  TcxButtonGroupViewDataClass = class of TcxButtonGroupViewData;

  { TcxCustomGroupBoxProperties }

  TcxCustomGroupBoxProperties = class(TcxCustomEditProperties)
  protected
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
  public
    class function GetContainerClass: TcxContainerClass; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
  end;

  { TcxButtonGroupItem }

  TcxButtonGroupItem = class(TCollectionItem)
  private
    FCaption: TCaption;
    FEnabled: Boolean;
    FTag: TTag;
    function GetIsCollectionDestroying: Boolean;
    function IsTagStored: Boolean;
    procedure SetCaption(const Value: TCaption);
    procedure SetEnabled(Value: Boolean);
  protected
    procedure DoChanged(ACollection: TCollection; ACollectionOperation: TcxCollectionOperation;
      AIndex: Integer = -1);
    property Caption: TCaption read FCaption write SetCaption;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property IsCollectionDestroying: Boolean read GetIsCollectionDestroying;
    property Tag: TTag read FTag write FTag stored IsTagStored;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetCaption: TCaption;
  end;

  { TcxButtonGroupItems }

  TcxButtonGroupItems = class(TOwnedCollection,
    IUnknown, IcxCheckItems)
  private
    FChangedItemIndex: Integer;
    FChangedItemOperation: TcxCollectionOperation;
    FIsDestroying: Boolean;
    FItemChanged: Boolean;
    function GetItem(Index: Integer): TcxButtonGroupItem;
    procedure SetItem(Index: Integer; Value: TcxButtonGroupItem);

    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    { IcxCheckItems }
    function IcxCheckItems.GetCaption = CheckItemsGetCaption;
    function IcxCheckItems.GetCount = CheckItemsGetCount;
    function CheckItemsGetCaption(Index: Integer): string;
    function CheckItemsGetCount: Integer;
  protected
    procedure Update(Item: TCollectionItem); override;
    property ChangedItemIndex: Integer read FChangedItemIndex;
    property ChangedItemOperation: TcxCollectionOperation
      read FChangedItemOperation;
    property IsDestroying: Boolean read FIsDestroying;
    property ItemChanged: Boolean read FItemChanged;
  public
    destructor Destroy; override;
    procedure InternalNotify(AItem: TcxButtonGroupItem; AItemIndex: Integer;
      AItemOperation: TcxCollectionOperation);
    property Items[Index: Integer]: TcxButtonGroupItem
      read GetItem write SetItem; default;
  end;

  TcxButtonGroupItemsClass = class of TcxButtonGroupItems;

  { TcxCustomButtonGroupProperties }

  TcxCustomButtonGroupProperties = class(TcxCustomGroupBoxProperties)
  private
    FColumns: Integer;
    FItems: TcxButtonGroupItems;
    FWordWrap: Boolean;
    procedure SetColumns(Value: Integer);
    procedure SetItems(Value: TcxButtonGroupItems);
    procedure SetWordWrap(Value: Boolean);
  protected
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    function CreateItems: TcxButtonGroupItems; virtual;
    function GetButtonsPerColumn: Integer;
    function GetColumnCount: Integer; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CreatePreviewProperties: TcxCustomEditProperties; override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetSpecialFeatures: TcxEditSpecialFeatures; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    // !!!
    property Columns: Integer read FColumns write SetColumns default 1;
    property Items: TcxButtonGroupItems read FItems write SetItems;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;

  { TcxCustomGroupBox }

  TcxCustomGroupBox = class(TcxCustomEdit)
  private
    FAlignment: TcxCaptionAlignment;
    FCaptionBkColor: TColor; // deprecated
    FCaptionFont: TFont;
    FIsAccelCharHandling: Boolean;
    FVisibleCaption: string;
    procedure CalculateVisibleCaption;
    function GetColor: TColor; // deprecated
    function GetFont: TFont; // deprecated
    procedure SetAlignment(Value: TcxCaptionAlignment);
    procedure SetColor(Value: TColor); // deprecated
    procedure SetFont(Value: TFont); // deprecated
  {$IFNDEF DELPHI7}
    procedure WMPrintClient(var Message: TMessage); message WM_PRINTCLIENT;
  {$ENDIF}
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    function CanAutoSize: Boolean; override;
    function CanFocusOnClick: Boolean; override;
    procedure ContainerStyleChanged(Sender: TObject); override;
    function DefaultParentColor: Boolean; override;
    procedure FontChanged; override;
    function GetShadowBounds: TRect; override;
    procedure Initialize; override;
    function InternalGetActiveStyle: TcxContainerStyle; override;
    function InternalGetNotPublishedStyleValues: TcxEditStyleValues; override;
    function IsContainerClass: Boolean; override;
    function IsNativeBackground: Boolean; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    procedure TextChanged; override;
    procedure AdjustCanvasFontSettings(ACanvas: TcxCanvas);
    procedure CalculateCaptionFont;
    function GetCaptionDrawingFlags: Integer;
    function IsVerticalText: Boolean;
    property CaptionBkColor: TColor read FCaptionBkColor write FCaptionBkColor
      stored False; // deprecated
    property Color: TColor read GetColor write SetColor stored False; // deprecated
    property Ctl3D;
    property Font: TFont read GetFont write SetFont stored False; // deprecated
    property ParentBackground;
    property TabStop default False;
  public
  {$IFDEF CBUILDER10}
    constructor Create(AOwner: TComponent); override;
  {$ENDIF}
    destructor Destroy; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property Alignment: TcxCaptionAlignment read FAlignment write SetAlignment
      default alTopLeft;
    property Transparent;
  end;

  { TcxGroupBox }

  TcxGroupBox = class(TcxCustomGroupBox)
  published
    property Align;
    property Alignment;
    property Anchors;
    property BiDiMode;
    property Caption;
    property CaptionBkColor; // deprecated
    property Color; // deprecated
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font; // deprecated
    property LookAndFeel; // deprecated
    property ParentBackground;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  { TcxCustomButtonGroup }

  TcxCustomButtonGroup = class(TcxCustomGroupBox)
  private
    FButtons: TList;
    procedure DoButtonDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DoButtonDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DoButtonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoButtonKeyPress(Sender: TObject; var Key: Char);
    procedure DoButtonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoButtonMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DoButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoButtonMouseWheel(Sender: TObject;
      {$IFNDEF VCL}const{$ENDIF} Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint; var Handled: Boolean);
    function GetProperties: TcxCustomButtonGroupProperties;
    function GetActiveProperties: TcxCustomButtonGroupProperties;
    procedure SetProperties(Value: TcxCustomButtonGroupProperties);
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
      message WM_WINDOWPOSCHANGED;
  protected
    function CanAutoSize: Boolean; override;
    procedure ContainerStyleChanged(Sender: TObject); override;
    procedure CursorChanged; override;
    procedure DoEditKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure EnabledChanged; override;
    procedure Initialize; override;
    function IsButtonDC(ADC: THandle): Boolean; override;
    function IsContainerClass: Boolean; override;
    procedure PropertiesChanged(Sender: TObject); override;
    procedure ReadState(Reader: TReader); override;
    function RefreshContainer(const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
      AIsMouseEvent: Boolean): Boolean; override;
{$IFDEF VCL}
    procedure CreateHandle; override;
{$ELSE}
    procedure InitWidget; override;
{$ENDIF}
    procedure ArrangeButtons; virtual;
    function GetButtonDC(AButtonIndex: Integer): THandle; virtual; abstract;
    function GetButtonIndexAt(const P: TPoint): Integer;
    function GetButtonInstance: TWinControl; virtual; abstract;
    function GetFocusedButtonIndex: Integer;
    procedure InitButtonInstance(AButton: TWinControl); virtual;
    procedure SetButtonCount(Value: Integer); virtual;
    procedure SynchronizeButtonsStyle; virtual;
    procedure UpdateButtons; virtual;
    property InternalButtons: TList read FButtons;
    property TabStop default True;
  public
    destructor Destroy; override;
    procedure ActivateByMouse(Shift: TShiftState; X, Y: Integer;
      var AEditData: TcxCustomEditData); override;
    function Focused: Boolean; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    procedure GetTabOrderList(List: TList); override;
    function IsButtonNativeStyle: Boolean;
    property AutoSize default False;
    property ActiveProperties: TcxCustomButtonGroupProperties
      read GetActiveProperties;
    property Properties: TcxCustomButtonGroupProperties read GetProperties
      write SetProperties;
  end;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  dxThemeConsts, dxThemeManager, dxUxTheme, cxEditUtils, Math;

type
  TControlAccess = class(TControl);
  TWinControlAccess = class(TWinControl);

function cxGroupBoxAlignment2GroupBoxCaption(AAlignment: TcxCaptionAlignment): TcxGroupBoxCaptionPosition;
begin
  if AAlignment in [alTopLeft, alTopCenter, alTopRight] then
    Result := cxgpTop
  else
  if AAlignment in [alBottomLeft, alBottomCenter, alBottomRight] then
    Result := cxgpBottom
  else
{$IFDEF VCL}
  if AAlignment in [alLeftTop, alLeftCenter, alLeftBottom] then
    Result := cxgpLeft
  else
  if AAlignment in [alRightTop, alRightCenter, alRightBottom] then
    Result := cxgpRight
  else
{$ENDIF}
    Result := cxgpCenter;
end;

{ TcxGroupBoxButtonViewInfo }

function TcxGroupBoxButtonViewInfo.GetGlyphRect(ACanvas: TcxCanvas; AGlyphSize: TSize; AAlignment: TLeftRight; AIsPaintCopy: Boolean): TRect;
begin
  Result.Top := Bounds.Top + (Bounds.Bottom - Bounds.Top - AGlyphSize.cy) div 2;
  Result.Bottom := Result.Top + AGlyphSize.cy;
  if AAlignment = taRightJustify then
  begin
    Result.Left := Bounds.Left;
    Result.Right := Result.Left + AGlyphSize.cx;
  end
  else
  begin
    Result.Right := Bounds.Right;
    Result.Left := Result.Right - AGlyphSize.cx;
  end;
end;

{ TcxGroupBoxViewInfo }

constructor TcxGroupBoxViewInfo.Create;
begin
  inherited Create;
  CaptionBitmap := TBitmap.Create;
  CaptionBitmap.PixelFormat := pf32bit;
  CaptionBitmapCanvas := TcxCanvas.Create(CaptionBitmap.Canvas);
end;

destructor TcxGroupBoxViewInfo.Destroy;
begin
  FreeAndNil(CaptionBitmapCanvas);
  FreeAndNil(CaptionBitmap);
  inherited Destroy;
end;

function TcxGroupBoxViewInfo.GetButtonViewInfoClass: TcxEditButtonViewInfoClass;
begin
  Result := TcxGroupBoxButtonViewInfo;
end;

procedure TcxGroupBoxViewInfo.InternalPaint(ACanvas: TcxCanvas);

  function GetThemeBackgroundRect(ACanvas: TcxCanvas): TRect;
  begin
    Result := ControlRect;
    case Edit.FAlignment of
      alTopLeft, alTopCenter, alTopRight:
        Result.Top := ACanvas.TextHeight('Qq') div 2;
      alBottomLeft, alBottomCenter, alBottomRight:
        Dec(Result.Bottom, ACanvas.TextHeight('Qq') div 2);
      alLeftTop, alLeftCenter, alLeftBottom:
        Result.Left := ACanvas.TextHeight('Qq') div 2;
      alRightTop, alRightCenter, alRightBottom:
        Dec(Result.Right, ACanvas.TextHeight('Qq') div 2);
    end;
  end;

  procedure InternalDrawNativeShape(ACanvas: TcxCanvas; const ACaptionRect: TRect);
  var
    ABackgroundRect, R: TRect;
    AClipRgn: TcxRegion;
    ANativeState: Integer;
    ATheme: TTheme;
  begin
    AClipRgn := ACanvas.GetClipRegion;
    try
      ATheme := OpenTheme(totButton);
      if Enabled then
        ANativeState := GBS_NORMAL
      else
        ANativeState := GBS_DISABLED;

      R := ControlRect;
      if Edit.IsTransparent then
        cxDrawTransparentControlBackground(Edit, ACanvas, R)
      else
        if Edit.IsNativeBackground and
          IsThemeBackgroundPartiallyTransparent(ATheme, BP_GROUPBOX, ANativeState) then
        begin
          cxDrawThemeParentBackground(Edit, ACanvas, R);
        end
        else
          cxEditFillRect(ACanvas.Handle, R, GetSolidBrush(ACanvas, BackgroundColor));

      if BorderStyle <> ebsNone then
      begin
        if Edit.FAlignment <> alCenterCenter then
          ACanvas.ExcludeClipRect(ACaptionRect);
        ABackgroundRect := GetThemeBackgroundRect(ACanvas);
        DrawThemeBackground(ATheme, ACanvas.Handle, BP_GROUPBOX, ANativeState,
          ABackgroundRect);
      end;
    finally
      ACanvas.SetClipRegion(AClipRgn, roSet);
    end;
  end;

  procedure DrawFrame(ACanvas: TcxCanvas; R: TRect);
  begin
    case BorderStyle of
      ebsSingle: ACanvas.FrameRect(R, BorderColor, 1, Edit.ActiveStyle.Edges, True);
      ebsThick: ACanvas.FrameRect(R, BorderColor, 2, Edit.ActiveStyle.Edges, True);
      ebsFlat:
        begin
          ACanvas.FrameRect(R, clBtnShadow, 1, Edit.ActiveStyle.Edges, True);
          InflateRect(R, -1, -1);
          ACanvas.FrameRect(R, clBtnHighlight, 1, Edit.ActiveStyle.Edges, True);
        end;
      ebs3D:
        if Edit.Ctl3D then
        begin
          Dec(R.Right);
          Dec(R.Bottom);
          ACanvas.FrameRect(R, clBtnShadow, 1, Edit.ActiveStyle.Edges, True);
          OffsetRect(R, 1, 1);
          ACanvas.FrameRect(R, clBtnHighlight, 1, Edit.ActiveStyle.Edges, True);
        end
        else
        begin
          ACanvas.FrameRect(R, clWindowFrame, 1, Edit.ActiveStyle.Edges, True);
          InflateRect(R, -1, -1);
          ACanvas.FrameRect(R, BackgroundColor, 1, Edit.ActiveStyle.Edges, True);
        end;
    end;
  end;

  procedure InternalDrawUsualShape(ACanvas: TcxCanvas);
  var
    AFrameRect: TRect;
    ABorderWidth: Integer;
  begin
    ABorderWidth := GetContainerBorderWidth(TcxContainerBorderStyle(BorderStyle));

    AFrameRect := BorderRect;
    ExtendRectByBorders(AFrameRect, ABorderWidth, Edges);
    DrawFrame(ACanvas, AFrameRect);

    if Shadow then
      DrawContainerShadow(ACanvas, AFrameRect);
    if Edit.IsTransparent then
      cxDrawTransparentControlBackground(Edit, ACanvas, ControlRect)
    else
      cxEditFillRect(ACanvas, ControlRect, BackgroundColor)
  end;

  procedure DrawShape;
  begin
    if NativeStyle then
      InternalDrawNativeShape(ACanvas, CaptionRect)
    else
    if Painter <> nil then
    begin
      cxDrawTransparentControlBackground(Edit, ACanvas, ControlRect);
      Painter.DrawGroupBoxContent(ACanvas, BorderRect,
        cxGroupBoxAlignment2GroupBoxCaption(Edit.Alignment));
    end  
    else
      InternalDrawUsualShape(ACanvas);
  end;

  procedure DrawCaption;
  var
    ACaptionPos: TcxGroupBoxCaptionPosition;
    AFlags, X, Y: Integer;
  begin
    if Edit.FVisibleCaption = '' then
      Exit;

    Edit.AdjustCanvasFontSettings(CaptionBitmapCanvas);
    if Painter <> nil then
    begin
      ACaptionPos := cxGroupBoxAlignment2GroupBoxCaption(Edit.Alignment);
      cxDrawTransparentControlBackground(Edit, CaptionBitmapCanvas, ControlRect);
      Painter.DrawGroupBoxBackground(CaptionBitmapCanvas, CaptionRect, CaptionRect);
      Painter.DrawGroupBoxCaption(CaptionBitmapCanvas, CaptionRect, ACaptionPos);
      CaptionBitmapCanvas.Brush.Style := bsClear;
    end
    else 
      if Edit.IsTransparentBackground then
      begin
        cxDrawTransparentControlBackground(Edit, CaptionBitmapCanvas, ControlRect);
        CaptionBitmapCanvas.Brush.Style := bsClear;
      end
      else
        CaptionBitmapCanvas.Brush.Color := BackgroundColor;

    if not Edit.IsVerticalText then
      cxDrawText(CaptionBitmapCanvas.Handle, Edit.FVisibleCaption, TextRect, Edit.GetCaptionDrawingFlags)
    else
    begin
      AFlags := ETO_CLIPPED;
      if not Edit.IsTransparentBackground and (Painter = nil) then
        AFlags := AFlags or ETO_OPAQUE;
      if Edit.FAlignment in [alLeftTop, alLeftCenter, alLeftBottom] then
      begin
        X := TextRect.Left;
        Y := TextRect.Bottom - 1;
      end
      else
      begin
        X := TextRect.Right;
        Y := TextRect.Top + 1;
      end;
      cxExtTextOut(CaptionBitmapCanvas.Handle, Edit.FVisibleCaption, Point(X, Y), TextRect, AFlags);
    end;
  end;

var
  AClipRgn: TcxRegion;
begin
  if IsInplace then
  begin
    if Edit = nil then
      inherited InternalPaint(ACanvas)
    else
      if IsCustomBackground then
        DrawBackground(ACanvas)
      else
        cxEditFillRect(ACanvas, Bounds, BackgroundColor);
    Exit;
  end;


  AClipRgn := ACanvas.GetClipRegion;
  try
    ACanvas.ExcludeClipRect(CaptionRect);
    SetWindowOrgEx(CaptionBitmap.Canvas.Handle, CaptionRect.Left,
      CaptionRect.Top, nil);
    CaptionBitmapCanvas.Canvas.Lock;
    try
      DrawShape;
      DrawCaption;
      SetWindowOrgEx(CaptionBitmap.Canvas.Handle, 0, 0, nil);
    finally
      CaptionBitmapCanvas.Canvas.Unlock;
    end;
  finally
    ACanvas.SetClipRegion(AClipRgn, roSet);
  end;
  ACanvas.CopyRect(CaptionRect, CaptionBitmap.Canvas,
    Rect(0, 0, CaptionBitmap.Width, CaptionBitmap.Height));

  if Edit.IsDBEditPaintCopyDrawing then
    DrawButtons(ACanvas);
end;

function TcxGroupBoxViewInfo.GetControlRect: TRect;
begin
  Result := cxContainer.GetControlRect(Edit);
end;

function TcxGroupBoxViewInfo.GetEdit: TcxCustomGroupBox;
begin
  Result := TcxCustomGroupBox(FEdit);
end;

{ TcxGroupBoxViewData }

procedure TcxGroupBoxViewData.Calculate(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
  AViewInfo: TcxCustomEditViewInfo; AIsMouseEvent: Boolean);
var
  AEditViewInfo: TcxGroupBoxViewInfo;
begin
  AEditViewInfo := TcxGroupBoxViewInfo(AViewInfo);
  AEditViewInfo.IsDesigning := IsDesigning;
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);
  if not IsInplace then
  begin
    Edit.CalculateCaptionFont;
    Edit.CalculateVisibleCaption;
    if Style.LookAndFeel.SkinPainter <> nil then
      CalcRects(ACanvas, AEditViewInfo)
    else
    begin
      AEditViewInfo.CaptionRect := GetCaptionRect(ACanvas);
      AEditViewInfo.TextRect := GetCaptionRect(ACanvas);
    end;
    
    with AEditViewInfo.CaptionRect do
    begin
      AEditViewInfo.CaptionBitmap.Width := Right - Left;
      AEditViewInfo.CaptionBitmap.Height := Bottom - Top;
    end;
  end;
end;

function TcxGroupBoxViewData.GetBorderColor: TColor;
begin
  if Style.BorderStyle in [ebsUltraFlat, ebsOffice11] then
  begin
    if Enabled then
      Result := GetEditBorderHighlightColor(Style.BorderStyle = ebsOffice11)
    else
      Result := clBtnShadow;
  end
  else
    Result := Style.BorderColor;
end;

function TcxGroupBoxViewData.GetBorderExtent: TRect;
var
  AHeaderSideBorderOffset: Integer;
begin
  Result := inherited GetBorderExtent;
  if not IsInplace and (Edit.FAlignment <> alCenterCenter){$IFNDEF VCL} and
    (Edit.FVisibleCaption <> ''){$ENDIF} then
  begin
    ScreenCanvas.Font := Edit.FCaptionFont;
    AHeaderSideBorderOffset := ScreenCanvas.TextHeight('Qq') div 2 - 1 +
      cxEditMaxBorderWidth;
    case Edit.FAlignment of
      alTopLeft, alTopCenter, alTopRight:
        Result.Top := AHeaderSideBorderOffset;
      alBottomLeft, alBottomCenter, alBottomRight:
        Result.Bottom := AHeaderSideBorderOffset;
{$IFDEF VCL}
      alLeftTop, alLeftCenter, alLeftBottom:
        Result.Left := AHeaderSideBorderOffset - 1;
      alRightTop, alRightCenter, alRightBottom:
        Result.Right := AHeaderSideBorderOffset - 1;
{$ENDIF}
    end;
  end;
end;

function TcxGroupBoxViewData.GetClientExtent(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomEditViewInfo): TRect;
var
  AHeaderSideClientExtent: Integer;
  ABorderRect: TRect;
begin
  if not IsInplace and (Style.LookAndFeel.SkinPainter <> nil) then
  begin
    ABorderRect := Style.LookAndFeel.SkinPainter.GroupBoxBorderSize(False,
      cxGroupBoxAlignment2GroupBoxCaption(Edit.Alignment));
    with ABorderRect do
      Result := Rect(Left + cxEditMaxBorderWidth, Top + cxEditMaxBorderWidth,
        Right + cxEditMaxBorderWidth, Bottom + cxEditMaxBorderWidth);
    if Edit.HasShadow then
    begin
      Result.Right := Result.Right + cxEditShadowWidth;
      Result.Bottom := Result.Bottom + cxEditShadowWidth;
    end;
    if Edit.FAlignment <> alCenterCenter then
    begin
    {$IFDEF VCL}
      ScreenCanvas.Font := Edit.FCaptionFont;
      AHeaderSideClientExtent := ScreenCanvas.TextHeight('Qq') +
        Result.Top + cxEditMaxBorderWidth + 1;
    {$ELSE}
      AHeaderSideClientExtent := Result.Top + Style.GetVisibleFont.Height;
    {$ENDIF}
      case Edit.FAlignment of
        alTopLeft, alTopCenter, alTopRight:
          Result.Top := AHeaderSideClientExtent;
        alBottomLeft, alBottomCenter, alBottomRight:
          Result.Bottom := AHeaderSideClientExtent;
     {$IFDEF VCL}
        alLeftTop, alLeftCenter, alLeftBottom:
          Result.Left := AHeaderSideClientExtent;
        alRightTop, alRightCenter, alRightBottom:
          Result.Right := AHeaderSideClientExtent;
     {$ENDIF}
      end;
    end;  
  end
  else
  begin
    Result := inherited GetBorderExtent;
    if not IsInplace and (Edit.FAlignment <> alCenterCenter){$IFNDEF VCL} and
      (Edit.FVisibleCaption <> ''){$ENDIF} then
    begin
      {$IFDEF VCL}
        ScreenCanvas.Font := Edit.FCaptionFont;
        AHeaderSideClientExtent := ScreenCanvas.TextHeight('Qq') +
          cxEditMaxBorderWidth + 1;
      {$ELSE}
        AHeaderSideClientExtent := Result.Top + Style.GetVisibleFont.Height;
      {$ENDIF}
      case Edit.FAlignment of
        alTopLeft, alTopCenter, alTopRight:
          Result.Top := AHeaderSideClientExtent;
        alBottomLeft, alBottomCenter, alBottomRight:
          Result.Bottom := AHeaderSideClientExtent;
    {$IFDEF VCL}
        alLeftTop, alLeftCenter, alLeftBottom:
          Result.Left := AHeaderSideClientExtent;
        alRightTop, alRightCenter, alRightBottom:
          Result.Right := AHeaderSideClientExtent;
    {$ENDIF}
       end;
    end;
  end;  
end;

function TcxGroupBoxViewData.HasShadow: Boolean;
begin
  Result := (Edit.FAlignment in [alTopLeft, alTopCenter,
    alTopRight, alLeftTop, alLeftCenter, alLeftBottom, alCenterCenter]) and
    inherited HasShadow;
end;

{$IFDEF VCL}
class function TcxGroupBoxViewData.IsNativeStyle(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := AreVisualStylesMustBeUsed(
    ALookAndFeel.NativeStyle or (ALookAndFeel.Kind = lfOffice11), totEdit) and
      (ALookAndFeel.SkinPainter = nil);
end;
{$ENDIF}

function TcxGroupBoxViewData.GetContainerState(const ABounds: TRect;
  const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
  AIsMouseEvent: Boolean): TcxContainerState;
begin
  if Enabled then
    Result := [csNormal]
  else
    Result := [csDisabled];
end;

function TcxGroupBoxViewData.GetCaptionRect(ACanvas: TcxCanvas): TRect;
const
  CaptionRectLeftBound = 8;
var
  AFlags, AShadowWidth, ATextHeight, ATextWidth: Integer;
begin
  if Edit.FVisibleCaption = '' then
  begin
    Result := cxEmptyRect;
    Exit;
  end;

  Edit.AdjustCanvasFontSettings(ACanvas);
  with ACanvas do
  begin
    ATextHeight := TextHeight('Qq');
    Result := Rect(CaptionRectLeftBound, 0, 0, ATextHeight);
    AFlags := Edit.GetCaptionDrawingFlags;
    cxDrawText(Handle, Edit.FVisibleCaption, Result, AFlags or DT_CALCRECT);
    ATextWidth := Result.Right - Result.Left;

    if Style.Shadow then
      AShadowWidth := cxContainerShadowWidth
    else
      AShadowWidth := 0;

    if not Edit.IsVerticalText then
    begin
      case Edit.FAlignment of
        alTopCenter, alBottomCenter, alCenterCenter:
          OffsetRect(Result, -Result.Left + (Edit.Width - AShadowWidth - (Result.Right - Result.Left)) div 2, 0);
        alTopRight, alBottomRight:
          OffsetRect(Result, Edit.Width - Result.Right - Result.Left - AShadowWidth, 0);
      end;
      case Edit.FAlignment of
        alBottomLeft, alBottomCenter, alBottomRight:
          begin
            Result := Rect(Result.Left, Edit.Height - Result.Top -
              (Result.Bottom - Result.Top), Result.Right, Edit.Height - Result.Top);
            OffsetRect(Result, 0, -2);
          end;
        alCenterCenter:
          OffsetRect(Result, 0, -Result.Top + (Edit.Height - AShadowWidth -
            (Result.Bottom - Result.Top)) div 2);
      end;
    end
    else
      case Edit.FAlignment of
        alLeftTop:
          begin
            Result := Rect(Result.Top - 1, Result.Left, Result.Bottom - 1, 0);
            Result.Bottom := Result.Top + ATextWidth;
          end;
        alLeftCenter:
          begin
            Result := Rect(Result.Top - 1, 0, Result.Bottom - 1,
              Edit.Height - AShadowWidth - (Edit.Height - AShadowWidth - ATextWidth) div 2);
            Result.Top := Result.Bottom - ATextWidth;
          end;
        alLeftBottom:
          begin
            Result := Rect(Result.Top - 1, 0, Result.Bottom - 1,
              Edit.Height - AShadowWidth - Result.Left);
            Result.Top := Result.Bottom - ATextWidth;
          end;
        alRightTop:
          Result := Rect(Edit.Width - Result.Bottom + 1, Result.Left,
            Edit.Width - Result.Top + 1, Result.Left + ATextWidth);
        alRightCenter:
          begin
            Result := Rect(Edit.Width - Result.Bottom + 1,
              (Edit.Height - ATextWidth) div 2, Edit.Width - Result.Top + 1, 0);
            Result.Bottom := Result.Top + ATextWidth;
          end;
        alRightBottom:
          Result := Rect(Edit.Width - Result.Bottom + 1,
            Edit.Height - Result.Left - ATextWidth, Edit.Width - Result.Top + 1,
            Edit.Height - Result.Left);
      end;
  end;
end;

function TcxGroupBoxViewData.GetEdit: TcxCustomGroupBox;
begin
  Result := TcxCustomGroupBox(FEdit);
end;

procedure TcxGroupBoxViewData.CalcRects(ACanvas: TcxCanvas;
  AEditViewInfo: TcxGroupBoxViewInfo);
var
  ABorderSize: TRect;
  ACaptionPos: TcxGroupBoxCaptionPosition;
  ATextHeight: Integer;
  ATextWidth: Integer;
begin
  with AEditViewInfo do
  begin
    Edit.AdjustCanvasFontSettings(ACanvas);
    ATextHeight := Max(ACanvas.TextHeight(Edit.FVisibleCaption),
      ACanvas.TextHeight('Qq'));
    ATextWidth := ACanvas.TextWidth(Edit.FVisibleCaption);  

    ACaptionPos := cxGroupBoxAlignment2GroupBoxCaption(Edit.Alignment);
    ABorderSize := Style.LookAndFeel.SkinPainter.GroupBoxBorderSize(True, ACaptionPos);
    case ACaptionPos of
      cxgpTop:
        begin
          CaptionRect := Rect(BorderRect.Left, ControlRect.Top, BorderRect.Right,
            ControlRect.Top + ATextHeight + ABorderSize.Top + ABorderSize.Bottom);
          BorderRect.Top := CaptionRect.Bottom;
        end;
      cxgpBottom:
        begin
          CaptionRect := Rect(BorderRect.Left,
            ControlRect.Bottom - ABorderSize.Top - ABorderSize.Bottom - ATextHeight,
            BorderRect.Right,  ControlRect.Bottom);
          BorderRect.Bottom := CaptionRect.Top;
        end;
      cxgpLeft:
        begin
          CaptionRect := Rect(ControlRect.Left, BorderRect.Top,
            ControlRect.Left + ATextHeight + ABorderSize.Left + ABorderSize.Right,
            BorderRect.Bottom);
          BorderRect.Left := CaptionRect.Right;
        end;
      cxgpRight:
        begin
          CaptionRect := Rect(ControlRect.Right - ATextHeight - ABorderSize.Right,
            BorderRect.Top, ControlRect.Right, BorderRect.Bottom);
          BorderRect.Right := CaptionRect.Left;
        end;
      cxgpCenter:
        begin
          CaptionRect.Left := (ControlRect.Right + ControlRect.Left - ATextWidth) div 2;
          CaptionRect.Top := (ControlRect.Bottom + ControlRect.Top - ATextHeight) div 2;
          CaptionRect.Bottom := CaptionRect.Top + ATextHeight;
          CaptionRect.Right := CaptionRect.Left + ATextWidth;
          BorderRect := ControlRect;
          InflateRect(BorderRect, -1, -1);
        end;
    end;
    with ABorderSize do
      TextRect := Rect(CaptionRect.Left + Left, CaptionRect.Top + Top,
        CaptionRect.Right - Right, CaptionRect.Bottom - Bottom);
    if Edit.Alignment in [alTopRight, alBottomRight] then
      TextRect.Left := TextRect.Right - ATextWidth
    else
    if Edit.Alignment in [alTopCenter, alBottomCenter] then
      TextRect.Left := (TextRect.Left + TextRect.Right - ATextWidth) div 2
    else       
    {$IFDEF VCL}
    if Edit.Alignment in [alLeftTop, alRightTop] then
      TextRect.Bottom := TextRect.Top + ATextWidth
    else
    if Edit.Alignment in [alLeftCenter, alRightCenter] then
    begin
      TextRect.Top := (TextRect.Bottom + TextRect.Top - ATextWidth) div 2;
      TextRect.Bottom := TextRect.Top + ATextWidth;
    end  
    else
    if Edit.Alignment in [alLeftBottom, alRightBottom] then
      TextRect.Top := TextRect.Bottom - ATextWidth
    else   
    {$ENDIF}
  end;
end;

{ TcxButtonGroupViewInfo }

procedure TcxButtonGroupViewInfo.DrawEditButton(ACanvas: TcxCanvas;
  AButtonVisibleIndex: Integer);
var
  AButtonViewInfo: TcxGroupBoxButtonViewInfo;
  AGlyphRect: TRect;
begin
  AButtonViewInfo := TcxGroupBoxButtonViewInfo(ButtonsInfo[AButtonVisibleIndex]);
  AGlyphRect := AButtonViewInfo.GetGlyphRect(ACanvas, GetGlyphSize,
    Alignment, IsDBEditPaintCopyDrawing);
  if not IsDBEditPaintCopyDrawing then
    DrawEditBackground(ACanvas, AButtonViewInfo.Bounds, AGlyphRect,
      IsButtonGlypthTransparent(AButtonViewInfo));
  DrawButtonGlyph(ACanvas, AButtonViewInfo, AGlyphRect);
  DrawButtonCaption(ACanvas, AButtonViewInfo, AGlyphRect);
end;

function TcxButtonGroupViewInfo.GetGlyphSize: TSize;
begin
  Result := GlyphSize;
end;

{ TcxButtonGroupViewData }

procedure TcxButtonGroupViewData.Calculate(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo,
    AIsMouseEvent);
  with TcxButtonGroupViewInfo(AViewInfo) do
  begin
    DrawTextFlags := GetDrawTextFlags;
    CaptionExtent := GetCaptionRectExtent;
  end;
end;

procedure TcxButtonGroupViewData.CalculateButtonsViewInfo(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo; AIsMouseEvent: Boolean);

  procedure CalculateButtonStates;
  var
    AButtonsCount, APrevPressedButton, I: Integer;
    AButtonViewInfo: TcxGroupBoxButtonViewInfo;
    ACapturePressing, AHoldPressing, AIsButtonPressed, AMouseButtonPressing: Boolean;
  begin
    AButtonsCount := Properties.Items.Count;
    AViewInfo.IsButtonReallyPressed := False;
    if AIsMouseEvent then
      APrevPressedButton := AViewInfo.PressedButton
    else
      APrevPressedButton := -1;
    AViewInfo.PressedButton := -1;
    AViewInfo.SelectedButton := -1;

    for I := 0 to AButtonsCount - 1 do
    begin
      AButtonViewInfo := TcxGroupBoxButtonViewInfo(AViewInfo.ButtonsInfo[I]);
      AButtonViewInfo.Index := I;
{$IFDEF VCL}
      AButtonViewInfo.Data.NativeStyle := IsButtonNativeStyle(Style.LookAndFeel);
{$ELSE}
      AButtonViewInfo.Data.NativeStyle := False;
{$ENDIF}
      AButtonViewInfo.Data.Transparent := (Self.Style.ButtonTransparency = ebtAlways) or
        (Self.Style.ButtonTransparency = ebtInactive) and not Selected;

      AButtonViewInfo.Data.BackgroundColor := AViewInfo.BackgroundColor;
      AIsButtonPressed := IsButtonPressed(AViewInfo, I);
      with AButtonViewInfo do
      begin
        if not Enabled then
          Data.State := ebsDisabled
        else
          if AIsButtonPressed or (not IsDesigning and PtInRect(AButtonViewInfo.Bounds, P)) then
          begin
            ACapturePressing := (Button = cxmbNone) and (ButtonToShift(mbLeft) *
              Shift <> []) and (Data.State = ebsNormal) and (GetCaptureButtonVisibleIndex =
              I);
            AMouseButtonPressing := (Button = ButtonTocxButton(mbLeft)) and
              ((Shift = ButtonToShift(mbLeft)) or
              (Shift = ButtonToShift(mbLeft) + [ssDouble]));
            AHoldPressing := (Data.State = ebsPressed) and (Shift * ButtonToShift(mbLeft) <> []);
            if AIsButtonPressed or AMouseButtonPressing or AHoldPressing or
                ACapturePressing then
              AViewInfo.IsButtonReallyPressed := True;
            if not AIsButtonPressed and (Shift = []) and not ACapturePressing then
            begin
              Data.State := ebsSelected;
              AViewInfo.SelectedButton := I;
            end
            else
              if (AIsButtonPressed or ACapturePressing and CanPressButton(AViewInfo, I) or ((Shift = [ssLeft]) or (Shift = [ssLeft, ssDouble])) and
                ((Button = cxmbLeft) and CanPressButton(AViewInfo, I) or
                (APrevPressedButton = I))) or AHoldPressing then
              begin
                Data.State := ebsPressed;
                AViewInfo.PressedButton := I;
              end
              else
                Data.State := ebsNormal;
          end
          else
            Data.State := ebsNormal;

{$IFDEF VCL}
      CalculateButtonNativeState(AViewInfo, AButtonViewInfo);
{$ENDIF}
      end;
    end;
  end;

var
  AButtonsCount: Integer;
begin
  AButtonsCount := Properties.Items.Count;
  TcxGroupBoxViewInfo(AViewInfo).SetButtonCount(AButtonsCount);
  if AButtonsCount = 0 then
    Exit;

  CalculateButtonViewInfos(AViewInfo);
  CalculateButtonPositions(ACanvas, AViewInfo);
  CalculateButtonStates;
end;

function TcxButtonGroupViewData.GetEditConstantPartSize(ACanvas: TcxCanvas;
  const AEditSizeProperties: TcxEditSizeProperties;
  var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo = nil): TSize;
var
  AButtonsCount, AButtonsPerColumn, AColumnsCount: Integer;
  ACaption: string;
  AColumnWidth, AMaxButtonHeight: Integer;
  ADefaultButtonHeight, AButtonHeight: Integer;
  AFlags: Integer;
  AMaxColumnWidth: Integer;
  ASizeCorrection: TSize;
  ATextWidth: Integer;
  I: Integer;
  R: TRect;
  AEditMetrics: TcxEditMetrics;
begin
  MinContentSize := Size(0, 0);
  ACanvas.Font := Style.GetVisibleFont;
  ASizeCorrection := Self.GetEditContentSizeCorrection;
  AButtonsCount := Properties.Items.Count;
  AColumnsCount := Properties.GetColumnCount;
  GetEditMetrics(AEditSizeProperties.Width >= 0, ACanvas, AEditMetrics);
  ADefaultButtonHeight := ACanvas.TextHeight('Zg') + ASizeCorrection.cy;
  if AEditSizeProperties.Width >= 0 then
  begin
    Result.cx := AEditSizeProperties.Width;
    if AButtonsCount = 0 then
      Result.cy := ADefaultButtonHeight
    else
    begin
      Result.cy := 0;
      AButtonsPerColumn := Properties.GetButtonsPerColumn;
      AColumnWidth := AEditSizeProperties.Width - ContentOffset.Left -
        ContentOffset.Right + AEditMetrics.AutoHeightWidthCorrection -
        AEditMetrics.ColumnOffset * (AColumnsCount - 1);
      AColumnWidth := AColumnWidth div AColumnsCount - AEditMetrics.ButtonSize.cx -
        AEditMetrics.AutoHeightColumnWidthCorrection;
      if AColumnWidth <= 0 then
        AColumnWidth := 1;
      AMaxButtonHeight := ADefaultButtonHeight;
      Include(PaintOptions, epoAutoHeight);
      AFlags := GetDrawTextFlags and not cxAlignVCenter or cxAlignTop;
      for I := 0 to AButtonsCount - 1 do
      begin
        R := Rect(0, 0, AColumnWidth, MaxInt);
        ACaption := Properties.Items[I].Caption;
        if Properties.WordWrap and (ACaption <> '') then
        begin
          ACanvas.TextExtent(ACaption, R, AFlags);
          AButtonHeight := R.Bottom - R.Top + ASizeCorrection.cy;
          if AMaxButtonHeight < AButtonHeight then
            AMaxButtonHeight := AButtonHeight;
        end;
      end;
      Result.cy := AMaxButtonHeight * AButtonsPerColumn;
      if not IsInplace then
      begin
        R := GetClientExtent(ACanvas, nil);
        Result.cy := Result.cy + R.Top + R.Bottom;
      end;
    end;
  end else
  begin
    if AButtonsCount = 0 then
    begin
      Result.cx := 0;
      Result.cy := ACanvas.TextHeight('Zg') + ASizeCorrection.cy;
    end else
    begin
      AMaxColumnWidth := 0;
      AButtonsPerColumn := Properties.GetButtonsPerColumn;
      for I := 0 to AButtonsCount - 1 do
      begin
        ATextWidth := ACanvas.TextWidth(Properties.Items[I].Caption);
        if ATextWidth > AMaxColumnWidth then
          AMaxColumnWidth := ATextWidth;
      end;
      Result.cx := (AMaxColumnWidth + AEditMetrics.ColumnWidthCorrection + AEditMetrics.ButtonSize.cx) *
        AColumnsCount + AEditMetrics.ColumnOffset * (AColumnsCount - 1) + AEditMetrics.WidthCorrection;
      if ADefaultButtonHeight > AEditMetrics.ButtonSize.cy then
        Result.cy := ADefaultButtonHeight
      else
        Result.cy := AEditMetrics.ButtonSize.cy;
      Result.cy := Result.cy * AButtonsPerColumn;
    end;
  end;
end;

class function TcxButtonGroupViewData.IsButtonNativeStyle(
  ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := AreVisualStylesMustBeUsed(ALookAndFeel.NativeStyle, totButton);
end;

procedure TcxButtonGroupViewData.CalculateButtonPositions(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomEditViewInfo);
var
  AButtonsCount, AButtonsPerColumn, AButtonHeight, AButtonWidth, AClientHeight,
    AColumnsCount, ATopOffset, I: Integer;
  AButtonViewInfo: TcxGroupBoxButtonViewInfo;
  AClientExtent: TRect;
  AEditMetrics: TcxEditMetrics;
begin
  AButtonsCount := Properties.Items.Count;
  AColumnsCount := Properties.GetColumnCount;
  AButtonsPerColumn := Properties.GetButtonsPerColumn;
  AClientExtent := GetClientExtent(ACanvas, AViewInfo);
  GetEditMetrics(False, nil, AEditMetrics);
  AButtonWidth := (Bounds.Right - Bounds.Left - (AClientExtent.Left +
    AClientExtent.Right) + AEditMetrics.ClientWidthCorrection -
    AEditMetrics.ColumnOffset * (AColumnsCount - 1)) div AColumnsCount;
  AClientHeight := Bounds.Bottom - Bounds.Top - AClientExtent.Top - AClientExtent.Bottom;

{$IFDEF VCL}
  ATopOffset := Bounds.Top + AClientExtent.Top + (AClientHeight mod AButtonsPerColumn) div 2;
{$ELSE}
  ATopOffset := Bounds.Top + AClientExtent.Top + 8 - (Style.GetVisibleFont.Height) div 2;
{$ENDIF}

{$IFNDEF VCL}
  if not IsInplace then
    AButtonHeight := (ABounds.Bottom - AClientExtent.Bottom - ATopOffset) div AButtonsPerColumn
  else
{$ENDIF}
    AButtonHeight := AClientHeight div AButtonsPerColumn;

  for I := 0 to AButtonsCount - 1 do
  begin
    AButtonViewInfo := TcxGroupBoxButtonViewInfo(AViewInfo.ButtonsInfo[I]);
    AButtonViewInfo.Bounds.Left := Bounds.Left + AClientExtent.Left +
      AButtonViewInfo.Column * (AButtonWidth + AEditMetrics.ColumnOffset) +
      AEditMetrics.ClientLeftBoundCorrection;
    AButtonViewInfo.Bounds.Top := ATopOffset + AButtonViewInfo.Row * AButtonHeight;
{$IFDEF VCL}
    AButtonViewInfo.Bounds.Right := AButtonViewInfo.Bounds.Left + AButtonWidth;
{$ELSE}
    if AButtonViewInfo.Bounds.Left >= ABounds.Right - AClientExtent.Right then
      AButtonViewInfo.Bounds.Right := AButtonViewInfo.Bounds.Left
    else
    begin
      AButtonViewInfo.Bounds.Right := AButtonViewInfo.Bounds.Left + AButtonWidth;
      if AButtonViewInfo.Bounds.Right > ABounds.Right - AClientExtent.Right then
        AButtonViewInfo.Bounds.Right := ABounds.Right - AClientExtent.Right;
    end;
    if AButtonViewInfo.Column = AColumnsCount - 1 then
      AButtonViewInfo.Bounds.Right := ABounds.Right - AClientExtent.Right - 1;
{$ENDIF}
    AButtonViewInfo.Bounds.Bottom := AButtonViewInfo.Bounds.Top + AButtonHeight;
    AButtonViewInfo.VisibleBounds := AButtonViewInfo.Bounds;
  end;
end;

procedure TcxButtonGroupViewData.CalculateButtonViewInfos(AViewInfo: TcxCustomEditViewInfo);

  function GetButtonStyle: TcxEditButtonStyle;
  const
    AButtonInplaceStyleMap: array[TcxLookAndFeelKind] of TcxEditButtonStyle =
      (btsFlat, bts3D, btsUltraFlat,
      btsOffice11);
    AButtonStyleMap: array [TcxEditBorderStyle] of TcxEditButtonStyle =
      (bts3D, btsFlat, btsFlat, btsFlat, bts3D, btsUltraFlat,
      btsOffice11);
  begin
    if IsInplace then
      Result := AButtonInplaceStyleMap[Style.LookAndFeel.Kind]
    else
      case Style.BorderStyle of
        ebsUltraFlat:
          Result := btsUltraFlat;
        ebsOffice11:
          Result := btsOffice11;
        else
          Result := AButtonStyleMap[AViewInfo.BorderStyle];
      end;
  end;

var
  AButtonsCount, AButtonsPerColumn, I: Integer;
  AButtonStyle: TcxEditButtonStyle;
  AButtonViewInfo: TcxGroupBoxButtonViewInfo;
begin
  AButtonStyle := GetButtonStyle;
  AButtonsCount := Properties.Items.Count;
  AButtonsPerColumn := Properties.GetButtonsPerColumn;

  for I := 0 to AButtonsCount - 1 do
  begin
    AButtonViewInfo := TcxGroupBoxButtonViewInfo(AViewInfo.ButtonsInfo[I]);
    with AButtonViewInfo do
    begin
      HasBackground := AViewInfo.HasBackground;
      Data.Style := AButtonStyle;
      Caption := Properties.FItems[I].Caption;
      Column := I div AButtonsPerColumn;
      Row := I mod AButtonsPerColumn;
    end;
  end;
end;

function TcxButtonGroupViewData.GetDrawTextFlags: Integer;
begin
  Result := cxAlignLeft or cxAlignVCenter or cxShowPrefix;
  if (epoAutoHeight in PaintOptions) and Properties.WordWrap then
  begin
    Result := Result or cxDontClip;
    Result := Result or cxWordBreak;
  end
  else
    Result := Result or cxSingleLine;
end;

function TcxButtonGroupViewData.GetCaptionRectExtent: TRect;
begin
  Result := cxEmptyRect;
end;

function TcxButtonGroupViewData.GetProperties: TcxCustomButtonGroupProperties;
begin
  Result := TcxCustomButtonGroupProperties(FProperties);
end;

{ TcxCustomGroupBoxProperties }

class function TcxCustomGroupBoxProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxCustomGroupBox;
end;

class function TcxCustomGroupBoxProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxGroupBoxViewInfo;
end;

class function TcxCustomGroupBoxProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxGroupBoxViewData;
end;

{ TcxButtonGroupItem }

constructor TcxButtonGroupItem.Create(Collection: TCollection);
begin
  if Assigned(Collection) then
    Collection.BeginUpdate;
  try
    inherited Create(Collection);
    FEnabled := True;
    DoChanged(Collection, copAdd);
  finally
    if Assigned(Collection) then
      Collection.EndUpdate;
  end;
end;

destructor TcxButtonGroupItem.Destroy;
var
  ACollection: TCollection;
  AIndex: Integer;
begin
  ACollection := Collection;
  if not IsCollectionDestroying then
    AIndex := Index
  else
    AIndex := -1;
  if Assigned(ACollection) then
    ACollection.BeginUpdate;
  try
    inherited Destroy;
    DoChanged(ACollection, copDelete, AIndex);
  finally
    if Assigned(ACollection) then
      ACollection.EndUpdate;
  end;
end;

procedure TcxButtonGroupItem.Assign(Source: TPersistent);
begin
  if Source is TcxButtonGroupItem then
    with TcxButtonGroupItem(Source) do
    begin
      Self.Caption := Caption;
      Self.Enabled := Enabled;
      Self.Tag := Tag;
    end
  else
    inherited Assign(Source);
end;

function TcxButtonGroupItem.GetCaption: TCaption;
begin
  Result := FCaption;
end;

procedure TcxButtonGroupItem.DoChanged(ACollection: TCollection;
  ACollectionOperation: TcxCollectionOperation; AIndex: Integer = -1);
begin
  if Assigned(ACollection) then
    if AIndex = -1 then
      TcxButtonGroupItems(ACollection).InternalNotify(Self, AIndex, ACollectionOperation)
    else
      TcxButtonGroupItems(ACollection).InternalNotify(nil, AIndex, ACollectionOperation);
end;

function TcxButtonGroupItem.GetIsCollectionDestroying: Boolean;
begin
  Result := (Collection <> nil) and TcxButtonGroupItems(Collection).IsDestroying;
end;

function TcxButtonGroupItem.IsTagStored: Boolean;
begin
  Result := FTag <> 0;
end;

procedure TcxButtonGroupItem.SetCaption(const Value: TCaption);
begin
  if Value <> FCaption then
  begin
    FCaption := Value;
    DoChanged(Collection, copChanged);
  end;
end;

procedure TcxButtonGroupItem.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    DoChanged(Collection, copChanged);
  end;
end;

{ TcxButtonGroupItems }

destructor TcxButtonGroupItems.Destroy;
begin
  FIsDestroying := True;
  inherited Destroy;
end;

procedure TcxButtonGroupItems.InternalNotify(AItem: TcxButtonGroupItem;
  AItemIndex: Integer; AItemOperation: TcxCollectionOperation);
begin
  if TcxCustomEditProperties(GetOwner).ChangedLocked or IsDestroying then
    Exit;
  if AItem <> nil then
    FChangedItemIndex := AItem.Index
  else
    FChangedItemIndex := AItemIndex;
  FChangedItemOperation := AItemOperation;
  FItemChanged := True;
  try
    TcxCustomEditProperties(GetOwner).Changed;
  finally
    FItemChanged := False;
  end;
end;

procedure TcxButtonGroupItems.Update(Item: TCollectionItem);
begin
  TcxCustomEditProperties(GetOwner).Changed;
end;

function TcxButtonGroupItems.GetItem(Index: Integer): TcxButtonGroupItem;
begin
  Result := TcxButtonGroupItem(inherited Items[Index]);
end;

procedure TcxButtonGroupItems.SetItem(Index: Integer; Value: TcxButtonGroupItem);
begin
  inherited Items[Index] := Value;
end;

function TcxButtonGroupItems.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TcxButtonGroupItems._AddRef: Integer;
begin
  Result := -1;
end;

function TcxButtonGroupItems._Release: Integer;
begin
  Result := -1;
end;

function TcxButtonGroupItems.CheckItemsGetCaption(Index: Integer): string;
begin
  Result := TcxButtonGroupItem(Items[Index]).Caption;
end;

function TcxButtonGroupItems.CheckItemsGetCount: Integer;
begin
  Result := Count;
end;

{ TcxCustomButtonGroupProperties }

constructor TcxCustomButtonGroupProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FColumns := 1;
  FItems := CreateItems;
end;

destructor TcxCustomButtonGroupProperties.Destroy;
begin
  BeginUpdate;
  try
    FreeAndNil(FItems);
  finally
    EndUpdate(False);
  end;
  inherited Destroy;
end;

procedure TcxCustomButtonGroupProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomButtonGroupProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomButtonGroupProperties do
      begin
        Self.Columns := Columns;
        Self.Items := Items;
        Self.WordWrap := WordWrap;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomButtonGroupProperties.CreatePreviewProperties: TcxCustomEditProperties;
const
  AItemCaptions: array [0..2] of string = ('A', 'B', 'C');
var
  I: Integer;
begin
  Result := inherited CreatePreviewProperties;
  for I := 0 to High(AItemCaptions) do
    TcxButtonGroupItem(TcxCustomButtonGroupProperties(Result).Items.Add).Caption := AItemCaptions[I];
  TcxCustomButtonGroupProperties(Result).Columns := 3;
end;

class function TcxCustomButtonGroupProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxCustomButtonGroup;
end;

function TcxCustomButtonGroupProperties.GetSpecialFeatures: TcxEditSpecialFeatures;
begin
  Result := inherited GetSpecialFeatures + [esfMinSize];
end;

function TcxCustomButtonGroupProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := [esoAlwaysHotTrack, esoAutoHeight, esoEditing, esoFiltering,
    esoShowingCaption, esoSorting, esoTransparency];
  if Items.Count > 0 then
    Include(Result, esoHotTrack);
end;

class function TcxCustomButtonGroupProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxButtonGroupViewInfo;
end;

class function TcxCustomButtonGroupProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxButtonGroupViewData;
end;

function TcxCustomButtonGroupProperties.GetColumnCount: Integer;
var
  AButtonCount, AButtonsPerColumn: Integer;
begin
  Result := Columns;
  AButtonCount := Items.Count;
  if Result > AButtonCount then
    Result := AButtonCount;
  if AButtonCount > 0 then
  begin
    if Result = 0 then
      Result := 1;
    AButtonsPerColumn := (AButtonCount + Result - 1) div Result;
    Result := (AButtonCount + AButtonsPerColumn - 1) div AButtonsPerColumn;
  end;
end;

function TcxCustomButtonGroupProperties.CreateItems: TcxButtonGroupItems;
begin
  Result := TcxButtonGroupItems.Create(Self, TcxButtonGroupItem);
end;

function TcxCustomButtonGroupProperties.GetButtonsPerColumn: Integer;
var
  AColumnsCount: Integer;
begin
  AColumnsCount := GetColumnCount;
  Result := (Items.Count + AColumnsCount - 1) div AColumnsCount;
end;

procedure TcxCustomButtonGroupProperties.SetColumns(Value: Integer);
begin
  if Value < 1 then
    Value := 1;
  if Value <> FColumns then
  begin
    FColumns := Value;
    Changed;
  end;
end;

procedure TcxCustomButtonGroupProperties.SetItems(Value: TcxButtonGroupItems);
begin
  FItems.Assign(Value);
end;

procedure TcxCustomButtonGroupProperties.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

{ TcxCustomGroupBox }

{$IFDEF CBUILDER10}
constructor TcxCustomGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

destructor TcxCustomGroupBox.Destroy;
begin
  FreeAndNil(FCaptionFont);
  inherited Destroy;
end;

class function TcxCustomGroupBox.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomGroupBoxProperties;
end;

procedure TcxCustomGroupBox.CalculateVisibleCaption;
begin
  if IsVerticalText then
    FVisibleCaption := RemoveAccelChars(Caption)
  else
    FVisibleCaption := Caption;
end;

function TcxCustomGroupBox.GetColor: TColor;
begin
  Result := Style.Color;
end;

function TcxCustomGroupBox.GetFont: TFont;
begin
  Result := Style.GetVisibleFont;
end;

procedure TcxCustomGroupBox.SetAlignment(Value: TcxCaptionAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    CalculateCaptionFont;
    CalculateVisibleCaption;
    ShortRefreshContainer(False);
    Realign;
  end;
end;

procedure TcxCustomGroupBox.SetColor(Value: TColor);
begin
  Style.Color := Value;
end;

procedure TcxCustomGroupBox.SetFont(Value: TFont);
begin
  Style.Font := Value;
end;

{$IFNDEF DELPHI7}
procedure TcxCustomGroupBox.WMPrintClient(var Message: TMessage);
begin
  if (Message.Result <> 1) and
    ((Message.LParam and PRF_CHECKVISIBLE = 0) or Visible) then
      PaintHandler(TWMPaint(Message))
  else
    inherited;
end;
{$ENDIF}

procedure TcxCustomGroupBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      FIsAccelCharHandling := True;
      try
        SelectFirst;
        Result := 1;
      finally
        FIsAccelCharHandling := False;
      end;
    end
    else
      inherited;
end;

procedure TcxCustomGroupBox.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  Invalidate;
end;

procedure TcxCustomGroupBox.AdjustClientRect(var Rect: TRect);
var
  AViewData: TcxCustomEditViewData;
begin
  if IsDestroying then
    Exit;
  AViewData := TcxCustomEditViewData(CreateViewData);
  try
    InitializeViewData(AViewData);
    Rect := GetControlRect(Self);
    ExtendRect(Rect, AViewData.GetClientExtent(Canvas, ViewInfo));
  finally
    FreeAndNil(AViewData);
  end;
end;

function TcxCustomGroupBox.CanAutoSize: Boolean;
begin
  Result := False;
end;

function TcxCustomGroupBox.CanFocusOnClick: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGroupBox.ContainerStyleChanged(Sender: TObject);
begin
  CalculateCaptionFont;
  inherited ContainerStyleChanged(Sender);
end;

function TcxCustomGroupBox.DefaultParentColor: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGroupBox.FontChanged;
begin
  inherited FontChanged;
  Realign;
end;

function TcxCustomGroupBox.GetShadowBounds: TRect;
begin
  Result := inherited GetShadowBounds;
  case Alignment of
    alTopLeft, alTopCenter, alTopRight:
      Result.Top := 0;
    alBottomLeft, alBottomCenter, alBottomRight:
      Result.Bottom := Height;
{$IFDEF VCL}
    alLeftTop, alLeftCenter, alLeftBottom:
      Result.Left := 0;
    alRightTop, alRightCenter, alRightBottom:
      Result.Right := Width;
{$ENDIF}
  end;
end;

procedure TcxCustomGroupBox.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle + [csAcceptsControls, csCaptureMouse, csClickEvents];
  SetBounds(Left, Top, 185, 105);
  FCaptionFont := TFont.Create;
  CalculateCaptionFont;
  TabStop := False;
end;

function TcxCustomGroupBox.InternalGetActiveStyle: TcxContainerStyle;
begin
  if csDisabled in ViewInfo.ContainerState then
    Result := FStyles.StyleDisabled
  else
    Result := FStyles.Style;
end;

function TcxCustomGroupBox.InternalGetNotPublishedStyleValues: TcxEditStyleValues;
begin
  Result := inherited InternalGetNotPublishedStyleValues;
  Include(Result, svHotTrack);
end;

function TcxCustomGroupBox.IsContainerClass: Boolean;
begin
  Result := True;
end;

function TcxCustomGroupBox.IsNativeBackground: Boolean;
begin
  Result := IsNativeStyle and ParentBackground and not IsInplace and
    not Transparent;
end;

procedure TcxCustomGroupBox.TextChanged;
begin
  inherited TextChanged;
  CalculateVisibleCaption;
  ShortRefreshContainer(False);
end;

procedure TcxCustomGroupBox.AdjustCanvasFontSettings(ACanvas: TcxCanvas);
{$IFDEF VCL}
var
  AColor: TColorRef;
  ANativeState: Integer;
  ATheme: TTheme;
{$ENDIF}
begin
  with ACanvas do
  begin
    Font := FCaptionFont;
{$IFDEF VCL}
    if IsNativeStyle then
    begin
      ATheme := OpenTheme(totButton);
      if Enabled then
        ANativeState := GBS_NORMAL
      else
        ANativeState := GBS_DISABLED;
      GetThemeColor(ATheme, BP_GROUPBOX, ANativeState, TMT_TEXTCOLOR, AColor);
      Font.Color := AColor;
    end;
{$ENDIF}
  end;
end;

procedure TcxCustomGroupBox.CalculateCaptionFont;
{$IFDEF VCL}
var
  AFontEscapement: Longint;
  ALogFont: TLogFont;
  ATextMetric : TTextMetric;
{$ENDIF}
begin
  if IsInplace then
    Exit;
  FCaptionFont.Assign(ActiveStyle.GetVisibleFont);
{$IFDEF VCL}
  if IsVerticalText then
  begin
    ScreenCanvas.Font := FCaptionFont;
    GetTextMetrics(ScreenCanvas.Handle, ATextMetric);
    if ATextMetric.tmPitchAndFamily and TMPF_TRUETYPE = 0 then
      FCaptionFont.Name := 'Arial';

    if FAlignment in [alLeftTop, alLeftCenter, alLeftBottom] then
      AFontEscapement := 900
    else
      AFontEscapement := 2700;
    cxGetFontData(FCaptionFont.Handle, ALogFont);
    if AFontEscapement <> ALogFont.lfEscapement then
    begin
      ALogFont.lfEscapement := AFontEscapement;
      ALogFont.lfOrientation := AFontEscapement;
      ALogFont.lfOutPrecision := OUT_TT_ONLY_PRECIS;
      FCaptionFont.Handle := CreateFontIndirect(ALogFont);
    end;
  end;
{$ENDIF}
end;

function TcxCustomGroupBox.GetCaptionDrawingFlags: Integer;
begin
  Result := DrawTextBiDiModeFlags(DT_SINGLELINE);
  if IsVerticalText then
    Result := Result or DT_NOPREFIX;
end;

function TcxCustomGroupBox.IsVerticalText: Boolean;
begin
{$IFDEF VCL}
  Result := FAlignment in [alLeftTop, alLeftCenter, alLeftBottom, alRightTop,
    alRightCenter, alRightBottom];
{$ELSE}
  Result := False;
{$ENDIF}
end;

{ TcxCustomButtonGroup }

destructor TcxCustomButtonGroup.Destroy;
begin
  SetButtonCount(0);
  FreeAndNil(FButtons);
  inherited Destroy;
end;

procedure TcxCustomButtonGroup.ActivateByMouse(Shift: TShiftState; X, Y: Integer;
  var AEditData: TcxCustomEditData);
var
  P: TPoint;
  AButtonIndex: Integer;
begin
  Activate(AEditData);
  P := Parent.ClientToScreen(Point(X, Y));
  P := ScreenToClient(P);
  AButtonIndex := GetButtonIndexAt(P);
  if AButtonIndex <> -1 then
  begin
    with ViewInfo.ButtonsInfo[AButtonIndex].Bounds do
    begin
      P.X := (Right - Left) div 2;
      P.Y := (Bottom - Top) div 2;
    end;
    if ssLeft in Shift then
      SendMessage(TWinControl(FButtons[AButtonIndex]).Handle, WM_LBUTTONDOWN,
        ShiftStateToKeys(Shift), P.Y shl 16 + P.X)
    else
      SendMessage(TWinControl(FButtons[AButtonIndex]).Handle, WM_LBUTTONUP,
        ShiftStateToKeys(Shift), P.Y shl 16 + P.X);
  end;
end;

function TcxCustomButtonGroup.Focused: Boolean;
var
  I: Integer;
begin
  Result := inherited Focused;
  if not Result and not FIsCreating then
    for I := 0 to FButtons.Count - 1 do
      if TWinControl(FButtons[I]).Focused then
      begin
        Result := True;
        Break;
      end;
end;

class function TcxCustomButtonGroup.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomButtonGroupProperties;
end;

procedure TcxCustomButtonGroup.GetTabOrderList(List: TList);
begin
  if IsInplace and Visible then
    List.Remove(Parent);
end;

function TcxCustomButtonGroup.IsButtonNativeStyle: Boolean;
begin
  Result := TcxButtonGroupViewDataClass(Properties.GetViewDataClass).IsButtonNativeStyle(Style.LookAndFeel);
end;

procedure TcxCustomButtonGroup.PropertiesChanged(Sender: TObject);
begin
  if not (csReading in ComponentState) then
    UpdateButtons;
  inherited PropertiesChanged(Sender);
end;

procedure TcxCustomButtonGroup.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  UpdateButtons;
  SynchronizeDisplayValue;
end;

function TcxCustomButtonGroup.CanAutoSize: Boolean;
begin
  Result := not IsInplace and AutoSize;
end;

procedure TcxCustomButtonGroup.ContainerStyleChanged(Sender: TObject);
begin
  inherited ContainerStyleChanged(Sender);
  if not FIsCreating then
    UpdateButtons;
end;

procedure TcxCustomButtonGroup.CursorChanged;
begin
  UpdateButtons;
end;

procedure TcxCustomButtonGroup.DoEditKeyDown(var Key: Word; Shift: TShiftState);
var
  AButtonsInColumn, AButtonsPerColumn: Integer;
  AFocusedButtonIndex: Integer;
  AColumn, ARow: Integer;
begin
  AFocusedButtonIndex := GetFocusedButtonIndex;
  if AFocusedButtonIndex = -1 then
    Exit;
  AButtonsPerColumn := ActiveProperties.GetButtonsPerColumn;
  AButtonsInColumn := AButtonsPerColumn;
  with TcxGroupBoxButtonViewInfo(ViewInfo.ButtonsInfo[AFocusedButtonIndex]) do
  begin
    AColumn := Column;
    ARow := Row;
  end;
  if AFocusedButtonIndex - ARow + AButtonsInColumn - 1 >= ActiveProperties.Items.Count then
    AButtonsInColumn := ActiveProperties.Items.Count - (AFocusedButtonIndex - ARow);
  case Key of
    VK_DOWN:
      if ARow < AButtonsInColumn - 1 then
      begin
        TWinControl(FButtons[AFocusedButtonIndex + 1]).SetFocus;
        Key := 0;
      end;
    VK_LEFT:
      if AColumn > 0 then
      begin
        TWinControl(FButtons[AFocusedButtonIndex - AButtonsPerColumn]).SetFocus;
        Key := 0;
      end;
    VK_RIGHT:
      if AFocusedButtonIndex + AButtonsPerColumn < FButtons.Count then
      begin
        TWinControl(FButtons[AFocusedButtonIndex + AButtonsPerColumn]).SetFocus;
        Key := 0;
      end;
    VK_UP:
      if ARow > 0 then
      begin
        TWinControl(FButtons[AFocusedButtonIndex - 1]).SetFocus;
        Key := 0;
      end
  end;
  inherited DoEditKeyDown(Key, Shift);
end;

procedure TcxCustomButtonGroup.EnabledChanged;
begin
  inherited EnabledChanged;
  UpdateButtons;
end;

procedure TcxCustomButtonGroup.Initialize;
begin
  inherited Initialize;
  FButtons := TList.Create;
  AutoSize := False;
  TabStop := True;
end;

function TcxCustomButtonGroup.IsButtonDC(ADC: THandle): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to InternalButtons.Count - 1 do
    if GetButtonDC(I) = ADC then
    begin
      Result := True;
      Break;
    end;
end;

function TcxCustomButtonGroup.IsContainerClass: Boolean;
begin
  Result := FIsAccelCharHandling;
end;

function TcxCustomButtonGroup.RefreshContainer(const P: TPoint;
  Button: TcxMouseButton; Shift: TShiftState; AIsMouseEvent: Boolean): Boolean;
begin
  Result := inherited RefreshContainer(P, Button, Shift, AIsMouseEvent);
  ArrangeButtons;
  SynchronizeButtonsStyle;
end;

{$IFDEF VCL}
procedure TcxCustomButtonGroup.CreateHandle;
begin
  inherited CreateHandle;
  UpdateButtons;
  SynchronizeDisplayValue;
end;
{$ELSE}

procedure TcxCustomButtonGroup.InitWidget;
begin
  inherited InitWidget;
  UpdateButtons;
end;
{$ENDIF}

procedure TcxCustomButtonGroup.ArrangeButtons;
var
  AButtonViewInfo: TcxGroupBoxButtonViewInfo;
  I: Integer;
  R: TRect;
begin
  for I := 0 to FButtons.Count - 1 do
    with TWinControl(FButtons[I]) do
    begin
      AButtonViewInfo := TcxGroupBoxButtonViewInfo(ViewInfo.ButtonsInfo[I]);
      R := AButtonViewInfo.Bounds;
      SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
    end;
end;

function TcxCustomButtonGroup.GetButtonIndexAt(const P: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ActiveProperties.Items.Count - 1 do
    if PtInRect(ViewInfo.ButtonsInfo[I].Bounds, P) then
    begin
      Result := I;
      Break;
    end;
end;

function TcxCustomButtonGroup.GetFocusedButtonIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ActiveProperties.Items.Count - 1 do
    if TWinControl(FButtons[I]).Focused then
    begin
      Result := I;
      Break;
    end;
end;

procedure TcxCustomButtonGroup.InitButtonInstance(AButton: TWinControl);
begin
  TControlAccess(AButton).ParentShowHint := False;
  AButton.Parent := Self;

  TControlAccess(AButton).OnDragDrop := DoButtonDragDrop;
  TControlAccess(AButton).OnDragOver := DoButtonDragOver;
  TWinControlAccess(AButton).OnKeyDown := DoButtonKeyDown;
  TWinControlAccess(AButton).OnKeyPress := DoButtonKeyPress;
  TWinControlAccess(AButton).OnKeyUp := DoButtonKeyUp;
  TControlAccess(AButton).OnMouseDown := DoButtonMouseDown;
  TControlAccess(AButton).OnMouseMove := DoButtonMouseMove;
  TControlAccess(AButton).OnMouseUp := DoButtonMouseUp;
  {$IFDEF DELPHI6}
  TControlAccess(AButton).OnMouseWheel := DoButtonMouseWheel;
  {$ELSE}
  TWinControlAccess(AButton).OnMouseWheel := DoButtonMouseWheel;
  {$ENDIF}
end;

procedure TcxCustomButtonGroup.SetButtonCount(Value: Integer);
begin
  with ActiveProperties.Items do
    if ItemChanged then
    begin
      if ChangedItemOperation = copAdd then
        InitButtonInstance(GetButtonInstance)
      else
        if ChangedItemOperation = copDelete then
          TWinControl(FButtons[ChangedItemIndex]).Free;
    end
    else
      if Value <> FButtons.Count then
        if Value < FButtons.Count then
          while FButtons.Count > Value do
            TWinControl(FButtons.Last).Free
        else
          while FButtons.Count < Value do
            InitButtonInstance(GetButtonInstance);
end;

procedure TcxCustomButtonGroup.SynchronizeButtonsStyle;
var
  AButton: TWinControlAccess;
  ATempFont: TFont;
  I: Integer;
begin
  ATempFont := TFont.Create;
  try
    for I := 0 to FButtons.Count - 1 do
    begin
      AButton := TWinControlAccess(FButtons[I]);
      AButton.Color := ActiveStyle.Color;
      ATempFont.Assign(Style.GetVisibleFont);
      ATempFont.Color := ActiveStyle.GetVisibleFont.Color;
      AssignFonts(AButton.Font, ATempFont);
    end;
  finally
    ATempFont.Free;
  end;
end;

procedure TcxCustomButtonGroup.UpdateButtons;
var
  AButton: TWinControl;
  I: Integer;
begin
  SetButtonCount(ActiveProperties.Items.Count);
  for I := 0 to FButtons.Count - 1 do
  begin
    AButton := TWinControl(FButtons[I]);
    AButton.Enabled := Enabled and ActiveProperties.Items[I].Enabled;
  end;
  ShortRefreshContainer(False);
  for I := 0 to FButtons.Count - 1 do
  begin
    AButton := TWinControl(FButtons[I]);
    AButton.Cursor := Cursor;
  end;
end;

procedure TcxCustomButtonGroup.DoButtonDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  with TWinControl(Sender) do
    Self.DragDrop(Source, Left + X, Top + Y);
end;

procedure TcxCustomButtonGroup.DoButtonDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  with TWinControl(Sender) do
    Self.DragOver(Source, Left + X, Top + Y, State, Accept);
end;

procedure TcxCustomButtonGroup.DoButtonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift);
end;

procedure TcxCustomButtonGroup.DoButtonKeyPress(Sender: TObject; var Key: Char);
begin
  KeyPress(Key);
end;

procedure TcxCustomButtonGroup.DoButtonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyUp(Key, Shift);
end;

procedure TcxCustomButtonGroup.DoButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  InnerControlMouseDown := True;
  try
    with TWinControl(Sender) do
      Self.MouseDown(Button, Shift, X + Left, Y + Top);
  finally
    InnerControlMouseDown := False;
  end;
end;

procedure TcxCustomButtonGroup.DoButtonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  with TWinControl(Sender) do
    Self.MouseMove(Shift, X + Left, Y + Top);
end;

procedure TcxCustomButtonGroup.DoButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with TWinControl(Sender) do
    Self.MouseUp(Button, Shift, X + Left, Y + Top);
end;

procedure TcxCustomButtonGroup.DoButtonMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; {$IFNDEF VCL}const{$ENDIF} MousePos: TPoint; var Handled: Boolean);
begin
  Handled := False;
end;

function TcxCustomButtonGroup.GetProperties: TcxCustomButtonGroupProperties;
begin
  Result := TcxCustomButtonGroupProperties(FProperties);
end;

function TcxCustomButtonGroup.GetActiveProperties: TcxCustomButtonGroupProperties;
begin
  Result := TcxCustomButtonGroupProperties(InternalGetActiveProperties);
end;

procedure TcxCustomButtonGroup.SetProperties(Value: TcxCustomButtonGroupProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomButtonGroup.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if not IsDestroying and IsTransparentBackground then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

end.
