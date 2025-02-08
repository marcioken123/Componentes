unit LMDStopWatch;
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

LMDStopWatch unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  LMDCustomComponent;

type
  TLMDStopWatch=class(TLMDCustomComponent)
  private
    FCaption: TCaption;
    FDigits : Byte;
    FStart,
    FStop   : TLargeInteger;//_LARGE_INTEGER;
    FStartTime,
    FStopTime: LongInt;
    FRunning,
    FWaitCursor: Boolean;
    FControl: TControl;
    FResult : Extended;
    FSuffix : String;
    function GetTimeString:String;
    function GetDisplayCaption:String;
    function GetActive: Boolean;
    procedure SetActive (aValue: Boolean);
  public
    constructor Create(AOwner:TComponent); override;
    procedure Start;
    function Stop:Extended;
    property Time:Extended read FResult;
    property TimeString: String read GetTimeString;
    property DisplayCaption: String read GetDisplayCaption;
    property Active: Boolean read GetActive write SetActive;
  published
    property About;
    property Control: TControl read FControl write FControl;
    property Digits:Byte read FDigits write FDigits;
    property Caption:TCaption read FCaption write FCaption;
    property Suffix:String read FSuffix write FSuffix;
    property WaitCursor: Boolean read FWaitCursor write FWaitCursor default false;
  end;

implementation

uses
  SysUtils,
  Forms,
  TypInfo,
  lmdclass;

//small helper for TLMDStopWatch
procedure SetCaption(AControl: TControl; const Caption: TCaption);
var
  PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(AControl, 'Caption');

  if  Assigned(PropInfo)  then
    SetStrProp(AControl, PropInfo, Caption);
end;

{------------------------- Private --------------------------------------------}
function TLMDStopWatch.GetTimeString:String;
begin
  result:=FloatToStrF(FResult, ffNumber,16,FDigits);
end;

{------------------------------------------------------------------------------}
function TLMDStopWatch.GetDisplayCaption:String;
begin
  result:=Caption+TimeString+FSuffix;
end;

{------------------------------------------------------------------------------}
function TLMDStopWatch.GetActive: Boolean;
begin
  result := FRunning;
end;

{------------------------------------------------------------------------------}
procedure TLMDStopWatch.SetActive (aValue: Boolean);
begin
  if aValue then Start else Stop;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDStopWatch.Create(AOwner:TComponent);
begin
  inherited;
  FResult:=0;
  FRunning:=False;
  FWaitCursor:=false;
  FControl:=nil;
  FCaption:='Time: ';
  FDigits:=2;
end;

{------------------------------------------------------------------------------}
procedure TLMDStopWatch.Start;
begin
  if FRunning then Stop;
  FResult:=0;
  FRunning:=True;
  if FWaitCursor then Screen.Cursor:=crHourGlass;
  if Assigned(FControl) then
    begin
      SetCaption(FControl, Caption);
      FControl.Enabled:=False;
    end;
  if not QueryPerformanceCounter(FStart) then  //use alternative method
(*
  if not QueryPerformanceCounter(FStart) then  //use alternative method
*)
    FStartTime:=GetTickCount;
end;

{------------------------------------------------------------------------------}
function TLMDStopWatch.Stop:Extended;
begin
  result:=0;
  if not FRunning then exit;
//  if not QueryPerformanceCounter(TLargeInteger(FStop)) then
  if not QueryPerformanceCounter(FStop) then
    begin
      FStopTime:=GetTickCount;
      FResult:=(FStopTime-FStartTime)/1000;
    end
  else
    FResult:=(FStop - FStart)/LMDApplication.TimerFrequency;
//    FResult:=(FStop.QuadPart-FStart.QuadPart)/LMDApplication.TimerFrequency;

  if FWaitCursor then Screen.Cursor:=crDefault;
  if Assigned(FControl) then
    begin
      SetCaption(FControl, GetDisplayCaption);
      FControl.Enabled:=True;
    end;

  result:=FResult;
end;

end.
 
