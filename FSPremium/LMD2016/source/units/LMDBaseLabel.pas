unit LMDBaseLabel;
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

LMDBaseLabel unit (RM)
----------------------
Base label component. Used by many labels as ancestor.

ToDo
----
* Unicode support (hint, caption etc.)

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Classes, Controls, Graphics, Forms, Themes,
  LMDTypes, LMDClass, LMDGraph, LMDBaseGraphicControl, LMDVldBase;

type

  TLMDLabelOption=(loPathEllipsis, loEndEllipsis, loEditControl, loShowLabelHint);
  TLMDLabelOptions=set of TLMDLabelOption;

  {-------------------------- TLMDBaseLabel -----------------------------------}
  TLMDBaseLabel = class(TLMDBaseGraphicControl, ILMDValidatingMsgControl)
  private
    FAccelChar,
    FDBControl,
    FTwinkle,
    FMultiLine        : Boolean;
    FAlignment        : TLMDAlignment;
    FOptions          : TLMDLabelOptions;
    FTwinkleTimerId   : TLMDTimer;
    FTwinkleVisible,
    FTwinkleInVisible : Integer;
    FTwinkleColor     : TColor;
    FAntialiased: Boolean;
    FUseGlobalTimer: Boolean;
    procedure SetAlignment (aValue : TLMDAlignment);
    procedure SetOptions (aValue : TLMDLabelOptions);
    procedure SetInteger (index, aValue : Integer);
    procedure SetBool(index : Integer; aValue : Boolean);
    procedure SetControl(aValue:TWinControl);
    procedure SetAntialised(const Value: Boolean);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    FControl: TWinControl;
    FAutoSize,
    FTwinkleFlag,
    FCChange: Boolean;
    function GetThemedTextColor: TColor;
    function CheckAntiAliasedState:Boolean;
    procedure OnTwinkleTimer (Sender : TObject);
    procedure GetChange(Sender:TObject);override;
    function  GetEmpty:Boolean;override;
    function GetLabelText:String; virtual;
    function GetStatusControl: Boolean;virtual;
    function GetOptionsFlag:Word;
    procedure FontChange(Sender:TObject);virtual;
    procedure Loaded;override;
    Procedure Notification(AComponent: TComponent;Operation: TOperation); override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
    // 7.0
    class function SystemFontSmoothingState:Boolean;
    property FontSmoothing:Boolean read FAntialiased write SetAntialised default false;

    function GetControl : TWinControl;
    procedure CorrectBounds;virtual;

    property Alignment:TLMDAlignment read FAlignment write SetAlignment default agTopLeft;
    property AutoSize:Boolean index 0 read FAutoSize write SetBool default True;
    property Caption;
    property Color;
    property DBControl:Boolean read FDBControl write FDBControl; {only for internal use}
    // 8.0
    property StatusBarControl:Boolean read GetStatusControl; {only for internal use}
    // ---
    property FocusControl: TWinControl read FControl write SetControl;
    property Font;
    property MultiLine:Boolean index 1 read FMultiLine write SetBool default False;
    property Options:TLMDLabelOptions read FOptions write SetOptions;
    property ShowAccelChar:Boolean index 2 read FAccelChar write SetBool default True;
    property Transparent;
    property Twinkle : Boolean index 3 read FTwinkle write SetBool default false;
    property TwinkleVisible : Integer index 0 read FTwinkleVisible write SetInteger default 700;
    property TwinkleInVisible : Integer index 1 read FTwinkleInVisible write SetInteger default 700;
    property TwinkleColor : TColor read FTwinkleColor write FTwinkleColor default clNone;
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---

    //Validation support, May 2006, RS
    procedure SetErrorMessage(val : TLMDString; errorLevel: integer);
    function GetLastErrorMessage : TLMDString;
  published
    property BiDiMode;
    property ParentBiDiMode;
  end;

implementation

uses
  Windows, SysUtils, LMDSysin;

{************************ Class TLMDBaseLabel *********************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDBaseLabel.SetAlignment(aValue:TLMDAlignment);
begin
  if aValue<>FAlignment then
    begin
      FAlignment:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetAntialised(const Value: Boolean);
begin
  if Value<>FAntialiased then
    begin
      FAntialiased:=Value;
      CheckAntiAliasedState;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FTwinkleVisible then
          begin
            FTwinkleVisible := aValue;
          end;
    1 : if aValue <> FTwinkleInVisible then
          begin
            FTwinkleInVisible := aValue;
          end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetBool(index:Integer;aValue:Boolean);
begin
  case index of
    0: if aValue<>FAutoSize then begin FAutoSize:=aValue;CorrectBounds;end;
    1: if aValue<>FMultiLine then begin FMultiLine:=aValue;GetChange(nil);end;
    2: if aValue<>FAccelChar then begin FAccelChar:=aValue;InvalidateControl;end;
    3: if aValue<>FTwinkle then
         begin
           FTwinkle := aValue;
           if FTwinkle and not (csDesigning in ComponentState) then
             begin
               if Assigned(FTwinkleTimerId) then FreeAndNil(FTwinkleTimerId);
               FTwinkleTimerId:=TLMDTimer.Create(FTwinkleVisible, OnTwinkleTimer,Enabled, FUseGlobalTimer)
             end
           else
             begin
               FreeAndNil(FTwinkleTimerID);
               FTwinkleFlag := True;
               InvalidateControl;
             end;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetOptions(aValue:TLMDLabelOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetControl(aValue: TWinControl);
begin
  FControl := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if not FAccelChar then exit;
  if (FControl <> nil) and Enabled and IsAccel(Message.CharCode, Caption) then
    if FControl.CanFocus then
      begin
        FControl.SetFocus;
        Message.Result := 1;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.CMFontChanged(var Message: TMessage);
begin
  CheckAntiAliasedState;
  inherited;
  if FCChange then exit;
  FontChange(Font);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.CMHintShow(var Message: TCMHintShow);
var
  HintInfo: PHintInfo;
begin
  inherited;
  if (Hint<>'') or not (loShowLabelHint in FOptions) then exit;
  HintInfo := Message.HintInfo;
  if (HintInfo.HintControl = Self) then
    HintInfo.HintStr := GetLabelText;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.CMTextChanged(var Message: TMessage);
begin
  CorrectBounds;
  InvalidateControl;
end;

{------------------------- Protected ------------------------------------------}
function TLMDBaseLabel.CheckAntiAliasedState: Boolean;
var
  lf: TLogFont;
begin
  result:=false;

  Windows.GetObject(Font.Handle, SizeOf(TLogFont), @lf);

  if FAntialiased<>(lf.lfQuality=ANTIALIASED_QUALITY) then
    begin
      if FAntialiased then
        lf.lfQuality:=ANTIALIASED_QUALITY
      else
        lf.lfQuality := DEFAULT_QUALITY;
      Font.Handle := CreateFontIndirect(lf);
      result:=True;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.OnTwinkleTimer (Sender : TObject);
begin
  if not Assigned(FTwinkleTimerId) then exit;
  FTwinkleFlag := (FTwinkleFlag = false);
  if FTwinkleFlag then
    FTwinkleTimerId.Interval := FTwinkleInVisible
  else
    FTwinkleTimerId.Interval := FTwinkleVisible;
  // 7.02
  if Visible then
    InvalidateControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.GetChange(Sender:TObject);
begin
  CorrectBounds;
  InvalidateControl;
end;

{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetEmpty:Boolean;
begin
  result:=Transparent and (GetLabelText='');
end;

{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetOptionsFlag:Word;
const
  OPTFLAGS:array[TLMDLabelOption] of Word = (DT_PATH_ELLIPSIS, DT_END_ELLIPSIS, DT_EDITCONTROL, 0);
var
  i:TLMDLabelOption;
begin
  result:=0;
  for i:=Low(TLMDLabelOption) to High(TLMDLabelOption) do
    if i in FOptions then result:=result or OptFlags[i];
  if result<>0 then result:=result or DT_MODIFYSTRING;
end;

{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetLabelText:String;
begin
  result:=Caption
end;

{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetStatusControl: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled,
                                                  ttlTextLabelNormal);
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(C_STATES[Enabled]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clWindowText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{------------------------------------------------------------------------------}
Procedure TLMDBaseLabel.FontChange(Sender:TObject);
begin
  if csLoading in ComponentState then exit;
  if sender=Font then ParentFont:=False;
  if not (csReading in ComponentState) then Canvas.Font:=self.Font;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.Loaded;
begin
  inherited Loaded;
  Canvas.Font:=self.Font;
  CorrectBounds;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (AComponent = FControl) then FControl := nil;
end;

{------------------------- Public ---------------------------------------------}
function TLMDBaseLabel.GetControl : TWinControl;
begin
  result := FControl;
end;

{------------------------------------------------------------------------------}
constructor TLMDBaseLabel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FAlignment := agTopLeft;
  FAutoSize  := true;
  FAccelChar := true;
  FMultiLine := false;
  FDBControl := false;
  FTwinkle   := false;
  FTwinkleVisible   := 700;
  FTwinkleInVisible := 700;
  FTwinkleFlag := true;
  FTwinkleColor := clNone;
  FTwinkleTimerId := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseLabel.Destroy;
begin
  if Assigned(FTwinkleTimerId) then
    FreeAndNil(FTwinkleTimerId);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.CorrectBounds;
begin
end;

{------------------------------------------------------------------------------}
class function TLMDBaseLabel.SystemFontSmoothingState: Boolean;
begin
  result:=LMDSIFontSmoothing;
end;

{------------------------------------------------------------------------------}
//Validation support, May 2006, RS
{------------------------------------------------------------------------------}
function TLMDBaseLabel.GetLastErrorMessage: TLMDString;
begin
  Result := Self.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseLabel.SetErrorMessage(val: TLMDString; errorLevel: integer);
begin
  Self.Text := val;
end;

end.
