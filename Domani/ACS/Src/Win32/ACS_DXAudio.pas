(*
  This file is a part of Audio Components Suite v 2.3 (Delphi version).
  Copyright (c) 2002-2005 Andrei Borovsky. All rights reserved.
  See the LICENSE file for more details.
  You can contact me at acs@compiler4.net
*)


unit ACS_DXAudio;

interface

uses
  SysUtils, Classes, Forms, ACS_Types, ACS_Classes, Windows;

const

  DS_BUFFER_SIZE = $40000;
  DS_POLLING_INTERVAL = 400; //milliseconds

type

  TDSoundWrapper = record
    dsw_pDirectSound : Pointer;
    dsw_OutputBuffer : Pointer;
    dsw_WriteOffset : LongWord;
    dsw_OutputSize : Integer;
    dsw_BytesPerFrame : Integer;
    dsw_CounterTicksPerBuffer : Int64;
    dsw_LastPlayTime : Int64;
    dsw_LastPlayCursor : Int64;
    dsw_OutputUnderflows : Int64;
    dsw_OutputRunning : LongBool;
    dsw_FramesWritten : Double;
    dsw_FramesPlayed : Double;
    dsw_pDirectSoundCapture : Pointer;
    dsw_InputBuffer : Pointer;
    dsw_ReadOffset : LongWord;
    dsw_InputSize : LongWord;
  end;

  PDSoundWrapper = ^TDSoundWrapper;

  TDSW_DeviceInfo = record
	  guid : TGUID;
  	name : array[0..127] of char;
  end;

  TDSW_Devices = record
    devcount : Integer;
  	dinfo : array [0..15] of TDSW_DeviceInfo;
  end;

  PDSW_Devices = ^TDSW_Devices;

  TDXAudioOut = class(TACSOutput)
  private
    DSW : TDSoundWrapper;
    Devices : TDSW_Devices;
    Chan, SR, BPS : Integer;
    EndOfInput, StartInput : Boolean;
    Buf : array[0..DS_BUFFER_SIZE-1] of Byte;
    FDeviceNumber : Integer;
    FDeviceCount : Integer;
    procedure SetDeviceNumber(i : Integer);
    function GetDeviceName(Number : Integer) : String;
  protected
    procedure Done; override;
    function DoOutput(Abort : Boolean):Boolean; override;
    procedure Prepare; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Pause;
    procedure Resume;
    property DeviceCount : Integer read FDeviceCount;
    property DeviceName[Number : Integer] : String read GetDeviceName;
  published
    property DeviceNumber : Integer read FDeviceNumber write SetDeviceNumber;
  end;

  TDXAudioIn = class(TACSInput)
  private
    DSW : TDSoundWrapper;
    Devices : TDSW_Devices;
    Buf : array[0..DS_BUFFER_SIZE-1] of Byte;
    FDeviceNumber : Integer;
    FDeviceCount : Integer;
    FBPS, FChan, FFreq : Integer;
    FOpened : Integer;
    FBytesToRead : Integer;
    FRecTime : Integer;
    procedure SetDeviceNumber(i : Integer);
    function GetDeviceName(Number : Integer) : String;
    procedure OpenAudio;
    procedure CloseAudio;
    function GetBPS : Integer; override;
    function GetCh : Integer; override;
    function GetSR : Integer; override;
    function GetTotalTime : Integer; override;
    procedure SetRecTime(aRecTime : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetData(Buffer : Pointer; BufferSize : Integer): Integer; override;
    procedure Init; override;
    procedure Flush; override;
    property DeviceCount : Integer read FDeviceCount;
    property DeviceName[Number : Integer] : String read GetDeviceName;
  published
    property BytesToRead : Integer read FBytesToRead write FBytesToRead;
    property DeviceNumber : Integer read FDeviceNumber write SetDeviceNumber;
    property InBitsPerSample : Integer read GetBPS write FBPS stored True;
    property InChannels : Integer read GetCh write FChan stored True;
    property InSampleRate : Integer read GetSR write FFreq stored True;
    property RecTime : Integer read FRecTime write SetRecTime;
  end;

implementation

type

  DSW_Init_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_Term_t =  procedure(dsw: PDSoundWrapper); cdecl;
  DSW_InitOutputDevice_t = function (dsw: PDSoundWrapper; const guid : TGUID) : HRESULT; cdecl;
  DSW_InitOutputBuffer_t = function (dsw: PDSoundWrapper; Wnd : HWND; bps, nFrameRate : LongWord; nChannels, bufSize : Integer): HRESULT; cdecl;
  DSW_StartOutput_t = function (dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_StopOutput_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_RestartOutput_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_GetOutputStatus_t = function(dsw: PDSoundWrapper) : DWORD; cdecl;
  DSW_WriteBlock_t = function(dsw: PDSoundWrapper; buf : PByte; numBytes : Integer) : HRESULT; cdecl;
  DSW_ZeroEmptySpace_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_QueryOutputSpace_t = function(dsw: PDSoundWrapper; var bytesEmpty ) : HRESULT; cdecl;
  DSW_Enumerate_t = function(var devices : TDSW_Devices) : HRESULT; cdecl;

  DSW_InitInputBuffer_t = function(dsw: PDSoundWrapper; bps, nFrameRate, nChannels, bufSize : Integer) : HRESULT; cdecl;
  DSW_InitInputDevice_t = function(dsw: PDSoundWrapper; const GUID : TGUID) : HRESULT; cdecl;
  DSW_StartInput_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_StopInput_t = function(dsw: PDSoundWrapper) : HRESULT; cdecl;
  DSW_ReadBlock_t = function(dsw: PDSoundWrapper; buf : PByte; numBytes : Integer) : HRESULT; cdecl;
  DSW_QueryInputFilled_t = function(dsw: PDSoundWrapper; var bytesFilled : Integer) : HRESULT; cdecl;

var

  LibdswLoaded : Boolean = False;

  DSW_Init : DSW_Init_t;
  DSW_Term : DSW_Term_t;
  DSW_InitOutputDevice : DSW_InitOutputDevice_t;
  DSW_InitOutputBuffer : DSW_InitOutputBuffer_t;
  DSW_StartOutput : DSW_StartOutput_t;
  DSW_StopOutput : DSW_StopOutput_t;
  DSW_RestartOutput : DSW_RestartOutput_t;
  DSW_GetOutputStatus : DSW_GetOutputStatus_t;
  DSW_WriteBlock : DSW_WriteBlock_t;
  DSW_ZeroEmptySpace : DSW_ZeroEmptySpace_t;
  DSW_QueryOutputSpace : DSW_QueryOutputSpace_t;
  DSW_Enumerate : DSW_Enumerate_t;

  DSW_InitInputBuffer : DSW_InitInputBuffer_t;
  DSW_InitInputDevice : DSW_InitInputDevice_t;
  DSW_StartInput : DSW_StartInput_t;
  DSW_StopInput : DSW_StopInput_t;
  DSW_ReadBlock : DSW_ReadBlock_t;
  DSW_QueryInputFilled : DSW_QueryInputFilled_t;

  Libhandle : HMODULE;


procedure TDXAudioOut.Prepare;
var
  Res : HResult;
  Wnd : HWND;
  Form : TForm;
begin
  if (FDeviceNumber >= FDeviceCount) then raise EACSException.Create('Invalid device number');
  FInput.Init;
  Chan := FInput.Channels;
  SR := FInput.SampleRate;
  BPS := FInput.BitsPerSample;
  DSW_Init(@DSW);
  Res := DSW_InitOutputDevice(@DSW, Devices.dinfo[FDeviceNumber].guid);
  if Res <> 0 then raise EACSException.Create('Failed to create DirectSound device');
  if Owner is TForm then
  begin
    Form := Owner as TForm;
    Wnd := Form.Handle;
  end else Wnd := 0;
  Res := DSW_InitOutputBuffer(@DSW, Wnd, BPS, SR, Chan, DS_BUFFER_SIZE);
  if Res <> 0 then raise EACSException.Create('Failed to create DirectSound buffer');
  StartInput := True;
  EndOfInput := False;
end;

procedure TDXAudioOut.Done;
begin
  Finput.Flush;
  DSW_Term(@DSW);
end;

function TDXAudioOut.DoOutput;
var
  Len, offs, lb : Integer;
  Stat : LongWord;
  Res : HRESULT;
  PlayTime, CTime : LongWord;
begin
  Result := True;
  if not Busy then Exit;
  if not CanOutput then
  begin
    Result := False;
    Exit;
  end;
  if StartInput then
  begin
    Len := 0;
    while Len < DS_BUFFER_SIZE do
    begin
      offs := FInput.GetData(@Buf[Len], DS_BUFFER_SIZE-Len);
      if offs = 0 then
      begin
        EndOfInput := True;
        Break;
      end;
      Inc(Len, offs);
    end;
    DSW_WriteBlock(@DSW, @Buf[0], Len);
    DSW_StartOutput(@DSW);
    StartInput := False;
  end;
  if Abort then
  begin
    DSW_StopOutput(@DSW);
    CanOutput := False;
    Result := False;
    Exit;
  end;
  if EndOfInput then
  begin
    CanOutput := False;
    PlayTime := Round(DS_BUFFER_SIZE/(Chan*(BPS div 8)*SR))*1000;
    CTime := 0;
    while CTime < PlayTime do
    begin
      Sleep(100);
      DSW_ZeroEmptySpace(@DSW);
      Inc(CTime, 100);
    end;
    DSW_StopOutput(@DSW);
    Result := False;
    Exit;
  end;
  Sleep(DS_POLLING_INTERVAL);
  DSW_QueryOutputSpace(@DSW, lb);
  lb := lb - (lb mod 1024);
  Len := 0;
  while Len < lb do
  begin
    offs := Finput.GetData(@Buf[Len], lb-Len);
    if offs = 0 then Break;
    Inc(Len, offs);
  end;
  DSW_WriteBlock(@DSW, @Buf[0], Len);
  if offs = 0 then
  begin
    DSW_ZeroEmptySpace(@DSW);
    EndOfInput := True;
  end;
end;

constructor TDXAudioOut.Create;
begin
  inherited Create(AOwner);
  if not (csDesigning	in ComponentState) then
  begin
    if not LibdswLoaded then
    raise EACSException.Create('Library dswrapper.dll not found');
  end;
  if LibdswLoaded then DSW_Enumerate(Devices);
  FDeviceCount := Devices.devcount;
end;

destructor TDXAudioOut.Destroy;
begin
  if LibdswLoaded then DSW_Term(@DSW);
  inherited Destroy;
end;

procedure TDXAudioOut.Pause;
begin
  if EndOfInput then Exit;
  DSW_StopOutput(@DSW);
  inherited Pause;
end;

procedure TDXAudioOut.Resume;
begin
  if EndOfInput then Exit;
  DSW_RestartOutput(@DSW);
  inherited Resume;
end;

procedure TDXAudioOut.SetDeviceNumber(i : Integer);
begin
  FDeviceNumber := i
end;

function TDXAudioOut.GetDeviceName(Number : Integer) : String;
begin
  if (Number < FDeviceCount) then Result := PChar(@(Devices.dinfo[Number].Name[0]))
  else Result := '';
end;

constructor TDXAudioIn.Create;
begin
  inherited Create(AOwner);
  FBPS := 8;
  FChan := 1;
  FFreq := 8000;
  FSize := -1;
  if not (csDesigning	in ComponentState) then
  begin
    if not LibdswLoaded then
    raise EACSException.Create('Library dswrapper.dll not found');
  end;
  if LibdswLoaded then DSW_Enumerate(Devices);
  FDeviceCount := Devices.devcount;
end;

destructor TDXAudioIn.Destroy;
begin
  if LibdswLoaded then DSW_Term(@DSW);
  inherited Destroy;
end;

procedure TDXAudioIn.OpenAudio;
var
  Res : HResult;
begin
  if FOpened = 0 then
  begin
    DSW_Init(@DSW);
    if not Assigned(DSW_InitInputDevice) then raise EACSException.Create('Failed');
    Res := DSW_InitInputDevice(@DSW, Devices.dinfo[FDeviceNumber].guid);
    if Res <> 0 then raise EACSException.Create('Failed to create DirectSound device');
    Res := DSW_InitInputBuffer(@DSW, FBPS, FFreq, FChan, DS_BUFFER_SIZE);
    if Res <> 0 then raise EACSException.Create('Failed to create DirectSound buffer');
  end;
  Inc(FOpened);
end;

procedure TDXAudioIn.CloseAudio;
begin
  if FOpened = 1 then DSW_Term(@DSW);
  if FOpened > 0 then Dec(FOpened);
end;

function TDXAudioIn.GetBPS;
begin
  Result := FBPS;
end;

function TDXAudioIn.GetCh;
begin
  Result := FChan;
end;

function TDXAudioIn.GetSR;
begin
  Result := FFreq;
end;

procedure TDXAudioIn.Init;
begin
  if Busy then raise EACSException.Create('The component is busy');
  if (FDeviceNumber >= FDeviceCount) then raise EACSException.Create('Invalid device number');
  if FRecTime > 0 then FBytesToRead := FRecTime*FFreq*FChan*(FBPS div 8);
  BufEnd := 0;
  BufStart := 1;
  FPosition := 0;
  Busy := True;
  FSize := FBytesToRead;
  OpenAudio;
  DSW_StartInput(@DSW);
end;

procedure TDXAudioIn.Flush;
begin
  DSW_StopInput(@DSW);
  CloseAudio;
  Busy := False;
end;

function TDXAudioIn.GetData;
var
  l : Integer;
begin
  if not Busy then  raise EACSException.Create('The Stream is not opened');
  if  (FBytesToRead >=0) and (FPosition >= FBytesToRead) then
  begin
    Result := 0;
    Exit;
  end;
  if BufStart >= BufEnd then
  begin
    BufStart := 0;
    Sleep(DS_POLLING_INTERVAL);
    DSW_QueryInputFilled(@DSW, l);
    if l > DS_BUFFER_SIZE then l := DS_BUFFER_SIZE; (* We have lost some data.
                                                       Generally this shouldn't happen. *)
    l := l - (l mod 1024);
    DSW_ReadBlock(@DSW, @Buf[0], l);
    BufEnd := l;
  end;
  if BufferSize < (BufEnd - BufStart)
  then Result := BufferSize
  else Result := BufEnd - BufStart;
  Move(Buf[BufStart], Buffer^, Result);
  Inc(BufStart, Result);
  Inc(FPosition, Result);
end;

procedure TDXAudioIn.SetRecTime;
begin
  FRecTime := aRecTime;
  if FRecTime > 0 then FBytesToRead := FRecTime*FFreq*FChan*(FBPS div 8)
  else FBytesToRead := -1;
end;

procedure TDXAudioIn.SetDeviceNumber(i : Integer);
begin
  FDeviceNumber := i
end;

function TDXAudioIn.GetDeviceName(Number : Integer) : String;
begin
  if (Number < FDeviceCount) then Result := PChar(@(Devices.dinfo[Number].Name[0]))
  else Result := '';
end;

function TDXAudioIn.GetTotalTime : Integer;
var
  BytesPerSec : Integer;
begin
  BytesPerSec := FFreq*FChan*(FBPS div 8);
  Result := Round(FBytesToRead/BytesPerSec);
end;

initialization

  Libhandle := LoadLibraryEx('dswrapper.dll', 0, 0);

  if Libhandle <> 0 then
  begin
    LibdswLoaded := True;

    DSW_Init := GetProcAddress(Libhandle, 'DSW_Init');
    DSW_Term := GetProcAddress(Libhandle, 'DSW_Term');
    DSW_InitOutputDevice := GetProcAddress(Libhandle, 'DSW_InitOutputDevice');
    DSW_InitOutputBuffer := GetProcAddress(Libhandle, 'DSW_InitOutputBuffer');
    DSW_StartOutput := GetProcAddress(Libhandle, 'DSW_StartOutput');
    DSW_StopOutput := GetProcAddress(Libhandle, 'DSW_StopOutput');
    DSW_RestartOutput := GetProcAddress(Libhandle, 'DSW_RestartOutput');
    DSW_GetOutputStatus := GetProcAddress(Libhandle, 'DSW_GetOutputStatus');
    DSW_WriteBlock := GetProcAddress(Libhandle, 'DSW_WriteBlock');
    DSW_ZeroEmptySpace := GetProcAddress(Libhandle, 'DSW_ZeroEmptySpace');
    DSW_QueryOutputSpace := GetProcAddress(Libhandle, 'DSW_QueryOutputSpace');
    DSW_Enumerate := GetProcAddress(Libhandle, 'DSW_Enumerate');
    DSW_InitInputDevice := GetProcAddress(Libhandle, 'DSW_InitInputDevice');
    DSW_InitInputBuffer := GetProcAddress(Libhandle, 'DSW_InitInputBuffer');
    DSW_StartInput := GetProcAddress(Libhandle, 'DSW_StartInput');
    DSW_StopInput := GetProcAddress(Libhandle, 'DSW_StopInput');
    DSW_ReadBlock := GetProcAddress(Libhandle, 'DSW_ReadBlock');
    DSW_QueryInputFilled := GetProcAddress(Libhandle, 'DSW_QueryInputFilled');

  end;

finalization

  if Libhandle <> 0 then FreeLibrary(Libhandle);

end.
