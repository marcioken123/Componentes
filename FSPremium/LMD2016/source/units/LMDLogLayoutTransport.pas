unit LMDLogLayoutTransport;
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

LMDLogLayoutTransport unit (AH)
-------------------------------
Base class for transports that needed Layout 

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  LMDObjectList, LMDLogMessage, LMDTypes, Classes, SysUtils;

type
  // Base class for Message Layouts   
  TLMDLogCustomLayout = class(TPersistent)
  protected
    FHeaderSize: Integer;
    FFooterSize: Integer;
    procedure SetParameters(const AStr: TLMDMemoryStrings); virtual; abstract;
    function GetParameters: WideString; virtual; abstract;
    function BinaryToText(const AArray: TLMDByteArray): TLMDString; virtual;
    function TextToBinary(const AString: TLMDString): TLMDByteArray; virtual;
  public
    constructor Create; virtual;
    class function GetName: WideString; virtual;
    function GetMessageAsBinary(const AMessage: TLMDLogMessage): TLMDByteArray; virtual; abstract;
    function GetHeaderAsBinary: TLMDByteArray; virtual; abstract;
    function GetFooterAsBinary: TLMDByteArray; virtual; abstract;

    function GetMessageAsText(const AMessage: TLMDLogMessage): TLMDString; virtual; abstract;
    function GetHeaderAsText: TLMDString; virtual; abstract;
    function GetFooterAsText: TLMDString; virtual; abstract;

    function GetHeaderSize: Integer; virtual;
    function GetFooterSize: Integer; virtual;
  end;

  TLMDLogCustomBinaryLayout = class(TLMDLogCustomLayout)
  public
    function GetMessageAsText(const AMessage: TLMDLogMessage): TLMDString; override;
    function GetHeaderAsText: TLMDString; override;
    function GetFooterAsText: TLMDString; override;
  end;

  TLMDLogCustomTextLayout = class(TLMDLogCustomLayout)
  public
    function GetMessageAsBinary(const AMessage: TLMDLogMessage): TLMDByteArray; override;
    function GetHeaderAsBinary: TLMDByteArray; override;
    function GetFooterAsBinary: TLMDByteArray; override;
  end;

  TLMDLogLayoutClass = class of TLMDLogCustomLayout;

  TLMDLogLayoutTransport = class(TLMDLogCustomTransport, ILMDLogTransport)
  protected
    FLayout: TLMDLogCustomLayout;
    function GetParameters: WideString; override;
    procedure SetParameters(const AValue: WideString); override;
  public
    destructor Destroy; override;
    property Layout: TLMDLogCustomLayout read FLayout;
  end;

  TLMDLogLayoutManager = class(TPersistent)
  protected
    FLayoutClasses: TLMDObjectList;

    function GetLayoutClass(const ALayoutClassType: TLMDString): TLMDLogLayoutClass;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterLayoutClass(const ALayoutClass: TLMDLogLayoutClass);
  end;

var
  LMDLogLayoutManager: TLMDLogLayoutManager;

implementation

{ ************************* TLMDLogGeneralFileLayout ************************* }
{ ---------------------------------------------------------------------------- }
function TLMDLogCustomLayout.BinaryToText(const AArray: TLMDByteArray): TLMDString;
begin
  SetLength(Result, Length(AArray) div SizeOf(Result[1]));
  Move(AArray[0], Result[1], SizeOf(Result[1]) * Length(AArray));
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomLayout.TextToBinary(const AString: TLMDString): TLMDByteArray;
begin
  SetLength(Result, SizeOf(AString[1]) * Length(AString));
  Move(AString[1], Result[0], SizeOf(AString[1]) * Length(AString));
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDLogCustomLayout.Create;
begin
  inherited;
  FHeaderSize := -1;
  FFooterSize := -1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomLayout.GetFooterSize: Integer;
begin
  if FFooterSize < 0 then
    FFooterSize := Length(GetFooterAsBinary);
  Result := FFooterSize;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomLayout.GetHeaderSize: Integer;
begin
  if FHeaderSize < 0 then
    FHeaderSize := Length(GetHeaderAsBinary);
  Result := FHeaderSize;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogCustomLayout.GetName: WideString;
begin
  raise ELMDLogException.Create('Should be overriden in child class');
end;

{ ************************ TLMDLogLayoutedTransport ************************** }
{ ---------------------------------------------------------------------------- }
destructor TLMDLogLayoutTransport.Destroy;
begin
  inherited;
  if Assigned(FLayout) then
    FreeAndNil(FLayout);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLayoutTransport.GetParameters: WideString;
begin
  Result := 'Layout=' + Layout.GetName + #13#10;
  Result := Result + FLayout.GetParameters + #13#10;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogLayoutTransport.SetParameters(const AValue: WideString);
var
  LStr: TLMDMemoryStrings;
begin
  LStr := TLMDMemoryStrings.Create;
  try
    LStr.Text := AValue;
    if Assigned(FLayout) then
      FreeAndNil(FLayout);
    FLayout := LMDLogLayoutManager.GetLayoutClass(LStr.Values['Layout']).Create;
    FLayout.SetParameters(LStr);
  finally
    LStr.Free;
  end;
end;

{ ************************* TLMDLogFileLayoutManager ************************* }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogLayoutManager.Create;
begin
  inherited;
  FLayoutClasses := TLMDObjectList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogLayoutManager.Destroy;
begin
  FLayoutClasses.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogLayoutManager.GetLayoutClass(const ALayoutClassType: TLMDString): TLMDLogLayoutClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FLayoutClasses.Count - 1 do
  begin
    if TLMDLogLayoutClass(FLayoutClasses.Items[i]).GetName = ALayoutClassType then
    begin
      Result := TLMDLogLayoutClass(FLayoutClasses.Items[i]);
      break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogLayoutManager.RegisterLayoutClass(const ALayoutClass: TLMDLogLayoutClass);
begin
  if not Assigned(GetLayoutClass(ALayoutClass.GetName)) then
    FLayoutClasses.Add(ALayoutClass)
  else
    raise ELMDLogException.CreateFmt('Transport %s is already registered', [ALayoutClass.GetName]);
end;

{ ---------------------------------------------------------------------------- }
procedure Init;
begin
  LMDLogLayoutManager := TLMDLogLayoutManager.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure DeInit;
begin
  FreeAndNil(LMDLogLayoutManager);
end;

{ ************************ TLMDLogCustomBinaryLayout ************************* }
{ ---------------------------------------------------------------------------- }
function TLMDLogCustomBinaryLayout.GetFooterAsText: TLMDString;
begin
  Result := BinaryToText(GetFooterAsBinary);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomBinaryLayout.GetHeaderAsText: TLMDString;
begin
  Result := BinaryToText(GetHeaderAsBinary);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomBinaryLayout.GetMessageAsText(
  const AMessage: TLMDLogMessage): TLMDString;
begin
  Result := BinaryToText(GetMessageAsBinary(AMessage));
end;

{ ************************* TLMDLogCustomTextLayout ************************** }
{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTextLayout.GetFooterAsBinary: TLMDByteArray;
begin
  Result := TextToBinary(GetFooterAsText);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTextLayout.GetHeaderAsBinary: TLMDByteArray;
begin
  Result := TextToBinary(GetHeaderAsText);
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogCustomTextLayout.GetMessageAsBinary(const AMessage: TLMDLogMessage): TLMDByteArray;
begin
  Result := TextToBinary(GetMessageAsText(AMessage));
end;

initialization
  Init;

finalization
  DeInit;

end.
