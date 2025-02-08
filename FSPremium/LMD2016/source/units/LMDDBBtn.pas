unit LMDDBBtn;
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

LMDDBBtn unit (JH)
------------------

Database control buttons, DBNavigator and additional classes

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBConsts, DB, VDBConsts,
  LMDDBConst, LMDClass, LMDGraph,LMDButtonBase, LMDBookmarkCont, LMDSpeedButton,
  LMDButtonLayout, LMDCustomSpeedButton, LMDCustomBevelPanel;

const
  IDB_NAVBMP = 16548;
  LMDNAVBTNS = 23; // number of single glyphs saved in IDB_NAVBMP

type

  TLMDNavigateBtn = (nbFirst, nbPrior, nbNext, nbLast,
                     nbInsert, nbDelete, nbEdit, nbPost,
                     nbCancel, nbRefresh, nbSetBookmark, nbGotoBookmark,
                     nbDeleteBookmark, nbSearch, nbSetFilter, nbRemoveFilter,
                     nbClear, nbOpen, nbClose,
                     nbFindFirst, nbFindPrior, nbFindNext, nbFindLast);

  TLMDNavClick = procedure (Sender: TObject; Button: TLMDNavigateBtn) of object;
  TLMDNavGlyphSet=(ngBlack, ngColored, ngNone);

  { ----------------------------- TLMDButtonDataLink ------------------------- }
  TLMDButtonDataLink = class(TDataLink)
  private
    FDBNavComp: TComponent;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANavComponent: TComponent);
    destructor Destroy; override;
  end;

  TLMDNavButtons = set of TLMDNavigateBtn;

  TLMDOnCustomBtnClick = procedure (Sender : TObject;index : Integer) of object;

  TLMDDBNavigator = class;

  {---------------------TLMDSpecialButton--------------------------------------}
  TLMDSpecialButton = class (TCollectionItem)
  private
    FHint,
    FCaption : String;
    FGlyph   : TBitmap;
    FBtn     : TLMDSpeedButton;
    FEnabled : Boolean;
    FOnClick : TLMDOnCustomBtnClick;
    procedure SetEnabled (aValue : Boolean);
    procedure SetString (index : integer;aValue : String);
    procedure SetGlyph (aValue : TBitmap);
    procedure SetBtn (aValue : TLMDSpeedButton);
    procedure DoOnClick (Sender : TObject);
    procedure GetChange (Sender : TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Btn : TLMDSpeedButton read FBtn write SetBtn;
  published
    property Caption : String index 0 read FCaption write SetString;
    property Hint : String index 1 read FHint write SetString;
    property Glyph : TBitmap read FGlyph write SetGlyph;
    property Enabled : Boolean read FEnabled write SetEnabled;
    property Index;
    property DisplayName;

    property OnClick : TLMDOnCustomBtnClick read FOnClick write FOnClick;
  end;

  {---------------------TLMDSpecialButtons-------------------------------------}
  TLMDSpecialButtons = class (TCollection)
  private
    FNavigator: TLMDDBNavigator;
    function GetItem(Index: Integer): TLMDSpecialButton;
    procedure SetItem(Index: Integer; Value: TLMDSpecialButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Navigator : TLMDDBNavigator);
    destructor Destroy; override;
    function Add: TLMDSpecialButton;
    property Items[Index: Integer]: TLMDSpecialButton read GetItem write SetItem; default;
  end;

  { ----------------------- TLMDDBNavigator ---------------------------------- }
  TLMDDBNavigator = class (TLMDCustomBevelPanel)
  private
    FButtons  : TLMDNavButtons;
    FDataLink : TLMDButtonDataLink;
    FBookmark : TLMDBookmarkCont;
    FHideHint,
    FSingleLine,
    FShowBtnHints,
    FConfirmDelete:Boolean;
    FMinBtnSize : TPoint;
    FBtnStyle : TLMDUserButtonStyle;
    FBtnCaptions,
    FBtnHints : TStrings;
    FDisplayButtons : Array[Low (TLMDNavigateBtn)..High (TLMDNavigateBtn)] of TLMDSpeedButton;
    FCustomButtons : TLMDSpecialButtons;
    FBtnLayout : TLMDButtonLayout;
    FOnSearch : TNotifyEvent;
    //RM
    FSet:TLMDNavGlyphSet;
    FOnNavClick,
    FBeforeAction: TLMDNavClick;
    FRepeatedClick: Boolean;
    FRepeatingInterval: Word;
    procedure SetCustomButtons (aValue : TLMDSpecialButtons);
    procedure SetMinBtnSize (index, aValue : Integer);
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetBtnHints (aValue : TStrings);
    procedure SetBtnCaptions (aValue : TStrings);
    procedure SetBtnLayout (aValue : TLMDButtonLayout);
    procedure SetBtnStyle (aValue : TLMDUserButtonStyle);
    procedure SetButtons (aValue : TLMDNavButtons);
    procedure SetDataSource (aValue : TDataSource);
    procedure SetBookmark (aValue : TLMDBookmarkCont);
    procedure SetBorders (var aWidth: Integer; var aHeight: Integer);
    procedure SetRepeatedClick(aValue: Boolean);
    procedure SetRepeatingInterval(aValue: Word);
    procedure SetSet(aValue:TLMDNavGlyphSet);
    function GetDatasource : TDataSource;
    function GetMinBtnSize(Index:Integer):Integer;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;
    procedure InitButtons;
    procedure InitButtonHints(Sender : TObject);
    procedure InitButtonCaptions(Sender : TObject);
    procedure InitButtonLayouts;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize (var Message: TWMSize); message WM_SIZE;
  protected
    procedure Click; override;
    procedure DoClick (Sender : TObject);
    procedure DoThemeChanged;override;
    procedure ClickButton (btn: TLMDNavigateBtn); //new Feb 2002, JH
    procedure UpdateSize;
    procedure GetChange (Sender : TObject); override;
    function GetEmpty : Boolean; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure MouseExit; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure BtnClick (Index : TLMDNavigateBtn);
    property CtlXP;  // compatibility
    property DockManager;
  published
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    property About;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property Buttons : TLMDNavButtons read FButtons write SetButtons;
    property Bookmark : TLMDBookmarkCont read FBookmark write SetBookmark;
    property ConfirmDelete : Boolean index 1 read FConfirmDelete write SetBoolean default true;
    property HideHint : Boolean read FHideHint write FHideHint default false;
    property ShowButtonHints : Boolean read FShowBtnHints write FShowBtnHints default true;
    property ButtonHints : TStrings read FBtnHints write SetBtnHints;
    property ButtonCaptions : TStrings read FBtnCaptions write SetBtnCaptions;
    property ButtonLayout : TLMDButtonLayout read FBtnLayout write SetBtnLayout;
    property ButtonStyle:TLMDUserButtonStyle read FBtnStyle write SetBtnStyle default ubsWin40;
    property SingleLine : Boolean index 0 read FSingleLine write SetBoolean default false;
    property MinBtnWidth : Integer index 0 read GetMinBtnSize write SetMinBtnSize default 20;
    property MinBtnHeight : Integer index 1 read GetMinBtnSize write SetMinBtnSize default 18;
    property CustomButtons : TLMDSpecialButtons read FCustomButtons write SetCustomButtons;
    property GlyphSet:TLMDNavGlyphSet read FSet write SetSet default ngBlack;
    property RepeatedClick: Boolean read FRepeatedClick write SetRepeatedClick default False;
    property RepeatingInterval: Word read FRepeatingInterval write SetRepeatingInterval default 100;

    property Color;
    property Align;
    property Bevel;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property Visible;
    property PopupMenu;
    property TabStop;
    property TabOrder;
    property Transparent;
    property ThemeMode;
    property ThemeGlobalMode;    
    property ShowHint;
    property ParentShowHint;
    //events
    property OnClick;
    property OnBeforeNavBtnAction: TLMDNavClick read FBeforeAction write FBeforeAction;
    property OnNavBtnClick:TLMDNavClick read FOnNavClick write FOnNavClick;
    property OnSearch:TNotifyEvent read FOnSearch write FOnSearch;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnStartDrag;
    property OnEndDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnMouseWheel;
  end;

  procedure LMDDBNavAction(Sender:TComponent;DataSet:TDataSet;Kind:TLMDNavigateBtn;FBookMark:TLMDBookmarkCont; FConfirmDelete:Boolean);

implementation

uses
  Variants, Types,
  LMDDBSpeedButton;

const
  LMDCheckRepeatedButtons=[nbPrior, nbNext, nbInsert, nbDelete, nbFindFirst, nbFindPrior, nbFindNext, nbFindLast];
//RM
procedure LMDDBNavAction(Sender:TComponent;DataSet:TDataSet;Kind:TLMDNavigateBtn;FBookMark:TLMDBookmarkCont; FConfirmDelete:Boolean);
begin
  with DataSet do
    case Kind of
      nbPrior: Prior;
      nbNext: Next;
      nbFirst: First;
      nbLast: Last;
      nbInsert: Insert;
      nbEdit: Edit;
      nbCancel: Cancel;
      nbPost: Post;
      nbRefresh: Refresh;
      nbDelete: if (not FConfirmDelete) or (MessageDlg(SDeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel) then Delete;
      nbSetBookmark : if FBookmark <> nil then FBookMark.AddBookmark;
      nbGotoBookMark : if (FBookmark <> nil) then FBookmark.GotoBookmark;
      nbDeleteBookMark: if (FBookmark <> nil) then FBookmark.DeleteBookmark;
      nbSearch:
                if sender is TLMDDBSpeedButton then
                  begin
                    if Assigned (TLMDDBSpeedButton(Sender).OnSearch) then TLMDDBSpeedButton(Sender).OnSearch(Sender);
                  end
                else
                  if Assigned (TLMDDBNavigator(Sender).FOnSearch) then TLMDDBNavigator(Sender).FOnSearch(Sender);
      nbSetFilter: Filtered := true;
      nbRemoveFilter: Filtered := false;
      nbClear: ClearFields;
      nbOpen: Active := true;
      nbClose: Active := false;
      nbFindFirst: FindFirst;
      nbFindNext: FindNext;
      nbFindPrior: FindPrior;
      nbFindLast: FindLast;
    end;
end;

{ ************************* TLMDButtonDataLink ******************************* }
{ ---------------------------------------------------------------------------- }
constructor TLMDButtonDataLink.Create(ANavComponent: TComponent);
begin
  inherited Create;
  FDBNavComp := ANavComponent;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonDataLink.Destroy;
begin
  FDBNavComp := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonDataLink.EditingChanged;
begin
  if FDBNavComp = nil then exit;
  if FDBNavComp is TLMDDBSpeedButton then
    TLMDDBSpeedButton (FDBNavComp).EditingChanged;
  if FDBNavComp is TLMDDBNavigator then
    TLMDDBNavigator (FDBNavComp).EditingChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonDataLink.DataSetChanged;
begin
  if FDBNavComp = nil then Exit;
  if FDBNavComp is TLMDDBSpeedButton then
    TLMDDBSpeedButton (FDBNavComp).DataChanged;
  if FDBNavComp is TLMDDBNavigator then
    TLMDDBNavigator (FDBNavComp).DataChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonDataLink.ActiveChanged;
begin
  if FDBNavComp = nil then Exit;
  if FDBNavComp is TLMDDBSpeedButton then
    TLMDDBSpeedButton (FDBNavComp).ActiveChanged;
  if FDBNavComp is TLMDDBNavigator then
    TLMDDBNavigator (FDBNavComp).ActiveChanged;
end;

{ *************** TLMDSpecialButton ******************************************** }
{ --------------- private ---------------------------------------------------- }
procedure TLMDSpecialButton.SetString (index : Integer;aValue : String);
begin
  case index of
    0 : begin
          FCaption := aValue;
          FBtn.Caption := FCaption;
        end;
    1 : begin
          FHint := aValue;
          FBtn.Hint := FHint;
        end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetGlyph (aValue : TBitmap);
begin
  FGlyph.Assign (aValue);
  FBtn.Glyph:= (FGlyph);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetBtn (aValue : TLMDSpeedButton);
begin
  FBtn.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.SetEnabled (aValue : Boolean);
begin
  FEnabled := aValue;
  FBtn.Enabled := FEnabled;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDSpecialButton.DoOnClick (Sender : TObject);
begin
  if Assigned (FOnClick) then FOnClick (self, index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.GetChange (Sender : TObject);
begin
  FBtn.Glyph := FGlyph;
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDSpecialButton.Create(Collection: TCollection);
begin
  inherited Create (Collection);

  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GetChange;
  FEnabled := false;

  FBtn := TLMDSpeedButton.Create(TLMDDBNavigator(TLMDSpecialButtons(Collection).GetOwner));
  FBtn.Parent := TLMDDBNavigator(TLMDSpecialButtons(Collection).GetOwner);
  FBtn.ShowHint := TLMDDBNavigator(TLMDSpecialButtons(Collection).GetOwner).ShowButtonHints;
  FBtn.Style := TLMDDBNavigator(TLMDSpecialButtons(Collection).GetOwner).ButtonStyle;
  FBtn.OnClick := DoOnClick;
  FBtn.Enabled := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialButton.Destroy;
begin
  FBtn.OnClick := nil;
  FBtn.Free;
  FGlyph.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButton.Assign(Source: TPersistent);
begin
  if Source is TLMDSpecialButton then
    begin
      Caption := (Source as TLMDSpecialButton).Caption;
      Hint := (Source as TLMDSpecialButton).Hint;
      Glyph.Assign ((Source as TLMDSpecialButton).Glyph);
      Enabled := (Source as TLMDSpecialButton).Enabled;
    end
  else
    inherited Assign (Source);
end;
{ ---------------------------------------------------------------------------- }

{ ******************* TLMDSpecialButtons ************************************* }
function TLMDSpecialButtons.GetItem(Index: Integer): TLMDSpecialButton;
begin
  result := TLMDSpecialButton(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButtons.SetItem(Index: Integer; Value: TLMDSpecialButton);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButtons.GetOwner: TPersistent;
begin
  result := FNavigator;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialButtons.Update(Item: TCollectionItem);
begin
//  if Item <> nil then
  FNavigator.UpdateSize;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSpecialButtons.Create(Navigator: TLMDDBNavigator);
begin
  inherited Create(TLMDSpecialButton);
  FNavigator := Navigator;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialButtons.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialButtons.Add: TLMDSpecialButton;
begin
  result := TLMDSpecialButton(inherited Add);
end;

{ *********************** TLMDDBNavigator ************************************ }
{ ------------------------------- private ------------------------------------ }
procedure TLMDDBNavigator.SetBtnHints (aValue : TStrings);
begin
  FBtnHints.Assign (aValue);
  InitButtonHints(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBtnCaptions (aValue : TStrings);
begin
  FBtnCaptions.Assign (aValue);
  InitButtonCaptions(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBtnLayout (aValue : TLMDButtonLayout);
begin
  FBtnLayout.Assign (aValue);
  InitButtonLayouts;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBtnStyle (aValue : TLMDUserButtonStyle);
var
  i : TLMDNavigateBtn;
  j : Integer;
begin
  if aValue <> FBtnStyle then
    begin
      FBtnStyle := aValue;
      for i := Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
        FDisplayButtons[i].Style := FBtnStyle;
      for j := 0 to FCustomButtons.Count - 1 do
        FCustomButtons[j].Btn.Style := FBtnStyle;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetButtons (aValue : TLMDNavButtons);
var
  i : TLMDNavigateBtn;
begin
  if aValue <> FButtons then
    begin
      FButtons := aValue;
      for i := Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
         FDisplayButtons[i].Visible := i in FButtons;
      UpdateSize;

      //Invalidate;
//      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetRepeatingInterval(aValue:Word);
var
  i : TLMDNavigateBtn;
begin
  if aValue <> FRepeatingInterval then
    begin
      FRepeatingInterval:=aValue;
      for i := Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
        if i in LMDCheckRepeatedButtons then
          FDisplayButtons[i].RepeatingInterval := FRepeatingInterval;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetRepeatedClick(aValue:Boolean);
var
  i : TLMDNavigateBtn;
begin
  if aValue <> FRepeatedClick then
    begin
      FRepeatedClick:=aValue;
      for i:=Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
        if i in LMDCheckRepeatedButtons then
          if (i <> nbDelete) or (not FConfirmDelete) then
            FDisplayButtons[i].RepeatedClick := FRepeatedClick;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if (FBookmark <> nil) and (FBookmark.DataSource <> FDataLink.DataSource) and not (csLoading in ComponentState) then
    begin
      ShowMessage ('The DataSource of the Bookmark Container and the Navigator must be identical. Connection will be removed.');
      Bookmark := nil;
    end;
  if not (csLoading in ComponentState) then
    begin
      ActiveChanged;
    end;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetCustomButtons (aValue : TLMDSpecialButtons);
begin
  FCustomButtons.Assign (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetMinBtnSize (index : integer;aValue : Integer);
begin
  case index of
    0 : if aValue <> FMinBtnSize.X then
          begin
            FMinBtnSize.X := aValue;
            GetChange (nil);
          end;
    1 : if aValue <> FMinBtnSize.Y then
          begin
            FMinBtnSize.Y := aValue;
            GetChange (nil);
          end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : if aValue <> FSingleLine then
          begin
            FSingleLine := aValue;
            UpdateSize;
          end;
    1 : if aValue <> FConfirmDelete then
          begin
            FConfirmDelete := aValue;
            FDisplayButtons[nbDelete].RepeatedClick := (not FConfirmDelete) and (FRepeatedClick);
          end;

  end;
end;

{------------------------------------------------------------------------------}
function TLMDDBNavigator.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource
end;

{------------------------------------------------------------------------------}
function TLMDDBNavigator.GetMinBtnSize(Index:Integer):Integer;
begin
  case Index of
    0: result:=FMinBtnSize.X;
    1: result:=FMinBtnSize.Y;
  else
    result:=0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBookmark (aValue : TLMDBookmarkCont);
begin
  if (aValue <> nil) and (aValue.DataSource <> nil) and (FDataLink.DataSource <> nil) and (aValue.DataSource <> FDataLink.DataSource) then
    begin
      FBookmark := nil;
      ActiveChanged;
      ShowMessage ('Navigator and Bookmark container must have the same DataSource!!');
      exit;
    end
  else
    begin
      FBookmark := aValue;
      ActiveChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure  TLMDDBNavigator.SetSet(aValue:TLMDNavGlyphSet);
var
  i : TLMDNavigateBtn;
  FEn, FBBmp:TBitmap;
  aRect:TRect;
begin
  if aValue <> FSet then
    begin
      FSet:=aValue;
      if FSet = ngNone then
        begin
          for i:=Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
             FDisplayButtons[i].Glyph:=nil;
          exit;
        end;
      FEn := TBitmap.Create;
      FBBmp := TBitmap.Create;
      try
        FEn.Handle := LoadBitmap (HInstance, MakeIntResource(IDB_NAVBMP+Ord(FSet)));
        FBBmp.Width := FEn.Width Div LMDNAVBTNS;
        FBBmp.Height := FEn.Height;
        aRect:=Rect(0,0,FBBmp.Width, FBBmp.Height);
        for i:=Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
          begin
            FBBmp.Canvas.CopyRect (aRect, FEn.Canvas, Rect (Ord(i) * aRect.Right, 0, (Ord(i)+1)*aRect.Right, aRect.Bottom));
            FDisplayButtons[i].Glyph:=FBBmp;
            FDisplayButtons[i].NumGlyphs:=Ord(FSet)+1;
          end;
      finally
        FBBmp.Free;
        FEn.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.SetBorders (var aWidth: Integer; var aHeight:  Integer);
var
  aRect : TRect;
  bevExt,
  h,
  row, col,
  xs, ys, j,
  c, x, y : Integer;
  i : TLMDNavigateBtn;
begin
  if [csLoading, csReading]*ComponentState<>[] then exit;
  aRect := Rect (0, 0, aWidth, aHeight);

  if not Assigned (Bevel) then exit;   //creation of parent not finished

  bevExt := Bevel.BevelExtend;
  if Bevel.Mode <> bmWindows then
    InflateRect (aRect, -bevExt, -bevExt);
  c := 0;

  //how many buttons are visible?
  for i := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
    if FDisplayButtons[i].Visible then inc (c);
  //add the user defined buttons
  c := c + FCustomButtons.Count;
  if c = 0 then c := 1;
  //if all btns in a row
  if FSingleLine then
    begin
      col := (aRect.Right - aRect.Left) div c;
      //col is max width of btn
      if col < FMinBtnSize.X then
        begin //col is lower than the minimum btn width
          xs := FMinBtnSize.X;
          col := FMinBtnSize.X * c
        end
      else // if FMinBtnSize.X = -1 then //auto
        begin
          xs := col;
          col := col * c;
        end;
      row := (aRect.Bottom - aRect.Top);
      if row < FMinBtnSize.Y then
        row := FMinBtnSize.Y;
      ys := row;

      //SetBounds (Left, Top, col + Bevel.BevelExtend * 2, row + Bevel.BevelExtend * 2)

      aWidth := col + bevExt * 2;
      aHeight := row + bevExt * 2;

      aRect := Rect (bevExt, bevExt, aWidth - bevExt, aHeight - bevExt);

      //get buttons per row (only one row here)
      //col := (aRect.Right - aRect.Left) div FMinBtnSize.X;
      //row := 0;
    end
  else
    begin
      //get max buttons per line
      h := FMinBtnSize.X; if h = 0 then h := 1; //avoid div by zero

      col := (aRect.Right - aRect.Left) div h;//FMinBtnSize.X; replaced by h June 02
      if col = 0 then col := 1;
      //if there are less btns than we can display in one row
      if c <= col then
        row := 1 //we only need one row
      else //otherwise we need to some more ...
        row := c div col;
      if row * col < c then inc(row);
      //single line display (less btns than we could display in a row)
      if c < col then col := c;
      //SetBounds (Left, Top, col * FMinBtnSize.X + Bevel.BevelExtend * 2, row * FMinBtnSize.Y + Bevel.BevelExtend * 2 + 1);
      aWidth := col * FMinBtnSize.X + bevExt * 2;
      aHeight := row * FMinBtnSize.Y + bevExt * 2 + 1;
      xs := FMinBtnSize.X;
      ys := FMinBtnSize.Y;
    end;
  //now let's set the buttons
  if FSingleLine then
    begin
      x := aRect.Left;// + bevExt;
      y := aRect.Top;// + bevExt;
    end
  else
    begin
      x := aRect.Left;
      y := aRect.Top;
    end;
  for i := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
    if FDisplayButtons[i].Visible then
      begin
        FDisplayButtons[i].SetBounds (X, Y, xs, ys);
        inc (x, xs);
        if x + xs > aRect.Right then
          begin
            x := aRect.Left;
            inc (y, ys);
          end;
      end
    else
      FDisplayButtons[i].SetBounds (0, 0, 0, 0);
  for j := 0 to FCustomButtons.Count - 1 do
    begin
      FCustomButtons[j].Btn.SetBounds (X, Y, xs, ys);
      inc (x, xs);
      if x + xs > aRect.Right then
        begin
          x := aRect.Left;
          inc (y, ys);
        end;
    end
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.DataChanged;
var
  UpEnable, DnEnable : Boolean;
begin
  UpEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DnEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  FDisplayButtons[nbFirst].Enabled := UpEnable;
  FDisplayButtons[nbPrior].Enabled := UpEnable;
  FDisplayButtons[nbNext].Enabled :=  DnEnable;
  FDisplayButtons[nbLast].Enabled :=  DnEnable;
  FDisplayButtons[nbRemoveFilter].Enabled := FDataLink.DataSource.DataSet.Filtered;
  FDisplayButtons[nbDelete].Enabled := Enabled and FDataLink.Active and FDataLink.DataSet.CanModify and
    not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.EditingChanged;
var
  CanModify: Boolean;
begin
  CanModify := Enabled and FDataLink.Active and FDataLink.DataSet.CanModify;
  FDisplayButtons[nbInsert].Enabled := CanModify;
  FDisplayButtons[nbEdit].Enabled := CanModify and not FDataLink.Editing;
  FDisplayButtons[nbPost].Enabled := CanModify and FDataLink.Editing;
  FDisplayButtons[nbCancel].Enabled := CanModify and FDataLink.Editing;
  FDisplayButtons[nbRefresh].Enabled := CanModify;
  FDisplayButtons[nbClear].Enabled := CanModify and FDataLink.Editing;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.ActiveChanged;
var
  i : TLMDNavigateBtn;
begin
  if not (Enabled) or not (FDataLink.Active) then
    for I := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
      if (I <> nbOpen) or (FDataLink.DataSource = nil) then
        FDisplayButtons[i].Enabled := false
      else
        FDisplayButtons[i].Enabled := true
  else
    begin
      FDisplayButtons[nbDeleteBookmark].Enabled := (FBookmark <> nil);
      FDisplayButtons[nbGotoBookmark].Enabled := (FBookmark <> nil);
      FDisplayButtons[nbSetBookmark].Enabled := (FBookmark <> nil);
      FDisplayButtons[nbSearch].Enabled := true;
      FDisplayButtons[nbSetFilter].Enabled := true;
      FDisplayButtons[nbClose].Enabled := true;
      FDisplayButtons[nbOpen].Enabled := false;
      FDisplayButtons[nbFindFirst].Enabled := true;
      FDisplayButtons[nbFindNext].Enabled := true;
      FDisplayButtons[nbFindPrior].Enabled := true;
      FDisplayButtons[nbFindLast].Enabled := true;

      DataChanged;
      EditingChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.InitButtons;
var
  I: TLMDNavigateBtn;
  Btn: TLMDSpeedButton;
  X: Integer;
  FEn,
  FBBmp : TBitmap;
  aRect:TRect;
begin
  X := 0;
  FEn := TBitmap.Create;
  FBBmp := TBitmap.Create;
  try
    FEn.Handle := LoadBitmap (HInstance, MakeIntResource(IDB_NAVBMP+Ord(FSet)));
    FBBmp.Width := FEn.Width Div LMDNAVBTNS;
    FBBmp.Height := FEn.Height;
    aRect:=Rect(0,0,FBBmp.Width, FBBmp.Height);
    for I := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
      begin
        Btn := TLMDSpeedButton.Create (Self);
        Btn.Parent := Self;
        Btn.Tag := Ord(i);
        Btn.Enabled := False;
        Btn.SetBounds (X, 0, FMinBtnSize.X, FMinBtnSize.Y);
        Btn.NumGlyphs:=Ord(FSet)+1;
        FBBmp.Canvas.CopyRect (aRect, FEn.Canvas, Rect (Ord(i) * aRect.Right, 0, (Ord(i)+1)*aRect.Right, aRect.Bottom));
        Btn.Glyph:=FBBmp;
        Btn.Visible := I in FButtons;
        if i in LMDCheckRepeatedButtons then
          if (i <> nbDelete) or (not FConfirmDelete) then
            begin
              Btn.RepeatedClick:=FRepeatedClick;
              Btn.RepeatingInterval:=FRepeatingInterval;
            end;
        Btn.OnClick := DoClick;
        Btn.Style := FBtnStyle;
        FDisplayButtons[I] := Btn;
        X := X + FMinBtnSize.X;
      end;
  finally
    FBBmp.Free;
    FEn.Free;
  end;
  InitButtonHints(self);
  InitButtonCaptions(self);
  InitButtonLayouts;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.InitButtonHints(Sender : TObject);
var
  I: TLMDNavigateBtn;
  c: Integer;
begin
  c := -1;
  for I := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
    begin
      FDisplayButtons[i].ShowHint := FShowBtnHints;
      if FDisplayButtons[i].Visible then
        begin
          inc (c);
          if c < FBtnHints.Count then
            FDisplayButtons[i].Hint := FBtnHints[c];
        end;
    end;
  for c := 0 to FCustomButtons.Count - 1 do
    begin
      FCustomButtons[c].Btn.ShowHint := FShowBtnHints;
      FCustomButtons[c].Btn.HideHint := false;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.InitButtonCaptions(Sender : TObject);
var
  I: TLMDNavigateBtn;
  c: Integer;
begin
  c := -1;
  for I := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
    begin
      if FDisplayButtons[i].Visible then
        begin
          inc(c);
          if c < FBtnCaptions.Count then
            FDisplayButtons[i].Caption := FBtnCaptions[c];
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.InitButtonLayouts;
var
  I: TLMDNavigateBtn;
  j : Integer;
begin
  for I := Low(TLMDNavigateBtn) to High(TLMDNavigateBtn) do
    begin
      FDisplayButtons[i].ButtonLayout.Assign(FBtnLayout);
      FDisplayButtons[i].HideHint:=false;
    end;
  for j := 0 to FCustomButtons.Count -  1 do
    begin
      FCustomButtons[j].Btn.ButtonLayout.Assign (FBtnLayout);
      FCustomButtons[j].Btn.HideHint:=false;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.DoClick (Sender : TObject);
var
  tmp: TLMDNavigateBtn;

  begin
  //RM
  tmp := TLMDNavigateBtn(TComponent(Sender).Tag);
  ClickButton(tmp);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.ClickButton (btn: TLMDNavigateBtn);
begin
  if (FDataLink.DataSource <> nil) then
    begin
      if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then FBeforeAction(Self, btn);
      LMDDBNavAction(self, DataSource.DataSet, btn, FBookMark, FConfirmDelete);
    end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then FOnNavClick(Self, btn);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.WMSize (var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetBorders(W, H);
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDDBNavigator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
  if (Operation=opRemove) and (AComponent=FBookmark) then
    begin
      FBookmark := nil;
      ActiveChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.MouseExit;
begin
  inherited MouseExit;
  if FHideHint then Application.HideHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.Click;
begin
  //RM??
  inherited Click;
  {if (DataSource <> nil) and (DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    with DataSource.DataSet do
    begin
      case FKind of
        nbPrior: Prior;
        nbNext: Next;
        nbFirst: First;
        nbLast: Last;
        nbInsert: Insert;
        nbEdit: Edit;
        nbCancel: Cancel;
        nbPost: Post;
        nbRefresh: Refresh;
        nbDelete: if (not FConfirmDelete) or
            (MessageDlg(SDeleteRecordQuestion, mtConfirmation,
            mbOKCancel, 0) <> idCancel) then Delete;
        nbSetBookmark : if FBookmark <> nil then
                          FBookMark.AddBookmark;
        nbGotoBookMark : if (FBookmark <> nil) then
                           FBookmark.GotoBookmark;
        nbDeleteBookMark : if (FBookmark <> nil) then
                             FBookmark.DeleteBookmark;
      end;
    end;}
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.UpdateSize;
var
  W, H : Integer;
begin
  W := Width;
  H := Height;
  SetBorders(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  UpdateSize;
end;

{------------------------------------------------------------------------------}
function TLMDDBNavigator.GetEmpty : Boolean;
begin
  result := false;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDDBNavigator.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption, csReplicatable];
  FRepeatingInterval:=100;
  FDataLink := TLMDButtonDataLink.Create(self);
  FButtons := [nbFirst, nbLast, nbNext, nbPrior,
               nbEdit, nbInsert, nbPost, nbDelete, nbCancel, nbRefresh];
  FHideHint := false;
  FBtnStyle := ubsWin40;
  FCustomButtons := TLMDSpecialButtons.Create (self);
  FBtnHints := TStringList.Create;
  TStringList(FBtnHints).OnChange := InitButtonHints;
  FBtnCaptions := TStringList.Create;
  TStringList(FBtnCaptions).OnChange := InitButtonCaptions;
  FBtnLayout := TLMDButtonLayout.Create;
  FShowBtnHints := true;
  FSingleLine := false;
  FMinBtnSize := Point(20, 18);
  InitButtons;
  FBookmark := nil;
  //FXP:=false;
  FConfirmDelete := true;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBNavigator.Destroy;
begin
  FBtnLayout.Free;
  FBtnCaptions.Free;
  FBtnHints.Free;
  FCustomButtons.Free;
  FBookmark := nil;
  FDataLink.DataSource := nil;
  FreeAndNil(FDataLink); //JH May 02, changed from FDataLink.Free
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNavigator.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  InitButtonHints(self);
  InitButtonCaptions(self);
  InitButtonLayouts;
  UpdateSize;
  ActiveChanged;
  DoThemeChanged;
  w:=Width; h:=Height;
  SetBorders(w, h);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  w, h : Integer;
begin
  w := AWidth;
  h := AHeight;
  if not HandleAllocated then
    SetBorders (w, h);
  inherited SetBounds (ALeft, ATop, w, h);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBNavigator.BtnClick (Index : TLMDNavigateBtn);
begin
  ClickButton (Index); //line below replaced by JH Feb 2002 (now events will get
                   //fired on using this method!
  //LMDDBNavAction(self, DataSource.DataSet, Index, FBookMark, FConfirmDelete);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBNavigator.DoThemeChanged;
var
  i:Integer;
  j:TLMDNavigateBtn;
begin
  inherited;
  for i:=0 to FCustomButtons.Count-1 do
    FCustomButtons.Items[i].Btn.ThemeMode := FThemeMode;
  for j := Low (TLMDNavigateBtn) to High (TLMDNavigateBtn) do
    FDisplayButtons[j].ThemeMode := FThemeMode;
end;

end.
