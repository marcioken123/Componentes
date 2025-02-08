unit LMDRangeValidator;
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

LMDRangeValidator unit (RS)
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Dialogs,
  LMDVldBase;

type

  TLMDRangeValidator = class(TLMDCustomValidator)
  private
    FValueType: TLMDValueType;
    FLowLimit: string;
    FHighLimit: string;
  protected
    function PerformValidation(value: string): TLMDErrorLevel; override;
    procedure HandleConvertError;
  public
    function GetMessage(Sender: ILMDValidatedControl; errorLevel: TLMDErrorLevel): string; override;
  published
    property ValueType: TLMDValueType read FValueType write FValueType;
    property HighLimit: string read FHighLimit write FHighLimit;
    property LowLimit: string read FLowLimit write FLowLimit;
  end;

implementation

{****************** Object TLMDRangeValidator *********************************}
{------------------------- Protected ------------------------------------------}
function TLMDRangeValidator.PerformValidation(value: string): TLMDErrorLevel;
var
  vl: string;
begin
  Result := 0;
  vl := Trim(value);
  if vl = '' then
    Exit;
  try
    begin
      case Self.ValueType of
        vtNumber: if (StrToFloat(vl) < StrToFloat(Self.LowLimit))
          or (StrToFloat(vl) > StrToFloat(Self.HighLimit)) then
            Result := Self.ErrorLevel;
        vtString: if (vl < Self.LowLimit)
          or (vl > Self.HighLimit) then
            Result := Self.ErrorLevel;
        vtDate: if (StrToDate(vl) < StrToDate(Self.LowLimit))
          or (StrToDate(vl) > StrToDate(Self.HighLimit)) then
            Result := Self.ErrorLevel;
      end;
    end
  except
    on EConvertError do
      HandleConvertError;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRangeValidator.HandleConvertError;
begin

end;

{------------------------- Public ---------------------------------------------}
function TLMDRangeValidator.GetMessage(Sender: ILMDValidatedControl;
  errorLevel: TLMDErrorLevel): string;
begin
  if errorLevel = 0 then
    Result := ''
  else
  begin
    Result := StringReplace(Self.ErrorMessage, '%F', Sender.ValidationMsgString,
      [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, '%EH', Self.HighLimit, [rfReplaceAll,
      rfIgnoreCase]);
    Result := StringReplace(Result, '%EL', Self.LowLimit, [rfReplaceAll,
      rfIgnoreCase]);
  end;
end;

end.

