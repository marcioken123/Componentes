unit ElXHeader;
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

ElXHeader unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Types,
  Windows,
  Graphics,
  SysUtils,
  Controls,
  Messages,
  Math,
  Forms,
  ImgList,
  Themes,
  CommCtrl,
  StdCtrls,

  ElVCLUtils,
  ElTreeInplaceEditors,
  ElHeader,
  ElXTreeCell,

  LMDObjectList,
  LMDClass, LMDThemes,
  LMDSysIn,
  LMDTypes,
  LMDBmp,
  LMDUnicodeStrings,
  LMDGraphUtils,
  LMDProcs,
  LMDFiles,
  LMDHTMLUnit;

type
  TElXCustomHeader = class;
  TElXHeaderCell = class;
  TElXHeaderSections = class;
  TElXHeaderSection = class;
  TElXHeaderCellRow = class;

  TElXHeaderSectionEvent = procedure(Sender: TElXCustomHeader; Section: TElXHeaderSection) of object;
  TElXHeaderSectionCellEvent = procedure(Sender: TElXCustomHeader; Section: TElXHeaderSection; Cell: TElXHeaderCell) of object;
  TMeasureXSectionEvent = procedure(Sender: TObject; Section: TElXHeaderSection; var Size: TPoint) of object;

  TElXSectionRedrawEvent = procedure(Sender: TElXCustomHeader;
    Canvas: TCanvas; Section: TElXHeaderSection; R: TRect; Pressed: boolean) of object;
  TElXSectionCellDrawEvent = procedure (Sender: TElXCustomHeader; Canvas: TCanvas; Section: TElXHeaderSection; Cell: TElXHeaderCell; R: TRect; Pressed: Boolean) of object;

  TElXSectionMoveEvent = procedure(Sender: TElXCustomHeader;
    Section: TElXHeaderSection; OldPos, NewPos: integer) of object;
  TElXSectionResizingEvent = procedure(Sender: TElXCustomHeader;
    Section: TElXHeaderSection; State: TElHResizingStates; Width: integer) of object;

  TXSectionChangeEvent = procedure(Sender: TElXCustomHeader; Section: TElXHeaderSection; Change: TSectionChangeMode) of object;
  TElXHeaderLookupEvent = procedure(Sender: TObject; Section: TElXHeaderSection; var Text: TElFString) of object;
  TElXHeaderLookupDoneEvent = procedure(Sender: TObject;
    Section: TElXHeaderSection;
    Text: TElFString;
    Accepted: boolean) of object;
  TXPictureNeededEvent = procedure(Sender: TElXCustomHeader; Section: TElXHeaderSection; var ImageIndex: integer) of object;

  TElXHeaderSection = class(TElHeaderSection)
  private
//    FAlignment: TAlignment;
//    FPicAlign: TAlignment;
    FTrackedCellIndx: Integer;
//    procedure SetAlignment(const Value: TAlignment);
  protected
    FSections: TElXHeaderSections;
    FClickedCellIndx: Integer;
    FSortedCellIndx: Integer;
    procedure SetParentSection(newValue: TElXHeaderSection);
    function GetParentSection: TElXHeaderSection;
    function GetCellIndexByY(AY: Integer): Integer;
    function GetIndex: Integer; override;
    procedure SetIndex(Value: integer);override;
    function GetPosition: Integer;override;
    function GetText: TLMDString; override;
    procedure SetText(value: TLMDString); override;
    procedure SetSortMode(value: TElSSortMode);override;
    function GetCell(ARowIndex: Integer): TElXHeaderCell;
    procedure SetAlignment(value: TElSAlignment);override;
  public
    procedure UpdateSection;override;
    constructor Create(AOwner: TElXCustomHeader; ASections: TElXHeaderSections);
    destructor Destroy; override;
    // Temporarily (???) been made public for drawing purpose
//    property PicAlign: TAlignment read FPicAlign;
//    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
//    property PictureAlign: TAlignment read FPicAlign write FPicAlign;
    property Cell[ARowIndex: Integer]: TElXHeaderCell read GetCell;
  published
    property ParentSection: TElXHeaderSection read GetParentSection write SetParentSection;
  end;

  TElXHeaderSections = class(TElHeaderSections)
  protected
    FIgnoreGutterState: Boolean;
    function GetSectionsOrder: string; override;
    procedure SetSectionsOrder(newValue: string); override;
    function GetCellIndex(ACell: TElXCustomTreeCell): Integer;
    function GetCount: Integer; override;
    function GetSection(AIndex: Integer): TElHeaderSection; override;
    procedure SetSection(index: integer; Section: TElHeaderSection); override;
    function GetXSection(AIndex: Integer): TElXHeaderSection; virtual;
    procedure SetXSection(index: integer; Section: TElXHeaderSection); virtual;
    function GetSectionByPos(index: integer): TElHeaderSection; override;
    function GetXSectionByPos(index: integer): TElXHeaderSection; virtual;
    procedure IntReadData(Stream: TStream; ClearCurrent: boolean); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure CellsReadData(Stream: TStream);virtual;
    procedure CellsWriteData(Stream: TStream);virtual;
    function GetSectionList: TLMDObjectList;
    function GetCustomHeaderSection(AIndex: Integer): TElXHeaderSection;
    property SectionList: TLMDObjectList read GetSectionList;
    procedure CheckJoin(Index: Integer);
    procedure MoveXSection(ASection: TElXHeaderSection; ANewPos: integer); virtual;
  public
    procedure Clear; override;
    procedure SaveToFile(FileName: TLMDString);override;
    procedure LoadFromFile(FileName: TLMDString);override;
    destructor Destroy; override;
    procedure Assign(source: TPersistent); override;
    function AddSection: TElXHeaderSection; reintroduce;
    function CreateSection: TElHeaderSection; override;
    function InsertSection(AColumnIndex: integer): TElHeaderSection; override;
//    procedure Clear; override;
    procedure ClearSorting; virtual;
    procedure MoveSection(ASection: TElHeaderSection; ANewPos: integer); override;
    property Sections[AIndex: Integer]: TElXHeaderSection read GetCustomHeaderSection;
    property ItemByPos[Index: integer]: TElXHeaderSection read GetXSectionByPos;
    property Item[Index: integer]: TElXHeaderSection read GetXSection write SetXSection; default;
    procedure DeleteSection(Section: TElHeaderSection); override;
  end;

  TElXCustomHeader = class(TCustomElHeader)
  protected
    FSectionOffset: Integer;
    FRowsList: TLMDObjectList;
    FOnMeasureSection: TMeasureXSectionEvent;
    FOnFilterCall: TElXHeaderSectionEvent;
    FOnSectionResizing: TElXSectionResizingEvent;
    FOnPictureNeeded: TXPictureNeededEvent;
    FOnSectionClick: TElXHeaderSectionEvent;
    FOnSectionDraw: TElXSectionRedrawEvent;
    FOnSectionCellPostDraw, FOnSectionCellDraw: TElXSectionCellDrawEvent;
    FOnSectionResize: TElXHeaderSectionEvent;
    FOnSectionDelete: TElXHeaderSectionEvent;
    FOnSectionMove: TElXSectionMoveEvent;
    FOnSectionReindex: TElXSectionMoveEvent;
    FOnVisibleChange: TElXHeaderSectionEvent;
    FOnSectionChange: TXSectionChangeEvent;
    FOnSectionCreate: TElXHeaderSectionEvent;
    FOnHeaderLookup: TElXHeaderLookupEvent;
    FOnHeaderLookupDone: TElXHeaderLookupDoneEvent;
    FOnSectionExpand: TElXHeaderSectionEvent;
    FOnSectionCollapse: TElXHeaderSectionEvent;
    FOnSectionAutoSize: TElXHeaderSectionEvent;
    FOnSectionCellClick: TElXHeaderSectionCellEvent;
    FRowHeight: Integer;
    FDelSectionNum: Integer;
    FAddedSectionNum: Integer;
    procedure CancelOldRightAlignedOrder;override;
    function SectionOffset: Integer;
    procedure SetFixedColNum(Value: Integer);override;
    function GetFixedColNum: Integer;override;
    function CreateHeaderCellRow: TElXHeaderCellRow;virtual;
    function  CreateSections: TElHeaderSections; override;
    procedure SetRowHeight(Value: Integer);virtual;
    procedure GetDragImage(XPos, YPos: Integer);reintroduce;
    procedure TriggerSectionAutoSizeEvent(Section: TElHeaderSection); override;
    function GetPressedItem: TElXHeaderSection;
    function GetPressed: Boolean;
    function GetDropSrc: TElXHeaderSection;
    function GetDropTrg: TElXHeaderSection;
    function GetTrackSection: TElXHeaderSection;
    function GetAlphaImages: TCustomImageList;
    function GetRender: TLMDHTMLRender;
    function GetItem(AIndex: Integer): TElXHeaderCellRow;
    procedure SetRowCount(const AValue: Integer);virtual;
    function GetRowCount: Integer;
    procedure Paint; override;
    procedure RedrawSection(ACanvas: TCanvas; ASection: TElHeaderSection; AR: TRect; AxHOffs: integer; ADithered: Boolean); override;
    procedure RedrawSectionCell(ACanvas: TCanvas; ASection: TElHeaderSection; AR: TRect; AxHOffs: integer; ADithered: Boolean; ARowIndex: Integer); virtual;
    function GetXSectionRect(AItemNum, SectionPos: integer): TRect;
    function GetDragSectionRect(SectionPos: integer): TRect;virtual;
    procedure RedrawSections; override;
    procedure InvalidateRight(AValue: integer); override;
    function GetSections: TElXHeaderSections;
    procedure SetSections(const Value: TElXHeaderSections);
    function InResizeArea(AX, AY: integer; var AHitSection: TElXHeaderSection): boolean; reintroduce;
    procedure IntLButtonDown(XPos, YPos: SmallInt);override;
    procedure IntLButtonUp(XPos, YPos: SmallInt);override;
    procedure IntMouseMove(XPos, YPos: SmallInt); override;
    procedure DoSectionMove(Section: TElHeaderSection; OldPos, NewPos: integer); override;
    procedure DoSectionReindex(Section: TElHeaderSection; OldIndex, NewIndex: integer); override;
    procedure DoSectionClick(Section: TElHeaderSection); override;
    procedure DoSectionDraw(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean); override;
    procedure DoSectionCellDraw(Canvas: TCanvas; Section: TElXHeaderSection; Cell: TElXHeaderCell; R: TRect; Pressed: boolean); virtual;
    procedure DoSectionResize(Section: TElHeaderSection); override;
    procedure DoNotifySectionChange(Section: TElHeaderSection; Change: TSectionChangeMode); override;
    procedure DoSectionCreate(Section: TElHeaderSection); override;
    procedure DoSectionDelete(Section: TElHeaderSection); override;
    procedure DoVisChanged(Section: TElHeaderSection); override;
    procedure DoSectionLookupEvent(Section: TElHeaderSection; var Text: TElFString); override;
    procedure DoSectionLookupDoneEvent(Section: TElHeaderSection; Text: TLMDString; Accepted: boolean); override;
    procedure DoSectionExpandEvent(Section: TElHeaderSection); override;
    procedure DoSectionCollapseEvent(Section: TElHeaderSection); override;
    procedure DoSectionCellClick(Section: TElXHeaderSection; Cell: TElXHeaderCell);virtual;
    procedure DoSectionCellPostDraw(Canvas: TCanvas; Section: TElXHeaderSection; Cell: TElXHeaderCell; R: TRect; Pressed: Boolean);virtual;
    procedure RecheckMasterCells;virtual;

    procedure DoSectionResizing(Section: TElHeaderSection; State: TElHResizingStates; NewWidth: integer); override;
    procedure TriggerFilterCallEvent(Section: TElHeaderSection); override;
    procedure TriggerMeasureSectionEvent(Section: TElHeaderSection; var Size: TPoint); override;
    function DoGetPicture(Section: TElHeaderSection): integer; override;
    function GetResizableWidth: integer;override;
//    function RigthAndHaveGutter: Boolean;override;
    procedure AdjustHeaderHeight; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Sections: TElXHeaderSections read GetSections write SetSections;
    function GetSectionRect(SectionNum: integer): TRect;override;
    procedure Loaded; override;
    function MeasureSectionWidth(Section: TElHeaderSection; TextWidth:PInteger;SectionHeight: PInteger): integer; override;

    function CalcHeaderHeight: integer; override;

    property RowsList: TLMDObjectList read FRowsList;
    property RowCount: Integer read GetRowCount write SetRowCount default 1;
    property Rows[AIndex: Integer]: TElXHeaderCellRow read GetItem;

    // Temporarily (???) been made public for drawing purpose
    property PressedSection: TElXHeaderSection read GetPressedItem;
    property Pressed: Boolean read GetPressed;
    property DropSrc: TElXHeaderSection read GetDropSrc;
    property DropTrg: TElXHeaderSection read GetDropTrg;
    property TrackSection: TElXHeaderSection read GetTrackSection;
    property AlphaImages: TCustomImageList read GetAlphaImages;
    property HTMLRender: TLMDHTMLRender read GetRender;
    property OnSectionAutoSize: TElXHeaderSectionEvent read FOnSectionAutoSize write FOnSectionAutoSize;
    property OnSectionClick: TElXHeaderSectionEvent read FOnSectionClick
      write FOnSectionClick;
    property OnSectionCellPostDraw: TElXSectionCellDrawEvent read FOnSectionCellPostDraw
      write FOnSectionCellPostDraw;
    property OnSectionCellDraw: TElXSectionCellDrawEvent read FOnSectionCellDraw
      write FOnSectionCellDraw;
    property OnSectionDraw: TElXSectionRedrawEvent read FOnSectionDraw
      write FOnSectionDraw;
    property OnSectionResize: TElXHeaderSectionEvent read FOnSectionResize
      write FOnSectionResize;

    property OnSectionResizing: TElXSectionResizingEvent read FOnSectionResizing
      write FOnSectionResizing;
    property OnMeasureSection: TMeasureXSectionEvent read FOnMeasureSection write FOnMeasureSection;
    property OnFilterCall: TElXHeaderSectionEvent read FOnFilterCall write FOnFilterCall;
    property OnPictureNeeded: TXPictureNeededEvent read FOnPictureNeeded
      write FOnPictureNeeded;

    property OnSectionDelete: TElXHeaderSectionEvent read FOnSectionDelete
      write FOnSectionDelete;
    property OnSectionMove: TElXSectionMoveEvent read FOnSectionMove
      write FOnSectionMove;
    property OnSectionReindex: TElXSectionMoveEvent read FOnSectionReindex write FOnSectionReindex;
    property OnSectionShowHide: TElXHeaderSectionEvent read FOnVisibleChange
      write FOnVisibleChange;
    property OnSectionChange: TXSectionChangeEvent read FOnSectionChange
      write FOnSectionChange;
    property OnSectionCreate: TElXHeaderSectionEvent read FOnSectionCreate
      write FOnSectionCreate;
    property OnHeaderLookup: TElXHeaderLookupEvent read FOnHeaderLookup
      write FOnHeaderLookup;
    property OnHeaderLookupDone: TElXHeaderLookupDoneEvent read FOnHeaderLookupDone
      write FOnHeaderLookupDone;
    property OnSectionExpand: TElXHeaderSectionEvent read FOnSectionExpand
      write FOnSectionExpand;
    property OnSectionCollapse: TElXHeaderSectionEvent read FOnSectionCollapse
      write FOnSectionCollapse;
    property OnSectionCellClick: TElXHeaderSectionCellEvent read FOnSectionCellClick
      write FOnSectionCellClick;
    property RowHeight: Integer read FRowHeight write SetRowHeight;
  end;

  TElXHeaderCell = class(TElXBaseCell)
  private
  protected
    FOwner: TElXHeaderCellRow;
    FDithered: Boolean;
    FXOffset: Integer;
    FHeaderSection: TElXHeaderSection;
    FLeft: Integer;
    FWidth: Integer;
    FTag: Integer;
    FAlignment: TElSAlignment;
    function GetHeaderSection: TPersistent; virtual;
    function GetText: TLMDString; override;
    function GetIndex: Integer; override;
    function GetLeft: Integer; virtual;
    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
    procedure SetText(const AText: TLMDString); override;
    function GetJointCellMaster: TElXHeaderCell;
    function GetRowIndex: Integer;override;
    function GetBottom: Integer;
    function GetTop: Integer;
    procedure LoadFromStream(Stream : TStream);override;
    procedure WriteToStream(Stream : TStream);override;
    procedure SetAlignment(value: TElSAlignment);
  public
    constructor Create(AOwner: TElXHeaderCellRow; AHeaderSection: TElXHeaderSection);reintroduce;
    procedure Paint(const ACanvas: TCanvas; const ARect: TRect); virtual;
    procedure Join(ARowCount, AColumnCount: Integer); override;
    procedure Split; override;
    procedure SmartSplit; virtual;
    property RowIndex: Integer read GetRowIndex;
    property HeaderSection: TElXHeaderSection read FHeaderSection;
    property Dithered: Boolean read FDithered write FDithered;
//    property XOffset: Integer read FXOffset write FXOffset;
    property Left: Integer read GetLeft;
    property Top: Integer read GetTop;
    property Tag: Integer read FTag write FTag default 0;
    property Bottom: Integer read GetBottom;
    property Owner: TElXHeaderCellRow read FOwner write FOwner;
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
    property Alignment: TElSAlignment read FAlignment write SetAlignment default hsaLeft;
    property Index;
    property Text;
    property JointCellRole;
    property JointRowCount;
    property JointColumnCount;
    property JointCellMaster:TElXHeaderCell read GetJointCellMaster;
  end;

  TElXHeaderCellRow = class(TElXBaseCellRow)
  protected
    FOwner: TElXCustomHeader;
    FComplexHeight: Integer;
    function CellOffset: integer;
    function GetCell(AIndex: Integer): TElXHeaderCell;reintroduce;virtual;
    function IntGetCount: Integer; override;
    procedure SplitCells;
    function CreateCell(AHeaderSection: TElXHeaderSection): TElXHeaderCell; reintroduce;
    function GetHeight: Integer; virtual;
    procedure SetHeight(newValue: Integer);virtual;
    function GetRowIndex: Integer; virtual;
    function GetHeader: TElXCustomHeader;
  public
    constructor Create(AOwner: TElXCustomHeader);virtual;
    destructor Destroy; override;
    function InsertCell(AIndex: Integer; AHeaderSection: TElXHeaderSection; Convert: Boolean = True): TElXHeaderCell; virtual;
    function IndexOf(ACell: TElXHeaderCell): Integer; reintroduce;virtual;
    procedure Delete(AIndex: Integer); override;
    property Cell[AIndex: Integer]: TElXHeaderCell read GetCell; default;
    property Height: Integer read GetHeight write SetHeight;
    property RowIndex: Integer read GetRowIndex;
    property Count;
  end;

  TElXHeader = class(TElXCustomHeader)
  published
    property RowCount;
    property RowHeight;
    property Owner;
    property ActiveFilterColor;
    property AllowDrag;
    property Align default alTop;
    property Color;
    property DefaultWidth;
    property Enabled;
    property Flat;
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
    property MoveOnDrag;
    property Font;
    property FilterColor;
    property Images;
    property AlphaForImages;

    property LookupStyle;
    property ImageForm;

    property InvertSortArrows;

    property LockHeight;

    property MultiSort;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ResizeOnDrag;
    property RightAlignedText;
    property RightAlignedOrder;
    property SectionsWidth;
    property Sections;
    property ShowHint;
    property StickySections;
    property Tracking;

    property Storage;
    property StoragePath;

    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property WrapCaptions;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSectionResizing;
    property OnMeasureSection;
    property OnSectionClick;
    property OnSectionResize;
    property OnSectionDraw;
    property OnSectionDelete;
    property OnSectionMove;
    property OnSectionShowHide;
    property OnPictureNeeded;
    property OnSectionChange;
    property OnSectionCreate;
    property OnSectionExpand;
    property OnSectionCollapse;
    property OnHeaderLookup;
    property OnHeaderLookupDone;
    property OnSectionCellClick;
    property OnSectionCellDraw;
    property OnSectionCellPostDraw;
    property OnHTMLImageNeeded;
    property OnHTMLImageNeededEx;

    property OnSectionAutoSize;
    property OnFilterCall;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;
  end;

implementation

uses
  ElXTree , ElXPThemedControl, UxTheme;

  type
  THackCustomElXTree = class(TCustomElXTree)
  end;
  { TElXHeaderSection }

constructor TElXHeaderSection.Create(AOwner: TElXCustomHeader;
  ASections: TElXHeaderSections);
begin
  inherited Create(AOwner);
  FSections := ASections;
  FTrackedCellIndx := -1;
  FClickedCellIndx := -1;
  FSortedCellIndx := 0;
end;

destructor TElXHeaderSection.Destroy;
//var
//  LItem: TElXHeaderCellRow;
//  i: integer;
begin
//  if Index > 0 then
//  begin
//    for i := 0 to (FOwner as TElXCustomHeader).FRowsList.Count - 1 do
//    begin
//      LItem := (FOwner as TElXCustomHeader).FRowsList[i];
//      LItem.Delete(Index-Litem.FCellOffset);
////      LItem.Delete(Position+Litem.FCellOffset);
//    end;
//  end;
  inherited;
end;

function TElXHeaderSection.GetText: TLMDString;
begin
  if (FOwner as TElXCustomHeader).RowCount > 0 then
    Result := (FOwner as TElXCustomHeader).Rows[0].Cell[Position].Text
  else
    Result := FText;
end;

procedure TElXHeaderSection.SetText(value: TLMDString);
begin
  if Text = value then Exit;
  if (FOwner as TElXCustomHeader).RowCount > 0 then
    (FOwner as TElXCustomHeader).Rows[0].Cell[position].Text := Value
  else
    FText := Value;
  if FStyle = ElhsText then
     UpdateSection;
end;

procedure TElXHeaderSection.SetIndex(Value: integer);
begin
  FIndex := Value + (FOwner as TElXCustomHeader).SectionOffset;
end;

function TElXHeaderSection.GetIndex: Integer;
begin
  Result := inherited GetIndex - (FOwner as TElXCustomHeader).SectionOffset;
end;

procedure TElXHeaderSection.UpdateSection;
var
  R, R1: TRect;
  i: integer;
begin
  if (not Visible) or (not FOwner.HandleAllocated) then Exit;
  FOwner.BeginUpdate;
  try
    R := (FOwner as TElXCustomHeader).GetXSectionRect(0, Cell[0].JointCellMaster.Index);
    for i := 1 to (FOwner as TElXCustomHeader).RowCount - 1 do
    begin
      R1 := (FOwner as TElXCustomHeader).GetXSectionRect(i, Cell[i].JointCellMaster.Index);
      R := Rect(min(R1.Left,R.Left),min(R1.Top,R.Top),max(R1.Right,R.Right),max(R1.Bottom,R.Bottom));
    end;
    InvalidateRect(FOwner.Handle, @R, False);
  finally
    FOwner.EndUpdate;
  end;
end;

procedure TElXHeaderSection.SetSortMode(value: TElSSortMode);
//var
//  i, j: integer;
begin
  if FSortMode = value then Exit;
  if Value = hsmNone then
    FSortedCellIndx := -1
  else
    if FSortedCellIndx = -1 then
      FSortedCellIndx := 0;
  inherited SetSortMode(value);
//  FSortMode := value;
//  if AutoSize then
//     FOwner.TriggerSectionAutoSizeEvent(Self);
//  if (not FOwner.HandleAllocated) then Exit;
//  if FShowSortMark then
//    FOwner.Invalidate;//Repaint;
end;

function TElXHeaderSection.GetCell(ARowIndex: Integer): TElXHeaderCell;
begin
//  result := (FOwner as TElXCustomHeader).Rows[ARowIndex].Cell[Index];
  result := (FOwner as TElXCustomHeader).Rows[ARowIndex].Cell[Position];
end;

function TElXHeaderSection.GetCellIndexByY(AY: Integer): Integer;
var
  i, ATop: integer;
begin
  Result := -1;
  ATop := Top;
  for i := 0 to (FOwner as TElXCustomHeader).RowCount - 1 do
  begin
    if LMDInRange(AY, ATop, ATop + (FOwner as TElXCustomHeader).RowHeight) then
    begin
      Result := i;
      Exit;
    end;
    ATop := ATop + (FOwner as TElXCustomHeader).RowHeight;
  end;
end;

function TElXHeaderSection.GetParentSection: TElXHeaderSection;
begin
  Result := inherited GetParentSection as TElXHeaderSection;
end;

procedure TElXHeaderSection.SetParentSection(newValue: TElXHeaderSection);
begin
  inherited SetParentSection(newValue);
end;

procedure TElXHeaderSection.SetAlignment(value: TElSAlignment);
var
  i: integer;
begin
  inherited;
  if Index >= 0 then
  begin
    for i := 0 to (FOwner as TElXCustomHeader).FRowsList.Count - 1 do
    begin
      Cell[i].FAlignment := value;
    end;
  end;
end;

function TElXHeaderSection.GetPosition: Integer;
begin
  Result := inherited GetPosition - (FOwner as TElXCustomHeader).SectionOffset
end;

{ TElXHeaderSections }

destructor TElXHeaderSections.Destroy;
begin
  inherited;
end;

procedure TElXHeaderSections.Clear;
var
  i: Integer;
begin
  if (csReading in FOwner.ComponentState) or (csWriting in FOwner.ComponentState) or FIgnoreGutterState then
    inherited
  else
    for i := Count - 1 downto 0 do
    begin
      DeleteSection(Sections[i]);
    end;
end;

procedure TElXCustomHeader.CancelOldRightAlignedOrder;
var
  i, j: integer;
begin
  for i := 0 to FRowsList.Count - 1 do
  begin
    for j := 0 to ((TElXHeaderCellRow(FRowsList[i]).Count + SectionOffset) div 2) - 1 do
    begin
      TElXHeaderCellRow(FRowsList[i]).Move(j,TElXHeaderCellRow(FRowsList[i]).Count + SectionOffset - 1 - j);
      TElXHeaderCellRow(FRowsList[i]).Move(TElXHeaderCellRow(FRowsList[i]).Count + SectionOffset - 2 - j, j);
    end;
  end;
  inherited;
end;

function TElXHeaderSections.GetSectionsOrder: string;
var
  i, i1, i2: integer;
  Section: TElHeaderSection;
begin
  Result := '';
  i1 := 0;
  i2 := GetCount - 1;
  for i := i1 to i2 do
  begin
    Section := GetSectionByPos(i);
    Result := Result + 'i' + IntToStr(Section.Index) + ':w' + IntToStr(Section.Width) + ':v';
    if Section.Visible then
      Result := Result + 't,'
    else
      Result := Result + 'f,';
  end;
end; { GetSectionsOrder }

procedure TElXHeaderSections.SetSectionsOrder(newValue: string);
var
  i: integer;
  Section: TElXHeaderSection;
  s: string;
begin
  if (csDesigning in Owner.ComponentState) or (csLoading in Owner.ComponentState) or
     ((Owner.Owner <> nil) and ((csDesigning in Owner.Owner.ComponentState) or
                               (csLoading in Owner.Owner.ComponentState))) then
    Exit;
  i := 0;
  while newValue <> '' do
  begin
    s := copy(newValue, 2, pos(':', newValue) - 2);
    delete(newValue, 1, pos(':', newValue));
    Section := Item[StrToInt(s)];
    if Section <> nil then
    begin
      MoveSection(Section, i);
      s := copy(newValue, 2, pos(':', newValue) - 2);
      delete(newValue, 1, pos(':', newValue));
      Section.Width := StrToInt(s);
      if (pos('vf,', newValue) = 1) or (pos('vf;', newValue) = 1) then
        Section.Visible := False
      else
        Section.Visible := True;
      delete(newValue, 1, 3);
      Inc(i);
    end
    else
      delete(newValue, 1, 3);
  end;
end;

function TElXHeaderSections.GetCellIndex(ACell: TElXCustomTreeCell): Integer;
begin
  Result := FList.IndexOf(ACell);
end;

function TElXHeaderSections.GetCount: Integer;
begin
  Result := inherited GetCount - (FOwner as TElXCustomHeader).SectionOffset;
end;

function TElXHeaderSections.GetCustomHeaderSection(
  AIndex: Integer): TElXHeaderSection;
begin
  Result := GetSection(AIndex) as TElXHeaderSection;
end;

function TElXHeaderSections.AddSection: TElXHeaderSection;
begin
  Result := inherited AddSection as TElXHeaderSection;
end;

function TElXHeaderSections.CreateSection: TElHeaderSection;
var
  LHeader: TElXCustomHeader;
  LSection: TElXHeaderSection;
begin
  LHeader := FOwner as TElXCustomHeader;
  LSection := TElXHeaderSection.Create(LHeader, Self);
  Result := LSection;
end;

function TElXHeaderSections.InsertSection(AColumnIndex: Integer): TElHeaderSection;
var
  LRowIndex: Integer;
  LHeader: TElXCustomHeader;
  LSection: TElXHeaderSection;
  LItem: TElXHeaderCellRow;
begin
  FOwner.BeginUpdate;
  LSection := inherited InsertSection(AColumnIndex) as TElXHeaderSection;
  Result := LSection;
  LHeader := FOwner as TElXCustomHeader;
  for LRowIndex := 0 to LHeader.RowCount - 1 do
  begin
    LItem := LHeader.Rows[LRowIndex];
    LItem.InsertCell(AColumnIndex,LSection);
  end;
  TElXCustomHeader(FOwner).FAddedSectionNum := AColumnIndex;
  FOwner.EndUpdate;
  if TElXCustomHeader(FOwner).FUpdateCount > 0 then
    TElXCustomHeader(FOwner).DoSectionCreate(LSection);
end;

function TElXHeaderSections.GetSection(AIndex: Integer): TElHeaderSection;
begin
  Result := inherited GetSection(AIndex + (FOwner as TElXCustomHeader).SectionOffset);
end;

procedure TElXHeaderSections.SetSection(index: integer;
  Section: TElHeaderSection);
begin
  inherited SetSection(Index + (FOwner as TElXCustomHeader).SectionOffset, Section);
end;

function TElXHeaderSections.GetSectionList: TLMDObjectList;
begin
  Result := FList;
end;

procedure TElXHeaderSections.IntReadData(Stream: TStream;
  ClearCurrent: boolean);
var
  LItem: TElXHeaderCellRow;
  i: integer;
begin
  for i := 0 to (Owner as TElXCustomHeader).RowCount - 1 do
  begin
    LItem := (Owner as TElXCustomHeader).Rows[i];
    LItem.Clear;
  end;
  inherited;
end;

procedure TElXHeaderSections.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Cells', CellsReadData, CellsWriteData, True);
end;

procedure TElXHeaderSections.CellsReadData(Stream: TStream);
var
  LItem: TElXHeaderCellRow;
  i, j: integer;
begin
  if (Owner.Owner is TCustomElXTree) then
  (Owner as TElXCustomHeader).SetRowCount(THackCustomElXTree(Owner.Owner).FHeaderRowCount);
  for i := 0 to (Owner as TElXCustomHeader).RowCount - 1 do
  begin
    LItem := (Owner as TElXCustomHeader).Rows[i];
    for j := 0 to Count - 1 do
    begin
      LItem.Cell[j-LItem.CellOffset].LoadFromStream(Stream);
    end;
  end;
end;

procedure TElXHeaderSections.CellsWriteData(Stream: TStream);
var
  i, j : integer;
  LItem: TElXHeaderCellRow;
begin
  for i := 0 to (Owner as TElXCustomHeader).RowCount - 1 do
  begin
    LItem := (Owner as TElXCustomHeader).Rows[i];
    for j := 0 to Count - 1 do
    begin
      LItem.Cell[j-LItem.CellOffset].WriteToStream(Stream);
    end;
  end;
end;

procedure TElXHeaderSections.CheckJoin(Index: Integer);
var
  LMasterCell: TElXHeaderCell;
  LSTxt: TLMDString;
  jcc, jrc, i: integer;
  LHCellRow: TElXHeaderCellRow;
  LColumnIndex: Integer;
begin
  for i := 0 to (FOwner as TElXCustomHeader).RowCount - 1 do
  begin
    LHCellRow := TElXHeaderCellRow((FOwner as TElXCustomHeader).FRowsList[i]);
//      if LHCellRow.Cell[Index].JointCellRole = jcrSingle then
    begin
      jrc := 1;
      jcc := 1;
      LSTxt := LHCellRow.Cell[Index].Text;
      LMasterCell := nil;
      if Length(LSTxt) > 0 then
      begin
        // find leftmost cell with same text - this will be Master cell
        LColumnIndex := Index;
        while (LColumnIndex >= 0) and (LHCellRow.Cell[LColumnIndex].Text = LSTxt) do
          dec(LColumnIndex);
        LMasterCell := LHCellRow.Cell[LColumnIndex + 1];

        LColumnIndex := Max(LColumnIndex + LMasterCell.JointColumnCount, Index);
        while (LColumnIndex < Count) and (LHCellRow.Cell[LColumnIndex].Text = LSTxt) do
          inc(LColumnIndex);

        jcc := (LColumnIndex - LMasterCell.Index);
      end;
      if Assigned(LMasterCell) and (LMasterCell.JointCellRole <> jcrSlave) and ((jrc > 1) or (jcc > 1)) then
      begin
        LMasterCell.Join(jrc,jcc);
      end;
    end;
  end;
end;

procedure TElXHeaderSections.MoveXSection(ASection: TElXHeaderSection; ANewPos: integer);
var
  LOwner: TElXCustomHeader;
  i, LOldPos: Integer;
  LHCellRow: TElXHeaderCellRow;
  LItem: TElXHeaderSection;
begin
  LOwner := FOwner as TElXCustomHeader;
//  AOldPos := ASection.Index;
  LOldPos := ASection.Position;
  if ANewPos >= Count then
    exit;
  LItem := ItemByPos[ANewPos];
  if not Assigned(LItem) then
    exit;

  ANewPos := LItem.Position;

  if ASection.Locked or (ANewPos = LOldPos) then
    Exit;
  if (ANewPos < LOwner.FixedColNum) and not ASection.Locked then
    ANewPos := LOwner.FixedColNum;

  for i := 0 to LOwner.RowCount - 1 do
  begin
    LHCellRow := TElXHeaderCellRow(LOwner.FRowsList[i]);
    if LHCellRow.Cell[LOldPos].JointCellRole <> jcrSingle then
    begin
      if LHCellRow.Cell[LOldPos].JointCellMaster.JointColumnCount > 1 then
        LHCellRow.Cell[LOldPos].SmartSplit;
    end;
    if LHCellRow.Cell[ANewPos].JointCellRole <> jcrSingle then
    begin
      if LHCellRow.Cell[ANewPos].JointCellMaster.JointColumnCount > 1 then
        LHCellRow.Cell[ANewPos].SmartSplit;
    end;
  end;
  FList.Move(LOldPos+TElXCustomHeader(Owner).SectionOffset, ANewPos+TElXCustomHeader(Owner).SectionOffset);

  for i := 0 to TElXCustomHeader(Owner).RowCount - 1 do
  begin
    (TElXCustomHeader(Owner).Rows[i] as TElXHeaderCellRow).Move(LOldPos+TElXCustomHeader(Owner).SectionOffset, ANewPos+TElXCustomHeader(Owner).SectionOffset);
  end;
//    inherited MoveSection(ASection,NewPos);

  CheckJoin(LOldPos);
  for i := Max(0, ANewPos - 1) to Min(Count - 1, ANewPos + 1) do
    CheckJoin(i);
  LOwner.DoSectionMove(ASection, LOldPos + LOwner.FSectionOffset, ANewPos + LOwner.FSectionOffset);
end;

procedure TElXHeaderSections.MoveSection(ASection: TElHeaderSection;
  ANewPos: Integer);
var
  LOwner: TElXCustomHeader;
//  LOldPos: integer;
begin
  LOwner := FOwner as TElXCustomHeader;
  if ASection.Locked and (ANewPos >= LOwner.FixedColNum) then
    Exit;
  LOwner.BeginUpdate;
  try
    // LOldPos := ASection.Position;
    MoveXSection(ASection as TElXHeaderSection,ANewPos);
    // LOwner.DoSectionMove(ASection, LOldPos + LOwner.FSectionOffset, ANewPos + LOwner.FSectionOffset);
  finally
    EndUpdate;
    if LOwner.HandleAllocated then
      LOwner.Invalidate;
    if (LOwner.Owner is TCustomElXTree ) then
      (LOwner.Owner as TCustomElXTree).Refresh;
  end;
end;

procedure TElXHeaderSections.ClearSorting;
var
  i: integer;
begin
  for i := 0 to SectionList.Count - 2 do
    Sections[i].SetSortMode(hsmNone);
end;

procedure TElXHeaderSections.DeleteSection(Section: TElHeaderSection);
var
  LItem: TElXHeaderCellRow;
  i: integer;
begin
  Owner.BeginUpdate;
  try
    if Assigned(Section) then
    begin
      for i := 0 to (FOwner as TElXCustomHeader).FRowsList.Count - 1 do
      begin
        LItem := TElXHeaderCellRow((FOwner as TElXCustomHeader).FRowsList[i]);
        if Section.Position < LItem.Count then
          LItem.Delete(Section.Position);
      end;
      (FOwner as TElXCustomHeader).FDelSectionNum := Section.Index;
    end
    else
      (FOwner as TElXCustomHeader).FDelSectionNum := -1;
    inherited;
  finally
    Owner.EndUpdate;
  end;
end;

function TElXHeaderSections.GetSectionByPos(index: integer): TElHeaderSection;
begin
  Result := inherited GetSectionByPos(index + (FOwner as TElXCustomHeader).SectionOffset) as TElXHeaderSection;
end;

procedure TElXHeaderSections.Assign(source: TPersistent);
var
  i, j: integer;
  SHeader, DHeader: TElXCustomHeader;
begin
  if source is TElXHeaderSections then
  begin
    FOwner.BeginUpdate;
    try
      SHeader := (source as TElXHeaderSections).Owner as TElXCustomHeader;
      DHeader := FOwner as TElXCustomHeader;
      inherited;
      DHeader.RowCount := SHeader.RowCount;
      for i := 0 to SHeader.RowCount - 1  do
      begin
        for j := 0 to SHeader.Rows[i].Count - 1 do
        begin
          DHeader.Rows[i].Cell[j].Text := SHeader.Rows[i].Cell[j].Text;
          DHeader.Rows[i].Cell[j].Alignment := SHeader.Rows[i].Cell[j].Alignment;
          if SHeader.Rows[i].Cell[j].FJointCellRole = jcrMaster then
            DHeader.Rows[i].Cell[j].Join(SHeader.Rows[i].Cell[j].FJointRowCount,SHeader.Rows[i].Cell[j].FJointColumnCount);
        end;
      end;
    finally
      TElXCustomHeader(FOwner).FAddedSectionNum := -1;
      TElXCustomHeader(FOwner).FDelSectionNum := -1;
      TElXCustomHeader(FOwner).DeletionHappened := False;
      FOwner.EndUpdate;
      FOwner.Invalidate;
    end;
  end
  else
    inherited;
end;

function TElXHeaderSections.GetXSectionByPos(
  index: integer): TElXHeaderSection;
begin
  Result := GetSectionByPos(index) as TElXHeaderSection;
end;

function TElXHeaderSections.GetXSection(
  AIndex: Integer): TElXHeaderSection;
begin
  result :=  GetSection(AIndex) as TElXHeaderSection;
end;

procedure TElXHeaderSections.SetXSection(index: integer;
  Section: TElXHeaderSection);
begin
  SetSection(index,Section);
end;

procedure TElXHeaderSections.LoadFromFile(FileName: TLMDString);
var
  T: TStream;
  Ver, rc, i: Integer;
begin
  T := nil;
  FIgnoreGutterState := True;
  try
    T := TLMDFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    FOwner.BeginUpdate;
    LoadFromStream(T);
    if (T.Size - T.Position) > 0 then
    begin
      T.ReadBuffer(Ver, SizeOf(Ver));
      if ver > 0 then
      begin
        T.ReadBuffer(rc, SizeOf(rc));
        TElXCustomHeader(FOwner).RowCount := rc;
        CellsReadData(T);
      end;
    end
    else
    begin
      for i := 0 to Count - 1 do
      begin
        Item[i].Text := Item[i].FText;
        Item[i].SetAlignment(Item[i].Alignment);
      end;
    end;
  finally
    T.Free;
    FIgnoreGutterState := False;
    if (FOwner <> nil) and (FOwner.HandleAllocated) then
      FOwner.Invalidate;
    FOwner.EndUpdate;
  end;
end;

procedure TElXHeaderSections.SaveToFile(FileName: TLMDString);
var
  T: TStream;
  Ver, rc: Integer;
begin
  T := nil;
  FIgnoreGutterState := True;
  try
    T := TLMDFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
    ver := 1;
    T.WriteBuffer(Ver, SizeOf(Ver));
    rc := TElXCustomHeader(FOwner).RowCount;
    T.WriteBuffer(rc, SizeOf(rc));
    CellsWriteData(T);
  finally
    T.Free;
    FIgnoreGutterState := False;
  end;
end;

{ TElXCustomHeader }

constructor TElXCustomHeader.Create(AOwner: TComponent);
var
  LItem: TElXHeaderCellRow;
begin
  FRowsList := TLMDObjectList.Create;
  inherited;
  FSectionOffset := 0;
  FRowHeight := inherited CalcHeaderHeight;
  LItem := CreateHeaderCellRow;
  FRowsList.Add(LItem);
  FDelSectionNum := -1;
  FAddedSectionNum := -1;
end;

destructor TElXCustomHeader.Destroy;
var
  i: Integer;
  LItem: TElXHeaderCellRow;
begin
  for i := 0 to FRowsList.Count - 1 do
  begin
    LItem := TElXHeaderCellRow(FRowsList[FRowsList.Count - 1]);
    LItem.Destroy;
    FRowsList.Remove(LItem);
  end;
  FRowsList.Free;
  inherited;
end;

{function TElXCustomHeader.RigthAndHaveGutter: Boolean;
begin
  Result := (FSectionOffset > 0) and RightAlignedOrder;
end;}

function TElXCustomHeader.MeasureSectionWidth(Section: TElHeaderSection;
        TextWidth:PInteger;SectionHeight: PInteger): integer;
var
  stxt: TLMDString;
  LAlignment: TElSAlignment;
  LCellAlignment: array of TElSAlignment;
  i: integer;
begin
  BeginUpdate;
  stxt := Section.Text;
  SetLength(LCellAlignment, RowCount);
  for i := 0 to RowCount - 1 do
  begin
    LCellAlignment[i] := (Section as TElXHeaderSection).Cell[i].FAlignment;
  end;
  LAlignment := Section.Alignment;
  Section.Alignment := (Section as TElXHeaderSection).Cell[0].Alignment;
  for i := 0 to RowCount - 1 do
  begin
    if Length((Section as TElXHeaderSection).Cell[i].FText) > Length(stxt) then
    begin
      Section.Text := (Section as TElXHeaderSection).Cell[i].FText;
      Section.Alignment := (Section as TElXHeaderSection).Cell[i].Alignment;
    end;
  end;
  Result := inherited MeasureSectionWidth(Section, TextWidth, SectionHeight);
  Section.Text := stxt;
  Section.Alignment := LAlignment;
  for i := 0 to RowCount - 1 do
  begin
    (Section as TElXHeaderSection).Cell[i].FAlignment := LCellAlignment[i];
  end;
  if Assigned(SectionHeight) then
    SectionHeight^ := SectionHeight^ * RowCount;
  EndUpdate;
end;

function TElXCustomHeader.CalcHeaderHeight: integer;
var
  LItemNum: Integer;
  LItem: TElXHeaderCellRow;
begin
//  if LockHeight then
  begin
    Result := 0;
    for LItemNum := 0 to FRowsList.Count - 1 do
    begin
      LItem := TElXHeaderCellRow(FRowsList[LItemNum]);
      Inc(Result, LItem.Height);
    end;
  end;
end;

procedure TElXCustomHeader.AdjustHeaderHeight;
begin
  inherited;
  if RowCount > 0 then
    RowHeight := Height div RowCount
  else
    RowHeight := Height;
end;

function TElXCustomHeader.GetRowCount: Integer;
begin
  if Assigned(FRowsList) then
    Result := FRowsList.Count
  else
    Result := -1;
end;

procedure TElXCustomHeader.SetRowCount(const AValue: Integer);
var
  LRowCount: Integer;
  i, j: Integer;
//  LHeader: TElXHeaderSections;
  LItem: TElXHeaderCellRow;
begin
  LRowCount := FRowsList.Count;
  if (LRowCount < 0) or (LRowCount = AValue) or (AValue < 1) then
    Exit;
  if LRowCount > AValue then
    for i := LRowCount - 1 downto AValue do
    begin
      LItem := TElXHeaderCellRow(FRowsList[AValue]);
//      h := LItem.Height;
      LItem.Destroy;
      FRowsList.Remove(LItem);
//      Height := Height - h;
    end
  else
    for i := LRowCount to AValue - 1 do
    begin
      LItem := CreateHeaderCellRow;
      FRowsList.Add(LItem);
      for j := 0 to Sections.Count + SectionOffset - 1 do
      begin
        LItem.InsertCell(j, Sections.ItemByPos[j - SectionOffset], False);
      end;
    end;
  Height := CalcHeaderHeight;
end;

procedure TElXCustomHeader.RedrawSection(ACanvas: TCanvas;
  ASection: TElHeaderSection; AR: TRect; AxHOffs: integer; ADithered: Boolean);
var
  LCell: TElXHeaderCell;
  i: integer;
  ATop: integer;
begin
  ATop := 0;
  for i := 0 to RowCount - 1 do
  begin
//    LCell := Rows[i].Cell[ASection.Index];
    LCell := Rows[i].Cell[ASection.Position];
    LCell.Dithered := ADithered;
    LCell.FXOffset := AxHOffs;
    LCell.Paint(ACanvas, Rect(AR.Left,AR.Top + ATop,AR.Right,AR.Top + ATop + LCell.Height));
    ATop := ATop + LCell.Height;
  end;
end;

function TElXCustomHeader.GetXSectionRect(AItemNum, SectionPos: integer): TRect;
var
  LSection: TElXHeaderSection;
  LItem: TElXHeaderCellRow;
  LCell: TElXHeaderCell;
  i: Integer;
begin
  LItem := Rows[AItemNum];
  LCell := LItem.Cell[SectionPos];
  LCell := LCell.JointCellMaster as TElXHeaderCell;
  LSection := LCell.HeaderSection;
  Result.Top := 0;
  for i := 0 to AItemNum - 1 do
    Inc(Result.Top, Rows[i].Height);
  if RightAlignedOrder then
  begin
    Result.Right := LSection.Right;
    Result.Left := Result.Right - LCell.Width;
  end
  else
  begin
    Result.Left := LSection.Left;
    Result.Right := Result.Left + LCell.Width;
  end;
  Result.Bottom := Result.Top + LCell.Height;
  if not LSection.Locked and (FHPos <> 0) then
    OffsetRect(Result, -FHPos, 0);
end;

procedure TElXCustomHeader.RedrawSections;

  procedure DrawSectionsRange(AItem: TElXHeaderCellRow; AItemNum: Integer; AMin, AMax: Integer; IsFixed: Boolean = True);
  var
    i, l: Integer;
    LCell: TElXHeaderCell;
    LR, LTmpR: TRect;
    LSection: TElXHeaderSection;
    TmpBmp : TBitmap;
  begin
//    if AMax <= AMin then
//      Exit;
    for i := AMin to AMax - 1 do
    begin
      LSection := Sections[i];
      if not Assigned(LSection) or not LSection.Visible then
        continue;
      LCell := LSection.GetCell(AItemNum);
      LR := GetDragSectionRect(LSection.Position);
      if IntersectRect(LTmpR, LR, Canvas.ClipRect) and (LSection.Style = elhsOwnerDraw) then
      begin
        (LSection.FOwner as TElXCustomHeader).DoSectionDraw(Canvas, LSection, LR, ((LSection = (LSection.FOwner as TElXCustomHeader).PressedSection) and ((LSection.FOwner as TElXCustomHeader).Pressed = True)) or (((LSection.FOwner as TElXCustomHeader).DropSrc = LSection)));
        //Continue;
      end;
      if not Assigned(LCell) or (LCell.JointCellRole = jcrSlave) then
        continue;

      LR := GetXSectionRect(AItemNum, LSection.Position);
      if (LR.Right < LR.Left) or (LR.Bottom < LR.Top) then
        exit;
      TmpBmp := TBitmap.Create;
      TmpBmp.Width := LR.Right - LR.Left;
      TmpBmp.Height := LR.Bottom - LR.Top;
      TmpBmp.Canvas.Font.assign(Canvas.Font);
      bitblt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, Canvas.Handle, LR.Left, LR.Top, SRCCOPY);
      l := 0;
      if not IsFixed and RightAlignedOrder then
      begin
        if SectionOffset > 0 then
          if (LR.Right > ClientRect.Right - ClientRect.Left - FFixedColWidth) then
            l := LR.Right - (Width - FFixedColWidth)
          else
            l := 0
        else
          if (LR.Right > ClientRect.Right - ClientRect.Left - FFixedColWidth) then
            l := LR.Right - Width + FFixedColWidth
          else
            l := 0;
        //TmpBmp.Width := max(0, TmpBmp.Width - max(0, l));
      end;
      RedrawSectionCell(TmpBmp.Canvas, LCell.HeaderSection, Rect(0,0,TmpBmp.Width,TmpBmp.Height), 0, False,AItemNum);
      if IsFixed then
        bitblt(Canvas.Handle, LR.left, LR.Top, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY)
      else
      begin
        if not RightAlignedOrder then
        begin
          if LR.Left < FFixedColWidth then
            l := FFixedColWidth - LR.Left
          else
            l := 0;
          bitblt(Canvas.Handle, max(LR.left,FFixedColWidth), LR.Top, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, l, 0, SRCCOPY);
        end
        else
          bitblt(Canvas.Handle, LR.left, LR.Top, TmpBmp.Width - l, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
      end;
      TmpBmp.Free;
    end;
  end;

var
  R: TRect;
  i: Integer;
  LCount: Integer;
  LItem: TElXHeaderCellRow;
  BgRect: TRect;
  ACtl: TWinControl;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  if IsRectEmpty(Canvas.ClipRect) then
    Exit;
  LUseThemeMode := UseThemeMode;
  CalcFixedColWidth;
  for i := FRowsList.Count - 1 downto 0 do begin
    LItem := Rows[i];
    LCount := LItem.Count;
    DrawSectionsRange(LItem, i, 0, FixedColNum);
    DrawSectionsRange(LItem, i, FixedColNum, LCount, false);
    if (SectionOffset > 0) then
      DrawSectionsRange(LItem, i, -FSectionOffset, -FSectionOffset + 1);
  end;

  R := ClientRect;
  if FRightAlignedOrder then
  begin
    if Width > FColumnsWidth then
      R.Right := Width - FColumnsWidth
    else
      R.Left := R.Right + 100;
  end
  else
    R.Left := SectionsWidth - FHPos;
 // if (FSectionOffset > 0) and not RightAlignedOrder then
 //   inc(R.Left, Sections[-1].Width);
    if R.Left < R.Right then
  begin
    if (LUseThemeMode = ttmNone) then
    begin
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        if (FImgForm.Control <> Self) then
        begin
          ACtl := FImgForm.GetRealControl;
          BgRect := R;
          OffsetRect(BgRect, -SectionsWidth, 0);
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
          BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
          BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
          FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
        end;
      end
      else
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(R);
      end;
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
    end
    else
    begin
      LDetails.Element := teHeader;
      LDetails.Part := 0;
      LDetails.State := 0;
      LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, R, nil);
      // DrawThemeBackground(Theme, Canvas.Handle, 0, 0, R, nil);
    end;
  end;
end;

procedure TElXCustomHeader.Paint;
begin
  inherited Paint;
end;

function TElXCustomHeader.GetItem(AIndex: Integer): TElXHeaderCellRow;
begin
  Result := TElXHeaderCellRow(FRowsList[AIndex]);
end;

procedure TElXCustomHeader.InvalidateRight(AValue: integer);
begin
  if (SectionOffset = 0) then
    inherited InvalidateRight(AValue)
  else
  if (AValue > 0) then
    inherited InvalidateRight(AValue - 1)
  else
    if (AValue < Sections.Count) then
      inherited InvalidateRight(AValue);
end;

//procedure TElXCustomHeader.InvalidateGutterSection;
//begin
//
//end;

function TElXCustomHeader.GetSections: TElXHeaderSections;
begin
  Result := inherited Sections as TElXHeaderSections;
end;

procedure TElXCustomHeader.SetSections(
  const Value: TElXHeaderSections);
begin
  inherited SetSections(Value);
end;

function TElXCustomHeader.InResizeArea(AX,AY : integer; var AHitSection: TElXHeaderSection): boolean;
var
  LSection: TElXHeaderSection;
  LLeft: integer;
  LCell: TElXHeaderCell;
  i,j: integer;
begin
  Result := False;
  LSection := TElXHeaderSection(GetSectionAt(AX, 0));
  if not Assigned(LSection) or (RowCount < 1) then
    exit;
  LCell := LSection.Cell[0] as TElXHeaderCell;
  i := max (min(Trunc(AY/LCell.Height), RowCount - 1), 0);
  j := LCell.Index;
  LCell := Rows[i].Cell[j];
  AHitSection := LSection;
  if not Assigned(LSection) then
  begin
    if Sections.Count > 0 then
      LSection := TElXHeaderSection(Sections.LastVisibleSection);
    if Assigned(LSection) then
    begin
      LLeft := LSection.Right;
      if not LSection.Locked then
        dec(LLeft, FHPos);
      if RightAlignedOrder then
      begin
        if LLeft + LSection.Width + ResizeWidth > AX then
        begin
          if (J+1 < Rows[i].Count) and (LCell.JointCellMaster <> Rows[i].Cell[j+1].JointCellMaster)  then
            Result := True
          else
            Result := False;
          AHitSection := LSection;
          Exit;
        end;
      end
      else
        if LLeft + ResizeWidth > AX then
        begin
          if (J+1 < Rows[i].Count) and (LCell.JointCellMaster <> Rows[i].Cell[j+1].JointCellMaster)  then
            Result := True
          else
            Result := False;
          AHitSection := LSection;
          Exit;
        end;
    end;
    Result := False;
    AHitSection := nil;
    Exit;
  end
  else
  begin
    if LSection.Width < ResizeWidth * 3 then
      Result := False
    else
    begin
      LLeft := LSection.Left;
      if not LSection.Locked then
        Dec(LLeft, FHPos);
      if RightAlignedOrder then
      begin
        if LLeft + LSection.Width - ResizeWidth < AX then
        begin
          if (Sections.GetPrevVisibleSection(LSection) = nil) then
          begin
            Result := False;
            AHitSection := LSection;
            Exit;
          end;
          if LSection.Index > 0 then
          begin
            if (j > 0) and (LCell.JointCellMaster <> Rows[i].Cell[j-1].JointCellMaster) then
              Result := True
            else
              Result := False;
            AHitSection := Sections.GetPrevVisibleSection(LSection) as TElXHeaderSection;
          end
          else
            Result := False;
          Exit;
        end;
        if (LCell.JointCellRole = jcrSingle) or (LCell.JointColumnCount<2) then
          Result := (LSection.Index >= 0) and (LLeft + ResizeWidth >= AX)
        else
          Result := False;
      end
      else
      begin
        if LLeft + ResizeWidth > AX then
        begin
          if Sections.GetPrevVisibleSection(LSection) = nil then
          begin
            Result := False;
            AHitSection := LSection;
            Exit;
          end;
          if LSection.Index > 0 then
          begin
            if (j > 0) and (LCell.JointCellMaster <> Rows[i].Cell[j-1].JointCellMaster) then
              Result := True
            else
              Result := False;
            AHitSection := Sections.GetPrevVisibleSection(LSection) as TElXHeaderSection;
          end
          else
            Result := False;
          Exit;
        end;
        if (LCell.JointCellRole = jcrSingle) or (LCell.JointColumnCount<2) then
          Result := (LSection.Index >= 0) and (LLeft + LSection.FWidth - ResizeWidth <= AX)
        else
          Result := False;
      end;
    end;
  end;
end;

procedure TElXCustomHeader.IntMouseMove(XPos, YPos: SmallInt);
var
  LSection: TElXHeaderSection;
  LCellIndx: integer;
  AMsg: TMessage;
  NewPos,
  NewWidth,
  L: integer;
  XOffs: integer;
  TmpBmp: TBitmap;
  X: integer;
  LUseTHemeMode: TLMDThemeMode;
//  LDropSrc: TElXHeaderSection;

  function FixedRighterSections(Section: TElHeaderSection): integer;
  var
    i: integer;
    LSection: TElXHeaderSection;
  begin
    Result := 0;
    for i := Section.Position + 1 to FSections.Count - 1 do
    begin
      LSection := FSections.ItemByPos[i] as TElXHeaderSection;
      if not LSection.Resizable then
        Inc(Result, LSection.Width);
    end;
  end;

begin
  LUseTHemeMode := UseThemeMode;
  x := XPos;
  if FPressed and FAllowDrag and Assigned(FPressedItem) and (not FPressedItem.Locked) then
  begin
    if Assigned(FPressedItem) and not Assigned(FDropSrc)
      and (Sqrt(Sqr(FPressCoord.X - XPos) + Sqr(FPressCoord.Y - YPos)) >= 5)
    then
    begin
      (*
      FDropSrc := FTrackSection;
      FDropSrc.UpdateSection;
      if FDropSrc <> FPressedItem then
      *)
      FTrackSection := nil;
      FDropSrc := FPressedItem; // as TElXHeaderSection;
      FPressed := False;
      FDropSrc.UpdateSection;

      GetDragImage(FPressCoord.X,FPressCoord.Y);
      //s.index is used there which is incorrect for ElXHeader

//      LSection := GetSectionAt(FPressCoord.X, FPressCoord.Y) as TElXHeaderSection;
      LSection := FPressedItem as TElXHeaderSection;

//      if Assigned(LSection) and not LSection.Locked then
        Inc(FPressCoord.X, FHPos);

      SetCapture(Handle);
      FDropTrg := nil;
      FDragCoord := FPressCoord;
      DragRect := GetDragSectionRect((FDropSrc as TElXHeaderSection).Position);

    end;
  end;
  if FAllowDrag and not FPressed and Assigned(FDropSrc) then
  begin
    FDropTrg := GetSectionAt(X, YPos); // as TElXHeaderSection;
    if FMoveOnDrag and (FDropSrc <> FDropTrg) then
    begin
      if not Assigned(FDropTrg) then
      begin
        NewPos := Sections.Count;
        Sections.MoveSection(FDropSrc, NewPos);
      end
      else if ((FDropSrc.Position < FDropTrg.Position) and (FDropTrg.Right - FDropSrc.Width < XPos))
        or ((FDropSrc.Position > FDropTrg.Position) and (FDropTrg.Left + FDropSrc.Width > XPos)) then
      begin
        NewPos := FDropTrg.Position; // FSectionsList.IndexOf(FDropTrg);
        Sections.MoveSection(FDropSrc, NewPos);
      end;
    end;

    if not FDropSrc.Locked then
      XOffs := FHPos
    else
      XOffs := 0;

    TmpBmp := TBitmap.Create;
    TmpBmp.Width := DragRect.Right - DragRect.Left + Abs(FDragCoord.x - (XPos + xOffs));
    TmpBmp.Height := DragRect.Bottom - DragRect.Top;
    bitblt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, Canvas.Handle, Min(DragRect.Left, DragRect.Left - (FDragCoord.x - (XPos + xOffs))),  DragRect.Top, SRCCOPY);
    if SaveBmp <> nil then
      bitblt(TmpBmp.Canvas.Handle,
        Max(0, (FDragCoord.x - (XPos + xOffs))), 0,
        SaveBmp.Width, TmpBmp.Height,
        SaveBmp.Canvas.Handle, 0, 0, SRCCOPY);

    OffsetRect(DragRect, - (FDragCoord.x - (XPos + xOffs)), 0);

    if SaveBmp = nil then
    begin
      SaveBmp := TBitmap.Create;
      SaveBmp.Width  := DragRect.Right - DragRect.Left;
      SaveBmp.Height := DragRect.Bottom - DragRect.Top;
    end;
    bitblt(SaveBmp.Canvas.Handle, 0, 0,
      SaveBmp.Width, SaveBmp.Height, TmpBmp.Canvas.Handle,
      Max(0, -(FDragCoord.x - (XPos + xOffs))), 0, SRCCOPY);

    if LMDSIWindowsNTUp then
      MaskBlt(TmpBmp.Canvas.Handle, -(FDragCoord.x - (XPos + xOffs)), DragRect.Top, DragBmp.Width - 1, DragBmp.Height - 1, DragBmp.Canvas.Handle,
        0, 0, DragBmpMask.MaskHandle, 0, 0, ((SRCCOPY shl 8) and $FF000000) or SRCAND)
    else

    BitBlt(TmpBmp.Canvas.Handle, -(FDragCoord.x - (XPos + xOffs)), DragRect.Top, DragBmp.Width, DragBmp.Height, DragBmp.Canvas.Handle,
           0, 0, SRCCOPY);

    bitblt(Canvas.Handle,
           Min(DragRect.Left, DragRect.Left + (FDragCoord.x - (XPos + xOffs))),
           DragRect.Top,
           TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FDragCoord.X := XPos;

    if not FDropSrc.Locked then
      Inc(FDragCoord.X, FHPos);

    TmpBmp.Free;
  end;

  if (FTracking or (LUseTHemeMode <> ttmNone))
    and not FResizing
    and not Assigned(FDropSrc)
    and not (csNoStdEvents in ControlStyle)
    and not (csDesigning in ComponentState)
    and FMouseInControl
  then
  begin
    LSection := FTrackSection as TElXHeaderSection;
    FTrackSection := GetSectionAt(X, YPos) as TElXHeaderSection;
    if Assigned(FTrackSection) then
      LCellIndx := (FTrackSection as TElXHeaderSection).GetCellIndexByY(YPos)
    else
      LCellIndx := -1;
    if (LCellIndx > -SectionOffset) and Assigned(FTrackSection) then
      if (FTrackSection as TElXHeaderSection).Cell[LCellIndx].JointCellRole = jcrSlave then
        FTrackSection := (FTrackSection as TElXHeaderSection).Cell[LCellIndx].JointCellMaster.FHeaderSection;
    if (LSection <> FTrackSection) or ((Assigned(FTrackSection)) and ((FTrackSection as TElXHeaderSection).FTrackedCellIndx <> LCellIndx)) then
    begin
      if LSection <> nil then
      begin
        LSection.FTrackedCellIndx := -1;
        LSection.UpdateSection;
      end;
      if FTrackSection <> nil then
      begin
        (FTrackSection as TElXHeaderSection).FTrackedCellIndx := LCellIndx;
        FTrackSection.UpdateSection;
      end;
    end;
  end;
  if not FPressed and not FResizing and not Assigned(FDropSrc) and FMouseInControl then
  begin
    if InResizeArea(XPos, YPos, LSection) and (not (csDesigning in ComponentState)) and (LSection.Resizable) then
    begin
      if Screen.Cursor <> crHSplit then
        Screen.Cursor := crHSplit;
    end
    else if Screen.Cursor = crHSplit then
      Screen.Cursor := Cursor;

    if (FHintSection <> nil) and (FHintSection <> LSection) and (LSection <> nil) and ShowHint and (LSection.Hint <> '') then
    begin
      // P := ClientToScreen(SmallPointToPoint(Message.Pos));
      // Application.ActivateHint(P);
      ZeroMemory(@AMsg, sizeof(AMsg));
      TWMMouse(AMsg).XPos := -10000;
      TWMMouse(AMsg).YPos := -10000;
      Application.HintMouseMessage(Self, AMsg);
      TWMMouse(AMsg).XPos := XPos;
      TWMMouse(AMsg).YPos := YPos;
      Application.HintMouseMessage(Self, AMsg);
      end;
  end;
  if FResizing then
  begin
    if RightAlignedOrder then
    begin
      L := FResizeSection.Right;
      if not FResizeSection.Locked then
        XOffs := - FHPos
      else
        XOffs := 0;
      if (XPos - xOffs - FLineTab <= L)  and (not StickySections or
         (XPos - xOffs - FLineTab < Width - FixedRighterSections(FResizeSection))) then
      begin
        NewWidth := L - XPos- FLineTab;
        if not FResizeSection.Locked then
          Inc(NewWidth, FHPos);
        with FResizeSection do
          if LMDInRange(NewWidth, MinWidth, MaxWidth) then
          begin
            if FResizeOnDrag then
            begin
              Width := NewWidth;
              InvalidateRight(FResizeSection.Index);
              Update;
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end
            else
            begin
              DrawLine(True);
              FHeaderLine := XPos;
              DrawLine(False);
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end;
          end;
      end;
    end
    else
    begin
      L := FResizeSection.Left;
      if not FResizeSection.Locked then
        XOffs := - FHPos
      else
        XOffs := 0;

      if (XPos - xOffs - FLineTab >= L)  and (not StickySections or
         (XPos - xOffs - FLineTab < Width - FixedRighterSections(FResizeSection))) then
      begin
        NewWidth := XPos - L - FLineTab;

        if not FResizeSection.Locked then
          Inc(NewWidth, FHPos);
        with FResizeSection do
          if LMDInRange(NewWidth, MinWidth, MaxWidth) then
          begin
            if FResizeOnDrag then
            begin
              Width := NewWidth;
              InvalidateRight(FResizeSection.Index);
              Update;
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end
            else
            begin
              DrawLine(True);
              FHeaderLine := L + NewWidth;
              if not FResizeSection.Locked then
                Dec(FHeaderLine, FHPos);
              DrawLine(False);
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end;
          end;
      end; // really in client width
    end;
  end;
end;

function TElXCustomHeader.GetPressedItem: TElXHeaderSection;
begin
  Result := FPressedItem as TElXHeaderSection;
end;

function TElXCustomHeader.GetPressed: Boolean;
begin
  Result := FPressed;
end;

function TElXCustomHeader.GetDropSrc: TElXHeaderSection;
begin
  Result := FDropSrc as TElXHeaderSection;
end;

function TElXCustomHeader.GetDropTrg: TElXHeaderSection;
begin
  Result := FDropTrg as TElXHeaderSection;
end;

function TElXCustomHeader.GetTrackSection: TElXHeaderSection;
begin
  Result := FTrackSection as TElXHeaderSection;
end;

procedure TElXCustomHeader.DoSectionMove(Section: TElHeaderSection; OldPos,
  NewPos: integer);
begin
  if assigned(FOnSectionMove) then FOnSectionMove(Self, Section as TElXHeaderSection, OldPos, NewPos);
end;

function TElXCustomHeader.GetAlphaImages: TCustomImageList;
begin
  Result := FAlphaImages;
end;

function TElXCustomHeader.GetRender: TLMDHTMLRender;
begin
  Result := FRender;
end;

procedure TElXCustomHeader.SetRowHeight(Value: Integer);
var
  i: integer;
begin
  FRowHeight := Value;
  for i := 0 to RowCount - 1 do
  begin
    Rows[i].Height := Value;
  end;
//  Height := CalcHeaderHeight;
  Height := Value * RowCount;
  if (Owner is TCustomElXTree) then
    (Owner as TCustomElXTree).Refresh;
end;

procedure TElXCustomHeader.TriggerSectionAutoSizeEvent(
  Section: TElHeaderSection);
begin
  if (assigned(FOnSectionAutoSize)) then
    FOnSectionAutoSize(Self, Section as TElXHeaderSection);
end;

function TElXCustomHeader.GetDragSectionRect(SectionPos: integer): TRect;
var
  LSection: TElXHeaderSection;
begin
  LSection := Sections.GetXSectionByPos(SectionPos);
  Result.Top := 0;
  Result.Left := LSection.Left;
  Result.Right := Result.Left + LSection.Width;
  Result.Bottom := Result.Top + Height;
  if not LSection.Locked and (FHPos <> 0) then
    OffsetRect(Result, -FHPos, 0);
end;

procedure TElXCustomHeader.GetDragImage(XPos,YPos: Integer);
var
  R{, RC}: TRect;
  S: TElXHeaderSection;
  C: TColor;
  hls2: integer;
  lum{, i}: integer;
//  LCell: TElXHeaderCell;
begin
  S := GetSectionAt(XPos, YPos) as TElXHeaderSection;
  if S = nil then Exit;
  R := GetDragSectionRect(S.Position);
  DragRect := R;
  DragBmp := TBitmap.Create;
  DragBmp.Height := R.Bottom - R.Top + 1;
  DragBmp.Width := R.Right - R.Left + 1;
  R := Rect(0, 0, DragBmp.Width - 1, DragBmp.Height - 1);
  DragBmp.Canvas.Brush.Color := Color;
  DragBmp.Canvas.FillRect(R);
  DragBmpMask := TBitmap.Create;
  DragBmp.Canvas.Font.Assign(Font);

  RedrawSection(DragBmp.Canvas, S, R, S.Left, True);

  DragBmpMask.Width := DragBmp.Width;
  DragBmpMask.Height := DragBmp.Height;
  DragBmpMask.Canvas.CopyRect(R, DragBmp.Canvas, R);

  if S.FParentColor then
    C := Color
  else
    C := S.FColor;

  begin
    hls2 := RGBtoHLS(ColorToRGB(C));
    lum := Hi(hls2 and $FFFF);
    Dec(lum, lum shr 2);
    if lum > 239 then
      lum := 239;
    hls2 := (lum shl 8) or (hls2 and $FF00FF);
    C := TColor(HLStoRGB(hls2))
  end;

  DragBmpMask.Mask(C);
end; { GetDragImage }

procedure TElXCustomHeader.DoSectionClick(Section: TElHeaderSection);
var
  ASection: TElXHeaderSection;
begin
  ASection := (Section as TElXHeaderSection);
  if (Assigned(FOnSectionClick)) then FOnSectionClick(Self, ASection);
  if ASection.FClickedCellIndx > -1 then
    DoSectionCellClick(ASection, ASection.Cell[ASection.FClickedCellIndx]);
end;

procedure TElXCustomHeader.DoSectionReindex(Section: TElHeaderSection; OldIndex, NewIndex: integer);
begin
  if assigned(FOnSectionReindex) then FOnSectionReindex(Self, Section as TElXHeaderSection, OldIndex, NewIndex);
end;

procedure TElXCustomHeader.DoSectionResize(Section: TElHeaderSection);
begin
  RecalcColumnsWidth;
  if Assigned(FOnSectionResize) then FOnSectionResize(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.DoVisChanged(Section: TElHeaderSection);
begin
  if Assigned(FOnVisibleChange) then FOnVisibleChange(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.DoNotifySectionChange(Section: TElHeaderSection;
  Change: TSectionChangeMode);
begin
  if (assigned(FOnSectionChange)) then
    FOnSectionChange(Self, Section as TElXHeaderSection, Change);
end;

procedure TElXCustomHeader.DoSectionCreate(Section: TElHeaderSection);
begin
  if (assigned(FOnSectionCreate)) then FOnSectionCreate(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.DoSectionDelete(Section: TElHeaderSection);
begin
  if (assigned(FOnSectionDelete)) then FOnSectionDelete(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.DoSectionLookupDoneEvent(
  Section: TElHeaderSection; Text: TLMDString; Accepted: boolean);
begin
  if (assigned(FOnHeaderLookupDone)) then FOnHeaderLookupDone(Self, Section as TElXHeaderSection, Text, Accepted);
end;

procedure TElXCustomHeader.DoSectionLookupEvent(Section: TElHeaderSection;
  var Text: TLMDString);
begin
  if (assigned(FOnHeaderLookup)) then FOnHeaderLookup(Self, Section as TElXHeaderSection, Text);
end;

procedure TElXCustomHeader.DoSectionCollapseEvent(
  Section: TElHeaderSection);
begin
  if (assigned(FOnSectionCollapse)) then FOnSectionCollapse(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.DoSectionExpandEvent(Section: TElHeaderSection);
begin
  if (assigned(FOnSectionExpand)) then FOnSectionExpand(Self, Section as TElXHeaderSection);
end;

procedure TElXCustomHeader.IntLButtonDown(XPos, YPos: SmallInt);
var
  THS, THS1: TElXHeaderSection;
  b: boolean;
  rm: integer;
begin
  //  SendCancelMode(Self);
  if FDoingLookup then
  begin
    FDoingLookup := False;
    FLookup.Visible := False;
    DoSectionLookupDoneEvent(FLookupSection, FLookup.Text, False);
    try
      Windows.SetFocus(FFocusedCtl);
      except
      on E: Exception do
      begin
      end;
    end;
  end
  else
  if not (csNoStdEvents in ControlStyle) then
  begin
    if InResizeArea(XPos, YPos, THS) and ((THS as TElXHeaderSection).FResizable) and (THS.Index >=0) then
    begin
      FResizing := True;
      FResizeSection := THS;
      THS1 := FTrackSection as TElXHeaderSection;
      FTrackSection := nil;
      if THS1 <> nil then
        THS1.UpdateSection;
      Screen.Cursor := crHSplit;
      SetCapture(Handle);
      if RightAlignedOrder then
        FHeaderLine := FResizeSection.Left
      else
        FHeaderLine := FResizeSection.Right;

      if not FResizeSection.Locked then

         Dec(FHeaderLine, FHPos);
      FLineTab := XPos - FHeaderLine;
      if (not ResizeOnDrag) then
      begin
        //        SendCancelMode(Self);
        AllocateLineDC;
        DrawLine(False);
      end;
      DoSectionResizing(THS, trsBegin, THS.Width);
    end // Resizing
    else
    begin
      FPressCoord := Point(XPos, YPos);
      FPressed := True;
      if FPressedItem <> nil then
      begin
        THS := FPressedItem as TElXHeaderSection;
        FPressedItem := nil;
        THS.UpdateSection;
      end;
      FPressedItem := GetSectionAt(XPos, YPos);
      THS := FPressedItem as TElXHeaderSection;
      if FPressedItem <> nil then
      begin
        b := True;
        rm := FPressedItem.Right - 4;

        if not FPressedItem.Locked then

        Dec(rm, FHPos);
        if FPressedItem.Expandable then
        begin
          if ((rm + 13 - FPressedItem.Width) + (ResizeWidth - 4) < RM)
            and LMDInRange(XPos, rm - 6 - (ResizeWidth - 4), RM)
            and LMDInRange(YPos, 2, 9) then
          begin
            THS := FPressedItem as TElXHeaderSection;
            FPressedItem := nil;
            THS.Expanded := not THS.Expanded;
            if THS.Expanded then
              DoSectionExpandEvent(THS)
            else
              DoSectionCollapseEvent(THS);
            b := False;
          end;
        end;
        if THS.FLookupEnabled then
        begin

          if not THS.Locked then

          if ((rm + 13 - THS.Width) + (ResizeWidth - 4) < RM)
            and LMDInRange(XPos, rm - 6 - (ResizeWidth - 4), RM)
            and LMDInRange(YPos, 12, 16) then
          begin
            THS.ShowLookup;
            b := False;
          end;
        end;
        if THS.FFilterEnabled then
        begin
          if THS.LookupEnabled or THS.Expandable then
            Dec(rm, 8);
          if ((THS.Width - ResizeWidth) > 4)
            and LMDInRange(XPos, rm - 6, RM)
            and LMDInRange(YPos, 12, 16) then
          begin
            TriggerFilterCallEvent(THS);
            b := False;
          end;
        end;
        if b and (TElXHeaderSection(FPressedItem).FAllowClick ) then
          FPressedItem.UpdateSection
        else
          FPressedItem := nil;
      end;
    end; // not Resizing
  end;
end;

function TElXCustomHeader.CreateSections: TElHeaderSections;
begin
  Result := TElXHeaderSections.Create(Self);
end;

procedure TElXCustomHeader.RedrawSectionCell(ACanvas: TCanvas;
  ASection: TElHeaderSection; AR: TRect; AxHOffs: integer;
  ADithered: Boolean; ARowIndex: Integer);
var
  LCell: TElXHeaderCell;
begin
  LCell := Rows[ARowIndex].Cell[ASection.Position];
  LCell.Dithered := ADithered;
  LCell.FXOffset := AxHOffs;
  LCell.Paint(ACanvas, AR);
end;

procedure TElXCustomHeader.IntLButtonUp(XPos, YPos: SmallInt);
var
  LSection: TElXHeaderSection;
//  i, j: integer;
begin
  if not InResizeArea(XPos,YPos,LSection) then
  begin
    LSection := GetSectionAt(XPos, YPos) as TElXHeaderSection;
    if Assigned(LSection) then
    begin
//      i := LSection.GetGellIndexByY(YPos);
      LSection.FClickedCellIndx := LSection.GetCellIndexByY(YPos);
//      if (LSection.Cell[i].FJointCellRole = jcrMaster) and (LSection.Cell[i].FJointColumnCount > 1) then
//      begin
//        for j := 1 to LSection.Cell[i].FJointColumnCount - 1 do
//        begin
//          (Rows[i] as TElXHeaderRow).Cells[LSection.Cell[i].Index+j].HeaderSection.FClickedCellIndx := i;
//        end;
//      end;
    end;
  end;
  inherited;
end;

function TElXCustomHeader.CreateHeaderCellRow: TElXHeaderCellRow;
begin
  result := TElXHeaderCellRow.Create(Self);
end;

procedure TElXCustomHeader.DoSectionCellClick(Section: TElXHeaderSection; Cell: TElXHeaderCell);
begin
  if (assigned(FOnSectionCellClick)) then FOnSectionCellClick(Self, Section, Cell);
end;

procedure TElXCustomHeader.DoSectionCellDraw(Canvas: TCanvas;
  Section: TElXHeaderSection; Cell: TElXHeaderCell; R: TRect;
  Pressed: boolean);
begin
  if Assigned(FOnSectionCellDraw) then FOnSectionCellDraw(Self, Canvas, Section, Cell, R, Pressed);
end;

procedure TElXCustomHeader.DoSectionDraw(Canvas: TCanvas;
  Section: TElHeaderSection; R: TRect; Pressed: boolean);
begin
  if Assigned(FOnSectionDraw) then FOnSectionDraw(Self, Canvas, (Section as TElXHeaderSection), R, Pressed);
end;

procedure TElXCustomHeader.DoSectionCellPostDraw(Canvas: TCanvas; Section: TElXHeaderSection; Cell: TElXHeaderCell;
  R: TRect; Pressed: Boolean);
begin
  if Assigned(FOnSectionCellPostDraw) then FOnSectionCellPostDraw(Self, Canvas, Section, Cell, R, Pressed);
end;

procedure TElXCustomHeader.Loaded;
begin
  inherited;
  RecheckMasterCells;
end;

procedure TElXCustomHeader.RecheckMasterCells;
var
  i, j: integer;
begin
  for i := 0 to RowCount - 1 do
  begin
    for j := 0 - SectionOffset to Rows[i].Count - 1 do
    begin
      if (Rows[i].Cell[j].JointCellRole = jcrMaster)
          and (Rows[i].Cell[j].JointRowCount + i <= RowCount)
          and (Rows[i].Cell[j].JointColumnCount + j <= Rows[i].Count) then
      begin
        Rows[i].Cell[j].Join(Rows[i].Cell[j].JointRowCount,Rows[i].Cell[j].JointColumnCount)
      end
    end;
  end;
end;

function TElXCustomHeader.DoGetPicture(Section: TElHeaderSection): integer;
begin
  Result := -1;
  if Assigned(FOnPictureNeeded) then FOnPictureNeeded(self, Section as TElXHeaderSection, Result);
end;

procedure TElXCustomHeader.DoSectionResizing(Section: TElHeaderSection;
  State: TElHResizingStates; NewWidth: integer);
begin
  if Assigned(FOnSectionResizing) then FOnSectionResizing(Self, Section as TElXHeaderSection, State, NewWidth);
end;

procedure TElXCustomHeader.TriggerFilterCallEvent(
  Section: TElHeaderSection);
begin
  if (assigned(FOnFilterCall)) then FOnFilterCall(Self, Section as TelXHeaderSection);
end;

procedure TElXCustomHeader.TriggerMeasureSectionEvent(
  Section: TElHeaderSection; var Size: TPoint);
begin
  if assigned(FOnMeasureSection) then FOnMeasureSection(Self, Section as TElXHeaderSection, Size);
end;

function TElXCustomHeader.GetResizableWidth: integer;
begin
  Result := inherited GetResizableWidth;
  if (csReading in Owner.ComponentState) or (csWriting in Owner.ComponentState) then
    exit;
  if (SectionOffset > 0) and Assigned(Sections[-1]) and not RightAlignedOrder then
  begin
    Result := Result -  Sections[-1].Width;
  end;
end;

function TElXCustomHeader.GetSectionRect(SectionNum: integer): TRect;
begin
  Result := GetDragSectionRect(Sections[SectionNum].Position);
end;

procedure TElXCustomHeader.SetFixedColNum(Value: Integer);
begin
  inherited SetFixedColNum(Value + SectionOffset);
end;

function TElXCustomHeader.GetFixedColNum: Integer;
begin
  Result := max(0, FFixedColNum - SectionOffset);
end;

function TElXCustomHeader.SectionOffset: Integer;
begin
  if (csReading in Owner.ComponentState) or (csWriting in Owner.ComponentState) or Sections.FIgnoreGutterState then
    Result := 0
  else
    Result := FSectionOffset;
end;

{ TElXHeaderCell }

function TElXHeaderCell.GetHeaderSection: TPersistent;
begin
  Result := FHeaderSection;
end;

function TElXHeaderCell.GetText: TLMDString;
begin
  Result := FText;
end;

procedure TElXHeaderCell.SetText(const AText: TLMDString);
begin
  FText := AText;
end;

constructor TElXHeaderCell.Create(AOwner: TElXHeaderCellRow; AHeaderSection: TElXHeaderSection);
begin
  inherited Create(AOwner);
  FOwner := AOwner;
  FHeaderSection := AHeaderSection;
  FWidth := 120;
end;

procedure TElXHeaderCell.Paint(const ACanvas: TCanvas; const ARect: TRect);
var
  LDithered: Boolean; // is passed to TCustomElHeader.RedrawSection
  LHOffs: Integer; // is passed to TCustomElHeader.RedrawSection
  LHeader: TElXCustomHeader;
  LSection, MSection: TElXHeaderSection;
  LRect: TRect;
  LText: TLMDString;
  LBitmap: TBitmap;
  LAlphaBitmap: TBitmap;
  LTextSize: Integer;
  R1: TRect;
  R2: TRect;
  BgRect: TRect;
  w, i, j: integer;
  DC: HDC;
  SaveCol: TColor;
  SaveColor: TColor;
  SaveStyle: TFontStyles;
  StImIndex: integer;
  AL: integer;
  ACtl: TWinControl;
  imfd: boolean;
  SPressed, SMPressed, SSorted, STracked: boolean;
  C: TColor;
  hls2: integer;
  lum: integer;
  PS: TSize;
  Tmp1: TBitmap;
  LDetails: TThemedElementDetails;
  LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := FOwner.FOwner.UseThemeMode;
  PS.cx := 0;
  LSection := FHeaderSection;
//  LSection := FOwner.FOwner.Sections[Index];
  LHeader := LSection.Owner as TElXCustomHeader;
  SMpressed := (LSection = LHeader.PressedSection);
  if (LHeader.SectionOffset > 0) and (LHeader.Owner is TCustomElXTree) then
    SSorted := (THackCustomElXTree(LHeader.Owner).SortMode <> smNone)
  else
    SSorted := True;
  SSorted := SSorted and (LSection.SortMode <> hsmNone) and (LSection.ShowSortMark);
  if (FJointCellRole = jcrMaster) and (LHeader.Pressed) then
  begin
    for j := RowIndex to RowIndex + FJointRowCount - 1 do
      for i := Index to Index + FJointColumnCount - 1 do
      begin
        MSection := LHeader.Rows[j].Cell[i].FHeaderSection;
        SMPressed := SMPressed or (MSection = LHeader.PressedSection);
//        SSorted := SSorted or ((MSection.SortMode <> hsmNone) and (MSection.ShowSortMark));
      end;
  end;

  if LSection.ParentColor then
    C := LHeader.Color
  else
    C := LSection.Color;

  LDithered := FDithered;
  LHOffs := FXOffset;
  LRect := ARect;
  SPressed := LMDInRange(LHeader.FPressCoord.X, LRect.Left + LSection.Left - LHeader.FHPos, LRect.Right + LSection.Right - LHeader.FHPos) and LMDInRange(LHeader.FPressCoord.Y, LRect.Top + RowIndex*LHeader.FRowHeight, LRect.Bottom + RowIndex*LHeader.FRowHeight);
  if JointCellRole = jcrMaster then
  begin
    MSection := JointCellMaster.HeaderSection;
    if LMDInRange(MSection.FTrackedCellIndx, 0, LHeader.RowCount - 1) then
      STracked := LMDInRange(RowIndex,
                  MSection.Cell[MSection.FTrackedCellIndx].JointCellMaster.RowIndex,
                  MSection.Cell[MSection.FTrackedCellIndx].JointCellMaster.RowIndex + MSection.Cell[MSection.FTrackedCellIndx].JointCellMaster.JointRowCount - 1)
      else
        STracked := False;
  end
  else
    STracked := (LSection.FTrackedCellIndx = RowIndex);
  SSorted := SSorted and (LSection.FSortedCellIndx = RowIndex);

  if LDithered then
  begin
    hls2 := RGBtoHLS(ColorToRGB(C));
    lum := Hi(hls2 and $FFFF);
    Dec(lum, lum shr 2);
    if lum > 252 then
      lum := 252;
    hls2 := (lum shl 8) or (hls2 and $FF00FF);
    C := TColor(HLStoRGB(hls2))
  end;

  ACanvas.Brush.Color := C;

  imfd := False;
  if not LHeader.IsThemed then
  begin

    if Assigned(LHeader.ImageForm) and (not (csDesigning in LHeader.ImageForm.GetRealControl.ComponentState)) then
    begin
      if (LHeader.ImageForm.Control <> LHeader) then
      begin
        ACtl := LHeader.ImageForm.GetRealControl;
        OffsetRect(LRect, LHOffs, 0);
        BgRect := LRect;
        OffsetRect(BgRect, -LSection.Left + LHOffs + LHeader.LeftPos, 0);
        BgRect.TopLeft := LHeader.ClientToScreen(BgRect.TopLeft);
        BgRect.BottomRight := LHeader.ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        OffsetRect(LRect, -LHOffs, 0);
        LHeader.ImageForm.PaintBkgnd(ACanvas.Handle, LRect, BgRect.TopLeft, False);
      end;
      imfd := True;
    end
    else
      ACanvas.FillRect(LRect);

    DC := ACanvas.Handle;
    if (SMPressed and SPressed)
        and LHeader.Pressed
        or (LHeader.DropSrc = LSection) and not LDithered
    then
    begin
      if LHeader.Flat then
      begin
        Dec(LRect.Bottom); Dec(LRect.Right);
        DrawEdge(DC, LRect, BDR_SUNKENOUTER, BF_RECT);
        Inc(LRect.Bottom); Inc(LRect.Right);
        InflateRect(LRect, -1, -1);
        OffsetRect(LRect, 1, 1);
      end
      else
      begin
        Dec(LRect.Bottom); Dec(LRect.Right);
        DrawEdge(DC, LRect, BDR_SUNKENINNER, BF_TOPLEFT);
        DrawEdge(DC, LRect, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
        Inc(LRect.Bottom); Inc(LRect.Right);

        InflateRect(LRect, -1, -1);
        OffsetRect(LRect, 1, 1);
      end;
    end
    else
    begin
      if LHeader.Flat then
      begin
        DrawEdge(DC, LRect, BDR_RAISEDINNER, BF_RECT);
      end
      else
      begin
        DrawEdge(DC, LRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT); { black }
        Dec(LRect.Bottom);
        Dec(LRect.Right);
        DrawEdge(DC, LRect, BDR_RAISEDINNER, BF_TOPLEFT); { btnhilite }
        Inc(LRect.Top);
        Inc(LRect.Left);
        DrawEdge(DC, LRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT); { btnshadow }
        Dec(LRect.Bottom);
        Dec(LRect.Right);
      end;
    end;

    Inc(LRect.Top);
    Inc(LRect.Left);
    Dec(LRect.Bottom);
  end
  else
  begin
    imfd := True;
    LDetails.Element := teHeader;
    LDetails.Part := 0;
    LDetails.State := 0;
    LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, LRect, LMDRectToPtr(LRect));;

    if ((SMPressed and SPressed) and (LHeader.Pressed = True)) or
       ((LSection = LHeader.DropSrc) and not LDithered) then
      LDetails.State := HIS_PRESSED
    else

	if ((LSection = LHeader.TrackSection) and STracked and LSection.ClickSelect) or
       ((LSection = LHeader.DropSrc) and LDithered) then
      LDetails.State := HIS_HOT
    else
      LDetails.State := HIS_NORMAL;
    LDetails.Part := HP_HEADERITEM;
    LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, LRect, LMDRectToPtr(LRect));

    if LHeader.FRightAlignedOrder and not (SysLocale.MiddleEast) then
    begin
      Tmp1 := TBitmap.Create;
      Tmp1.Width := LRect.Right - LRect.Left + 4;
      Tmp1.Height := LRect.Bottom - LRect.Top;
      Tmp1.PixelFormat := pf24bit;
      BgRect := Rect(1, 0, Tmp1.Width - 2, Tmp1.Height);
      LDetails.Part := 0;
      LMDThemeServices.DrawElement(LHeader.UseThemeMode, Tmp1.Canvas.Handle, LDetails, BgRect, LMDRectToPtr(BgRect));

      LDetails.Part := HP_HEADERITEM;
      LMDThemeServices.DrawElement(LHeader.UseThemeMode, Tmp1.Canvas.Handle, LDetails, BgRect, LMDRectToPtr(BgRect));

      LMDBmpFlipHorizontal(Tmp1, Rect (0, 0, Tmp1.Width - 1, Tmp1.Height - 1), Tmp1, Point (0,0));
      bitblt(ACanvas.Handle, LRect.Left, LRect.Top, Tmp1.Width - 2, Tmp1.Height-1, Tmp1.Canvas.Handle, 0, 0, SRCCOPY);
      Tmp1.Free;
    end;
    c := ACanvas.Pixels[(LRect.Right - LRect.Left) div 2, (LRect.Bottom - LRect.Top) div 2];
  end;

  Dec(LRect.Right, 4);
  if (LSection.Expandable or LSection.LookupEnabled) and (LRect.Right - 2 > LRect.Left +  ResizeWidth) then
  begin
    if LSection.Expandable then
    begin
      R2 := Rect(LRect.Right - 5, LRect.Top, LRect.Right, LRect.Top + 7);
      if LSection.Expanded then
        LMDDrawArrow(ACanvas, eadLeft, R2, clBtnText, True)
      else
        LMDDrawArrow(ACanvas, eadRight, R2, clBtnText, True);
    end;
    if LSection.LookupEnabled then
    begin
      LBitmap := ElHeaderPointBmp;
      R2 := Rect(LRect.Right - 5, LRect.Top + 10, LRect.Right, Min(LRect.Top + 14, LRect.Bottom));
      if imfd then
      DrawTransparentBitmapEx(ACanvas.Handle, LBitmap, R2.Left, R2.Top, Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), LBitmap.TransparentColor)
      else
      ACanvas.BrushCopy(R2, LBitmap, Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), LBitmap.TransparentColor)
      end;
    Dec(LRect.Right, 8);
  end;
  R1 := LRect;
  if LSection.FilterEnabled and (LRect.Right - 4 > LRect.Left + ResizeWidth) then
  begin
    SaveColor := ACanvas.Brush.Color;
    SaveCol := ACanvas.Pen.Color;
    if LSection.FilterIsActive then
      ACanvas.Brush.Color := LHeader.ActiveFilterColor
    else
      ACanvas.Brush.Color := LHeader.FilterColor;
    ACanvas.Pen.Color := ACanvas.Brush.Color;
    ACanvas.Polygon([Point(LRect.Right - 4, LRect.Top + 10), Point(LRect.Right, LRect.Top + 10), Point(LRect.Right - 2, Min(LRect.Top + 14, LRect.Bottom))]);
    ACanvas.Brush.Color := SaveColor;
    ACanvas.Pen.Color := SaveCol;
    if (LSection.SortMode = hsmNone) or (not LSection.ShowSortMark) then
      Dec(R1.Right, 6);
  end;
  if ((LSection.SortMode <> hsmNone) and (LSection.ShowSortMark)) and SSorted then
  begin
{    if LHeader.IsThemeApplied then
    begin
      if (LSection.SortMode = hsmAscend) xor (LHeader.InvertSortArrows) then
        sid1 := HSAS_SORTEDUP
      else
        sid1 := HSAS_SORTEDDOWN;
      if R1.Right - 8 < R1.Left + ResizeWidth then
      begin
        w := 0;
        R1.Right := R1.Left + ResizeWidth;
      end
      else
      begin
        w := 9;
        Dec(R1.Right, 9);
      end;
      if LSection.FilterEnabled or LSection.LookupEnabled then
        R2 := Rect(R1.Right, (5 + LRect.Top) - 3, R1.Right + W, (5 + LRect.Top) + 3)
      else
        R2 := Rect(R1.Right, ((R1.Bottom - LRect.Top) div 2 + LRect.Top) - 3, R1.Right + W, ((R1.Bottom - LRect.Top) div 2 + LRect.Top) + 3);
      GetThemePartSize(LHeader.Theme, ACanvas.Handle, HP_HEADERSORTARROW, sid1, @R2, TS_DRAW, PS);
      PS.CX := 9;
      PS.cy := 9;
      R2 := R1;
      if R1.Right - PS.CX < R1.Left + ResizeWidth then
      begin
        // w := 0;
        R1.Right := R1.Left + ResizeWidth;
        R2.Left := R1.Left;
      end
      else
      begin
        w := PS.CX + 1;
        Dec(R1.Right, PS.CX + 1);
        R2.Left := R1.Right - w;
      end;
      R2.Right := R1.Right;
      DrawThemeBackground(LHeader.Theme, ACanvas.Handle, HP_HEADERSORTARROW, sid1, R2, @R2);
    end
    else}
    begin
      if R1.Right - 8 < R1.Left + ResizeWidth then
      begin
        w := 0;
        R1.Right := R1.Left + ResizeWidth;
      end
      else
      begin
        w := 9;
        Dec(R1.Right, 9);
      end;
      if LSection.FilterEnabled or LSection.LookupEnabled then
        R2 := Rect(R1.Right, (5 + LRect.Top) - 3, R1.Right + W, (5 + LRect.Top) + 3)
      else
        R2 := Rect(R1.Right, ((R1.Bottom - LRect.Top) div 2 + LRect.Top) - 3, R1.Right + W, ((R1.Bottom - LRect.Top) div 2 + LRect.Top) + 3);
      ACanvas.Brush.Color := C;

      if w > 0 then
      begin
        if (LSection.SortMode = hsmAscend) xor (LHeader.InvertSortArrows) then
          LBitmap := ElHeaderAscBmp
        else
          LBitmap := ElHeaderDescBmp;
        if imfd then
          DrawTransparentBitmapEx(ACanvas.Handle, LBitmap, R2.Left, R2.Top, Rect(0, 0, 9, 6), LBitmap.Canvas.Pixels[0, 5])
        else
          ACanvas.BrushCopy(R2, LBitmap, Rect(0, 0, 9, 6), LBitmap.Canvas.Pixels[0, 5]);
        Dec(R1.Right, 3);
      end;
    end;
  end;
  if not (LSection.Style in [elhsPictureOnly, elhsImageIndex]) then
    Inc(R1.Left, ResizeWidth);

  if R1.Right < R1.Left then Exit;
  if LSection.Style = elhsOwnerDraw then
    LHeader.DoSectionCellDraw(ACanvas, LSection, Self, R1, ((LSection = LHeader.PressedSection) and (LHeader.Pressed = True)) or ((LHeader.DropSrc = LSection) and not LDithered))
  else
  begin
    if (LSection.Style in [elhsPictureOnly, elhsImageIndex]) then
    begin
      if (LHeader.Images <> nil) then
      begin
        if LSection.Style = elhsPictureOnly then
          StImIndex := LSection.ImageIndex
        else
          StImIndex := StrToIntDef(Text, -1);
//          StImIndex := StrToIntDef(LSection.Text, -1);

//        if StImIndex = -1 then
//          StImIndex := LHeader.DoGetPicture(LSection);

        if LMDInRange(StImIndex, 0, LHeader.Images.Count - 1) then
        begin
          LBitmap := TBitmap.Create;
          LBitmap.Width := LHeader.Images.Width;
          LBitmap.Height := LHeader.Images.Height;

          R2 := Rect(Max(R1.Left + ((R1.Right - R1.Left + 1) div 2) - (LHeader.Images.Width div 2), R1.Left),
              R1.Top + ((R1.Bottom - R1.Top + 1) div 2) - (LHeader.Images.Height div 2),
              Min(R1.Right, R1.Left + ((R1.Right - R1.Left + 1) div 2) - (LHeader.Images.Width div 2) + LHeader.Images.Width),
              R1.Top + LHeader.Images.Height);
          LBitmap.Canvas.CopyRect(Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height), ACanvas, R2);

          if LRect.Left < LRect.Right then
          begin
            if (LHeader.AlphaImages <> nil) and (LHeader.AlphaImages.Count>StImIndex) then
            begin
              ImageList_DrawEx(LHeader.Images.Handle, StImIndex, LBitmap.Canvas.Handle,
                0, 0, 0, 0, clNone, clNone, ILD_Normal);

              LAlphaBitmap := TBitmap.Create;
              LAlphaBitmap.Width := LHeader.AlphaImages.Width;
              LAlphaBitmap.Height := LHeader.AlphaImages.Height;
              ImageList_DrawEx(LHeader.AlphaImages.Handle, StImIndex, LAlphaBitmap.Canvas.Handle,
                0, 0, 0, 0, clNone, clNone, ILD_Normal);
              AlphaCopyRect2(ACanvas.Handle,
                R2,
                LBitmap.Canvas.Handle,
                Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height),
                LAlphaBitmap,
                255);
              FreeAndNil(LAlphaBitmap);
            end
            else
            begin
              LHeader.Images.Draw(LBitmap.Canvas, 0, 0, StImIndex);
              ACanvas.CopyRect(R2, LBitmap.Canvas, Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height));
            end;
          end;
          Inc(R1.Left, LHeader.Images.Width);
          FreeAndNil(LBitmap);
        end;
      end;
      Exit;
    end;
    LTextSize := 0;
    if LSection.Style = elhsText then
    begin
      LText := FText;
      if Pos('<html>', LText) = 1 then
      begin
        LHeader.HTMLRender.Data.DefaultBgColor := clNone;//C;
        LHeader.HTMLRender.Data.DefaultColor := LHeader.Font.Color;
        LHeader.HTMLRender.Data.DefaultStyle := LHeader.Font.Style;
        LHeader.HTMLRender.Data.DefaultHeight := LHeader.Font.Height;
        LHeader.HTMLRender.Data.DefaultFont := LHeader.Font.Name;
        LHeader.HTMLRender.Data.Charset := LHeader.Font.Charset;
        LHeader.HTMLRender.PrepareText(LText, 0, False);
        LTextSize := LHeader.HTMLRender.Data.TextSize.cx;
      end
      else
      begin
        R2 := R1;
        LMDDrawText(ACanvas.Handle, LText, -1, R2, DT_CALCRECT);
        LTextSize := r2.Right - r2.Left;
      end;
    end;
    if LTextSize > LSection.Width then
      LTextSize := -1;
    if (LHeader.Images <> nil) and (LSection.PictureAlign <> hsaCenter) then
    begin
      StImIndex := LSection.ImageIndex;
//      if StImIndex = -1 then StImIndex := LHeader.DoGetPicture(LSection);
      if LMDInRange(StImIndex, 0, LHeader.Images.Count - 1) then
      begin
        LBitmap := TBitmap.Create;
        LBitmap.Width := LHeader.Images.Width;
        LBitmap.Height := LHeader.Images.Height;

        R2 := Rect(R1.Left, (R1.Bottom + R1.Top + 1) div 2 - (LHeader.Images.Height div 2), Min(R1.Right, R1.Left + LHeader.Images.Width), 0);
        R2.Bottom := R2.Top + LHeader.Images.Height;
        if LTextSize >= 0 then
          case {LSection.}FAlignment of
            hsaCenter: begin
                         OffsetRect(R2,(R1.Right - R1.Left - LTextSize) div 2 - LBitmap.Width - 3, 0);
                         if LSection.PictureAlign = hsaRight then
                           OffsetRect(R2, LTextSize + 6 + LBitmap.Width, 0);
                       end;
            hsaRight: begin
                         if LSection.PictureAlign = hsaRight then
                         begin
                         if LHeader.RightAlignedText then
                           OffsetRect(R2, LTextSize + 3, 0)
                         else
                           OffsetRect(R2, R1.Right - R1.Left - LBitmap.Width, 0);
                         end
                         else
                          if not LHeader.RightAlignedText then
                            OffsetRect(R2, R1.Right - R1.Left - LTextSize - LBitmap.Width - 3, 0);
                      end;
            hsaLeft: begin
                       if LSection.PictureAlign = hsaRight then
                       begin
                         if LHeader.RightAlignedText then
                           OffsetRect(R2, R1.Right - R1.Left - LBitmap.Width, 0)
                         else
                           OffsetRect(R2, LTextSize + 3, 0);
                       end
                       else
                         if LHeader.RightAlignedText then
                           OffsetRect(R2, R1.Right - R1.Left - LTextSize - LBitmap.Width - 3, 0);
                     end;
          end;
        LBitmap.Canvas.CopyRect(Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height), ACanvas, R2);

        if LRect.Left < LRect.Right then
        begin
          if (LHeader.AlphaImages <> nil)and (LHeader.AlphaImages.Count>StImIndex) then
          begin
            ImageList_DrawEx(LHeader.Images.Handle, StImIndex, LBitmap.Canvas.Handle,
              0, 0, 0, 0, clNone, clNone, ILD_Normal);

            LAlphaBitmap := TBitmap.Create;
            LAlphaBitmap.Width := LHeader.AlphaImages.Width;
            LAlphaBitmap.Height := LHeader.AlphaImages.Height;
            ImageList_DrawEx(LHeader.AlphaImages.Handle, StImIndex, LAlphaBitmap.Canvas.Handle,
              0, 0, 0, 0, clNone, clNone, ILD_Normal);
            AlphaCopyRect2(ACanvas.Handle,
              R2,
              LBitmap.Canvas.Handle,
              Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height),
              LAlphaBitmap,
              255);
            FreeAndNil(LAlphaBitmap);
          end
          else
          begin
            // LBitmap.ACanvas.Brush.Color := ACanvas.Brush.Color;
            // LBitmap.ACanvas.FillRect(Rect(0, 0, LHeader.Images.Width, LHeader.Images.Height));
            LHeader.Images.Draw(LBitmap.Canvas, 0, 0, StImIndex);
            LBitmap.TransparentMode := tmAuto;
            ACanvas.CopyRect(R2, LBitmap.Canvas, Rect(0, 0, min(LHeader.Images.Width, Min(R1.Right, R1.Left + LHeader.Images.Width - 1) - R1.Left + 1), LHeader.Images.Height));
          end;
        end;
        if (LSection.Alignment = hsaLeft) or (LHeader.RightAlignedText and (LSection.Alignment = hsaRight)) then
          if LSection.PictureAlign = hsaLeft then
            Inc(R1.Left, LHeader.Images.Width + 3);
        if (LSection.Alignment = hsaRight) or (LHeader.RightAlignedText and (LSection.Alignment = hsaLeft)) then
          if LSection.PictureAlign = hsaRight then
            dec(R1.Right, LHeader.Images.Width + 3);
        FreeAndNil(LBitmap);
      end;
    end;
    if R1.Right < R1.Left then Exit;
    if LSection.Style = elhsText then
    begin
      LText := FText;

      if Pos('<html>', LText) = 1 then
      begin
//        LHeader.HTMLRender.Data.DefaultBgColor := C;
//        LHeader.HTMLRender.Data.DefaultColor := LHeader.Font.Color;
//        LHeader.HTMLRender.Data.DefaultStyle := LHeader.Font.Style;
//        LHeader.HTMLRender.Data.DefaultHeight := LHeader.Font.Height;
//        LHeader.HTMLRender.Data.DefaultFont := LHeader.Font.Name;
//        LHeader.HTMLRender.Data.Charset := LHeader.Font.Charset;
//        LHeader.HTMLRender.PrepareText(LText, 0, False);
        if (LHeader.HTMLRender.Data.TextSize.cy < (R1.Bottom - R1.Top)) then
        begin
          if (LSection.TextLayout = tlCenter) then
            R1.Top := R1.Top + max(R1.Bottom - R1.Top - LHeader.HTMLRender.Data.TextSize.cy - 2, 0) div 2;
          if (LSection.TextLayout = tlBottom) then
            R1.Top := R1.Top + max(R1.Bottom - R1.Top - LHeader.HTMLRender.Data.TextSize.cy - 2, 0);
        end;
        LHeader.HTMLRender.DrawText(ACanvas, Point(0, 0), R1, clNone);
      end
      else
      begin
        if LHeader.RightAlignedText then
        begin
          Al := DT_RIGHT;
//          case LSection.Alignment of
          case FAlignment of
            hsaCenter: Al := DT_CENTER;
            hsaRight: Al := DT_LEFT;
          end; // case
          end
        else
        begin
          Al := DT_LEFT;
//          case LSection.Alignment of
          case FAlignment of
            hsaCenter: Al := DT_CENTER;
            hsaRight: Al := DT_RIGHT;
          end; // case
          end;
        case LSection.TextLayout of
          tlTop: Al := AL or DT_TOP;
          tlCenter: Al := Al or DT_VCENTER;
          tlBottom: Al := Al or DT_BOTTOM;
        end;
        if LHeader.RightAlignedText then
           AL := AL or DT_RTLREADING;
        if LHeader.WrapCaptions then
        begin
          AL := AL or DT_WORDBREAK;
          if LSection.TextLayout = tlCenter then
            AL := AL or DT_TOP;
        end
        else
        if (Pos(#13#10, FText) = 0) then
          AL := AL or DT_SINGLELINE or DT_END_ELLIPSIS;
        ACanvas.Brush.Style := bsClear;
        SaveCol := 0;
        if ((LSection = LHeader.TrackSection) and STracked) and not LHeader.IsThemed then
        begin
          SaveCol := ACanvas.Font.Color;
          SaveStyle := ACanvas.Font.Style;
          ACanvas.Font.Color := clHighlight;
          ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
        end
        else
          if LSection.ParentColor then
            ACanvas.Font.Color := LHeader.Font.Color
          else
           ACanvas.Font.Color := LSection.FontColor;
        // to fix problem with rigth-aligned italic text
        if (fsItalic in ACanvas.Font.Style) and ((AL and DT_RIGHT) = DT_RIGHT) then
          AL := AL or DT_NOCLIP;
        if LHeader.IsThemed then
        begin
          LDetails.Part := HP_HEADERITEM;
          LMDThemeServices.DrawThemeText(LHeader.UseThemeMode, ACanvas.Handle, LDetails, LText, -1, DT_NOPREFIX or AL, 0, R1);
        end
        else
          LMDDrawText(ACanvas.Handle, LText, -1, R1, DT_NOPREFIX or AL);
        if ((LSection = LHeader.TrackSection) and STracked) and (not LHeader.IsThemed) then
        begin
          ACanvas.Font.Color := SaveCol;
          ACanvas.Font.Style := SaveStyle;
        end;
        ACanvas.Brush.Style := bsSolid;
      end;
    end;
  end;
  LHeader.DoSectionCellPostDraw(ACanvas, LSection, Self, ARect, ((LSection = LHeader.PressedSection) and (LHeader.Pressed = True)) or ((LHeader.DropSrc = LSection) and not LDithered))
end;

procedure TElXHeaderCell.Join(ARowCount, AColumnCount: Integer);
var
  x, y: Integer;
  LCellIndex: Integer;
  LItemIndex: Integer;
  LCell: TElXHeaderCell;
  LItem: TElXHeaderCellRow;
  LHeader: TElXCustomHeader;
begin
  LItem := Owner as TElXHeaderCellRow;
  LHeader := LItem.FOwner;
  LCellIndex := GetIndex;
  LItemIndex := LItem.RowIndex;
  // the column is bigger than the rightmost column index
  if LCellIndex <> -1 then // not Gutter
  begin
    if (LCellIndex + AColumnCount > LHeader.Sections.Count)
      or (LItemIndex + ARowCount > LHeader.RowsList.Count)
      or LMDInRange(LHeader.FixedColNum - 1, LCellIndex, LCellIndex + AColumnCount)
    then
      Exit;
  end;

//  LHeader.IsUpdating := True;

  for y := LItemIndex to LItemIndex + ARowCount - 1 do begin
    LItem := (LHeader.Rows[y] as TElXHeaderCellRow);
    for x := LCellIndex to LCellIndex + AColumnCount - 1 do
    begin
      LCell := LItem.Cell[x];
      if not Assigned(LCell) then
        break;
      LCell.Split;
    end;
  end;

  for y := LItemIndex to LItemIndex + ARowCount - 1 do
  begin
    LItem := (LHeader.Rows[y] as TElXHeaderCellRow);
    for x := LCellIndex to LCellIndex + AColumnCount - 1 do
    begin
      LCell := LItem.Cell[x];
      if not Assigned(LCell) then
        break;
      LCell.FJointCellRole := jcrSlave;
      LCell.FJointCellMaster := Self;
    end;
  end;
  FJointCellRole := jcrMaster;
  FJointRowCount := ARowCount;
  FJointColumnCount := AColumnCount;
//  LTree.IsUpdating := False;
  LHeader.Repaint;
end;

//function TElXHeaderCell.GetOwner: TElXHeaderRow;
//begin
//  Result := FOwner as TElXHeaderRow;
//end;

procedure TElXHeaderCell.Split;
var
  x, y: Integer;
  LCellIndex: Integer;
  LItemIndex: Integer;
  LRowCount: Integer;
  LColumnCount: Integer;
  LCell: TElXHeaderCell;
  LItem: TElXHeaderCellRow;
  LHeader: TElXCustomHeader;
begin
  LCell := Self;
  case FJointCellRole of
    jcrSingle: Exit;
    jcrMaster: LCell := Self;
    jcrSlave: LCell := FJointCellMaster as TElXHeaderCell;
  end;
  if not Assigned(LCell) then exit;
  LItem := Owner as TElXHeaderCellRow;
  LHeader := LItem.FOwner;
  if not Assigned(LHeader) then exit;
  LItemIndex := LCell.RowIndex;
  LCellIndex := LCell.GetIndex;
  LRowCount := LCell.FJointRowCount;
  LColumnCount := LCell.FJointColumnCount;

  for y := LItemIndex to LItemIndex + LRowCount - 1 do
  begin
    if y >= LHeader.RowCount then exit;
    LItem := (LHeader.Rows[y] as TElXHeaderCellRow);
    for x := LCellIndex to LCellIndex + LColumnCount - 1 do
    begin
      LItem.Cell[x].FJointCellRole := jcrSingle;
      LItem.Cell[x].FJointCellMaster := LItem.Cell[x];
      LItem.Cell[x].FJointColumnCount := 1;
      LItem.Cell[x].FJointRowCount := 1;
    end;
  end;
  if not (csDestroying in LHeader.ComponentState) then
    LHeader.Repaint;
end;

procedure TElXHeaderCell.SmartSplit;
var
  x, y: Integer;
  LCellIndex: Integer;
  LItemIndex: Integer;
  LRowCount: Integer;
  LColumnCount: Integer;
  LCell, LNCell: TElXHeaderCell;
  LItem: TElXHeaderCellRow;
  LHeader: TElXCustomHeader;
  i: Integer;
  LLastCellIndex: Integer;
  LLastCell: TElXHeaderCell;
//  LTree: TElXTree;
begin
  LCell := nil;
  LNCell := nil;
  case FJointCellRole of
    jcrSingle: Exit;
    jcrMaster: LCell := Self;
    jcrSlave: LCell := FJointCellMaster as TElXHeaderCell;
  end;
  LItem := Owner as TElXHeaderCellRow;
  LHeader := LItem.FOwner;
  if Assigned(LHeader) then
  begin
    LItemIndex := RowIndex;
  //  LCellIndex := LCell.GetIndex;
    LRowCount := LCell.FJointRowCount;
    LColumnCount := LCell.FJointColumnCount;
    if FJointCellRole = jcrMaster then
    begin
      if FJointColumnCount > 2 then
        LNCell := (Owner as TElXHeaderCellRow).Cell[Index+1]
      else
        if FJointRowCount > 2 then
          LNCell := LHeader.Rows[LItemIndex+1].Cell[Index]
        else
          Split;
    end
    else
    begin
      if (Index = LCell.Index) then
      begin
        // cells in some column
        if (LRowCount + LCell.RowIndex - 1 > LItemIndex) then
        begin
          LNCell := Self
        end
        else
          for y := Index to LColumnCount + Index - 1 do
          begin
            with LItem.Cell[y] do begin
              FJointCellRole := jcrSingle;
              FJointCellMaster := Self;
              FJointColumnCount := 1;
              FJointRowCount := 1;
            end;
            if LCell.FJointRowCount > 1 then
              LCell.FJointRowCount := LCell.FJointRowCount - 1;
            if not ((LCell.JointColumnCount > 1) or (LCell.JointRowCount > 1)) then
              LCell.FJointCellRole := jcrSingle;
          end;
      end
      else
      begin
        if (LCell.Index + LColumnCount - 1 > Self.Index) then
        begin
          LNCell := LCell.Owner.Cell[Self.index]
        end
        else
        begin
          for y := LItemIndex to LItemIndex + LRowCount - 1 do
          begin
            LItem := LHeader.Rows[y];
            with LItem.Cell[Index] do begin
              FJointCellRole := jcrSingle;
              FJointCellMaster := Self;
              FJointColumnCount := 1;
              FJointRowCount := 1;
            end;
          end;
          if LCell.FJointColumnCount > 1 then
            LCell.FJointColumnCount := LCell.FJointColumnCount - 1;
          if not ((LCell.JointColumnCount > 1) or (LCell.JointRowCount > 1)) then
            LCell.FJointCellRole := jcrSingle;
        end;
      end;
    end;
    if Assigned(LNCell) and (LNCEll <> LCell) then
    begin
      LLastCellIndex := LCell.Index + LCell.JointColumnCount - 1;
      LCell.FJointRowCount := Max(1, LCell.FJointRowCount - LNCell.RowIndex + LCell.RowIndex - 1);
      LNCell.FJointRowCount := Max(1, LRowCount - LCell.FJointRowCount);
  //    LCell.FJointColumnCount := LCell.FJointColumnCount - LNCell.Index + LCell.Index - 1;
      LCell.FJointColumnCount := Max(1, LNCell.Index - LCell.Index);
//      LNCell.FJointColumnCount := LColumnCount - LCell.FJointColumnCount
      LNCell.FJointColumnCount := 1;
      if ((LCell.JointColumnCount = 1) and (LCell.JointRowCount = 1)) then
        LCell.FJointCellRole := jcrSingle;

      if ((LNCell.JointColumnCount = 1) and (LNCell.JointRowCount = 1)) then
      begin
        for i := LCell.Index + LCell.JointColumnCount to LLastCellIndex do
        begin
          LLastCell := LCell.Owner.Cell[i];
          LLastCell.FJointCellRole := jcrSingle;
          LLastCell.FJointCellMaster := LLastCell;
        end;
        LNCell.FJointCellRole := jcrSingle;
        LNCell.FJointCellMaster := LNCell;
      end
      else
      begin
        LItemIndex := LNCell.RowIndex;
        LRowCount := LNCell.FJointRowCount;
        LCellIndex := LNCell.Index;
        LColumnCount := LNCell.FJointColumnCount;
        for y := LItemIndex to LItemIndex + LRowCount - 1 do
        begin
          LItem := LHeader.Rows[y];
          for x := LCellIndex to LCellIndex + LColumnCount - 1 do
          begin
            with LItem.Cell[x] do
            begin
              FJointCellRole := jcrSlave;
              FJointCellMaster := LNCell;
            end;
          end;
        end;
        LNCell.FJointCellRole := jcrMaster;
      end;
    end;
    if not (csDestroying in LHeader.ComponentState) then
      LHeader.Repaint;
  end;
end;

function TElXHeaderCell.GetHeight: Integer;
var
  LRowIndex, LRowsLeft, LItemIndexMax: Integer;
  LCell: TElXHeaderCell;
  LItem: TElXHeaderCellRow;
  LHeader: TElXCustomHeader;
begin
  LCell := GetJointRangeMasterCell as TElXHeaderCell;
  LItem := LCell.FOwner as TElXHeaderCellRow;
  Result := LItem.Height;
  if FJointCellRole = jcrSingle then
    Exit;

  LHeader := LItem.FOwner;
  LRowIndex := LItem.RowIndex + 1;
  LRowsLeft := LCell.FJointRowCount - 1;
  LItemIndexMax := LHeader.RowsList.Count - 1;
  while (LRowsLeft > 0) and (LRowIndex <= LItemIndexMax) do begin
    LItem := LHeader.Rows[LRowIndex];
    Inc(Result, LItem.Height);
    Inc(LRowIndex);
    Dec(LRowsLeft);
  end;
end;

function TElXHeaderCell.GetLeft: Integer;
//var
//  i: Integer;
//  LItem: TElXHeaderCellRow;
//  LTopItemCells: TElXHeaderCellRow;
//  LCell: TElXHeaderCell;
begin
//  Result := 0;
//  LItem := Owner;
//  LTopItemCells := LItem.FOwner.Rows[0];
//  for i := 0 - Owner.CellOffset to Index - 1 do
//  begin
//   LCell := LTopItemCells[i];
//    if Assigned(LCell.HeaderSection) then
//      Inc(Result, LCell.HeaderSection.FWidth);
//  end;
  Result := HeaderSection.Left;
end;

function TElXHeaderCell.GetIndex: Integer;
begin
//  Result := FHeaderSection.Index;
  Result := FHeaderSection.Position;
end;

function TElXHeaderCell.GetWidth: Integer;
var
  LCell: TElXHeaderCell;
  LCells: TElXHeaderCellRow;
  i: Integer;
begin
  Result := FHeaderSection.FWidth;
  if FJointCellRole = jcrSingle then
    Exit;
  LCell := GetJointRangeMasterCell as TElXHeaderCell;
  LCells := Owner;
//  if not TElXCustomHeader(FHeaderSection.Owner).RightAlignedOrder then
    for i := 1 to LCell.JointColumnCount - 1 do
      Inc(Result, LCells[LCell.Index+i].FHeaderSection.FWidth)
{ else
    for i := LCell.JointColumnCount - 1 downto 1 do
      Inc(Result, LCells[LCell.Index-i].FHeaderSection.FWidth)
}
end;

function TElXHeaderCell.GetJointCellMaster: TElXHeaderCell;
begin
  Result := TElXHeaderCell(inherited JointCellMaster);
end;

function TElXHeaderCell.GetRowIndex: Integer;
begin
  Result := GetJointCellMaster.Owner.GetRowIndex;
end;

function TElXHeaderCell.GetBottom: Integer;
begin
  Result := Top + Height;
end;

function TElXHeaderCell.GetTop: Integer;
var
  i: Integer;
  LHeader: TElXCustomHeader;
begin
  Result := 0;
  LHeader := Owner.FOwner;
  for i := 1 to RowIndex do
    Inc(Result, LHeader.Rows[i].Height);
end;

procedure TElXHeaderCell.SetAlignment(value: TElSAlignment);
begin
  if FAlignment = value then Exit;
  FAlignment := value;
  FHeaderSection.UpdateSection;
end;

procedure TElXHeaderCell.LoadFromStream(Stream: TStream);

begin
  inherited;

  Stream.ReadBuffer(FAlignment, SizeOf(FAlignment));

end;

procedure TElXHeaderCell.WriteToStream(Stream: TStream);
begin
  inherited;

  Stream.WriteBuffer(FAlignment, SizeOf(FAlignment));

end;

{ TElXHeaderCellRow }

procedure TElXHeaderCellRow.Delete(AIndex: Integer);
begin
  if Cell[AIndex].FJointCellRole <> jcrSingle then
  begin
    Cell[AIndex].SmartSplit;
  end;
//  if not FOwner.RightAlignedOrder then
    inherited Delete(AIndex + CellOffset)
//  else
//    inherited Delete(AIndex);
end;

function TElXHeaderCellRow.GetCell(AIndex: Integer): TElXHeaderCell;
begin
  Result := inherited GetCell(AIndex + CellOffset) as TElXHeaderCell
end;

function TElXHeaderCellRow.IntGetCount: Integer;
begin
  Result := inherited IntGetCount - CellOffset;
  if Result < 0 then
    Result := 0;
end;

function TElXHeaderCellRow.IndexOf(ACell: TElXHeaderCell): Integer;
begin
//  if not FOwner.RightAlignedOrder then
    Result := inherited IndexOf(ACell) - CellOffset
//  else
//    Result := inherited IndexOf(ACell);
end;

function TElXHeaderCellRow.InsertCell(AIndex: Integer; AHeaderSection: TElXHeaderSection; Convert: Boolean = True): TElXHeaderCell;
begin
  Result := TElXHeaderCell.Create(Self, AHeaderSection);
//  if FOwner.RightAlignedOrder and Convert then
//  begin
//    AIndex := min(Count + 1 - AIndex, Count);
//  end;
  inherited Insert(AIndex, Result);
end;

constructor TElXHeaderCellRow.Create(AOwner: TElXCustomHeader);
begin
  inherited Create;
  FOwner := AOwner;
  FComplexHeight := AOwner.RowHeight;
end;

function TElXHeaderCellRow.CreateCell(
  AHeaderSection: TElXHeaderSection): TElXHeaderCell;
begin
  Result := TElXHeaderCell.Create(Self, AHeaderSection);
end;

function TElXHeaderCellRow.GetHeader: TElXCustomHeader;
begin
  Result := FOwner;
end;

function TElXHeaderCellRow.GetHeight: Integer;
begin
  Result := FComplexHeight;
end;

function TElXHeaderCellRow.GetRowIndex: Integer;
begin
  Result := FOwner.FRowsList.IndexOf(Self);
end;

procedure TElXHeaderCellRow.SetHeight(newValue: Integer);
begin
  FComplexHeight := newValue;
end;

procedure TElXHeaderCellRow.SplitCells;
var
  i: integer;
begin
  for i := -CellOffset to Count - 1 do
  begin
    if cell[i].JointCellRole <> jcrSingle then
      cell[i].SmartSplit;
  end;
end;

destructor TElXHeaderCellRow.Destroy;
begin
  SplitCells;
  inherited;
end;

function TElXHeaderCellRow.CellOffset: integer;
begin
  Result := FOwner.SectionOffset;
end;

end.
