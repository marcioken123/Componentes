unit LMDSysKeyboardObject;
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

LMDSysKeyboardObject unit (JH, AH)
----------------------------------
Information about the used keyboard

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, 
  LMDSysObject, LMDSysBase, LMDSysConst;

type
  TLMDSysKeyboardDisplayInfo=(kpidTypeString,kpidType, kpidSubType, kpidFunctionKeys,
                              kpidDelay, kpidSpeed, kpidNumLock, kpidCapsLock,
                              kpidScrollLock, kpidCaretBlinkTime, kpidLayout);
  TLMDSysKeyboardDisplayInfos=set of TLMDSysKeyboardDisplayInfo;

const
  def_TLMDSysKeyboardDisplayInfos=[kpidDelay, kpidSpeed, kpidNumLock, kpidCapsLock,
                              kpidCaretBlinkTime, kpidScrollLock, kpidType, kpidTypeString,
                              kpidSubType, kpidFunctionKeys, kpidLayout];

  LMDSysKeyboardProps:array[TLMDSysKeyboardDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysKeyboardPropTitleTypeString; Description: sLMDSysKeyboardPropDescTypeString),
    (Name: sLMDSysKeyboardPropTitleType; Description: sLMDSysKeyboardPropDescType),
    (Name: sLMDSysKeyboardPropTitleSubType; Description: sLMDSysKeyboardPropDescSubType),
    (Name: sLMDSysKeyboardPropTitleFunctionKeys; Description: sLMDSysKeyboardPropDescFunctionKeys),
    (Name: sLMDSysKeyboardPropTitleDelay; Description: sLMDSysKeyboardPropDescDelay),
    (Name: sLMDSysKeyboardPropTitleSpeed; Description: sLMDSysKeyboardPropDescSpeed),
    (Name: sLMDSysKeyboardPropTitleNumLock; Description: sLMDSysKeyboardPropDescNumLock),
    (Name: sLMDSysKeyboardPropTitleCapsLock; Description: sLMDSysKeyboardPropDescCapsLock),
    (Name: sLMDSysKeyboardPropTitleScrollLock; Description: sLMDSysKeyboardPropDescScrollLock),
    (Name: sLMDSysKeyboardPropTitleCaretBlinkTime; Description: sLMDSysKeyboardPropDescCaretBlinkTime),
    (Name: sLMDSysKeyboardPropTitleLayout; Description: sLMDSysKeyboardPropDescLayout)
  );

  LMDSysKeyboardNames:array[1..7] of string=(sLMDKeyboard1, sLMDKeyboard2, sLMDKeyboard3, sLMDKeyboard4,
                                             sLMDKeyboard5, sLMDKeyboard6, sLMDKeyboard7);

type
  { ************************************************************************** }
  TLMDSysKeyboardObject = class(TLMDSysObject)
  private
    FCaretBlinkTime,
      FKeyboardSpeed,
      FKeyboardDelay: LongInt;
    FNumLock,
      FCapsLock,
      FScroll: Boolean;
    FType,
      FSubType,
      FFuncKeys: Integer;
    FLayout: string;
    FDisplayInfo: TLMDSysKeyboardDisplayInfos;

    procedure SetDummyBool(index: Integer; aValue: Boolean);
    procedure SetDummyInteger(index: Integer; aValue: Integer);
    procedure SetDummyString(aValue: string);

    function getNumLock: Boolean;
    function getCapsLock: Boolean;
    function getScrollLock: Boolean;
    function getLayout: string;

    function GetBool(index: Integer): Boolean;
    function GetKeyboardDelay: LongInt;
    function GetKeyboardSpeed: LongInt;
    function GetCaretBlinkTime: LongInt;
    function GetInteger(index: Integer): Integer;
    function GetLayoutStr: string;
    procedure SetCaretBlinkTime(const Value: LongInt);
    procedure SetKeyboardDelay(const Value: LongInt);
    procedure SetKeyboardSpeed(const Value: LongInt);
    procedure SetDisplayInfo(const Value: TLMDSysKeyboardDisplayInfos);
    function GetKeyboardString: String;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    procedure Refresh; override;
    procedure Apply; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property TypeString:String read GetKeyboardString write SetDummyString stored false;
    property Delay: LongInt read GetKeyboardDelay write SetKeyboardDelay stored false;
    property Speed: LongInt read GetKeyboardSpeed write SetKeyboardSpeed stored false;
    property NumLock: Boolean index 0 read GetBool write SetDummyBool stored false;
    property CapsLock: Boolean index 1 read GetBool write SetDummyBool stored false;
    property CaretBlinkTime: LongInt read GetCaretBlinkTime write SetCaretBlinkTime stored false;
    property ScrollLock: Boolean index 2 read GetBool write SetDummyBool stored false;
    property TypeID: Integer index 0 read GetInteger write SetDummyInteger stored false;
    property SubTypeID: Integer index 1 read GetInteger write SetDummyInteger stored false;
    property FunctionKeys: Integer index 2 read GetInteger write SetDummyInteger stored false;
    property Layout: string read GetLayoutStr write SetDummyString stored false;
    property DisplayInfo:TLMDSysKeyboardDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysKeyboardDisplayInfos;
  end;

implementation

uses
  SysUtils,
  LMDSysLogStrings;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
{procedure TLMDSysKeyboardObject.SetDummyLongInt(aValue: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysKeyboardObject.SetDummyBool(index: Integer; aValue: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysKeyboardObject.SetDummyInteger(index: Integer; aValue: Integer);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysKeyboardObject.SetDummyString(aValue: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysKeyboardObject.SetDisplayInfo(const Value: TLMDSysKeyboardDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysKeyboardObject.SetCaretBlinkTime(const Value: LongInt);
begin
  if FCaretBlinkTime <> Value then
    begin
      RememberChange(strCaretBlinkTime, IntToStr(FCaretBlinkTime),
        IntToStr(Value));
      FCaretBlinkTime:= Value
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysKeyboardObject.SetKeyboardDelay(const Value: LongInt);
begin
  if FKeyboardDelay <> Value then
    begin
      RememberChange(strKeyboardDelay, IntToStr(FKeyboardDelay),
        IntToStr(Value));
      FKeyboardDelay:= Value
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysKeyboardObject.SetKeyboardSpeed(const Value: LongInt);
begin
  if FKeyboardSpeed <> Value then
    begin
      RememberChange(strKeyboardSpeed, IntToStr(FKeyboardSpeed),
        IntToStr(Value));
      FKeyboardSpeed:= Value
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.getNumLock: Boolean;
begin
  Result:= (lo(GetKeyState(VK_NUMLOCK)) = 1)
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.getCapsLock: Boolean;
begin
  Result:= (lo(GetKeyState(VK_CAPITAL)) = 1)
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.getScrollLock: Boolean;
begin
  Result:= (lo(GetKeyState(VK_SCROLL)) = 1)
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.getLayout: string;
var
  mc: PAnsiChar;
  begin
  GetMem(mc, KL_NAMELENGTH);
  try
    GetKeyboardLayoutNameA(mc);
    Result:= String(mc);
    finally
    FreeMem(mc);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetBool(index: Integer): Boolean;
begin
  Result:= false;
  case index of
    0:
      begin
        if FInstantUpdate then
          FNumLock:= getNumLock;
        Result:= FNumLock;
      end;
    1:
      begin
        if FInstantUpdate then
          FCapsLock:= getCapsLock;
        Result:= FCapsLock;
      end;
    2:
      begin
        if FInstantUpdate then
          FScroll:= getScrollLock;
        Result:= FScroll;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetKeyboardDelay: LongInt;

begin
  if FInstantUpdate then
    SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, @FKeyboardDelay, 0);
    Result:= FKeyboardDelay;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetKeyboardSpeed: LongInt;

begin
  if FInstantUpdate then
    SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, @FKeyboardSpeed, 0);
    Result:= FKeyboardSpeed;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetKeyboardString: String;
begin
 if FType in [1..7] then
   result:=LMDSysKeyboardNames[FType]
 else
   result:=sLMDSysUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetInteger(index: Integer): Integer;
begin
  Result:= 0;
  case index of
    0:
      begin
        if FInstantUpdate then
          FType:= GetKeyboardType(0);
        Result:= FType;
      end;
    1:
      begin
        if FInstantUpdate then
          FSubType:= GetKeyboardType(1);
        Result:= FSubType;
      end;
    2:
      begin
        if FInstantUpdate then
          FFuncKeys:= GetKeyboardType(2);
        Result:= FFuncKeys;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetLayoutStr: string;
begin
  if FInstantUpdate then
    FLayout:= getLayout;
  Result:= FLayout;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetCaretBlinkTime: LongInt;
begin
  if FInstantUpdate then
    FCaretBlinkTime:= Windows.GetCaretBlinkTime;
  Result:= FCaretBlinkTime;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysKeyboardObject.RegisterProperties;
var
  i:TLMDSysKeyboardDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysKeyboardDisplayInfo) to High(TLMDSysKeyboardDisplayInfo) do
    if i in FDisplayInfo then
      FPropertiesDesc.Add(Ord(i), LMDSysKeyBoardProps[i].Name, LMDSysKeyBoardProps[i].Description);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysKeyboardObject.Create;
begin
  FDisplayInfo:=def_TLMDSysKeyboardDisplayInfos;
  inherited Create;
  FInstantUpdate:= false;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDSysKeyboardObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysKeyboardObject.Refresh;
var
  i:TLMDSysKeyboardDisplayInfo;

begin
DoProgress(sLMDSysKeyboardObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, @FKeyboardDelay, 0);
  DoProgress(sLMDSysKeyboardObjectsTitle, 100, 40);
  SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, @FKeyboardSpeed, 0);
  DoProgress(sLMDSysKeyboardObjectsTitle, 100, 80);
  FNumLock:= getNumLock;
  FCapsLock:= getCapsLock;
  FScroll:= getScrollLock;
  FType:= GetKeyboardType(0);
  FSubType:= GetKeyboardType(1);
  FFuncKeys:= GetKeyboardType(2);
  FLayout:= getLayout;
  FCaretBlinkTime:=Windows.GetCaretBlinkTime;

  for i:=Low(TLMDSysKeyboardDisplayInfo) to High(TLMDSysKeyboardDisplayInfo) do
    if i in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          kpidDelay: Text:=IntToStr(FKeyboardDelay);
          kpidSpeed: Text:=IntToStr(FKeyboardSpeed);
          kpidNumLock: Text:= BoolToStr(FNumLock);
          kpidCapsLock: Text:= BoolToStr(FCapsLock);
          kpidCaretBlinkTime: Text:=IntToStr(FCaretBlinkTime);
          kpidScrollLock: Text:=BoolToStr(FScroll);
          kpidTypeString: Text:= GetKeyBoardString;
          kpidType: Text:= IntToStr(FType);
          kpidSubType: Text:= IntToStr(FSubType);
          kpidFunctionKeys: Text:= IntToStr(FFuncKeys);
          kpidLayout: Text:= FLayout;
        end;

  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysKeyboardObject.Apply;
begin
  if PropChanged(strCaretBlinkTime) then
    begin
      WriteToLog(strCaretBlinkTime);
      Windows.SetCaretBlinkTime(FCaretBlinkTime);
    end;
  if PropChanged(strKeyboardDelay) then
    begin
      WriteToLog(strKeyboardDelay);
      SystemParametersInfo(SPI_SETKEYBOARDDELAY, FKeyboardDelay, nil, 0);
    end;
  if PropChanged(strKeyboardSpeed) then
    begin
      WriteToLog(strKeyboardSpeed);
      SystemParametersInfo(SPI_SETKEYBOARDSpeed, FKeyboardSpeed, nil, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetElementTitle : string;
begin
  result := sLMDSysKeyboardObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetElementDescription : string;
begin
  result := sLMDSysKeyboardObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysKeyboardObject.GetElementType : TLMDSysInfoType;
begin
  result := itKeyboard;
end;

end.
