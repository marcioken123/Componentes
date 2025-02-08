unit LMDDsgComboBox;
{$I LmdCmps.inc}

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

LMDDsgComboBox unit (YB, AH)
------------------------
TLMDObjectComboBox unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, StdCtrls, ExtCtrls, Forms, Types,
  SysUtils, Graphics, Themes, IntfLMDBase, LMDTypes, LMDUnicode, LMDSvcPvdr,
  LMDDsgClass, LMDDsgCst, LMDDsgObjects;

type
  ELMDObjectComboBox       = class(Exception);
  TLMDCustomObjectComboBox = class;

  { **************************** TLMDPopupList ******************************* }

  TLMDDropDownAlign = (daLeft, daRight, daCenter);

  TLMDPopupList = class(TCustomListBox)
  private
    FComboBox   : TLMDCustomObjectComboBox;
    FPopup      : Boolean;
    FReadOnly   : Boolean;
    FRowCount   : Integer;
    FItems      : TLMDStrings;

    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure SetRowCount(Value: Integer);
    function  GetBorderSize: Integer;
    procedure SetItems(const Value: TLMDStrings);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateWnd; override;
  public
    constructor Create(AComboBox: TLMDCustomObjectComboBox); reintroduce;
    destructor Destroy; override;

    property Items: TLMDStrings read FItems write SetItems;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property RowCount: Integer read FRowCount write SetRowCount;
  end;

  TLMDObjectComboBoxOnGetObjectNamePath = procedure(Sender: TObject;
    AObject: TPersistent; var ANamePath, AClassName: TLMDString) of object;

  { *********************** TLMDCustomObjectComboBox ************************* }

  TLMDCustomObjectComboBox = class(TCustomControl, ILMDComponent)
  private
    FAbout                    : TLMDAboutVar;
    FServiceProvider          : TLMDServiceProvider;
    FDropDownWidth            : Integer;
    FDropDownRows             : Integer;
    FDropDownAlign            : TLMDDropDownAlign;
    FButtonWidth              : Integer;
    FHasFocus                 : Boolean;
    FListVisible              : Boolean;
    FListActive               : Boolean;
    FPopupList                : TLMDPopupList;
    FMouseInControl           : Boolean;
    FTracking                 : Boolean;
    FPressed                  : Boolean;
    FOnDropDown               : TNotifyEvent;
    FOnCloseUp                : TNotifyEvent;
    FReadOnly                 : Boolean;
    FSelectedObjectBuffer     : TPersistent;
    FSelectedCountBuffer      : Integer;
    FListObjects              : TLMDDesignObjects;
    FListObjsNotifier         : TObject;
    FSelection                : TLMDDesignObjects;
    FSelnNotifier             : TObject;
    FClassNameColor           : TColor;
    FShowClassName            : Boolean;
    FShowFocus                : Boolean;
    FOnGetObjectNamePath      : TLMDObjectComboBoxOnGetObjectNamePath;
    FDestroying               : Boolean;
    FSortDropDown             : Boolean;

    procedure SetClassNameColor(const Value: TColor);
    procedure SetShowClassName(const Value: Boolean);
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure UpdateView;
    procedure PopupListDrawItem(Control: TWinControl; Index: Integer;
                                Rect: TRect; State: TOwnerDrawState);
    procedure PaintItem(ACanvas: TCanvas; ARect: TRect; AX, AY: Integer;
                        AObject: TPersistent; AIsComboText, AIsSelected,
                        AIsFocused: Boolean);
    procedure SetShowFocus(const Value: Boolean);
    function  GetDroppedDown: Boolean;
    procedure SetListObjects(const Value: TLMDDesignObjects);
    procedure SetSelection(const Value: TLMDDesignObjects);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure CompsChangeNotification(Sender: TObject; AChangedComps: TList);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;

    procedure GetObjectNamePath(AObject: TPersistent; var ANamePath,
                                  AClassName: TLMDString);
    procedure DoGetObjectNamePath(AObject: TPersistent; var ANamePath,
                                  AClassName: TLMDString); virtual;
    procedure DoDropDown; virtual;
    procedure DoCloseUp; virtual;
    function  GetBorderSize: Integer; virtual;
    function  GetTextHeight: Integer; virtual;

    procedure CreateParams(var Params: TCreateParams); override;
    function  GetThemedBackColor: TColor;
    function  GetThemedTextColor: TColor;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;

    property  TabStop default True;
    property  ParentColor default False;
    property  ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property  ListObjects: TLMDDesignObjects read FListObjects write SetListObjects;
    property  Selection: TLMDDesignObjects read FSelection write SetSelection;
    property  ClassNameColor: TColor read FClassNameColor write SetClassNameColor default clGray;
    property  ShowClassName: Boolean read FShowClassName write SetShowClassName default True;
    property  ShowFocus: Boolean read FShowFocus write SetShowFocus default True;
    property  ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property  DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property  DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property  DropDownAlign: TLMDDropDownAlign read FDropDownAlign write FDropDownAlign default daLeft;
    property  SortDropDown: Boolean read FSortDropDown write FSortDropDown default True;
    property  DroppedDown: Boolean read GetDroppedDown;
    property  OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property  OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property  OnGetObjectNamePath: TLMDObjectComboBoxOnGetObjectNamePath read FOnGetObjectNamePath write FOnGetObjectNamePath;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SelectAll;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  { ************************** TLMDObjectComboBox **************************** }

  TLMDObjectComboBox = class(TLMDCustomObjectComboBox)
  public
    property DroppedDown;
  published
    property Align;
    property ServiceProvider;
    property ListObjects;
    property Selection;
    property ClassNameColor;
    property ShowClassName;
    property ShowFocus;
    property ReadOnly;
    property DropDownRows;
    property DropDownWidth;
    property DropDownAlign;
    property SortDropDown;
    property OnCloseUp;
    property OnDropDown;
    property OnGetObjectNamePath;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
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
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDUnicodeControl, LMDInsClass, LMDDsgModule;

type
  TPersistentAccess = class(TPersistent);


  {******************************** TObjsNotifier *****************************}

  TObjsNotifier = class(ILMDDsgObjsNotifier)
  private
    FComboBox: TLMDCustomObjectComboBox;
  public
    constructor Create(AComboBox: TLMDCustomObjectComboBox);
    procedure   Changed(ASender: TLMDDesignObjects); override;
  end;

{******************************* TObjsNotifier ********************************}
{---------------------------------- public ------------------------------------}

procedure TObjsNotifier.Changed(ASender: TLMDDesignObjects);
begin
  FComboBox.UpdateView;
end;

{ ---------------------------------------------------------------------------- }
constructor TObjsNotifier.Create(AComboBox: TLMDCustomObjectComboBox);
begin
  inherited Create;
  FComboBox := AComboBox;
end;

{ ************************** class TLMDPopupList ***************************** }
{ -------------------------------- private ----------------------------------- }
procedure TLMDPopupList.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPopupList.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  Height := Value * ItemHeight + GetBorderSize;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPopupList.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDPopupList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPopupList.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'LISTBOX');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPopupList.WndProc(var Message: TMessage);
var
  LI:       Integer;
  LWMMouse: TWMMouse;
begin
  case Message.Msg of
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN,
    WM_LBUTTONDBLCLK:
      ; // Do nothing (Do not call inherited to
        // prevent focus control changing).
    WM_LBUTTONUP,
    WM_MOUSEMOVE:
      begin
        LWMMouse := TWMMouse(Message);

        LI := ItemAtPos(Point(LWMMouse.XPos, LWMMouse.YPos), True);

        if (LI <> -1) and not FReadOnly then
          ItemIndex := LI;

        if Message.Msg = WM_LBUTTONUP then
          FComboBox.CloseUp((LI <> -1) and not FReadOnly);
      end;
  else
    inherited;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPopupList.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
end;

{ -------------------------------- public ------------------------------------ }
constructor TLMDPopupList.Create(AComboBox: TLMDCustomObjectComboBox);
begin
  FComboBox := AComboBox;
  inherited Create(AComboBox);

  ControlStyle := ControlStyle + [csNoDesignVisible];
  ParentColor  := False;
  FPopup       := True;
  RowCount     := 7;

  {$IFDEF _LMD_UNICODEIMPL}
  FItems := TLMDListBoxItems.Create(Self, inherited Items);
  {$ELSE}
  FItems := inherited Items;
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPopupList.Destroy;
begin
  inherited;
  {$IFDEF _LMD_UNICODEIMPL}
  FItems.Free;
  {$ENDIF}
end;

{ ********************* class TLMDCustomObjectComboBox *********************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDCustomObjectComboBox.SetClassNameColor(const Value: TColor);
begin
  if FClassNameColor <> Value then
    begin
      FClassNameColor := Value;
      Repaint;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetShowClassName(const Value: Boolean);
begin
  if FShowClassName <> Value then
    begin
      FShowClassName := Value;
      Repaint;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.StopTracking;
begin
  if FTracking then
    begin
      TrackButton(-1, -1);
      FTracking := False;
      MouseCapture := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
begin
  NewState := PtInRect(Rect(ClientWidth - FButtonWidth, 0, ClientWidth,
    ClientHeight), Point(X, Y));
  if FPressed <> NewState then
    begin
      FPressed := NewState;
      Repaint;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.WMKillFocus(var Message: TWMKillFocus);
begin
  FHasFocus := False;
  inherited;
  if FShowFocus then
    Invalidate;
  CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.WMSetFocus(var Message: TWMSetFocus);
begin
  FHasFocus := True;
  inherited;
  if FShowFocus then
    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FListVisible then
    begin
      CloseUp(Message.CharCode = VK_RETURN);
      Message.Result := 1;
    end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FPopupList) then
    CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Height := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  FPopupList.BiDiMode := BiDiMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and
     not (FMouseInControl) and
     not (csDesigning in ComponentState) then // Windows XP themes use hot
                                              // track states, hence we have to
                                              // update the drop down button.
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and FMouseInControl then
    begin
      FMouseInControl := False;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
  Height := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.UpdateView;
begin
  if FDestroying then
    Exit;

  if FSelection <> nil then
    FSelectedCountBuffer := FSelection.Count
  else
    FSelectedCountBuffer := 0;

  if FSelectedCountBuffer = 1 then
    FSelectedObjectBuffer := TPersistent(FSelection[0])
  else
    FSelectedObjectBuffer := nil;

  FListActive := (FSelection <> nil) and (FListObjects <> nil) and
                 (FListObjects.Count > 0);
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.PopupListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  PaintItem(FPopupList.Canvas, Rect, Rect.Left + 2, Rect.Top + 2,
    TPersistent(FPopupList.Items.Objects[Index]), False,
    odSelected in State, FHasFocus);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.PaintItem(ACanvas: TCanvas; ARect: TRect;
  AX, AY: Integer; AObject: TPersistent;
  AIsComboText, AIsSelected, AIsFocused: Boolean);
var
  LR: TRect;
  LTextWidth, LClassNameX: Integer;
  LOldColor, LClassNameColor: TColor;
  LNamePath, LClassName: TLMDString;
begin
  GetObjectNamePath(AObject, LNamePath, LClassName);

  LClassNameColor := ClassNameColor;
  if AIsSelected then
    LClassNameColor := clHighlightText;

  LR := ARect;
  LClassNameX := LR.Right;
  if FShowClassName then
  begin
    LClassNameX := (ARect.Left + ARect.Right) div 2;
    LTextWidth := ACanvas.TextWidth(LNamePath);
    if LTextWidth + 4 > LClassNameX then
      LClassNameX := LTextWidth + 4;
    if LClassNameX > ARect.Right then
      LClassNameX := ARect.Right;
  end;

  LR.Right := LClassNameX;
  LMDTextRect(ACanvas, LR, AX, AY, LNamePath);

  if FShowClassName then
  begin
    LOldColor := ACanvas.Font.Color;
    try
      ACanvas.Font.Color := LClassNameColor;
      LR := ARect;
      LR.Left := LClassNameX;
      LMDTextRect(ACanvas, LR, LR.Left, AY, LClassName);
    finally
      ACanvas.Font.Color := LOldColor;
    end;
  end;

  if (AIsSelected or (AIsComboText and not FListVisible)) and AIsFocused then
    ACanvas.DrawFocusRect(ARect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> Value then
    begin
      FShowFocus := Value;
      Repaint;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomObjectComboBox.GetDroppedDown: Boolean;
begin
  Result := FListVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetListObjects(
  const Value: TLMDDesignObjects);
begin
  if FListObjects <> Value then
  begin
    if (Value <> nil) and (Value = FSelection) then
      raise ELMDObjectComboBox.Create(SLMDObtCmBxSameCollections);

    if FListObjects <> nil then
    begin
      FListObjects.RemoveFreeNotification(Self);
      FListObjects.RemoveNotifier(TObjsNotifier(FListObjsNotifier));
    end;
    FListObjects := Value;
    if FListObjects <> nil then
    begin
      FListObjects.FreeNotification(Self);
      FListObjects.AddNotifier(TObjsNotifier(FListObjsNotifier));
    end;

    UpdateView;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetSelection(
  const Value: TLMDDesignObjects);
begin
  if FSelection <> Value then
  begin
    if (Value <> nil) and (Value = FListObjects) then
      raise ELMDObjectComboBox.Create(SLMDObtCmBxSameCollections);

    if FSelection <> nil then
    begin
      FSelection.RemoveFreeNotification(Self);
      FSelection.RemoveNotifier(TObjsNotifier(FSelnNotifier));
    end;
    FSelection := Value;
    if FSelection <> nil then
    begin
      FSelection.FreeNotification(Self);
      FSelection.AddNotifier(TObjsNotifier(FSelnNotifier));
    end;

    UpdateView;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetServiceProvider(
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

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation = opRemove then
  begin
    if AComponent = FListObjects then
      ListObjects := nil;
    if AComponent = FSelection then
      Selection := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomObjectComboBox.DoGetObjectNamePath(AObject: TPersistent;
  var ANamePath, AClassName: TLMDString);
begin
  if Assigned(OnGetObjectNamePath) then
    OnGetObjectNamePath(Self, AObject, ANamePath, AClassName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.DoDropDown;
begin
  if Assigned(OnDropDown) then
    OnDropDown(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.DoCloseUp;
begin
  if Assigned(OnCloseUp) then
    OnCloseUp(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomObjectComboBox.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.GetObjectNamePath(AObject: TPersistent;
  var ANamePath, AClassName: TLMDString);
var
  pownr: TPersistent;
  cur:   TComponent;
begin
  AClassName := AObject.ClassName;
  ANamePath  := AObject.GetNamePath;

  if AObject is TComponent then
    cur := TComponent(AObject)
  else
  begin
    pownr := TPersistentAccess(AObject).GetOwner;
    if (pownr <> nil) and (pownr is TComponent) then
      cur := TComponent(pownr)
    else
      cur := nil;
  end;

  if cur <> nil then
  begin
    cur := cur.Owner;

    while (cur <> nil) and LMDIsFrameCopy(cur) do
    begin
      ANamePath := cur.Name + '.' + ANamePath;
      cur    := cur.Owner;
    end;
  end;

  DoGetObjectNamePath(AObject, ANamePath, AClassName);
end;

function TLMDCustomObjectComboBox.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

function TLMDCustomObjectComboBox.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scComboBox)
  else
  {$ENDIF}
    Result := Color;
end;

function TLMDCustomObjectComboBox.GetThemedTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if Enabled or (csDesigning in ComponentState) then
      Result := StyleServices.GetStyleFontColor(sfComboBoxItemNormal)
    else
      Result := StyleServices.GetStyleFontColor(sfComboBoxItemDisabled);
  end
  else
  {$ENDIF}
  begin
    if Enabled or (csDesigning in ComponentState) then
      Result := Font.Color
    else
      Result := clGrayText;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if NewStyleControls and Ctl3D then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end
    else
      Style := Style or WS_BORDER;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.Paint;
var
  W, X, Flags: Integer;
  R:           TRect;
  State:       TThemedComboBox;
  Details:     TThemedElementDetails;
begin
  Canvas.Font        := Font;
  Canvas.Brush.Color := GetThemedBackColor;
  Canvas.Font.Color  := GetThemedTextColor;

  W := ClientWidth - FButtonWidth;
  X := 2;
  SetRect(R, 1, 1, W - 1, ClientHeight - 1);

  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    Inc(X, FButtonWidth);
    Inc(R.Left, FButtonWidth);

    R.Right := ClientWidth;
  end;

  if SysLocale.MiddleEast then
    TControlCanvas(Canvas).UpdateTextFlags;

  if FShowFocus and FHasFocus and not FListVisible then
  begin
    Canvas.Font.Color  := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;

  Canvas.FillRect(ClientRect);

  if FSelectedCountBuffer = 1 then
    PaintItem(Canvas, R, X, 2, FSelectedObjectBuffer, True,
              FShowFocus and FHasFocus and not FListVisible,
              FShowFocus and FHasFocus)
  else
  begin
    if FSelectedCountBuffer = 0 then
      LMDTextRect(Canvas, R, X, 2, SLMDObtCmBxNoObjectsSelected)
    else
      LMDTextRect(Canvas, R, X, 2,
                  Format(SLMDObtCmBxManyObjectsSelected,
                         [FSelectedCountBuffer]));

    if FShowFocus and FHasFocus and not FListVisible then
      Canvas.DrawFocusRect(R);
  end;

  SetRect(R, W, 0, ClientWidth, ClientHeight);
  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    R.Left := 0;
    R.Right:= FButtonWidth;
  end;

  if ThemeServices.ThemesEnabled then
  begin
    if not FListActive and not (csDesigning in ComponentState) then
      State := tcDropDownButtonDisabled
    else
      if FPressed then
        State := tcDropDownButtonPressed
      else
        if FMouseInControl and not FListVisible then
          State := tcDropDownButtonHot
        else
          State := tcDropDownButtonNormal;

    Details := ThemeServices.GetElementDetails(State);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);
  end
  else
  begin
    if not (FListActive and Enabled) and
       not (csDesigning in ComponentState) then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
    else if FPressed then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED
    else
      Flags := DFCS_SCROLLCOMBOBOX;
      
    DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FListActive and ((Key = VK_UP) or (Key = VK_DOWN)) then
    if ssAlt in Shift then
      begin
        if FListVisible then
          CloseUp(True)
        else
          DropDown;
        Key := 0;
      end else
      if FListVisible then
        begin
          case Key of
            VK_UP:
              if (FPopupList.ItemIndex > 0) then
                FPopupList.ItemIndex := FPopupList.ItemIndex - 1;
            VK_DOWN:
              if (FPopupList.ItemIndex < FPopupList.Items.Count - 1) then
                FPopupList.ItemIndex := FPopupList.ItemIndex + 1;
          end;
          Key := 0;
        end;
  if (Key <> 0) and FListVisible then
    FPopupList.KeyDown(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.KeyPress(var Key: Char);
begin
  if FListVisible then
    if AnsiChar(Key) in [#13, #27] then
      CloseUp(Key = #13)
    else
      FPopupList.KeyPress(Key);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      SetFocus;
      if not FHasFocus then Exit;
      if FListVisible then
        CloseUp(False)
      else
        if FListActive then
          begin
            MouseCapture := True;
            FTracking := True;
            TrackButton(X, Y);
            DropDown;
          end;
    end;
  inherited MouseDown(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  ListPos: TPoint;
begin
  if FTracking then
    begin
      TrackButton(X, Y);
      if FListVisible then
        begin
          ListPos := FPopupList.ScreenToClient(ClientToScreen(Point(X, Y)));
          if PtInRect(FPopupList.ClientRect, ListPos) then
            begin
              StopTracking;
              Exit;
            end;
        end;
    end;
  inherited MouseMove(Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomObjectComboBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csOpaque, csCaptureMouse, csDoubleClicks, csFixedHeight
                   {$IFDEF LMDCOMP7} ,csNeedsBorderPaint {$ENDIF}];
  FDestroying := False;
  FPopupList := TLMDPopupList.Create(Self);
  FPopupList.Visible := False;
  FPopupList.Parent := Self;
  FPopupList.Style := lbOwnerDrawFixed;
  FPopupList.OnDrawItem := PopupListDrawItem;
  FListObjsNotifier := TObjsNotifier.Create(Self);
  FSelnNotifier := TObjsNotifier.Create(Self);
  FDropDownRows := 7;
  FSortDropDown := True;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FListActive := False;
  FListVisible := False;
  FClassNameColor := clGray;
  FShowClassName := True;
  FShowFocus := True;
  ParentColor := False;
  ParentCtl3D := True;
  Width := 145;
  Height := 0;
  TabStop := True;

  LMDRegisterComponentChangeNotification(Self, CompsChangeNotification);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomObjectComboBox.Destroy;
begin
  ServiceProvider := nil;
  ListObjects     := nil;
  Selection       := nil;

  inherited;

  FDestroying := True; // Prevents ObjectsChanged activity, while
                       // object lists destruction.
  FListObjsNotifier.Free;
  FSelnNotifier.Free;
  
  LMDUnregisterComponentChangeNotification(Self);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomObjectComboBox.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.CloseUp(Accept: Boolean);
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then
      LMDSendMessage(GetCapture, WM_CANCELMODE, 0, 0);

    if Accept and (FSelection <> nil) and
       (FPopupList.ItemIndex <> -1) then
    begin
      FSelection.SetOne(TPersistent(FPopupList.Items.Objects[
        FPopupList.ItemIndex]));
    end;

    SetFocus;
    SetWindowPos(FPopupList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    Repaint;

    DoCloseUp;
    if Accept then
      Click;
  end;
end;

{ ---------------------------------------------------------------------------- }
function DropListQSCompare(AItemIndex1, AItemIndex2: Integer;
  AData: TLMDDataTag): Integer;
var
  cb:       TLMDCustomObjectComboBox;
  nm1, cn1: TLMDString;
  nm2, cn2: TLMDString;
begin
  cb := TLMDCustomObjectComboBox(AData);

  cb.GetObjectNamePath(TPersistent(cb.FPopupList.Items.Objects[AItemIndex1]),
                       nm1, cn1);
  cb.GetObjectNamePath(TPersistent(cb.FPopupList.Items.Objects[AItemIndex2]),
                       nm2, cn2);

  Result := CompareText(nm1, nm2);
end;

{ ---------------------------------------------------------------------------- }
procedure DropListQSExchange(AItemIndex1, AItemIndex2: Integer;
  AData: TLMDDataTag);
var
  cb: TLMDCustomObjectComboBox;
begin
  cb := TLMDCustomObjectComboBox(AData);
  cb.FPopupList.Items.Exchange(AItemIndex1, AItemIndex2);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomObjectComboBox.DropDown;
var
  P: TPoint;
  Y: Integer;
  ADropDownAlign: TLMDDropDownAlign;
  LI: Integer;
begin
  if not FListVisible and FListActive then
  begin
    DoDropDown;

    FPopupList.Color := Color;
    FPopupList.Font := Font;
    FPopupList.Canvas.Font := Font;
    FPopupList.ItemHeight := FPopupList.Canvas.TextHeight('Wg') + 2;
    if FDropDownWidth > 0 then
      FPopupList.Width := FDropDownWidth else
      FPopupList.Width := Width;

    FPopupList.Items.BeginUpdate;
    try
      FPopupList.Items.Clear;

      if FListObjects <> nil then
      begin
        for LI := 0 to FListObjects.Count - 1 do
          FPopupList.Items.AddObject('', FListObjects[LI]);

        if FSortDropDown then
          LMDQuickSort(0, FPopupList.Items.Count - 1, DropListQSCompare,
                       DropListQSExchange, Self);
      end;

      if FSelectedCountBuffer = 1 then
      begin
        LI := FPopupList.Items.IndexOfObject(FSelectedObjectBuffer);
        FPopupList.ItemIndex := LI;
      end
      else
        FPopupList.ItemIndex := -1;
    finally
      FPopupList.Items.EndUpdate;
    end;

    FPopupList.ReadOnly := FReadOnly;

    if (FListObjects <> nil) and
       (FDropDownRows > FListObjects.Count) then
      FPopupList.RowCount := FListObjects.Count
    else
      FPopupList.RowCount := FDropDownRows;

    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FPopupList.Height > Screen.Height then
      Y := P.Y - FPopupList.Height;
    ADropDownAlign := FDropDownAlign;
    if Self.UseRightToLeftAlignment then
    begin
      if ADropDownAlign = daLeft then
        ADropDownAlign := daRight
      else if ADropDownAlign = daRight then
        ADropDownAlign := daLeft;
    end;
    case ADropDownAlign of
      daRight:  Dec(P.X, FPopupList.Width - Width);
      daCenter: Dec(P.X, (FPopupList.Width - Width) div 2);
    end;
    SetWindowPos(FPopupList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);

    FListVisible := True;
    Repaint;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
  LHeight: Integer;
begin
  LHeight := GetTextHeight + GetBorderSize + 4;
  inherited SetBounds(ALeft, ATop, AWidth, LHeight);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomObjectComboBox.SelectAll;
begin
  if (FListObjects <> nil) and (FSelection <> nil) then
    FSelection.CopyFrom(FListObjects);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPopupList.SetItems(const Value: TLMDStrings);
begin
  FItems.Assign(Value);
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDCustomObjectComboBox.CompsChangeNotification(Sender: TObject;
  AChangedComps: TList);
var
  comps: TList;
begin
  if Sender = Self then
    Exit;

  comps := TList.Create;
  try
    if FListObjects <> nil then
      FListObjects.GetItems(comps);

    LMDTransformToCompList(comps);
    if LMDHasCommonItems(AChangedComps, comps) then
      Repaint;
  finally
    comps.Free;
  end;
end;
      
{ ---------------------------------------------------------------------------- }

end.
