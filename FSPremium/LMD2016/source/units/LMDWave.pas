unit LMDWave;
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

LMDWave unit ()
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Messages, MMSystem,
  LMDObject;

type

  {TLMDWave}
  ELMDInvalidWave = class(Exception);
  ELMDErrorCheckingWave = class(Exception);

  TLMDWaveFormat=(wfUnknown, wfPCM);
  TLMDChannelMode=(cmUnknown, cmMono, cmStereo);

  TLMDWaveInfo=record
    Size:LongInt;
    SampleRate:LongInt;
    Channels:TLMDChannelMode;
    Format:TLMDWaveFormat;
    BitsCount:Word;
  end;

  (*$HPPEMIT 'namespace Lmdwave' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '#pragma option push -b-' *)
  (*$HPPEMIT 'enum TLMDSndPlayMode { sdSync, sdAsync, sdLoop };' *)
  (*$HPPEMIT '#pragma option pop' *)
  (*$HPPEMIT 'class DELPHICLASS TLMDCustomWave;' *)
  (*$HPPEMIT 'class PASCALIMPLEMENTATION TLMDCustomWave : public Lmdobject::TLMDObject ' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '	typedef Lmdobject::TLMDObject inherited;' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '	virtual bool __fastcall PlaySoundExt(TLMDSndPlayMode aValue) = 0 ;' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	bool __fastcall PlaySound(TLMDSndPlayMode aValue);' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TLMDObject.Create */ inline __fastcall virtual TLMDCustomWave(Classes::TPersistent* Owner) : Lmdobject::TLMDObject(' *)
  (*$HPPEMIT '		Owner) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCustomWave(void) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '};' *)

  {$EXTERNALSYM TLMDSndPlayMode}
  TLMDSndPlayMode=(sdSync, sdAsync, sdLoop);

  {$EXTERNALSYM TLMDCustomWave}
  {------------------- Object TLMDCustomWave ----------------------------------}
  TLMDCustomWave = class(TLMDObject)
  public
    function  PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;virtual;abstract;
    function  PlaySound(aValue:TLMDSndPlayMode):Boolean;
  end;

  {------------------------ Object TLMDWave -----------------------------------}
  TLMDWave = class(TLMDCustomWave)
  private
    FMemoryWave:TMemoryStream;
    {function  CheckIfWave(Stream:TStream):Boolean;}
    function  GetBits:Word;
    function  GetEmpty:Boolean;
    function  GetInfo:TLMDWaveInfo;
    function  GetChannelMode:TLMDChannelMode;
    function  GetFormat:TLMDWaveFormat;
    function  GetSampleRate:LongInt;
    function  GetSize:LongInt;
    Procedure NewWave(Stream:TMemoryStream);
    procedure ReadStream(size:Longint; Stream:TStream);
    procedure WriteStream(Stream:TStream; WriteSize:Boolean);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure ReadData(Stream:TStream);virtual;
    procedure WriteData(Stream:TStream);virtual;
  public
    constructor Create(Owner:TPersistent=nil);override;
    constructor CreateFromFile(const FileName:String);virtual;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent); override;
    Procedure FreeWave;
    procedure LoadCompressedFromStream(Stream: TStream);
    procedure LoadFromFile(const Filename: string);virtual;
    procedure LoadFromStream(Stream:TStream);virtual;
    procedure LoadFromStreamEx(Stream:TStream);

    function  Play:Boolean;
    function  PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;override;
    procedure SaveToFile(const Filename: string);virtual;
    procedure SaveCompressedToStream(Stream: TStream);
    procedure SaveToStream(Stream:TStream);virtual;
    procedure SaveToStreamEx(Stream:TStream);
    Procedure Stop;

    property Bits:Word read GetBits;
    property ChannelMode:TLMDChannelMode read GetChannelMode;
    property Empty:Boolean read GetEmpty;
    property Format:TLMDWaveFormat read GetFormat;
    property Info:TLMDWaveInfo read GetInfo;
    Property MemoryWave:TMemoryStream read FMemoryWave;
    property SampleRate:Longint read GetSampleRate;
    property Size:LongInt read GetSize;
  end;

  {------------------ Helper Routines -----------------------------------------}
  {WaveInfos}
  Function LMDGetWaveFileInfo(const FileName:TFileName; var info:TLMDWaveInfo):Boolean;
  Function LMDGetWaveStreamInfo(Stream:TStream; var info:TLMDWaveInfo):Boolean;

  {Wave output}
  {------------------------------------------------------------------------------}
  function LMDMMWavePossible:Boolean;

implementation
uses
  Consts, Forms, Controls,RtlConsts, 
  LMDUtils, LMDProcs, LMDStreamUtils;

{check if wave output is possible}
function LMDMMWavePossible:Boolean;
begin
  result:=WaveOutGetNumDevs<>0;
end;

{ ************************ TLMDCustomWave *************************************}
{------------------------------------------------------------------------------}
function TLMDCustomWave.PlaySound(aValue: TLMDSndPlayMode): Boolean;
begin
  result:=PlaySoundExt(aValue);
end;

{************************ Object TLMDWave *************************************}
{------------------------- Private---------------------------------------------}
function TLMDWave.GetBits:Word;
begin
  result:=0;
  if not Empty then
    result:=GetInfo.BitsCount;
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetEmpty:Boolean;
begin
  Result := (FMemoryWave = nil) or (FMemoryWave.Size=0);
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetChannelMode:TLMDChannelMode;
begin
  result:=cmUnknown;
  if not Empty then
    result:=GetInfo.Channels;
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetFormat:TLMDWaveFormat;
begin
  result:=wfUnknown;
  if not Empty then
    result:=GetInfo.Format;
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetSampleRate:LongInt;
begin
  result:=0;
  if not Empty then
    result:=GetInfo.SampleRate;
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetSize:LongInt;
begin
  result:=0;
  if not Empty then
    result:=FMemoryWave.Size;
end;

{------------------------------------------------------------------------------}
{function TLMDWave.CheckIfWave(Stream: TStream):Boolean;
var
  Info:TLMDWaveInfo;
begin
  result:=LMDGetWaveStreamInfo(Stream, info);
end;

{------------------------------------------------------------------------------}
function TLMDWave.GetInfo:TLMDWaveInfo;
var
  info:TLMDWaveInfo;

begin
  if not empty then LMDGetWaveStreamInfo(FMemoryWave, info);
  result:=info;
end;

{------------------------------------------------------------------------------}
Procedure TLMDWave.NewWave(Stream: TMemoryStream);
begin
  {if a Wave is actually Playing - stop it}
  if FMemoryWave<>nil then Stop;
  FMemoryWave.Free;
  FMemoryWave:=Stream;
  if FMemoryWave<>nil then FMemoryWave.Position:=0;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.ReadStream(size:Longint;Stream:TStream);
var
  Wave:TMemoryStream;
  info:TLMDWaveInfo;
begin
  if stream.size=0 then
    NewWave(nil)
  else
    begin
      Wave := TMemoryStream.Create;
      try
        Wave.SetSize(Size);
        Stream.ReadBuffer(Wave.Memory^, Size);
        if not LMDGetWaveStreamInfo(Wave, info) then
          ELMDInvalidWave.Create(self.ClassName+': '+SFOpenError)
        else
          NewWave(Wave);
      except
        Wave.Free;
        raise;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.WriteStream(Stream: TStream; WriteSize:Boolean);
var
  fsize: Longint;
  new : TMemoryStream;

begin
  with FMemoryWave do
    begin
      {we need an instanced FMemoryWaveObject}
      new:=TMemoryStream.Create;
      if FMemoryWave=nil then
        try
          FMemoryWave:=new;
        except
          new.free;
          raise;
        end;

      fsize := FMemoryWave.Size;
      if WriteSize then Stream.WriteBuffer(fsize, SizeOf(fSize));
      if fSize <> 0 then
        Stream.WriteBuffer(FMemoryWave.Memory^, fSize);
    end;
end;

{------------------------- Protected-------------------------------------------}
procedure TLMDWave.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, FMemoryWave <> nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.ReadData(Stream: TStream);
var
  size: Longint;
begin
  Stream.Read(size, SizeOf(size));
  ReadStream(size, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.WriteData(Stream: TStream);
begin
  {Save as Property}
  WriteStream(Stream, True);
end;

{------------------------------------------------------------------------------}
constructor TLMDWave.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
constructor TLMDWave.CreateFromFile(const FileName:String);
begin
  inherited Create;
  LoadFromFile(FileName);
end;

{------------------------------------------------------------------------------}
Destructor TLMDWave.Destroy;
begin
  {if a Wave is actually Playing - stop it}
  if FMemoryWave<>nil then Stop;
  FreeAndNil(FMemoryWave);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.Assign(Source: TPersistent);
var
  fsize:Longint;
begin
  if (Source = nil) or (Source is TLMDWave) then
    begin
      if Source <> nil then
        begin
          FMemoryWave.Free;
          FMemoryWave:=Nil;
          FMemoryWave:=TMemoryStream.Create;
          fsize:=TLMDWave(Source).Size;
          if fsize>0 then
            begin
              FMemoryWave.SetSize(fsize);
              TLMDWave(Source).MemoryWave.Position:=0;
              TLMDWave(Source).MemoryWave.ReadBuffer(FMemoryWave.Memory^, FSize);
              TLMDWave(Source).MemoryWave.Position:=0;
              FMemoryWave.Position:=0;
            end;
        end
      else
        begin
          NewWave(nil);
          Exit;
        end;
      Change;
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.FreeWave;
begin
  NewWave(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.LoadFromFile(const Filename: string);
var
  Stream: TStream;
begin
  Stream:=TFileStream.Create(Filename, fmOpenRead or fmShareDenyRead);
  try
    ReadStream(Stream.Size, Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream.Size - Stream.Position, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.LoadCompressedFromStream(Stream: TStream);
var
  tmp:TMemoryStream;
begin
  tmp:=TMemoryStream.Create;
  try
    LMDLoadCompressedStream(Stream, tmp);
    tmp.Position:=0;
    LoadFromStream(tmp);
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.LoadFromStreamEx(Stream: TStream);
var
  size:LongInt;
begin
  Stream.Read(size, SizeOf(Size));
  ReadStream(size, Stream);
end;


{------------------------------------------------------------------------------}
function TLMDWave.Play:Boolean;
begin
  result:=false;
  If Empty or not LMDMMWavePossible then Exit;
  result := Win32Check(SndPlaySound(FMemoryWave.Memory, SND_ASYNC OR SND_MEMORY OR SND_NoDefault));
end;

{------------------------------------------------------------------------------}
function TLMDWave.PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;
var
  uFlags:Word;
begin
  result:=false;
  If Empty or not LMDMMWavePossible then Exit;
  uflags:=SND_MEMORY OR SND_NODEFAULT;
  case aValue of
    sdSync :uflags:=uflags or SND_SYNC;
    sdASync:uflags:=uflags or SND_ASYNC;
    sdLoop :uflags:=uflags or SND_ASYNC OR SND_LOOP;
  end;
  result:=SndPlaySound(FMemoryWave.Memory, uflags);
end;

{------------------------------------------------------------------------------}
Procedure TLMDWave.Stop;
begin
  SndPlaySound(Nil, SND_MEMORY);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.SaveToFile(const Filename: string);
var
  Stream: TStream;
begin
  Stream:=TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.SaveToStream(Stream: TStream);
begin
  WriteStream(Stream, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.SaveCompressedToStream(Stream: TStream);
var
  tmp:TMemoryStream;
begin
  tmp:=TMemoryStream.Create;
  try
    SaveToStream(tmp);
    tmp.Position:=0;
    LMDSaveCompressedStream(tmp, Stream, tmp.size);
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWave.SaveToStreamEx(Stream:TStream);
begin
  WriteStream(Stream, True);
end;

{**************************** Helper Routines *********************************}
{------------------------------------------------------------------------------}
Function LMDGetWaveFileInfo(const FileName:TFileName; var info:TLMDWaveInfo):Boolean;
var
  Stream:TFileStream;

begin
  result:=False;
  {File exists?}
  if not FileExists(Filename) then exit;
  Stream := TFileStream.Create(Filename, fmOpenRead);
  try
    if LMDGetWaveStreamInfo(Stream, info) then result:=true;
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
Function LMDGetWaveStreamInfo(Stream:TStream; var info:TLMDWaveInfo):Boolean;
const
  FourCC_Wave=$45564157;
  FourCC_DATA=$61746164;
  FourCC_FMT0=$20746D66;
// Todo
var
  PCMFormat: PWaveFormat;
  temp: DWord;

begin

  result:=false;
  if (stream=nil) or (stream.size=0) then exit;
  try
    with stream do
      begin
        {first 4 Bytes = RIFF?}
        ReadBuffer(temp, sizeof(temp));
        if temp=FourCC_RIFF then
          begin
            ReadBuffer(temp,sizeof(temp));
            info.Size:=temp;
            ReadBuffer(temp, sizeof(temp));
            if temp=FourCC_WAVE then
              begin
                ReadBuffer(temp, sizeof(temp));
                if temp=FourCC_FMT0 then
                  begin
                    ReadBuffer(temp, sizeof(temp));
                    GetMem(PCMFormat, sizeof(TWaveFormat));
                    ReadBuffer(PCMFormat^, sizeof(TWaveFormat) -2 );
                    with info, PCMFormat^ do
                      begin
                        {get the Informations we want...}
                        case wFormatTag of
                          1:Format:=wfPCM;
                        else
                          Format:=wfunknown;
                        end;

                        {ChannelMode}
                        case nChannels of
                          1:Channels:=cmMono;
                          2:Channels:=cmStereo;
                        else
                          Channels:=cmUnknown;
                        end;
                        SampleRate:=nSamplesPerSec;
                        ReadBuffer(BitsCount, sizeof(BitsCount));
                      end;
                    FreeMem(PCMFormat, sizeof(TWaveFormat));
                    result:=true;
                  end;
              end;
          end;
        {At last, set Position to the beginning}
        Position:=0;
      end;
  except
    Raise ELMDErrorCheckingWave.Create('GetWaveData: '+SFOpenError);
  end;

end;

end.
