
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

unit cxCheckGroup;

{$I cxVer.inc}

interface

uses
  Windows, Classes, cxContainer, cxEdit, cxGroupBox, Controls, cxCheckBox, cxGraphics,
  Graphics, Messages, cxFilterControlUtils, cxCheckComboBox, cxLookAndFeels;

type
  { TcxCheckGroupItem }

  TcxCheckGroupItem = class(TcxButtonGroupItem)
  published
    property Caption;
    property Enabled;
    property Tag;
  end;

  { TcxCheckGroupItems }

  TcxCheckGroupItems = class(TcxButtonGroupItems)
  private
    function GetItem(Index: Integer): TcxCheckGroupItem;
    procedure SetItem(Index: Integer; Value: TcxCheckGroupItem);
  public
    function Add: TcxCheckGroupItem;
    property Items[Index: Integer]: TcxCheckGroupItem
      read GetItem write SetItem; default;
  end;

  { TcxCheckGroupButtonViewInfo }

  TcxCheckGroupButtonViewInfo = class(TcxGroupBoxButtonViewInfo)
  public
    State: TcxCheckBoxState;
    function GetGlyphRect(ACanvas: TcxCanvas; AGlyphSize: TSize; AAlignment: TLeftRight; AIsPaintCopy: Boolean): TRect; override;
  end;

  TcxCustomCheckGroup = class;

  { TcxCheckGroupViewInfo }

  TcxCheckGroupViewInfo = class(TcxButtonGroupViewInfo)
  private
    function GetEdit: TcxCustomCheckGroup;
  protected
    procedure DrawButtonCaption(ACanvas: TcxCanvas;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect); override;
    procedure DrawButtonGlyph(ACanvas: TcxCanvas;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect); override;
    function GetButtonViewInfoClass: TcxEditButtonViewInfoClass; override;
    function IsButtonGlypthTransparent(AButtonViewInfo: TcxGroupBoxButtonViewInfo): Boolean; override;

    procedure SetOnDrawBackground(AValue: TcxEditDrawBackgroundEvent); override;
  public
    CheckBorderStyle: TcxEditCheckBoxBorderStyle;
    property Edit: TcxCustomCheckGroup read GetEdit;
  end;

  { TcxCheckGroupViewData }

  TcxCheckGroupViewData = class(TcxButtonGroupViewData)
  protected
    procedure CalculateButtonNativeState(AViewInfo: TcxCustomEditViewInfo;
      AButtonViewInfo: TcxGroupBoxButtonViewInfo); override;
    function GetCaptionRectExtent: TRect; override;
    procedure GetEditMetrics(AAutoHeight: Boolean; ACanvas: TcxCanvas;
      out AMetrics: TcxEditMetrics); override;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    procedure EditValueToDrawValue(ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
      AViewInfo: TcxCustomEditViewInfo); override;
  end;

  { TcxCustomCheckGroupProperties }

  TcxCustomCheckGroupProperties = class(TcxCustomButtonGroupProperties)
  private
    FAllowGrayed: Boolean;
    FEditValueFormat: TcxCheckStatesValueFormat;
    FGlyph: TBitmap;
    FGlyphCount: Integer;
    FItemAlignment: TLeftRight;
    FOnEditValueToStates: TcxValueToCheckStatesEvent;
    FOnStatesToEditValue: TcxCheckStatesToValueEvent;
    function GetGlyph: TBitmap;
    function GetItems: TcxCheckGroupItems;
    procedure GlyphChanged(Sender: TObject);
    procedure SetAllowGrayed(Value: Boolean);
    procedure SetEditValueFormat(Value: TcxCheckStatesValueFormat);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphCount(Value: Integer);
    procedure SetItemAlignment(Value: TLeftRight);
    procedure SetItems(Value: TcxCheckGroupItems);
  protected
    function CreateItems: TcxButtonGroupItems; override;
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    function HasDisplayValue: Boolean; override;
    procedure CalculateCheckStatesByEditValue(Sender: TObject;
      const AEditValue: TcxEditValue); virtual;
    procedure CalculateEditValueByCheckStates(Sender: TObject;
      out AEditValue: TcxEditValue); virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CompareDisplayValues(
      const AEditValue1, AEditValue2: TcxEditValue): Boolean; override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    // !!!
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed
      default False;
    property EditValueFormat: TcxCheckStatesValueFormat read FEditValueFormat
      write SetEditValueFormat default cvfIndices;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read FGlyphCount write SetGlyphCount default 6;
    property ItemAlignment: TLeftRight read FItemAlignment
      write SetItemAlignment default taLeftJustify;
    property Items: TcxCheckGroupItems read GetItems write SetItems;
    property OnEditValueToStates: TcxValueToCheckStatesEvent
      read FOnEditValueToStates write FOnEditValueToStates;
    property OnStatesToEditValue: TcxCheckStatesToValueEvent
      read FOnStatesToEditValue write FOnStatesToEditValue;
  end;

  { TcxCheckGroupProperties }

  TcxCheckGroupProperties = class(TcxCustomCheckGroupProperties)
  published
    property AllowGrayed;
    property AssignedValues;
    property ClearKey;
    property Columns;
    property EditValueFormat;
    property Glyph;
    property GlyphCount;
    property ImmediatePost;
    property ItemAlignment;
    property Items;
    property ReadOnly;
    property WordWrap;
    property OnChange;
    property OnEditValueChanged;
    property OnEditValueToStates;
    property OnStatesToEditValue;
  end;

  { TcxCheckGroupCheckButtonViewInfo }

  TcxCheckGroupCheckButtonViewInfo = class(TcxCustomCheckBoxViewInfo)
  protected
    procedure InternalPaint(ACanvas: TcxCanvas); override;
  end;

  { TcxCheckGroupButtonProperties }

  TcxCheckGroupButtonProperties = class(TcxCheckBoxProperties)
  protected
    function InternalGetGlyph: TBitmap; override;
    function IsEmbeddedEdit: Boolean; override;
  public
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
  end;

  { TcxCheckGroupButton }

  TcxCheckGroupButton = class(TcxCheckBox, IcxContainerInnerControl)
  private
    FColumn: Integer;
    FRow: Integer;
    function GetCheckGroup: TcxCustomCheckGroup;
  protected
    function CanAutoSize: Boolean; override;
    procedure DoExit; override;
    procedure Initialize; override;
    function IsNativeBackground: Boolean; override;
    function IsNativeStyle: Boolean; override;
    function IsTransparent: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    procedure WndProc(var Message: TMessage); override;

    // IcxContainerInnerControl
    function GetControl: TWinControl;
    function GetControlContainer: TcxContainer;

    procedure CheckTransparentBorder;
    property CheckGroup: TcxCustomCheckGroup read GetCheckGroup;
  public
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
  end;

  { TcxCustomCheckGroup }

  TcxCustomCheckGroup = class(TcxCustomButtonGroup)
  private
    FButtonStatesChanging: Boolean;
    FFocusedItemIndex: Integer;
    FStatesItems: Boolean;
    procedure DoButtonChange(Sender: TObject);
    procedure DoButtonEditing(Sender: TObject; var CanEdit: Boolean);
    procedure DoButtonFocusChanged(Sender: TObject);
    function GetActiveProperties: TcxCustomCheckGroupProperties;
    function GetButton(Index: Integer): TcxCheckGroupButton;
    function GetProperties: TcxCustomCheckGroupProperties;
    function GetState(Index: Integer): TcxCheckBoxState;
    procedure SetProperties(Value: TcxCustomCheckGroupProperties);
    procedure SetState(Index: Integer; Value: TcxCheckBoxState);
  protected
    procedure ArrangeButtons; override;
    function GetButtonDC(AButtonIndex: Integer): THandle; override;
    function GetButtonInstance: TWinControl; override;
    procedure Initialize; override;
    procedure InternalValidateDisplayValue(const ADisplayValue: TcxEditValue); override;
    function IsEditValueStored: Boolean; override;
    procedure ParentBackgroundChanged; override;
    procedure PropertiesChanged(Sender: TObject); override;
    procedure SynchronizeButtonsStyle; override;
    procedure SynchronizeDisplayValue; override;
    procedure UpdateButtons; override;
    function WantNavigationKeys: Boolean; override;
    function GetFirstEnabledItemIndex(AStartIndex: Integer): Integer;
    property Buttons[Index: Integer]: TcxCheckGroupButton read GetButton;
    property InternalButtons;
    property StatesItems: Boolean read FStatesItems write FStatesItems stored False;
  public
    procedure Activate(var AEditData: TcxCustomEditData); override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    procedure GetTabOrderList(List: TList); override;
    procedure SetFocus; override;
    property ActiveProperties: TcxCustomCheckGroupProperties
      read GetActiveProperties;
    property Properties: TcxCustomCheckGroupProperties read GetProperties
      write SetProperties;
    property States[Index: Integer]: TcxCheckBoxState read GetState
      write SetState; default;
    property Transparent;
  end;

  { TcxCheckGroup }

  TcxCheckGroup = class(TcxCustomCheckGroup)
  private
    function GetActiveProperties: TcxCheckGroupProperties;
    function GetProperties: TcxCheckGroupProperties;
    procedure SetProperties(Value: TcxCheckGroupProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxCheckGroupProperties read GetActiveProperties;
  published
    property Align;
    property Alignment;
    property Anchors;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EditValue;
    property Enabled;
    property ParentBackground;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxCheckGroupProperties read GetProperties
      write SetProperties;
    property ShowHint;
    property StatesItems;
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
    property OnDragDrop;
    property OnDragOver;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFocusChanged;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TcxFilterCheckGroupHelper }

  TcxFilterCheckGroupHelper = class(TcxFilterChecksHelper)
  protected
    class function GetEditValueFormat(
      AEditProperties: TcxCustomEditProperties): TcxCheckStatesValueFormat; override;
    class function GetItems(
      AEditProperties: TcxCustomEditProperties): IcxCheckItems; override;
    class procedure InitializeItems(AProperties,
      AEditProperties: TcxCustomEditProperties); override;
  end;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
  Types,
{$ENDIF}
  SysUtils, cxClasses, cxControls, cxVariants, cxExtEditConsts, cxEditUtils,
  dxThemeManager, cxEditPaintUtils;

{ TcxCheckGroupItems }

function TcxCheckGroupItems.Add: TcxCheckGroupItem;
begin
  Result := TcxCheckGroupItem(inherited Add);
end;

function TcxCheckGroupItems.GetItem(Index: Integer): TcxCheckGroupItem;
begin
  Result := TcxCheckGroupItem(inherited Items[Index]);
end;

procedure TcxCheckGroupItems.SetItem(Index: Integer; Value: TcxCheckGroupItem);
begin
  inherited Items[Index] := Value;
end;

{ TcxCheckGroupButtonViewInfo }

function TcxCheckGroupButtonViewInfo.GetGlyphRect(ACanvas: TcxCanvas;
  AGlyphSize: TSize; AAlignment: TLeftRight; AIsPaintCopy: Boolean): TRect;

  procedure CorrectCheckRect(var ACheckRect: TRect);
  begin
    if AIsPaintCopy then
      if AAlignment = taRightJustify then
        OffsetRect(ACheckRect, 2, 0)
      else
        OffsetRect(ACheckRect, -2, 0);
  end;

begin             
  case AAlignment of
    taLeftJustify: AAlignment := taRightJustify;
    taRightJustify: AAlignment := taLeftJustify;
  end;
  Result := inherited GetGlyphRect(ACanvas, AGlyphSize, AAlignment, AIsPaintCopy);
  CorrectCheckRect(Result);
end;

{ TcxCheckGroupViewInfo }

procedure TcxCheckGroupViewInfo.DrawButtonCaption(ACanvas: TcxCanvas;
  AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect);

  function GetCaptionRect(const ACheckRect: TRect): TRect;
  begin
    Result := AButtonViewInfo.Bounds;
    if Alignment = taLeftJustify then
    begin
      Result.Left := ACheckRect.Right + CaptionExtent.Left;
      Dec(Result.Right, CaptionExtent.Right);
    end
    else
    begin
      Result.Right := ACheckRect.Left - CaptionExtent.Right;
      Inc(Result.Left, CaptionExtent.Left);
    end;
  end;

begin
  DrawCheckBoxText(ACanvas, AButtonViewInfo.Caption, Font, TextColor,
    GetCaptionRect(AGlyphRect), DrawTextFlags, Enabled);
end;

procedure TcxCheckGroupViewInfo.DrawButtonGlyph(ACanvas: TcxCanvas;
  AButtonViewInfo: TcxGroupBoxButtonViewInfo; const AGlyphRect: TRect);
const
  ACheckStateByButtonState: array[TcxEditButtonState] of TcxEditCheckState =
    (ecsDisabled, ecsNormal, ecsPressed, ecsHot);
var
  ACheckBorderStyle: TcxEditBorderStyle;
  AEditProperties: TcxCustomCheckGroupProperties;
begin
  if (CheckBorderStyle = ebsFlat) and (AButtonViewInfo.Data.State = ebsSelected) then
    ACheckBorderStyle := ebs3D
  else
    ACheckBorderStyle := CheckBorderStyle;
  AEditProperties := TcxCustomCheckGroupProperties(EditProperties);

  DrawEditCheck(ACanvas, AGlyphRect, TcxCheckGroupButtonViewInfo(AButtonViewInfo).State,
    ACheckStateByButtonState[AButtonViewInfo.Data.State], AEditProperties.Glyph,
    AEditProperties.GlyphCount, ACheckBorderStyle, AButtonViewInfo.Data.NativeStyle,
    clBtnText, BackgroundColor, not IsBackgroundTransparent, IsDesigning, False, True,
    Painter);
end;

function TcxCheckGroupViewInfo.GetButtonViewInfoClass: TcxEditButtonViewInfoClass;
begin
  Result := TcxCheckGroupButtonViewInfo;
end;

function TcxCheckGroupViewInfo.IsButtonGlypthTransparent(AButtonViewInfo: TcxGroupBoxButtonViewInfo): Boolean;
begin
  Result := IsBackgroundTransparent;
end;

procedure TcxCheckGroupViewInfo.SetOnDrawBackground(AValue: TcxEditDrawBackgroundEvent);
var
  I: Integer;
begin
  inherited SetOnDrawBackground(AValue);
  if Edit <> nil then
    for I := 0 to Edit.InternalButtons.Count - 1 do
      TcxCheckGroupButton(Edit.InternalButtons[I]).ViewInfo.OnDrawBackground := AValue;
end;

function TcxCheckGroupViewInfo.GetEdit: TcxCustomCheckGroup;
begin
  Result := TcxCustomCheckGroup(FEdit);
end;

{ TcxCheckGroupViewData }

procedure TcxCheckGroupViewData.Calculate(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo; AIsMouseEvent: Boolean);
const
  ABorderStyle: array[TcxLookAndFeelKind] of TcxEditCheckBoxBorderStyle =
    (ebsFlat, ebs3D, ebsUltraFlat, ebsOffice11);
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo,
    AIsMouseEvent);
  with TcxCustomCheckGroupProperties(Properties) do
  begin
    TcxCheckGroupViewInfo(AViewInfo).GlyphSize :=
      GetEditCheckSize(ACanvas, IsButtonNativeStyle(Style.LookAndFeel), Glyph,
      GlyphCount, AViewInfo.Painter);
    TcxCheckGroupViewInfo(AViewInfo).Alignment := ItemAlignment;
  end;
  TcxCheckGroupViewInfo(AViewInfo).CheckBorderStyle :=
    ABorderStyle[Style.LookAndFeel.Kind];
  AViewInfo.BackgroundColor := Style.Color;
end;

procedure TcxCheckGroupViewData.EditValueToDrawValue(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo);
var
  ASender: TObject;
  I: Integer;
begin
  with TcxCustomCheckGroupProperties(Properties) do
  begin
    if IsInplace then
      ASender := nil
    else
      ASender := Edit;
    TcxCheckGroupViewInfo(AViewInfo).SetButtonCount(Items.Count);
    if PreviewMode then
      TcxCheckGroupButtonViewInfo(AViewInfo.ButtonsInfo[0]).State := cbsChecked
    else
    begin
      CalculateCheckStatesByEditValue(ASender, AEditValue);
      for I := 0 to Items.Count - 1 do
        TcxCheckGroupButtonViewInfo(AViewInfo.ButtonsInfo[I]).State := CheckStates[I];
    end;
  end;
  if epoAutoHeight in PaintOptions then
    Include(AViewInfo.PaintOptions, epoAutoHeight);
end;

procedure TcxCheckGroupViewData.CalculateButtonNativeState(AViewInfo: TcxCustomEditViewInfo;
  AButtonViewInfo: TcxGroupBoxButtonViewInfo);
begin
end;

function TcxCheckGroupViewData.GetCaptionRectExtent: TRect;
begin
  Result.Top := 0;
  Result.Bottom := 0;
  if TcxCustomCheckGroupProperties(Properties).ItemAlignment = taLeftJustify then
  begin
    Result.Left := 3;
    Result.Right := 2;
  end
  else
  begin
    Result.Right := 2;
    Result.Left := 2;
  end;
end;

procedure TcxCheckGroupViewData.GetEditMetrics(AAutoHeight: Boolean;
  ACanvas: TcxCanvas; out AMetrics: TcxEditMetrics);
begin
  AMetrics.ClientLeftBoundCorrection := 6 - (5 +
    Integer(TcxCustomCheckGroupProperties(Properties).ItemAlignment =
    taRightJustify)) * Integer(IsInplace);
  AMetrics.ClientWidthCorrection := 5 * Integer(IsInplace) - 6;
  AMetrics.ColumnOffset := 6;
  if ACanvas = nil then
    Exit;

  AMetrics.ButtonSize := GetEditCheckSize(ACanvas,
    IsButtonNativeStyle(Style.LookAndFeel),
    TcxCustomCheckGroupProperties(Properties).FGlyph,
    TcxCustomCheckGroupProperties(Properties).GlyphCount,
    Style.LookAndFeel.Painter);
  with GetCaptionRectExtent do
    AMetrics.AutoHeightColumnWidthCorrection := Left + Right;
  AMetrics.ColumnWidthCorrection := AMetrics.AutoHeightColumnWidthCorrection;
  AMetrics.WidthCorrection := 6 - 5 * Integer(IsInplace);
  AMetrics.AutoHeightWidthCorrection := AMetrics.ClientWidthCorrection;
end;

{ TcxCustomCheckGroupProperties }

constructor TcxCustomCheckGroupProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FEditValueFormat := cvfIndices;
  FItemAlignment := taLeftJustify;
  FGlyphCount := 6;
end;

destructor TcxCustomCheckGroupProperties.Destroy;
begin
  if FGlyph <> nil then
    FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TcxCustomCheckGroupProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomCheckGroupProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with TcxCustomCheckGroupProperties(Source) do
      begin
        Self.AllowGrayed := AllowGrayed;
        Self.ItemAlignment := ItemAlignment;
        Self.WordWrap := WordWrap;
        Self.Glyph := Glyph;
        Self.GlyphCount := GlyphCount;
        Self.EditValueFormat := EditValueFormat;
        Self.OnEditValueToStates := OnEditValueToStates;
        Self.OnStatesToEditValue := OnStatesToEditValue;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomCheckGroupProperties.CompareDisplayValues(
  const AEditValue1, AEditValue2: TcxEditValue): Boolean;
var
  ACheckStates: TcxCheckStates;
begin
  CalculateCheckStatesByEditValue(nil, AEditValue1);
  ACheckStates := Copy(CheckStates);
  CalculateCheckStatesByEditValue(nil, AEditValue2);
  Result := CompareMem(@ACheckStates[0], @CheckStates[0],
    SizeOf(TcxCheckBoxState) * Length(CheckStates));
end;

class function TcxCustomCheckGroupProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxCheckGroup;
end;

function TcxCustomCheckGroupProperties.GetDisplayText(const AEditValue: TcxEditValue;
  AFullText: Boolean = False; AIsInplace: Boolean = True): WideString;
var
  ACheckStateNames: array[TcxCheckBoxState] of WideString;

  procedure InitCheckStateNames;
  begin
    ACheckStateNames[cbsUnchecked] :=
      cxGetResourceString(@cxSEditCheckGroupUnchecked);
    ACheckStateNames[cbsChecked] :=
      cxGetResourceString(@cxSEditCheckGroupChecked);
    ACheckStateNames[cbsGrayed] :=
      cxGetResourceString(@cxSEditCheckGroupGrayed);
  end;

var
  I: Integer;
begin
  CalculateCheckStatesByEditValue(nil, AEditValue);
  InitCheckStateNames;

  Result := '';
  for I := 0 to Items.Count - 1 do
  begin
    Result := Result + Items[I].Caption +
      cxGetResourceString(@cxSEditCheckGroupCaptionStateDelimiter) +
      ACheckStateNames[CheckStates[I]];
    if I < Items.Count - 1 then
      Result := Result + cxGetResourceString(@cxSEditCheckGroupFilterColumnSeparator);
  end;
end;

class function TcxCustomCheckGroupProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCheckGroupViewInfo;
end;

function TcxCustomCheckGroupProperties.CreateItems: TcxButtonGroupItems;
begin
  Result := TcxCheckGroupItems.Create(Self, TcxCheckGroupItem);
end;

class function TcxCustomCheckGroupProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxCheckGroupViewData;
end;

function TcxCustomCheckGroupProperties.HasDisplayValue: Boolean;
begin
  Result := True;
end;

procedure TcxCustomCheckGroupProperties.CalculateCheckStatesByEditValue(
  Sender: TObject; const AEditValue: TcxEditValue);
begin
  if Assigned(OnEditValueToStates) then
  begin
    SetLength(CheckStates, Items.Count);
    OnEditValueToStates(Sender, AEditValue, CheckStates);
  end
  else
    cxCheckBox.CalculateCheckStates(AEditValue, Items, EditValueFormat, CheckStates);
end;

procedure TcxCustomCheckGroupProperties.CalculateEditValueByCheckStates(
  Sender: TObject; out AEditValue: TcxEditValue);
begin
  if Assigned(OnStatesToEditValue) then
    OnStatesToEditValue(Sender, CheckStates, AEditValue)
  else
    AEditValue := cxCheckBox.CalculateCheckStatesValue(CheckStates, Items, EditValueFormat);
end;

function TcxCustomCheckGroupProperties.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
  begin
    FGlyph := TBitmap.Create;
    FGlyph.OnChange := GlyphChanged;
  end;
  Result := FGlyph;
end;

function TcxCustomCheckGroupProperties.GetItems: TcxCheckGroupItems;
begin
  Result := TcxCheckGroupItems(inherited Items);
end;

procedure TcxCustomCheckGroupProperties.GlyphChanged(Sender: TObject);
begin
  Changed;
end;

procedure TcxCustomCheckGroupProperties.SetAllowGrayed(Value: Boolean);
begin
  if Value <> FAllowGrayed then
  begin
    FAllowGrayed := Value;
    Changed;
  end;
end;

procedure TcxCustomCheckGroupProperties.SetEditValueFormat(Value: TcxCheckStatesValueFormat);
begin
  if Value <> FEditValueFormat then
  begin
    FEditValueFormat := Value;
    Changed;
  end;
end;

procedure TcxCustomCheckGroupProperties.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FreeAndNil(FGlyph)
  else
    Glyph.Assign(Value);
  Changed;
end;

procedure TcxCustomCheckGroupProperties.SetGlyphCount(Value: Integer);
begin
  if FGlyphCount <> Value then
  begin
    FGlyphCount := Value;
    if FGlyph <> nil then
      Changed;
  end;
end;

procedure TcxCustomCheckGroupProperties.SetItemAlignment(Value: TLeftRight);
begin
  if Value <> FItemAlignment then
  begin
    FItemAlignment := Value;
    Changed;
  end;
end;

procedure TcxCustomCheckGroupProperties.SetItems(Value: TcxCheckGroupItems);
begin
  inherited Items.Assign(Value);
end;

{ TcxCheckGroupCheckButtonViewInfo }

procedure TcxCheckGroupCheckButtonViewInfo.InternalPaint(ACanvas: TcxCanvas);
var
  ARect: TRect;
  ABitmap: TBitmap;
  ABitmapCanvas: TcxCanvas;
begin
  if Painter <> nil then
  begin
    ARect := ClientRect;
    ABitmap := cxCreateBitmap(ARect, pf32bit);
    ABitmapCanvas := TcxCanvas.Create(ABitmap.Canvas);
    try
      Painter.DrawGroupBoxBackground(ABitmapCanvas, ARect,
        Rect(0, 0, ABitmap.Width, ABitmap.Height));
      inherited InternalPaint(ABitmapCanvas);
      ACanvas.Draw(0, 0, ABitmap); 
    finally
      ABitmapCanvas.Free;
      ABitmap.Free;
    end;
  end else
    inherited InternalPaint(ACanvas);
end;

{ TcxCheckGroupButtonProperties }

function TcxCheckGroupButtonProperties.InternalGetGlyph: TBitmap;
begin
  Result :=
   (TcxCheckGroupButton(Owner).Owner as TcxCustomCheckGroup).ActiveProperties.Glyph;
end;

function TcxCheckGroupButtonProperties.IsEmbeddedEdit: Boolean;
begin
  Result := True;
end;

class function TcxCheckGroupButtonProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCheckGroupCheckButtonViewInfo;
end;

{ TcxCheckGroupButton }

destructor TcxCheckGroupButton.Destroy;
begin
  TcxCustomCheckGroup(GetOwner).InternalButtons.Remove(Self);
  inherited Destroy;
end;

function TcxCheckGroupButton.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or
    CheckGroup.DataBinding.ExecuteAction(Action);
end;

class function TcxCheckGroupButton.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCheckGroupButtonProperties;
end;

function TcxCheckGroupButton.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or
    CheckGroup.DataBinding.UpdateAction(Action);
end;

function TcxCheckGroupButton.CanAutoSize: Boolean;
begin
  Result := False;
end;

procedure TcxCheckGroupButton.DoExit;
begin
  inherited DoExit;
  CheckGroup.FFocusedItemIndex := CheckGroup.InternalButtons.IndexOf(Self);
end;

procedure TcxCheckGroupButton.Initialize;
begin
  inherited Initialize;
  CheckGroup.InternalButtons.Add(Self);
  Style.LookAndFeel.MasterLookAndFeel := CheckGroup.LookAndFeel;
  Keys := Keys + [kArrows];
  CheckTransparentBorder;
end;

function TcxCheckGroupButton.IsNativeBackground: Boolean;
begin
  Result := CheckGroup.IsNativeBackground;
end;

function TcxCheckGroupButton.IsNativeStyle: Boolean;
begin
  Result := CheckGroup.IsButtonNativeStyle;
end;

function TcxCheckGroupButton.IsTransparent: Boolean;
begin
  Result := CheckGroup.IsTransparent;
end;

procedure TcxCheckGroupButton.KeyDown(var Key: Word; Shift: TShiftState);

  procedure FocusNearestItem(ADown: Boolean);
  var
    AIndex, I, ADelta: Integer;
  begin
    with CheckGroup do
    begin
      AIndex := InternalButtons.IndexOf(Self);
      ADelta := Integer(ADown) - Integer(not ADown);
      I := AIndex;
      repeat
        I := I + ADelta;
        if I = InternalButtons.Count then
          I := 0
        else
          if I < 0 then
            I := InternalButtons.Count - 1;
        if Buttons[I].Enabled then
          Break;
      until I = AIndex;
      if I <> AIndex then
        Buttons[I].SetFocus;
    end;
  end;
var
  APrevKeyDownEvent: TKeyEvent;
begin
  _TcxContainerAccess.KeyDown(CheckGroup, Key, Shift);
  if Key = 0 then
    Exit;
  if not CheckGroup.IsInplace then
    if Key in [VK_UP, VK_LEFT] then
      FocusNearestItem(False)
    else
      if Key in [VK_DOWN, VK_RIGHT] then
        FocusNearestItem(True);
  APrevKeyDownEvent := OnKeyDown;
  OnKeyDown := nil;
  inherited KeyDown(Key, Shift);
  OnKeyDown := APrevKeyDownEvent;
end;

procedure TcxCheckGroupButton.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  if not IsDestroying then
    CheckTransparentBorder;
end;

procedure TcxCheckGroupButton.WndProc(var Message: TMessage);
begin
  with Message do
    if ((Msg = WM_LBUTTONDOWN) or (Msg = WM_LBUTTONDBLCLK)) and
      (CheckGroup.DragMode = dmAutomatic) and not(csDesigning in CheckGroup.ComponentState) then
    begin
      _TcxContainerAccess.BeginAutoDrag(CheckGroup);
      Exit;
    end;
  inherited WndProc(Message);
end;

function TcxCheckGroupButton.GetControl: TWinControl;
begin
  Result := Self;
end;

function TcxCheckGroupButton.GetControlContainer: TcxContainer;
begin
  Result := CheckGroup;
end;

procedure TcxCheckGroupButton.CheckTransparentBorder;
begin
  if Style.LookAndFeel.SkinPainter <> nil then
    ViewInfo.Transparent := True; 
  if not CheckGroup.IsInplace then
    Style.TransparentBorder := IsNativeStyle;
end;

function TcxCheckGroupButton.GetCheckGroup: TcxCustomCheckGroup;
begin
  Result := TcxCustomCheckGroup(Owner);
end;

{ TcxCustomCheckGroup }

procedure TcxCustomCheckGroup.Activate(var AEditData: TcxCustomEditData);
begin
  FFocusedItemIndex := 0;
  inherited Activate(AEditData);
end;

class function TcxCustomCheckGroup.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomCheckGroupProperties;
end;

procedure TcxCustomCheckGroup.GetTabOrderList(List: TList);
var
  AFocusedItemIndex: Integer;
begin
  inherited GetTabOrderList(List);
  List.Remove(Self);
  if Focused then
    AFocusedItemIndex := GetFocusedButtonIndex
  else
    AFocusedItemIndex := GetFirstEnabledItemIndex(FFocusedItemIndex);
  if (AFocusedItemIndex <> -1) and TabStop then
    List.Add(InternalButtons[AFocusedItemIndex]);
end;

procedure TcxCustomCheckGroup.SetFocus;
begin
  inherited SetFocus;
  FFocusedItemIndex := GetFirstEnabledItemIndex(FFocusedItemIndex);
  if FFocusedItemIndex <> -1 then
    TWinControl(InternalButtons[FFocusedItemIndex]).SetFocus;
end;

procedure TcxCustomCheckGroup.ArrangeButtons;
var
  AButtonViewInfo: TcxGroupBoxButtonViewInfo;
  I: Integer;
begin
  inherited ArrangeButtons;
  for I := 0 to InternalButtons.Count - 1 do
    with Buttons[I] do
    begin
      AButtonViewInfo := TcxGroupBoxButtonViewInfo(Self.ViewInfo.ButtonsInfo[I]);
      FColumn := AButtonViewInfo.Column;
      FRow := AButtonViewInfo.Row;
    end;
end;

function TcxCustomCheckGroup.GetButtonDC(AButtonIndex: Integer): THandle;
begin
  Result := Buttons[AButtonIndex].Canvas.Handle;
end;

function TcxCustomCheckGroup.GetButtonInstance: TWinControl;
begin
  Result := TcxCheckGroupButton.Create(Self, IsInplace);
end;

procedure TcxCustomCheckGroup.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle - [csAcceptsControls];
  FFocusedItemIndex := -1;
  InternalEditValue := 0;
end;

procedure TcxCustomCheckGroup.InternalValidateDisplayValue(const ADisplayValue: TcxEditValue);
var
  APrevEditValue: TcxEditValue;
  I: Integer;
begin
  APrevEditValue := FEditValue;
  SetLength(CheckStates, InternalButtons.Count);
  for I := 0 to High(CheckStates) do
    CheckStates[I] := Buttons[I].State;
  with ActiveProperties do
    CalculateEditValueByCheckStates(GetStandaloneEventSender(Self), FEditValue);
  if not InternalVarEqualsExact(APrevEditValue, FEditValue) then
    DoEditValueChanged;
end;

function TcxCustomCheckGroup.IsEditValueStored: Boolean;
begin
  Result := (ActiveProperties.EditValueFormat = cvfInteger) and (EditValue <> 0) or
    (ActiveProperties.EditValueFormat <> cvfInteger) and (VarToStr(EditValue) <> '');
end;

procedure TcxCustomCheckGroup.ParentBackgroundChanged;
var
  I: Integer;
begin
  for I := 0 to InternalButtons.Count - 1 do
    Buttons[I].ParentBackground := ParentBackground;
end;

procedure TcxCustomCheckGroup.PropertiesChanged(Sender: TObject);
begin
  inherited PropertiesChanged(Sender);
  InternalValidateDisplayValue(Null);
  DataBinding.UpdateDisplayValue;
end;

procedure TcxCustomCheckGroup.SynchronizeButtonsStyle;
var
  AButton: TcxCheckGroupButton;
  I: Integer;
begin
  inherited SynchronizeButtonsStyle;
  for I := 0 to InternalButtons.Count - 1 do
  begin
    AButton := Buttons[I];
    AButton.Style.BorderStyle := ActiveStyle.BorderStyle;
    if not AButton.Enabled then
    begin
      AButton.StyleDisabled.Color := ActiveStyle.Color;
      AButton.StyleDisabled.TextColor := StyleDisabled.GetVisibleFont.Color;
    end;
    AButton.Transparent := Transparent; // to repaint button
  end;
end;

procedure TcxCustomCheckGroup.SynchronizeDisplayValue;
var
  I: Integer;
begin
  if ActiveProperties.Items.ItemChanged then
    Exit;
  with ActiveProperties do
    CalculateCheckStatesByEditValue(GetStandaloneEventSender(Self), EditValue);
  if not ActiveProperties.AllowGrayed and Focused then
    for I := 0 to High(CheckStates) do
      if CheckStates[I] = cbsGrayed then
        CheckStates[I] := cbsUnchecked;

  FButtonStatesChanging := True;
  try
    for I := 0 to InternalButtons.Count - 1 do
      Buttons[I].State := CheckStates[I];
  finally
    FButtonStatesChanging := False;
  end;
end;

procedure TcxCustomCheckGroup.UpdateButtons;
const
  ALookAndFeelKindMap: array [TcxEditButtonStyle] of TcxLookAndFeelKind =
    (lfStandard, lfStandard, lfFlat, lfStandard, lfStandard,
    lfUltraFlat, lfOffice11);
var
 AButton: TcxCheckGroupButton;
 I: Integer;
begin
  inherited UpdateButtons;
  if FFocusedItemIndex >= InternalButtons.Count then
    FFocusedItemIndex := -1;
  for I := 0 to InternalButtons.Count - 1 do
  begin
    AButton := Buttons[I];
    AButton.Properties.BeginUpdate;
    try
      AButton.Properties.Alignment := ActiveProperties.ItemAlignment;
      AButton.Properties.AllowGrayed := ActiveProperties.AllowGrayed;
      AButton.Caption := ActiveProperties.Items[I].Caption;
      AButton.Properties.MultiLine := ActiveProperties.WordWrap;
      AButton.Properties.GlyphCount := ActiveProperties.GlyphCount;
      AButton.Properties.ReadOnly := ActiveProperties.ReadOnly and
        DataBinding.IsDataAvailable;
      if Length(ViewInfo.ButtonsInfo) > 0 then
        AButton.LookAndFeel.Kind := ALookAndFeelKindMap[ViewInfo.ButtonsInfo[0].Data.Style];
    finally
      AButton.Properties.EndUpdate;
      AButton.OnEditing := DoButtonEditing;
      AButton.OnFocusChanged := DoButtonFocusChanged;
      AButton.Properties.OnChange := DoButtonChange;
    end;
  end;
//  SynchronizeDisplayValue;
end;

function TcxCustomCheckGroup.WantNavigationKeys: Boolean;
begin
  Result := not IsInplace;
end;


function TcxCustomCheckGroup.GetFirstEnabledItemIndex(AStartIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AStartIndex = -1 then
    AStartIndex := 0;
  for I := 0 to InternalButtons.Count - 1 do
    if TWinControl(InternalButtons[(I + AStartIndex) mod InternalButtons.Count]).CanFocus then
    begin
      Result := (I + AStartIndex) mod InternalButtons.Count;
      Break;
    end;
end;

procedure TcxCustomCheckGroup.DoButtonChange(Sender: TObject);
begin
  if FButtonStatesChanging then
    Exit;
  LockChangeEvents(True);
  try
    InternalValidateDisplayValue(Null);
    ChangeHandler(Self);
    if ActiveProperties.ImmediatePost and CanPostEditValue and ValidateEdit(True) then
      InternalPostEditValue;
  finally
    LockChangeEvents(False);
  end;
end;

procedure TcxCustomCheckGroup.DoButtonEditing(Sender: TObject; var CanEdit: Boolean);
begin
  CanEdit := DoEditing;
end;

procedure TcxCustomCheckGroup.DoButtonFocusChanged(Sender: TObject);
begin
  FocusChanged;
end;

function TcxCustomCheckGroup.GetActiveProperties: TcxCustomCheckGroupProperties;
begin
  Result := TcxCustomCheckGroupProperties(InternalGetActiveProperties);
end;

function TcxCustomCheckGroup.GetButton(Index: Integer): TcxCheckGroupButton;
begin
  Result := TcxCheckGroupButton(InternalButtons[Index]);
end;

function TcxCustomCheckGroup.GetProperties: TcxCustomCheckGroupProperties;
begin
  Result := TcxCustomCheckGroupProperties(FProperties);
end;

function TcxCustomCheckGroup.GetState(Index: Integer): TcxCheckBoxState;
begin
  Result := Buttons[Index].State;
end;

procedure TcxCustomCheckGroup.SetProperties(Value: TcxCustomCheckGroupProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomCheckGroup.SetState(Index: Integer; Value: TcxCheckBoxState);
begin
  Buttons[Index].State := Value;
end;

{ TcxCheckGroup }

class function TcxCheckGroup.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCheckGroupProperties;
end;

function TcxCheckGroup.GetActiveProperties: TcxCheckGroupProperties;
begin
  Result := TcxCheckGroupProperties(InternalGetActiveProperties);
end;

function TcxCheckGroup.GetProperties: TcxCheckGroupProperties;
begin
  Result := TcxCheckGroupProperties(FProperties);
end;

procedure TcxCheckGroup.SetProperties(Value: TcxCheckGroupProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxFilterCheckGroupHelper }

class function TcxFilterCheckGroupHelper.GetEditValueFormat(
  AEditProperties: TcxCustomEditProperties): TcxCheckStatesValueFormat;
begin
  Result := TcxCustomCheckGroupProperties(AEditProperties).EditValueFormat;
end;

class function TcxFilterCheckGroupHelper.GetItems(
  AEditProperties: TcxCustomEditProperties): IcxCheckItems;
begin
  Result := TcxCustomCheckGroupProperties(AEditProperties).Items;
end;

class procedure TcxFilterCheckGroupHelper.InitializeItems(AProperties,
  AEditProperties: TcxCustomEditProperties);
begin
  inherited InitializeItems(AProperties, AEditProperties);
  TcxCustomCheckComboBoxProperties(AProperties).Glyph :=
    TcxCustomCheckGroupProperties(AEditProperties).Glyph;
  TcxCustomCheckComboBoxProperties(AProperties).GlyphCount :=
    TcxCustomCheckGroupProperties(AEditProperties).GlyphCount;
end;

initialization
  GetRegisteredEditProperties.Register(TcxCheckGroupProperties,
    scxSEditRepositoryCheckGroupItem);
  FilterEditsController.Register(TcxCheckGroupProperties,
    TcxFilterCheckGroupHelper);

finalization
  FilterEditsController.Unregister(TcxCheckGroupProperties,
    TcxFilterCheckGroupHelper);
  GetRegisteredEditProperties.Unregister(TcxCheckGroupProperties);

end.
