
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

unit cxLabel;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, Variants,
{$ENDIF}
  Windows, Classes, Controls, Forms, Graphics, Messages, SysUtils, cxClasses,
  cxContainer, cxControls, cxCustomData, cxDataUtils, cxEdit, cxExtEditConsts,
  cxGraphics, cxTextEdit, cxVariants;

type
  TcxLabelEffect = (cxleNormal, cxleFun, cxleExtrude, cxleCool);
  TcxLabelStyle = (cxlsNormal, cxlsRaised, cxlsLowered, cxlsOutLine);
  TcxLabelOrientation = (cxoLeft, cxoRight, cxoTop, cxoBottom, cxoLeftTop,
    cxoLeftBottom, cxoRightTop, cxoRightBottom);

  { TcxLabelEditStyle }

  TcxLabelEditStyle = class(TcxEditStyle)
  protected
    function DefaultBorderStyle: TcxContainerBorderStyle; override;
    function DefaultHotTrack: Boolean; override;
  end;

  { TcxCustomLabelViewInfo }

  TcxCustomLabelViewInfo = class(TcxCustomTextEditViewInfo)
  private
    FAlignment: TcxEditAlignment;
    FAngle: Integer;
    FDepth: Word;
    FDepthDeltaSize: TSize;
    FDrawBitmap: TBitmap;
    FGlyph: TBitmap;
    FIsDrawBitmapDirty: Boolean;
    FInplaceOffset: TPoint;
    FLabelEffect: TcxLabelEffect;
    FLabelStyle: TcxLabelStyle;
    FLabelTextRect: TRect;
    FOrientation: TcxLabelOrientation;
    FPenWidth: Integer;
    FShadowedColor: TColor;
    FWordWrap: Boolean;
  protected
    procedure SetBackgroundColor(Value: TColor); override;
    property Alignment: TcxEditAlignment read FAlignment write FAlignment;
    property LabelEffect: TcxLabelEffect read FLabelEffect write FLabelEffect;
    property LabelStyle: TcxLabelStyle read FLabelStyle write FLabelStyle;
    property Orientation: TcxLabelOrientation read FOrientation write FOrientation;
    property Depth: Word read FDepth write FDepth;
    property DepthDeltaSize: TSize read FDepthDeltaSize write FDepthDeltaSize;
    property ShadowedColor: TColor read FShadowedColor write FShadowedColor;
    property Angle: Integer read FAngle write FAngle;
    property PenWidth: Integer read FPenWidth write FPenWidth;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property Glyph: TBitmap read FGlyph write FGlyph;
    property LabelTextRect: TRect read FLabelTextRect write FLabelTextRect;
  public
    DrawTextOffsets: TRect;
    FocusRect: TRect;
    HasGlyph: Boolean;
    LeftTop: TPoint;
    ShowAccelChar: Boolean;
    constructor Create; override;
    destructor Destroy; override;
    procedure Offset(DX, DY: Integer); override;
    procedure Paint(ACanvas: TcxCanvas); override;
    procedure DrawLabel(ACanvas: TcxCanvas); virtual;
  end;

  { TcxCustomLabelViewData }

  TcxCustomLabelProperties = class;

  TcxCustomLabelViewData = class(TcxCustomEditViewData)
  private
    function GetProperties: TcxCustomLabelProperties;
    procedure CalculateLabelViewInfoProps(AViewInfo: TcxCustomEditViewInfo);
  protected
    function GetDrawTextFlags: Integer; virtual;
    function GetIsEditClass: Boolean;
    function InternalEditValueToDisplayText(AEditValue: TcxEditValue): string; override;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    procedure EditValueToDrawValue(ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
      AViewInfo: TcxCustomEditViewInfo); override;
    function GetEditContentSize(ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
      const AEditSizeProperties: TcxEditSizeProperties): TSize; override;
    property Properties: TcxCustomLabelProperties read GetProperties;
  end;

  { TcxCustomLabelProperties }

  TcxCustomLabelProperties = class(TcxCustomEditProperties)
  private
    FLabelEffect: TcxLabelEffect;
    FLabelStyle: TcxLabelStyle;
    FOrientation: TcxLabelOrientation;
    FDepth: Word;
    FShadowedColor: TColor;
    FShowAccelChar: Boolean;
    FShowEndEllipsis: Boolean; // deprecated
    FAngle: Integer;
    FPenWidth: Integer;
    FGlyph: TBitmap;
    FWordWrap: Boolean;
    procedure SetLabelEffect(Value : TcxLabelEffect);
    procedure SetLabelStyle(Value : TcxLabelStyle);
    procedure SetOrientation(Value : TcxLabelOrientation);
    procedure SetDepth(Value : Word);
    procedure SetShadowedColor(Value : TColor);
    procedure SetAngle(Value: Integer);
    procedure SetPenWidth(Value: Integer);
    function GetGlyph: TBitmap;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetWordWrap(Value: Boolean);
  protected
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    function HasDisplayValue: Boolean; override;
    function CalculateDepthDelta: TSize; virtual;
    function GetDisplayFormatOptions: TcxEditDisplayFormatOptions; override;
    property ShowEndEllipsis: Boolean read FShowEndEllipsis
      write FShowEndEllipsis stored False; // deprecated
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CanCompareEditValue: Boolean; override;
    class function GetContainerClass: TcxContainerClass; override;
    class function GetStyleClass: TcxCustomEditStyleClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    function IsEditValueValid(var EditValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
    procedure PrepareDisplayValue(const AEditValue: TcxEditValue;
      var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
    function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
    // !!!
    property Angle: Integer read FAngle write SetAngle default 0;
    property Depth: Word read FDepth write SetDepth default 0;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property LabelEffect: TcxLabelEffect read FLabelEffect
      write SetLabelEffect default cxleNormal;
    property LabelStyle: TcxLabelStyle read FLabelStyle
      write SetLabelStyle default cxlsNormal;
    property Orientation: TcxLabelOrientation read FOrientation
      write SetOrientation default cxoRightBottom;
    property PenWidth: Integer read FPenWidth write SetPenWidth default 1;
    property ShadowedColor: TColor read FShadowedColor
      write SetShadowedColor default clGrayText;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar
      default True;
    property Transparent; // deprecated
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;

  { TcxLabelProperties }

  TcxLabelProperties = class(TcxCustomLabelProperties)
  published
    property Alignment;
    property Angle;
    property Depth;
    property Glyph;
    property LabelEffect;
    property LabelStyle;
    property Orientation;
    property PenWidth;
    property ShadowedColor;
    property ShowAccelChar;
    property ShowEndEllipsis; // deprecated
    property Transparent; // deprecated
    property WordWrap;
  end;

  { TcxCustomLabel }

  TcxCustomLabel = class(TcxCustomEdit)
  private
    FFocusControl: TWinControl;
    FLockCaption: Boolean;
    function GetProperties: TcxCustomLabelProperties;
    function GetActiveProperties: TcxCustomLabelProperties;
    function GetStyle: TcxLabelEditStyle;
    function GetViewInfo: TcxCustomLabelViewInfo;
    procedure SetProperties(Value: TcxCustomLabelProperties);
    procedure SetStyle(Value: TcxLabelEditStyle);
    procedure SetFocusControl(Value: TWinControl);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure Initialize; override;
    procedure InternalSetEditValue(const Value: TcxEditValue; AValidateEditValue: Boolean); override;
    procedure SetInternalDisplayValue(Value: TcxEditValue); override;
    procedure TextChanged; override;
    function CanAutoWidth: Boolean; override;
    function CanFocusOnClick: Boolean; override;
    function DefaultParentColor: Boolean; override;
    procedure Notification(ACOmponent: TComponent; Operation: TOperation); override;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ViewInfo: TcxCustomLabelViewInfo read GetViewInfo;
  public
    destructor Destroy; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    function CanFocus: Boolean; override;
  {$IFDEF DELPHI10}
    function GetTextBaseLine: Integer; override;
    function HasTextBaseLine: Boolean; override;
  {$ENDIF}
    property ActiveProperties: TcxCustomLabelProperties
      read GetActiveProperties;
    property Caption;
    property Properties: TcxCustomLabelProperties read GetProperties
      write SetProperties;
    property Style: TcxLabelEditStyle read GetStyle write SetStyle;
    property TabOrder stored False;
    property Transparent;
  end;

  { TcxCustomLabel }

  TcxLabel = class(TcxCustomLabel)
  private
    function GetActiveProperties: TcxLabelProperties;
    function GetProperties: TcxLabelProperties;
    procedure SetProperties(Value: TcxLabelProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxLabelProperties read GetActiveProperties;
  published
    property Align;
    property Anchors;
    property AutoSize;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxLabelProperties read GetProperties
      write SetProperties;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property Transparent;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  Math, cxEditConsts, cxEditPaintUtils, cxEditUtils, cxExtEditUtils,
  cxFilterControlUtils, dxThemeConsts, dxThemeManager, dxUxTheme;

const
  TextFromBorderOffset = 1;

procedure CalculateCustomLabelViewInfo(ACanvas: TcxCanvas; AViewData: TcxCustomLabelViewData;
  AViewInfo: TcxCustomLabelViewInfo);

  procedure CheckFocusRectBounds;
  begin
    with AViewInfo do
    begin
      if FocusRect.Left < TextRect.Left - 1 then
        FocusRect.Left := TextRect.Left - 1;
      if FocusRect.Top < TextRect.Top - 1 then
        FocusRect.Top := TextRect.Top - 1;
      if FocusRect.Right > TextRect.Right + 1 then
        FocusRect.Right := TextRect.Right + 1;
      if FocusRect.Bottom > TextRect.Bottom + 1 then
        FocusRect.Bottom := TextRect.Bottom + 1;
    end;
  end;

begin
  with AViewInfo do
  begin
    if not IsInplace and Focused then
      if Length(Text) = 0 then
        FocusRect := cxEmptyRect
      else
      begin
        FocusRect := TextRect;
        InflateRect(FocusRect, 1, 1);
        CheckFocusRectBounds;
      end;
  end;
end;

{ TcxLabelEditStyle }

function TcxLabelEditStyle.DefaultBorderStyle: TcxContainerBorderStyle;
begin
  if IsBaseStyle then
    Result := cbsNone
  else
    Result := inherited DefaultBorderStyle;
end;

function TcxLabelEditStyle.DefaultHotTrack: Boolean;
begin
  Result := False;
end;

{ TcxCustomLabelViewInfo }

constructor TcxCustomLabelViewInfo.Create;
begin
  inherited Create;
  FAlignment := TcxEditAlignment.Create(nil);
  FDrawBitmap := TBitmap.Create;
  FInplaceOffset := Point(MaxInt, MaxInt);
end;

destructor TcxCustomLabelViewInfo.Destroy;
begin
  FreeAndNil(FDrawBitmap);
  if Assigned(FAlignment) then FreeAndNil(FAlignment);
  inherited;
end;

procedure TcxCustomLabelViewInfo.Offset(DX, DY: Integer);
begin
  inherited Offset(DX, DY);
  OffsetRect(FLabelTextRect, DX, DY);
  OffsetRect(FocusRect, DX, DY);
  if Transparent then
    FIsDrawBitmapDirty := True;
end;

procedure TcxCustomLabelViewInfo.Paint(ACanvas: TcxCanvas);
begin
  DrawCustomEdit(ACanvas, Self, False, bpsSolid);
  DrawLabel(ACanvas);
end;

procedure TcxCustomLabelViewInfo.DrawLabel(ACanvas: TcxCanvas);

  function GetColor(BColor, EColor: TColor; N,H: Integer) : TColor;
  begin
    EColor := ColorToRGB(EColor);
    BColor := ColorToRGB(BColor);

    Result := RGB(Trunc(GetRValue(BColor) + (GetRValue(EColor) - GetRValue(BColor)) * N / H),
                  Trunc(GetGValue(BColor) + (GetGValue(EColor) - GetGValue(BColor)) * N / H),
                  Trunc(GetBValue(BColor) + (GetBValue(EColor) - GetBValue(BColor)) * N / H));
  end;

  procedure DrawBackground(ADrawCanvas: TcxCanvas; const ADrawingRect: TRect;
    AParentBackgroundOffset: TPoint);
  begin
    if Self.DrawBackground(ADrawCanvas, AParentBackgroundOffset) then
      Exit;
    if not Transparent or IsInplace and Focused then
      cxEditFillRect(ADrawCanvas, ADrawingRect, BackgroundColor)
    else
      if IsInplace then
        BitBlt(ADrawCanvas.Handle, ADrawingRect.Left, ADrawingRect.Top,
          RectWidth(ADrawingRect), RectHeight(ADrawingRect), ACanvas.Handle,
          AParentBackgroundOffset.X, AParentBackgroundOffset.Y, SRCCOPY)
      else
      begin
        if not (csPaintCopy in Edit.ControlState) then
        begin
          with AParentBackgroundOffset do
            cxDrawTransparentControlBackground(Edit, ADrawCanvas,
              Rect(X, Y, X + RectWidth(ADrawingRect), Y + RectHeight(ADrawingRect)));
        end;
      end;
  end;

  function GetLabelStyleOffset: Integer;
  begin
    Result := 0;
    if LabelStyle in [cxlsRaised, cxlsLowered] then
    begin
      if Font.Size >= 12 then
        Result := 2
      else
        Result := 1;
    end;
  end;

  function GetTextDrawingParameters(ACanvas: TCanvas; ADrawingRect: TRect;
    AAngle: Integer; out AStep: TSize): TPoint;

    procedure CalcRotatedTextPos(ACanvas: TCanvas);
    var
     ARect: TRect;
     AText: string;
    begin
      if AAngle <> 0 then
      begin
        ARect := ADrawingRect;
        Dec(ARect.Right, DepthDeltaSize.cx);
        Dec(ARect.Bottom, DepthDeltaSize.cy);
        AText := Text;
        if ShowAccelChar then
          AText := RemoveAccelChars(AText);
        Windows.DrawText(ACanvas.Handle, PChar(AText),
          Length(AText), ADrawingRect, DT_CALCRECT or DT_NOPREFIX);

        Result.X := Round(
          (ARect.Left + ARect.Right)/2 -
          RectWidth(ADrawingRect) / 2  * Cos(AAngle * PI / 180) -
          RectHeight(ADrawingRect) / 2 * Sin(AAngle * PI / 180));
        Result.Y := Round(
          (ARect.Top + ARect.Bottom)/2 +
          RectWidth(ADrawingRect) / 2  * Sin(AAngle * PI / 180) -
          RectHeight(ADrawingRect) / 2 * Cos(AAngle * PI / 180));
      end;
    end;

    function GetSignByValue(AValue: Longint): ShortInt;
    begin
      Result := 0;
      if AValue = 0 then
        Exit;
      if AValue > 0 then
        Result := 1
      else
        Result := -1;
    end;

  var
    ALabelStyleOffset: Integer;
  begin
    Result := Point(0, 0);
    CalcRotatedTextPos(ACanvas);
    AStep := Size(0, 0);
    ALabelStyleOffset := GetLabelStyleOffset;
    if (LabelEffect <> cxleNormal) and (FDepth <> 0) then
    begin
      AStep := DepthDeltaSize;
      if Orientation in [cxoRight, cxoRightTop, cxoRightBottom] then
      begin
        Inc(Result.X, DepthDeltaSize.cx + ALabelStyleOffset);
        AStep.cx := -AStep.cx;
      end;
      if Orientation in [cxoBottom, cxoLeftBottom , cxoRightBottom] then
      begin
        Inc(Result.Y, DepthDeltaSize.cy + ALabelStyleOffset);
        AStep.cy := -AStep.cy;
      end;
      if LabelEffect in [cxleFun, cxleExtrude] then
      begin
         AStep.cx := GetSignByValue(AStep.cx);
         AStep.cy := GetSignByValue(AStep.cy);
      end;
    end;
  end;

  procedure DrawActualText(ACanvas: TcxCanvas; const ADrawingRect: TRect;
    const APosition: TPoint; AIsTextRotated: Boolean);
  var
    ATextRect: TRect;
    AText: string;
  begin
    ATextRect := ADrawingRect;
    if not AIsTextRotated then
    begin
      Dec(ATextRect.Right, DepthDeltaSize.cx);
      Dec(ATextRect.Bottom, DepthDeltaSize.cy);
      OffsetRect(ATextRect, APosition.X, APosition.Y);
      ACanvas.DrawText(Text, ATextRect,
        PrepareTextFlag(0, Alignment.Horz, TcxAlignmentVert(Ord(Alignment.Vert)),
          (epoShowEndEllipsis in PaintOptions) and IsInplace,
          WordWrap, 0, False, ShowAccelChar));
    end
    else
    begin
      AText := Text;
      if ShowAccelChar then
        AText := RemoveAccelChars(AText);
      ExtTextOut(ACanvas.Handle, APosition.X, APosition.Y, 0,
        @ATextRect, PChar(AText),
        Length(AText), nil);
    end;
  end;

  procedure DrawLabelEffect(ACanvas: TcxCanvas; const ADrawingRect: TRect;
    var AStartPos: TPoint; const AStep: TSize; AIsTextRotated: Boolean);
  var
    AIterationCount, I: Integer;
  begin
    if (LabelEffect = cxleNormal) or (FDepth = 0) then
      Exit;
    if AStep.cx <> 0 then
      AIterationCount := FDepth div Abs(AStep.cx)
    else
      AIterationCount := FDepth div Abs(AStep.cy);
    if LabelEffect <> cxleFun then
      ACanvas.Font.Color := ShadowedColor;
    for I := 1 to AIterationCount do
    begin
      if LabelEffect = cxleFun then
        ACanvas.Font.Color :=
          GetColor(BackgroundColor, ShadowedColor, I, AIterationCount);
      DrawActualText(ACanvas, ADrawingRect, AStartPos, AIsTextRotated);
      Inc(AStartPos.X, AStep.cx);
      Inc(AStartPos.Y, AStep.cy);
    end;
  end;

  procedure DrawConventionalizedText(ACanvas: TcxCanvas; ARect: TRect;
    const APosition: TPoint; AGlyph: TBitmap; AIsTrueType: Boolean;
    AIsTextRotated: Boolean);

    procedure DrawFilledText(XPosOffset, YPosOffset: Integer;
      AGlyphOnly: Boolean = False);
    begin
      if not AGlyph.Empty and AIsTrueType and (AGlyph.Width > 0) and
        (AGlyph.Height > 0) then
      begin
        BeginPath(ACanvas.Handle);
        DrawActualText(ACanvas, ARect, Point(APosition.X + XPosOffset,
          APosition.Y + YPosOffset), AIsTextRotated);
        EndPath(ACanvas.Handle);
        SelectClipPath(ACanvas.Handle, RGN_COPY);
        ACanvas.FillRect(ARect, AGlyph);
        SelectClipRgn(ACanvas.Handle, 0);
      end
      else
        if not AGlyphOnly then
          DrawActualText(ACanvas, ARect, Point(APosition.X + XPosOffset,
            APosition.Y + YPosOffset), AIsTextRotated);
    end;

  begin
    ACanvas.Font.Color := TextColor;
    case LabelStyle of
      cxlsNormal:
        DrawFilledText(0, 0);
      cxlsRaised:
      begin
        ACanvas.Font.Color :=  clBtnHighlight;
        DrawActualText(ACanvas, ARect, APosition,
          AIsTextRotated);
        if Font.Size >= 12 then
        begin
          ACanvas.Font.Color := clBtnShadow;
          DrawActualText(ACanvas, ARect, Point(APosition.X + 2, APosition.Y + 2),
            AIsTextRotated);
        end;
        ACanvas.Font.Color := TextColor;
        DrawFilledText(1, 1);
      end;
      cxlsLowered:
      begin
        if Font.Size >= 12 then
        begin
          ACanvas.Font.Color :=  clBtnShadow;
          DrawActualText(ACanvas, ARect, APosition,
            AIsTextRotated);
        end;
        ACanvas.Font.Color := clBtnHighlight;
        DrawActualText(ACanvas, ARect, Point(APosition.X + 2, APosition.Y + 2),
          AIsTextRotated);
        ACanvas.Font.Color := TextColor;
        DrawFilledText(1, 1);
      end;
      cxlsOutLine:
      begin
        DrawFilledText(0, 0, AIsTrueType);
        if AIsTrueType then
        begin
          BeginPath(ACanvas.Handle);
          DrawActualText(ACanvas, ARect, APosition, AIsTextRotated);
          EndPath(ACanvas.Handle);
          ACanvas.Pen.Color := TextColor;
          ACanvas.Pen.Width := FPenWidth;
          StrokePath(ACanvas.Handle);
          ACanvas.Pen.Width := 1;
        end;
      end;
    end;
  end;

  procedure AdjustTextPosWithLabelStyle(var APosition: TPoint;
    const AStep: TSize);
  var
    ALabelStyleOffset: Integer;
  begin
    ALabelStyleOffset := GetLabelStyleOffset;
    if AStep.cx < 0 then
      Dec(APosition.X, ALabelStyleOffset);
    if AStep.cy < 0 then
      Dec(APosition.Y, ALabelStyleOffset);
  end;

  procedure AdjustTextRectWithOffset(var ATextRect: TRect);
  begin
    if IsInplace then
      with DrawTextOffsets do
      begin
        Inc(ATextRect.Left, Left);
        Inc(ATextRect.Top, Top);
        Dec(ATextRect.Right, Right);
        Dec(ATextRect.Bottom, Bottom);
      end
    else
      if BorderStyle <> ebsNone then
        InflateRect(ATextRect, -TextFromBorderOffset, 0);
  end;

  procedure InternalDrawLabel(ADrawCanvas: TcxCanvas;
    const ABackgroundRect, ATextRect: TRect; const AParentBackgroundOffset: TPoint);
  var
    AIsTrueType: Boolean;
    ARealAngle: Integer;
    AStep: TSize;
    AStartPos: TPoint;
  begin
    DrawBackground(ADrawCanvas, ABackgroundRect, AParentBackgroundOffset);

    AIsTrueType := AdjustCanvasFont(ADrawCanvas.Canvas, Font, FAngle);
    ARealAngle := Integer(AIsTrueType) * FAngle;
    ARealAngle := (ARealAngle mod 360 + 360) mod 360;
    AStartPos := GetTextDrawingParameters(ADrawCanvas.Canvas, ATextRect,
      ARealAngle, AStep);
    ADrawCanvas.Brush.Style := bsClear;
    DrawLabelEffect(ADrawCanvas, ATextRect, AStartPos, AStep, ARealAngle <> 0);
    AdjustTextPosWithLabelStyle(AStartPos, AStep);
    DrawConventionalizedText(ADrawCanvas, ATextRect, AStartPos, FGlyph,
      AIsTrueType, ARealAngle <> 0);
    ADrawCanvas.Brush.Style := bsSolid;
  end;

  function InplaceOffsetChanged: Boolean;
  begin
    Result := (FInplaceOffset.X <> Left) or (FInplaceOffset.Y <> Top);
    if Result then
    begin
      FInplaceOffset.X := Left;
      FInplaceOffset.Y := Top;
    end;
  end;

var
  ABitmapCanvas: TcxCanvas;
  AContentRect, ATextRect: TRect;
  APrevLogFont: TLogFont;
begin
  SaveCanvasFont(ACanvas, APrevLogFont);
  try
    AContentRect := LabelTextRect;
    ATextRect := LabelTextRect;
    AdjustTextRectWithOffset(ATextRect);
    if not IsInplace and Transparent and (csPaintCopy in Edit.ControlState) then
      InternalDrawLabel(ACanvas, AContentRect, ATextRect, AContentRect.TopLeft)
    else
    begin
      if not IsInplace and NativeStyle then
        GetThemeBackgroundContentRect(OpenTheme(totEdit), ACanvas.Handle,
          EP_EDITTEXT, NativeState, Bounds, AContentRect);
      if InplaceOffsetChanged or FIsDrawBitmapDirty or Transparent then
      begin
        FDrawBitmap.Width := RectWidth(AContentRect);
        FDrawBitmap.Height := RectHeight(AContentRect);
        ABitmapCanvas := TcxCanvas.Create(FDrawBitmap.Canvas);
        OffsetRect(ATextRect, -AContentRect.Left, -AContentRect.Top);
        try
          InternalDrawLabel(ABitmapCanvas, Rect(0, 0, FDrawBitmap.Width, FDrawBitmap.Height),
            ATextRect, AContentRect.TopLeft);
        finally
          FreeAndNil(ABitmapCanvas);
        end;
        FIsDrawBitmapDirty := False;
      end;
      BitBlt(ACanvas.Handle, AContentRect.Left, AContentRect.Top,
        FDrawBitmap.Width, FDrawBitmap.Height, FDrawBitmap.Canvas.Handle, 0, 0, SRCCOPY);
     end;
  finally
    RestoreCanvasFont(ACanvas, APrevLogFont);
  end;
end;

procedure TcxCustomLabelViewInfo.SetBackgroundColor(Value: TColor);
begin
  inherited SetBackgroundColor(Value);
  FIsDrawBitmapDirty := True;
end;

{ TcxCustomLabelViewData }

procedure TcxCustomLabelViewData.CalculateLabelViewInfoProps(AViewInfo: TcxCustomEditViewInfo);
begin
  with TcxCustomLabelViewInfo(AViewInfo) do
  begin
    LabelEffect := Properties.LabelEffect;
    LabelStyle := Properties.LabelStyle;
    Orientation := Properties.Orientation;
    Depth := Properties.Depth;
    ShadowedColor := Properties.ShadowedColor;
    ShowAccelChar := Properties.ShowAccelChar;
    Angle := Properties.Angle;
    PenWidth := Properties.PenWidth;
    WordWrap := Properties.WordWrap;
    Alignment.Assign(Properties.Alignment);
    Glyph := Properties.Glyph;
  end;
end;

procedure TcxCustomLabelViewData.Calculate(ACanvas: TcxCanvas; const ABounds: TRect;
  const P: TPoint; Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
var
  ALabelViewInfo: TcxCustomLabelViewInfo;
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);
  if ((ABounds.Bottom >= MaxInt) or (ABounds.Right >= MaxInt)) and IsInplace then
    Exit;
  ALabelViewInfo := TcxCustomLabelViewInfo(AViewInfo);
  {Standart properties}
  ALabelViewInfo.IsEditClass := GetIsEditClass;
  ALabelViewInfo.DrawSelectionBar := False;
  ALabelViewInfo.HasPopupWindow := False;
  ALabelViewInfo.DrawTextFlags := GetDrawTextFlags;
  if AreVisualStylesMustBeUsed(ALabelViewInfo.NativeStyle, totButton) and
    (ALabelViewInfo.BorderStyle = ebsNone) then
    ALabelViewInfo.NativeStyle := False;
  if not IsInplace then
    ALabelViewInfo.Transparent := TcxCustomLabel(Edit).Transparent;
  {Label properties}
  CalculateLabelViewInfoProps(ALabelViewInfo);
  ALabelViewInfo.DepthDeltaSize := Properties.CalculateDepthDelta;
  ALabelViewInfo.TextRect := AViewInfo.ClientRect;
  ALabelViewInfo.LabelTextRect := AViewInfo.ClientRect;
  CalculateCustomLabelViewInfo(ACanvas, Self, ALabelViewInfo);
  if not IsInplace then ALabelViewInfo.DrawSelectionBar := False;

  if Edit <> nil then
    ALabelViewInfo.LeftTop := Point(Edit.Left, Edit.Top);

  ALabelViewInfo.DrawTextOffsets := GetTextEditDrawTextOffset(Self);

  ALabelViewInfo.FIsDrawBitmapDirty := True;
end;

procedure TcxCustomLabelViewData.EditValueToDrawValue(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo);
begin
  TcxCustomLabelViewInfo(AViewInfo).Text := EditValueToDisplayText(AEditValue);
end;

function TcxCustomLabelViewData.GetEditContentSize(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; const AEditSizeProperties: TcxEditSizeProperties): TSize;

  function CalculateLabelTextSize(ACanvas: TcxCanvas; const AText: string;
    const ATextRect: TRect; AAngle: Integer; ADepthSize,
      AContentSizeCorrection: TSize; ALabelStyleOffset: Integer; AIsInplace,
        AWordWrap, AShowAccelChar: Boolean): TSize;
  var
    ARealAngle, ATextFlag, ATextWidth: Integer;
    ARealText: string;
    ARect: TRect;
    ARealWordWrap: Boolean;
  begin
    ARect := Rect(0, 0, RectWidth(ATextRect), RectHeight(ATextRect));
    ARealAngle := (AAngle mod 360 + 360) mod 360;
    ARealWordWrap := AWordWrap and (ARealAngle = 0);
    if ARect.Right < 0 then
    begin
      if AIsInplace then
        ARealWordWrap := False;
    end
    else
    begin
      Dec(ARect.Right, ADepthSize.cx + ALabelStyleOffset);
      if (Style.BorderStyle <> ebsNone) and not AIsInplace then
        Dec(ARect.Right, TextFromBorderOffset * 2);
      if AIsInplace then
        Dec(ARect.Right, AContentSizeCorrection.cx);
    end;
    ATextFlag := PrepareTextFlag(DT_CALCRECT, TAlignment(0),
      TcxAlignmentVert(0), False,
      ARealWordWrap, 0, True, AShowAccelChar and (ARealAngle = 0));
    ARealText := AText;
    if (ARealAngle <> 0) and AShowAccelChar then
      ARealText := RemoveAccelChars(AText);
    DrawText(ACanvas.Handle, PChar(ARealText),
      Length(ARealText), ARect, ATextFlag);
    if ARealAngle <> 0 then
    begin
      ATextWidth := ARect.Right;
      ARect.Right := Trunc(Abs(ARect.Right * Cos(ARealAngle * PI / 180)) +
        Abs(ARect.Bottom * Sin(ARealAngle  * PI / 180)) + 0.5);
      ARect.Bottom := Trunc(Abs(ATextWidth * Sin(ARealAngle * PI / 180)) +
        Abs(ARect.Bottom * Cos(ARealAngle  * PI / 180)) + 0.5);
    end;
    Result.cx := ARect.Right;
    Result.cy := ARect.Bottom;
    Result.cx := Result.cx + ADepthSize.cx + ALabelStyleOffset;
    Result.cy := Result.cy + ADepthSize.cy + ALabelStyleOffset;
    if (Style.BorderStyle <> ebsNone) and not AIsInplace then
      Result.cx := Result.cx + TextFromBorderOffset * 2;
    if AIsInplace then
    begin
      Result.cx := Result.cx + AContentSizeCorrection.cx;
      Result.cy := Result.cy + AContentSizeCorrection.cy;
    end;
  end;

var
  ADisplayText: string;
  ALabelStyleOffset: Integer;
  APrevLogFont: TLogFont;
  ARealAngle: Integer;
  ASizeDelta: TSize;
begin
  SaveCanvasFont(ACanvas, APrevLogFont);
  try
    Result := Size(0, 0);
    ADisplayText := EditValueToDisplayText(AEditValue);
    if ADisplayText = '' then
      ADisplayText := ' ';
    Result.cx := AEditSizeProperties.Width;
    ARealAngle := Integer(AdjustCanvasFont(ACanvas.Canvas, Style.GetVisibleFont, Properties.Angle)) *
      Properties.Angle;
    ASizeDelta := Properties.CalculateDepthDelta;
    if Properties.LabelStyle in [cxlsRaised, cxlsLowered] then
    begin
      if ACanvas.Font.Size >= 12 then
        ALabelStyleOffset := 2
      else
        ALabelStyleOffset := 1;
    end
    else
      ALabelStyleOffset := 0;

    with Properties do
      Result := CalculateLabelTextSize(ACanvas, ADisplayText,
        Rect(0, 0, Result.cx, Result.cy), ARealAngle, ASizeDelta,
        Self.GetEditContentSizeCorrection, ALabelStyleOffset, IsInplace,
        WordWrap, Properties.ShowAccelChar);
  finally
    RestoreCanvasFont(ACanvas, APrevLogFont);
  end;
end;

function TcxCustomLabelViewData.GetDrawTextFlags: Integer;
var
  ARealAngle: Integer;
begin
  ARealAngle := (Properties.Angle mod 360 + 360) mod 360;
  Result := DrawTextFlagsTocxTextOutFlags(
    PrepareTextFlag(0, Properties.Alignment.Horz,
      TcxAlignmentVert(Ord(Properties.Alignment.Vert)),
      epoShowEndEllipsis in PaintOptions,
      Properties.WordWrap and (ARealAngle = 0), 0, False));
end;

function TcxCustomLabelViewData.GetIsEditClass: Boolean;
begin
  Result := False;
end;

function TcxCustomLabelViewData.InternalEditValueToDisplayText(
  AEditValue: TcxEditValue): string;
begin
  Result := VarToStr(AEditValue);
end;

function TcxCustomLabelViewData.GetProperties: TcxCustomLabelProperties;
begin
  Result := TcxCustomLabelProperties(FProperties);
end;

{ TcxCustomLabelProperties }

constructor TcxCustomLabelProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FLabelEffect := cxleNormal;
  FLabelStyle := cxlsNormal;
  FOrientation := cxoRightBottom;
  FDepth := 0;
  FShadowedColor := clGrayText;
  FShowAccelChar := True;
  FAngle := 0;
  FPenWidth := 1;
  FWordWrap := False;
end;

destructor TcxCustomLabelProperties.Destroy;
begin
  if FGlyph <> nil then FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TcxCustomLabelProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomLabelProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomLabelProperties do
      begin
        Self.LabelEffect := LabelEffect;
        Self.LabelStyle := LabelStyle;
        Self.Orientation := Orientation;
        Self.Depth := Depth;
        Self.ShadowedColor := ShadowedColor;
        Self.Angle := Angle;
        Self.PenWidth := PenWidth;
        Self.Glyph := Glyph;
        Self.ShowAccelChar := ShowAccelChar;
        Self.WordWrap := WordWrap;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomLabelProperties.CanCompareEditValue: Boolean;
begin
  Result := True;
end;

class function TcxCustomLabelProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxLabel;
end;

class function TcxCustomLabelProperties.GetStyleClass: TcxCustomEditStyleClass;
begin
  Result := TcxLabelEditStyle;
end;

function TcxCustomLabelProperties.GetDisplayText(const AEditValue: TcxEditValue;
  AFullText: Boolean = False; AIsInplace: Boolean = True): WideString;
var
  ADisplayValue: TcxEditValue;
begin
  PrepareDisplayValue(AEditValue, ADisplayValue, False);
  Result := ADisplayValue;
end;

function TcxCustomLabelProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := [esoAutoHeight, esoFiltering, esoShowingCaption, esoSorting,
    esoTransparency];
end;

class function TcxCustomLabelProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCustomLabelViewInfo;
end;

function TcxCustomLabelProperties.IsEditValueValid(var EditValue: TcxEditValue; AEditFocused: Boolean): Boolean;
begin
  Result := inherited IsEditValueValid(EditValue, AEditFocused);
end;

procedure TcxCustomLabelProperties.PrepareDisplayValue(const AEditValue:
  TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean);
begin
  DisplayValue := VarToStr(AEditValue);
end;

class function TcxCustomLabelProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxCustomLabelViewData;
end;

function TcxCustomLabelProperties.HasDisplayValue: Boolean;
begin
  Result := True;
end;

procedure TcxCustomLabelProperties.SetLabelEffect(Value : TcxLabelEffect);
begin
  if FLabelEffect <> Value then
  begin
    FLabelEffect := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetLabelStyle(Value : TcxLabelStyle);
begin
  if FLabelStyle <> Value then
  begin
    FLabelStyle := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetOrientation(Value : TcxLabelOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetDepth(Value : Word);
begin
  if FDepth <> Value then
  begin
    FDepth := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetShadowedColor(Value : TColor);
begin
  if FShadowedColor <> Value then
  begin
    FShadowedColor := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetAngle(Value: Integer);
begin
  if FAngle <> Value then
  begin
    FAngle := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetPenWidth(Value: Integer);
begin
  if FPenWidth <> Value then
  begin
    FPenWidth := Value;
    Changed;
  end;
end;

function TcxCustomLabelProperties.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
  begin
    FGlyph := TBitmap.Create;
    FGlyph.OnChange := GlyphChanged;
  end;
  Result := FGlyph;
end;

procedure TcxCustomLabelProperties.GlyphChanged(Sender: TObject);
begin
  Changed;
end;

procedure TcxCustomLabelProperties.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FreeAndNil(FGlyph)
  else
    Glyph.Assign(Value);
  Changed;
end;

procedure TcxCustomLabelProperties.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    Changed;
  end;
end;

procedure TcxCustomLabelProperties.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

function TcxCustomLabelProperties.CalculateDepthDelta: TSize;
begin
  Result.cx := 0;
  Result.cy := 0;
  if LabelEffect = cxleNormal then Exit;
  case FOrientation of
    cxoLeft, cxoRight: Result.cx := FDepth;
    cxoTop, cxoBottom: Result.cy := FDepth;
    cxoLeftTop, cxoLeftBottom, cxoRightTop, cxoRightBottom:
    begin
      Result.cx := FDepth;
      Result.cy := FDepth;
    end;
  end;
end;

function TcxCustomLabelProperties.GetDisplayFormatOptions: TcxEditDisplayFormatOptions;
begin
  Result := [];
end;

function TcxCustomLabelProperties.GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource;
begin
  Result := evsText;
end;

{ TcxCustomLabel }

destructor TcxCustomLabel.Destroy;
begin
  FFocusControl := nil;
  inherited Destroy;
end;

procedure TcxCustomLabel.Notification(ACOmponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FFocusControl <> nil) and
    (AComponent = FFocusControl) then FFocusControl := nil;
end;

class function TcxCustomLabel.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomLabelProperties;
end;

procedure TcxCustomLabel.SetStyle(Value: TcxLabelEditStyle);
begin
  FStyles.Style := Value;
end;

procedure TcxCustomLabel.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle - [csCaptureMouse];
  Width := 121;
  Height := 21;
end;

procedure TcxCustomLabel.SetFocusControl(Value: TWinControl);
begin
  if (FFocusControl <> Value) and (Value <> Self) then
    FFocusControl := Value;
end;

procedure TcxCustomLabel.InternalSetEditValue(const Value: TcxEditValue;
  AValidateEditValue: Boolean);
begin
  inherited InternalSetEditValue(Value, AValidateEditValue);
  if not FLockCaption then
    Caption := VarToStr(Value);
  SetInternalDisplayValue(Caption);
end;

procedure TcxCustomLabel.SetInternalDisplayValue(Value: TcxEditValue);
begin
  ViewInfo.Text := VarToStr(Value);
  ShortRefreshContainer(False);
end;

procedure TcxCustomLabel.TextChanged;
begin
  inherited TextChanged;
  FLockCaption := True;
  try
    InternalEditValue := Caption;
  finally
    FLockCaption := False;
  end;
end;

function TcxCustomLabel.CanFocus: Boolean;
begin
  Result := IsInplace;
end;

{$IFDEF DELPHI10}
function TcxCustomLabel.GetTextBaseLine: Integer;
begin
  Result := ViewInfo.GetTextBaseLine;
end;

function TcxCustomLabel.HasTextBaseLine: Boolean;
begin
  Result := ActiveProperties.Angle = 0;
end;
{$ENDIF}

function TcxCustomLabel.CanAutoWidth: Boolean;
begin
  Result := True;
end;

function TcxCustomLabel.CanFocusOnClick: Boolean;
begin
  Result := inherited CanFocusOnClick and IsInplace;
end;

function TcxCustomLabel.DefaultParentColor: Boolean;
begin
  Result := True;
end;

procedure TcxCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and Properties.ShowAccelChar and
    IsAccel(Message.CharCode, Caption) and FFocusControl.CanFocus then
  begin
    FFocusControl.SetFocus;
    Message.Result := 1;
  end;
end;

function TcxCustomLabel.GetProperties: TcxCustomLabelProperties;
begin
  Result := TcxCustomLabelProperties(FProperties);
end;

function TcxCustomLabel.GetActiveProperties: TcxCustomLabelProperties;
begin
  Result := TcxCustomLabelProperties(InternalGetActiveProperties);
end;

function TcxCustomLabel.GetStyle: TcxLabelEditStyle;
begin
  Result := TcxLabelEditStyle(FStyles.Style);
end;

function TcxCustomLabel.GetViewInfo: TcxCustomLabelViewInfo;
begin
  Result := TcxCustomLabelViewInfo(FViewInfo);
end;

procedure TcxCustomLabel.SetProperties(Value: TcxCustomLabelProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxLabel }

class function TcxLabel.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxLabelProperties;
end;

function TcxLabel.GetActiveProperties: TcxLabelProperties;
begin
  Result := TcxLabelProperties(InternalGetActiveProperties);
end;

function TcxLabel.GetProperties: TcxLabelProperties;
begin
  Result := TcxLabelProperties(FProperties);
end;

procedure TcxLabel.SetProperties(Value: TcxLabelProperties);
begin
  FProperties.Assign(Value);
end;

initialization
  GetRegisteredEditProperties.Register(TcxLabelProperties, scxSEditRepositoryLabelItem);
  FilterEditsController.Register(TcxLabelProperties, TcxFilterTextEditHelper);

finalization
  FilterEditsController.Unregister(TcxLabelProperties, TcxFilterTextEditHelper);
  GetRegisteredEditProperties.Unregister(TcxLabelProperties);
  
end.
