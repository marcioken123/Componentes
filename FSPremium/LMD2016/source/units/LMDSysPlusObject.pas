unit LMDSysPlusObject;
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

LMDSysPlusObject unit (JH, AH)
------------------------------
Extended display settings

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysObject,
  LMDSysBase
  ;

type
  { ************************************************************************** }
  TLMDSysPlusObject = class(TLMDSysObject)
  private
    FAvailable: Boolean;
    FFontSmoothing: Boolean;
    FWindowAnimation: Boolean;
    //FUseLargeIcons: Boolean;
    //FResizeBackImg: Boolean;
    FDragFullWindows: Boolean;

    procedure SetBool(index: Integer; aValue: Boolean);
    function GetBool(index: Integer): Boolean;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Available: Boolean index 0 read GetBool write SetBool stored false;
    property FontSmoothing: Boolean index 1 read GetBool write SetBool stored false;
    property WindowAnimation: Boolean index 2 read GetBool write SetBool stored false;
    property DragFullWindows: Boolean index 3 read GetBool write SetBool stored false;
    //    property UseLargeIcons : Boolean index 4 read GetBool write SetBool stored false;
    //    property ResizeBackImage : Boolean index 5 read GetBool write SetBool stored false;
  end;

implementation

uses
  LMDSysLogStrings, LMDSysConst;

const
  cpidAvailable         = 0;
  cpidFontSmoothing     = 1;
  cpidWindowAnimation   = 2;
  cpidDragFullWindows   = 3;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }

procedure TLMDSysPlusObject.SetBool(index: Integer; aValue: Boolean);
begin
  case index of
    0: ;
    1:
      if FFontSmoothing <> aValue then
        begin
          RememberChange(strPlusFontSmoothing, BoolToStr(FFontSmoothing), BoolToStr(aValue));
          FFontSmoothing:= aValue;
        end;
    2:
      if FWindowAnimation <> aValue then
        begin
          RememberChange(strPlusWindowAnimation, BoolToStr(FWindowAnimation), BoolToStr(aValue));
          FWindowAnimation:= aValue;
        end;
    3:
      if FDragFullWindows <> aValue then
        begin
          RememberChange(strPlusDragFullWindows, BoolToStr(FDragFullWindows), BoolToStr(aValue));
          FDragFullWindows:= aValue;
        end;
  end;
  if ApplyChangesAtOnce then
    Apply;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysPlusObject.GetBool(index: Integer): Boolean;
begin
  Result:= false;
  if FInstantUpdate then
    Refresh;
  case index of
    0: Result:= FAvailable;
    1: Result:= FFontSmoothing;
    2: Result:= FWindowAnimation;
    3: Result:= FDragFullWindows;
  end;
end;
{ --------------------------------- protected -------------------------------- }
procedure TLMDSysPlusObject.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidAvailable, sLMDSysDisplayPlusPropTitleAvailable, sLMDSysDisplayPlusPropDescAvailable);
  FPropertiesDesc.Add(cpidFontSmoothing, sLMDSysDisplayPlusPropTitleFontSmoothing, sLMDSysDisplayPlusPropDescFontSmoothing);
  FPropertiesDesc.Add(cpidWindowAnimation, sLMDSysDisplayPlusPropTitleWindowAnimation, sLMDSysDisplayPlusPropDescWindowAnimation);
  FPropertiesDesc.Add(cpidDragFullWindows, sLMDSysDisplayPlusPropTitleDragFullWindows, sLMDSysDisplayPlusPropDescDragFullWindows);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysPlusObject.Create;
begin
  inherited Create;
end;

{ ---------------------------------------------------------------------------- }

//procedure TLMDSysPlusObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysPlusObject.Refresh;
var
  temp: TAnimationInfo;
  val: Boolean;
  begin
  DoProgress(sLMDSysDisplayPlusObjectTitle, 100, 0);
  //  FAvailable := SystemParametersInfo(SPI_GETWINDOWSEXTENSION, 1, nil, 0) //only win 95
  //  exit;
  FPropertiesDesc.InvalidateProperties;

  FAvailable:= true;
  FPropertiesDesc.PropertyByID(cpidAvailable).Text := BoolToStr(FAvailable);
  SystemParametersInfo(SPI_GETFONTSMOOTHING, 0, @val, 0);
  DoProgress(sLMDSysDisplayPlusObjectTitle, 100, 2);

  FFontSmoothing:= val;
  FPropertiesDesc.PropertyByID(cpidFontSmoothing).Text := BoolToStr(FFontSmoothing);

  temp.cbSize:= SizeOf(TAnimationInfo);
  SystemParametersInfo(SPI_GETANIMATION, SizeOf(TAnimationInfo), @temp, 0);
  DoProgress(sLMDSysDisplayPlusObjectTitle, 100, 60);

  FWindowAnimation := (temp.iMinAnimate <> 0);
  FPropertiesDesc.PropertyByID(cpidWindowAnimation).Text := BoolToStr(FWindowAnimation);

  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, @val, 0);
  DoProgress(sLMDSysDisplayPlusObjectTitle, 100, 80);

  FDragFullWindows:= val;
  FPropertiesDesc.PropertyByID(cpidDragFullWindows).Text := BoolToStr(FDragFullWindows);

  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysPlusObject.Apply;
var
  temp: TAnimationInfo;
  begin
  if PropChanged(strPlusFontSmoothing) then
    begin
      WriteToLog(strPlusFontSmoothing);
      SystemParametersInfo(SPI_SETFONTSMOOTHING, Ord(FFontSmoothing), nil, 0);
    end;

  if PropChanged(strPlusWindowAnimation) then
    begin
      WriteToLog(strPlusWindowAnimation);
      temp.cbSize:= SizeOf(TAnimationInfo);
      if FWindowAnimation then
        temp.iMinAnimate:= 1
      else
        temp.iMinAnimate:= 0;
      SystemParametersInfo(SPI_SETANIMATION, SizeOf(TAnimationInfo), @temp, 0);
      end;

  if PropChanged(strPlusDragFullWindows) then
    begin
      WriteToLog(strPlusDragFullWindows);
      SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, Ord(FDragFullWindows), nil, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPlusObject.GetElementTitle : string;
begin
  result :=   sLMDSysDisplayPlusObjectTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPlusObject.GetElementDescription : string;
begin
  result := sLMDSysDisplayPlusObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPlusObject.GetElementType : TLMDSysInfoType;
begin
  result := itDisplayPlus;
end;

{ ---------------------------------------------------------------------------- }

end.
