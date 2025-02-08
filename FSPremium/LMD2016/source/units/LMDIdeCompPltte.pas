unit LMDIdeCompPltte;
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

LMDIdeCompPltte unit (YB)
------------------------
TLMDComponentPalette unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, ComCtrls,
  ImgList, Forms, Menus, ExtCtrls, intfLMDBase, LMDTypes, LMDSvcPvdr,
  LMDInsClass, LMDUnicodeControl, LMDIdeCst, LMDIdeClass;

type
  ELMDComponentPalette = class(Exception);
  TLMDComponentPalette = class;
  TLMDCompPalettePage  = class;

  {*************************** TLMDCompPalettePageItem ************************}

  TLMDCompPalettePageItem = class
  private
    FPage:       TLMDCompPalettePage;
    FImageIndex: Integer;
    FClass:      TComponentClass;
    
    function GetDisplayString: TLMDString;
  public
    constructor Create(APage: TLMDCompPalettePage);
    destructor Destroy; override;

    property Page: TLMDCompPalettePage read FPage;
    property Class_: TComponentClass read FClass;
    property ImageIndex: Integer read FImageIndex;
  end;

  {**************************** TLMDCompPalettePage ***************************}

  TLMDCompPalettePage = class
  private
    FPalette: TLMDComponentPalette;
    FName:    TLMDString;
    FItems:   TList;

    procedure CleanupItems;
    function  AddItem(AClass: TComponentClass;
                      AImageIndex: Integer): TLMDCompPalettePageItem;
    procedure RemoveItem(AClass: TComponentClass);
    function  IndexOfItem(AClass: TComponentClass): Integer;
    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDCompPalettePageItem;
  public
    constructor Create(APalette: TLMDComponentPalette; const AName: TLMDString;
                       AIndex: Integer = -1);
    destructor Destroy; override;

    property Palette: TLMDComponentPalette read FPalette;
    property Name: TLMDString read FName;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDCompPalettePageItem read GetItems; default;
  end;

  {**************************** TLMDComponentPalette **************************}

  TLMDCompPaletteBtnKind = (pbkArrow, pbkComponent, pbkDropDown);
  TLMDCompPaletteBtnInfo = record
    Kind:     TLMDCompPaletteBtnKind;
    Bounds:   TRect;
    PageItem: TLMDCompPalettePageItem;
  end;

  TLMDCompPaletteBtnInfos = array of TLMDCompPaletteBtnInfo;

  TLMDCompPaletteOnComponentHint = procedure(Sender: TObject;
    AItem: TLMDCompPalettePageItem; var AHint: TLMDString) of object;
  TLMDCompPaletteOnGetDropItemCaption = procedure(Sender: TObject;
    AItem: TLMDCompPalettePageItem; var ACaption: TLMDString) of object;

  TLMDComponentPalette = class(TCustomTabControl, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FBCBBugFix:           TLMDCompPaletteBtnInfo; // This member is actually not used,
                                                  // but will fix dynamic array BCB
                                                  // bug.
    FPages:                TList;
    FActivePage:           TLMDCompPalettePage;
    FStandardPage:         TLMDString;
    FButtons:              TLMDCompPaletteBtnInfos;
    FCompBtnCount:         Integer;
    FSelectedItem:         TLMDCompPalettePageItem;
    FHotButton:            Integer;
    FImages:               TImageList;
    FImagesChangeLink:     TChangeLink;
    FArrowBitmap:          TBitmap; // Lazy inited, use GetArrowBitmap.
    FDropDownBitmap:       TBitmap; // Lazy inited, use GetDropDownBitmap.
    FServiceProvider:      TLMDServiceProvider;
    FHint:                 TObject; // TPaletteHint.
    FLastHintButton:       Integer;
    FDropList:             TPopupMenu;
    FComponentHints:       Boolean;
    FOnComponentHint:      TLMDCompPaletteOnComponentHint;
    FOnGetDropItemCaption: TLMDCompPaletteOnGetDropItemCaption;

    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure InsertPage(APage: TLMDCompPalettePage; AIndex: Integer);
    procedure RemovePage(APage: TLMDCompPalettePage);
    function  FindPage(const AName: string): TLMDCompPalettePage;
    function  FindByCompClass(ACompClass: TComponentClass): TLMDCompPalettePage;
    function  ButtonByItem(AItem: TLMDCompPalettePageItem): Integer;
    procedure ClearPages(AClearStdPage: Boolean);
    function  GetArrowBitmap: TBitmap;
    function  GetDropDownBitmap: TBitmap;
    procedure ImagesChange(Sender: TObject);
    procedure DropListClick(Sender: TObject);
    function  GetPageCount: Integer;
    function  GetPages(AIndex: Integer): TLMDCompPalettePage;
    procedure SetStandardPage(const Value: TLMDString);
    function  IsStandardPageStored: Boolean;
    procedure SetImages(const Value: TImageList);
    function  GetSelectedClass: TComponentClass;
    procedure SetActivePage(const Value: TLMDCompPalettePage);
    procedure SetSelectedItem(const Value: TLMDCompPalettePageItem);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetComponentHints(const Value: Boolean);
  protected
    { ILMDComponent }

    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure Change; override;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoComponentHint(AItem: TLMDCompPalettePageItem;
                              var AHint: TLMDString); virtual;

    function  ButtonAtPos(AX, AY: Integer): Integer;
    procedure PaintPage(C: TCanvas);
    procedure PaintButton(C: TCanvas; AIndex: Integer);
    procedure PaintDropListItem(Sender: TObject; ACanvas: TCanvas;
                                ARect: TRect; State: TOwnerDrawState);
    procedure UpdateTabs;
    procedure UpdatePage(AInvalidate: Boolean = True);
    procedure UpdateTracking; overload;
    procedure UpdateTracking(AInvalidate: Boolean; AMouseDown: Boolean;
                             out ADropList: Boolean); overload;
    procedure UpdateHint;
    procedure DoDropList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure RegisterComponent(const APageName: TLMDString;
                                AClass: TComponentClass;
                                AImageIndex: Integer); overload;
    procedure RegisterComponent(AClass: TComponentClass;
                                AImageIndex: Integer); overload;
    procedure UnregisterComponent(AClass: TComponentClass);

    function FindItem(AClass: TComponentClass): TLMDCompPalettePageItem;

    property PageCount: Integer read GetPageCount;
    property Pages[AIndex: Integer]: TLMDCompPalettePage read GetPages;
    property ActivePage:  TLMDCompPalettePage read FActivePage write SetActivePage;
    property SelectedItem: TLMDCompPalettePageItem read FSelectedItem write SetSelectedItem;
    property SelectedClass: TComponentClass read GetSelectedClass;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property StandardPage: TLMDString read FStandardPage write SetStandardPage stored IsStandardPageStored;
    property Images: TImageList read FImages write SetImages;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property ComponentHints: Boolean read FComponentHints write SetComponentHints default True;
    property OnComponentHint: TLMDCompPaletteOnComponentHint read FOnComponentHint write FOnComponentHint;
    property OnGetDropItemCaption: TLMDCompPaletteOnGetDropItemCaption read FOnGetDropItemCaption write FOnGetDropItemCaption;
    property Height default 65;
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
    property TabHeight;
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
  TLMDCompPaletteStyleHook = class(TTabControlStyleHook)
  strict protected
    procedure Paint(Canvas: TCanvas); override;
  end;
  {$ENDIF}

implementation

uses
  Dialogs, Math, Themes, LMDStrings;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{------------------------------------------------------------------------------}

type
  TPaletteHintTimerMode = (tmShow, tmHide);

  TPaletteHint = class
  private
    FPalette:    TLMDComponentPalette;
    FTimer:      TTimer;
    FTimerMode:  TPaletteHintTimerMode;
    FPos:        TPoint;
    FMsg:        TLMDString;
    FActive:     Boolean;
    FHintWindow: TLMDHintWindow;

    procedure TimerOnTimer(Sender: TObject);
    procedure UpdateNoPause;
  public
    constructor Create(APalette: TLMDComponentPalette);
    destructor Destroy; override;

    procedure UpdateHint(const APos: TPoint; const AMsg: TLMDString);
    procedure CancelHint;
    procedure IsHintMsg(var AMsg: TMsg);
    property  Active: Boolean read FActive;
  end;

  TDropListMenuItem = class(TMenuItem)
  public
    PageItem: TLMDCompPalettePageItem;
  end;

{******************************** TPaletteHint ********************************}
{------------------------------------------------------------------------------}

procedure TPaletteHint.TimerOnTimer(Sender: TObject);
begin
  case FTimerMode of
    tmShow: UpdateNoPause;
    tmHide: CancelHint;
  end;
end;
          
{------------------------------------------------------------------------------}

procedure TPaletteHint.UpdateNoPause;
var
  r: TRect;
begin
  FTimer.Enabled := False;

  LMDHookHint(IsHintMsg);

  r := FHintWindow.CalcHintRect(Screen.Width, FMsg, nil);
  OffsetRect(r, FPos.X, FPos.Y);

  FHintWindow.Color       := Application.HintColor;
  FHintWindow.Canvas.Font := Screen.HintFont;
  FHintWindow.ActivateHint(r, FMsg);
  FHintWindow.Update;

  FTimer.Interval := Application.HintHidePause;
  FTimerMode      := tmHide;
  FTimer.Enabled  := True;

  FActive := True;
end;
             
{------------------------------------------------------------------------------}

constructor TPaletteHint.Create(APalette: TLMDComponentPalette);
begin
  inherited Create;
  FPalette       := APalette;
  FTimer         := TTimer.Create(nil);
  FTimer.OnTimer := TimerOnTimer;
  FHintWindow    := TLMDHintWindow.Create(nil);
end;
         
{------------------------------------------------------------------------------}

destructor TPaletteHint.Destroy;
begin
  CancelHint;
  FTimer.Free;
  FHintWindow.Free;
  inherited;
end;
             
{------------------------------------------------------------------------------}

procedure TPaletteHint.UpdateHint(const APos: TPoint;
  const AMsg: TLMDString);
begin
  FPos := APos;
  FMsg := AMsg;

  if not FActive then
  begin
    FTimer.Enabled  := False;
    FTimer.Interval := Application.HintPause;
    FTimerMode      := tmShow;
    FTimer.Enabled  := True;
  end
  else
    UpdateNoPause;
end;
       
{------------------------------------------------------------------------------}

procedure TPaletteHint.CancelHint;
begin
  FTimer.Enabled := False;

  ShowWindow(FHintWindow.Handle, SW_HIDE);
  LMDUnhookHint(IsHintMsg);

  FActive := False;
end;
     
{------------------------------------------------------------------------------}

procedure TPaletteHint.IsHintMsg(var AMsg: TMsg);
begin
  if (FHintWindow <> nil) and FHintWindow.IsHintMsg(AMsg) then
      CancelHint;
end;

{**************************** TLMDCompPalettePageItem *************************}
{------------------------------------------------------------------------------}

constructor TLMDCompPalettePageItem.Create(APage: TLMDCompPalettePage);
begin
  inherited Create;
  FPage := APage;
end;

{------------------------------------------------------------------------------}

destructor TLMDCompPalettePageItem.Destroy;
begin
  if FPage.FPalette.FSelectedItem = Self then
    FPage.FPalette.FSelectedItem := nil;
  inherited;
end;
      
{------------------------------------------------------------------------------}

function TLMDCompPalettePageItem.GetDisplayString: TLMDString;
begin
  Result := Class_.ClassName;

  if (Length(Result) >= 2) and ((Result[1] = 't') or (Result[1] = 'T')) then
    Result := Copy(Result, 2, MaxInt);
end;

{***************************** TLMDCompPalettePage ****************************}
{------------------------------------------------------------------------------}

procedure TLMDCompPalettePage.CleanupItems;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDCompPalettePageItem(FItems[i]).Free;
  FItems.Clear;
end;
         
{------------------------------------------------------------------------------}

function TLMDCompPalettePage.AddItem(AClass: TComponentClass;
  AImageIndex: Integer): TLMDCompPalettePageItem;
begin
  Result := TLMDCompPalettePageItem.Create(Self);
  try
    Result.FClass      := AClass;
    Result.FImageIndex := AImageIndex;

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;
           
{------------------------------------------------------------------------------}

procedure TLMDCompPalettePage.RemoveItem(AClass: TComponentClass);
var
  i: Integer;
begin
  i := IndexOfItem(AClass);
  if i <> -1 then
  begin
    TLMDCompPalettePageItem(FItems[i]).Free;
    FItems.Delete(i);
  end;
end;
       
{------------------------------------------------------------------------------}

function TLMDCompPalettePage.IndexOfItem(AClass: TComponentClass): Integer;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TLMDCompPalettePageItem(FItems[i]).Class_ = AClass then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;
         
{------------------------------------------------------------------------------}

function TLMDCompPalettePage.GetCount: Integer;
begin
  Result := FItems.Count;
end;
       
{------------------------------------------------------------------------------}

function TLMDCompPalettePage.GetItems(
  AIndex: Integer): TLMDCompPalettePageItem;
begin
  Result := TLMDCompPalettePageItem(FItems[AIndex]);
end;
      
{------------------------------------------------------------------------------}

constructor TLMDCompPalettePage.Create(APalette: TLMDComponentPalette;
  const AName: TLMDString; AIndex: Integer);
begin
  inherited Create;

  FPalette := APalette;
  FName    := AName;
  FItems   := TList.Create;

  FPalette.InsertPage(Self, AIndex);
end;
         
{------------------------------------------------------------------------------}

destructor TLMDCompPalettePage.Destroy;
begin
  FPalette.RemovePage(Self);

  CleanupItems;
  FItems.Free;
  inherited;
end;

{***************************** TLMDComponentPalette ***************************}
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.WMPaint(var Message: TWMPaint);
begin
  ControlState := ControlState + [csCustomPaint];
  inherited;
  ControlState := ControlState - [csCustomPaint];
end;
        
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.CMMouseEnter(var Message: TMessage);
begin
  UpdateTracking;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.CMMouseLeave(var Message: TMessage);
begin
  UpdateTracking;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  TPaletteHint(FHint).CancelHint;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.InsertPage(APage: TLMDCompPalettePage;
  AIndex: Integer);
begin
  if AIndex = -1 then
    FPages.Add(APage)
  else
    FPages.Insert(AIndex, APage);

  if FActivePage = nil then
    FActivePage := APage;

  UpdateTabs;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.RemovePage(APage: TLMDCompPalettePage);
begin
  FPages.Remove(APage);
  if FActivePage = APage then
  begin
    if FPages.Count > 0 then
      FActivePage := TLMDCompPalettePage(FPages[0])
    else
      FActivePage := nil;
  end;

  UpdateTabs;
end;
       
{------------------------------------------------------------------------------}

function TLMDComponentPalette.FindPage(
  const AName: string): TLMDCompPalettePage;
var
  i: Integer;
begin
  for i := 0 to FPages.Count  -1 do
  begin
    Result := TLMDCompPalettePage(FPages[i]);
    if LMDSameText(Result.Name, AName) then
      Exit;
  end;

  Result := nil;
end;
       
{------------------------------------------------------------------------------}

function TLMDComponentPalette.FindByCompClass(
  ACompClass: TComponentClass): TLMDCompPalettePage;
var
  i:    Integer;
  page: TLMDCompPalettePage;
begin
  for i := 0 to FPages.Count - 1 do
  begin
    page := TLMDCompPalettePage(FPages[i]);
    if page.IndexOfItem(ACompClass) <> -1 then
    begin
      Result := page;
      Exit;
    end;
  end;

  Result := nil;
end;
    
{------------------------------------------------------------------------------}

function TLMDComponentPalette.ButtonByItem(
  AItem: TLMDCompPalettePageItem): Integer;
var
  i: Integer;
begin
  for i := 0 to High(FButtons) do
    if FButtons[i].PageItem = AItem then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.ClearPages(AClearStdPage: Boolean);

  function _FreePage(APage: TLMDCompPalettePage): Boolean;
  begin
    Result := True;
    if not AClearStdPage then
      Result := (APage.Name <> FStandardPage);
  end;

var
  i: Integer;
begin
  for i := FPages.Count - 1 downto 0 do
    if _FreePage(TLMDCompPalettePage(FPages[i])) then
      TLMDCompPalettePage(FPages[i]).Free;

  UpdateTabs;
end;
       
{------------------------------------------------------------------------------}

function TLMDComponentPalette.GetArrowBitmap: TBitmap;
begin
  if FArrowBitmap = nil then
  begin
    FArrowBitmap := TBitmap.Create;
    FArrowBitmap.Width       := 16;
    FArrowBitmap.Height      := 16;
    FArrowBitmap.Transparent := True;
    FArrowBitmap.LoadFromResourceName(HInstance, 'LMDIDE_COMPPALARROW');
  end;
  Result := FArrowBitmap;
end;
    
{------------------------------------------------------------------------------}

function TLMDComponentPalette.GetDropDownBitmap: TBitmap;
begin
  if FDropDownBitmap = nil then
  begin
    FDropDownBitmap := TBitmap.Create;
    FDropDownBitmap.Width       := 16;
    FDropDownBitmap.Height      := 16;
    FDropDownBitmap.Transparent := True;
    FDropDownBitmap.LoadFromResourceName(HInstance, 'LMDIDE_COMPPALDROPDOWN');
  end;
  Result := FDropDownBitmap;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.ImagesChange(Sender: TObject);
begin
  Invalidate;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.DropListClick(Sender: TObject);
begin
  SetSelectedItem(TLMDCompPalettePageItem(TMenuItem(Sender).Tag));
end;

{------------------------------------------------------------------------------}

function TLMDComponentPalette.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;
      
{------------------------------------------------------------------------------}

function TLMDComponentPalette.GetPages(
  AIndex: Integer): TLMDCompPalettePage;
begin
  Result := TLMDCompPalettePage(FPages[AIndex]);
end;
            
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetStandardPage(const Value: TLMDString);
var
  page: TLMDCompPalettePage;
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
        TLMDCompPalettePage.Create(Self, FStandardPage, 0)
      else
        page.FName := FStandardPage; // Correct latters case.
    end;

    UpdateTabs;
  end;
end;
    
{------------------------------------------------------------------------------}

function TLMDComponentPalette.IsStandardPageStored: Boolean;
begin
  Result := FStandardPage <> SLMDStdPage;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetImages(const Value: TImageList);
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
          
{------------------------------------------------------------------------------}

function TLMDComponentPalette.GetSelectedClass: TComponentClass;
var
  item: TLMDCompPalettePageItem;
begin
  item := FSelectedItem;
  if item <> nil then
    Result := item.Class_
  else
    Result := nil;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetActivePage(
  const Value: TLMDCompPalettePage);
begin
  if FActivePage <> Value then
  begin
    Assert((Value = nil) or (Value.FPalette = Self),
           'Can''t activate page from another palette.');

    if Value = nil then
    begin
      if FPages.Count > 0 then
        FActivePage := TLMDCompPalettePage(FPages[0])
      else
        FActivePage := nil;
    end
    else
      FActivePage := Value;

    UpdateTabs;
  end;
end;
           
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetSelectedItem(
  const Value: TLMDCompPalettePageItem);
begin
  if Value <> FSelectedItem then
  begin
    if Value = nil then
    begin
      FSelectedItem := nil;
      UpdatePage;
    end
    else
    begin
      ActivePage    := Value.FPage;
      FSelectedItem := Value;
      UpdatePage;
    end;
  end;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetServiceProvider(
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
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.SetComponentHints(const Value: Boolean);
begin
  if FComponentHints <> Value then
  begin
    FComponentHints := Value;
    UpdateHint;
  end;
end;
      
{------------------------------------------------------------------------------}

function TLMDComponentPalette.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.CreateHandle;
begin
  inherited;
  UpdateTabs;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.PaintWindow(DC: HDC);
var
  Message: TMessage;
begin
  { Draw tab control }

  Message.Msg := WM_PAINT;
  Message.WParam := DC;
  Message.LParam := 0;
  Message.Result := 0;
  DefaultHandler(Message);

  { Draw page area }

  Canvas.Lock;
  try
    Canvas.Handle := DC;
    try
      PaintPage(Canvas);
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
end;
           
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_NCHITTEST:
    begin
      Message.Result := HTCLIENT;
      Exit; // No inherited.
    end;
    WM_MOUSEFIRST..WM_MOUSELAST:
      UpdateTracking;
  end;

  inherited;
end;
        
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.Notification(AComponent: TComponent;
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
        
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.Change;
begin
  if (TabIndex >= 0) and (TabIndex < FPages.Count) then
    FActivePage := TLMDCompPalettePage(FPages[TabIndex])
  else
    FActivePage := nil;

  UpdatePage;
  FSelectedItem := nil;
  FHotButton    := -1;
end;

procedure TLMDComponentPalette.Resize;
begin
  inherited;
  UpdatePage;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  droplist: Boolean;
begin
  inherited;
  droplist := False;

  if (Button = mbLeft) and Enabled then
    UpdateTracking(True, True, droplist);

  if droplist then
    DoDropList;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  UpdateTracking;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.DoComponentHint(AItem: TLMDCompPalettePageItem;
  var AHint: TLMDString);
begin
  if Assigned(FOnComponentHint) then
    FOnComponentHint(Self, AItem, AHint);
end;
        
{------------------------------------------------------------------------------}

function TLMDComponentPalette.ButtonAtPos(AX, AY: Integer): Integer;
var
  i: Integer;
  p: TPoint;
begin
  p := Point(AX, AY);

  for i := 0 to High(FButtons) do
    if PtInRect(FButtons[i].Bounds, p) then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.PaintPage(C: TCanvas);
var
  i: Integer;
begin
  for i := 0 to High(FButtons) do
    PaintButton(C, i);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.PaintButton(C: TCanvas; AIndex: Integer);
var
  tstate: TThemedToolBar;
  dets:   TThemedElementDetails;
  xoff,
  yoff:   Integer;
  bnds:   TRect;
  pgitm:  TLMDCompPalettePageItem;
  isdown: Boolean;
  r:      TRect;
  edge:   Cardinal;
begin
  bnds   := FButtons[AIndex].Bounds;
  pgitm  := FButtons[AIndex].PageItem;
  isdown := (FButtons[AIndex].PageItem = FSelectedItem) and
            (FButtons[AIndex].Kind <> pbkDropDown);  

  { Fill background }

  if ThemeServices.ThemesEnabled then
  begin
    if Enabled then
    begin
      if (isdown) then
        tstate := ttbButtonPressed
      else if (AIndex = FHotButton) then
        tstate := ttbButtonHot
      else
        tstate := ttbButtonNormal;
    end
    else
      tstate := ttbButtonDisabled;

    dets := ThemeServices.GetElementDetails(tstate);
    ThemeServices.DrawElement(C.Handle, dets, bnds);
  end
  else
  begin
    if Enabled then
    begin
      if (isdown) then
        edge := BDR_SUNKENOUTER
      else if (AIndex = FHotButton) then
        edge := BDR_RAISEDINNER
      else
        edge := 0;
    end
    else
      edge := 0;

    C.Brush.Color := clBtnFace;
    C.FillRect(bnds);
    DrawEdge(C.Handle, bnds, edge, BF_RECT);

    if edge = BDR_SUNKENOUTER then
    begin
      r := bnds;
      InflateRect(r, -1, -1);

      C.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
      C.FillRect(r);
    end;
  end;

  { Draw glyph }

  if (FImages <> nil) and (pgitm <> nil) and
     (pgitm.ImageIndex >= 0) and (pgitm.ImageIndex <= FImages.Count) then
  begin
    Assert(AIndex <> 0); // Not an arrow button.

    xoff := ((bnds.Right - bnds.Left) - FImages.Width) div 2;
    yoff := ((bnds.Bottom - bnds.Top) - FImages.Height) div 2;

    if isdown then
    begin
      Inc(xoff);
      Inc(yoff);
    end;

    FImages.Draw(C, bnds.Left + xoff, bnds.Top + yoff, pgitm.ImageIndex,
                 dsTransparent, itImage);
  end
  else if (FButtons[AIndex].Kind = pbkArrow) then 
  begin
    xoff := ((bnds.Right - bnds.Left) - GetArrowBitmap.Width) div 2;
    yoff := ((bnds.Bottom - bnds.Top) - GetArrowBitmap.Height) div 2;

    if isdown then
    begin
      Inc(xoff);
      Inc(yoff);
    end;

    C.Draw(bnds.Left + xoff, bnds.Top + yoff, GetArrowBitmap);
  end
  else if (FButtons[AIndex].Kind = pbkDropDown) then
  begin
    xoff := ((bnds.Right - bnds.Left) - GetDropDownBitmap.Width) div 2;
    yoff := ((bnds.Bottom - bnds.Top) - GetDropDownBitmap.Height) div 2;

    C.Draw(bnds.Left + xoff, bnds.Top + yoff, GetDropDownBitmap);
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.PaintDropListItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
var
  item:    TLMDCompPalettePageItem;
  tstate:  TThemedToolBar;
  dets:    TThemedElementDetails;
  edge:    Cardinal;
  isdown:  Boolean;
  off:     Integer;
  r:       TRect;
begin
  item   := TDropListMenuItem(Sender).PageItem;
  isdown := (item = FSelectedItem);
  off    := 0;

  { Fill background }

  if ThemeServices.ThemesEnabled then
  begin
    if Enabled then
    begin
      if (isdown) then
        tstate := ttbButtonPressed
      else if (odSelected in State) then
        tstate := ttbButtonHot
      else
        tstate := ttbButtonNormal;
    end
    else
      tstate := ttbButtonDisabled;

    dets := ThemeServices.GetElementDetails(tstate);

    ACanvas.FillRect(ARect);
    ThemeServices.DrawElement(ACanvas.Handle, dets, ARect);
  end
  else
  begin
    if Enabled then
    begin
      if (isdown) then
        edge := BDR_SUNKENOUTER
      else if (odSelected in State) then
        edge := BDR_RAISEDINNER
      else
        edge := 0;
    end
    else
      edge := 0;

    ACanvas.Brush.Color := clBtnFace;
    ACanvas.FillRect(ARect);
    DrawEdge(ACanvas.Handle, ARect, edge, BF_RECT);

    if edge = BDR_SUNKENOUTER then
    begin
      r := ARect;
      InflateRect(r, -1, -1);

      ACanvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
      ACanvas.FillRect(r);
    end;
  end;

  { Draw glyph }

  if (FImages <> nil) and (item.ImageIndex >= 0) and
     (item.ImageIndex <= FImages.Count) then
  begin
    off := ((ARect.Bottom - ARect.Top) - FImages.Height) div 2;

    FImages.Draw(ACanvas, ARect.Left + off, ARect.Top + off,
                 item.ImageIndex, dsTransparent, itImage);
    Inc(off, FImages.Width);
  end;

  { Draw text }

  ACanvas.Brush.Style := bsClear;
  LMDTextRect(ACanvas, ARect,
              ARect.Left + off + 2,
              ARect.Top + ((ARect.Bottom - ARect.Top) -
                                ACanvas.TextHeight('Wg')) div 2,
              item.GetDisplayString);
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UpdateTabs;
var
  i:      Integer;
  page:   TLMDCompPalettePage;
  tabidx: Integer;
begin
  if not HandleAllocated then
    Exit;

  Tabs.BeginUpdate;
  try
    Tabs.Clear;
    tabidx := -1;
    for i := 0 to FPages.Count - 1 do
    begin
      page := TLMDCompPalettePage(FPages[i]);
      Tabs.Add(page.Name);

      if page = FActivePage then
        tabidx := i;
    end;
    TabIndex := tabidx;
  finally
    Tabs.EndUpdate;
  end;

  UpdatePage;
end;
              
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UpdatePage(AInvalidate: Boolean);
const
  BTN_IDENT     = 3;
  BTN_WIDTH     = 28;
  BTN_HEIGHT    = 28;
  DROPBTN_WIDTH = 12;
var
  i:        Integer;
  idx:      Integer;
  x:        Integer;
  dr:       TRect;
  y:        Integer;
  dropbtn:  Boolean;
  dummy:    Boolean;
begin
  if not HandleAllocated then
    Exit;

  dr      := DisplayRect;
  x       := dr.Left + BTN_IDENT;
  y       := dr.Top + BTN_IDENT;
  idx     := 0;
  dropbtn := False;

  { Arrow button }

  SetLength(FButtons, 1);

  FButtons[0].Kind     := pbkArrow;
  FButtons[0].Bounds   := Rect(x, y, x + BTN_WIDTH, y + BTN_HEIGHT);
  FButtons[0].PageItem := nil;
  Inc(x, BTN_WIDTH + BTN_IDENT * 4);
  Inc(idx);

  { Component buttons }

  if FActivePage <> nil then
  begin
    FCompBtnCount := Min(Max((dr.Right - x) div BTN_WIDTH, 0),
                         FActivePage.FItems.Count);

    if FCompBtnCount < FActivePage.FItems.Count then
    begin
      dropbtn := True;
      if (FCompBtnCount * BTN_WIDTH) + (DROPBTN_WIDTH + BTN_IDENT) > (dr.Right - x) then
        FCompBtnCount := Max(FCompBtnCount - 1, 0);
    end;

    SetLength(FButtons, idx + FCompBtnCount);

    for i := 0 to FCompBtnCount - 1 do
    begin
      FButtons[idx].Kind     := pbkComponent;
      FButtons[idx].Bounds   := Rect(x, y, x + BTN_WIDTH, y + BTN_HEIGHT);
      FButtons[idx].PageItem := TLMDCompPalettePageItem(FActivePage.FItems[i]);
      Inc(x, BTN_WIDTH);
      Inc(idx);
    end;
  end;

  { Drop down list button }

  if dropbtn then
  begin
    SetLength(FButtons, idx + 1);

    FButtons[idx].Kind     := pbkDropDown;
    FButtons[idx].Bounds   := Rect(x, y, x + DROPBTN_WIDTH, y + BTN_HEIGHT);
    FButtons[idx].PageItem := nil;
  end;

  UpdateTracking(False, False, dummy);

  if AInvalidate then
    InvalidateRect(Handle, @dr, True);
end;
                
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UpdateTracking;
var
  dummy: Boolean;
begin
  UpdateTracking(True, False, dummy);
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UpdateTracking(AInvalidate: Boolean;
  AMouseDown: Boolean; out ADropList: Boolean);
var
  p:        TPoint;
  r:        TRect;
  oldhot:   Integer;
  olddown:  Integer;
  curdown:  Integer;
begin
  if not HandleAllocated then
    Exit;

  GetCursorPos(p);
  p          := ScreenToClient(p);
  oldhot     := FHotButton;
  olddown    := ButtonByItem(FSelectedItem);
  curdown    := olddown;
  FHotButton := ButtonAtPos(p.X, p.Y);
  ADropList  := False;

  if AMouseDown and (FHotButton <> -1) then
  begin
    if FButtons[FHotButton].Kind <> pbkDropDown then
    begin
      curdown       := FHotButton;
      FSelectedItem := FButtons[curdown].PageItem;
    end
    else
      ADropList := True;
  end;

  if AInvalidate then
  begin
    if (FHotButton <> oldhot) and
       (oldhot >= 0) and (oldhot <= High(FButtons)) then
    begin
      r := FButtons[oldhot].Bounds;
      InvalidateRect(Handle, @r, True);
    end;
    if (curdown <> olddown) and
       (olddown >= 0) and (olddown <= High(FButtons)) then
    begin
      r := FButtons[olddown].Bounds;
      InvalidateRect(Handle, @r, True);
    end;
    if ((FHotButton <> oldhot) or (curdown <> olddown)) and
       (FHotButton >= 0) and (FHotButton <= High(FButtons)) then
    begin
      r := FButtons[FHotButton].Bounds;
      InvalidateRect(Handle, @r, True);
    end;
  end;

  UpdateHint;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UpdateHint;
var
  pos: TPoint;
  msg: TLMDString;
begin
  if HandleAllocated and FComponentHints and (FHotButton >= 0) and
     (FButtons[FHotButton].Kind = pbkComponent) then
  begin
    if FHotButton <> FLastHintButton then
    begin
      pos := Point(FButtons[FHotButton].Bounds.Left,
                   FButtons[FHotButton].Bounds.Bottom + 2);
      pos := ClientToScreen(pos);
      msg := FButtons[FHotButton].PageItem.GetDisplayString;

      DoComponentHint(FButtons[FHotButton].PageItem, msg);
      TPaletteHint(FHint).UpdateHint(pos, msg);
    end;
  end
  else
    TPaletteHint(FHint).CancelHint;

  FLastHintButton := FHotButton;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.DoDropList;
var
  i:       Integer;
  bntr:    TRect;
  pt:      TPoint;
  pitem:   TLMDCompPalettePageItem;
  mitem:   TDropListMenuItem;
  s:       TLMDString;
begin
  if FActivePage = nil then
    Exit;

  if FDropList = nil then
    FDropList := TPopupMenu.Create(nil);

  FDropList.Items.Clear;
  FDropList.Images    := FImages;
  FDropList.OwnerDraw := True;

  for i := FCompBtnCount to FActivePage.FItems.Count - 1 do
  begin
    pitem := TLMDCompPalettePageItem(FActivePage.FItems[i]);
    s     := pitem.GetDisplayString;

    if Assigned(FOnGetDropItemCaption) then
      FOnGetDropItemCaption(Self, pitem, s);

    mitem                    := TDropListMenuItem.Create(FDropList);
    mitem.Caption            := s;
    mitem.ImageIndex         := pitem.FImageIndex;
    mitem.PageItem           := pitem;
    mitem.OnAdvancedDrawItem := PaintDropListItem;
    mitem.OnClick            := DropListClick;

    FDropList.Items.Add(mitem);
  end;

  bntr := FButtons[High(FButtons)].Bounds;
  pt   := ClientToScreen(Point(bntr.Left, bntr.Bottom));

  FDropList.Popup(pt.X, pt.Y);
  UpdateTracking;
end;

{------------------------------------------------------------------------------}

constructor TLMDComponentPalette.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle      := [csClickEvents, csDoubleClicks, csCaptureMouse];
  FPages            := TList.Create;
  FHint             := TPaletteHint.Create(Self);
  FComponentHints   := True;
  FImagesChangeLink := TChangeLink.Create;
  FImagesChangeLink.OnChange := ImagesChange;

  Height := 65;
  SetStandardPage(SLMDStdPage);

  FBCBBugFix.PageItem := nil; // Remove compiler hint: FBCBBugFix is declared
                              // but never used.
end;

{------------------------------------------------------------------------------}

destructor TLMDComponentPalette.Destroy;
begin
  ServiceProvider := nil;
  ClearPages(True);
  Images := nil;
  FPages.Free;
  FHint.Free;
  FImagesChangeLink.Free;
  FArrowBitmap.Free;
  FDropDownBitmap.Free;
  FDropList.Free;
  inherited;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.RegisterComponent(
  const APageName: TLMDString; AClass: TComponentClass;
  AImageIndex: Integer);
var
  page: TLMDCompPalettePage;
begin
  { Check already registered }

  if FindByCompClass(AClass) <> nil then
    raise ELMDComponentPalette.CreateFmt(SLMDCompClassAlradyRegistered,
                                         [AClass.ClassName]);

  { Register }

  page := FindPage(APageName);
  if page = nil then
    page := TLMDCompPalettePage.Create(Self, APageName);

  if page.IndexOfItem(AClass) = -1 then
    page.AddItem(AClass, AImageIndex);

  UpdatePage;
  Classes.RegisterClass(AClass); // For sure.
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.RegisterComponent(AClass: TComponentClass;
  AImageIndex: Integer);
begin
  RegisterComponent(StandardPage, AClass, AImageIndex);
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentPalette.UnregisterComponent(AClass: TComponentClass);
var
  page: TLMDCompPalettePage;
begin
  page := FindByCompClass(AClass);

  if page <> nil then
  begin
    page.RemoveItem(AClass);

    if (page.FItems.Count = 0) and
       (page.Name <> FStandardPage) then
      page.Free;
  end;

  UpdatePage;
end;
        
{------------------------------------------------------------------------------}

function TLMDComponentPalette.FindItem(
  AClass: TComponentClass): TLMDCompPalettePageItem;
var
  i:    Integer;
  page: TLMDCompPalettePage;
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

{------------------------------------------------------------------------------}

{ TLMDCompPaletteStyleHook }

{$IFDEF LMDCOMP16}
procedure TLMDCompPaletteStyleHook.Paint(Canvas: TCanvas);
begin
  inherited;
  (Control as TLMDComponentPalette).PaintPage(Canvas);
end;
{$ENDIF}

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C3.INC}
  {$ENDIF}
  {$IFDEF LMDCOMP16}
  TCustomStyleEngine.RegisterStyleHook(TLMDComponentPalette,
                                       TLMDCompPaletteStyleHook);
  {$ENDIF}

finalization
  {$IFDEF LMDCOMP16}
  TCustomStyleEngine.UnRegisterStyleHook(TLMDComponentPalette,
                                         TLMDCompPaletteStyleHook);
  {$ENDIF}

end.

