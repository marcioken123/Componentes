unit LMDUpdateMessage;
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

LMDUpdateMessage unit (AIH)
-------------------
Description:
Unit provide LMD Update message object

Changes
-------
Release 0.1 (June 2008)
 - Initial Release

###############################################################################}

interface
uses
  LMDTypes, LMDWebConfig, Classes;
type
  TLMDUpdateMessageType = (umtBreakUpdate, umtError, umtScript, umtProgress, umtFinish, umtGetConfig, umtInfo, umtConfirm, umtCloseRequest);
  TLMDUpdateMessage = class(TObject)
  private
     FMsgType: TLMDUpdateMessageType;
     FDescr: TLMDString;
     FPercent: Byte;
     FCurFileName: TLMDString;
     FCurFileSize: LongWord;
     FTimeEstimateElapsed: LongWord;
     FErrCode: Integer;
     FDbID: Integer;
     FWebConfig: TLMDWebConfig;
     FResult: HRESULT;
  public
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    property MsgType: TLMDUpdateMessageType read FMsgType write FMsgType;
    property Descr: TLMDString read FDescr write FDescr;
    property Percent: Byte read FPercent write FPercent;
    property CurFileName: TLMDString read FCurFileName write FCurFileName;
    property CurFileSize: LongWord read FCurFileSize write FCurFileSize;
    property TimeEstimateElapsed: LongWord read FTimeEstimateElapsed write FTimeEstimateElapsed;
    property ErrCode: Integer read FErrCode write FErrCode;
    property DbID: Integer read FDbID write FDbID;
    property WebConfig: TLMDWebConfig read FWebConfig write FWebConfig;
    property Result: HRESULT read FResult write FResult;
  end;

implementation
uses
  LMDStrings, Math, SysUtils;
{***************************** TLMDUpdateMessage ******************************}
{--------------------------------- public -------------------------------------}
procedure TLMDUpdateMessage.SaveToStream(AStream: TStream);
var
  LInt: Integer;
begin
  AStream.Write(Byte(FMsgType), sizeOf(Byte));

  LInt := Length(FDescr);
  AStream.Write(LInt, sizeOf(Integer));

  LMDStringToStream(FDescr, AStream);

  AStream.Write(FPercent, sizeOf(Byte));

  LInt := Length(FCurFileName);
  AStream.Write(LInt, sizeOf(Integer));
  LMDStringToStream(FCurFileName, AStream);

  AStream.Write(FCurFileSize, sizeOf(LongWord));
  AStream.Write(FTimeEstimateElapsed, SizeOf(LongWord));
  AStream.Write(FErrCode, SizeOf(Integer));
  AStream.Write(FDbID, SizeOf(Integer));
  AStream.Write(FResult, SizeOf(HResult));
  LInt := IfThen(Assigned(FWebConfig), 1, 0);
  AStream.Write(LInt, SizeOf(Integer));
  if LInt = 1 then
    AStream.WriteComponent(FWebConfig);
end;

{------------------------------------------------------------------------------}
procedure TLMDUpdateMessage.LoadFromStream(AStream: TStream);
var
  LInt: Integer;
  LString: TLMDString;
  LByte: Byte;
begin
  try
    AStream.Read(LByte, SizeOf(Byte));
    FMsgType := TLMDUpdateMessageType(LByte);

    AStream.Read(LInt, SizeOf(Integer));
    SetLength(LString, LInt);
    LString := LMDStreamToString(AStream, LInt );

    FDescr := LString;
    AStream.Read(FPercent, sizeOf(Byte));
    AStream.Read(LInt, SizeOf(Integer));
    SetLength(LString, LInt);
    FCurFileName := LMDStreamToString(AStream, LInt );

    AStream.Read(FCurFileSize, sizeOf(LongWord));
    AStream.Read(FTimeEstimateElapsed, sizeOf(LongWord));
    AStream.Read(FErrCode, SizeOf(Integer));
    AStream.Read(FDbID, SizeOf(Integer));

    AStream.Read(FResult, SizeOf(HResult));
    AStream.Read(LInt, SizeOf(Integer));
    if LInt = 1 then
    begin
      Classes.RegisterClass(TLMDWebConfig);
      FWebConfig := TLMDWebConfig(AStream.ReadComponent(nil));
    end
  except
    raise
      EInOutError.Create('Couldn''t read from stream');
      end;
end;

end.
 
