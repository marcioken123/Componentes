unit LMDCustomSheetControl;
{$I lmdcmps.INC}

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

LMDCustomSheetControl unit (RM)
-------------------------------
Base class for controls which can act as sheet container.

Changes
-------
Release 8.0 (July 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Menus, StdCtrls, Forms, Messages, Themes,
  LMDCustomPanelFill, LMDCustomPanel, LMDBase;

type

  {****************** TLMDCustomSheetControl control **************************}
  TLMDCustomSheetControl = class;

  {------------------------- TLMDCustomPage -----------------------------------}
  TLMDCustomSheet = class(TLMDCustomPanelFill)
  private
    FSheetControl:TLMDCustomSheetControl;
    FInclude: Boolean;
    FOnBeforeShowPage,
    FOnAfterShowPage:TNotifyEvent;
    FOnNextPage:TLMDStandardEvent;
    FDescription:String;
    procedure SetSheetControl(aValue:TLMDCustomSheetControl);
    procedure SetInclude(aValue:Boolean);
    procedure SetPageIndex(aValue:Integer);
    function GetPageIndex: Integer;
  protected
    procedure DoThemeChanged;override;
    procedure Loaded;override;
    procedure ReadState(Reader:TReader);override;
    property Visible default False;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy; override;
    property SheetControl: TLMDCustomSheetControl read FSheetControl write SetSheetControl;
    property Align default alClient;
    property Included:Boolean read FInclude write SetInclude default True;
  published
    property About;
    property Bevel;
    property Caption;
    property Description:String read FDescription write FDescription;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property OnBeforeShowPage:TNotifyEvent read FOnBeforeShowPage write FOnBeforeShowPage;
    property OnAfterShowPage:TNotifyEvent read FOnAfterShowPage write FOnAfterShowPage;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    // 8.0
    property ParentBackground default true;
    // --
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
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
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    // V4 enhancements
    //property Anchors;
    //property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

  TLMDSheetClass = class of TLMDCustomSheet;

  {------------------------- TLMDCustomSheetControl ---------------------------}
  TLMDCustomSheetControl = class(TLMDCustomPanel)
  private
    FAutoFocus:Boolean;
    FActivePage:TLMDCustomSheet;
    FOnChange:TNotifyEvent;
    {internal}
    FPages:TList;
    FSaveResources,
    FStartFirstPage:Boolean;
    procedure SetPageIndex(aValue:Integer);
    procedure SetActiveSheet(aValue:TLMDCustomSheet);
    function GetSheet(Index:Integer):TLMDCustomSheet;
    function GetPageIndex:Integer;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMERASEBKGND(var Message: TWMERASEBKGND); message WM_ERASEBKGND;
  protected
    procedure AlignControls(aControl:TControl;var Rect:TRect);override;
    procedure CreateParams(var Params: TCreateParams);  override;
    procedure CleanResources;
    procedure DoChange;
    procedure DoPageChange(NewPage:TLMDCustomSheet; var Cancel:Boolean);virtual;abstract;
    function FindNextPage(CurPage:TLMDCustomSheet; GoForward, CheckInclude: Boolean):TLMDCustomSheet;
    function FindNewActiveSheet(CurPage:TLMDCustomSheet):TLMDCustomSheet;
    procedure Loaded;override;
    procedure Paint;override;
    function GetCount:Integer;
    function GetChildOwner: TComponent; override;
    function GetVisible(Index:Integer):Boolean;virtual;
    function GetVisibleCount:Integer;virtual;
    property PageIndex:Integer read GetPageIndex write SetPageIndex stored false;
  public
    constructor Create(AnOwner: TComponent);  override;
    destructor Destroy;  override;

    function GetSheetClass:TLMDSheetClass;virtual;abstract;
    // 7.04
    property AutoFocus:Boolean read FAutoFocus write FAutoFocus default true;
    // ----
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ActivePageByCaption(const aValue:String);
    procedure ActivePageByName(const aValue:String);

    procedure FirstPage;virtual;
    procedure InitPages;
    procedure InsertPage(aValue:TLMDCustomSheet; Active:Boolean=true);
    procedure LastPage;
    procedure MovePage(OldIndex, NewIndex: Integer);virtual;
    procedure NextPage;
    procedure PrevPage;
    // does not actually free aValue!
    procedure RemovePage(aValue:TLMDCustomSheet);
    // frees aValue!
    procedure FreePage(aValue:TLMDCustomSheet);
    procedure FreePages;

    property Sheets:TList read FPages;
    property Count:Integer read GetCount;
    {array properties}
    property Sheet[Index:Integer]:TLMDCustomSheet read GetSheet;
    property ActiveSheet: TLMDCustomSheet read FActivePage write SetActiveSheet;
    property CtlXP;   // compatibility
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
  published
    property About;
    property Transparent;
    // 7.0
    property SaveResources:Boolean read FSaveResources write FSaveResources default False;
    property StartFirstPage:Boolean read FStartFirstPage write FStartFirstPage default true;
    {own events}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    {inherited events}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

implementation
uses
  LMDClass, LMDGraph, LMDResWinControl, LMDProcs, LMDGraphUtils, LMDButtonBase, LMDThemes;

{********************** class TLMDCustomSheet *********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDCustomSheet.SetSheetControl(aValue:TLMDCustomSheetControl);
begin
  if FSheetControl<>aValue then
    begin
      if Assigned(FSheetControl) then
        FSheetControl.RemovePage(Self);
      if aValue<>nil then
        aValue.InsertPage(Self);
      FSheetControl:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheet.SetInclude(aValue:Boolean);
begin
  if (FInclude<>aValue) then
    begin
      FInclude:=aValue;
      if (csDesigning in ComponentState) or not Assigned(FSheetControl) then exit;
      if FInclude then
        FSheetControl.DoChange
      else
        if (FSheetControl.ActiveSheet=Self) and not FInclude then
          FSheetControl.ActiveSheet:=FSheetControl.FindNewActiveSheet(self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheet.SetPageIndex(aValue:Integer);
begin
  if Assigned(FSheetControl) then
    FSheetControl.MovePage(PageIndex, aValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheet.GetPageIndex: Integer;
begin
  result := -1;
  if Assigned(FSheetControl) then
    result := FSheetControl.FPages.IndexOf(Self)
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDCustomSheet.DoThemeChanged;
begin
  if Assigned(FSheetControl) then
    FThemeMode := FSheetControl.ThemeMode;
  CheckOpaqueState;
  // RM - Themes
  NotifyControls (CM_LMDTHEMECHANGED);
  //inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheet.Loaded;
begin
  inherited;
  if Assigned(FSheetControl) then
    FThemeMode := FSheetControl.ThemeMode;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheet.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if (Reader.Parent is TLMDCustomSheetControl) then
    SheetControl:=TLMDCustomSheetControl(Reader.Parent);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDCustomSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csDoubleClicks, csAcceptsControls, csNoDesignVisible];
  Align:=alClient;
  FInclude:=True;
  Visible:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSheet.Destroy;
begin
  SheetControl:=nil;
  inherited Destroy;
end;

{********************** class TLMDCustomSheetControl **************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDCustomSheetControl.SetActiveSheet(aValue:TLMDCustomSheet);
var
  tmp:Boolean;
begin
  if (aValue=nil) then
    begin
      if Assigned(FActivePage) and not (csDestroying in FActivePage.ComponentState) then
        begin
          if Assigned(FActivePage.FOnAfterShowPage) then
            FActivePage.FOnAfterShowPage(FActivePage);
          FActivePage.Visible:=False;
        end;
      FActivePage:=nil;
      if NeedInvalidate then
         GetChange(nil);
      exit;
    end;

  if (aValue=FActivePage) or (FPages.Indexof(aValue)=-1) or IsUpdating then
    begin
      if NeedInvalidate then
        GetChange(nil);
      exit;
    end;

  tmp:=False;

  DoPageChange(aValue, tmp);
  if tmp then exit;

  with aValue do
    begin
      //if not aValue.HandleAllocated then
      //  aValue.HandleNeeded;
      DisableAlign;
      Visible:=True;

      BringToFront;
      if not (csDesigning in ComponentState) then
        if (CanFocus and FAutoFocus) then SelectFirst;

      if Assigned(FActivePage) then
        begin
          if Assigned(FActivePage.FOnAfterShowPage) then FActivePage.FOnAfterShowPage(FActivePage);
          FActivePage.Visible:=False;
        end;

      if Assigned(aValue.FOnBeforeShowPage) then aValue.FOnBeforeShowPage(aValue);
      FActivePage:=aValue;

      EnableAlign;

      // 7.01
      if FSaveResources then
      // ----
        CleanResources;  // a simple way

      if Assigned(FOnChange) and ([csLoading, csDestroying, csReading]*ComponentState=[]) then
        FOnChange(Self);

      if Self.NeedInvalidate then
        Self.GetChange(self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.SetPageIndex(aValue:Integer);
var
  tmp:TLMDCustomSheet;
begin
  if aValue=-1 then
    tmp:=nil
  else
    tmp:= TLMDCustomSheet(FPages[aValue]);
  if (ActiveSheet <> tmp) or ([csReading, csLoading]*ComponentState<>[]) then
    ActiveSheet := tmp;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.GetCount: Integer;
begin
  Result:=FPages.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.GetSheet(Index:Integer):TLMDCustomSheet;
begin
  Result:=TLMDCustomSheet(FPages[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.GetPageIndex: Integer;
begin
  Result:=FPages.IndexOf(FActivePage);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.WMERASEBKGND(var Message: TWMERASEBKGND);
var
  aRect:TRect;
  lThemeMode: TLMDThemeMode;
begin
  lThemeMode := UseThemeMode;
  if lThemeMode<>ttmNone {and IsNotOpaque} then
    begin
      aRect:=ClientRect;
      InflateRect(aRect, 4, 4);
      LMDThemeServices.DrawElement(lThemeMode, Message.DC, ttPane, aRect);
      Message.Result := 1;
    end
  else
    inherited;
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDCustomSheetControl.AlignControls(aControl:TControl;var Rect:TRect);
begin
  inherited AlignControls(aControl, Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.CleanResources;
var
  i:Integer;
begin
  for i := 0 to FPages.Count-1 do
    begin
      if (ActiveSheet<>Sheet[i]) and (Sheet[i].HandleAllocated) then
        LMDFreeResources(Sheet[i]);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      Style := Style or WS_CLIPCHILDREN;
      WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.FindNextPage(CurPage:TLMDCustomSheet; GoForward, CheckInclude: Boolean): TLMDCustomSheet;
var
  Index:Integer;
begin
  result:=nil;
  Index:=FPages.IndexOf(CurPage);
  if (CurPage=nil) or (Index=-1) then exit;

  if GoForward then
    begin
      Inc(Index);
      while (Index<FPages.Count) do
        if (not CheckInclude) or TLMDCustomSheet(FPages[Index]).Included then
          begin
            Result:=TLMDCustomSheet(FPages[Index]);
            Exit;
          end
        else
          Inc(Index)
    end
  else
    begin
      Dec(Index);
      while (Index>=0) do
        if (not CheckInclude) or TLMDCustomSheet(FPages[Index]).Included then
          begin
            Result:=TLMDCustomSheet(FPages[Index]);
            Exit;
          end
        else
          Dec(index);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.FindNewActiveSheet(CurPage: TLMDCustomSheet): TLMDCustomSheet;
var
  index:Integer;
begin
  result:=nil;
  if FPages.Count>0 then
    Index:=FPages.IndexOf(CurPage)
  else
    exit;
  if (Index<>-1) then
    begin
      result:=FindNextPage(CurPage, True, true);
      if result=nil then
        result:=FindNextPage(CurPage, False, true);
      if result=CurPage then result:=nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.Loaded;
begin
  inherited Loaded;
  if FStartFirstPage and not (csDesigning in ComponentState) then
    InitPages;
  if FSaveResources then
    CleanResources;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i:Integer;
begin
  for i:=0 to Pred(FPages.Count) do Proc(TComponent(FPages[i]));
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.GetChildOwner: TComponent;
begin
  result:=inherited GetChildOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomSheetControl.GetVisibleCount: Integer;
var
  i:Integer;
begin
  result:=0;
  for i:=0 to FPages.Count-1 do
    Inc(result, Ord(GetVisible(i)));
end;

{------------------------------------------------------------------------------}
function TLMDCustomSheetControl.GetVisible(Index: Integer): Boolean;
begin
  if csDesigning in ComponentState then  // at designtime always visible
    result:=true
  else
    result:=Sheet[Index].Included;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.Paint;
var
  lThemeMode:TLMDThemeMode;

  procedure DrawBackGround;
  var
    aRect:TRect;
  begin
    aRect:=ClientRect;
    InflateRect(aRect, 4, 4);
    LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, ttPane, aRect);
  end;

begin
  if isUpdating then exit;
  lThemeMode := UseThemeMode;
  if (lThemeMode<>ttmNone) and (not IsNotOpaque) then
    DrawBackground;
  if csDesigning in ComponentState then
    begin
      if not ((lThemeMode<>ttmNone) and not Transparent) then
        inherited Paint;
      if (FPages.Count=0) then
        begin
          DrawDashedFrame;
          Canvas.TextOut(5,5,'No Pages available (use Context Menu to add pages).');
        end
    end
  else
    if (GetVisibleCount=0) and (not (lThemeMode<>ttmNone)) then
      inherited Paint;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDCustomSheetControl.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
  ControlStyle:=ControlStyle-[csAcceptsControls{$IFDEF LMDCOMP10}, csPannable{$ENDIF}];
  FAutoFocus:=true;
  FStartFirstPage:=True;
  FPages:=TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSheetControl.Destroy;
begin
  FPages.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.DoChange;
begin
  GetChange(nil);
end;

{public page handling methods}
{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.ActivePageByCaption(const aValue:String);
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=0;
      while i<Count do
        if Sheet[i].Included and (aValue=Sheet[i].Caption) then
          begin
            ActiveSheet:=Sheet[i];
            exit;
          end
        else
          Inc(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.ActivePageByName(const aValue:String);
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=0;
      while i<Count do
        if Sheet[i].Included and (aValue=Sheet[i].Name) then
          begin
            ActiveSheet:=Sheet[i];
            exit;
          end
        else
          Inc(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.FirstPage;
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=0;
      while i<Count do
        if Sheet[i].Included then
          begin
            ActiveSheet:=Sheet[i];
            exit;
          end
        else
          Inc(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.InitPages;
begin
  FirstPage;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.InsertPage(aValue:TLMDCustomSheet;Active:Boolean=true);
begin
  if aValue=nil then
    exit
  else
    if FPages.IndexOf(aValue)=-1 then FPages.Add(aValue);
  aValue.Parent:=Self;
  aValue.FSheetControl:=self;
  if Active and ([csLoading, csDestroying, csReading]*ComponentState=[]) then
    ActiveSheet:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.LastPage;
var
  i:Integer;
begin
  if FPages.Count>0 then
    begin
      i:=Pred(Count);
      while i>=0 do
        if Sheet[i].Included then
          begin
            ActiveSheet:=Sheet[i];
            exit;
          end
        else
          Dec(i);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.MovePage(OldIndex, NewIndex: Integer);
begin
  FPages.Move(OldIndex, NewIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.NextPage;
var
  tmp:TLMDCustomSheet;
  bCancel: boolean;
begin
  bCancel := false;
  if Assigned(ActiveSheet.FOnNextPage) then
    ActiveSheet.FOnNextPage(Self, bCancel);
  if bCancel then exit;
  tmp:=FindNextPage(ActiveSheet, True, True);
  if Assigned(tmp) then ActiveSheet:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.PrevPage;
var
  tmp:TLMDCustomSheet;
begin
  tmp:=FindNextPage(ActiveSheet, False, True);
  if Assigned(tmp) then ActiveSheet:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.RemovePage(aValue:TLMDCustomSheet);
var
  Index:Integer;
  tmp:TLMDCustomSheet;
begin
  if FPages.Count>0 then
    Index:=FPages.IndexOf(aValue)
  else
    Index:=-1;

  if Index<>-1 then
    begin
      tmp:=FindNewActiveSheet(aValue);
      FPages.Delete(Index);
      aValue.FSheetControl:=nil;
      if not (csDestroying in ComponentState) then
        ActiveSheet:=tmp;
    end;

  if Assigned(FPages) and not (csDestroying in ComponentState) then
    if (FPages.Count=0) and (ActiveSheet<>nil) then
      ActiveSheet:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.FreePage(aValue: TLMDCustomSheet);
var
  i:Integer;
begin
  if aValue<>nil then
    begin
      i:=FPages.IndexOf(aValue);
      if i<>-1 then
        begin
          RemovePage(aValue);
          FreeAndNil(aValue);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSheetControl.FreePages;
begin
  BeginUpdate;
  try
    while FPages.Count>0 do
      FreePage(Sheet[FPages.Count-1]);
  finally
    EndUpdate(true);
  end;
end;

end.

