unit LMDIdeCompBar;
{$I LMDCmps.inc}

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

LMDIdeCompBar unit (YB)
-----------------------
TLMDComponentBar unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, ComCtrls, ImgList,
  Forms, Menus, ExtCtrls, GraphUtil, intfLMDBase, LMDTypes, LMDSvcPvdr,
  LMDDsgClass, LMDUnicodeControl, LMDIdeCst, LMDIdeClass;

type
  ELMDComponentBar = class(Exception);
  TLMDComponentBar = class;
  TLMDCompBarPage  = class;

  {****************************** TLMDCompBarItem *****************************}

  TLMDCompBarItem = class
  private
    FPage:       TLMDCompBarPage;
    FImageIndex: Integer;
    FClass:      TComponentClass;
    
    function GetDisplayString: TLMDString;
  public
    constructor Create(APage: TLMDCompBarPage);
    destructor Destroy; override;

    property Page: TLMDCompBarPage read FPage;
    property Class_: TComponentClass read FClass;
    property ImageIndex: Integer read FImageIndex;
  end;

  {****************************** TLMDCompBarPage ******************************}

  TLMDCompBarPage = class
  private
    FBar:      TLMDComponentBar;
    FName:     TLMDString;
    FItems:    TList;
    FExpanded: Boolean;

    procedure InternalSetExpanded(AAutoCollapse, AUpdateLayout,
                                  AValue: Boolean);
    procedure CleanupItems;
    function  AddItem(AClass: TComponentClass;
                      AImageIndex: Integer): TLMDCompBarItem;
    procedure RemoveItem(AClass: TComponentClass);
    function  IndexOfItem(AClass: TComponentClass): Integer;
    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDCompBarItem;
    procedure SetExpanded(const Value: Boolean);
  public
    constructor Create(ABar: TLMDComponentBar; const AName: TLMDString;
                       AIndex: Integer = -1);
    destructor Destroy; override;

    property Bar: TLMDComponentBar read FBar;
    property Name: TLMDString read FName;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDCompBarItem read GetItems; default;
    property Expanded: Boolean read FExpanded write SetExpanded;
  end;

  {**************************** TLMDComponentBar ******************************}

  TLMDComponentBarPageStyle = (psBDS, psFlat);
  TLMDComponentBarOnGetItemCaption = procedure(Sender: TObject;
    AItem: TLMDCompBarItem; var ACaption: TLMDString) of object;

  TLMDComponentBarRowKind       = (prkPageHeader, prkItem);
  TLMDComponentBarRowPaintState = (prpsNormal, prpsHot, prpsSelected,
                                   prpsSelectedDown);
  TLMDComponentBarRowInfo       = record
    Kind:       TLMDComponentBarRowKind;
    Bounds:     TRect;
    Data:       TObject; // Page or item.
    PaintState: TLMDComponentBarRowPaintState;
  end;

  TLMDComponentBarRowInfos = array of TLMDComponentBarRowInfo;

  TLMDComponentBar = class(TCustomControl, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FBCBBugFix:           TLMDComponentBarRowInfo; // This member is actually not used,
                                                   // but will fix dynamic array BCB
                                                   // bug.
    FPages:               TList;
    FImages:              TImageList;
    FImagesChangeLink:    TChangeLink;
    FSelectedItem:        TLMDCompBarItem;
    FStandardPage:        TLMDString;
    FServiceProvider:     TLMDServiceProvider;
    FRows:                TLMDComponentBarRowInfos;
    FRowsHeight:          Integer;
    FHotRow:              Integer;
    FScrollPos:           Integer;
    FHotItemColor:        TColor;
    FSelectedItemColor:   TColor;
    FCategoryFont:        TFont;
    FAutoCollapse:        Boolean;
    FMouseDown:           Boolean;
    FOnGetItemCaption:    TLMDComponentBarOnGetItemCaption;
    FOnChange:            TNotifyEvent;
    FPageStyle:           TLMDComponentBarPageStyle;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure InsertPage(APage: TLMDCompBarPage; AIndex: Integer);
    procedure RemovePage(APage: TLMDCompBarPage);
    function  FindPage(const AName: string): TLMDCompBarPage;
    function  FindByCompClass(ACompClass: TComponentClass): TLMDCompBarPage;
    procedure ClearPages(AClearStdPage: Boolean);
    procedure ImagesChange(Sender: TObject);
    function  GetPageCount: Integer;
    function  GetPages(AIndex: Integer): TLMDCompBarPage;
    procedure SetStandardPage(const Value: TLMDString);
    function  IsStandardPageStored: Boolean;
    procedure SetImages(const Value: TImageList);
    function  GetSelectedClass: TComponentClass;
    procedure SetSelectedItem(const Value: TLMDCompBarItem);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    function  RowAtPos(AX, AY: Integer): Integer;
    function  RowByItem(AItem: TLMDCompBarItem): Integer;
    procedure SetHotItemColor(const Value: TColor);
    procedure SetSelectedItemColor(const Value: TColor);
    procedure SetCategoryFont(const Value: TFont);
    procedure CategoryFontChanged(Sender: TObject);
    function  IsOnExpandButton(AIndex: Integer; AX: Integer): Boolean;
    procedure SetAutoCollapse(const Value: Boolean);
    procedure InternalSetSelectedItem(AItem: TLMDCompBarItem;
                                      AUpdateLayout: Boolean);
    procedure SetPageStyle(const Value: TLMDComponentBarPageStyle);
  protected
    { ILMDComponent }

    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure Click; override;
    procedure DblClick; override;
    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor(AState: TLMDComponentBarRowPaintState): TColor;
    function  GetThemedCategoryTextColor: TColor;
    procedure GetThemedCategoryColors(out C1, C2, C3: TColor);
    procedure Paint; override;
    function  GetItemCaption(AItem: TLMDCompBarItem): TLMDString; virtual;
    procedure Change; virtual;

    function  GetRowPaintState(AIndex: Integer): TLMDComponentBarRowPaintState;
    procedure PaintRow(AIndex: Integer);

    procedure UpdateLayout(AInvalidate: Boolean = True);
    procedure UpdateTracking; overload;
    procedure UpdateTracking(AInvalidate, AMouseDown: Boolean); overload;

    procedure UpdateScrollBar;
    procedure RestrictScrollPos(var AScrollPos: Integer);
    procedure SetScrollPosFromUI(AValue: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegisterComponent(const APageName: TLMDString;
                                AClass: TComponentClass;
                                AImageIndex: Integer); overload;
    procedure RegisterComponent(AClass: TComponentClass;
                                AImageIndex: Integer); overload;
    procedure UnregisterComponent(AClass: TComponentClass);

    function FindItem(AClass: TComponentClass): TLMDCompBarItem;

    property PageCount: Integer read GetPageCount;
    property Pages[AIndex: Integer]: TLMDCompBarPage read GetPages;
    property SelectedItem: TLMDCompBarItem read FSelectedItem write SetSelectedItem;
    property SelectedClass: TComponentClass read GetSelectedClass;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property PageStyle: TLMDComponentBarPageStyle read FPageStyle write SetPageStyle default psBDS;
    property StandardPage: TLMDString read FStandardPage write SetStandardPage stored IsStandardPageStored;
    property Images: TImageList read FImages write SetImages;
    property HotItemColor: TColor read FHotItemColor write SetHotItemColor default $00EFD3C6;
    property SelectedItemColor: TColor read FSelectedItemColor write SetSelectedItemColor default $00D9D5D6;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property CategoryFont: TFont read FCategoryFont write SetCategoryFont;
    property AutoCollapse: Boolean read FAutoCollapse write SetAutoCollapse default False;
    property OnGetItemCaption: TLMDComponentBarOnGetItemCaption read FOnGetItemCaption write FOnGetItemCaption;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Width default 188;
    property Height default 193;
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
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
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  {$IFDEF LMDCOMP16}
  TLMDCompBarStyleHook = class(TScrollingStyleHook);
  {$ENDIF}

implementation

uses
  Dialogs, Math, Themes, LMDStrings;

{ TLMDCompBarItem }

constructor TLMDCompBarItem.Create(APage: TLMDCompBarPage);
begin
  inherited Create;
  FPage := APage;
end;

destructor TLMDCompBarItem.Destroy;
begin
  FPage.FItems.Remove(Self);
  if FPage.FBar.FSelectedItem = Self then
    FPage.FBar.InternalSetSelectedItem(nil, False);
    
  inherited;
end;

function TLMDCompBarItem.GetDisplayString: TLMDString;
begin
  Result := Class_.ClassName;
end;

{ TLMDCompBarPage }

function TLMDCompBarPage.AddItem(AClass: TComponentClass;
  AImageIndex: Integer): TLMDCompBarItem;
begin
  Result := TLMDCompBarItem.Create(Self);
  try
    Result.FClass      := AClass;
    Result.FImageIndex := AImageIndex;

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDCompBarPage.CleanupItems;
begin
  while FItems.Count  > 0 do
    TLMDCompBarItem(FItems[0]).Free;
  FItems.Clear;
end;

constructor TLMDCompBarPage.Create(ABar: TLMDComponentBar;
  const AName: TLMDString; AIndex: Integer);
begin
  inherited Create;

  FBar      := ABar;
  FName     := AName;
  FItems    := TList.Create;

  FBar.InsertPage(Self, AIndex);
end;

destructor TLMDCompBarPage.Destroy;
begin
  FBar.RemovePage(Self);

  CleanupItems;
  FItems.Free;
  inherited;
end;

function TLMDCompBarPage.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TLMDCompBarPage.GetItems(
  AIndex: Integer): TLMDCompBarItem;
begin
  Result := TLMDCompBarItem(FItems[AIndex]);
end;

function TLMDCompBarPage.IndexOfItem(
  AClass: TComponentClass): Integer;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TLMDCompBarItem(FItems[i]).Class_ = AClass then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

procedure TLMDCompBarPage.InternalSetExpanded(AAutoCollapse,
  AUpdateLayout, AValue: Boolean);
var
  i: Integer;
begin
  if FExpanded <> AValue then
  begin
    if AAutoCollapse then
    begin
      for i := 0 to FBar.FPages.Count - 1 do
        TLMDCompBarPage(FBar.FPages[i]).FExpanded := False;
    end;

    FExpanded := AValue;
    if AUpdateLayout then
      FBar.UpdateLayout;
  end;
end;

procedure TLMDCompBarPage.RemoveItem(AClass: TComponentClass);
var
  i: Integer;
begin
  i := IndexOfItem(AClass);
  if i <> -1 then
    TLMDCompBarItem(FItems[i]).Free;
end;

procedure TLMDCompBarPage.SetExpanded(const Value: Boolean);
begin
  InternalSetExpanded(FBar.FAutoCollapse, True, Value);
end;

{ TLMDComponentBar }

procedure TLMDComponentBar.ClearPages(AClearStdPage: Boolean);

  function _FreePage(APage: TLMDCompBarPage): Boolean;
  begin
    Result := True;
    if not AClearStdPage then
      Result := (APage.Name <> FStandardPage);
  end;

var
  i: Integer;
begin
  for i := FPages.Count - 1 downto 0 do
    if _FreePage(TLMDCompBarPage(FPages[i])) then
      TLMDCompBarPage(FPages[i]).Free;

  UpdateLayout;
end;

procedure TLMDComponentBar.CMMouseEnter(var Message: TMessage);
begin
  UpdateTracking;
end;

procedure TLMDComponentBar.CMMouseLeave(var Message: TMessage);
begin
  UpdateTracking;
end;

constructor TLMDComponentBar.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle           := [csClickEvents, csDoubleClicks, csCaptureMouse,
                             csOpaque];
  FPages                 := TList.Create;
  FImagesChangeLink      := TChangeLink.Create;
  FImagesChangeLink.OnChange := ImagesChange;
  FHotRow                := -1;
  FHotItemColor          := $00EFD3C6;
  FSelectedItemColor     := $00D9D5D6;
  FCategoryFont          := TFont.Create;
  FCategoryFont.Style    := [fsBold];
  FCategoryFont.Color    := clHighlightText;
  FCategoryFont.OnChange := CategoryFontChanged;
  FPageStyle             := psBDS;

  Width  := 188;
  Height := 193;
  SetStandardPage(SLMDStdPage);

  FBCBBugFix.Data := nil; // Remove compiler hint: FBCBBugFix is declared
                          // but never used.
end;

procedure TLMDComponentBar.CreateHandle;
begin
  inherited;
  UpdateLayout;
end;

destructor TLMDComponentBar.Destroy;
begin
  ServiceProvider := nil;
  ClearPages(True);
  Images := nil;
  FPages.Free;
  FImagesChangeLink.Free;
  FCategoryFont.Free;
  inherited;
end;

function TLMDComponentBar.FindByCompClass(
  ACompClass: TComponentClass): TLMDCompBarPage;
var
  i:    Integer;
  page: TLMDCompBarPage;
begin
  for i := 0 to FPages.Count - 1 do
  begin
    page := TLMDCompBarPage(FPages[i]);
    if page.IndexOfItem(ACompClass) <> -1 then
    begin
      Result := page;
      Exit;
    end;
  end;

  Result := nil;
end;

function TLMDComponentBar.FindItem(
  AClass: TComponentClass): TLMDCompBarItem;
var
  i:    Integer;
  page: TLMDCompBarPage;
begin
  Result := nil;
  page   := FindByCompClass(AClass);

  if page <> nil then
  begin
    i := page.IndexOfItem(AClass);
    if i <> -1 then
      Result := page.Items[i];
  end;
end;

function TLMDComponentBar.FindPage(
  const AName: string): TLMDCompBarPage;
var
  i: Integer;
begin
  for i := 0 to FPages.Count  -1 do
  begin
    Result := TLMDCompBarPage(FPages[i]);
    if LMDSameText(Result.Name, AName) then
      Exit;
  end;

  Result := nil;
end;

function TLMDComponentBar.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

function TLMDComponentBar.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

function TLMDComponentBar.GetPages(
  AIndex: Integer): TLMDCompBarPage;
begin
  Result := TLMDCompBarPage(FPages[AIndex]);
end;

function TLMDComponentBar.GetSelectedClass: TComponentClass;
var
  item: TLMDCompBarItem;
begin
  item := FSelectedItem;
  if item <> nil then
    Result := item.Class_
  else
    Result := nil;
end;

function TLMDComponentBar.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scCategoryButtons)
  else
  {$ENDIF}
    Result := Color;
end;

procedure TLMDComponentBar.GetThemedCategoryColors(out C1, C2, C3: TColor);
var
  base: TColor;
  {$IFDEF LMDCOMP16}
  dtls: TThemedElementDetails;
  {$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    C1   := StyleServices.GetStyleColor(scCategoryButtonsGradientBase);
    C2   := StyleServices.GetStyleColor(scCategoryButtonsGradientEnd);
    dtls := StyleServices.GetElementDetails(tcbCategoryNormal);
    if not StyleServices.GetElementColor(dtls, ecBorderColor, C3) or
       (C3 = clNone) then
      C3 := LMDGetShadowColor(C1, -10);
  end
  else
  {$ENDIF}
  begin
    base := GetThemedBackColor;
    C1   := LMDGetShadowColor(base, -20);
    C2   := LMDGetHighLightColor(base, 10);
    C3   := LMDGetShadowColor(base, -40);
  end;
end;

function TLMDComponentBar.GetThemedCategoryTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfCatgeoryButtonsCategoryNormal)
  else
  {$ENDIF}
    Result := FCategoryFont.Color;
end;

function TLMDComponentBar.GetThemedTextColor(
  AState: TLMDComponentBarRowPaintState): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    case AState of
      prpsHot:
        Result := StyleServices.GetStyleFontColor(sfCatgeoryButtonsHot);
      prpsSelected,
      prpsSelectedDown:
        Result := StyleServices.GetStyleFontColor(sfCatgeoryButtonsSelected);
    else
      Result := StyleServices.GetStyleFontColor(sfWindowTextNormal);
    end;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

procedure TLMDComponentBar.ImagesChange(Sender: TObject);
begin
  UpdateLayout;
end;

procedure TLMDComponentBar.InsertPage(APage: TLMDCompBarPage;
  AIndex: Integer);
begin
  if AIndex = -1 then
    FPages.Add(APage)
  else
    FPages.Insert(AIndex, APage);

  UpdateLayout;
end;

function TLMDComponentBar.IsStandardPageStored: Boolean;
begin
  Result := FStandardPage <> SLMDStdPage;
end;

procedure TLMDComponentBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetFocus;
  FMouseDown := True;
  
  if (Button = mbLeft) and Enabled then
    UpdateTracking(True, True);
end;

procedure TLMDComponentBar.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  UpdateTracking;
end;

procedure TLMDComponentBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImages then
      Images := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

procedure TLMDComponentBar.RegisterComponent(AClass: TComponentClass;
  AImageIndex: Integer);
begin
  RegisterComponent(StandardPage, AClass, AImageIndex);
end;

procedure TLMDComponentBar.RegisterComponent(
  const APageName: TLMDString; AClass: TComponentClass;
  AImageIndex: Integer);
var
  page: TLMDCompBarPage;
begin
  { Check already registered }

  if FindByCompClass(AClass) <> nil then
    raise ELMDComponentBar.CreateFmt(SLMDCompClassAlradyRegistered,
                                     [AClass.ClassName]);

  { Register }

  page := FindPage(APageName);
  if page = nil then
    page := TLMDCompBarPage.Create(Self, APageName);

  if page.IndexOfItem(AClass) = -1 then
    page.AddItem(AClass, AImageIndex);

  Classes.RegisterClass(AClass); // For sure.
  UpdateLayout;
end;

procedure TLMDComponentBar.RemovePage(APage: TLMDCompBarPage);
begin
  FPages.Remove(APage);
  UpdateLayout;
end;

procedure TLMDComponentBar.Resize;
begin
  inherited;
  UpdateLayout;
end;

procedure TLMDComponentBar.SetImages(const Value: TImageList);
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnRegisterChanges(FImagesChangeLink);
    end;

    FImages := Value;

    if FImages <> nil then
    begin
      FImages.FreeNotification(Self);
      FImages.RegisterChanges(FImagesChangeLink);
    end;

    Invalidate;
  end;
end;

procedure TLMDComponentBar.SetSelectedItem(
  const Value: TLMDCompBarItem);
begin
  InternalSetSelectedItem(Value, True);
end;

procedure TLMDComponentBar.SetStandardPage(const Value: TLMDString);
var
  page: TLMDCompBarPage;
begin
  if FStandardPage <> Value then
  begin
    if FStandardPage <> '' then
    begin
      page := FindPage(FStandardPage);
      if (page <> nil) and (page.FItems.Count = 0) then
        page.Free;
    end;

    FStandardPage := Value;

    if FStandardPage <> '' then
    begin
      page := FindPage(FStandardPage);
      if page = nil then
        TLMDCompBarPage.Create(Self, FStandardPage, 0)
      else
        page.FName := FStandardPage; // Correct latters case.
    end;

    UpdateLayout;
  end;
end;

procedure TLMDComponentBar.UnregisterComponent(
  AClass: TComponentClass);
var
  page: TLMDCompBarPage;
begin
  page := FindByCompClass(AClass);

  if page <> nil then
  begin
    page.RemoveItem(AClass);

    if (page.FItems.Count = 0) and
       (page.Name <> FStandardPage) then
      page.Free;
  end;

  UpdateLayout;
end;

procedure TLMDComponentBar.UpdateTracking;
begin
  UpdateTracking(True, False);
end;

procedure TLMDComponentBar.UpdateLayout(AInvalidate: Boolean);
var
  cr:   TRect;
  y:    Integer;
  i, j: Integer;
  idx:  Integer;
  page: TLMDCompBarPage;
  item: TLMDCompBarItem;
  hdrheight: Integer;
  itmheight: Integer;
begin
  if not HandleAllocated then
    Exit;

  cr  := ClientRect;
  y   := cr.Top;
  idx := 0;

  Canvas.Font := FCategoryFont;
  hdrheight   := Max(16, Canvas.TextHeight('Wg') + 6);
  Canvas.Font := Self.Font;
  itmheight   := Max(16, Canvas.TextHeight('Wg') + 6);
  if FImages <> nil then
    itmheight   := Max(itmheight, FImages.Height + 6);

  for i := 0 to FPages.Count - 1 do
  begin
    page := TLMDCompBarPage(FPages[i]);

    SetLength(FRows, idx + 1);
    FRows[idx].Kind   := prkPageHeader;
    FRows[idx].Bounds := Rect(cr.Left, y, cr.Right, y + hdrheight);
    FRows[idx].Data   := page;
    Inc(y, hdrheight);
    Inc(idx);

    if page.FExpanded then
      for j := 0 to page.FItems.Count - 1 do
      begin
        item := TLMDCompBarItem(page.FItems[j]);

        SetLength(FRows, idx + 1);
        FRows[idx].Kind   := prkItem;
        FRows[idx].Bounds := Rect(cr.Left, y, cr.Right, y + itmheight);
        FRows[idx].Data   := item;
        Inc(y, itmheight);
        Inc(idx);
      end;
  end;

  FRowsHeight := y;

  RestrictScrollPos(FScrollPos);
  UpdateScrollBar;

  if AInvalidate then
    Invalidate;
end;

procedure TLMDComponentBar.UpdateTracking(AInvalidate,
  AMouseDown: Boolean);

  procedure _CheckRow(AIndex: Integer);
  var
    r: TRect;
  begin
    if (AIndex >= 0) and (AIndex <= High(FRows)) and
       (GetRowPaintState(AIndex) <> FRows[AIndex].PaintState) then
    begin
      r := FRows[AIndex].Bounds;
      OffsetRect(r, 0, -FScrollPos);
      InvalidateRect(Handle, @r, True);
    end;
  end;

var
  p:        TPoint;
  oldhot:   Integer;
  oldsel:   Integer;
begin
  if not HandleAllocated then
    Exit;

  GetCursorPos(p);
  p          := ScreenToClient(p);
  oldhot     := FHotRow;
  oldsel     := RowByItem(FSelectedItem);
  FHotRow    := RowAtPos(p.X, p.Y);

  if AMouseDown and (FHotRow <> -1) then
  begin
    if FRows[FHotRow].Kind = prkItem then
      FSelectedItem := TLMDCompBarItem(FRows[FHotRow].Data)
    else
      FSelectedItem := nil;
  end;

  if AInvalidate then
  begin
    _CheckRow(oldhot);
    _CheckRow(oldsel);
    _CheckRow(FHotRow);
    _CheckRow(RowByItem(FSelectedItem));
  end;
end;

procedure TLMDComponentBar.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Members.UnregisterMember(Self);
    end;
    FServiceProvider := Value;
    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Members.RegisterMember(Self);
    end;
  end;
end;

procedure TLMDComponentBar.Paint;
var
  i: Integer;
begin
  for i := 0 to High(FRows) do
    PaintRow(i);
    
  if FRowsHeight - FScrollPos < ClientHeight then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := GetThemedBackColor;
    Canvas.FillRect(Rect(0, FRowsHeight - FScrollPos, ClientWidth,
                         ClientHeight));
  end;
end;

procedure TLMDComponentBar.PaintRow(AIndex: Integer);

  procedure _DrawExpandButton(AX, AY: Integer; AExpanded: Boolean);
  var
    LDetails: TThemedElementDetails;
  begin
    with Canvas do
    begin
      if ThemeServices.ThemesEnabled then
      begin
        if AExpanded then
          LDetails := ThemeServices.GetElementDetails(ttGlyphOpened)
        else
          LDetails := ThemeServices.GetElementDetails(ttGlyphClosed);
          ThemeServices.DrawElement(Handle, LDetails,
                                    Rect(AX, AY, AX + 9, AY + 9));
      end
      else
      begin
        Pen.Color := clBlack;
        Brush.Color := clWhite;
        Rectangle(AX, AY, AX + 9, AY + 9);
        Polyline([Point(AX + 2, AY + 4), Point(AX + 7, AY + 4)]);
        if not AExpanded then
          Polyline([Point(AX + 4, AY + 2), Point(AX + 4, AY + 7)]);
      end;
    end;
  end;

  procedure _DrawFlatHeaderBackground(const R: TRect);
  var
    clr:        TColor;
    c1, c2, c3: TColor;
  begin
    clr := GetThemedBackColor;
    GetThemedCategoryColors(c1, c2, c3);

    LMDGradientFillCanvas(Canvas, c1,
                          c2,
                          Rect(R.Left, R.Top, R.Right, R.Bottom - 2),
                          gdHorizontal);

    Canvas.Pen.Color := clr;
    Canvas.Polyline([Point(R.Left, R.Bottom - 2), Point(R.Right, R.Bottom - 2)]);

    Canvas.Pen.Color := c3;
    Canvas.Polyline([Point(R.Left, R.Bottom - 1), Point(R.Right, R.Bottom - 1)]);
  end;

  procedure _DrawBDSHeaderBackground(const R: TRect);
  var
    clr:        TColor;
    c1, c2, c3: TColor;
  begin
    clr := GetThemedBackColor;
    GetThemedCategoryColors(c1, c2, c3);

    LMDGradientFillCanvas(Canvas, c1, c2, Rect(R.Left + 1, R.Top,
                          R.Right - 1, R.Bottom), gdVertical);

    Canvas.Pen.Color := c3;
    Canvas.Polyline([Point(R.Left + 3, R.Top),
                     Point(R.Right - 4, R.Top),
                     Point(R.Right - 2, R.Top + 2),
                     Point(R.Right - 2, R.Bottom - 3),
                     Point(R.Right - 4, R.Bottom - 1),
                     Point(R.Left + 3, R.Bottom - 1),
                     Point(R.Left + 1, R.Bottom - 3),
                     Point(R.Left + 1, R.Top + 2),
                     Point(R.Left + 3, R.Top)]);

    Canvas.Pen.Color := clr;
    Canvas.Pixels[R.Left + 1, R.Top]         := clr;
    Canvas.Pixels[R.Left + 2, R.Top]         := clr;
    Canvas.Pixels[R.Left + 1, R.Top + 1]     := clr;
    Canvas.Pixels[R.Left + 1, R.Bottom - 1]  := clr;
    Canvas.Pixels[R.Left + 2, R.Bottom - 1]  := clr;
    Canvas.Pixels[R.Left + 1, R.Bottom - 2]  := clr;
    Canvas.Pixels[R.Right - 2, R.Top]        := clr;
    Canvas.Pixels[R.Right - 3, R.Top]        := clr;
    Canvas.Pixels[R.Right - 2, R.Top + 1]    := clr;
    Canvas.Pixels[R.Right - 2, R.Bottom - 1] := clr;
    Canvas.Pixels[R.Right - 3, R.Bottom - 1] := clr;
    Canvas.Pixels[R.Right - 2, R.Bottom - 2] := clr;
    Canvas.Polyline([Point(R.Left, R.Top), Point(R.Left, R.Bottom)]);
    Canvas.Polyline([Point(R.Right - 1, R.Top), Point(R.Right - 1, R.Bottom)]);
  end;

const
  IMT_XIDENT = 3;
var
  pstate: TLMDComponentBarRowPaintState;
  bnds:   TRect;
  page:   TLMDCompBarPage;
  item:   TLMDCompBarItem;
  xoff:   Integer;
  yoff:   Integer;
  r:      TRect;
  {$IFDEF LMDCOMP16}
  dtls:   TThemedElementDetails;
  {$ENDIF}
begin
  pstate := GetRowPaintState(AIndex);
  bnds   := FRows[AIndex].Bounds;
  OffsetRect(bnds, 0, -FScrollPos);

  if FRows[AIndex].Kind = prkPageHeader then
  begin
    { Draw header }

    page := TLMDCompBarPage(FRows[AIndex].Data);

    Canvas.Pen.Color := GetThemedBackColor;
    Canvas.Polyline([Point(bnds.Left, bnds.Top), Point(bnds.Right, bnds.Top)]);
    r := Rect(bnds.Left, bnds.Top + 1, bnds.Right, bnds.Bottom);

    if FPageStyle = psBDS then
      _DrawBDSHeaderBackground(r)
    else
      _DrawFlatHeaderBackground(r);

    yoff := ((bnds.Bottom - bnds.Top) - 9) div 2;
    xoff := yoff;

    _DrawExpandButton(bnds.Left + xoff, bnds.Top + yoff, page.FExpanded);

    xoff := xoff + 9 + 8;
    yoff := ((bnds.Bottom - bnds.Top) - Canvas.TextHeight('Wg')) div 2;

    Canvas.Font        := FCategoryFont;
    Canvas.Font.Color  := GetThemedCategoryTextColor;
    Canvas.Brush.Style := bsClear;
    LMDTextRect(Canvas, bnds, bnds.Left + xoff, bnds.Top + yoff, page.Name);
    Canvas.Brush.Style := bsSolid;
  end
  else
  begin
    { Draw item }

    item := TLMDCompBarItem(FRows[AIndex].Data);

    Canvas.Brush.Color := GetThemedBackColor;
    Canvas.FillRect(Rect(bnds.Left, bnds.Top, bnds.Left + IMT_XIDENT, bnds.Bottom));
    Canvas.FillRect(Rect(bnds.right - IMT_XIDENT, bnds.Top, bnds.Right, bnds.Bottom));

    r := Rect(bnds.Left + IMT_XIDENT, bnds.Top,
              bnds.Right - IMT_XIDENT, bnds.Bottom);

    {$IFDEF LMDCOMP16}
    if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    begin
      case pstate of
        prpsNormal:
        begin
          Canvas.Brush.Color := GetThemedBackColor;
          Canvas.FillRect(r);
        end;
        prpsHot:
        begin
          dtls := StyleServices.GetElementDetails(tcbButtonHot);
          StyleServices.DrawElement(Canvas.Handle, dtls, r);
        end;
        prpsSelected,
        prpsSelectedDown:
        begin
          dtls := StyleServices.GetElementDetails(tcbButtonSelected);
          StyleServices.DrawElement(Canvas.Handle, dtls, r);
        end;
      end;
    end
    else
    {$ENDIF}
    begin
      case pstate of
        prpsNormal:
        begin
          Canvas.Brush.Color := GetThemedBackColor;
          Canvas.Pen.Color   := Canvas.Brush.Color;
        end;
        prpsHot:
        begin
          Canvas.Brush.Color := FHotItemColor;
          Canvas.Pen.Color   := GetShadowColor(Canvas.Brush.Color);
        end;
        prpsSelected,
        prpsSelectedDown:
        begin
          Canvas.Brush.Color := FSelectedItemColor;
          Canvas.Pen.Color   := GetShadowColor(Canvas.Brush.Color);
        end;
      end;
      Canvas.Rectangle(r);
    end;

    if (FImages <> nil) and (item.ImageIndex >= 0) and
       (item.ImageIndex <= FImages.Count) then
    begin
      yoff := ((bnds.Bottom - bnds.Top) - FImages.Height) div 2;
      xoff := yoff + IMT_XIDENT;

      if pstate = prpsSelectedDown then
      begin
        Inc(xoff);
        Inc(yoff);
      end;

      FImages.Draw(Canvas, bnds.Left + xoff, bnds.Top + yoff,
                   item.ImageIndex, dsTransparent, itImage);
      Inc(xoff, FImages.Width);
    end
    else
      xoff := bnds.Left + IMT_XIDENT;

    xoff := xoff + 12;
    yoff := ((bnds.Bottom - bnds.Top) - Canvas.TextHeight('Wg')) div 2;

    if pstate = prpsSelectedDown then
      Inc(yoff); // xoff already incremented.

    Canvas.Font        := Font;
    Canvas.Font.Color  := GetThemedTextColor(pstate);
    Canvas.Brush.Style := bsClear;
    Canvas.Refresh;

    LMDTextRect(Canvas, bnds, bnds.Left + xoff, bnds.Top + yoff,
                GetItemCaption(item));
    Canvas.Brush.Style := bsSolid;
  end;

  FRows[AIndex].PaintState := pstate;
end;

function TLMDComponentBar.RowAtPos(AX, AY: Integer): Integer;
var
  i: Integer;
  p: TPoint;
begin
  p := Point(AX, AY + FScrollPos);

  for i := 0 to High(FRows) do
    if PtInRect(FRows[i].Bounds, p) then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

function TLMDComponentBar.RowByItem(
  AItem: TLMDCompBarItem): Integer;
var
  i: Integer;
begin
  for i := 0 to High(FRows) do
    if FRows[i].Data = AItem then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

procedure TLMDComponentBar.DblClick;
var
  p:   TPoint;
  idx: Integer;
begin
  GetCursorPos(p);
  p          := ScreenToClient(p);
  idx        := RowAtPos(p.X, p.Y);

  if (idx <> -1) and (FRows[idx].Kind = prkPageHeader) then
  begin
    TLMDCompBarPage(FRows[idx].Data).InternalSetExpanded(
          FAutoCollapse, True,
          not TLMDCompBarPage(FRows[idx].Data).FExpanded);
  end;

  inherited;
end;

procedure TLMDComponentBar.UpdateScrollBar;
var
  LSI: TScrollInfo;
begin
  if not HandleAllocated then
    Exit;

  LSI.cbSize := SizeOf(LSI);
  LSI.fMask  := SIF_ALL;
  GetScrollInfo(Self.Handle, SB_VERT, LSI);

  LSI.nPage  := ClientHeight;
  LSI.nMin   := 0;
  LSI.nMax   := FRowsHeight - 1;
  LSI.nPos   := FScrollPos;
  SetScrollInfo(Self.Handle, SB_VERT, LSI, True);
end;

procedure TLMDComponentBar.WMVScroll(var Message: TWMVScroll);
var
  spos: Integer;
  LSI:  TScrollInfo;
begin
  SetFocus;
  spos := FScrollPos;

  with Message do
    case ScrollCode of
      SB_LINEUP:      spos := FScrollPos - 20;
      SB_LINEDOWN:    spos := FScrollPos + 20;
      SB_PAGEUP:      spos := FScrollPos - ClientHeight;
      SB_PAGEDOWN:    spos := FScrollPos + ClientHeight;
      SB_THUMBPOSITION, SB_THUMBTRACK:
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_VERT, LSI);
          spos := LSI.nTrackPos;
        end;
      SB_BOTTOM:      spos := FRowsHeight - ClientHeight;
      SB_TOP:         spos := 0;
    end;

  SetScrollPosFromUI(spos);
  Message.Result := 0;
end;

procedure TLMDComponentBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  {$IFDEF LMDCOMP7}
  if csParentBackground in ControlStyle then // Remove some flickers.
    inherited;
  {$ENDIF}
end;

procedure TLMDComponentBar.SetHotItemColor(const Value: TColor);
begin
  FHotItemColor := Value;
  Invalidate;
end;

procedure TLMDComponentBar.SetSelectedItemColor(const Value: TColor);
begin
  FSelectedItemColor := Value;
  Invalidate;
end;

procedure TLMDComponentBar.SetCategoryFont(const Value: TFont);
begin
  FCategoryFont.Assign(Value);
end;

procedure TLMDComponentBar.CategoryFontChanged(Sender: TObject);
begin
  UpdateLayout;
end;

function TLMDComponentBar.IsOnExpandButton(AIndex: Integer;
  AX: Integer): Boolean;
var
  off: Integer;
begin
  off    := ((FRows[AIndex].Bounds.Bottom - FRows[AIndex].Bounds.Top) - 9) div 2;
  Result := (AX >= off) and (AX <= off + 9);
end;

procedure TLMDComponentBar.Click;
var
  p:   TPoint;
  idx: Integer;
begin
  GetCursorPos(p);
  p          := ScreenToClient(p);
  idx        := RowAtPos(p.X, p.Y);

  if (idx <> -1) and (FRows[idx].Kind = prkPageHeader) and
     IsOnExpandButton(idx, p.X) then
  begin
    TLMDCompBarPage(FRows[idx].Data).InternalSetExpanded(
          FAutoCollapse, True,
          not TLMDCompBarPage(FRows[idx].Data).FExpanded);
  end;

  inherited;
end;

procedure TLMDComponentBar.SetAutoCollapse(const Value: Boolean);
begin
  FAutoCollapse := Value;
end;

function TLMDComponentBar.GetItemCaption(
  AItem: TLMDCompBarItem): TLMDString;
begin
  Result := AItem.GetDisplayString;
  if Assigned(FOnGetItemCaption) then
    FOnGetItemCaption(Self, AItem, Result);
end;

function TLMDComponentBar.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);

  if not Result then
  begin
    SetScrollPosFromUI(FScrollPos + 20);
    Result := True;
  end;
end;

function TLMDComponentBar.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);

  if not Result then
  begin
    SetScrollPosFromUI(FScrollPos - 20);
    Result := True;
  end;
end;

procedure TLMDComponentBar.RestrictScrollPos(var AScrollPos: Integer);
begin
  if AScrollPos > FRowsHeight - ClientHeight then
    AScrollPos := FRowsHeight - ClientHeight;
  if AScrollPos < 0 then
    AScrollPos := 0;
end;

procedure TLMDComponentBar.SetScrollPosFromUI(AValue: Integer);
begin
  RestrictScrollPos(AValue);

  if AValue <> FScrollPos then
  begin
    FScrollPos := AValue;
    UpdateTracking;
    UpdateScrollBar;
    Invalidate;
  end;
end;

procedure TLMDComponentBar.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FMouseDown := False;
  UpdateTracking;
end;

function TLMDComponentBar.GetRowPaintState(
  AIndex: Integer): TLMDComponentBarRowPaintState;
var
  bnds: TRect;
  p:    TPoint;
begin
  if FRows[AIndex].Kind = prkPageHeader then
    Result := prpsNormal
  else if FRows[AIndex].Data = FSelectedItem then
  begin
    GetCursorPos(p);
    p := ScreenToClient(p);

    bnds := FRows[AIndex].Bounds;
    OffsetRect(bnds, 0, -FScrollPos);

    if FMouseDown and PtInRect(bnds, p) then
      Result := prpsSelectedDown
    else
      Result := prpsSelected;
  end
  else if AIndex = FHotRow then
    Result := prpsHot
  else
    Result := prpsNormal;
end;

procedure TLMDComponentBar.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  FMouseDown := False;
  UpdateTracking;
end;

procedure TLMDComponentBar.InternalSetSelectedItem(AItem: TLMDCompBarItem;
  AUpdateLayout: Boolean);
begin
  if AItem <> FSelectedItem then
  begin
    FSelectedItem := AItem;
    if AUpdateLayout then
      UpdateLayout;

    Change;
  end;
end;

procedure TLMDComponentBar.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TLMDComponentBar.SetPageStyle(
  const Value: TLMDComponentBarPageStyle);
begin
  if FPageStyle <> Value then
  begin
    FPageStyle := Value;
    Invalidate;
  end;
end;

initialization
  {$IFDEF LMDCOMP16}
  TCustomStyleEngine.RegisterStyleHook(TLMDComponentBar, TLMDCompBarStyleHook);
  {$ENDIF}

finalization
  {$IFDEF LMDCOMP16}
  TCustomStyleEngine.UnRegisterStyleHook(TLMDComponentBar, TLMDCompBarStyleHook);
  {$ENDIF}

end.
