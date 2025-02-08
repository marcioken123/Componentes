unit LMDJoy;
{$I LMDCmps.inc}
interface

uses
  Windows,SysUtils, Classes, messages, MMSystem, graphics,stdctrls, menus,
  LMDClass,
  LMDCustomComponent;

type

  TLMDJoyStickID= JOYSTICKID1..JOYSTICKID2;
  TLMDJoyStickButton=(jbButton1,jbButton2,jbButton3,jbButton4);
  TJoystickButtons=set of TLMDJoyStickButton;
  TLMDJoyStickButtons=TJoyStickButtons;

  TLMDJoyStickEvent=procedure(Sender:TObject;Buttons:TJoyStickButtons;X,Y:Word) of object;

  TDblWord=record
    x,y:Word;
  end;

  TLMDJoystick = class(TLMDCustomComponent)
  private
    FCalibrateRange:Word;
    FCalCenter:TDblWord;
    FCalLeftTop:TDBlWord;
    FCalRightBottom:TDblWord;

    FChanged:Boolean;
    FEnabled:Boolean;
    FHWnd:HWnd;
    FJoystickID:TLMDJoyStickID;
    FPeriod:Word;
    FThreshold:Word;
    FOnInitError:TNotifyEvent;
    FOnMove:TLMDJoyStickEvent;
    FOnButtonDown:TLMDJoyStickEvent;
    FOnButtonUp:TLMDJoyStickEvent;
    procedure SetCalibrateRange(aValue:Word);
    Procedure SetPeriod(aValue:Word);
    procedure SetChanged(aValue: Boolean);
    procedure SetEnabled(aValue: Boolean);
    procedure SetJoyStickId(aValue:TLMDJoyStickID);
    procedure SetThreshold(aValue:Word);
    procedure JoyEnable;
    procedure JoyDisable;
    procedure WndProc(var Message:TMessage);
    function  GetJoyInfo:TJoyInfo;
    function  GetPos(index:integer):WORD;
    function  GetPosC(index:integer):LongInt;
    function  GetButtons(aValue:Word):TJoyStickButtons;
    function  GetButtonState:TJoyStickButtons;
    function  GetButtonPressed:Boolean;
    function  GetPosition:TDblWord;
    function  GetNumDevs:Byte;     {detects how many joysticks are possible}
    function  GetAttachedDevs:Byte;{detects how many joysticks are REALLY attached}
    function  GetJoyCaps:TJoyCaps;
    function  GetBtnID(index:TLMDJoyStickButton):Boolean;
  protected
    procedure Loaded;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function TestAvailable(aValue:TLMDJoyStickID):Boolean;
    procedure CalibrateCenter(flag:Boolean;x,y:Word);
    procedure CalibrateLeftTop(flag:Boolean;x,y:Word);
    procedure CalibrateRightBottom(flag:Boolean;x,y:Word);
    property AttachedJoySticks:Byte read GetAttacheddevs;
    property AvailableJoySticks:Byte read GetNumdevs;
    property ButtonPressed:Boolean read GetButtonPressed;
    property ButtonState:TJoyStickButtons read GetButtonState;
    property ButtonPressedID[index:TLMDJoyStickButton]:Boolean read GetBtnID;
    property CalCenter:TDblWord read FCalCenter;
    property CalLeftTop:TDblWord read FCalLeftTop;
    property CalRightBottom:TDblWord read FCalRightBottom;
    property GetJoyStickCaps:TJoyCaps read GetJoyCaps;
    property Position: TDblWord read getPosition;
    property PosX:WORD index 0 read GetPos;
    property PosY:WORD index 1 read GetPos;
    property PosZ:WORD index 2 read GetPos;
    property PosCX:LongInt index 0 read GetPosC;
    property PosCY:LongInt index 1 read GetPosC;
  published
    Property About;
    property CalibrateRange:Word read FCalibrateRange write SetCalibrateRange default 10;
    property Changed: Boolean read FChanged write SetChanged default true;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property JoyStickId : TLMDJoyStickID read FJoyStickId write SetJoyStickId default 0;
    property Period: Word read FPeriod write SetPeriod default 10;
    property Threshold: Word read FThreshold write SetThreshold default 2000;

    property OnJoyMove: TLMDJoyStickEvent read FOnMove write FOnMove;
    property OnJoyButtonDown: TLMDJoyStickEvent read FOnButtonDown write FOnButtonDown;
    property OnJoyButtonUp: TLMDJoyStickEvent read FOnButtonUp write FOnButtonUp;
    property OnInitError: TNotifyEvent read FOnInitError write FOnInitError;

    {Events}
    property OnChange;
  end;

implementation
uses
  lmdutils, forms, consts, controls;

{Helper}
{------------------------------------------------------------------------------}
function DblWord(x, y:Word):TDblWord;
begin
  result.X:=x;
  result.Y:=y;
end;
{*************************** Class TLMDJoyStick *******************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDJoystick.SetChanged(aValue: Boolean);
begin
  If FChanged<>aValue then
    begin
      FChanged:=aValue;
      JoyEnable;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDJoystick.SetCalibrateRange(aValue:Word);
begin
  if (FCalibrateRange<>aValue) and (aValue>1) then FCalibrateRange:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.SetEnabled(aValue: Boolean);
begin
  if FEnabled<>aValue then
    begin
      FEnabled:=aValue;
      if FEnabled then JoyEnable else JoyDisable;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.SetJoyStickId(aValue: TLMDJoyStickID);
begin
  if FJoyStickID<>aValue then
    begin
      JoyDisable;
      FJoyStickID:=aValue;
      JoyEnable;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDJoystick.SetPeriod(aValue:Word);
begin
  if FPeriod<>aValue then
    begin
      FPeriod:=aValue;
      JoyEnable;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.SetThreshold(aValue:Word);
begin
  if FThreshold<>aValue then
    begin
      FThreshold:=aValue;
      if not (csDesigning in ComponentState) then
        begin
          joySetThreshold(FJoyStickID, FThreshold);
          Change;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.JoyEnable;
var
  tp:TJoyCaps;
begin

  if not (csDesigning in ComponentState) then
    if joySetCapture(FHWND, FJoyStickID, FPeriod, FCHanged)=0 then
      begin
        tp:=GetJoyCaps;
        {default Values}
        with tp do
          begin
            FCalCenter:=DblWord((wXmax-wXmin) div 2, (wYmax-wYmin) div 2);
            FCalLeftTop:=DblWord(wXmin, wYmin);
            FCalRightBottom:=DblWord(wXmax, wYMax);
            Change;
          end
      end
    else
      begin
        FEnabled:=False;
        if assigned(FOnInitError) then FOnInitError(self);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.JoyDisable;
begin
  if not (csDesigning in ComponentState) then
    joyReleaseCapture(FJoyStickID);
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.WNDProc(var Message:TMessage);
begin
  with Message do
    case Msg of
      MM_JOY1BUTTONDOWN,
      MM_JOY2BUTTONDOWN:if assigned(FOnButtonDown) then
                          FOnButtonDown(self,GetButtons(wParam),LoWord(LParam), HiWord(LParam));
      MM_JOY1BUTTONUP,
      MM_JOY2BUTTONUP:  if assigned(FOnButtonUp) then
                          FOnButtonUp(self,GetButtons(wParam),LoWord(LParam), HiWord(LParam));

      MM_JOY1MOVE,
      MM_JOY2MOVE,
      MM_JOY1ZMOVE,
      MM_JOY2ZMOVE:     if assigned(FOnMove) then
                          FOnMove(self,GetButtons(wParam),LoWord(LParam), HiWord(LParam));
    else
      Result := DefWindowProc(FHwnd, Msg, wParam, lParam);
    end;
end;

{------------------------------------------------------------------------------}
function  TLMDJoystick.GetAttachedDevs:Byte;
var
  temp:TJoyInfo;
begin
   result:=0;
   if getnumdevs=0 then exit;
   if joyGetPos(JoyStickID1, @temp)<>JOYERR_UNPLUGGED then result:=1;
   if joyGetPos(JoyStickID2, @temp)<>JOYERR_UNPLUGGED then inc(result);
end;

{------------------------------------------------------------------------------}
function TLMDJoystick.GetButtons(aValue:Word):TJoyStickButtons;
begin
   result:=[];
   if (aValue and JOY_BUTTON1)=JOY_BUTTON1 then result:=[jbButton1];
   if (aValue and JOY_BUTTON2)=JOY_BUTTON2 then result:=result+[jbButton2];
   if (aValue and JOY_BUTTON3)=JOY_BUTTON3 then result:=result+[jbButton3];
   if (aValue and JOY_BUTTON4)=JOY_BUTTON4 then result:=result+[jbButton4];
end;

{------------------------------------------------------------------------------}
function  TLMDJoystick.GetButtonPressed:Boolean;
begin
  result:=(GetButtonState<>[]);
end;

{------------------------------------------------------------------------------}
function TLMDJoystick.GetButtonState:TJoyStickButtons;
begin
   result:=GetButtons(Getjoyinfo.wbuttons);
end;

{------------------------------------------------------------------------------}
function TLMDJoyStick.GetBtnID(index:TLMDJoyStickButton):boolean;
begin
  result:=(index in GetButtonState);
end;

{------------------------------------------------------------------------------}
function  TLMDJoystick.GetJoyCaps:TJoyCaps;
var
  temp:TJoyCaps;
begin
  joyGetDevCaps(FJoyStickID, @temp, sizeof(temp));
  result:=temp;
end;

{------------------------------------------------------------------------------}
function TLMDJoystick.GetJoyInfo:TJoyInfo;
var
  temp:TJoyInfo;
begin
   joyGetPos(FJoyStickID, @temp);
   result:=temp;
end;

{------------------------------------------------------------------------------}
function  TLMDJoystick.GetNumDevs:Byte;
begin
  result:=joyGetNumDevs;
end;

{------------------------------------------------------------------------------}
function  TLMDJoystick.GetPosition:TDblWord;
begin
  result.X:=GetJoyInfo.wXpos;
  result.Y:=GetJoyInfo.wYpos;
end;

{------------------------------------------------------------------------------}
function TLMDJoystick.GetPos(index:integer):WORD;
begin
  result:=0;
  case index of
    0:result:=GetJoyInfo.wXPos;
    1:result:=GetJoyInfo.wYPos;
    2:result:=GetJoyInfo.wZPos;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDJoystick.GetPosC(index:integer):LongInt;
var
  w:longint;
begin
  result:=0;
  try
    case index of
      0:begin
          w:=GetJoyInfo.wXPos;
          if w<FCalCenter.X then
            result:=Round((w-FCalLeftTop.X)/(FCalCenter.X-FCalLeftTop.X)*FCalibrateRange)-FCalibrateRange
          else
            result:=Round((w-FCalCenter.X)/(FCalRightBottom.X-FCalCenter.X)*FCalibrateRange);
        end;
      1:begin
          w:=GetJoyInfo.wYPos;
          if w<FCalCenter.Y then
            result:=FCalibrateRange-Round((w-FCalLeftTop.Y)/(FCalCenter.Y-FCalLeftTop.y)*FCalibrateRange)
          else
            begin
              result:=Round((w-FCalCenter.Y)/(FCalRightBottom.Y-FCalCenter.Y)*-FCalibrateRange);
              if Abs(result)>FCalibrateRange then result:=-FCalibraterange;
            end
        end;
    end;
  except
    on exception do ;
  end;
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDJoystick.Loaded;
begin
  if not (csDesigning in ComponentState) then
    begin
      FHwnd:={$IFDEF CONDITIONALEXPRESSIONS}Classes.{$ENDIF}AllocateHwnd(WndProc);
      if FEnabled then
        begin
          if not testavailable(FJoyStickID) then
            FEnabled:=false
          else
            if joySetCapture(FHWND, FJoyStickID, FPeriod, FCHanged)=0 then
              joySetThreshold(FJoyStickID, FThreshold)
            else
              FEnabled:=false;
        end;
    end;
end;

{---------------------- Public ------------------------------------------------}
constructor TLMDJoystick.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FCalibrateRange:=10;
  FEnabled:=True;
  FJoyStickID:=0;
  FChanged:=True;
  FPeriod:=getjoycaps.wPeriodMin;
  joygetthreshold(FJoyStickID,@FThreshold);
  if FThreshold=0 then
    begin                    {an Error occured}
      FEnabled:=false;
      FThreshold:=2000;
    end;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName, 0);

end;

{------------------------------------------------------------------------------}
Destructor TLMDJoystick.Destroy;
begin
  if not (csDesigning in ComponentState) then
    begin
      joyReleaseCapture(FJoyStickID);
      {$IFDEF CONDITIONALEXPRESSIONS}Classes.{$ENDIF}DeallocateHWnd(FHWND);
    end;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.CalibrateCenter;
begin
  If not FEnabled then exit;
  if flag then
    FCalCenter:=DblWord(x,y)
  else
    FCalCenter:=GetPosition;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.CalibrateLeftTop;
begin
  if not FEnabled then exit;
  if flag then
    FCalLeftTop:=DblWord(x,y)
  else
    FCalLeftTop:=GetPosition;
end;

{------------------------------------------------------------------------------}
procedure TLMDJoystick.CalibrateRightBottom;
begin
  if not FEnabled then exit;
  if flag then
    FCalRightBottom:=DblWord(X,Y)
  else
    FCalRightBottom:=GetPosition;
end;

{----------------------------------------------------------------------------}
function TLMDJoystick.TestAvailable(aValue:TLMDJoyStickID):Boolean;
var
  temp:TJoyinfo;
begin
  if joyGetPos(aValue, @temp)=0 then result:=true else result:=false;
end;

end.
