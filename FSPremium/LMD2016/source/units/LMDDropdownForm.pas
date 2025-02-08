unit LMDDropdownForm;
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

LMDDropDownForm unit
--------------------


Changes
-------

###############################################################################}

interface

uses
  Messages, Forms, LMDClass, Classes;

type
  TLMDDropDownForm = class(TForm)
  protected
    FOnChange: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    procedure TriggerChangeEvent; virtual;
    procedure OkBtnClick(Sender : TObject); virtual;
    procedure FormClose(Sender : TObject; var Action : TCloseAction); virtual;
    procedure CancelBtnClick(Sender : TObject); virtual;
    procedure WMQueryEndSession(var Message : TMessage); message WM_QUERYENDSESSION;
  public
    IsModal : boolean;
    constructor CreateNew(AOwner : TComponent; Dummy: Integer); override;
    procedure SetFormThemed(Value: boolean); virtual;
    procedure SetThemeMode(AMode: TLMDThemeMode); virtual;
  published
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnDeactivate : TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;


implementation

uses
  TypInfo;

procedure TLMDDropDownForm.CancelBtnClick(Sender: TObject);
begin
  if not IsModal then Close;
end;

constructor TLMDDropDownForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  BorderIcons := [biSystemMenu];
  BorderStyle := bsSizeToolWin;
  Position := poScreenCenter;
  ShowHint := True;
  AutoSize := False;
end;

procedure TLMDDropDownForm.FormClose(Sender : TObject;
  var Action : TCloseAction);
begin
  Action := caHide;
end;

procedure TLMDDropDownForm.OkBtnClick(Sender: TObject);
begin
  if not IsModal then Close;
end;


procedure TLMDDropDownForm.SetFormThemed(Value: boolean);
var
  i : integer;
  PropInfo: PPropInfo;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
    if PropInfo <> nil then
      SetOrdProp(Components[i], PropInfo, Ord(Value));
  end;
end;


procedure TLMDDropDownForm.SetThemeMode(AMode: TLMDThemeMode);
var
  i: Integer;
  PropInfo: PPropInfo;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'ThemeMode');
    if PropInfo <> nil then
      SetOrdProp(Components[i], PropInfo, Ord(AMode));
  end;
end;

procedure TLMDDropDownForm.TriggerChangeEvent;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TLMDDropDownForm.WMQueryEndSession(var Message: TMessage);
begin
  inherited;
  Message.Result := 1;
end;

end.
