unit LMDClassLib;
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

LMDClassLib unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, TypInfo, LMDZLib;

type
  TLMDSerializable=class;
  { ******************************* TLMDSupportReader **************************** }
  TLMDSupportReader=class(TReader)
  public
    procedure ReadObject(aObject:TLMDSerializable; bBinaryStream:Boolean=True);
  end;

  { ******************************* TLMDSupportWriter **************************** }
  TLMDSupportWriter=class(TWriter)
  protected
    procedure WritePrefix(Flags: TFilerFlags; AChildPos: Integer);
  public
    procedure WriterObject(aObject:TLMDSerializable; bBinaryStream:Boolean=True);
  end;

  { ******************************* TLMDSerializable **************************** }
  TLMDSerializable=class(TPersistent)
  protected
    // Compressed file
    FUseZLIB : Boolean;
    // Binary or text stream format
    FBinaryStream: Boolean;
    procedure Loading;virtual;
    procedure Loaded;virtual;
  public
    constructor Create;
    // Write object to stream
    procedure WriteObject(Stream:TStream);virtual;
    // Read object from stream.
    procedure ReadObject(Stream:TStream);virtual;
    // Read object from file. File format depended on UseZLib
    function  ReadFromFile(szFileName:String):Boolean;virtual;
    // Write object to file. File format depended on UseZLib
    function  WriteToFile(szFileName:String):Boolean;virtual;
    property Compressed:Boolean read FUseZLIB write FUseZLIB default false;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  Dialogs, Windows;
  {$I C2.INC}
{$ENDIF}

{ ******************************* TLMDSerializable **************************** }
{-----------------------------------------------------------------------------}
constructor TLMDSerializable.Create;
begin
  inherited;
  FUseZLIB := false;
  FBinaryStream := True;
end;

{-----------------------------------------------------------------------------}

procedure TLMDSerializable.Loaded;
begin

end;

{-----------------------------------------------------------------------------}

procedure TLMDSerializable.Loading;
begin

end;

{-----------------------------------------------------------------------------}

function TLMDSerializable.ReadFromFile(szFileName: String): Boolean;
var
  FileStream : TFileStream;
  ZStream: TLMDDecompressionStream;
  begin
  try
    FileStream := TFileStream.Create(szFileName,fmOpenRead);
    if FUseZLIB then
    begin
      ZStream := TLMDDecompressionStream.Create(FileStream);
      try
        ReadObject(ZStream);
      finally
        ZStream.Free;
        FileStream.Free;
      end;
    end
    else
    begin
      try
        ReadObject(FileStream);
      finally
        FileStream.Free;
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDSerializable.ReadObject(Stream: TStream);
var
  Reader : TLMDSupportReader;
  MS     : TStream;
  iChildPos : Integer;
  Flag      : TFilerFlags;
begin
  Loading;
  MS := nil;
  try
    if FBinaryStream then
      MS := Stream
    else
    begin
      MS := TMemoryStream.Create;
      ObjectTextToBinary(Stream,MS);
      MS.Position := 0;
    end;
    Reader := TLMDSupportReader.Create(MS,4096);
    try
      if not FBinaryStream then
      begin
        Reader.ReadSignature;
        Reader.ReadPrefix(Flag,iChildPos);
        Reader.ReadStr;
        Reader.ReadStr;
      end;
      Reader.ReadObject(Self, FBinaryStream);
    finally
      Reader.Free;
    end;
  finally
    if not FBinaryStream then
      MS.Free;
  end;
  Loaded;
end;

{-----------------------------------------------------------------------------}

procedure TLMDSerializable.WriteObject(Stream: TStream);
var
  Writer : TLMDSupportWriter;
  MS     : TMemoryStream;
begin
  MS := TMemoryStream.Create;
  Writer := TLMDSupportWriter.Create(MS,4096);
  try
    if not FBinaryStream then
    begin
      Writer.WriteSignature;
      Writer.WritePrefix([ffInline],0);
      Writer.WriteStr(AnsiString(ClassName));
      Writer.WriteStr(AnsiString(Copy(ClassName, 2, Length(ClassName)-1)));
    end;

    Writer.WriterObject(Self, FBinaryStream);

    if not FBinaryStream then
    begin
      Writer.WriteListEnd;
      Writer.WriteListEnd;
    end;
    Writer.FlushBuffer;
    MS.Position := 0;
    if FBinaryStream then
      Stream.CopyFrom(MS,MS.Size)
    else
      ObjectBinaryToText(MS,Stream);
  finally
    Writer.Free;
    MS.Free;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDSerializable.WriteToFile(szFileName: String): Boolean;
var
  FileStream: TFileStream;
  ZStream: TLMDCompressionStream;
  begin
  try
    FileStream := TFileStream.Create(szFileName,fmCreate);
    if FUseZLIB then
    begin
      ZStream := TLMDCompressionStream.Create(clMax, FileStream);
      try
        WriteObject(ZStream);
      finally
        ZStream.Free;
        FileStream.Free;
      end;
    end
    else
    begin
      try
        WriteObject(FileStream);
      finally
        FileStream.Free;
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

{ ******************************* TLMDSupportReader **************************** }
{-----------------------------------------------------------------------------}

procedure TLMDSupportReader.ReadObject(aObject: TLMDSerializable; bBinaryStream:Boolean=True);
begin
  if bBinaryStream then
    ReadListBegin;
  while not EndOfList do
    try
      ReadProperty(aObject);
    except
    end;
  ReadListEnd;
end;

{ ******************************* TLMDSupportWriter **************************** }

procedure TLMDSupportWriter.WritePrefix(Flags: TFilerFlags; AChildPos: Integer);
begin
  inherited WritePrefix(Flags, AChildPos);
end;

{-----------------------------------------------------------------------------}

procedure TLMDSupportWriter.WriterObject(aObject: TLMDSerializable; bBinaryStream:Boolean=True);
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  if bBinaryStream then
    WriteListBegin;
  Count := GetTypeData(aObject.ClassInfo).PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(aObject.ClassInfo, PropList);
      for I := 0 to Count - 1 do
      begin
        PropInfo := PropList^[I];
        if PropInfo = nil then break;
        if IsStoredProp(aObject, PropInfo) then
          WriteProperty(aObject, PropInfo);
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
  aObject.DefineProperties(Self);
  WriteListEnd;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
