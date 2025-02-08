unit LMDCustomExtCombo;
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

LMDCustomExtCombo unit (JH)
---------------------------

Edit control which will popup a drop down control if the down button is pressed

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls,
  LMDButtonBase, LMDBaseEdit, LMDCustomMaskEdit;

type
  TLMDDropDownStyle = (csDropDown, csDropDownList);
  TLMDAllowDropEvent=procedure(Sender:TObject; var AllowDrop:Boolean) of object;

  TLMDCustomExtCombo = class(TLMDCustomMaskEdit)
  private
    FDroppedDown       : Boolean;
    FDropDownHeight,
    FDropDownWidth     : Integer;
    FOnCanDropDown     : TLMDAllowDropEvent;
    FOnBeforeDropDown,
    FOnDropDownAccept,
    FOnDropDownCancel,
    FOnDropDown        : TNotifyEvent;
    FOldControlProc    : TWndMethod;
    FAllowDownKey      : Boolean;
    FDropDownStyle     : TLMDDropDownStyle;
    procedure SetBoolean (aValue : Boolean);
    procedure SetDropDownStyle (aValue: TLMDDropDownStyle);
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKEYDown (var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMSYSKEYDOWN (var Msg : TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMKEYUP (var Msg : TWMKeyUp); message WM_KEYUP;
    procedure WMCHAR (var Msg : TWMChar); message WM_CHAR;
    procedure WMKillFocus (var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMCancelMode (var Msg: TWMCancelMode); message WM_CANCELMODE;
  protected
    FControl : TWinControl;
    FItemIndex: integer;
    FClickHandled: boolean;                 //JH March 2002


    procedure AdjustDropDownPosition(var P: TPoint); virtual;
    // 7.0
    procedure NewControlProc(var Msg: TMEssage);
    // ---

    // 7.1
    function GetListMode:Boolean; override;
    procedure DrawSpecialTextBackground (aCanvas: TCanvas; aRect: TRect); override; //JH March 2002
    // ---

    procedure CreateAndSetup;
    procedure DoDropDownClick (Sender : TObject);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter; override;

    procedure DoBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure DropDown; dynamic;
    procedure DoThemeChanged;override;
    procedure CreateControl; virtual; abstract;
    //called to modify the control if its created
    procedure ModifyControl; virtual;
    //called to modify control if it was already created
    procedure ReModifyControl; virtual;
    //this method can be used for (temporaly) prevent the control for being dropped down
    function CanDropDown: Boolean; virtual;
    procedure DisplayControl; virtual;
    procedure BeforeDropDown; virtual;
    procedure Cancel; virtual;
    procedure Accept; virtual;
    procedure Loaded; override;
    procedure CheckModified; virtual;

    function GetControl : TWinControl; virtual;
    procedure DoDownKey; virtual;
    procedure DoUpKey; virtual;
    // if enabled, Downkey processing (opening dropdown is disabled)
    property AllowDownKey:Boolean read FAllowDownKey write FAllowDownKey;
    property Style: TLMDDropDownStyle read FDropDownStyle write SetDropDownStyle default csDropDown;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    // 6.1 - use Open to drop down combo at runtime
    procedure Open;virtual;
    // 7.00.60 - use close method to close drop down window. acc parameter decides
    //           whether OnDropDownAccept or OnDropDownCancel is generated
    procedure Close (acc : boolean=false);
    // -------
    procedure Init;virtual;
    property DroppedDown : Boolean read FDroppedDown write SetBoolean default false;
    property Control : TWinControl read GetControl;
    property DropDownWidth : Integer read FDropDownWidth write FDropDownWidth default 0;
    property DropDownHeight : Integer read FDropDownHeight write FDropDownHeight default 0;
  published
    property Alignment;
    property CustomButtonsStyle default ubsCombo;
    property CustomButtonWidth;
    property OnDropDown : TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnAllowDropDown:TLMDAllowDropEvent read FOnCanDropDown write FOnCanDropDown;
    // 7.00.60
    property OnBeforeDropDown:TNotifyEvent read FOnBeforeDropDown write FOnBeforeDropDown;
    property OnDropDownAccept:TNotifyEvent read FOnDropDownAccept write FOnDropDownAccept;
    property OnDropDownCancel:TNotifyEvent read FOnDropDownCancel write FOnDropDownCancel;
    property Options;
  end;

implementation

uses
  Types,
  LMDGraph;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.SetBoolean (aValue : Boolean);
begin
  if aValue <> FDroppedDown then
    begin
      {CH if FDroppedDown then //ShowWindow (SW_HIDE)
        begin
        end;}

      FDroppedDown:= aValue;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.SetDropDownStyle (aValue: TLMDDropDownStyle);
begin
  if aValue <> FDropDownStyle then
    begin
      FDropDownStyle := aValue;
      if FDropDownStyle = csDropDownList then
        begin
          EnableKeyInput := false;
          Caret.Disable;
          Caret.CanEnable := false;
        end
      else
        begin
          EnableKeyInput := true;
          Caret.CanEnable := true;
          Caret.Enable;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMKEYDown (var Msg : TWMKeyDown);
begin
  if not DroppedDown then
    case Msg.CharCode of
      VK_DOWN   :
        if AllowDownKey then
          DoDownKey
        else
          DoDropDownClick (self);
      VK_UP     : DoUpKey;
      VK_F4     : DoDropDownClick(self);
    end
  else
    if Assigned(FControl) then

      with TMessage(Msg) do
        FControl.Perform(Msg, wParam, lParam);

//        SendMessage (FControl.Handle, Msg, wParam, lParam);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMSYSKEYDOWN (var Msg : TWMSysKeyDown);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMKEYUP (var Msg : TWMKeyUp);
begin
  if DroppedDown then
    begin
      (*case Msg.CharCode of     //VB June 2008: removed
        VK_DOWN   : DoDownKey;   //due to LMDDBListComboBox extra scroll issue
        VK_UP     : DoUpKey;     //(rept news 12 June 2008 by Alan Hartman)
      end*)
    end
  else
    if Assigned(FControl) then

      with TMessage(Msg) do
        FControl.Perform(Msg, wParam, lParam);

(*    with TMessage(Msg) do
      if Assigned(FControl) then
        SendMessage (FControl.Handle, Msg, wParam, lParam);*)
//-->
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMCHAR (var Msg : TWMChar);
begin
  if DroppedDown then
    begin
      if Assigned(FControl) then

      with TMessage(Msg) do
        FControl.Perform(Msg, wParam, lParam);

      case Msg.CharCode of
        VK_RETURN : Close (true);
        VK_ESCAPE, VK_CANCEL:
          begin
            Close (false);
            FClickHandled:=false;
          end;
      end;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMKillFocus (var Msg : TWMKillFocus);
begin
  if DroppedDown then
    Close (false);
  FClickHandled := false;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.CMCancelMode(var Message: TCMCancelMode);
begin
  if Assigned (Message.Sender) and (Message.Sender <> Self) and (Message.Sender <> FControl) and (Message.Sender.Parent <> FControl)
    and (Message.Sender <> CustomButtons.Items[0].Btn) then
    begin                                                                             
      Close(False);
      FClickHandled := false;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMCancelMode (var Msg: TWMCancelMode);
begin
  if DroppedDown then
    Close (false);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.AdjustDropDownPosition(var P: TPoint);
begin
  //do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.NewControlProc(var Msg: TMEssage);
begin
  FOldControlProc(Msg);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.CreateAndSetup;
begin
  CreateControl; //in descendant FControl := TControlClass.Create (self);
  FControl.Visible := false;
  FControl.Parent := self;
  FOldControlProc:=FControl.WindowProc;
  FControl.WindowProc:=NewControlProc;
  ModifyControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoThemeChanged;
begin
  inherited;
  CustomButtons.Items[0].Btn.ThemeMode := self.ThemeMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoDropDownClick (Sender : TObject);
var
  p : TPoint;
  h : HWND;
begin
  //JH May 2002
  //If control is currently protected for being dropped down
  //(e.g. becuase it's a db combo and not yet connected to a db field)
  //get out
  if not CanDropDown then exit;

  //JH March 2002
  //we have already handled this mouse click (closed the window)
  if FClickHandled then
    begin
      FClickHandled := false;
      exit;
    end;

  if FDroppedDown then
    begin
      Close(false);
      exit;
    end;

  SetFocus;

  BeforeDropDown;

  DroppedDown := true;

  //create control
  if FControl = nil then
    CreateAndSetup
  else
    ReModifyControl;

  p := Point(0, Height - 1 {-2});  //enabled and we will have a popup ignoring from border otherwise we will have a focusable popup
  AdjustDropDownPosition(p);
  p := ClientToScreen (p);

  // if ComboBox extents Screen.Height, pop up above control
  if p.Y+FControl.Height>Screen.Height then
    begin
      p.Y:=p.Y - Height {+ 2} - FControl.Height;
      if IsThemed then inc(p.y);
    end;

  // and one more check...
  if FControl.Height<=4 then // no items there?
    FControl.Height:=Canvas.TextHeight ('Wq')+2;

  DropDown;

  //set window params
//      WindowClass.Style := CS_SAVEBITS;
  Windows.SetParent(FControl.Handle, GetDesktopWindow);

  SetWindowLong(FControl.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
  SetWindowLong(FControl.Handle, GWL_STYLE, GetWindowLong (FControl.Handle, GWL_STYLE) or WS_BORDER);

  //set window position
  //  h := HWND_TOP;//MOST; replaced by line down, JH March 2001 (there was a problem concerning top most windows)
  h := HWND_TOPMOST;
  //added SWP_NOSIZE Dec 2001
  SetWindowPos(FControl.Handle, h, p.x, p.y, FControl.Width, FControl.Height,
               SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);

  //show control
  FControl.Visible := true;

  DisplayControl;

  //create hook for mouse events (for getting aware of clicks outside the popup control)
(*  if mouseHook = 0 then
    mouseHook := SetWindowsHookEx(WH_MOUSE, @mouseEvents, HInstance, 0{GetCurrentThreadID});*)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if DroppedDown then      //mouse down in edit field (close popup control)
    begin
      Close (false);
      FClickHandled := false; //correct value ...
    end;
  inherited MouseDown (Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.MouseEnter;
begin
  inherited MouseEnter;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FDroppedDown then
    begin
      Close (false);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DrawSpecialTextBackground (aCanvas: TCanvas; aRect: TRect);
begin
  if (Style <> csDropDownList) or not Focused then exit; //we do not need this ...
  with aCanvas do
    begin
      InflateRect (aRect, -1, -1);
      Brush.Color := clSilver;
      Brush.Style := bsSolid;
      FillRect (aRect);
      DrawFocusRect (aRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtCombo.GetListMode:Boolean;
begin
  result:=FDropDownStyle=csDropDownList;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Close (acc : boolean);
begin
  if not DroppedDown then exit;

  if not acc then
    FClickHandled := true; //mark the mouse click as "handled",   //JH March 2002

  //if popup control was focused we could have lost the "real" focus
  SetFocus;

  if acc then Accept else Cancel;

  SetWindowPos(FControl.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);

//  UnhookWindowsHookEx (mouseHook);
//  mouseHook := 0;

  FControl.Visible := False;

  DroppedDown := false;

  If GetCapture=Handle then
    ReleaseCapture;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DropDown;
begin
  if Assigned (FOnDropDown) then FOnDropDown (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.ModifyControl;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.ReModifyControl;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtCombo.CanDropDown: Boolean;
begin
  result := true;
  if Assigned(FOnCanDropDown) then
    FonCanDropDown(self, result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DisplayControl;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.BeforeDropDown;
begin
  if Assigned(FOnBeforeDropDown) then
    FOnBeforeDropDown(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Cancel;
begin
  if Assigned(FOnDropDownCancel) then
    FOnDropDownCancel(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Accept;
begin
  if Assigned(FOnDropDownAccept) then
    FOnDropDownAccept(self);
  CheckModified;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDCustomExtCombo.ComboWndProc(var Message: TMessage);
begin
  Message.Result := CallWindowProc (FComboOldWndProc, self.Handle, Message.Msg, Message.wParam, Message.lParam);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomExtCombo.GetControl : TWinControl;
begin
  result := FControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Init;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoDownKey;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.DoUpKey;
begin
end;

{ ----------------------------- public --------------------------------------- }
constructor TLMDCustomExtCombo.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);

  FMaskType := meNone;
  FClickHandled := false; //JH March 2002
  FDropDownStyle := csDropDown;

  //just add our drop down button
  CustomButtons.Add;
  BeginUpdate;
  inherited CustomButtonsStyle:=ubsCombo;
  EndUpdate;
  CustomButtons.Items[0].Btn.Style:=ubsCombo;
  CustomButtons.Items[0].Btn.ThemeMode := FThemeMode;

  CustomButtons.Items[0].Btn.ButtonLayout.Arrow := true;
  CustomButtons.Items[0].Btn.ButtonLayout.ArrowSize := 4;
  CustomButtons.Items[0].Btn.ButtonLayout.ArrowIndent := 0;

  CustomButtons.Items[0].Btn.OnClick := DoDropDownClick;
  CustomButtons.Items[0].Btn.OnMouseDown := DoBtnMouseDown;
  CustomButtons.Items[0].Btn.OnMouseUp := DoBtnMouseUp;

  FDropDownWidth := 0;
  FDropDownHeight := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomExtCombo.Destroy;
begin
  FreeAndNil(FControl);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Loaded;
begin
  inherited Loaded;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.Open;
begin
  DoDropDownClick(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomExtCombo.CheckModified;
begin
  if FOldText <> FText then
    Modified := true;
end;

initialization

end.

