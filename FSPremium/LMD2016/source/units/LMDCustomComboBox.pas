unit LMDCustomComboBox;
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

LMDCustomComboBox unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  StdCtrls, Classes, Controls, Messages, Windows, Graphics, ExtCtrls, SysUtils,
  Themes,
  LMDClass, LMDBase, LMDVldBase, LMDTypes, LMDThemedComboBox;

const
  defHeight=16;
  defBufferHeight=10;

type
  {------------------------- TLMDCustomComboBox -------------------------------}
  TLMDCustomComboBox = class(TLMDThemedComboBox, ILMDValidatedControl)
  private
    FTimerId     : TLMDTimer;
    FOnSelect    : TNotifyEvent;
    FFocused,
    FKeyed,
    FSearch,
    FRepaint,
    FFlat        : Boolean;
    FWidth,
    FTimerInterval: Integer;
    FFocusCtrl   : TWinControl;
    FMRUCount,
    FMRUMax      : Integer;
    FMRUList     : Boolean;
    FOnEditClick : TNotifyEvent;
    FUseGlobalTimer: Boolean;
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetSearch (aValue : Boolean);
    procedure SetInteger (index, aValue : Integer);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure WMPaint (var Msg : TWMPaint); message WM_PAINT;
    procedure WMLButtonDown (var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMThemeChanged (var Msg : TMessage); message WM_THEMECHANGED;
    procedure CMEnter (var Message : TCMEnter); message CM_ENTER;
    procedure CMExit (var Message : TCMExit); message CM_EXIT;
    procedure RepaintBorder;
    procedure DoTimerEvent (Sender : TObject);
    procedure CreateTimer;
    procedure FreeTimer;
    procedure ExitCtrl;
    function  GetTopParentHandleFocusCtrl : HWnd;
  protected
    //Validation support, May 2006, RS
    FValidator: TLMDValidationEntity;
    FValidationMsgString: TLMDString;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    FValidatedValue: TLMDValidatedListValue;

    //Validation support, May 2006, RS
    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString;
    procedure PaintSeparatorLine (aRect : TRect; index : Integer);
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    procedure DrawItem(Index:Integer; Rect:TRect; State:TOwnerDrawState);override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DoSelect; virtual;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure Change; override;
    procedure Loaded; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    //Validation support, May 2006, RS
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;
    function isMRUItem (index : Integer) : Boolean;
    property Flat : Boolean index 0 read FFlat write SetBoolean default false;
    property Search : Boolean read FSearch write SetSearch default false;
    property FocusControl:TWinControl read FFocusCtrl write FFocusCtrl;
    //4.01
    property Interval : Integer read FTimerInterval write FTimerInterval default 1500;
    property DropDownWidth : Integer index 0 read FWidth write SetInteger default 0;
    //----
    property MRUList : Boolean index 1 read FMRUList write SetBoolean default false;
    property MRUMax : Integer index 1 read FMRUMax write SetInteger default 5;
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
    property OnEditClick : TNotifyEvent read FOnEditClick write FOnEditClick;
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
  published
    //Validation support, May 2006, RS
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property ValidatedValue: TLMDValidatedListValue read FValidatedValue write FValidatedValue default vlvText;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
  uses dialogs;
  {$I C2.INC}
{$ENDIF}
{**************************** Class TLMDCustomComboBox ************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDCustomComboBox.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FFlat then
          begin
            FFlat := aValue;
            RepaintBorder;
          end;
    1 : if aValue <> FMRUList then
          begin
            FMRUList := aValue;
            if not FMRUList and (FMRUCount <> 0) then //there are mru fonts in the list
              begin //removing them
                while FMRUCount > 0 do
                  begin
                    Items.Delete (0);
                    dec (FMRUCount);
                  end;
              end;
            if MRUList then
              Style := csOwnerDrawFixed;
          end;

  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.SetSearch (aValue : Boolean);
begin
  if aValue <> FSearch then
    begin
      FSearch := aValue;
      if not Sorted then
        Sorted := true;
//      if FSearch and not (csDesigning in ComponentState) then
        {$IFDEF LMD_TOOLS}
//        LMDApplication.Timer [FTimerId].Enabled := false;
        {$ELSE}
        //FTimer.Enabled := false;
        {$ENDIF}
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomComboBox.SetInteger (index, aValue : Integer);
begin

  case index of
    0 : if aValue <> FWidth then
          begin
            FWidth := aValue;
            PostMessage (self.Handle, CB_SETDROPPEDWIDTH, FWidth, 0);
          end;
    1 : if aValue <> FMRUMax then
          begin
            FMRUMax := aValue;

            while FMRUMax < FMRUCount do
              begin
                Items.Delete (FMRUCount);
                dec (FMRUCount);
              end;

          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomComboBox.GetTopParentHandleFocusCtrl: HWnd;
var
  C: TWinControl;
begin
  C := FFocusCtrl;
  while C.Parent <> nil do
    C := C.Parent;
  Result := C.ParentWindow;
  if Result = 0 then Result := C.Handle;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.PaintSeparatorLine (aRect : TRect; index : Integer);
begin
  if (DroppedDown) and (FMRUList) and (FMRUCount-1 = Index) and (Canvas.ClipRect.Bottom > self.Height) then
    begin
      Canvas.Pen.Color := clBlack;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Width := 0;
      Canvas.MoveTo (aRect.Left, aRect.Bottom - 3);
      Canvas.LineTo (aRect.Right, aRect.Bottom - 3);
      Canvas.MoveTo (aRect.Left, aRect.Bottom-1);
      Canvas.LineTo (aRect.Right, aRect.Bottom-1);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CNCommand(var Message: TWMCommand);
var
  i : Integer;
  ai : boolean;
begin
  inherited;

  if message.NotifyCode = CBN_SELCHANGE then
    begin
      DoSelect;

      begin
        if FMRUList then
          begin
            ai := false;
            i := 0;
            //font already stored?
            while (i < FMRUCount-1) and (Items[i] <> Items[ItemIndex]) do
              inc(i);
            if (Items[i] = Items[ItemIndex]) and (FMRUCount <> 0) {avoid problems with first entry}then
              begin
                ItemIndex := i;
                ai := true;
              end;

            if not ai then
              begin

                // if we reached stored limit delete oldest entry
                if (FMRUMax = FMRUCount) then
                  Items.Delete (FMRUMax-1)
                else //we can store this font, increment stored counter
                  inc (FMRUCount);

                //insert object
                Items.Insert(0, Items[ItemIndex]);
                Items.Objects[0] := Items.Objects[ItemIndex];
                ItemIndex := 0;
              end;
          end;
      end;

      if not DroppedDown and not FKeyed then
        if FFocusCtrl <> nil then
          begin
            if (GetTopParentHandle <> GetTopParentHandleFocusCtrl) then
              begin
                FFocused := false;
                PostMessage (FFocusCtrl.ParentWindow, WM_SETFOCUS, 0 ,0);
                PostMessage (FFocusCtrl.Handle, WM_SETFOCUS, 0 ,0)
              end
            else
              FFocusCtrl.SetFocus;
            ExitCtrl;
            //FFocusCtrl.SetFocus;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then exit;
  // --
  //FMouseAbove := true;
  if (not FFlat) or (Focused) then exit;
  RepaintBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CMMouseLeave(var Message : TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then exit;
  // --
  //FMouseAbove := false;
  if (not FFlat) or (Focused) or (DroppedDown) or (FFocused) then exit;
  RepaintBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CMEnter(var Message : TCMEnter);
begin
  inherited;
  RepaintBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CMExit(var Message : TCMExit);
begin
  inherited;
  ExitCtrl;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.ExitCtrl;
begin
  if (not MouseAbove) and (not FFocused) then
    begin
      FRepaint := true;
      RepaintBorder;
      FRepaint := false;
    end;
  if FSearch then FreeTimer;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.WMPaint (var Msg : TWMPaint);
begin
  inherited;
  //do not call the border draw method on using WinXP:
  //windows will automatically draw correct control border
  if not IsThemed then RepaintBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.WMLButtonDown (var Msg : TWMLButtonDown);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.WMThemeChanged (var Msg : TMessage);
begin
  inherited;
  //Will only occur if someone uses WinXP and changes the theme while the app
  //is running.
  // Delphi 2k7 fix
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  RecreateWnd;
  Msg.result:=1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);

begin
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
  if ComboWnd = EditHandle then
    with Message do
      case Msg of
        WM_LBUTTONDOWN: if Assigned (FOnEditCLick) then FOnEditClick (self);
        WM_SETFOCUS:    FFocused := true;
        WM_KILLFOCUS:   FFocused := false;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  FKeyed := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.KeyDown (var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown (Key, Shift);
  if Assigned(FTimerID) then
    FTimerId.Enabled := false
  else
    CreateTimer;

  if (Key >= 32) {(isCharAlpha(Char(Key)))} and FSearch then
    begin
      FTimerId.Interval := FTimerInterval;
      FTimerId.Enabled := true;
    end;
  if (Key in [VK_DELETE, VK_BACK]) and FSearch then
    begin
      //something deleted - some more time to enter something new
      FTimerId.Interval := FTimerInterval + 1000;
      FTimerId.Enabled := true;
    end;
  if (Key in [VK_DOWN, VK_UP, VK_LEFT, VK_RIGHT, VK_NEXT, VK_PRIOR]) then
    FKeyed := true
  else
    FKeyed := false;
  //Return will set the focus to the given Control
  if (Key = VK_RETURN) then
    if FFocusCtrl <> nil then
      begin
        if (GetTopParentHandle <> GetTopParentHandleFocusCtrl) then
          begin
            FFocused := false;
            PostMessage (FFocusCtrl.Handle, WM_SETFOCUS, 0 ,0)
          end
        else
          FFocusCtrl.SetFocus;
        ExitCtrl;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.RepaintBorder;
var
  DC : HDC;
  aRect : TRect;
  BrushFrame,
  BrushBtnFace,
  BrushWindow : HBrush;
begin
  if IsThemed then exit; //XP will handle complete border drawing

  BrushBtnFace := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  BrushWindow := CreateSolidBrush(GetSysColor(COLOR_WINDOW));
  BrushFrame := CreateSolidBrush(GetSysColor(COLOR_WINDOWFRAME));
  DC := GetWindowDC (Handle);
  try
    //retrieves screen coordinates
    GetWindowRect (Handle, aRect);
    //"moves" rect to (0,0)
    OffsetRect (aRect, -aRect.Left, -aRect.Top);
    if ((csDesigning in ComponentState) or (not Flat) or (MouseAbove) or (Focused) or (FFocused)) and not (FRepaint and Flat) then
      begin
        inc(aRect.Left, 1);
        inc (aRect.Top);
        FrameRect (DC, aRect, BrushFrame);
        dec(aRect.Top);
        dec(aRect.Left, 1);

        dec (aRect.Bottom);
        dec (aRect.Right);
        FrameRect (DC, aRect, BrushBTNFACE);
        inc (aRect.Right);
        inc (aRect.Bottom);

        DrawEdge (DC, aRect, BDR_SUNKENOUTER, BF_ADJUST or BF_RECT);

      end
    else
      begin
        FrameRect (DC, aRect, BrushBtnFace);
        InflateRect (aRect, -1, -1);
        FrameRect (DC, aRect, BrushBtnFace);
        InflateRect (aRect, -1, -1);
        FrameRect (DC, aRect, BrushWindow);
      end;
  finally
    ReleaseDC(Handle, DC);
    DeleteObject (BrushFrame);
    DeleteObject (BrushWindow);
    DeleteObject (BrushBtnFace);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.DoTimerEvent (Sender : TObject);
var
  i, j : LongInt;
begin
  if not Sorted then exit;
  i := 0;
  while (Copy (Items[i], 1 , Length(Text)) <> Text) and (i < Items.Count) do
    inc(i);
  if (i < Items.Count) and (Copy (Items[i], 1 , Length(Text)) = Text) then
    begin
      j := SelStart;
      ItemIndex := i;
      SelStart := j;
      SelLength := Length(Text) - j;
    end;
  //everthing is done up to the next keystroke (which will enable the timer again)
  FreeTimer;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.CreateTimer;
begin
  if Assigned(FTimerId) then exit;
  FTimerId := TLMDTimer.Create(FTimerInterval, DoTimerEvent, false, FUseGlobalTimer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.FreeTimer;
begin
  if not Assigned(FTimerId) then exit;
  FreeAndNil(FTimerID);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.Change;
begin
  //Validation support, May 2006, RS
   if Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
  inherited Change;
end;

{---------------------- protected ---------------------------------------------}
procedure TLMDCustomComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FFocusCtrl) then
    FFocusCtrl := nil;
  //Validation support, May 2006, RS
  if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
    Self.SetValidator(nil);
  inherited Notification (AComponent, Operation);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  inherited DrawItem(Index, Rect, State);
  PaintSeparatorLine(Rect, Index);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  inherited MeasureItem (Index, Height);
  Height := ItemHeight;
  if MRUList then
    inc(Height, 4);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.DoSelect;
begin
  if Assigned (FOnSelect) then FOnSelect(self);
  //Validation support, added May, 2006 (RS)
  if  Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
end;

{ ------------------------------------ public -------------------------------- }
constructor TLMDCustomComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FFlat    := false;
  FRepaint := false;
  FSearch  := false;
  FFocused := false;
  FFocusCtrl := nil;
  FTimerInterval := 1500;
  FWidth := 0;
  FMRUList := false;
  FMRUMax := 5;
  FMRUCount := 0;
//  FXP := true;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomComboBox.Destroy;
begin
  FreeTimer;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.Loaded;
begin
  inherited Loaded;
  //added 00/05/18;JH
  PostMessage (self.Handle, CB_SETDROPPEDWIDTH, FWidth, 0);
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.isMRUItem (index : Integer) : Boolean;
begin
  //item = MRU item iff its index (0 based) < count of MRU items (MRU items always at top)
  result := index < FMRUCount;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetControl: TControl;
begin
  Result := Self;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetValueToValidate: TLMDString;
begin
  case Self.ValidatedValue of
    vlvText:  Result := Self.Text;
    vlvIndex: Result := IntToStr(Self.ItemIndex);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComboBox.SetValidator(Validator: TLMDValidationEntity);
begin
  if Self.FValidator = Validator then Exit;
//  if Assigned(Self.FValidator) then
//    Self.FValidator.ReleaseControl(Self);
  Self.FValidator := Validator;
  if Assigned(Self.FValidator) then
  begin
    Validator.FreeNotification(Self);
//    Self.FValidator.AcceptControl(Self);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComboBox.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
