unit LMDVldWinControlAdapter;
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

LMDVldWinControlAdapter unit (AH)
--------------------------------

Changes
-------
Release 2012.0 (October 2011)
 - Initial Release

###############################################################################}

interface
uses
  Classes, Controls, Graphics, SysUtils, Messages, LMDVldBase, LMDHookComponent,
  LMDTypes;

type
  TLMDVldWinControlAdapter = class(TComponent, ILMDValidatedControl)
  private
    FControl: TWinControl;
    FValidator: TLMDValidationEntity;
    FValidationMsgString: String;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    FHook: TLMDHookComponent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    procedure HookMessages(Sender: TObject; var Message: TMessage; var Handled: Boolean);
    procedure SetControl(const Value: TControl);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetValidationMsgString: TLMDString;
    function GetControl: TControl;
    function GetControlBackBrush: TBrush;
    function GetControlFont: TFont;
    function GetValueToValidate: TLMDString;
    function SupportsDefaultIndication: boolean;
    function GetValidator: TLMDValidationEntity;

    procedure SetValidationMsgString(val: TLMDString);
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator: TLMDValidationEntity);

    property ControlFont: TFont read GetControlFont;
    property ControlBackBrush: TBrush read GetControlBackBrush;
    property ValidationMsgString: TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Control: TControl read GetControl write SetControl;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write SetOnValidationError;
  end;

implementation

{ TLMDVldWinControlAdapter }

constructor TLMDVldWinControlAdapter.Create(AOwner: TComponent);
begin
  inherited;
  FHook := TLMDHookComponent.Create(Self);
  FHook.Active := True;
  FHook.OnMessage := HookMessages;
end;

destructor TLMDVldWinControlAdapter.Destroy;
begin
  FHook.Free;
  inherited;
end;

function TLMDVldWinControlAdapter.GetControl: TControl;
begin
  Result := FControl;
end;

function TLMDVldWinControlAdapter.GetControlBackBrush: TBrush;
begin
  Result := FControl.Brush;
end;

function TLMDVldWinControlAdapter.GetControlFont: TFont;
begin
  Result := nil;
end;

function TLMDVldWinControlAdapter.GetValidationMsgString: TLMDString;
begin
  Result := FValidationMsgString;
end;

function TLMDVldWinControlAdapter.GetValidator: TLMDValidationEntity;
begin
  Result := FValidator;
end;

function TLMDVldWinControlAdapter.GetValueToValidate: TLMDString;
var
  LText: PLMDChar;
  LLen: Integer;
begin
  LLen := FControl.GetTextLen + 1;
  LText := StrAlloc(LLen);
  FControl.GetTextBuf(LText, LLen);
  Result := LText;
end;

procedure TLMDVldWinControlAdapter.HookMessages(Sender: TObject; var Message: TMessage; var Handled: Boolean);
begin
  if (Message.Msg = WM_KEYUP) or (Message.Msg = WM_PASTE) then
  begin
    if Assigned(FValidator) then
      FValidator.Validate(Self);
  end;
  Handled := False;
end;

procedure TLMDVldWinControlAdapter.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

procedure TLMDVldWinControlAdapter.SetControl(const Value: TControl);
begin
  FControl := TWinControl(Value);
  FHook.Control := Value;
end;

procedure TLMDVldWinControlAdapter.SetOnValidationError(
  const Value: TLMDValidationErrorEvent);
begin
  FOnValidationError := Value;
end;

procedure TLMDVldWinControlAdapter.SetValidationMsgString(val: TLMDString);
begin
  FValidationMsgString := val;
end;

procedure TLMDVldWinControlAdapter.SetValidator(Validator: TLMDValidationEntity);
begin
  FValidator := Validator;
end;

function TLMDVldWinControlAdapter.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

end.
