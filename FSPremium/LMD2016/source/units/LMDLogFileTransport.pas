unit LMDLogFileTransport;
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

LMDLogFileTransport unit (AH)
-----------------------------
Transport that helps store log information into files.

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  LMDLogLayoutTransport, SysUtils, Classes, LMDThreads, LMDFiles, LMDTypes,
  LMDLogMessage, LMDZLib, LMDStrings, LMDProcs, LMDObjectList;

type
  TLMDLogFileTransport = class(TLMDLogLayoutTransport, ILMDLogTransport)
  private
    FFileName: TLMDString;
    FKeepOpen: Boolean;
    FAppended: Boolean;
    FBackup: Boolean;
    procedure SetFileName(const Value: TLMDString);
  protected
    function CreateSendThread: TThread; override;
    function GetParameters: WideString; override;
    procedure SetParameters(const AValue: WideString); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function GetName: WideString; override;
    property FileName: TLMDString read FFileName write SetFileName;
    property KeepOpen: Boolean read FKeepOpen write FKeepOpen;
    property Appended: Boolean read FAppended write FAppended;
    property Parameters: WideString read GetParameters write SetParameters;
  end;

  TLMDLogFileSendThread = class(TLMDLogCustomSendThread)
  protected
    FOwner: TLMDLogFileTransport;
    FHeaderSize: Integer;
    FFileStream: TLMDFileStream;
    function DoMessage(AMessage: TLMDLogMessage): Boolean; override;
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
    destructor Destroy; override;
  end;

implementation

uses
  Windows;

{ ***************************** TLMDFileTransport **************************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDLogFileTransport.Create;
begin
  inherited Create;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogFileTransport.CreateSendThread: TThread;
begin
  Result := TLMDLogFileSendThread.Create(False, Self);
end;

destructor TLMDLogFileTransport.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogFileTransport.GetName: WideString;
begin
  Result := 'lmd_file_log';
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogFileTransport.GetParameters: WideString;
begin
  Result := inherited GetParameters;
  Result := Result + 'FileName=' + FFileName + #13#10;
  Result := Result + 'KeepOpen=' + IntToStr(Integer(FKeepOpen)) + #13#10;
  Result := Result + 'Appended=' + IntToStr(Integer(FAppended)) + #13#10;
  Result := Result + 'Backup=' + IntToStr(Integer(FBackup)) + #13#10;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogFileTransport.SetFileName(const Value: TLMDString);
begin
  FFileName := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogFileTransport.SetParameters(const AValue: WideString);
var
  LStr: TLMDMemoryStrings;

  function LMDStrToBool(const AStr: TLMDString): Boolean;
  begin
    if AStr <> '' then
      Result := Boolean(StrToInt(AStr))
    else
      Result := False;
  end;

begin
  inherited SetParameters(AValue);
  LStr := TLMDMemoryStrings.Create;
  try
    try
      LStr.Text := AValue;
      FFileName := LStr.Values['FileName'];
      FKeepOpen := LMDStrToBool(LStr.Values['KeepOpen']);
      FAppended := LMDStrToBool(LStr.Values['Appended']);
      FBackup := LMDStrToBool(LStr.Values['Backup']);
    except
      raise ELMDLogException.CreateFmt('Parameters %s are incorrect', [AValue]);
    end;
  finally
    LStr.Free;
  end;
end;

{**************************** TLMDFileSendThread ******************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDLogFileSendThread.Create(ACreateSuspended: Boolean; AOwner: TLMDLogCustomTransport);
var
  LHeader: TLMDByteArray;
begin
  inherited Create(ACreateSuspended, AOwner);
  FOwner := TLMDLogFileTransport(AOwner);

  // Here we just create file if it doesn't exists or Log can't be append
  if (not FOwner.Appended) or (not FileExists(FOwner.FileName)) then
    FFileStream := TLMDFileStream.Create(FOwner.FileName, fmCreate)
  else
    FFileStream := TLMDFileStream.Create(FOwner.FileName, fmOpenWrite or fmShareDenyWrite);

  // Writing header
  LHeader := FOwner.Layout.GetHeaderAsBinary;
  FFileStream.Write(LHeader[0], Length(LHeader));
  FHeaderSize := FOwner.Layout.GetHeaderSize;

  FreeAndNil(FFileStream);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDLogFileSendThread.Destroy;
var
  LFooter: TLMDByteArray;
begin
  if not Assigned(FFileStream) then
    FFileStream := TLMDFileStream.Create(FOwner.FileName, fmOpenWrite or fmShareDenyWrite);
  // Writing footer
  LFooter := FOwner.Layout.GetFooterAsBinary;
  FFileStream.Write(LFooter[0], Length(LFooter));

  FreeAndNil(FFileStream);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLogFileSendThread.DoMessage(AMessage: TLMDLogMessage): Boolean;
var
  LMessage: TLMDByteArray;
begin
  Result := True;
  SetLength(LMessage, 0);

  // FlushFileBuffers(FFileStream.Handle);
  if (not FOwner.KeepOpen) or (not Assigned(FFileStream)) then
  begin
    if Assigned(FFileStream) then
      FreeAndNil(FFileStream);
    FFileStream := TLMDFileStream.Create(FOwner.FileName, fmOpenWrite or fmShareDenyWrite);
    if FOwner.Appended then
    begin
      FFileStream.Seek(FOwner.Layout.GetFooterSize, soFromEnd);
      SetEndOfFile(FFileStream.Handle);
    end
    else
      FFileStream.Seek(FOwner.Layout.GetHeaderSize, soFromBeginning);
  end;
  try
    try
      LMessage := FOwner.Layout.GetMessageAsBinary(AMessage);
      FFileStream.Write(LMessage[0], Length(LMessage));
    except
      Result := False;
    end;
  finally
    if (not FOwner.KeepOpen) then
      FreeAndNil(FFileStream);
    FreeAndNil(AMessage);
  end;
end;

initialization
  LMDLogManager.RegisterTransportClass(TLMDLogFileTransport);

end.
