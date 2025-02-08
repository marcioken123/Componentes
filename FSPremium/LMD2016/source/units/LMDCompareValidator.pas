unit LMDCompareValidator;
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

LMDCompareValidator unit (RS)
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes,
  LMDVldBase;

type

  TLMDCompareValidator = class(TLMDCustomValidator)
  protected
    FRefControl: ILMDValidatedControl;
    FRefSign: TLMDRefSign;
    FValueType: TLMDValueType;
    FLoopFlag: boolean;
    FValidateRefControl: boolean;
    procedure SetRefControl(const Value: ILMDValidatedControl);
    function CompliesWithConstraint(val: string; refVal: string; sign:
      TLMDRefSign): boolean;
    function PerformValidation(value: string): TLMDErrorLevel; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property RefSign: TLMDRefSign read FRefSign write FRefSign;
    property ValueType: TLMDValueType read FValueType write FValueType;
    property RefControl: ILMDValidatedControl read FRefControl write SetRefControl;
    property ValidateRefControl: boolean read FValidateRefControl write FValidateRefControl default false;
  end;

implementation

{****************** Object TLMDCompareValidator *******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDCompareValidator.SetRefControl(const Value: ILMDValidatedControl);
begin
  ReferenceInterface(Self.FRefControl, opRemove);
  Self.FRefControl := Value;
  ReferenceInterface(Self.FRefControl, opInsert);
end;

{------------------------------------------------------------------------------}
function TLMDCompareValidator.CompliesWithConstraint(val, refVal: string;
  sign: TLMDRefSign): boolean;
begin
  Result := true;
  if (val = '') or (refVal = '') then
  begin
    Result := val = refVal;
    Exit;
  end;
  try
    begin
      case sign of
        rsLess: case Self.ValueType of
            vtNumber: Result := StrToFloat(val) < StrToFloat(refVal);
            vtString: Result := val < refVal;
            vtDate: Result := StrToDate(val) < StrToDate(refVal);
          end;
        rsGreater: case Self.ValueType of
            vtNumber: Result := StrToFloat(val) > StrToFloat(refVal);
            vtString: Result := val > refVal;
            vtDate: Result := StrToDate(val) > StrToDate(refVal);
          end;
        rsEqual: case Self.ValueType of
            vtNumber: Result := StrToFloat(val) = StrToFloat(refVal);
            vtString: Result := val = refVal;
            vtDate: Result := StrToDate(val) = StrToDate(refVal);
          end;
      end;
    end
  except
    on EConvertError do
    begin
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCompareValidator.PerformValidation(
  value: string): TLMDErrorLevel;
begin
  Result := 0;
  if Self.FLoopFlag then
    Exit;
  if Assigned(Self.FRefControl) then
  begin
    if not Self.CompliesWithConstraint(value,
      Self.FRefControl.GetValueToValidate, Self.RefSign) then
      Result := Self.ErrorLevel;
    if Self.ValidateRefControl and Assigned(Self.FRefControl.Validator) then
    begin
      Self.FLoopFlag := true;
      Self.FRefControl.Validator.Validate(Self.FRefControl);
      Self.FLoopFlag := false;
    end;
  end;
end;

{------------------------- Public --------------------------------------------}
procedure TLMDCompareValidator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Assigned(Self.RefControl) and AComponent.IsImplementorOf(Self.RefControl) then
    Self.FRefControl := nil;
end;

end.

