unit LMDLogPatternLayout;
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

LMDLogFilePatternLayout unit (AH)
---------------------------------
Patterned layout to write text logs with File transport
Available macros in pattern:
%datetime - Datetime of message
%session - Name of session
%level - Level of session
%processid - Process ID
%threadid - Thread ID
%application - Name of Application
%host - Name of computer which is source of message
%user - Name of user from message
%title - Title of message

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface
uses
  LMDLogLayoutTransport, Classes, SysUtils, LMDStrings, LMDLogMessage, LMDTypes, LMDLogFileTransport;

type
  TLMDLogPatternLayout = class(TLMDLogCustomTextLayout)
  private
    FPattern: TLMDString;
    FIndent: Boolean;
  protected
    procedure SetParameters(const AStr: TLMDMemoryStrings); override;
    function GetParameters: WideString; override;
    function ApplyPattern(const AMessage: TLMDLogMessage): TLMDString;
  public
    class function GetName: WideString; override;
    function GetMessageAsText(const AMessage: TLMDLogMessage): TLMDString; override;
    function GetHeaderAsText: TLMDString; override;
    function GetFooterAsText: TLMDString; override;

    property Pattern: TLMDString read FPattern write FPattern;
    property Indent: Boolean read FIndent write FIndent;
  end;

implementation

{ ************************* TLMDLogBinaryFileLayout ************************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogPatternLayout.ApplyPattern(const AMessage: TLMDLogMessage): TLMDString;

  // TODO: Add format parser for DateTime
  function ReplaceMacros(const AMacros: TLMDString): TLMDString;
  begin
    Result := '%' + AMacros;
    if LMDLowerCase(AMacros) = 'datetime' then
      Result := DateTimeToStr(AMessage.DateTimeSent);
    if LMDLowerCase(AMacros) = 'processid' then
      Result := IntToHex(AMessage.ProcessId, 8);
    if LMDLowerCase(AMacros) = 'threadid' then
      Result := IntToHex(AMessage.ThreadId, 8);
    if LMDLowerCase(AMacros) = 'host' then
      Result := AMessage.ComputerName;
    if LMDLowerCase(AMacros) = 'user' then
      Result := AMessage.UserName;
    if LMDLowerCase(AMacros) = 'application' then
      Result := AMessage.UserName;
    if LMDLowerCase(AMacros) = 'level' then
      Result := LMDLogManager.GetLogLevelNameByValue(AMessage.LogLevel);
    if LMDLowerCase(AMacros) = 'title' then
      Result := AMessage.Title;
  end;

var
  i: Integer;
  LState: Integer;
  LMacros: TLMDString;
begin
  i := 1;
  LState := 0;
  Result := '';
  while (i <= Length(FPattern)) do
  begin
    case LState of
    0:
      begin
        if FPattern[i] = '%' then
        begin
          LState := 1;
          LMacros := '';
        end
        else
          Result := Result + FPattern[i];
      end;
    1:
      begin
        if (not (AnsiChar(FPattern[i]) in ['A'..'Z', 'a'..'z'])) then
        begin
          Result := Result + ReplaceMacros(LMacros);
          LState := 0;
          Dec(i);
        end
        else
          LMacros := LMacros + FPattern[i];
      end;
    end;
    Inc(i);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogPatternLayout.GetFooterAsText: TLMDString;
begin
  Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogPatternLayout.GetHeaderAsText: TLMDString;
begin
  Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogPatternLayout.GetMessageAsText(const AMessage: TLMDLogMessage): TLMDString;
begin
  Result := ApplyPattern(AMessage) + #13#10;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogPatternLayout.GetName: WideString;
begin
  Result := 'lmd_patterned_layout';
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogPatternLayout.GetParameters: WideString;
begin
  Result := 'Pattern=' + FPattern + #13#10;
  Result := Result + 'Indent=' + IntToStr(Integer(FIndent));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogPatternLayout.SetParameters(const AStr: TLMDMemoryStrings);
begin
  FPattern := AStr.Values['Pattern'];
  if AStr.Values['Indent'] <> '' then
    FIndent := Boolean(StrToInt(AStr.Values['Indent']))
  else
    FIndent := False;
end;

initialization
  LMDLogLayoutManager.RegisterLayoutClass(TLMDLogPatternLayout);

end.
