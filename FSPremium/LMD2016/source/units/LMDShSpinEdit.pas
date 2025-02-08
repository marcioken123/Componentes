unit LMDShSpinEdit;
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

LMDSHSpinEdit unit (RM)
----------------------
Common control for all Packs / used at Designtime

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Menus, Messages, Classes, Graphics, Controls, Forms,
  Stdctrls, Extctrls;

type

  {************************* TLMDSHSpinEdit ***********************************}
  TLMDShSpinEdit = class(TCustomEdit)
  private
    FAlignment : TAlignment;
    FMinValue,
    FMaxValue,
    FLineSize,
    FPageSize:LongInt;
    FSize:Byte;
    FEditorEnabled:Boolean;
    FButton: Pointer;
    FSuffix:String;
    FButtonWin: TWinControl;
    procedure SetEditRect;
    procedure SetInteger(Index:Integer; aValue:LongInt);
    procedure SetInterval(aValue:Word);
    procedure SetSize(aValue:Byte);
    procedure SetSuffix(aValue:String);
    procedure SetValue(aValue:LongInt);
    procedure SetAlignment(aValue:TAlignment);
    function GetInterval:Word;
    function GetMinHeight: Integer;
    function GetValue: LongInt;
    procedure AdjustSizeLMD;
    function CheckValue(aValue:LongInt):LongInt;

    procedure CMEnabledChanged(var Msg:TMessage); message CM_EnabledChanged;
    procedure CMEnter(var Message: TCMGOTFOCUS);message CM_ENTER;
    procedure CMExit(var Message: TCMExit);message CM_EXIT;
    procedure WMCut(var Message: TWMCut);message WM_CUT;
    procedure CMTextChanged(var Msg:TMessage); message CM_TextChanged;
    procedure WMPaste(var Message: TWMPaste);message WM_PASTE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DownClick (Sender: TObject); virtual;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure UpClick (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: Pointer read FButton;
    published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Interval:Word read GetInterval write SetInterval default 100;
    property LineSize:LongInt index 2 read FLineSize write SetInteger default 1;
    property MaxValue:LongInt index 0 read FMaxValue write SetInteger default 100;
    property MinValue:LongInt index 1 read FMinValue write SetInteger default 0;
    property PageSize:LongInt index 3 read FPageSize write SetInteger default 10;
    property Suffix:String read FSuffix write SetSuffix;
    property TriangleSize:Byte read FSize write SetSize default 3;

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Value: LongInt read GetValue write SetValue default 0;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnMouseWheelDown;
    Property OnMouseWheelUp;

  end;

implementation
uses
  Themes, LMDUtils;

type
  {data types}
  TLMDSpinButtonState = (sbUp, sbTopDown, sbBottomDown, sbDisabled);

  {****************************** Component ***********************************}
  {---------------------------- TLMDSpinButton --------------------------------}
  TLMDSpinButton = class(TGraphicControl)
  private
    FTimer:TTimer;   {ident for global timer}
    FCache:TBitmap;
    FDown,
    FLastDown: TLMDSpinButtonState;
    FDragging: Boolean;
    FOnTopClick: TNotifyEvent;
    FOnBottomClick: TNotifyEvent;
    procedure CreateStates;
    procedure DrawState(State:TLMDSpinButtonState);
    procedure TimerExpired(Sender: TObject);
    procedure CMEnabledChanged(var Msg:TMessage); message CM_EnabledChanged;
    procedure AddTimer;
    procedure RemoveTimer;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
  public
    FTSize:Byte;
    FInterval:Word;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled;
    property ShowHint;
    {events}
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
  end;

{************************* class TLMDSpinButton *******************************}
{-------------------------- private -------------------------------------------}
procedure TLMDSpinButton.TimerExpired(Sender: TObject);
begin
  FTimer.Interval:=FInterval;
  if (FDown<>sbUp) and MouseCapture then
    try
      if FDown=sbBottomDown then
        begin
          if Assigned(FOnBottomClick) then FOnBottomClick(Self);
        end
      else
        if Assigned(FOnTopClick) then FOnTopClick(Self);
    except
      RemoveTimer;
      raise;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.CMEnabledChanged(var Msg:TMessage);
begin
  inherited;
  if Enabled then FDown:=sbUp else FDown:=sbDisabled;
  Paint;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDSpinButton.Paint;
begin
  if not Enabled and not (csDesigning in ComponentState) then
    FDragging := False;

  if (FCache.Height<>Height) or (FCache.Width div 4<>Width) then CreateStates;

  Canvas.Draw(0,0, FCache);
  Canvas.CopyRect(ClientRect, FCache.Canvas, Rect(Ord(FDown)*Width, 0,
                 (Ord(FDown)+1)*Width, FCache.Height));
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.CreateStates;
begin
  FCache.Width:=4*Width;
  FCache.Height:=Height;
  DrawState(sbUp);
  DrawState(sbTopDown);
  DrawState(sbBottomDown);
  DrawState(sbDisabled);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.DrawState(State:TLMDSpinButtonState);
var
  Re:TRect;
  dRect:Integer;
  tmp:TBitmap;
  {$IFDEF LMDCOMP11}
  Details: TThemedElementDetails;
  Button: TThemedSpin;
  {$ENDIF}

  procedure Raised(aRect:TRect);
  begin
    DrawEdge(tmp.Canvas.Handle, aRect, BDR_RAISEDOUTER, BF_SOFT or BF_RECT or BF_ADJUST);
    DrawEdge(tmp.Canvas.Handle, aRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    dRect:=0;
  end;

  procedure Lowered(aRect:TRect);
  begin
    DrawEdge(tmp.Canvas.Handle, aRect, BDR_SUNKENOUTER, BF_RECT);
    DrawEdge(tmp.Canvas.Handle, aRect, BDR_SUNKENINNER, BF_TOPLEFT);
    dRect:=1;
  end;

begin
  tmp:=TBitmap.Create;
  try
    tmp.Height:=self.Height;
    tmp.Width:=self.Width;
    with tmp, tmp.Canvas do
      begin
        Re:=Bounds(0, 0, Width, Height);
        Brush.Color:=clBtnFace;
        Brush.Style:=bsSolid;
        FillRect(re);
        {$IFDEF LMDCOMP11}
        if ThemeControl(self) then
          begin
            re:=Rect(0,0,tmp.Width, (tmp.Height Div 2));
            if not Enabled then
              Button:=tsUpDisabled
            else
              if state=sbTopDown then Button:=tsUpPressed else Button:=tsUpNormal;
            Details := ThemeServices.GetElementDetails(Button);
            ThemeServices.DrawElement(tmp.Canvas.Handle, Details, re);
            if not Enabled then
              Button:=tsDownDisabled
            else
              if state=sbBottomDown then Button:=tsDownPressed else Button:=tsDownNormal;
            re:=Rect(0,(tmp.Height Div 2)+1,tmp.Width, tmp.Height);
            Details := ThemeServices.GetElementDetails(Button);
            ThemeServices.DrawElement(tmp.Canvas.Handle, Details, re);
          end
        else
        {$ENDIF}
        begin
          re:=Rect(0,0,Width, (Height Div 2));
          if state=sbTopDown then Lowered(Re) else Raised(Re);
          LMDDrawTriangle(tmp.Canvas, (tmp.Width Div 2)-2+dRect, (re.Bottom Div 2)+dRect-2,
                          FTSize, clBlack, false, State<>sbDisabled);
          re:=Rect(0,(Height Div 2)+1,Width, Height);
          if state=sbBottomDown then Lowered(Re) else Raised(Re);
          LMDDrawTriangle(tmp.Canvas, (tmp.Width Div 2)-3+dRect, re.Top+((re.Bottom-re.Top) Div 2)+dRect-2,
                          FTSize, clBlack, true, State<>sbDisabled);
        end;
      end;
    {copy bitmap in internal cache}
    FCache.Canvas.CopyRect(Rect(Ord(State)*tmp.Width,0, (Ord(State)+1)*tmp.Width, FCache.Height),
                           tmp.Canvas, Rect(0,0, tmp.Width, tmp.Height));
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button=mbLeft) and Enabled then
    begin
      if FDown=sbUp then
        begin
          FLastDown := FDown;
          if PtInRect(Rect(0,(Height Div 2)+1,Width, Height), Point(X,Y)) then //Y>(-(Width/Height)*X + Height) then
            begin
              FDown:=sbBottomDown;
              if Assigned(FOnBottomClick) then FOnBottomClick(Self);
            end
          else
            begin
              FDown:=sbTopDown;
              if Assigned(FOnTopClick) then FOnTopClick(Self);
            end;
          if FLastDown <> FDown then
            begin
              FLastDown := FDown;
              Paint;
            end;
          AddTimer;
          FTimer.Interval:=FInterval+200;
          FTimer.Enabled:=True
        end;
      FDragging := True;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TLMDSpinButtonState;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
    if PtInRect(ClientRect, Point(X,Y)) then
      begin
        NewState:=FDown;
        if PtInRect(Rect(0,(Height Div 2)+1,Width, Height), Point(X,Y)) then //Y>(-(Width/Height)*X + Height) then
          begin
            if (FDown<>sbBottomDown) then
              begin
                if FLastDown = sbBottomDown then
                  FDown := sbBottomDown
                else
                  FDown := sbUp;
                if NewState<>FDown then Paint;
              end;
          end
        else
          begin
            if (FDown<>sbTopDown) then
              begin
                if (FLastDown = sbTopDown) then
                  FDown:=sbTopDown
                else
                  FDown:=sbUp;
                if NewState<>FDown then Paint;
              end;
           end;
      end
    else
      if FDown<>sbUp then
        begin
          FDown:=sbUp;
          Paint;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
    begin
      FDragging := False;
      if PtInRect(ClientRect,Point(X,Y)) then
        begin
          FDown:=sbUp;
          FLastDown:=sbUp;
          RemoveTimer;
          Paint;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpinButton.AddTimer;
begin
  if Assigned(FTimer) then exit;
  {get a global timer-id}
  FTimer:=TTimer.Create(nil);
  FTimer.Enabled:=False;
  FTimer.OnTimer:=TimerExpired;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpinButton.RemoveTimer;
begin
  If Assigned(FTimer) then
    FreeAndNil(FTimer);
end;

{------------------------------ public ----------------------------------------}
constructor TLMDSpinButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCache:=TBitmap.Create;
  FInterval:=100;
  FDown:=sbup;
  FLastDown:=sbUp;
  Height:=20;
  Width:=20;
end;

{------------------------------------------------------------------------------}
destructor TLMDSpinButton.Destroy;
begin
  RemoveTimer;
  FCache.Free;
  inherited Destroy;
end;

{******************** class TLMDSpinEdit **************************************}
{-------------------------- private -------------------------------------------}
procedure TLMDShSpinEdit.SetEditRect;
var
  r: TRect;
  begin
  r := Rect(0,0, ClientWidth - TLMDSpinButton(FButton).Width-2, ClientHeight+1);
  SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@r));
  SendMessage(Handle, EM_GETRECT, 0, LPARAM(@r));
  end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetSize(aValue:Byte);
begin
  if aValue<>FSize then
    begin
      FSize:=aValue;
      TLMDSpinButton(FButton).FTSize:=FSize;
      If HandleAllocated then
        begin
          TLMDSpinButton(FButton).CreateStates;
          TLMDSpinButton(FButton).Invalidate;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetInteger(Index:Integer; aValue:LongInt);
begin
  case Index of
    0: if (aValue<>FMaxValue) and ((aValue>FMinValue) or (csLoading in ComponentState)) then
         begin
           FMaxValue:=aValue;
           if Value>FMaxValue then Value:=FMaxValue;
         end;
    1: if (aValue<>FMinValue) and ((aValue<FMaxValue) or (csLoading in ComponentState)) then
         begin
           FMinValue:=aValue;
           if Value<FMinValue then Value:=FMinValue;
         end;
    2: FLineSize:=aValue;
    3: FPageSize:=aValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetInterval(aValue:Word);
begin
  TLMDSpinButton(FButton).FInterval:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetSuffix(aValue:String);
begin
  if aValue<>FSuffix then
    begin
      FSuffix:=aValue;
      SetValue(Value);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetValue(aValue:LongInt);
begin
  Text:=IntToStr(CheckValue(aValue))+Suffix;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.SetAlignment (aValue : TAlignment);
begin
  if aValue <> FAlignment then
    begin
      FAlignment := aValue;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  h: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC:=GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  h:=SysMetrics.tmHeight;
  if h>Metrics.tmHeight then h:=Metrics.tmHeight;
  Result:=Metrics.tmHeight+ h div 4;
  if BorderStyle=bsSingle then result:=result+GetSystemMetrics(SM_CYBORDER)*4;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.GetValue:LongInt;
var
  tmp:String;
  i:Integer;
begin
  if FSuffix='' then
    begin
      if (Text='') then Text:=Inttostr(FMinValue);
      try
        Result:=StrToInt(Text);
      except
        Result:=FMinValue;
        Text:=Inttostr(FMinValue)
      end;
      exit;
    end;

  tmp:='';
  for i:=1 to Length(Text) do
    if AnsiChar(Text[i]) in ['+','-','0'..'9'] then tmp:=tmp+Text[i];
  if (tmp='') then tmp:=Inttostr(FMinValue);
  try
    Result:=StrToInt(tmp);
    Text:=tmp+FSuffix;
  except
    Result:=FMinValue;
    Text:=Inttostr(FMinValue)+FSuffix;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.GetInterval:Word;
begin
  result:=TLMDSpinButton(FButton).FInterval;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.AdjustSizeLMD;
var
  MinHeight: Integer;
begin
  MinHeight:=GetMinHeight;
  TLMDSpinButton(FButton).FTSize:=FSize;
  if Height<MinHeight then
    Height:=MinHeight
  else
    begin
      if NewStyleControls and CTL3D and (BorderStyle=bsSingle) then
        begin
          MinHeight:=GetSystemMetrics(SM_CYBORDER)*4;
          FButtonWin.SetBounds(Width-Height,0,Height-MinHeight,Height-MinHeight)
        end
      else
        FButtonWin.SetBounds(Width - Height, 0, Height, Height);

      TLMDSpinButton(FButton).SetBounds(0, 0, FButtonWin.Height, FButtonWin.Height);
      SetEditRect;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.CheckValue(aValue:LongInt): LongInt;
begin
  Result:=aValue;
  if (FMaxValue<>FMinValue) then
    begin
      if aValue<FMinValue then Result:=FMinValue;
      if aValue>FMaxValue then Result:=FMaxValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.CMEnabledChanged(var Msg:TMessage);
begin
  inherited;
  TLMDSpinButton(FButton).Enabled:=Enabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value)<>Value then SetValue(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.CMTextChanged(var Msg: TMessage);
begin
  if csLoading in ComponentState then exit;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.WMCut(var Message: TWMCut);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  AdjustSizeLMD;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDShSpinEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of WORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN or
                  Alignments[FAlignment];
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  AdjustSizeLMD;
  SetEditRect;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelDown(Shift, MousePos);
  DownClick(nil);
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelUp(Shift, MousePos);
  UpClick(nil);
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value:=Value-FLineSize;
end;

{------------------------------------------------------------------------------}
function TLMDShSpinEdit.IsValidChar(Key: Char): Boolean;
var
  ValidChar: set of AnsiChar;
begin
  ValidChar:=['+','-','0'..'9'];
  result:=(AnsiChar(Key) in ValidChar) or (Key < #32);
  if not FEditorEnabled and Result and
     ((Key>=#32) or (Key=Char(VK_BACK)) or (Key=Char(VK_DELETE))) then
    result:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_UP:UpClick (Self);
    VK_DOWN: DownClick (Self);
    VK_PRIOR: if not ReadOnly then value:=Value+FPageSize;
    VK_NEXT: if not ReadOnly then Value:=Value-FPageSize;
  end;
  inherited KeyDown(Key, Shift);
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
    begin
      Key:=#0;
      MessageBeep(0)
    end;
  if Key<>#0 then
    begin
      inherited KeyPress(Key);
      if (Key=Char(VK_RETURN)) or (Key=Char(VK_ESCAPE)) then
        begin
          GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
          if Key=Char(VK_RETURN) then Key := #0;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShSpinEdit.UpClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value:=Value+FLineSize;
end;

{---------------------------- public ------------------------------------------}
constructor TLMDShSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FButtonWin:=TWinControl.Create(Self);
  FButtonWin.Visible := True;
  FButtonWin.Parent := Self;
  FButtonWin.SetBounds(0, 0, Height, Height);
  FAlignment := taLeftJustify;
  FSize:=3;

  FButton := TLMDSpinButton.Create(Self);
  with TLMDSpinButton(FButton) do
    begin
      Parent:=FButtonWin;
      OnTopClick:=UpClick;
      OnBottomClick:=DownClick;
      SetBounds(0, 0, FButtonWin.Width, FButtonWin.Height);
    end;

  Text:='0';
  FLineSize := 1;
  FPageSize:=10;
  FMinValue:=0;
  FMaxValue:=100;
  FEditorEnabled := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDShSpinEdit.Destroy;
begin
  TLMDSpinButton(FButton).Free;
  FButtonWin.Free;
  inherited Destroy;
end;

end.
