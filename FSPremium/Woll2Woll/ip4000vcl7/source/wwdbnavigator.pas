{
///////////////////////////////////////////////////////
//                                                   //
// Component: TwwDBNavigator                         //
//                                                   //
// Copyright © 1998-2001 by Woll2Woll Software            //
// All Rights Reserved                               //
//                                                   //
///////////////////////////////////////////////////////

// Design-Time Usage:
//
// To add buttons, right-click on the TwwDBNavigator and
// click on "Add Button" from the context menu.  This will
// add a TwwNavButton to the TwwDBNavigator, which is
// derived from TSpeedButton.
//
// To add buttons for each of the TwwCustomDialogs on the
// form, (Technically, it uses the Owner of the
// TwwDBNavigator, but if dropped in at design-time,
// this can only be a TCustomForm.) right-click on the
// TwwDBNavigator and click on "Add InfoPower Dialogs" from
// the context menu.
//
// To select an individual button, hold down the space-
// key while clicking on a button.  To reorder a button,
// hold down the space-key and proceed to drag and drop
// it to its new location.
//
// The easiest way to select all the buttons is to right-
// click on the Navigator and choose "Select All Buttons"
// from the context menu. -ksw (6/26/98)
//
// Other notes:
//
// Currently, the Navigator only supports TwwNavButtons and
// decendants.  This is neccessary only for design-time
// reasons. (see TwwNavButton.WndProc)  However, there is
// currently no way to use First Class style buttons in the
// Navigator.  In order to have this feature, either a more
// primitive base class would have to be accepted (TControl),
// or use interfaces (iffy).
//
// -ksw (6/16/98, 6/25/98)
//
// 08/24/98 - Moved IwwNavButtons to wwCollection unit
//            This avoids a bug int the C++ Builder .hpp generator
//
//          - Added usActiveChanged to the if statement in the
//            UpdateState method of TwwNavButton in the nbsRestoreBookmark
//            portion of the case statement.
//
//          - Exception Handler added to the nbsRestoreBookmark portion
//            of the TwwNavButton Click method.
//
// 09/11/98 - Override SetName so components can be renamed
// 09/11/98 - Missing raise before which would not show exception message
// 09/23/98 - Changed behavior of TwwDBNavigator.SetVisibleButtons to include the IP Dialogs
// 10/01/98 - If OnClick assigned, still do default action
// 10/07/98 - Added to support accellerator keys
// 10/13/98 - Added check to see if DataSet is empty for nbsDelete.  -ksw (10/13/98)
// 11/03/98 - Added check on ComponentState to prevent shifting of buttons when their visible property changed
// 12/01/98 - Added check to see if user changed the Enabled property and to exit out if they did.  -ksw (12/1/98)
//  2/17/99 - RSW - formerly append which was not consistent with Delphi's
//  2/19/99 - Nav Buttons will now respect the Navigator's Enabled property.
              In addition, setting the Datasource will no longer overwrite
              the Navigator's Enabled property.  -ksw
//  2/21/99 - Release capture in case it was locked at design time
//  2/25/00 - Make sure mouse is down before creating timer
//  4/13/00 - PYW - Allow enduser to control how the painting here is handled.
//                  This resolves a peculiar bug where a navigator is placed on a
//                  transparent TToolBar which is on a TControlBar that has a Picture.
// 8/1/2000 - PYW - Add handling for abort in button's OnUpdateState event.
// 10/12/2000 - PYW Added Check to see if it is visible or if the Parent is showing and not nil.
//                  This is the same check that is in Buttons.pas.

}
unit wwDBNavigator;

interface

{$i wwIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  wwDialog, DB, Buttons, ExtCtrls, wwCommon, TypInfo, DBCtrls, DBConsts,
  wwIntl, wwSpeedButton, wwCollection, wwclearPanel{, wwclearbuttongroup},
  wwframe;

const
  WW_NAV_DEFAULT_MOVEBY = 10;

  // String Constants used for Exception messages.

  swwControlNotAllowed = 'TwwDBNavigator only accepts controls derived from TwwNavButton';
  swwNoDataSource = 'Error, DataSource not assigned';
  swwParentNotNav = 'Parent of TwwNavButton must be TwwDBNavigator';
  swwParentNotDefined = 'Parent propety of TwwNavButton not defined';
  swwButtonNotInList = 'Button parameter of RetrieveIndex not in Buttons list';
  swwIndexOutOfRange = 'Index of Buttons[] out of range';
  swwOwnerRequired = 'Owner cannot be nil';
  swwBookmarkInvalid = 'Cannot read or set property Bookmark because the Bookmark is invalid.';
  swwConfirmButtonAdd = 'Add a button to %s for %s';
  swwVisibleIndexOutRange = 'Index of VisibleButtons[] out of range';

type
  TwwDBNavigator = class;

  TwwNavDataLink = class(TDataLink)
  private
    FNavigator: TwwDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TwwDBNavigator);
    destructor Destroy; override;
  end;

  TwwNavButtonStyle = (nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert,
    nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage,
    nbsNextPage, nbsSaveBookmark, nbsRestoreBookmark, nbsFilterDialog, nbsRecordViewDialog, nbsLocateDialog, nbsSearchDialog, nbsCustom);
  TwwNavButtonStyles = set of TwwNavButtonStyle;

  TwwNavButtonNavStyleEx = nbsFirst..nbsRestoreBookmark;
  TwwNavButtonNavStyle = nbsFirst..nbsRefresh;
  TwwNavButtonDlgStyle = nbsFilterDialog..nbsSearchDialog;

//  TwwNavButtonNavStylesEx = set of TwwNavButtonNavStyleEx;
  TwwNavButtonNavStylesEx = set of TwwNavButtonStyle;

  TwwUpdateCause = (usDataChanged, usEditingChanged, usActiveChanged, usOther);

  TwwNavButton = class;
  TwwNavButtons = class;

  TwwUpdateStateEvent = procedure(Navigator: TwwDBNavigator; Button: TwwNavButton; Cause: TwwUpdateCause) of object;

  TwwCustomDialogEvent = procedure(Dialog: TwwCustomDialog) of object;

  TwwNavButton = class(TwwSpeedButton, IwwCollectionItem)
  private
    FOnUpdateName: TwwUpdateNameEvent;    // IwwCollectionItem Callback
    FSelectionMethod: TwwSelectionMethod; // IwwCollectionItem Callback

    FNavButtons: TwwNavButtons;
    FTimer: TTimer;

    // Property Storage Variables
    FLineBreak: Boolean;
    FDialog: TwwCustomDialog;
    FStyle: TwwNavButtonStyle;

    FOnRowChanged: TNotifyEvent;
    FOnUpdateState: TwwUpdateStateEvent;
    FOnAfterCreateDialog: TwwCustomDialogEvent;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    // Overridden methods
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;

    // Property access methods
    function GetImageIndex: Integer; override;
    function GetIndex: Integer; virtual;
    function GetNavButtons: TwwNavButtons; virtual;
    function GetNavigator: TwwDBNavigator; virtual;
    procedure SetDialog(Value: TwwCustomDialog); virtual;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetIndex(Value: Integer); virtual;
    procedure SetLineBreak(Value: Boolean); virtual;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParent(Value: TWinControl); override;
    procedure SetStyle(Value: TwwNavButtonStyle); virtual;

    function GetDefaultHint: string; virtual;
    function GetDialog(DataSet: TDataSet): TwwCustomDialog;

    procedure CancelTimer; virtual;
    procedure CreateTimer; virtual;
    procedure TimerEvent(Sender: TObject); virtual;
    procedure UpdateName; virtual;
    procedure UpdateGlyph; virtual;
    procedure UpdateState(Cause: TwwUpdateCause); virtual;

    property NavButtons: TwwNavButtons read GetNavButtons;
  public
    constructor Create(AOwner: TComponent); override;

    // Overrident public methods
    procedure Click; override;

    function IsVisible: Boolean; virtual;
    property Navigator: TwwDBNavigator read GetNavigator;

    // IwwCollectionItem
    function GetCollection: IwwCollection;
    function GetDisplayName: string;
    function GetInstance: TPersistent;
    procedure SetOnUpdateName(Value: TwwUpdateNameEvent);
    procedure SetSelectionMethod(Value: TwwSelectionMethod);
    procedure PaintTransparentBackground; virtual;
  published
    property Dialog: TwwCustomDialog read FDialog write SetDialog;
    property Index: Integer read GetIndex write SetIndex;
    property LineBreak: Boolean read FLineBreak write SetLineBreak default False;
    property Style: TwwNavButtonStyle read FStyle write SetStyle;

    property Visible;

    property OnAfterCreateDialog: TwwCustomDialogEvent read FOnAfterCreateDialog write FOnAfterCreateDialog;
    property OnRowChanged: TNotifyEvent read FOnRowChanged write FOnRowChanged;
    property OnUpdateState: TwwUpdateStateEvent read FOnUpdateState write FOnUpdateState;
  end;

  TwwNavButtons = class(TPersistent, IUnknown, IwwCollection, IwwNavButtons)
  private
    FDesigner: TControl;
    FNavigator: TwwDBNavigator;
    FUpdateLock: Integer;
  protected
    procedure AddButton(const Button: TwwNavButton); virtual;
    procedure RemoveButton(const Button: TwwNavButton); virtual;

    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    function BottommostButton: TwwNavButton; virtual;
    function FindButtonAtPos(IgnoreButton: TwwNavButton; x, y: Integer): TwwNavButton; virtual;
    function IgnoreButton(Button: TwwNavButton): Boolean; virtual;
    function RightmostButton: TwwNavButton; virtual;
    procedure MakeButtonsVisible;
    procedure MakeVisible(AStyle: TwwNavButtonStyle; CanCreate: Boolean); virtual;
    procedure MakeInvisible(AStyle: TwwNavButtoNStyle); virtual;

    // Property access methods
    function GetCount: Integer; virtual;
    function GetItems(Index: Integer): TwwNavButton; virtual;
    function GetNavigator: TwwDBNavigator; virtual;
    function GetVisibleButton(Index: Integer): TwwNavButton; virtual;
    function GetVisibleCount: Integer; virtual;
  public
    constructor Create(ANav: TwwDBNavigator);
    destructor Destroy; override;

    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj):
      {$ifdef wwDelphi4Up}HRESULT{$else}{$ifdef ver110}HRESULT{$else}Integer{$endif}{$endif}; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // IwwCollection
    function IwwCollection.Add = IwwCollection_Add;
    function IwwCollection_Add: IwwCollectionItem;
    function GetItem(Index: Integer): IwwCollectionItem;
    procedure SetDesigner(Value: TControl);

    function Add(AStyle: TwwNavButtonStyle
      {$ifdef wwDelphi4Up} = nbsCustom{$endif}; AComponent: TComponent
      {$ifdef wwDelphi4Up} = nil{$endif}): TwwNavButton; virtual;
    procedure AddInfoPowerDialogs; virtual;
    procedure Clear; virtual;
    procedure CreateDefaultButtons; virtual;
    procedure UpdateButtonsRect; virtual;
    procedure UpdateButtonsPos; virtual;
    procedure UpdateButtonsState(Cause: TwwUpdateCause); virtual;

    property Count: Integer read GetCount;
    property Navigator: TwwDBNavigator read GetNavigator;
    property Items[Index: Integer]: TwwNavButton read GetItems; default;
    property UpdateLock: Integer read FUpdateLock;
    property VisibleButtons[Index: Integer]: TwwNavButton read GetVisibleButton;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  TwwNavOption = (noConfirmDelete, noUseInternationalText);
  TwwNavOptions = set of TwwNavOption;

  TwwNavAutoSizeStyle = (asSizeNavigator, asSizeNavButtons, asNone);

  TwwNavLayout = (nlHorizontal, nlVertical);

  TwwNavRepeatInterval = class(TPersistent)
  private
    FInitialDelay: Integer;
    FRepeatInterval: Integer;
  public
    constructor Create;
  published
    property InitialDelay: Integer read FInitialDelay write FInitialDelay;
    property Interval: Integer read FRepeatInterval write FRepeatInterval;
  end;

  TwwDBNavigator = class(TwwCustomTransparentPanel)
//  TwwDBNavigator = class(TwwCustomTransparentGroupBox)
  private
    FButtons: TwwNavButtons;
    FDataLink: TDataLink;
    FBookmarks: TList;

    // Property Storage Variables
    FAutosizeStyle: TwwNavAutoSizeStyle;
    FDataSource: TDataSource;
    FFlat: Boolean;
    FImageList: TImageList;
    FLayout: TwwNavLayout;
    FMoveBy: Integer;
    FOptions: TwwNavOptions;
    FRepeatInterval: TwwNavRepeatInterval;
    InPaint: boolean;
    FTransparentClearsBackground: boolean;

    // Message handlers
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    {$ifdef wwDelphi4Up}
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    {$endif}
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    // Message handler wrappers
    procedure ControlListChange(const Control: TControl; const Inserting: Boolean); virtual;

    // Overridden methods
    procedure WndProc(var Message: TMessage); override;
    procedure AlignControls(Control: TControl; var Rect: TRect); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;

    // Datalink methods
    procedure DataChanged; virtual;
    procedure EditingChanged; virtual;
    procedure ActiveChanged; virtual;

    // Property Access Methods
    function GetShowHint: Boolean; virtual;
    function GetVisibleButtons: TwwNavButtonNavStylesEx; virtual;
    procedure SetAlignment(Value: TwwNavLayout); virtual;
    procedure SetAutosizeStyle(Value: TwwNavAutosizeStyle); virtual;
    procedure SetDataSource(Value: TDataSource); virtual;
    procedure SetFlat(Value: Boolean); virtual;
    procedure SetImageList(Value: TImageList); virtual;
    procedure SetMoveBy(Value: Integer); virtual;
    {$ifdef wwdelphi4up}
    procedure SetName(const NewName: TComponentName); override; {9/11/98 }
    {$endif}
    procedure SetOptions(Value: TwwNavOptions); virtual;
    procedure SetShowHint(Value: Boolean); virtual;
    procedure SetVisibleButtons(Value: TwwNavButtonNavStylesEx); virtual;

    function CalcBorderWidth: Integer; virtual;
    function CalcWidth: Integer; virtual;
    function GetDataSet(RaiseException: Boolean): TDataSet; virtual;
    function GetBookmark(DataSet: TDataSet; GetNew: Boolean): TBookmark;
    procedure AdjustButtonsSize(Control: TControl);
    procedure FreeBookmark(DataSet: TDataSet);
    procedure UpdateAutosize; virtual;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetDataSourceFromComponent(Component: TComponent; AllowNil: Boolean); virtual;
    property VisibleButtons: TwwNavButtonNavStylesEx read GetVisibleButtons write SetVisibleButtons;
  published
    property AutosizeStyle: TwwNavAutoSizeStyle read FAutosizeStyle write SetAutosizeStyle default asSizeNavigator;
    property Buttons: TwwNavButtons read FButtons stored False;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Flat: Boolean read FFlat write SetFlat default True;
    property ImageList: TImageList read FImageList write SetImageList; { RSW - 7/24/98 - Call SetImageList}
    property Layout: TwwNavLayout read FLayout write SetAlignment default nlHorizontal;
    property MoveBy: Integer read FMoveBy write SetMoveBy default WW_NAV_DEFAULT_MOVEBY;
    property Options: TwwNavOptions read FOptions write SetOptions default [noConfirmDelete];
    property ShowHint: Boolean read GetShowHint write SetShowHint default False;
    property RepeatInterval: TwwNavRepeatInterval read FRepeatInterval write FRepeatInterval;
    property TransparentClearsBackground : boolean read FTransparentClearsBackground write FTransparentClearsBackground default false;

    // Inherited Properties, Events
    {$ifdef wwDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}

    property Align;
    property BevelInner default bvNone;
    property BevelOuter default bvNone;
    property Color;
    property Enabled;
    property Font;
    property ParentShowHint;
    property Visible;
    property Transparent;

    property OnResize;
  end;

// This is a global variable because this is the most
// resource friendly way to utilize the Navigator
// glyphs. -ksw (7/2/98)

var wwNavButtonGlyphs: TImageList;

implementation

uses
  wwFltDlg, wwLocate, wwIDlg,
{$ifdef wwDelphi5Up}
  contnrs,
{$endif}
  wwRcdVw;

{$r wwDBNav.res}

const
  WWNAVBUTTONSTYLES: TwwNavButtonStyles = [nbsFirst,
    nbsPriorPage, nbsPrior, nbsNext, nbsNextPage, nbsLast, nbsInsert, nbsDelete,
    nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsSaveBookmark, nbsRestoreBookmark];

  WWNAVBUTTONDLGSTYLES: TwwNavButtonStyles = [nbsFilterDialog, nbsRecordViewDialog,
    nbsLocateDialog, nbsSearchDialog];

  WWNAVBUTTONMOVESTYLES: TwwNavButtonStyles = [
    nbsFirst, nbsPrior, nbsPriorPage, nbsNext, nbsNextPage,
    nbsLast
  ];

  WWNAVBUTTONSORDER: array[TwwNavButtonStyle] of TwwNavButtonStyle = (
    nbsFirst, nbsPriorPage, nbsPrior, nbsNext, nbsNextPage,
    nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel,
    nbsRefresh, nbsSaveBookmark, nbsRestoreBookmark, nbsFilterDialog,
    nbsRecordViewDialog, nbsLocateDialog, nbsSearchDialog, nbsCustom
  );

{$ifndef wwDelphi5Up}
{function ExtractComponent(Component: TComponent): TComponent;
begin
   result:= Component;
end;
}
{$endif}

function Cond(Condition: Boolean; TrueVal, FalseVal: Variant): Variant;
begin
  if Condition then result := TrueVal else result := FalseVal;
end;

// Given a ClassName (i.e. TwwFilterDialog), return the
// associated Nav Button Style (i.e. nbsFilterDialog)
// Name space convention is critical here.  Both types
// need to be prefixed by 3 characters. -ksw (7/3/98)

function DlgTypeFromClass(ClassName: string): TwwNavButtonDlgStyle;
begin
  result := TwwNavButtonStyle(GetEnumValue(TypeInfo(TwwNavButtonDlgStyle), 'nbs' + Copy(ClassName, 4, Length(ClassName) - 3)));
end;

// The opposite function.  Given a Dialog Type (nbsFilterDialog)
// return the corresponding class (TwwFilterDialog).

function ClassFromDlgType(DlgType: TwwNavButtonDlgStyle): TwwCustomDialogClass;
var s: string;
begin
  s := GetEnumName(TypeInfo(TwwNavButtonDlgStyle), ord(DlgType));
  s := 'Tww' + Copy(s, 4, Length(s) - 3);
  result := TwwCustomDialogClass(FindClass(s));
end;

// Given a component and a DataSource, set that component's
// DataSource property (or SearchTable property in the case
// of the TwwSearchDialog) to the passed DataSource. -ksw (7/3/98)   

procedure SetComponentDataAccess(Component: TComponent; DataSource: TDataSource);
var PropInfo: PPropInfo;
    PropName: string;
    PropVal: TComponent;
begin
  if Component is TwwSearchDialog then
  begin
    PropName := 'SearchTable';
    PropVal := DataSource.DataSet;
  end else begin
    PropName := 'DataSource';
    PropVal := DataSource;
  end;
  PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
    SetOrdProp(Component, PropInfo, LongInt(PropVal));
end;

constructor TwwNavDataLink.Create(ANav: TwwDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
end;

destructor TwwNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TwwNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TwwNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TwwNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

type
  TwwNavBookmark = class(TObject)
  public
    Bookmark: TBookmark;
    DataSet: TDataSet;
    constructor Create(ADataSet: TDataSet; ABookmark: TBookmark);
    destructor Destroy; override;
  end;

constructor TwwNavBookmark.Create(ADataSet: TDataSet; ABookmark: TBookmark);
begin
  inherited Create;
  DataSet := ADataSet;
  Bookmark := ABookmark;
end;

destructor TwwNavBookmark.Destroy;
begin
  DataSet.FreeBookmark(Bookmark);
  inherited Destroy;
end;

constructor TwwNavButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  WindowProc := WndProc;  - Add if we want Delphi 3 support for accel keys; not fully tested - ksw (10/7/98)
  FStyle := nbsFirst;
end;

// If the Dialog referenced by the Dialog property gets
// deleted, update the storage variable. -ksw (6/15/98)

procedure TwwNavButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDialog) then Dialog := nil;
end;

// Workaround Delphi 6 automatically selecting navbutton instead of navigator
procedure TwwDBNavigator.WndProc(var Message: TMessage);
{$ifdef wwDelphi6Up}
var OldVisible: boolean;
   Button: TwwNavButton;
{$endif}
begin
  {$ifdef wwDelphi6Up}
  if (csDesigning in ComponentState) then
  begin
    case Message.Msg of
      WM_LBUTTONDOWN: begin
        if (GetKeyState(VK_SPACE) < 0) then
          inherited
        else begin
           Button := Buttons.FindButtonAtPos(nil,
             LoWord(Message.lParam), HiWord(Message.lParam));
           if Button<>nil then
           begin
             Buttons.BeginUpdate;
             OldVisible:= Button.visible;
             Button.ControlStyle:= Button.ControlStyle + [csNoDesignVisible];
             Button.visible:= false;
             inherited;
             Button.ControlStyle:= Button.ControlStyle - [csNoDesignVisible];
             Button.visible:= OldVisible;
             Buttons.EndUpdate;
//             Invalidate;
             Button.invalidate;
           end
           else inherited;
        end
      end;
      else inherited;
    end; { Case }
  end else
  {$endif}
    inherited;
end;

procedure TwwNavButton.WndProc(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
  begin
    case Message.Msg of
      // If the user right-clicks on the control then
      // this code will select the navigator (instead of
      // having this button be selected) and then pass the
      // message along to the Navigator.  -ksw (6/24/98)
      WM_RBUTTONDOWN: begin
        Navigator.Perform(WM_LBUTTONDOWN, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));
        Navigator.Dispatch(Message);
      end;

      WM_LBUTTONDOWN: begin
        if (GetKeyState(VK_SPACE) < 0) then
          inherited
        else begin
            Navigator.Dispatch(Message);
            Navigator.Perform(Message.Msg, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));
            if GetCapture = Navigator.Handle then ReleaseCapture;
        end
      end;

      // Prevent the default ComponentEditor to occur if
      // the space key isn't pressed down. -ksw (6/24/98)
      WM_LBUTTONDBLCLK:
        if (GetKeyState(VK_SPACE) < 0) then
          inherited
        else begin
          // This line is a tweak that prevents an annoyance
          // in which after double-clicking on the Navigator,
          // clicking again would move attempt to move it, event
          // if you weren't clicking in the navigator.  -ksw (6/24/98)
          Navigator.Perform(WM_LBUTTONDOWN, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));

          // These other two lines need to go together.  If the second line is called
          // without the call to the first, Delphi will exit out rather
          // ungracefully.  If the first one is called without the call to the
          // second one, the double-click isn't processed by Delphi.
          Navigator.Dispatch(Message);
          Navigator.Perform(Message.Msg, Message.wParam, Message.lParam);
        end;
      else inherited;
    end; { Case }
  end else inherited;
end;

procedure TwwNavButton.Loaded;
begin
  inherited;
  SetImageIndex(ImageIndex); // -ksw (7/27/98)  -- Update glyph
  if noUseInternationalText in Navigator.Options then
     Hint := GetDefaultHint;
end;

procedure TwwNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CreateTimer;
  if Navigator.IsTransparent then PaintTransparentBackground;
end;

procedure TwwNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CancelTimer;
  inherited;
  if Navigator.IsTransparent then PaintTransparentBackground;
end;

{ 2/25/00 - Make sure mouse is down before creating timer }
procedure TwwNavButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  // If the mouse leaves while the Timer is 'clicking' the
  // button, the timer stops.  This code turns it back on.
  if (csLButtonDown in ControlState) and
     (GetKeyState(VK_LBUTTON) < 0) then
     CreateTimer
  else
     ControlState:= ControlState - [cslButtonDown];
end;

procedure TwwNavButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;

  if Navigator.IsTransparent then PaintTransparentBackground;
end;

procedure TwwNavButton.PaintTransparentBackground;
//var r: TRect;
//var AControl1, AControl2: TControl;
begin
//exit;
  if Navigator.IsTransparent and Navigator.HandleAllocated then
  begin
      { Clear button background with navigator in case there is no image in the back }
//      AControl1 := Parent.Parent.ControlAtPos(  Point(parent.Left + Left, parent.Top + Top), True);
//      AControl2 := Parent.Parent.ControlAtPos(  Point(parent.Left + Left + Width, parent.Top + Top + Height), True);
{      if ((AControl1=nil) or (Acontrol2=nil)) and (not Transparent) then begin//(wwIsTransparentParent(self)) then begin
          Canvas.Brush.Color:= Navigator.Color;
          Canvas.FillRect(ClientRect);
      end;
}
      wwInvalidateTransparentArea2(self, False, Navigator.TransparentClearsBackground);
      { Draws any image in the background }
//      r:= Rect(parent.left + Left, parent.Top+top,
//           parent.left + left+ Width, parent.top + Top + Height);

      // 4/13/2000 - PYW - Allow enduser to control how the painting here is handled.
      // This resolves a peculiar bug where a navigator is placed on a transparent TToolBar
      // which is on a TControlBar that has a Picture.

//      InvalidateRect(parent.parent.handle, @r, Navigator.TransparentClearsBackground);
//      r:= Rect(r.left + parent.parent.left, r.top + parent.parent.top,
//           r.Right + parent.parent.left, r.bottom + parent.parent.top);
//      InvalidateRect(parent.parent.parent.handle, @r, Navigator.TransparentClearsBackground);

  end;
end;

procedure TwwNavButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (csLButtonDown in ControlState) then CancelTimer;
  if Navigator.IsTransparent and Enabled then PaintTransparentBackground;
end;


// Process the click event.

procedure TwwNavButton.Click;
begin
  inherited Click;

//  if Assigned(OnClick) then Exit; { 10/1/98 - Still perform default action so comment out}
  try
    with Navigator.GetDataSet(True) do case FStyle of
      nbsPrior: Prior;
      nbsNext: Next;
      nbsFirst: First;
      nbsLast: Last;
      nbsInsert: Insert; { 2/17/99 - RSW - formerly append which was not consistent with Delphi's}
      nbsEdit: Edit;
      nbsCancel: Cancel;
      nbsPost: Post;
      nbsRefresh: Refresh;
      nbsDelete: if not (noConfirmDelete in Navigator.Options) or
        (MessageDlg(wwInternational.Navigator.ConfirmDeleteMessage, mtConfirmation,
         mbOKCancel, 0) <> idCancel) then Delete;
      nbsNextpage: MoveBy(Abs(Navigator.MoveBy));
      nbsPriorPage: MoveBy(- Abs(Navigator.MoveBy));
      nbsSaveBookmark: Navigator.GetBookmark(Navigator.GetDataSet(True), True);
      nbsRestoreBookmark:
        try
          GotoBookmark(Navigator.GetBookmark(Navigator.GetDataSet(True), False));
        except
          Navigator.FreeBookmark(Navigator.DataSource.DataSet);
        end;
    else
      if (FStyle in WWNAVBUTTONDLGSTYLES) then GetDialog(Navigator.GetDataSet(True)).Execute;
    end;
  except
    CancelTimer;
    raise; { 9/11/98 - Missing raise before which would not show exception message}
  end;
end;

function TwwNavButton.GetImageIndex: Integer;
begin
  if ImageList = WWNAVBUTTONGLYPHS then result := -1 else
  result := inherited GetImageIndex;
end;

function TwwNavButton.GetIndex: Integer;
var i: Integer;
begin
  for i := 0 to NavButtons.Count - 1 do
    if NavButtons.Items[i] = self then
  begin
    result := i;
    Exit;
  end;
  // Only occurs if Button is not found as a child of the TwwDBNavigator
  raise EInvalidOperation.Create(swwButtonNotInList);
end;

function TwwNavButton.GetNavButtons: TwwNavButtons;
begin
  result := nil;
  if FNavButtons <> nil then result := FNavButtons
  else try
    result := (Parent as TwwDBNavigator).FButtons;
  except
    on E: EAccessViolation do begin
      E.Message := swwParentNotDefined;
      Application.HandleException(E);
      Abort;
    end;
  end;
end;

function TwwNavButton.GetNavigator: TwwDBNavigator;
begin
  result := NavButtons.Navigator;
end;

procedure TwwNavButton.SetDialog(Value: TwwCustomDialog);
begin
  if FDialog <> Value then
  begin
    if (FDialog <> nil) and (FDialog.Owner = self) then FDialog.Free;
    FDialog := Value;
    if FDialog <> nil then Style := DlgTypeFromClass(Value.ClassName);
    UpdateState(usOther);
  end;
end;

procedure TwwNavButton.SetImageIndex(Value: Integer);
begin
  if Value = -1 then UpdateGlyph
  else begin
    ImageList := Navigator.ImageList;
    inherited SetImageIndex(Value);
  end;
end;

procedure TwwNavButton.SetIndex(Value: Integer);
begin
  if Index <> Value then
  begin
    if csLoading in Navigator.ComponentState then Exit;
    Navigator.SetChildOrder(self, Value);
    Navigator.Buttons.UpdateButtonsRect;
  end;
end;

// Property access method for LineBreak property.
// (Incidentally, property name is LineBreak and not
// Break, because when there's a property or variable
// named Break, the compiler favors the property instead of
// the break; statement, which gets annoying.
// Calls the AlignControls method  of the Navigator to
// update the buttons/navigator's position and/or size.
//
// -ksw (6/15/98)

procedure TwwNavButton.SetLineBreak(Value: Boolean);
begin
  if FLineBreak <> Value then
  begin
    FLineBreak := Value;
    if not (csLoading in ComponentState) then
      NavButtons.UpdateButtonsRect;
  end;
end;

procedure TwwNavButton.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if Assigned(FOnUpdateName) then FOnUpdateName(Self as IwwCollectionItem);
end;

procedure TwwNavButton.SetParent(Value: TWinControl);
begin
  inherited SetParent(Value);
  if (Value <> nil) and not (Value is TwwDBNavigator) then
  begin
    MessageDlg(swwParentNotNav, mtError, [mbOK], 0);
    Abort;
  end;
end;

// Property access method for Style property.  However, does
// not check to see if the new value is actually different
// from the old style.  This is so the UpdateGlyph method is
// always called. (i.e. When the Style is the default one (0,
// nbsFirst), the old and new style is not different, but
// UpdateGlyph needs to be called.)  However, because of this,
// the Style property should not be superflously assigned.
//
// -ksw (6/15/98)

procedure TwwNavButton.SetStyle(Value: TwwNavButtonStyle);
begin
  begin
    FStyle := Value;
    if ImageIndex = -1 then UpdateGlyph;
    Hint := GetDefaultHint;
    UpdateState(usOther);
  end;
end;

function wwGetPropNames(Obj: TObject; var APropList: PPropList; var NameList: TStringList): string;
var
  ACount: Integer;
  i: integer;
begin
  NameList := TStringList.Create;
  ACount := GetPropList(TypeInfo(TwwDBNavigatorIntlHints), tkProperties, nil);
  GetMem(APropList, ACount * SizeOf(TPropInfo));
  GetPropList(TypeInfo(TwwDBNavigatorIntlHints), tkProperties, APropList);
  for i := 0 to ACount - 1 do
    NameList.Add(APropList^[i].Name);
end;

// Method used to retrieve the default hint value from
// the TwwIntl component.

function TwwNavButton.GetDefaultHint: string;
var i: integer;
    EnumName: string;
    ANames: TStringList;
    APropList: PPropList;
begin
  result := Hint;
  if (result <> '') and not (noUseInternationalText in Navigator.Options) then Exit;
  EnumName := GetEnumName(TypeInfo(TwwNavButtonStyle), ord(FStyle));
  APropList := nil;
  ANames := nil;

  if FStyle <> nbsCustom then
  begin
    wwGetPropNames(wwInternational.Navigator.Hints, APropList, ANames);
    try
      i := ANames.IndexOf(Copy(EnumName, 4, Length(EnumName) - 3) + 'Hint');
      result := GetStrProp(wwInternational.Navigator.Hints, APropList^[i]);
    finally
      FreeMem(APropList);
      ANames.Free;
    end;
  end;
  if FStyle in [nbsNextPage, nbsPriorPage] then
    result := Format(result, [Navigator.MoveBy]);
end;

function TwwNavButton.GetDialog(DataSet: TDataSet): TwwCustomDialog;
var i: Integer;
    OwnerComponent: TComponent;
begin
  result := nil;
  if not (FStyle in WWNAVBUTTONDLGSTYLES) then Exit;

  if FDialog <> nil then
  begin
    // The user has already assigned a dialog to the Dialog
    // property.  So just use that.
    result := FDialog;
    Exit;
  end;

  if (csDesigning in ComponentState) then Exit;

  // FilterDialogs need to have the owner be the DataSet for
  // filter callback reasons.  The rest of them can have the
  // owner be the Navigator.
  if FStyle = nbsFilterDialog then OwnerComponent := Navigator.DataSource.DataSet
  else OwnerComponent := Navigator;

  for i := 0 to OwnerComponent.ComponentCount - 1 do
    if (OwnerComponent.Components[i] is TwwCustomDialog) and
       ((OwnerComponent.Components[i] as TwwCustomDialog).GetPrimaryDataSet = DataSet) and
       (OwnerComponent.Components[i] is ClassFromDlgType(FStyle)) then
    begin
      // Found a dialog already; return that one and exit;
      result := OwnerComponent.Components[i] as TwwCustomDialog;
      FDialog:= result; { RSW}
      Exit;
    end;

  // The user doesn't have a dialog assigned, and we haven't
  // already created one.  So create a new one.
  result := ClassFromDlgType(FStyle).Create(OwnerComponent);
  FDialog:= result; { RSW}
  SetComponentDataAccess(result, Navigator.DataSource);
  if Assigned(FOnAfterCreateDialog) then FOnAfterCreateDialog(result);
end;

procedure TwwNavButton.CancelTimer;
var ATimer: TTimer;   // Used to be safe; Timers are erratic
begin
  ATimer := FTimer;
  FTimer := nil;
  ATimer.Free;
end;

procedure TwwNavButton.CreateTimer;
begin
  if not (FStyle in WWNAVBUTTONMOVESTYLES) then Exit;
  FTimer := TTimer.Create(self);
  FTimer.Interval := Navigator.RepeatInterval.InitialDelay;
  FTimer.OnTimer := TimerEvent;
end;

procedure TwwNavButton.TimerEvent(Sender: TObject);
begin
  if not (csLButtonDown in ControlState) then CancelTimer;
  if FTimer = nil then Exit;
  FTimer.Interval := Navigator.RepeatInterval.Interval;
  Click;
end;

// Method used to create a unique and useful name for the
// button.  Called by the CreateWnd method so TwwDBNavigator
// name is valid.  Uses GetEnumName from TypInfo to prevent
// case statement or meaningless names. -ksw (6/15/98)

procedure TwwNavButton.UpdateName;
var s, NewName: string;
    i: Integer;
begin
  if (Navigator.Owner = nil) or // Validate Rename is going to require Navigator's Owner
     (Name <> '') or (Navigator.Name = '') then Exit;

  i := 0;
  if FStyle <> nbsCustom then begin
    s := GetEnumName(TypeInfo(TwwNavButtonStyle), ord(FStyle));
    s := Navigator.Name + Copy(s, 4, Length(s) - 3);
  end else s := Navigator.Name + 'Button';

  NewName := s;
  while True do
    try
      Name := NewName;
      Break;
    except
      inc(i);
      NewName := s + InttoStr(i);
    end;
end;

// Method used to keep the Button's glyph current with the
// Button's style.  Called by the SetStyle access method.
// Uses GetEnumName from type TypInfo unit to prevent the
// use of an ugly case statement.  Also uses wwIsClass from
// the wwCommon unit to compare classes to prevent the
// inclusion of the InfoPower dialog units in this unit.
//
// -ksw (6/15/98)

procedure TwwNavButton.UpdateGlyph;
begin
  if (FStyle = nbsCustom) or (csLoading in ComponentState) then Exit;

  ImageIndex := ord(FStyle) * 2;
  NumGlyphs := 2;
  ImageList := wwNavButtonGlyphs;
end;

procedure TwwNavButton.UpdateState(Cause: TwwUpdateCause);
var CurBookmark: TBookmark;
    OldEnabled: Boolean;
    DefaultEnabled: Boolean;
begin
  OldEnabled := Enabled;
  try
  if Assigned(FOnUpdateState) then FOnUpdateState(Navigator, self, Cause);
  except
    exit;          // 8/1/2000 - Add handling for abort in button's OnUpdateState event.
  end;
  if (Cause = usDataChanged) and Assigned(FOnRowChanged) then FOnRowChanged(self);

  if (OldEnabled <> Enabled) or  //  Added check to see if user changed the Enabled property and to exit out if they did.  -ksw (12/1/98)
     (Style = nbsCustom) then Exit; { 7/24/98 - RSW }

  if (Navigator.DataSource = nil) or (Navigator.DataSource.DataSet = nil) then
  begin
    Enabled := False;
    Exit;
  end;

  // Added check of Navigator's Enabled property.  -ksw (2/19/99)
  DefaultEnabled := Navigator.FDataLink.Active and Navigator.Enabled;
  with Navigator.FDataLink do case FStyle of
    nbsPrior, nbsPriorPage, nbsFirst: Enabled := DefaultEnabled and not DataSet.BOF;
    nbsNext, nbsNextPage, nbsLast: Enabled := DefaultEnabled and not DataSet.EOF;
    nbsInsert, nbsRefresh: Enabled := DefaultEnabled and DataSet.CanModify;
    nbsDelete: Enabled := DefaultEnabled and DataSet.CanModify and not (DataSet.BOF and DataSet.EOF); // Added check to see if DataSet is empty for nbsDelete.  -ksw (10/13/98)
    nbsEdit: Enabled := DefaultEnabled and DataSet.CanModify and not Editing;
    nbsCancel, nbsPost: Enabled := DefaultEnabled and DataSet.CanModify and Editing;
    nbsSaveBookmark: Enabled := DefaultEnabled;
    nbsRestoreBookmark:
      if (Cause in [usOther, usDataChanged, usActiveChanged]) then  // Added usActiveChanged -ksw (8/24/98)
      begin
        CurBookmark:= Navigator.GetBookmark(Navigator.GetDataSet(True), False);
        if CurBookmark<>nil then
        begin
          Enabled := DefaultEnabled and DataSet.BookmarkValid(CurBookmark);
        end else Enabled:= False
      end;
  else
    if (FStyle in WWNAVBUTTONDLGSTYLES) then
      Enabled := DefaultEnabled and ((Dialog = nil) or ((Dialog <> nil) and (Dialog.GetPrimaryDataSet <> nil)));
  end;
end;

function TwwNavButton.IsVisible: Boolean;
begin
  result := ((Top + Height) < Navigator.Height) and
            ((Left + Width) < Navigator.Width);
end;

// IwwCollectionItem

function TwwNavButton.GetCollection: IwwCollection;
begin
  result := NavButtons as IwwCollection;
end;

function TwwNavButton.GetDisplayName: string;
begin
  result := Name;
end;

function TwwNavButton.GetInstance: TPersistent;
begin
  result := self;
end;

procedure TwwNavButton.SetOnUpdateName(Value: TwwUpdateNameEvent);
begin
  FOnUpdateName := Value;
end;

procedure TwwNavButton.SetSelectionMethod(Value: TwwSelectionMethod);
begin
  FSelectionMethod := Value;
end;

constructor TwwNavButtons.Create(ANav: TwwDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
end;

destructor TwwNavButtons.Destroy;
begin
  if FDesigner <> nil then FDesigner.Free;
  inherited Destroy;
end;

// IUnknown

function TwwNavButtons.QueryInterface(const IID: TGUID; out Obj):
{$ifdef wwDelphi4Up}HRESULT{$else}{$ifdef ver110}HRESULT{$else}Integer{$endif}{$endif};
const
  E_NOINTERFACE = $80004002;
begin
{$WARNINGS OFF}
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
{$WARNINGS ON}
end;

function TwwNavButtons._AddRef: Integer;
begin
  Result := 1;
end;

function TwwNavButtons._Release: Integer;
begin
  Result := 0;
end;

function TwwNavButtons.GetCount: Integer;
begin
  result := Navigator.ControlCount;
end;

function TwwNavButtons.GetItems(Index: Integer): TwwNavButton;
begin
  if (Index < 0) or (Index >= Count) then
    raise EInvalidOperation.Create(swwIndexOutOfRange);
  result := Navigator.Controls[Index] as TwwNavButton;
end;

// Somewhat useless property in this class, but useful in
// derived classes. -ksw (6/15/98)

function TwwNavButtons.GetNavigator: TwwDBNavigator;
begin
  result := FNavigator;
end;

function TwwNavButtons.GetVisibleCount: Integer;
var i: Integer;
begin
  if csDesigning in Navigator.ComponentState then
  begin
    result := Count;
    Exit;
  end;

  result := 0;
  for i := 0 to Count - 1 do
    if Items[i].Visible then inc(result);
end;

function TwwNavButtons.GetVisibleButton(Index: Integer): TwwNavButton;
var i: Integer;
    Counter: Integer;
begin
  if csDesigning in Navigator.ComponentState then
  begin
    result := Items[Index];
    Exit;
  end;

  result := nil;
  Counter := 0;

  if (Index < 0) or (Index >= VisibleCount) then
    raise EInvalidOperation.Create(swwVisibleIndexOutRange);

  for i := 0 to Count - 1 do
    if Items[i].Visible then
    begin
      if Counter = Index then
      begin
        result := Items[i];
        Exit;
      end;
      inc(Counter);
    end;
end;

// IwwCollection

function TwwNavButtons.IwwCollection_Add: IwwCollectionItem;
begin
  result := Add(nbsCustom, nil) as IwwCollectionItem;
end;

function TwwNavButtons.GetItem(Index: Integer): IwwCollectionItem;
begin
  result := Items[Index] as IwwCollectionItem;
end;

procedure TwwNavButtons.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

// Adds a TwwNavButton to the TwwDBNavigator.  Returns the
// newly created button. -ksw (6/15/98)

function TwwNavButtons.Add(AStyle: TwwNavButtonStyle; AComponent: TComponent): TwwNavButton;
begin
  BeginUpdate;
  result := TwwNavButton.Create(Navigator.Owner);
  result.FNavButtons := self;
  result.Parent := Navigator;
  result.Index := Count - 1;
  result.Style := AStyle;
  result.UpdateState(usOther);
  result.Flat := Navigator.Flat;

  if AStyle in WWNAVBUTTONDLGSTYLES then
    result.Dialog := AComponent as TwwCustomDialog;

  result.Hint := result.GetDefaultHint;

  if csDesigning in Navigator.ComponentState then result.UpdateName;
  result.UpdateState(usOther);
  EndUpdate;

  Navigator.Buttons.UpdateButtonsPos;
  if not result.IsVisible then MakeButtonsVisible;
end;

// Add a button for each of the dialogs that is part of
// the TwwDBNavigator's owner.
//
// Checks for:
// Dialog not already in the Navigator
// If datasource is assigned, and the dialog's datasource
//   is assigned, makes sure that they are equal.
//
// -ksw (6/17/98)

procedure TwwNavButtons.AddInfoPowerDialogs;
var i: TwwNavButtonDlgStyle;
begin
  BeginUpdate;
  for i := Low(TwwNavButtonDlgStyle) to High(TwwNavButtonDlgStyle) do
    Add(i, nil);
  EndUpdate;
  UpdateButtonsRect;
end;

// Clear the list of controls. (Frees allocated memory)
// -ksw (6/15/98)

procedure TwwNavButtons.Clear;
var i: integer;
begin
  for i := Count - 1 downto 0 do Items[i].Free;
end;

procedure TwwNavButtons.MakeButtonsVisible;
begin
  if Navigator.AutosizeStyle = asSizeNavigator then
  begin
    with Items[Count - 1] do
      if Navigator.Layout = nlHorizontal then
        Navigator.Height := Top + Height
      else Navigator.Width := Left + Width;
  end else Navigator.UpdateAutosize;
end;

// Create's the default set of buttons upon Creation of the
// TwwDBNavigator.  Override to provide a different set of
// default buttons. -ksw (6/15/98)

procedure TwwNavButtons.CreateDefaultButtons;
var i: TwwNavButtonStyle;
begin
  BeginUpdate;
  for i := Low(WWNAVBUTTONSORDER) to High(WWNAVBUTTONSORDER) do
    if WWNAVBUTTONSORDER[i] in WWNAVBUTTONSTYLES then Add(WWNAVBUTTONSORDER[i], nil);
  EndUpdate;
end;

procedure TwwNavButtons.UpdateButtonsRect;
begin
  if Navigator.AutosizeStyle = asSizeNavButtons then
  begin
    Navigator.UpdateAutosize;
    UpdateButtonsPos;
  end else begin
    UpdateButtonsPos;
    Navigator.UpdateAutosize;
  end;
end;

// Positions the buttons to the proper position. -ksw (6/15/98)

procedure TwwNavButtons.UpdateButtonsPos;
var i: integer;
    PrevSize: TSize;
    x, y: Integer;
    CurButton, PrevButton: TwwNavButton;
begin
  if (csDestroying in Navigator.ComponentState) or (UpdateLock > 0) then Exit;

  PrevSize.cx := 0; PrevSize.cy := 0;
  x := ord(Navigator.CalcBorderWidth); y := ord(Navigator.CalcBorderWidth);

  BeginUpdate;

  PrevButton := nil;
  if VisibleCount > 0 then PrevButton := VisibleButtons[0];
  for i := 0 to VisibleCount - 1 do
  begin
    CurButton := VisibleButtons[i];
    if IgnoreButton(CurButton) then Continue;

    if Navigator.Layout = nlHorizontal then begin
      if (x + CurButton.Width > Navigator.Width) or CurButton.LineBreak then begin
        inc(y, PrevButton.Height);
        x := ord(Navigator.CalcBorderWidth);
      end;
    end else begin
      if (y + CurButton.Height > Navigator.Height) or CurButton.LineBreak then begin
        inc(x, PrevButton.Width);
        y := ord(Navigator.CalcBorderWidth);
      end;
    end;

    CurButton.SetBounds(x, y, CurButton.Width, CurButton.Height);

    if Navigator.Layout = nlHorizontal then inc(x, CurButton.Width)
    else inc(y, CurButton.Height);
    PrevSize.cx := CurButton.Width;
    PrevSize.cy := CurButton.Height;
    PrevButton := CurButton;
  end;

  EndUpdate;
end;

// One of the three DataLink methods will trigger this
// method.  After which, the button's enabled state will
// reflect the appropriate availability of its action.
// (If Style is nbsFirst, and the DataSet is on the First
// record, the Button sholud appear disabled.) -ksw (6/15/98)

procedure TwwNavButtons.UpdateButtonsState(Cause: TwwUpdateCause);
var i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].UpdateState(Cause);
end;

// The following two methods are here as a convenience
// for derived classes. -ksw (6/15/98)

procedure TwwNavButtons.AddButton(const Button: TwwNavButton);
begin
end;

procedure TwwNavButtons.RemoveButton(const Button: TwwNavButton);
begin
end;

// The following two methods suspend certain actions
// (AlignControls, ...) while FUpdateLock is greater than
// zero.  Not only is this quicker, but in some cases
// (the Add method) it won't work unless these methods
// are used.

procedure TwwNavButtons.BeginUpdate;
begin
  inc(FUpdateLock);
end;

procedure TwwNavButtons.EndUpdate;
begin
  dec(FUpdateLock);
end;

// Method used by AlignControls method for use in reordering
// Buttons via drag-drop. -ksw (6/15/98)

function TwwNavButtons.FindButtonAtPos(IgnoreButton: TwwNavButton; x,
y: Integer): TwwNavButton;
var i: Integer;
    p: TPoint;
    r: TRect;
begin
  result := IgnoreButton;        // Return IgnoreButton by default, unless dropped past end of list (Either below or to the right)
  if Count = 0 then Exit;        // Some references to possibly [-1], so exit out if the count's zero

  p := Point(x, y);
  if p.y < 0 then p.y := 0;      // Adjust y coord if less than zero (meaningless)
  if p.x < 0 then p.x := 0;      // Adjust x coord if less than zero
  for i := 0 to Count - 1 do
  begin
    if self.IgnoreButton(Items[i]) then Continue;
    
    with Items[i] do r := Rect(Left, Top, Left + Width, Top + Height);
    if (Items[i] <> IgnoreButton) and PtInRect(r, p) then
    begin
      result := Items[i];
      Exit;
    end;
  end;
  with Items[Count - 1] do if (p.x > Left + Width) or (p.y > Top + Height) then result := nil;
end;

function TwwNavButtons.IgnoreButton(Button: TwwNavButton): Boolean;
begin
  result := not Button.Visible and not (csDesigning in Navigator.ComponentState);
end;

procedure TwwNavButtons.MakeVisible(AStyle: TwwNavButtonStyle; CanCreate: Boolean);
var i: integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].Style = AStyle then
    begin
      Items[i].Visible := True;
      Exit;
    end;
  with Add(AStyle, nil) do
    Index := ord(AStyle);
end;

procedure TwwNavButtons.MakeInvisible(AStyle: TwwNavButtoNStyle);
var i: integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].Style = AStyle then
      Items[i].Visible := False;
end;

function TwwNavButtons.RightmostButton: TwwNavButton;
var i, MaxRight: Integer;
begin
  result := nil;
  MaxRight := 0;
  for i := 0 to VisibleCount - 1 do with VisibleButtons[i] do
    if (Left + Width) > MaxRight then
    begin
      MaxRight := Left + Width;
      result := VisibleButtons[i];
    end;
end;

function TwwNavButtons.BottommostButton: TwwNavButton;
var i, MaxBottom: Integer;
begin
  result := nil;
  MaxBottom := 0;
  for i := 0 to VisibleCount - 1 do with VisibleButtons[i] do
    if (Top + Height) > MaxBottom then
    begin
      MaxBottom := Top + Height;
      result := VisibleButtons[i];
    end;
end;

constructor TwwNavRepeatInterval.Create;
begin
  FInitialDelay := 500;
  FRepeatInterval := 100;
end;

constructor TwwDBNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls];

  FButtons := TwwNavButtons.Create(self);
  FDataLink := TwwNavDataLink.Create(self);
  FBookmarks := TList.Create;

//  Buttons.CreateDefaultButtons; { RSW }
{  if Buttons.Count > 0 then
  begin
    Height := Buttons[0].Height;
    Width := CalcWidth;
  end; // Moved to CreateWnd}
  Width := 1;

  BevelInner := bvNone;
  BevelOuter := bvNone;
  FMoveBy := WW_NAV_DEFAULT_MOVEBY;
  FOptions := [noConfirmDelete];
  Flat := True;
  FRepeatInterval := TwwNavRepeatInterval.Create;
end;

destructor TwwDBNavigator.Destroy;
var i: Integer;
begin
  FButtons.Free;
  FDataLink.Free;
  FRepeatInterval.Free;
  for i := 0 to FBookmarks.Count - 1 do
    TwwNavBookmark(FBookmarks[i]).Free;
  FBookmarks.Free;
  inherited Destroy;
end;

// This methods get called whenever one of the TwwDBNavigator's
// child controls' Bounds gets adjusted.
//
// Prevents users from manually adjusting the position of
// the buttons (via drag-drop, etc.).  Repositions the
// controls. -ksw (6/15/98)

procedure TwwDBNavigator.AlignControls(Control: TControl; var Rect: TRect);
var Button: TwwNavButton;
begin
  if Buttons.FUpdateLock > 0 then Exit;
  if (Control <> nil) and (csDesigning in ComponentState) then  // Added check on ComponentState to prevent shifting of buttons when their visible property changed -ksw (11/3/98)
  begin
    AdjustButtonsSize(Control);
    Button := Buttons.FindButtonAtPos(Control as TwwNavButton, Control.Left, Control.Top);
    if Control <> Button then
    begin
      if Button = nil then (Control as TwwNavButton).Index := Buttons.Count - 1
      else (Control as TwwNavButton).Index := Button.Index;
    end;
  end;
  Buttons.UpdateButtonsRect;
end;

// Not sure if this is the best place.  But need a create event
// that allows me to access the Name property of the TwwDBNavigator
// after it's been assigned by the IDE.  This allows the creation
// of names such as 'wwDBNavigator1Refresh'.
//
// SetDataSource is there to make sure buttons are disabled
// if DataSource is nil.
//
// -ksw (6/15/98)

procedure TwwDBNavigator.CreateWnd;
var i: Integer;
begin
  // This is here because allthough the Add function normally
  // adds a default name at design time, it doesn't work in the
  // the constructor because the Navigator doesn't have a name
  // yet.  At this point it does.  -ksw (6/24/98)

(*  if FButtons.Count = 0 then
  begin
     Buttons.CreateDefaultButtons; { RSW }
     if Buttons.Count > 0 then  // Moved here so Navigator sizing is correct. -ksw (7/31/98)
     begin
       Height := Buttons[0].Height;
       Width := CalcWidth;
     end
  end;
*)
//  Parent.Update;

  if csDesigning in ComponentState then
    for i := 0 to Buttons.Count - 1 do
      Buttons[i].UpdateName;

  SetDataSource(FDataSource);
  Buttons.UpdateButtonsPos;
  UpdateAutosize;
  inherited CreateWnd;

//  SetWindowLong(Handle, GWL_STYLE,
//      GetWindowLong(Handle, GWL_STYLE) and not WS_CLIPCHILDREN)

end;

procedure TwwDBNavigator.Loaded;
begin
  inherited Loaded;
    SetFlat(FFlat);
  SetImageList(FImageList);
end;

// Remove the DataSource reference if that Component gets
// deleted. -ksw (6/15/98)

procedure TwwDBNavigator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDataSource) then FDataSource := nil;
  if (Operation = opRemove) and (AComponent is TDataSet) then
    FreeBookmark(AComponent as TDataSet);
  if (Operation = opRemove) and (AComponent = FImageList) then
    FImageList := nil;
end;

// Wipe out the default created buttons if this TwwDBNavigator
// is being loaded from the stream.  This will replace the
// default buttons with the streamed buttons. -ksw (6/15/98)

procedure TwwDBNavigator.ReadState(Reader: TReader);
begin
//  FButtons.Clear; { RSW }f
  inherited ReadState(Reader);
end;

procedure TwwDBNavigator.CMEnabledChanged(var Message: TMessage);
var i: integer;
begin
  inherited;
  for i := 0 to Buttons.Count - 1 do Buttons[i].Enabled := Enabled;
  if Enabled then Buttons.UpdateButtonsState(usOther);
end;

// Wrap the CM_CONTROLCHANGE message.  This message happens after
// a control gets added or removed from the Navigator.
// CM_CONTROLLISTCHANGE occurs before it gets added ore removed. -ksw (7/20/98)

procedure TwwDBNavigator.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  if Buttons.FDesigner <> nil then Buttons.FDesigner.Update;
end;

// Wrap the CM_CONTROLLISTCHANGE message and pass it on to a
// virtual method so derived classes can use it. -ksw (6/15/98)

procedure TwwDBNavigator.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
  ControlListChange(Message.Control, Message.Inserting);
end;

// This method occurs whenever Controls get added or removed
// from the TwwDBNavigator. (Conrols[i] gets manimpulated)
//
// If a user attempts to add a component that is not derived
// from a TSpeedButton onto the Navigator, an error message
// appears and prevents the insertion.
//
// Calls the methods AddButton RemoveButton (does nothing in
// this class)
//
// -ksw (6/15/98)

procedure TwwDBNavigator.ControlListChange(const Control: TControl; 
  const Inserting: Boolean);
begin
  inherited;
  if not (Control is TwwNavButton) and Inserting then
    raise EInvalidOperation.Create(swwControlNotAllowed);
  if Inserting then Buttons.AddButton(Control as TwwNavButton)
  else Buttons.RemoveButton(Control as TwwNavButton);
end;

// Added to support accellerator keys -ksw (10/7/98)

{$ifdef wwDelphi4Up}

procedure TwwDBNavigator.CMDialogChar(var Message: TCMDialogChar);
var i: Integer;
begin
  inherited;
  for i := 0 to Buttons.Count - 1 do
    if IsAccel(Message.CharCode, Buttons[i].Caption) then
    begin // Added the enabled check -ksw (10/8/98)
          // Added Check to see if it is visible or if the Parent is showing and not nil.
          // This is the same check that is in Buttons.Pas.   -pyw (10/12/2000)
      if (Buttons[i].Enabled) and (Buttons[i].Visible) then
         if (Parent <> nil) and Parent.Showing then begin
            Buttons[i].Click; // Added the enabled check -ksw (10/8/98)
            Message.Result := 1;
            Break;
         end;
    end;
end;

{$endif}

procedure TwwDBNavigator.AdjustButtonsSize(Control: TControl);
var i: Integer;
begin
  for i := 0 to Buttons.Count - 1 do
    if FLayout = nlHorizontal then
      Buttons[i].Height := Control.Height
    else
      Buttons[i].Width := Control.Width;
end;

procedure TwwDBNavigator.UpdateAutosize;
var x, y, i, j: Integer;
    RemainX, RemainBtnX, RemainY, RemainBtnY: Integer;
    b: Boolean;
    NumLineBreaks, LastLineBreak, NumButtons: Integer;
    NavWidth, NavHeight: Integer;
begin
  if (FAutosizeStyle = asNone) or (Buttons.VisibleCount = 0) then Exit;

  b := Layout = nlHorizontal;
  case FAutosizeStyle of
    asSizeNavButtons: begin
      // Get the number of buttons that have the LineBreak property set
      NumLineBreaks := 0;
      for i := 0 to Buttons.VisibleCount - 1 do if Buttons.VisibleButtons[i].LineBreak then inc(NumLineBreaks);

      NavWidth := Width - (2 * ord(CalcBorderWidth));
      NavHeight := Height - (2 * ord(CalcBorderWidth));

      LastLineBreak := 0;
      RemainY := Cond(b, NavHeight, NavWidth) mod (NumLineBreaks + 1);
      RemainBtnY := wwMin((RemainY div (NumLineBreaks + 1)) + 1, RemainY);
      for i := 0 to Buttons.VisibleCount - 1 do
      begin
        if Buttons.VisibleButtons[i].LineBreak or (i = Buttons.VisibleCount - 1) then
        begin
          NumButtons := (i - LastLineBreak) + ord(not Buttons.VisibleButtons[i].LineBreak);
          if NumButtons > 0 then
          begin
            // Get the difference between (ButtonCount * ButtonSize) and Navigator width
            RemainX := Cond(b, NavWidth, NavHeight) mod NumButtons;
            // Get the amount to add to each button (Add at least one unless it's a perfect fit
            RemainBtnX := wwMin((RemainX div NumButtons) + 1, RemainX);
            for j := LastLineBreak to i do
            begin
              if b then begin
                Buttons.VisibleButtons[j].Width := NavWidth div NumButtons + RemainBtnX;
                Buttons.VisibleButtons[j].Height := NavHeight div (NumLineBreaks + 1) + RemainBtnY;
              end else begin
                Buttons.VisibleButtons[j].Width := NavWidth div (NumLineBreaks + 1) + RemainBtnY;
                Buttons.VisibleButtons[j].Height := NavHeight div NumButtons + RemainBtnX;
              end;
              dec(RemainX, RemainBtnX);
              if RemainBtnX > RemainX then RemainBtnX := RemainX;
            end;
            dec(RemainY, RemainBtnY);
            if RemainBtnY > RemainY then RemainBtnY := RemainY;
            LastLineBreak := i;
          end;
        end;
      end;
    end;
    asSizeNavigator: begin
      with Buttons.RightmostButton do x := Left + Width + ord(CalcBorderWidth);
      with Buttons.BottommostButton do y := Top + Height + ord(CalcBorderWidth);
      self.SetBounds(self.Left, self.Top, x, y);
    end;
  end;
end;

// The following method will change the Navigator's DataSource
// to that of the passed Component if the component publishes a
// DataSource property.

procedure TwwDBNavigator.SetDataSourceFromComponent(Component: TComponent; AllowNil: Boolean);
var ADataSource: TDataSource;
begin
  if Component = nil then Exit;
  ADataSource := wwGetControlDataSource(Component);
  if (ADataSource <> nil) or (AllowNil) then DataSource := ADataSource;
end;

function TwwDBNavigator.CalcBorderWidth: Integer;
begin
  result := ord(BevelInner <> bvNone) + ord(BevelOuter <> bvNone);
end;

function TwwDBNavigator.CalcWidth: Integer;
var i: Integer;
begin
  result := 0;
  for i := 0 to Buttons.Count - 1 do if not Buttons.IgnoreButton(Buttons[i]) then
    inc(result, Buttons[i].Width);
end;

function TwwDBNavigator.GetDataSet(RaiseException: Boolean): TDataSet;
begin
  result := nil;
  if DataSource = nil then
  begin
    if RaiseException then raise EInvalidOperation.Create(swwNoDataSource)
    else Exit;
  end;
  if DataSource.DataSet = nil then
  begin
    if RaiseException then raise EInvalidOperation.Create(sDataSetMissing)
    else Exit;
  end;
  result := DataSource.DataSet;
end;

function TwwDBNavigator.GetBookmark(DataSet: TDataSet; GetNew: Boolean): TBookmark;
var i: Integer;
begin
  result := nil;
  if DataSet = nil then Exit;
  for i := FBookmarks.Count - 1 downto 0 do
    if TwwNavBookmark(FBookmarks[i]).DataSet = DataSet then
    begin
      if GetNew then
      begin
        DataSet.FreeBookmark(TwwNavBookmark(FBookmarks[i]).Bookmark);
        TwwNavBookmark(FBookmarks[i]).Bookmark := DataSet.GetBookmark;
        Buttons.UpdateButtonsState(usOther);
      end;
      result := TwwNavBookmark(FBookmarks[i]).Bookmark;

      if (result=nil) or (not DataSet.BookmarkValid(result)) then
      begin
//        TwwNavBookmark(FBookmarks[i]).Free;
//        FBookmarks.Delete(i);
        result:=nil;
        Continue;
      end;

      Exit;
    end;
  if GetNew then
  begin
    // If a bookmark for this dataset isn't in the list, then
    // get a new one.
    result := DataSet.GetBookmark;
    DataSet.FreeNotification(self);
    FBookmarks.Add(TwwNavBookmark.Create(DataSet, result));
    Buttons.UpdateButtonsState(usOther);
  end;
end;

procedure TwwDBNavigator.FreeBookmark(DataSet: TDataSet);
var i: Integer;
begin
  for i := FBookmarks.Count - 1 downto 0 do
    if TwwNavBookmark(FBookmarks[i]).DataSet = DataSet then
    begin
      TwwNavBookmark(FBookmarks[i]).Free;
      FBookmarks.Delete(i);
    end;
end;

procedure TwwDBNavigator.DataChanged;
begin
  Buttons.UpdateButtonsState(usDataChanged);
end;

procedure TwwDBNavigator.EditingChanged;
begin
  Buttons.UpdateButtonsState(usEditingChanged);
end;

procedure TwwDBNavigator.ActiveChanged;
begin
  { RSW - Clear old bookmarks for dataset when dataset closes
    (i.e may change to different table) }
  if (datasource<>nil) and (datasource.dataset<>nil) and
     not (datasource.dataset.active) then
  begin
     FreeBookmark(Datasource.dataset);
  end;

  Buttons.UpdateButtonsState(usActiveChanged);
end;

function TwwDBNavigator.GetShowHint: Boolean;
begin
  result := inherited ShowHint;
end;

function TwwDBNavigator.GetVisibleButtons: TwwNavButtonNavStylesEx;
var i: Integer;
begin
  result := [];
  for i := 0 to Buttons.Count - 1 do
    if Buttons[i].Style in WWNAVBUTTONSTYLES then
      Include(result, Buttons[i].Style);
end;

procedure TwwDBNavigator.SetAlignment(Value: TwwNavLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Buttons.UpdateButtonsRect;
  end;
end;

procedure TwwDBNavigator.SetAutosizeStyle(Value: TwwNavAutosizeStyle);
begin
  if FAutosizeStyle <> Value then
  begin
    FAutosizeStyle := Value;
    Buttons.UpdateButtonsRect;
  end;
end;

procedure TwwDBNavigator.SetDataSource(Value: TDataSource);
begin
  if Value <> nil then Value.FreeNotification(self);
  FDataSource := Value;
  FDataLink.DataSource := FDataSource;
//  Enabled := FDataSource <> nil;
  Buttons.UpdateButtonsState(usOther);
end;

procedure TwwDBNavigator.SetFlat(Value: Boolean);
var i: Integer;
begin
  FFlat := Value;
  for i := 0 to Buttons.Count - 1 do Buttons[i].Flat := FFlat;
end;

procedure TwwDBNavigator.SetImageList(Value: TImageList);
var i: Integer;
begin
  FImageList := Value;
  if FImageList <> nil then
    FImageList.FreeNotification(self);
  for i := 0 to Buttons.Count - 1 do if Buttons[i].ImageIndex > -1 then
    Buttons[i].ImageList := FImageList;
end;

procedure TwwDBNavigator.SetMoveBy(Value: Integer);
var i: Integer;
begin
  if FMoveBy <> Value then
  begin
    FMoveBy := Value;
    for i := 0 to Buttons.Count - 1 do
      if Buttons[i].Style in [nbsNextPage, nbsPriorPage] then
        Buttons[i].Hint := Format(Buttons[i].Hint, [Value]);
  end;
end;

{$ifdef wwdelphi4up}
procedure TwwDBNavigator.SetName(const NewName: TComponentName);
var OldName: string;
    i: Integer;
begin
  OldName := Name;
  inherited;
  for i := 0 to Buttons.Count - 1 do
    if Copy(Buttons[i].Name, 1, Length(OldName)) = OldName then
      Buttons[i].Name := NewName + Copy(Buttons[i].Name, Length(OldName) + 1, Length(Buttons[i].Name) - Length(OldName) + 1);
end;
{$endif}

procedure TwwDBNavigator.SetOptions(Value: TwwNavOptions);
var ChangedOptions: TwwNavOptions;
begin
  if FOptions <> Value then
  begin
    ChangedOptions := (FOptions - Value) + (Value - FOptions);
    FOptions := Value;
  end;
end;

procedure TwwDBNavigator.SetShowHint(Value: Boolean);
var i: integer;
begin
  inherited ShowHint := Value;
  for i := 0 to Buttons.Count - 1 do Buttons[i].ShowHint := Value;
end;

procedure TwwDBNavigator.SetVisibleButtons(Value: TwwNavButtonNavStylesEx);
var i: TwwNavButtonStyle;
begin
  if not (csLoading in ComponentState) and (Buttons.Count = 0) then
    Buttons.CreateDefaultButtons;
//  for i := Low(TwwNavButtonNavStyleEx) to High(TwwNavButtonNavStyleEx) do
  for i := Low(TwwNavButtonStyle) to High(TwwNavButtonStyle) do      // Added this line for compatibility with all
                                                                     // the dialogs for RecordView compatibility  - 9/23/98
    if i in Value then Buttons.MakeVisible(i, True)
    else Buttons.MakeInvisible(i);
end;

procedure DoInitialize;
  function GetImageResName(AStyle: TwwNavButtonStyle): string;
  var s: string;
  begin
    result := '';
    if AStyle <> nbsCustom then
    begin
      s := GetEnumName(TypeInfo(TwwNavButtonStyle), ord(AStyle));
      result := 'WW_DBN_' + UpperCase(Copy(s, 4, Length(s) - 3));
    end;
  end;
var i: TwwNavButtonStyle;
    ABitmap: TBitmap;
begin
  wwNavButtonGlyphs := TImageList.Create(nil);  // Important! Owner must be nil. -ksw (6/29/98)
  wwNavButtonGlyphs.Width := 18;
  wwNavButtonGlyphs.Height := 18;
  for i := Low(TwwNavButtonStyle) to High(TwwNavButtonStyle) do
  begin
    if i = nbsCustom then Continue;
    ABitmap := TBitmap.Create;
    ABitmap.LoadFromResourceName(HINSTANCE, GetImageResName(i) + '_ENABLED');
    wwNavButtonGlyphs.AddMasked(ABitmap, ABitmap.TransparentColor);
    ABitmap.LoadFromResourceName(HINSTANCE, GetImageResName(i) + '_DISABLED');
    wwNavButtonGlyphs.AddMasked(ABitmap, ABitmap.TransparentColor);
    ABitmap.Free;
  end;
end;

procedure DoFinalize;
begin
  wwNavButtonGlyphs.Free;
end;

procedure TwwDBNavigator.WMPaint(var Message: TWMPaint);
begin
  if InPaint then exit;

  if FButtons.Count = 0 then
  begin
     InPaint:= True;
     try
       Buttons.CreateDefaultButtons; { RSW }
       if (Width = 1) and (Buttons.Count > 0) then  // Moved here so Navigator sizing is correct. -ksw (7/31/98)
       begin
         Height := Buttons[0].Height;
         Width := CalcWidth;
         Parent.update; { 9/18/98 - Complete painting of container before painting navigator}
       end else if Buttons.Count > 0 then Buttons.UpdateButtonsRect;
     finally
       InPaint:= False;
     end;
  end;
  inherited;
end;

initialization
  RegisterClasses([TwwNavButton, TwwFilterDialog, TwwLocateDialog,
    TwwRecordViewDialog, TwwSearchDialog]);
  DoInitialize;
finalization
  DoFinalize;
end.
