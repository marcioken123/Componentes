unit LMDLogBinaryLayout;
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

LMDLogFileBinaryLayout unit (AH)
--------------------------------
Binary layout for writing into File transport

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  LMDLogLayoutTransport, Classes, LMDLogMessage, LMDTypes, LMDLogFileTransport;

type
  TLMDLogBinaryLayout = class(TLMDLogCustomBinaryLayout)
  protected
    procedure SetParameters(const AStr: TLMDMemoryStrings); override;
    function GetParameters: WideString; override;
  public
    class function GetName: WideString; override;
    function GetMessageAsBinary(const AMessage: TLMDLogMessage): TLMDByteArray; override;
    function GetHeaderAsBinary: TLMDByteArray; override;
    function GetFooterAsBinary: TLMDByteArray; override;
  end;

implementation

{ ************************ TLMDLogPatternFileLayout ************************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogBinaryLayout.GetFooterAsBinary: TLMDByteArray;
begin
  // We haven't footer here
  SetLength(Result, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogBinaryLayout.GetHeaderAsBinary: TLMDByteArray;
var
  LMemStr: TMemoryStream;
  LReserved: Integer;
begin
  LMemStr := TMemoryStream.Create;
  try
    LMemStr.Write(CHeaderMarker, Length(CHeaderMarker));
    LReserved := 0;
    // Size
    LMemStr.Write(LReserved, SizeOf(LReserved));
    // Reserved for future use
    LMemStr.Write(LReserved, SizeOf(LReserved));
    LMemStr.Write(LReserved, SizeOf(LReserved));

    SetLength(Result, LMemStr.Size);
    Move(LMemStr.Memory^, Result[0], LMemStr.Size);
   finally
    LMemStr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogBinaryLayout.GetMessageAsBinary(const AMessage: TLMDLogMessage): TLMDByteArray;
var
  LMemStr: TMemoryStream;
begin
  LMemStr := TMemoryStream.Create;
  try
    AMessage.SaveToStream(LMemStr);
    SetLength(Result, LMemStr.Size);
    Move(LMemStr.Memory^, Result[0], LMemStr.Size);
  finally
    LMemStr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogBinaryLayout.GetName: WideString;
begin
  Result := 'lmd_binary_layout';
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogBinaryLayout.GetParameters: WideString;
begin
  // No parameters here
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogBinaryLayout.SetParameters(const AStr: TLMDMemoryStrings);
begin
  // No parameters here
end;

initialization
  LMDLogLayoutManager.RegisterLayoutClass(TLMDLogBinaryLayout);

end.
