unit ElMenuBar;
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

ElMenuBar unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Controls,
  Messages,
  Buttons,
  Graphics,
  Classes,
  Forms,
  Windows,
  Menus,
  SysUtils,
  Types,
  ToolWin,

  LMDTypes,
  LMDSysIn,
  LMDGraph,
  LMDClass,
  ElHook,
  ElShadowWindow,
  ElToolbar,
  ElPopBtn,
  ElMenus,
  ElVCLUtils;

const
  EL_ACTIVATEMENU = WM_USER + 692;
  EL_SHORTCUT     = WM_USER + 693;
  EL_CANCELMENU   = WM_USER + 694;
  EL_REFOCUSBUTTON= WM_USER + 695;
  EL_SHOWMENU     = WM_USER + 696;

type
  TElMenuBarButton = class(TCustomElToolButton)
  private
    FMenuItem: TElMenuItem;
    FMouseMenu: boolean;
    FOnDrawItem: TMenuDrawItemEvent;
    FShadow: TElShadow;
    FOnAdvancedDrawItem: TAdvancedMenuDrawItemEvent;
  protected
    procedure DoPullMenu; override;
    function Focused: Boolean; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure Paint; override;
    function MeasureButton(LockHeight : boolean): TPoint; override;
    procedure DoClick; override;
    procedure WndProc(var Message : TMessage); override;
    procedure CopyFromMenuItem(Item : TElMenuItem);
    procedure MasterChange(Sender : TObject; MenuItem : TElMenuItem; Rebuild: boolean);
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property ParentFont;
  end;

  TElSystemButton = class (TElPopupButton)
  private
    FButtonType: Cardinal;
  protected
    procedure Paint; override;
  public
    property ButtonType: Cardinal read FButtonType write FButtonType;
  end;

  TElMenuBar = class(TCustomElToolbar)
  protected
    FFocusedButton: TElMenuBarButton;
    FHook         : TElHook;
    FInMenu       : boolean;
    FDroppedDown  : boolean;
    FInitSelect   : boolean;
    FMenu: TElMainMenu;
    IgnoreAltDn,
    IgnoreAltUp   : boolean;
    OldFocus      : HWND;
    FLastMousePos : TPoint;
    FIntMenu      : TElPopupMenu;
    FChFocusButton: boolean;
    FSysButton: TElPopupButton;
    FSysMinButton,
    FSysCloseButton,
    FSysRestoreButton: TElSystemButton;
    FActiveMDIForm: HWND;
    FSysMenu: HMENU;
    procedure PullDownMenuDropDown(Sender: TObject);
    procedure OnSystemMDIButtonClick(Sender: TObject);
    procedure CheckChildWindowChanging(AHandle: HWND; ACommand: Word);
    procedure ShowMDIButtons(AHandle: HWND);
    procedure HideMDIButtons();
    procedure AlignSysMDIButtons();

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure SetRightToLeft(Value: Boolean);override;
    procedure CancelMenu(ManualCancel : boolean);
    procedure CMMenuChanged(var Message: TMessage); message CM_MENUCHANGED;
    function GetButtonClass: TElToolButtonClass; override;
    procedure GetFont;
    procedure Loaded; override;
    procedure MouseOut; override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    procedure OnBeforeHook(Sender : TObject; var Message : TMessage; var Handled :
        boolean);
    procedure OnAfterHook(Sender : TObject; var Message : TMessage; var Handled :
        boolean);
    procedure PopupMenuPopup(Sender : TObject);
    procedure RebuildMenuBar;
    procedure SetFocusedButton(Value: TElMenuBarButton);
    procedure SetMenu(Value: TElMainMenu);
    procedure SetParent(AParent: TWinControl); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure ElActivateMenu(var Message: TMessage); message EL_ACTIVATEMENU;
    procedure PopupMenuEndPopup(Sender : TObject; ManualCancel : boolean);
    procedure PopupMenuNavigateKey(Sender : TObject; Key : Word);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure SetOrientation(newValue : TElBarOrientation); override;
    procedure ELShortcut(var Message: TMessage); message EL_SHORTCUT;
    procedure ELCancelMenu(var Message: TMessage); message EL_CANCELMENU;
    procedure CopyMenuProperties;
    procedure MasterChange(Sender : TObject; MenuItem : TElMenuItem; Rebuild :
        boolean);
    procedure ELRefocusButton(var Message: TMessage); message EL_REFOCUSBUTTON;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    property FocusedButton: TElMenuBarButton read FFocusedButton write
        SetFocusedButton;
    procedure DoThemeChanged; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure PopupWndProc(var Message : TMessage);
    procedure RequestAlign; override;
    published
    property ParentFont;
    property TabOrder;
    property Font;
    property BorderSides;
    property BorderColorDkShadow;
    property BorderColorFace;
    property BorderColorShadow;
    property BorderColorHighlight;
    property BorderColorWindow;
    property BorderType;
    property AlphaLevel;
    property AlwaysPaintBackground;
    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property OwnerDraw;
    property ImageForm;
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Enabled;
    property MouseCapture default False;
    property ParentColor;
    property ParentCtl3D;
    property ShowHint;
    property Visible;
    property OnResize;
    property ParentShowHint;
    property Resizable;
    property Movable;
    property OnMove;
    property OnPaint;

    property SizeGrip;
    property Align nodefault;
    property BevelSpaceColor;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property BevelInner  default bvNone;
    property BevelOuter  default bvNone;
    property BtnOffsHorz default 1;
    property BtnOffsVert default 1;
    property GlyphLayout default blGlyphLeft;
    property Menu: TElMainMenu read FMenu write SetMenu;
    property MinSize nodefault;
    property ShowCaption default true;
    property RightToLeft;
    property BtnWidth;
    property BtnHeight;
    property AutoWrap;
    property ShowGlyph;
    property LargeSize;
    property LargeBtnWidth;
    property LargeBtnHeight;
    property Spacing;
    property Margin;
    property Flat;
    property AutoSize;
    property ButtonColor;
    property ButtonImageForm;
    property Orientation;

    property UseLargeGlyphs;
    property Images;
    property HotImages;
    property DisabledImages;
    property DownImages;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property UseImageList;
    property TransparentButtons;
    property ThinButtons;
    property Storage;
    property StoragePath;
    property AdjustButtonWidth;
    property AdjustButtonHeight;

    property ShowBorder;
    property ShowMoreMenu;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
  end;

  TLMDWndHoolHelper = class
  private
    FMenusList: TList;
    function GetItem(AIndex: Integer): TElMenuBar;
    function GetCount(): Integer;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Subscribe(AnElMenuBar: TElMenuBar);
    procedure Unsubsribe(AnElMenuBar: TElMenuBar);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TElMenuBar read GetItem;
  end;

procedure CopyElMenuItems(Dest: TElMenuItem; Source: TElMenuItem; MenuItemClass:
  TElMenuItemClass);

function HookProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT stdcall;

implementation

uses
  Themes, LMDThemes;

var
  FWndHook: HHOOK;
  LMDWndHoolHelper: TLMDWndHoolHelper;
type

  THackForm = class(TCustomForm)
    property FormStyle;
  end;
  THackItem = class(TElMenuItem);

  TCustomElToolButtonProtected = class(TCustomElToolButton);
  TElMenuBarItem = class(TElMenuItem)
  protected
    FLinkCommand: Integer;
    procedure MasterChange(Sender : TObject; MenuItem : TElMenuItem; Rebuild : boolean);
  public
    // function GetParentMenu: TElMenu; override;
  end;

  TElPopupMenuBar = class(TElPopupMenu)
  public
    function FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem; override; //??? not usage
  end;

//function InPopupMenu : Boolean;
//begin
//  Result := (ActinePopupWindow<>nil); //and (ActinePopupWindow.SelectedItem>=0)
//      or (ActinePopupWindow.Menu[ActinePopupWindow.SelectedItem].Count=0) then
//end;

procedure TElSystemButton.Paint;
var
  LButtonStyle: TThemedWindow;
  LType, LState: UINT;
  R: TRect;
begin
  inherited Paint();

  R := Rect(0, 0, Width, Height);
  if UseThemeMode <> ttmNone then
  begin

    LButtonStyle := twMDISysButtonNormal;
    case FButtonType of
      SC_CLOSE:
        LButtonStyle := twMDICloseButtonNormal;
      SC_RESTORE:
        LButtonStyle := twMDIRestoreButtonNormal;
      SC_MINIMIZE:
        LButtonStyle := twMDIMinButtonNormal;
    end;
    if FMouseInControl or FMouseInArrow then
      case FButtonType of
        SC_CLOSE:
          LButtonStyle := twMDICloseButtonHot;
        SC_RESTORE:
          LButtonStyle := twMDIRestoreButtonHot;
        SC_MINIMIZE:
          LButtonStyle := twMDIMinButtonHot;
      end;

     if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
      case FButtonType of
        SC_CLOSE:
          LButtonStyle := twMDICloseButtonPushed;
        SC_RESTORE:
          LButtonStyle := twMDIRestoreButtonPushed;
        SC_MINIMIZE:
          LButtonStyle := twMDIMinButtonPushed;
      end;
      LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, LButtonStyle, R);
    end
    else
    begin
      LType := DFC_CAPTION;
      LState := 0;
      case FButtonType of
        SC_CLOSE:
          LState := DFCS_CAPTIONCLOSE;
        SC_RESTORE:
          LState := DFCS_CAPTIONRESTORE;
        SC_MINIMIZE:
          LState := DFCS_CAPTIONMIN;
      end;
    if FMouseInControl or FMouseInArrow then
        LState := LState or DFCS_HOT;

       if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
        LState := LState or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, R, LType, LState);
    end;

end;

constructor TLMDWndHoolHelper.Create();
begin
  FMenusList := TList.Create;
end;

destructor TLMDWndHoolHelper.Destroy();
begin
  FMenusList.Clear;
  FreeAndNil(FMenusList);
end;

procedure TLMDWndHoolHelper.Subscribe(AnElMenuBar: TElMenuBar);
begin
  if FMenusList.IndexOf(AnElMenuBar) = -1 then
    FMenusList.Add(AnElMenuBar)
end;

procedure TLMDWndHoolHelper.Unsubsribe(AnElMenuBar: TElMenuBar);
var
  LIdx: Integer;
begin
  LIdx := FMenusList.IndexOf(AnElMenuBar);
  if LIdx > -1 then
    FMenusList.Delete(LIdx);
end;

function TLMDWndHoolHelper.GetItem(AIndex: Integer): TElMenuBar;
begin
  Result := TElMenuBar(FMenusList.Items[AIndex]);
end;

function TLMDWndHoolHelper.GetCount(): Integer;
begin
  Result := FMenusList.Count;
end;

procedure CopyElMenuItems(Dest: TElMenuItem; Source: TElMenuItem; MenuItemClass:
  TElMenuItemClass);
var
  i: integer;
  SourceItem,
    DestItem: TElMenuItem;
begin
  for i := 0 to Source.Count - 1 do
  begin
    SourceItem := TElMenuItem(Source.Items[i]);
    DestItem := ElNewItem(SourceItem.Caption, SourceItem.ShortCut,
      SourceItem.Checked,
      SourceItem.Enabled, SourceItem.OnClick,
      SourceItem.HelpContext, SourceItem.Name, MenuItemClass);

    DestItem.Assign(SourceItem);
    Dest.Add(DestItem);

    if DestItem is TElMenuBarItem then
    begin
      TElMenuBarItem(SourceItem).OnIntChange := TElMenuBarItem(DestItem).MasterChange;
      DestItem.FreeNotification({TElMenuBarItem}(SourceItem));
      if (SourceItem.GetParentMenu is TElMainMenu) then
      begin
        // TElMainMenu.OwnerDraw hides TMenu.OwnerDraw property but works incorrectly
        // when we add new item in runtime
        if not TElMainMenu(SourceItem.GetParentMenu).OwnerDraw then
        begin
          DestItem.OnDrawItem := nil;
          DestItem.OnAdvancedDrawItem := nil;
        end;
      end
      else
        if not SourceItem.GetParentMenu.OwnerDraw then
        begin
          DestItem.OnDrawItem := nil;
          DestItem.OnAdvancedDrawItem := nil;
        end;
    end;

    if SourceItem.Count <> 0 then
      CopyElMenuItems(DestItem, SourceItem, MenuItemClass);
  end;
end;

constructor TElMenuBar.Create(AOwner : TComponent);
begin
  inherited;
  FIntMenu := TElBarPopupMenu.Create(Self);
  ShowCaption := true;
  ShowGlyph := true;
  GlyphLayout := blGlyphLeft;
  BtnOffsHorz := 1;
  BtnOffsVert := 1;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  MinSize := GetSystemMetrics(SM_CXMENUCHECK) + 2;
  Height := MinSize;
  BtnHeight := MinSize;
  FloatingDockSiteClass := TToolDockForm;
  // AdjustButtonHeight := false;
  GetFont;
  FHook := TElHook.Create(nil);
  FHook.OnBeforeProcess := OnBeforeHook;
  FHook.OnAfterProcess := OnAfterHook;
end;

destructor TElMenuBar.Destroy;
begin
  CancelMenu(false);
  FIntMenu.Free;
  FIntMenu := nil;
  FHook.Free;
  FHook := nil;
  inherited;
end;

procedure TElMenuBar.CancelMenu(ManualCancel : boolean);
begin
  if (FocusedButton <> nil) and (FocusedButton.FInMenu) then
  begin
    //FDroppedDown := false;
    CancelElMenu(ManualCancel); //??? #1
    FocusedButton.FInMenu := false;
    PostMessage(Handle, WM_KEYDOWN, VK_MENU, 1 shl 29);
    // while PeekMessage(Msg, 0, EL_ACTIVATEMENU, EL_ACTIVATEMENU, PM_REMOVE) do ;
  end;
end;

procedure TElMenuBar.CMMenuChanged(var Message: TMessage);
begin
  RebuildMenuBar;
end;

function TElMenuBar.GetButtonClass: TElToolButtonClass;
begin
  Result := TElMenuBarButton;
end;

procedure TElMenuBar.GetFont;
var AFont : HFont;
    LFont : TLogFont;
begin
  AFont := GetMenuFont;
  GetObject(AFont, sizeof(LFont), @LFont);
  Font.Name := LFont.lfFaceName;
  Font.Height := LFont.lfHeight;
  Font.Charset := LFont.lfCharSet;
  Font.Style := [];
  if LFont.lfHeight > 400 then
    Font.Style := Font.Style + [fsBold];
  if LFont.lfItalic <> 0 then
    Font.Style := Font.Style + [fsItalic];
  if LFont.lfUnderline <> 0 then
    Font.Style := Font.Style + [fsUnderline];
  if LFont.lfStrikeOut <> 0 then
    Font.Style := Font.Style + [fsStrikeOut];
  DeleteObject(AFont);
end;

procedure TElMenuBar.Loaded;
begin
  inherited;
  GetFont;
end;

procedure TElMenuBar.MouseOut;
var P : TPoint;
begin
  inherited;

  if (FocusedButton <> nil) and
     (FocusedButton.FInMenu) then exit;

  GetCursorPos(P);
  P := ScreenToClient(P);
  if PtInRect(ClientRect, P) then
    exit;

  if (not FInMenu) then
    FocusedButton := nil;
  FDroppedDown := false;
end;

procedure TElMenuBar.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited;
  if (operation = opRemove) then
  begin
    if (AComponent = FMenu) then
      Menu := nil;
  end; { if }
end; { Notification }

procedure TElMenuBar.OnAfterHook(Sender : TObject; var Message : TMessage; var Handled: boolean);
var
  i: integer;
  LForm: TForm;
  b: boolean;
begin
  Handled := false;
  if Message.Msg in [WM_KILLFOCUS, WM_SETFOCUS, WM_ACTIVATE] then
  begin
    if FButtons.Count > 0 then
      if (TElMenuBarItem(TElMenuBarButton(FButtons[0]).FMenuItem).GetDrawStyle = tdsNormal) and (LMDSIWindows98 or LMDSIWindows2000Up) then
      begin
        for i := 0 to ButtonCount - 1 do
          if not (csDesigning in ComponentState) then
          begin
            b := true;
            LForm := TForm(GetParentForm(Self));
            if Assigned(LForm) then
            begin
              b := LForm.Active or (LForm.FormStyle = fsMDIForm);
            end;
            TElToolButton(FButtons[i]).Enabled := TElMenuBarButton(FButtons[i]).FMenuItem.Enabled and b;
          end
          else
            TElToolButton(FButtons[i]).Enabled := TElMenuBarButton(FButtons[i]).FMenuItem.Enabled;
      end;
    Invalidate;
  end;
end;

procedure TElMenuBar.OnBeforeHook(Sender : TObject; var Message : TMessage; var Handled : boolean);
var
  LForm: TCustomForm;
begin
  Handled := false;
  if Message.Msg = WM_SYSCOMMAND then
  begin
    if (Message.wParam = SC_KEYMENU) and (Message.lParam = 0) then
    begin
      Message.Msg := 0;
      if (FocusedButton = nil) then
      begin
        OldFocus := GetFocus;
        try
          if CanFocus then
            SetFocus;
        except
          on EInvalidOperation do ;
        end;
        if FButtons.Count > 0 then
        begin
          FocusedButton := TElMenuBarButton(GetNextButton(nil, true, true));
          // Menu doesn't pulled down when Alt pressed, It's just focused
          //FocusedButton.DoPullMenu;
        end;
      end
      else
      begin
        Windows.SetFocus(OldFocus);
        FocusedButton := nil;
        PostMessage(Handle, EL_CANCELMENU, 0, 0);
      end;
      Handled := true;
    end;
  end
  else
    if (Message.Msg = CN_KEYDOWN) or (Message.Msg = CM_CHILDKEY) then
    begin
      if not (csDesigning in ComponentState) then
        Handled := True;
      ELShortcut(Message);
      LForm := GetParentForm(Self);
      if (THackForm(LForm).FormStyle = fsMDIChild) then
      begin
        if (THackForm(LForm).Owner is TCustomForm) then
          LForm := TCustomForm(THackForm(LForm).Owner)
        else
          LForm := nil;
        if (LForm <> nil) then
          SendMessage(LForm.Handle, Message.Msg, Message.WParam, Message.LParam);
      end;
    end;
end;

type
  THackMenu = class(TElPopupMenu);

procedure TElMenuBar.PopupMenuPopup(Sender : TObject);
var
  Btn : TElToolButton;
  R   : TRect;
begin
  THackMenu(Sender as TElPopupMenu).HookWindowProc := PopupWndProc;
  THackMenu(Sender as TElPopupMenu).InitialSelect := FInitSelect;
  Btn := TElToolButton((Sender as TElPopupMenu).PopupComponent);
  R := Btn.BoundsRect;
  if Orientation = eboVert then
    R := Rect(R.Right, R.Top, R.Right, R.Bottom)
  else
    R := Rect(R.Left, R.Bottom, R.Right, R.Bottom);

  R.TopLeft := ClientToScreen(R.TopLeft);
  R.BottomRight := ClientToScreen(R.BottomRight);
  THackMenu(Sender as TElPopupMenu).ExcludeRect := R;
  FInMenu := true;
end;

procedure TElMenuBar.PopupWndProc(var Message : TMessage);
var P : TPoint;
    Ctl : TControl;
begin
  if Message.Msg = WM_MOUSEMOVE then
  begin
    P := SmallPointToPoint(TWMMouse(Message).Pos);
    if (P.X <> FLastMousePos.X) or (P.Y <> FLastMousePos.Y) then
    begin
      FLastMousePos := P;

      P := ScreenToClient(P);
      if PtInRect(ClientRect, P) then
      begin
        Ctl := ControlAtPos(P, false);
        if (Ctl <> nil) and (Ctl is TElMenuBarButton) and (Ctl <> FocusedButton) then
        begin

          CancelMenu(true);

          FocusedButton := TElMEnuBarButton(Ctl);
          PostMessage(Self.Handle, EL_ACTIVATEMENU, 1, TLMDPtrInt(Pointer(Ctl)));
        end;
      end;
    end;
  end;
end;

procedure TElMenuBar.RebuildMenuBar;
var i, j : integer;
    //mw, mh : integer;
    Button : TElMenuBarButton;
    AMenu  : TElPopupMenu;
    //Item   : TMenuItem;
    AMenuItem : TElMenuItem;
begin

  BeginUpdate;
  while FButtons.Count > 0 do
  begin
    if TElMenuBarButton(FButtons.Last).PullDownMenu <> nil then
      TElMenuBarButton(FButtons.Last).PullDownMenu.Free;
    TElMenuBarButton(FButtons.Last).Free;
  end;

  if Menu <> nil then
  begin
    TElMenuBarItem(Menu.Items).OnIntChange := MasterChange;
    Self.FreeNotification(Menu.Items);
    for i := 0 to Menu.Items.Count - 1 do
    begin
      Button := TElMenuBarButton(AddButton(ebtButton));

      AMenuItem := ElNewItem('', 0, false, false, nil, 0, '', TElMenuBarItem);
      AMenuItem.Assign(TElMenuItem(Menu.Items[i]));
      FIntMenu.Items.Add(AMenuItem);

      Button.FMenuItem := AMenuItem;
      if Menu.OwnerDraw then
      begin
        if Assigned(Menu.Items[i].OnDrawItem) then
          Button.FOnDrawItem := Menu.Items[i].OnDrawItem;
        if Assigned(Menu.Items[i].OnAdvancedDrawItem) then
          Button.FOnAdvancedDrawItem := Menu.Items[i].OnAdvancedDrawItem;
      end
      else
      begin
        AMenuItem.OnDrawItem := nil;
        AMenuItem.OnAdvancedDrawItem := nil;
      end;
      TElMenuBarItem(AMenuItem).FLinkCommand := TElMenuItem(Menu.Items[i]).Command;

      AMenu := TElPopupMenuBar.Create(Self);
      Button.PulldownMenu := AMenu;
      AMenu.RightToLeft := RightToLeft;

      TElMenuBarItem(Menu.Items[i]).OnIntChange := Button.MasterChange;
      Button.FreeNotification(Menu.Items[i]);
      Button.CopyFromMenuItem(Menu.Items[i]);

      AMenu.ItemSpace := Menu.ItemSpace;
      AMenu.ImageMargin := Menu.ImageMargin;

      AMenu.OnPopup := PopupMenuPopup;
      AMenu.OnEndPopup := PopupMenuEndPopup;
      TElPopupMenuBar(AMenu).OnNavigateKey := PopupMenuNavigateKey;

      CopyElMenuItems(AMenu.Items, TElMenuItem(Menu.Items[i]), TElMenuBarItem);
      for j := 0 to TElMenuItem(Menu.Items[i]).Count - 1 do
      begin
        TElMenuBarItem(AMenu.Items[j]).FLinkCommand := TElMenuItem(Menu.Items[i]).Items[j].Command;
      end;

      //Item := TMenuItem(Button.PullDownMenu.Items);
      //j := Item.Count;

    end;
    CopyMenuProperties;

    j := GetSystemMetrics(SM_CXMENUCHECK) + 2;
    i := 0;
    THackItem(Menu.Items).MeasureItem(Canvas, i, j);
    BtnHeight := j;
    MinSize := j;
    if AutoSize then
      Height  := j;
  end
  else
  begin
    Images := nil;
    MinSize := GetSystemMetrics(SM_CXMENUCHECK) + 2;
    BtnHeight := MinSize;
    if AutoSize then
      Height := MinSize;
  end;
  FIntMenu.RightToLeft := RightToLeft;
  if Autosize then
    AlignButtons;
  EndUpdate;
end;

procedure TElMenuBar.RequestAlign;
var
  i: Integer;
begin
  inherited;
  AlignSysMDIButtons();
  for i:=0 to ControlCount-1 do
    if Controls[i] is TCustomElToolButton then
      with TCustomElToolButtonProtected(Controls[i]) do
        case Self.Align of
          alLeft, alRight:
            PopupPlace := ppRight;
          else
            PopupPlace := ppDown;
        end;
      end;

procedure TElMenuBar.SetFocusedButton(Value: TElMenuBarButton);
var Button : TElMenuBarButton;
begin
  if FFocusedButton <> Value then
  begin
    Button := FFocusedButton;

    if not FChFocusButton then
    begin
      FChFocusButton := true;
      try
        CancelMenu(false);
      finally
        FChFocusButton := false;
      end;
    end;

    FFocusedButton := nil;
    if Button <> nil then
      Button.Repaint;

    FFocusedButton := Value;

    if FFocusedButton <> nil then
    begin
      FFocusedButton.Invalidate;

      // PostMessage(Handle, WM_MENUBARMSG1, 0, 0); //!!!
      //SelectedItem := FFocusedButton;
      //Application.ProcessMessages;
      //PostMessage(Handle, WM_KEYDOWN, VK_MENU, 1 shl 29);
      //FocusedButton.DoPullMenu;
      {
      SelectedItem := nil;
      //OldFocus      : HWND;
      if b then
      begin
        //InMenuCount := 1;
        FocusedButton.DoPullMenu;
      end;
      {}
    end
  end;
end;

procedure TElMenuBar.SetMenu(Value: TElMainMenu);
var
  i: integer;
  LParent: TCustomForm;
begin
  if FMenu <> Value then
  begin
    if FMenu <> nil then
    begin
      TElMenuBarItem(FMenu.Items).OnIntChange := nil;
      for i := 0 to FMenu.Items.Count - 1 do
      begin
        TElMenuBarItem(FMenu.Items[i]).OnIntChange := nil;
      end;
      if not (csDestroying in FMenu.ComponentState) then
        FMenu.RemoveFreeNotification(Self);
    end;
//    if (FMenu <> nil) and (Value = nil) and (not (csDesigning in ComponentState)) then
//    begin
//      UnhookWindowsHookEx(OldKbdProc);
//      HookMenuBar := nil;
//    end
//    else
//    if (FMenu = nil) and (Value <> nil) and (not (csDesigning in ComponentState)) then
//    begin
//      OldKbdProc := SetWindowsHookEx(WH_KEYBOARD, @MenuBarKbdProc, 0, GetCurrentThreadId);
//      HookMenuBar := Self;
//    end;
    FMenu := Value;
    if FMenu <> nil then
    begin
      LParent := GetParentForm(Self);
      if Assigned(LParent) then
        if LParent.Menu = FMenu then
          LParent.Menu := nil;

      FMenu.FreeNotification(Self);
      //FIntMenu.Assign(FMenu);
    end;

    FIntMenu.Items.Clear;
    RebuildMenuBar;
  end;
end;

{------------------------------------------------------------------------------}

function HookProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT stdcall;
var
  i: Integer;
begin
  if code = HCBT_MINMAX then
    for i := 0 to LMDWndHoolHelper.Count - 1 do
      LMDWndHoolHelper.Items[i].CheckChildWindowChanging(wparam, lparam)
  else
    if code = HCBT_DESTROYWND then
      for i := 0 to LMDWndHoolHelper.Count - 1 do
        LMDWndHoolHelper.Items[i].CheckChildWindowChanging(wparam, WM_DESTROY);

  Result := CallNextHookEx(FWndHook, code, wparam, lparam)
end;

{------------------------------------------------------------------------------}

procedure TElMenuBar.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) then
  begin
    FHook.Control := GetParentForm(AParent);
    FHook.Active := true;
    if Assigned(FHook.Control) then
    begin
      if TForm(FHook.Control).FormStyle = fsMDIForm then
        LMDWndHoolHelper.Subscribe(Self);
    end;
  end
  else
  begin
    if FHook <> nil then
      FHook.Control := nil;
  end;
end;

procedure TElMenuBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB or DLGC_WANTCHARS;
end;

procedure TElMenuBar.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  FocusedButton := nil;
end;

procedure TElMenuBar.ELActivateMenu(var Message: TMessage);
var
  FIsMenuDown : integer;
begin
  FIsMenuDown := Message.wParam;
  FocusedButton := TElMenuBarButton(Message.lParam);
  (*
  if FIsMenuDown = 2 then
  begin
    PostMessage(Handle, EL_ACTIVATEMENU, 2, Message.LParam);
  end;
  *)

  if (FocusedButton <> nil) and (FIsMenuDown <> 0) then
  begin
    FDroppedDown := true;
    FInitSelect := true;
    FocusedButton.DoPullMenu;
    FocusedButton := TElMenuBarButton(Message.lParam);
  end;
 // FIsMenuDown := boolean(Message.wParam);
end;

procedure TElMenuBar.PopupMenuEndPopup(Sender : TObject; ManualCancel :
    boolean);
begin
  FDroppedDown := ManualCancel;
  if not ManualCancel then
    PostMessage(Handle, EL_CANCELMENU, 0, 0);
end;

procedure TElMenuBar.PopupMenuNavigateKey(Sender : TObject; Key : Word);
var
  NewButton : TElMenuBarButton;
  P         : TPoint;
begin
  if ((Key = VK_LEFT) and (Orientation = eboHorz)) or
     ((Key = VK_UP) and (Orientation = eboVert)) then
  begin
    if (FocusedButton <> nil) then
    begin
      NewButton := TElMenuBarButton(GetNextButton(FocusedButton, false, false));
      if NewButton <> FocusedButton then
      begin
        CancelMenu(true);
        GetCursorPos(P);
        FLastMousePos := P;
        FocusedButton := TElMenuBarButton(NewButton);
        if FInMenu then
          PostMessage(Self.Handle, EL_ACTIVATEMENU, 2, TLMDPtrInt(Pointer(NewButton)));
      end;
    end;
  end
  else
  if ((Key = VK_RIGHT) and (Orientation = eboHorz)) or
     ((Key = VK_DOWN) and (Orientation = eboVert)) then
  begin
    if (FocusedButton <> nil) then
    begin
      NewButton := TElMenuBarButton(GetNextButton(FocusedButton, true, false));
      if NewButton <> FocusedButton then
      begin
        CancelMenu(true);
        GetCursorPos(P);
        FLastMousePos := P;
        FocusedButton := TElMenuBarButton(NewButton);
        if FInMenu then
          PostMessage(Self.Handle, EL_ACTIVATEMENU, 2, TLMDPtrInt(Pointer(NewButton)));
      end;
    end;
  end;
  if (Key = VK_RETURN) or ((Key = VK_RIGHT) and (Orientation = eboVert))  or
     ((Key = VK_DOWN) and (Orientation = eboHorz)) then
  begin
    FInMenu := True;
    PostMessage(Self.Handle, EL_ACTIVATEMENU, 2, TLMDPtrInt(Pointer(FocusedButton)));
    end;
  if Key = VK_ESCAPE then
  begin
    if not FocusedButton.FMouseMenu then
      FocusedButton := nil;
  end;
end;

procedure TElMenuBar.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
end;

procedure TElMenuBar.WMMouseMove(var Message: TWMMouseMove);
var P : TPoint;
begin
  GetCursorPos(P);
  FLastMousePos := P;

  FocusedButton := nil;
  inherited;
end;

procedure TElMenuBar.SetOrientation(newValue : TElBarOrientation);
var i : integer;
begin
  if (Orientation <> newValue) then
  begin
    inherited;
    for i := 0 to ButtonCount - 1 do
    begin
      if Orientation = eboVert then
      begin
        TElToolButton(FButtons[i]).PopupPlace := ppRight;
      end
      else
      begin
        TElToolButton(FButtons[i]).PopupPlace := ppDown;
      end;
    end;
  end; {if}
end; {SetOrientation}

procedure TElMenuBar.ELShortcut(var Message: TMessage);
var
  Msg : TWMKeyDown;
begin
  Msg.Msg := WM_KEYDOWN;
  Msg.CharCode := Message.wParam;
  Msg.KeyData := Message.lParam;

  if FMenu <> nil then
    FMenu.IsShortCut(Msg);
  end;

procedure TElMenuBar.ELCancelMenu(var Message: TMessage);
var
  LOldFocused: TElMenuBarButton;
begin
  if FocusedButton <> nil then
    FocusedButton.FMouseMenu := false;
  LOldFocused := FFocusedButton;
  FocusedButton := nil;
  if Focused then
    FocusedButton := LOldFocused;
end;

procedure TElMenuBar.CopyMenuProperties;
var
  i : integer;
  AMenu : TElPopupMenuBar;
  Button: TElMenuBarButton;
  //AMenuItem : TElMenuItem;
begin
  Self.Images := Menu.Images;
  Self.AlphaForImages := Menu.AlphaForImages;
  Self.DisabledImages := Menu.DisabledImages;
  Self.AlphaForDisabledImages := Menu.AlphaForDisabledImages;
  Self.HotImages := Menu.HotImages;
  Self.AlphaForHotImages := Menu.AlphaForHotImages;

  Self.FIntMenu.Images := Menu.Images;
  Self.FIntMenu.AlphaForImages := Menu.AlphaForImages;
  Self.FIntMenu.DisabledImages := Menu.DisabledImages;
  Self.FIntMenu.AlphaForDisabledImages := Menu.AlphaForDisabledImages;
  Self.FIntMenu.HotImages := Menu.HotImages;
  Self.FIntMenu.AlphaForHotImages := Menu.AlphaForHotImages;

  Self.FIntMenu.DrawStyle := Menu.DrawStyle;
  Self.FIntMenu.SystemFont := Menu.SystemFont;
  Self.FIntMenu.Font := Menu.Font;
  Self.FIntMenu.OwnerDraw := Menu.OwnerDraw;
  Self.FIntMenu.IsHTML := Menu.IsHTML;

  Self.FIntMenu.UseFontColor := Menu.UseFontColor;
  Self.FIntMenu.SelectedItemFont := Menu.SelectedItemFont;

  for i := 0 to ButtonCount - 1 do
  begin
    Button:= TElMenuBarButton(FButtons[i]);
    AMenu := TElPopupMenuBar(Button.PulldownMenu);
    if Menu.SystemFont = false then
    begin
      Button.ParentFont := false;
      Button.Font := Menu.Font;
      AMenu.SystemFont := false;
      AMenu.Font := Menu.Font;
    end;

    Button.IsHTML := Menu.IsHTML;

    AMenu.DrawStyle := Menu.DrawStyle;
    AMenu.OwnerDraw := True;
    AMenu.UseXPThemes := UseXPThemes;
    AMenu.Images := Menu.Images;
    AMenu.AlphaforImages := Menu.AlphaforImages;
    AMenu.DisabledImages := Menu.DisabledImages;
    AMenu.AlphaForDisabledImages := Menu.AlphaForDisabledImages;
    AMenu.HotImages := Menu.HotImages;
    AMenu.Images := Menu.Images;
    AMenu.Tag := Menu.Tag;

    AMenu.UseFontColor := Menu.UseFontColor;
    AMenu.SelectedItemFont := Menu.SelectedItemFont;

  end;
end;

procedure TElMenuBar.MasterChange(Sender: TObject; MenuItem: TElMenuItem;
    Rebuild: boolean);
begin
  if (csDestroying in FMenu.ComponentState) then
  begin
    SetMenu(nil);
    exit;
  end;
  CopyMenuProperties;
  if Rebuild then
    RebuildMenuBar;
  AlignButtons;
end;

procedure TElMenuBar.ELRefocusButton(var Message: TMessage);
begin
  FocusedButton := TElMenuBarButton(Message.WParam);
  if FocusedButton <> nil then
    FocusedButton.Invalidate;
end;

procedure TElMenuBar.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
end;

{$ifdef LMDX64}
type
  TLMDMenuFinder = class
    Value: TLMDPtrUInt;
    Kind: TFindItemKind;
    FoundItem: TElMenuItem;
    function Find(Item: TElMenuItem): Boolean;
  end;

function TLMDMenuFinder.Find(Item: TElMenuItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ((Kind = fkCommand) and (Value = Item.Command)) or
    ((Kind = fkHandle) and (Value = Item.Handle)) or
    ((Kind = fkShortCut) and (Value = Item.ShortCut)) then
  begin
    FoundItem := Item;
    Result := True;
    Exit;
  end
  else
    for I := 0 to Item.Count - 1 do
      if Find(Item[I]) then
      begin
        Result := True;
        Exit;
      end;
end;

function TElPopupMenuBar.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  LFinder: TLMDMenuFinder;
begin
  LFinder := TLMDMenuFinder.Create;
  try
    LFinder.Value := Value;
    LFinder.Kind := Kind;
    IterateMenus(LFinder.Find, Items.Merged, Items);
    Result := LFinder.FoundItem;
  finally
    LFinder.Free;
  end;
end;
{$else}
function TElPopupMenuBar.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  FoundItem: TElMenuBarItem;

  function Find(Item: TElMenuBarItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if ((Kind = fkCommand) and (Value = Item.{FLink}Command)) or
      ((Kind = fkHandle) and (Value = Item.Handle)) or
      ((Kind = fkShortCut) and (Value = Item.ShortCut)) then
    begin
      FoundItem := Item;
      Result := True;
      Exit;
    end
    else
      for I := 0 to Item.GetCount - 1 do
        if Find(TElMenuBarItem(Item[I])) then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  FoundItem := nil;
  if Items <> nil then
    IterateMenus(@Find, Items.Merged, Items);
  Result := FoundItem;
end;
{$endif}

procedure TElMenuBarButton.DoPullMenu;
begin
  FShadow := TElShadow.Create(Owner);
  try
    FShadow.VisibleHorizontalShadow := False;
    FShadow.Control := Self;
    FShadow.Visible := True;
    if TElPopupMenu(PullDownMenu).Items.Count > 0 then
      FMenuItem.Click;
    inherited;
  finally
    FShadow.Free;
    FInMenu := false;
    TElMenuBar(Parent).FInitSelect := false;
    TElMenuBar(Parent).FInMenu := false;
    if not FMouseMenu then
      TElMenuBar(Parent).FocusedButton := nil;
    if TElMenuBar(Parent).Transparent then
      TElMenuBar(Parent).Invalidate;
  end;
end;

function TElMenuBarButton.Focused: Boolean;
begin
  Result := (Self = (Owner as TElMenuBar).FocusedButton){ and (TElMenuBar(Owner).MouseInControl)};
end;

procedure TElMenuBarButton.MouseDown(Button : TMouseButton; Shift : TShiftState;
    X, Y : Integer);
//var //P : TPoint;
    //R : TRect;
begin
  (Owner as TElMenuBar).FDroppedDown := false;
  (Owner as TElMenuBar).FocusedButton := Self;
  Invalidate;

  inherited;

  FDragging := false;
  FMouseInControl := false;

  FMouseMenu := true;
  AClick(false);
  FMouseMenu := false;
end;

procedure TElMenuBarButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  P : TPoint;
begin
  P := Point(X, Y);
  P := ClientToScreen(P);
  if (P.X <> TElMenuBar(Parent).FLastMousePos.X) or (P.Y <> TElMenuBar(Parent).FLastMousePos.Y) then
  begin
    TElMenuBar(Parent).FLastMousePos := P;

    if TElMenuBar(Parent).FocusedButton <> Self then
    begin
      TElMenuBar(Parent).FocusedButton := Self;
      if TElMenuBar(Parent).FDroppedDown then
      begin
        if (PullDownMenu <> nil) and (PullDownMenu.Items.Count > 0) then
          DoClick;
//        PostMessage(Parent.Handle, EL_ACTIVATEMENU, 1, TLMDPtrInt(Pointer(Self)));
      end;
    end;
  end;
  inherited;
end;

procedure TElMenuBarButton.Paint;
var
  fstate: TOwnerDrawState;
  LOldEnabled: Boolean;
  LForm: TForm;
  b: boolean;
begin
  if Assigned(FOnDrawItem) or Assigned(FOnAdvancedDrawItem) then
  begin
    if Assigned(FOnDrawItem) then
      FOnDrawItem(FMenuItem, Canvas, ClientRect, Focused);
    if Assigned(FOnAdvancedDrawItem) then
    begin
      if LMDSIWindows2000Up then
        fstate := [odNoAccel]
      else
        fstate := [odDefault];
      if ((GetParentForm(Self) <> nil) and not GetParentForm(Self).Active) then
        Include(fstate, odDisabled);
      if Focused and not FInMenu then
        include(fstate, odHotLight);
      if FInMenu then
        include(fstate, odSelected);
      FOnAdvancedDrawItem(FMenuItem, Canvas, ClientRect, fstate);
    end;
  end
  else
    if (TElMenuBarItem(FMenuItem).GetDrawStyle = tdsNormal) and (LMDSIWindows98 or LMDSIWindows2000Up) then
      inherited
    else
    begin
      TElMenuBarItem(FMenuItem).Vertical := TElMenuBar(Parent).Orientation = eboVert;
      LOldEnabled := FMenuItem.Enabled;
      if (TElPopupMenu(PullDownMenu).Items.Count = 0) and (not Assigned(FMenuItem.OnClick)) then
        FMenuItem.Enabled := False;
      if not (csDesigning in ComponentState) and (GetParentForm(Self) <> nil) then
      begin
        b := true;
        LForm := TForm(GetParentForm(Self));
        if Assigned(LForm) then
        begin
          b := LForm.Active or (LForm.FormStyle = fsMDIForm);
        end;
        if not b then
          FMenuItem.Enabled := false;
      end;
      TElMenuBarItem(FMenuItem).DrawMenuItem(Canvas, ClientRect, Focused, FInMenu);
      FMenuItem.Enabled := LOldEnabled;
    end;
end;

function TElMenuBarButton.MeasureButton(LockHeight : boolean): TPoint;
begin
  if (TElMenuBarItem(FMenuItem).GetDrawStyle = tdsNormal) and (LMDSIWindows98 or LMDSIWindows2000Up) then
    result := inherited MeasureButton(LockHeight)
  else
    TElMenuBarItem(FMenuItem).MeasureItem(Canvas, Result.X, Result.Y);
end; { MeasureButton }

destructor TElMenuBarButton.Destroy;
begin
  inherited;
end;

procedure TElMenuBarButton.DoClick;
begin
  TElMenuBar(Parent).FocusedButton := Self;
  if GetKeyState(VK_MENU) <> 0 then
    TElMenuBar(Parent).IgnoreAltUp := true;
//  FMenuItem.Click;
end;

procedure TElMenuBarButton.WndProc(var Message : TMessage);
begin
  inherited;
  if Message.Msg = WM_EXITMENULOOP Then
    Invalidate;
end;

procedure TElMenuBarButton.CopyFromMenuItem(Item : TElMenuItem);
begin
  FMenuItem.Assign(Item);

  ShortcutsEnabled := true;
  Caption := Item.Caption;
  ImageIndex := Item.ImageIndex;
  Visible := Item.Visible;
  Enabled := Item.Enabled;
  Hint := Item.Hint;
  Action := Item.Action;
  Tag := Item.Tag;
end;

procedure TElMenuBarButton.MasterChange(Sender: TObject; MenuItem: TElMenuItem;
    Rebuild: boolean);
begin
  CopyFromMenuItem(Sender as TElMenuItem);
  if Rebuild then
  begin
    TElPopupMenu(PullDownMenu).Items.Clear;
    CopyElMenuItems(TElPopupMenu(PullDownMenu).Items, Sender as TElMenuItem, TElMenuBarItem);
  end;
end;

procedure TElMenuBarButton.MouseUp(Button : TMouseButton; Shift : TShiftState;
    X, Y : Integer);
begin
  inherited;
end;

procedure TElMenuBarButton.CMDialogChar(var Message : TCMDialogChar);
begin
  with Message do
    if ShortcutsEnabled and IsAccel(CharCode, Caption) and (HiByte(GetKeyState(VK_MENU)) > 0) then
    begin
      (Owner as TElMenuBar).FInitSelect := true;
    end;
  inherited;
end;

constructor TElMenuBarButton.Create(AOwner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csCaptureMouse, csDoubleClicks];
end;

{ TElMenuBarItem }

procedure TElMenuBarItem.MasterChange(Sender: TObject;
  MenuItem: TElMenuItem; Rebuild: boolean);
begin
  Assign(Sender as TElMenuItem);
  if Rebuild then
  begin
    Clear;
    CopyElMenuItems(Self, Sender as TElMenuItem, TElMenuBarItem);
  end;
end;

procedure TElMenuBar.SetRightToLeft(Value: Boolean);
begin
  inherited SetRightToLeft(Value);
  FIntMenu.RightToLeft := Value;
  RebuildMenuBar;
end;

procedure TElMenuBar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Assigned(FFocusedButton) {and (TElPopupMenu(FFocusedButton.PullDownMenu).Items.count = 0) }then
    PopupMenuNavigateKey(Self, Key);
end;

procedure TElMenuBar.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then
  begin
    if Assigned(FMenu) then
    begin
      if not FMenu.SystemFont then
        FMenu.Font.Assign(Self.Font);
      FMenu.UpdateItems;
      FMenu.Items.DesignRebuild;
      CopyMenuProperties;
      AlignButtons;
      RebuildMenuBar;
    end;
  end;
end;

procedure TElMenuBar.AlignSysMDIButtons();
begin
  if Assigned(FSysMinButton) then
    FSysMinButton.Left := Self.Width - FSysMinButton.Width * 3;

  if Assigned(FSysCloseButton) then
    FSysCloseButton.Left := Self.Width - FSysCloseButton.Width;

  if Assigned(FSysRestoreButton) then
    FSysRestoreButton.Left := Self.Width - FSysRestoreButton.Width * 2;
end;

procedure TElMenuBar.ShowMDIButtons(AHandle:HWND);
var
  LGlyph: Graphics.TBitmap;
begin
  if Assigned(FSysButton) then
    HideMDIButtons();
  FSysButton := TElPopupButton.Create(Self);
  FSysButton.Parent := Self;
  FSysButton.Width := FSysButton.Height;
  FSysButton.Visible := True;
  FSysButton.Flat := True;
  FSysButton.Down := True;
  FSysButton.ThemeMode := ttmNone;
  FSysButton.OnClick := PullDownMenuDropDown;
  FSysButton.ShowBorder := False;

  LGlyph := Graphics.TBitmap.Create;
  LGlyph.Height := FSysButton.Height;
  LGlyph.Width := FSysButton.Width;

  DrawIconEx(LGlyph.Canvas.Handle, 0, 0, Application.Icon.Handle, LGlyph.Width, LGlyph.Height, 0, 0, DI_NORMAL);

  FSysButton.Glyph.Assign(LGlyph);
  FSysMenu := GetSystemMenu(AHandle, False);
  LGlyph.Free;

  {min}
  FSysMinButton := TElSystemButton.Create(nil);
  FSysMinButton.Parent := Parent;
  FSysMinButton.Width := FSysButton.Height;
  FSysMinButton.Height := FSysButton.Height;
  FSysMinButton.Visible := True;
  FSysMinButton.ThemeMode := UseThemeMode;
  FSysMinButton.Left := Self.Width - FSysMinButton.Width * 3;
  FSysMinButton.Caption := 'i';
  FSysMinButton.ButtonType := SC_MINIMIZE;
  FSysMinButton.OnClick := OnSystemMDIButtonClick;
  {close}
  FSysCloseButton := TElSystemButton.Create(nil);
  FSysCloseButton.Parent := Parent;
  FSysCloseButton.Width := FSysButton.Height;
  FSysCloseButton.Height := FSysButton.Height;
  FSysCloseButton.Visible := True;
  FSysCloseButton.ThemeMode := UseThemeMode;
  FSysCloseButton.Left := Self.Width - FSysCloseButton.Width;
  FSysCloseButton.Caption := 'x';
  FSysCloseButton.ButtonType := SC_CLOSE;
  FSysCloseButton.OnClick := OnSystemMDIButtonClick;

  {restore}
  FSysRestoreButton := TElSystemButton.Create(nil);
  FSysRestoreButton.Parent := Parent;
  FSysRestoreButton.Width := FSysButton.Height;
  FSysRestoreButton.Height := FSysButton.Height;
  FSysRestoreButton.Visible := True;
  FSysRestoreButton.ThemeMode := UseThemeMode;
  FSysRestoreButton.Left := Self.Width - FSysRestoreButton.Width * 2;
  FSysRestoreButton.Caption := 'r';
  FSysRestoreButton.ButtonType := SC_RESTORE;
  FSysRestoreButton.OnClick := OnSystemMDIButtonClick;
end;

procedure TElMenuBar.HideMDIButtons();
begin
//   MessageBox(0, 0, 0, 0);
  if Assigned(FSysButton) then
    FreeAndNil(FSysButton);
  if Assigned(FSysMinButton) then
    FreeAndNil(FSysMinButton);
  if Assigned(FSysCloseButton) then
    FreeAndNil(FSysCloseButton);
  if Assigned(FSysRestoreButton) then
    FreeAndNil(FSysRestoreButton);

end;

procedure TElMenuBar.CheckChildWindowChanging(AHandle: HWND; ACommand: Word);
  function WindowIsMDIChild(AHandle: HWND): Boolean;
  var
    i: Integer;
    LMainForm, LChildForm: TForm;
  begin
    LMainForm := Application.MainForm;
    if Assigned(LMainForm) then
      for i := 0 to LMainForm.MDIChildCount - 1 do
      begin
        LChildForm := LMainForm.MDIChildren[I];
        if LChildForm.HandleAllocated and (LChildForm.Handle = AHandle) then
        begin
          Result := True;
          Exit;
        end;
      end;
    Result := False;
  end;
var
  WP: TWindowPlacement;
begin
  if WindowIsMDIChild(AHandle) then
  begin
    // For restore maximized window from minimized state
    WP.length := SizeOf(TWIndowPlacement);
    GetWindowPlacement(AHandle, @WP);
    if (ACommand = SW_RESTORE) and (WP.showCmd = SW_SHOWMINIMIZED) and (WP.flags and WPF_RESTORETOMAXIMIZED = WPF_RESTORETOMAXIMIZED) then
      ACommand := SW_MAXIMIZE;

    case ACommand of
      SW_MAXIMIZE:
        begin
          FActiveMDIForm := AHandle;
          ShowMDIButtons(AHandle);
        end;
      SW_RESTORE, SW_MINIMIZE:
        HideMDIButtons();
      WM_DESTROY:
        if Application.MainForm.MDIChildCount <= 1 then
          HideMDIButtons();
        end;
  end;
end;

procedure TElMenuBar.PullDownMenuDropDown(Sender: TObject);
var
  q: TPoint;
  LHandle: HWND;
begin
  q.X := 0;
  q.Y := 0;
  q := ClientToScreen(q);
  q.Y := q.Y + Height;
  LHandle := 0;
  if Assigned(Application.MainForm) then
    LHandle := Application.MainForm.Handle;

  TrackPopupMenu(FSysMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
    q.X,
    q.Y,
    0, LHandle, nil);
end;

procedure TElMenuBar.OnSystemMDIButtonClick(Sender: TObject);
begin
  SendMessage(FActiveMDIForm, WM_SYSCOMMAND, TElSystemButton(Sender).ButtonType, 0);
end;

procedure TElMenuBar.DoThemeChanged;
var
  i: integer;
begin
  inherited;
  for i := 0 to ButtonCount - 1 do
  begin
    TElPopupMenuBar(TElMenuBarButton(FButtons[i]).PulldownMenu).ThemeMode := ThemeMode;
  end;
end;

initialization
  FWndHook := SetWindowsHookEx(WH_CBT, HookProc, 0, GetCurrentThreadId());
  LMDWndHoolHelper := TLMDWndHoolHelper.Create;
finalization
  UnhookWindowsHookEx(FWndHook);
  LMDWndHoolHelper.Destroy;
end.
