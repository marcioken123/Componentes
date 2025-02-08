unit LMDSysMultimediaObject;
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

LMDSysMultimediaObject unit (JH)
--------------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, 
  LMDSysObject, LMDSysLog, LMDSysLogStrings, LMDSysBase, LMDSysConst;

type
  (*
    { ************************************************************************** }
    TLMDCompressionFormatItem = class (TCollectionItem)
    private
    public
    end;

    { ************************************************************************** }
    TLMDCompressionFormatsInfo = class (TCollection)
    private
      FOwner : TLMDSysObject;
      function GetItem(Index: Integer): TLMDCompressionFormatItem;
      procedure SetItem(Index: Integer; Value: TLMDCompressionFormatItem);
    protected
      function GetOwner : TPersistent; override;
    public
      function Add: TLMDCompressionFormatItem;
      constructor Create(aOwner: TLMDSysObject);

      procedure Refresh;
      property Items[Index: Integer]: TLMDCompressionFormatItem read GetItem write SetItem; default;
    end;
  *)

  { ************************************************************************** }
  TLMDMMediaItem = class(TLMDSysCollectionItem)
  private
    FDeviceID: Word;
    FMinorVer: Byte;
    FMajorVer: Byte;
    FName: string;
    FProductID: Word;
    FManufacturerID: Word;
  protected
    procedure SetDummyByte(const Value: Byte);
    procedure SetDummyString(const Value: string);
    procedure SetDummyWord(const Value: Word);
    procedure SetDummyLong(const Value: LongInt);
  published
    property DeviceID: Word read FDeviceID write SetDummyWord;
    property ManufacturerID: Word read FManufacturerID write SetDummyWord;
    property ProductID: Word read FProductID write SetDummyWord;
    property MajorVer: Byte read FMajorVer write SetDummyByte;
    property MinorVer: Byte read FMinorVer write SetDummyByte;
    property Name: string read FName write SetDummyString;
  end;

  { ************************************************************************** }
  TLMDMixerItem = class(TLMDMMediaItem)
  private
    FDestinations: DWORD;
    procedure SetDummyDword(const Value: DWORD);
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Destinations: DWORD read FDestinations write SetDummyDword;
  end;

  { ************************************************************************** }
  TLMDMixersInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDMixerItem;
    procedure SetItem(Index: Integer; Value: TLMDMixerItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDMixerItem;
    constructor Create(aOwner: TLMDSysObject);
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDMixerItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }

  TLMDVolumedItem = class(TLMDMMediaItem)
  private
    FVolumeL: Word;
    FVolumeR: Word;
  procedure SetVolume(Index: LongInt; const Value: Word); virtual; abstract;
  published
    property VolumeL: Word index 0 read FVolumeL write SetVolume;
    property VolumeR: Word index 1 read FVolumeR write SetVolume;
  end;

  TLMDauxTech = (atNone, atAUXIN, atCDAUDIO);
  TLMDauxSupport = (asNone, asVolume, asLRVolume);
  TLMDauxAudioItem = class(TLMDVolumedItem)
  private
    FTechnology: TLMDauxTech;
    FSupport: TLMDauxSupport;
    procedure SetDummySupport(const Value: TLMDauxSupport);
    procedure SetDummyTech(const Value: TLMDauxTech);
    function DauxSupportToStr(aDauxSupport : TLMDauxSupport) : string;
    function DauxTechToStr(aDauxTech : TLMDauxTech) : string;
  protected
    procedure RegisterProperties; override;
    procedure SetVolume(Index: LongInt; const Value: Word); override;
  public
    procedure Refresh;
    procedure Apply; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    property Technology: TLMDauxTech read FTechnology write SetDummyTech;
    property Support: TLMDauxSupport read FSupport write SetDummySupport;
  end;

  { ************************************************************************** }
  TLMDauxAudioInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDauxAudioItem;
    procedure SetItem(Index: Integer; Value: TLMDauxAudioItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDauxAudioItem;
    constructor Create(aOwner: TLMDSysObject);
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
    property Items[Index: Integer]: TLMDauxAudioItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDwaveFormat = (wf1M08, wf1M16, wf1S08, wf1S16, wf2M08, wf2M16, wf2S08,
    wf2S16, wf4M08, wf4M16, wf4S08, wf4S16);
  TLMDwaveFormats = set of TLMDwaveFormat;
  TLMDwaveInAudioItem = class(TLMDMMediaItem)
  private
    FFormats: TLMDwaveFormats;
    FChannels: Word;
    procedure SetDummyFormats(const Value: TLMDwaveFormats);
    function waveFormatsToStr(awaveFormats : TLMDwaveFormats) : string;
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Formats: TLMDwaveFormats read FFormats write SetDummyFormats;
    property Channels: Word read FChannels write SetDummyWord;
  end;

  { ************************************************************************** }
  TLMDwaveInAudioInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDwaveInAudioItem;
    procedure SetItem(Index: Integer; Value: TLMDwaveInAudioItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDwaveInAudioItem;
    constructor Create(aOwner: TLMDSysObject);
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
    property Items[Index: Integer]: TLMDwaveInAudioItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDwaveOutSupport = (wosLRVOLUME, wosVOLUME, wosPITCH, wosPLAYBACKRATE,
    wosSYNC, wosSAMPLEACCURATE);
  TLMDwaveOutSupports = set of TLMDwaveOutSupport;
  TLMDwaveOutAudioItem = class(TLMDVolumedItem)
  private
    FFormats: TLMDwaveFormats;
    FChannels: Word;
    FSupport: TLMDwaveOutSupports;
    procedure SetDummyFormats(const Value: TLMDwaveFormats);
    procedure SetDummySupport(const Value: TLMDwaveOutSupports);
    function waveFormatsToStr(awaveFormats : TLMDwaveFormats) : string;
    function waveOutSupportsToStr(awaveOutSupports : TLMDwaveOutSupports) : string;
  protected
    procedure RegisterProperties; override;
    procedure SetVolume(Index: LongInt; const Value: Word); override;
  public
    procedure Apply; override;
    procedure Refresh;

    function GetElementTitle : string;override;
    function GetElementDescription : string;override;
    function GetElementType : TLMDSysInfoType;override;

  published
    property Formats: TLMDwaveFormats read FFormats write SetDummyFormats;
    property Channels: Word read FChannels write SetDummyWord;
    property Support: TLMDwaveOutSupports read FSupport write SetDummySupport;
  end;

  { ************************************************************************** }
  TLMDwaveOutAudioInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDwaveOutAudioItem;
    procedure SetItem(Index: Integer; Value: TLMDwaveOutAudioItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDwaveOutAudioItem;
    constructor Create(aOwner: TLMDSysObject);
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDwaveOutAudioItem read GetItem write SetItem; default;
  end;

  TLMDmidiInAudioItem = class(TLMDMMediaItem)
  private
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  end;

  { ************************************************************************** }
  TLMDmidiInAudioInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDmidiInAudioItem;
    procedure SetItem(Index: Integer; Value: TLMDmidiInAudioItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDmidiInAudioItem;
    constructor Create(aOwner: TLMDSysObject);

    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDmidiInAudioItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDMIDITechnology = (
    mtMIDIPORT,                         //The device is a MIDI hardware port.
    mtSYNTH,                            //The device is a synthesizer.
    mtSQSYNTH,                          //The device is a square wave synthesizer.
    mtFMSYNTH,                          //The device is an FM synthesizer.
    mtMAPPER,                           //The device is the Microsoft MIDI mapper.
    mtWAVETABLE,                        //The device is a hardware wavetable synthesizer.
    mtSWSYNTH);                         //The device is a software synthesizer.

  TLMDMIDIChannel = (ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11,
    ch12, ch13, ch14, ch15);
  TLMDMIDIChannels = set of TLMDMIDIChannel;

  TLMDmidiOutSupport = (mosCACHE, mosLRVOLUME, mosSTREAM, mosVOLUME);
  TLMDmidiOutSupports = set of TLMDmidiOutSupport;
  TLMDmidiOutAudioItem = class(TLMDVolumedItem)
  private
    FChannelMask: TLMDMIDIChannels;
    FSupport: TLMDmidiOutSupports;
    FTechnology: TLMDMIDITechnology;
    FVoices: Word;
    FNotes: Word;
    procedure SetDummyChannels(const Value: TLMDMIDIChannels);
    procedure SetDummySupport(const Value: TLMDmidiOutSupports);
    procedure SetDummyTechnology(const Value: TLMDMIDITechnology);

    function MIDITechnologyToStr(aTec : TLMDMIDITechnology) : string;
    function ChannelMaskToStr(aMask : TLMDMIDIChannels) : string;
    function SupportToStr(aSupp : TLMDmidiOutSupports) : string;
  protected
    procedure RegisterProperties; override;
    procedure SetVolume(Index: LongInt; const Value: Word); override;
  public
    procedure Apply; override;
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    property Technology: TLMDMIDITechnology read FTechnology write SetDummyTechnology;
    property Voices: Word read FVoices write SetDummyWord;
    property Notes: Word read FNotes write SetDummyWord;
    property ChannelMask: TLMDMIDIChannels read FChannelMask write SetDummyChannels;
    property Support: TLMDmidiOutSupports read FSupport write SetDummySupport;
  end;

  { ************************************************************************** }
  TLMDmidiOutAudioInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDmidiOutAudioItem;
    procedure SetItem(Index: Integer; Value: TLMDmidiOutAudioItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDmidiOutAudioItem;
    constructor Create(aOwner: TLMDSysObject);
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDmidiOutAudioItem read GetItem write SetItem; default;
  end;

  TLMDjoyCap = (jcHASZ, jcHASR, jcHASU, jcHASV, jcHASPOV, jcPOV4DIR, jcPOVCTS);
  TLMDjoyCaps = set of TLMDjoyCap;
  TLMDJoystickItem = class(TLMDMMediaItem)
  private
    FRmax: LongInt;
    FZMin: LongInt;
    FRmin: LongInt;
    FZMax: LongInt;
    FYMax: LongInt;
    FPeriodMax: LongInt;
    FXMax: LongInt;
    FNumAxes: LongInt;
    FYMin: LongInt;
    FMaxAxes: LongInt;
    FNumButtons: LongInt;
    FXMin: LongInt;
    FPeriodMin: LongInt;
    FOEMVxD: string;
    FRegKey: string;
    FCaps: TLMDjoyCaps;
    FVmax: LongInt;
    FUmax: LongInt;
    FVmin: LongInt;
    FUmin: LongInt;
    FMaxButtons: LongInt;
    procedure SetDummyCaps(const Value: TLMDjoyCaps);
    function JoyCapsToStr(aCaps : TLMDjoyCaps) : string;
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Xmin: LongInt read FXMin write SetDummyLong;
    property Xmax: LongInt read FXMax write SetDummyLong;
    property Ymin: LongInt read FYMin write SetDummyLong;
    property Ymax: LongInt read FYMax write SetDummyLong;
    property Zmin: LongInt read FZMin write SetDummyLong;
    property Zmax: LongInt read FZMax write SetDummyLong;
    property NumButtons: LongInt read FNumButtons write SetDummyLong;
    property PeriodMin: LongInt read FPeriodMin write SetDummyLong;
    property PeriodMax: LongInt read FPeriodMax write SetDummyLong;
    property Rmin: LongInt read FRmin write SetDummyLong;
    property Rmax: LongInt read FRmax write SetDummyLong;
    property Umin: LongInt read FUmin write SetDummyLong;
    property Umax: LongInt read FUmax write SetDummyLong;
    property Vmin: LongInt read FVmin write SetDummyLong;
    property Vmax: LongInt read FVmax write SetDummyLong;
    property Caps: TLMDjoyCaps read FCaps write SetDummyCaps;
    property MaxAxes: LongInt read FMaxAxes write SetDummyLong;
    property NumAxes: LongInt read FNumAxes write SetDummyLong;
    property MaxButtons: LongInt read FMaxButtons write SetDummyLong;
    property RegKey: string read FRegKey write SetDummyString;
    property OEMVxD: string read FOEMVxD write SetDummyString;
  end;

  { ************************************************************************** }
  TLMDJoystickInfo = class(TLMDSysCollection)
  private
    FOwner: TLMDSysObject;
    function GetItem(Index: Integer): TLMDJoystickItem;
    procedure SetItem(Index: Integer; Value: TLMDJoystickItem);
  protected
    function GetOwner: TPersistent; override;
    function GetNumberConJoysticks:Integer;
  public
    function Add: TLMDJoystickItem;
    constructor Create(aOwner: TLMDSysObject);

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    procedure Refresh;
    property Items[Index: Integer]: TLMDJoystickItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDSysMultimediaObject = class(TLMDSysObject, ILMDSysContainer)
  private
    //    FCompressionFormats: TLMDCompressionFormatsInfo;
    FMixers: TLMDMixersInfo;
    FauxDevices: TLMDauxAudioInfo;
    FwaveInDevices: TLMDwaveInAudioInfo;
    FwaveOutDevices: TLMDwaveOutAudioInfo;
    FmidiInDevices: TLMDmidiInAudioInfo;
    FmidiOutDevices: TLMDmidiOutAudioInfo;
    FJoysticks: TLMDJoystickInfo;
  public
    //  procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    constructor Create; override;
    destructor Destroy; override;

    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    //    property CompressionFormats: TLMDCompressionFormatsInfo read FCompressionFormats write FCompressionFormats;
    property Mixers: TLMDMixersInfo read FMixers write FMixers;
    property auxDevices: TLMDauxAudioInfo read FauxDevices write FauxDevices;
    property waveInDevices: TLMDwaveInAudioInfo read FwaveInDevices write FwaveInDevices;
    property waveOutDevices: TLMDwaveOutAudioInfo read FwaveOutDevices write FwaveOutDevices;
    property midiInDevices: TLMDmidiInAudioInfo read FmidiInDevices write FmidiInDevices;
    property midiOutDevices: TLMDmidiOutAudioInfo read FmidiOutDevices write FmidiOutDevices;
    property Joysticks: TLMDJoystickInfo read FJoysticks write FJoysticks;
  end;

implementation

uses
  SysUtils
  , mmSystem
  ;

const
  cpidDeviceID = 1;
  cpidManufacturerID = 2;
  cpidProductID = 3;
  cpidMajorVer = 4;
  cpidMinorVer = 5;
  cpidName = 6;

  cpidXmin = 7;
  cpidXmax = 8;
  cpidYmin = 9;
  cpidYmax = 10;
  cpidZmin = 11;
  cpidZmax = 12;
  cpidNumButtons = 13;
  cpidPeriodMin = 14;
  cpidPeriodMax = 15;
  cpidRmin = 16;
  cpidRmax = 17;
  cpidUmin = 18;
  cpidUmax = 19;
  cpidVmin = 20;
  cpidVmax = 21;
  cpidCaps = 22;
  cpidMaxAxes = 23;
  cpidNumAxes = 24;
  cpidMaxButtons = 25;
  cpidRegKey = 26;
  cpidOEMVxD = 27;

  cpidTechnology = 28;
  cpidVoices = 29;
  cpidNotes = 30;
  cpidChannelMask = 31;
  cpidSupport = 32;

  cpidwaveFormats = 33;
  cpidwaveChannels = 34;
  cpidwaveSupport = 35;

  cpidVolumeL = 36;
  cpidVolumeR = 37;
  cpiddauxTechnology = 38;
  cpiddauxSupport = 39;

  cpidDestinations = 40;

function GetWaveFormats(Value: DWORD): TLMDwaveFormats;
begin
  Result:= [];
  if Value and WAVE_FORMAT_1M08 <> 0 then
    Result:= Result + [wf1M08];
  if Value and WAVE_FORMAT_1M16 <> 0 then
    Result:= Result + [wf1M16];
  if Value and WAVE_FORMAT_1S08 <> 0 then
    Result:= Result + [wf1S08];
  if Value and WAVE_FORMAT_1S16 <> 0 then
    Result:= Result + [wf1S16];
  if Value and WAVE_FORMAT_2M08 <> 0 then
    Result:= Result + [wf2M08];
  if Value and WAVE_FORMAT_2M16 <> 0 then
    Result:= Result + [wf2M16];
  if Value and WAVE_FORMAT_2S08 <> 0 then
    Result:= Result + [wf2S08];
  if Value and WAVE_FORMAT_2S16 <> 0 then
    Result:= Result + [wf2S16];
  if Value and WAVE_FORMAT_4M08 <> 0 then
    Result:= Result + [wf4M08];
  if Value and WAVE_FORMAT_4M16 <> 0 then
    Result:= Result + [wf4M16];
  if Value and WAVE_FORMAT_4S08 <> 0 then
    Result:= Result + [wf4S08];
  if Value and WAVE_FORMAT_4S16 <> 0 then
    Result:= Result + [wf4S16];
end;

{ -------------------------- private --------------------------------------- }

procedure TLMDSysMultimediaObject.Refresh;
begin
  FJoysticks.Refresh;
  FmidiOutDevices.Refresh;
  FmidiInDevices.Refresh;
  FwaveOutDevices.Refresh;
  FwaveInDevices.Refresh;
  FauxDevices.Refresh;
  //  FCompressionFormats.Refresh;
  FMixers.Refresh;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysMultimediaObject.Apply;
begin
  FJoysticks.Apply;
  FmidiOutDevices.Apply;
  FmidiInDevices.Apply;
  FwaveOutDevices.Apply;
  FwaveInDevices.Apply;
  FauxDevices.Apply;
  FMixers.Apply;
  //  FCompressionFormats.Apply;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMultimediaObject.GetElementCount : integer;
begin
  result := 7;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMultimediaObject.GetElement(index : integer) : TObject;
begin
  case index of
    0 : result := TObject(FJoysticks);
    1 : result := TObject(FmidiOutDevices);
    2 : result := TObject(FmidiInDevices);
    3 : result := TObject(FwaveOutDevices);
    4 : result := TObject(FwaveInDevices);
    5 : result := TObject(FauxDevices);
    6 : result := TObject(FMixers);
  else
    result:=nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMultimediaObject.GetElementTitle : string;
begin
  result := sLMDSysMultimediaGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMultimediaObject.GetElementDescription : string;
begin
  result := sLMDSysMultimediaGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMultimediaObject.GetElementType : TLMDSysInfoType;
begin
  result := itMultimediaGroup;
end;

(*
{ TLMDCompressionFormatItem }

{ TLMDCompressionFormatsInfo }

{ ---------------------------------------------------------------------------- }
function TLMDCompressionFormatsInfo.Add: TLMDCompressionFormatItem;
begin
  Result:= TLMDCompressionFormatItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCompressionFormatsInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create (TLMDCompressionFormatItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCompressionFormatsInfo.GetItem(Index: Integer): TLMDCompressionFormatItem;
begin
  Result := TLMDCompressionFormatItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDCompressionFormatsInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCompressionFormatsInfo.Refresh;
begin
  Clear;
//  acmFormatEnum( 0, nil, ACMFORMATENUMCB fnCallback, DWORD(Self), 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCompressionFormatsInfo.SetItem(Index: Integer;
  Value: TLMDCompressionFormatItem);
begin
  inherited SetItem(Index, Value);
end;
*)
{ ---------------------------------------------------------------------------- }

constructor TLMDSysMultimediaObject.Create;
begin
  inherited;
  //  FCompressionFormats:= TLMDCompressionFormatsInfo.Create( Self);
  FMixers:= TLMDMixersInfo.Create(Self);
  FauxDevices:= TLMDauxAudioInfo.Create(Self);
  FwaveInDevices:= TLMDwaveInAudioInfo.Create(Self);
  FwaveOutDevices:= TLMDwaveOutAudioInfo.Create(Self);
  FmidiInDevices:= TLMDmidiInAudioInfo.Create(Self);
  FmidiOutDevices:= TLMDmidiOutAudioInfo.Create(Self);
  FJoysticks:= TLMDJoystickInfo.Create(Self);
  FMixers.OnChangeLog:= DoLog;
  FauxDevices.OnChangeLog:= DoLog;
  FwaveInDevices.OnChangeLog:= DoLog;
  FwaveOutDevices.OnChangeLog:= DoLog;
  FmidiInDevices.OnChangeLog:= DoLog;
  FmidiOutDevices.OnChangeLog:= DoLog;
  FJoysticks.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSysMultimediaObject.Destroy;
begin
  FJoysticks.Free;
  FmidiOutDevices.Free;
  FmidiInDevices.Free;
  FwaveOutDevices.Free;
  FwaveInDevices.Free;
  FauxDevices.Free;
  FMixers.Free;
  //  FCompressionFormats.Free;
  inherited;
end;

//procedure TLMDSysMultimediaObject.GetValues(aText: TStrings);
//begin
//  inherited;
//end;

{ TLMDMixersInfo }

{ ---------------------------------------------------------------------------- }

function TLMDMixersInfo.Add: TLMDMixerItem;
begin
  Result:= TLMDMixerItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDMixersInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDMixerItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }

function TLMDMixersInfo.GetItem(Index: Integer): TLMDMixerItem;
begin
  Result:= TLMDMixerItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

function TLMDMixersInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDMixersInfo.Refresh;
var
  mxcaps: TMixerCaps;
  I: LongInt;
begin
  Clear;
DoProgress(sLMDSysMixerGroupTitle, 100, 0);
  for I:= 0 to mixerGetNumDevs - 1 do
    begin
      DoProgress(sLMDSysMixerGroupTitle, 100, Round(i*100/mixerGetNumDevs));
      mixerGetDevCaps(I, @mxcaps, SizeOf(mxcaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= mxcaps.wMid;
          FProductID:= mxcaps.wPid;
          FMajorVer:= mxcaps.vDriverVersion shr 8;
          FMinorVer:= mxcaps.vDriverVersion and $00FF;
          FName:= mxcaps.szPname;
          FDestinations:= mxcaps.cDestinations;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDMixersInfo.SetItem(Index: Integer; Value: TLMDMixerItem);
begin
  inherited SetItem(Index, Value);
end;

function TLMDMixersInfo.GetElementTitle : string;
begin result := sLMDSysMixerGroupTitle; end;

function TLMDMixersInfo.GetElementDescription : string;
begin result := sLMDSysMixerGroupDesc; end;

function TLMDMixersInfo.GetElementType : TLMDSysInfoType;
begin result := itMixerGroup; end;

{ TLMDMixerItem }

procedure TLMDMixerItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);
  FPropertiesDesc.Add(cpidDestinations, sLMDSysMixerPropTitleDestinations, sLMDSysMixerPropDescDestinations);
end;

procedure TLMDMixerItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;
  FPropertiesDesc.PropertyByID(cpidDestinations).Text := IntToStr(FDestinations);
end;

{ ---------------------------------------------------------------------------- }
function TLMDMixerItem.GetElementTitle : string;
begin
  result :=  sLMDSysMixerGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDMixerItem.GetElementDescription : string;
begin
  result := sLMDSysMixerGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDMixerItem.GetElementType : TLMDSysInfoType;
begin
  result := itMixer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMixerItem.SetDummyDword(const Value: DWORD);
begin
end;

{ TLMDauxAudioItem }
{ ---------------------------------------------------------------------------- }
function TLMDauxAudioItem.DauxSupportToStr(aDauxSupport : TLMDauxSupport) : string;
begin
  case aDauxSupport of
    asNone : result := sLMDDauxSupportNone;
    asVolume : result := sLMDDauxSupportVolume;
    asLRVolume : result := sLMDDauxSupportLRVolume;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioItem.DauxTechToStr(aDauxTech : TLMDauxTech) : string;
begin
  case aDauxTech of
    atNone : result := sLMDDauxTechNone;
    atAUXIN : result := sLMDDauxTechAUXIN;
    atCDAUDIO : result := sLMDDauxTechCDAUDIO;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);

  FPropertiesDesc.Add(cpidVolumeL, sLMDSysVolumPropTitleVolumeL, sLMDSysVolumPropDescVolumeL);
  FPropertiesDesc.Add(cpidVolumeR, sLMDSysVolumPropTitleVolumeR, sLMDSysVolumPropDescVolumeR);
  FPropertiesDesc.Add(cpiddauxTechnology, sLMDSysDauxAudioPropTitledauxTechnology, sLMDSysDauxAudioPropDescdauxTechnology);
  FPropertiesDesc.Add(cpiddauxSupport, sLMDSysDauxAudioPropTitledauxSupport, sLMDSysDauxAudioPropDescdauxSupport);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;

  FPropertiesDesc.PropertyByID(cpiddauxTechnology).Text :=  DauxTechToStr(FTechnology);
  FPropertiesDesc.PropertyByID(cpiddauxSupport).Text :=  DauxSupportToStr(FSupport);
  FPropertiesDesc.PropertyByID(cpidVolumeL).Text := IntToStr(FVolumeL);
  FPropertiesDesc.PropertyByID(cpidVolumeR).Text := IntToStr(FVolumeR);
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioItem.GetElementTitle : string;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioItem.GetElementDescription : string;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioItem.GetElementType : TLMDSysInfoType;
begin
  result:=inherited GetElementType;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.Apply;
var
  Vol: DWORD;
begin
  inherited;
  Vol:= FVolumeR shl 8 or FVolumeL;
  if PropChanged(strMMauxVolumeL) or
    PropChanged(strMMauxVolumeR) then
    begin
      WriteToLog(strMMauxVolumeL);
      WriteToLog(strMMauxVolumeR);
      auxSetVolume(FDeviceID, Vol);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.SetDummySupport(const Value: TLMDauxSupport);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.SetDummyTech(const Value: TLMDauxTech);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioItem.SetVolume(Index: LongInt; const Value: Word);
begin
  case Index of
    0:
      if FVolumeL <> Value then
        begin
          RememberChange(strMMauxVolumeL, IntToStr(FVolumeL), IntToStr(Value));
          FVolumeL:= Value;
        end;
    1:
      if FVolumeR <> Value then
        begin
          RememberChange(strMMauxVolumeR, IntToStr(FVolumeR), IntToStr(Value));
          FVolumeR:= Value;
        end;
  end;
end;

{ TLMDauxAudioInfo }

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.Add: TLMDauxAudioItem;
begin
  Result:= TLMDauxAudioItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDauxAudioInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDauxAudioItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.GetItem(Index: Integer): TLMDauxAudioItem;
begin
  Result:= TLMDauxAudioItem(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioInfo.Refresh;
var
  auxcaps: TAuxCaps;
  I: LongInt;
  Vol: DWORD;
begin
  Clear;
DoProgress(sLMDSysDauxAudioGroupTitle, 100, 0);
  for I:= 0 to auxGetNumDevs - 1 do
    begin
      DoProgress(sLMDSysDauxAudioGroupTitle, 100, Round(i*100/auxGetNumDevs));
      auxGetDevCaps(I, @auxcaps, SizeOf(auxcaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= auxcaps.wMid;
          FProductID:= auxcaps.wPid;
          FMajorVer:= auxcaps.vDriverVersion shr 8;
          FMinorVer:= auxcaps.vDriverVersion and $00FF;
          FName:= auxcaps.szPname;
          if auxcaps.wTechnology = AUXCAPS_AUXIN then
            FTechnology:= atAUXIN
          else if auxcaps.wTechnology = AUXCAPS_CDAUDIO then
            FTechnology:= atCDAUDIO
          else
            FTechnology:= atNone;
          if auxcaps.dwSupport and AUXCAPS_LRVOLUME <> 0 then
            FSupport:= asLRVolume
          else if auxcaps.dwSupport and AUXCAPS_VOLUME <> 0 then
            FSupport:= asVolume
          else
            FSupport:= asNone;

          auxGetVolume(FDeviceID, @Vol);
          FVolumeL:= Vol and $00FF;
          FVolumeR:= Vol shl 8;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDauxAudioInfo.SetItem(Index: Integer;
  Value: TLMDauxAudioItem);
begin
  inherited SetItem(Index, Value)
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.GetElementTitle : string;
begin
  result := sLMDSysDauxAudioGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.GetElementDescription : string;
begin
  result := sLMDSysDauxAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDauxAudioInfo.GetElementType : TLMDSysInfoType;
begin
  result := itDauxAudioGroup;
end;

{ TLMDwaveInAudioItem }
{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioItem.waveFormatsToStr(awaveFormats : TLMDwaveFormats) : string;
begin
  result := '';
  if wf1M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat1M08;
  if wf1M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat1M16;
  if wf1S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat1S08;
  if wf1S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat1S16;
  if wf2M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat2M08;
  if wf2M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat2M16;
  if wf2S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat2S08;
  if wf2S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat2S16;
  if wf4M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat4M08;
  if wf4M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat4M16;
  if wf4S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat4S08;
  if wf4S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat4S16;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveInAudioItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);
  FPropertiesDesc.Add(cpidwaveFormats, sLMDSyswaveOutAudioPropTitlewaweFormats, sLMDSyswaveOutAudioPropDescwaweFormats);
  FPropertiesDesc.Add(cpidwaveChannels, sLMDSyswaveOutAudioPropTitlewaweChannels, sLMDSyswaveOutAudioPropDescwaweChannels);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveInAudioItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;
  FPropertiesDesc.PropertyByID(cpidwaveFormats).Text :=  waveFormatsToStr(FFormats);
  FPropertiesDesc.PropertyByID(cpidwaveChannels).Text := IntToStr(FChannels);
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioItem.GetElementTitle : string;
begin
  result := sLMDSyswaveInAudioGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioItem.GetElementDescription : string;
begin
  result := sLMDSyswaveInAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioItem.GetElementType : TLMDSysInfoType;
begin
  result := itwaveInAudio;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveInAudioItem.SetDummyFormats(const Value: TLMDwaveFormats);
begin
end;

{ TLMDwaveInAudioInfo }
{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.Add: TLMDwaveInAudioItem;
begin
  Result:= TLMDwaveInAudioItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDwaveInAudioInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDwaveInAudioItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.GetItem(Index: Integer): TLMDwaveInAudioItem;
begin
  Result:= TLMDwaveInAudioItem(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveInAudioInfo.Refresh;
var
  waveincaps: TWaveInCaps;
  I: LongInt;
begin
  Clear;
DoProgress(sLMDSyswaveInAudioGroupTitle, 100, 0);
  for I:= 0 to waveInGetNumDevs - 1 do
    begin
      DoProgress(sLMDSyswaveInAudioGroupTitle, 100, Round(i*100/waveInGetNumDevs));
      waveInGetDevCaps(I, @waveincaps, SizeOf(waveincaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= waveincaps.wMid;
          FProductID:= waveincaps.wPid;
          FMajorVer:= waveincaps.vDriverVersion shr 8;
          FMinorVer:= waveincaps.vDriverVersion and $00FF;
          FName:= waveincaps.szPname;
          FChannels:= waveincaps.wChannels;
          FFormats:= GetWaveFormats(waveincaps.dwFormats);
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveInAudioInfo.SetItem(Index: Integer; Value: TLMDwaveInAudioItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.GetElementTitle : string;
begin
  result := sLMDSyswaveInAudioGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.GetElementDescription : string;
begin
  result := sLMDSyswaveInAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveInAudioInfo.GetElementType : TLMDSysInfoType;
begin
  result := itwaveInAudioGroup;
end;

{ TLMDMMediaItem }
{ ---------------------------------------------------------------------------- }
procedure TLMDMMediaItem.SetDummyByte(const Value: Byte);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMMediaItem.SetDummyLong(const Value: Integer);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMMediaItem.SetDummyString(const Value: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDMMediaItem.SetDummyWord(const Value: Word);
begin
end;

{ TLMDwaveOutAudioItem }
{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioItem.waveFormatsToStr(awaveFormats : TLMDwaveFormats) : string;
begin
  result := '';
  if wf1M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat1M08;
  if wf1M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat1M16;
  if wf1S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat1S08;
  if wf1S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat1S16;
  if wf2M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat2M08;
  if wf2M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat2M16;
  if wf2S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat2S08;
  if wf2S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat2S16;
  if wf4M08 in awaveFormats then result := result + ' ' + sLMDWaveFormat4M08;
  if wf4M16 in awaveFormats then result := result + ' ' + sLMDWaveFormat4M16;
  if wf4S08 in awaveFormats then result := result + ' ' + sLMDWaveFormat4S08;
  if wf4S16 in awaveFormats then result := result + ' ' + sLMDWaveFormat4S16;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioItem.waveOutSupportsToStr(awaveOutSupports : TLMDwaveOutSupports) : string;
begin
  result := '';

  if wosLRVOLUME in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportLRVOLUME;
  if wosVOLUME in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportVOLUME;
  if wosPITCH in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportPITCH;
  if wosPLAYBACKRATE in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportPLAYBACKRATE;
  if wosSYNC in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportSYNC;
  if wosSAMPLEACCURATE in awaveOutSupports then result := result + ' ' + sLMDWaveOutSupportSAMPLEACCURATE;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);

  FPropertiesDesc.Add(cpidwaveFormats, sLMDSyswaveOutAudioPropTitlewaweFormats, sLMDSyswaveOutAudioPropDescwaweFormats);
  FPropertiesDesc.Add(cpidwaveChannels, sLMDSyswaveOutAudioPropTitlewaweChannels, sLMDSyswaveOutAudioPropDescwaweChannels);
  FPropertiesDesc.Add(cpidwaveSupport, sLMDSyswaveOutAudioPropTitlewaweSupport, sLMDSyswaveOutAudioPropDescwaweSupport);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;

  FPropertiesDesc.PropertyByID(cpidwaveFormats).Text :=  waveFormatsToStr(FFormats);
  FPropertiesDesc.PropertyByID(cpidwaveChannels).Text := IntToStr(FChannels);
  FPropertiesDesc.PropertyByID(cpidwaveSupport).Text :=  waveOutSupportsToStr(FSupport);
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioItem.GetElementTitle : string;
begin
  result := sLMDSyswaveOutAudioGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioItem.GetElementDescription : string;
begin
  result := sLMDSyswaveOutAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioItem.GetElementType : TLMDSysInfoType;
begin
  result := itwaveOutAudio;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.Apply;
var
  Vol: DWORD;
begin
  inherited;
  Vol:= FVolumeR shl 8 or FVolumeL;
  if PropChanged(strMMwaveVolumeL) or
    PropChanged(strMMwaveVolumeR) then
    begin
      WriteToLog(strMMwaveVolumeL);
      WriteToLog(strMMwaveVolumeR);
      waveOutSetVolume(FDeviceID, Vol);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.SetDummyFormats(const Value: TLMDwaveFormats);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.SetDummySupport(const Value: TLMDwaveOutSupports);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioItem.SetVolume(Index: Integer;const Value: Word);
begin
  case Index of
    0:
      if FVolumeL <> Value then
        begin
          RememberChange(strMMwaveVolumeL, IntToStr(FVolumeL), IntToStr(Value));
          FVolumeL:= Value;
        end;
    1:
      if FVolumeR <> Value then
        begin
          RememberChange(strMMwaveVolumeR, IntToStr(FVolumeR), IntToStr(Value));
          FVolumeR:= Value;
        end;
  end;
end;

{ TLMDwaveOutAudioInfo }
{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.Add: TLMDwaveOutAudioItem;
begin
  Result:= TLMDwaveOutAudioItem(inherited Add)
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDwaveOutAudioInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDwaveOutAudioItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.GetItem(Index: Integer): TLMDwaveOutAudioItem;
begin
  Result:= TLMDwaveOutAudioItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioInfo.Refresh;
var
  waveoutcaps: TWaveOutCaps;
  I: LongInt;
  Vol: DWORD;
begin
  Clear;
DoProgress(sLMDSyswaveOutAudioGroupTitle, 100, 0);
  for I:= 0 to waveOutGetNumDevs - 1 do
    begin
      DoProgress(sLMDSyswaveOutAudioGroupTitle, 100, Round(i*100/waveOutGetNumDevs));
      waveOutGetDevCaps(I, @waveoutcaps, SizeOf(waveoutcaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= waveoutcaps.wMid;
          FProductID:= waveoutcaps.wPid;
          FMajorVer:= waveoutcaps.vDriverVersion shr 8;
          FMinorVer:= waveoutcaps.vDriverVersion and $00FF;
          FName:= waveoutcaps.szPname;
          FChannels:= waveoutcaps.wChannels;
          FFormats:= GetWaveFormats(waveoutcaps.dwFormats);
          FSupport:= [];
          if waveoutcaps.dwSupport and WAVECAPS_LRVOLUME <> 0 then
            FSupport:= FSupport + [wosLRVOLUME];
          if waveoutcaps.dwSupport and WAVECAPS_PITCH <> 0 then
            FSupport:= FSupport + [wosPITCH];
          if waveoutcaps.dwSupport and WAVECAPS_PLAYBACKRATE <> 0 then
            FSupport:= FSupport + [wosPLAYBACKRATE];
          if waveoutcaps.dwSupport and WAVECAPS_SYNC <> 0 then
            FSupport:= FSupport + [wosSYNC];
          if waveoutcaps.dwSupport and WAVECAPS_VOLUME <> 0 then
            FSupport:= FSupport + [wosVOLUME];
          if waveoutcaps.dwSupport and WAVECAPS_SAMPLEACCURATE <> 0 then
            FSupport:= FSupport + [wosSAMPLEACCURATE];
          waveOutGetVolume(FDeviceID, @Vol);
          FVolumeL:= Vol and $00FF;
          FVolumeR:= Vol shl 8;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDwaveOutAudioInfo.SetItem(Index: Integer; Value: TLMDwaveOutAudioItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.GetElementTitle : string;
begin
  result := sLMDSyswaveOutAudioGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.GetElementDescription : string;
begin
  result := sLMDSyswaveOutAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDwaveOutAudioInfo.GetElementType : TLMDSysInfoType;
begin
  result := itwaveOutAudioGroup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiInAudioItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiInAudioItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioItem.GetElementTitle : string;
begin
  result := sLMDSysmidiInAudioGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioItem.GetElementDescription : string;
begin
  result := sLMDSysmidiInAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioItem.GetElementType : TLMDSysInfoType;
begin
  result := itMIDIiInAudio;
end;

{ TLMDmidiInAudioInfo }
{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.Add: TLMDmidiInAudioItem;
begin
  Result:= TLMDmidiInAudioItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDmidiInAudioInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDmidiInAudioItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.GetItem(Index: Integer): TLMDmidiInAudioItem;
begin
  Result:= TLMDmidiInAudioItem(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiInAudioInfo.Refresh;
var
  LMidiInCaps: TMidiInCaps;
  I: LongInt;
begin
  Clear;
DoProgress(sLMDSysmidiInAudioGroupTitle, 100, 0);
  for I:= 0 to midiInGetNumDevs - 1 do
    begin
      DoProgress(sLMDSysmidiInAudioGroupTitle, 100, Round(i*100/midiInGetNumDevs));
      // ATTENTION: Error - used waveInGetDevCaps instead of midiInGetDevCaps
      midiInGetDevCaps(I, @LMidiInCaps, SizeOf(midiincaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= LMidiInCaps.wMid;
          FProductID:= LMidiInCaps.wPid;
          FMajorVer:= LMidiInCaps.vDriverVersion shr 8;
          FMinorVer:= LMidiInCaps.vDriverVersion and $00FF;
          FName:= LMidiInCaps.szPname;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiInAudioInfo.SetItem(Index: Integer;
  Value: TLMDmidiInAudioItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.GetElementTitle : string;
begin
  result := sLMDSysmidiInAudioGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.GetElementDescription : string;
begin
  result := sLMDSysmidiInAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiInAudioInfo.GetElementType : TLMDSysInfoType;
begin
  result := itMidiInAudioGroup;
end;

{ TLMDmidiOutAudioItem }
{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.MIDITechnologyToStr(aTec : TLMDMIDITechnology) : string;
begin
  case aTec of
    mtMIDIPORT : result := sLMDMIDITechnologyMIDIPORT;
    mtSYNTH : result := sLMDMIDITechnologySYNTH;
    mtSQSYNTH : result := sLMDMIDITechnologySQSYNTH;
    mtFMSYNTH : result := sLMDMIDITechnologyFMSYNTH;
    mtMAPPER : result := sLMDMIDITechnologyMAPPER;
    mtWAVETABLE : result := sLMDMIDITechnologyWAVETABLE;
    mtSWSYNTH : result := sLMDMIDITechnologySWSYNTH;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.ChannelMaskToStr(aMask : TLMDMIDIChannels) : string;
begin
  result := '';
  if ch0 in aMask then result := result+sLMDMIDIChannel0+' ';
  if ch1 in aMask then result := result+sLMDMIDIChannel1+' ';
  if ch2 in aMask then result := result+sLMDMIDIChannel2+' ';
  if ch3 in aMask then result := result+sLMDMIDIChannel3+' ';
  if ch4 in aMask then result := result+sLMDMIDIChannel4+' ';
  if ch5 in aMask then result := result+sLMDMIDIChannel5+' ';
  if ch6 in aMask then result := result+sLMDMIDIChannel6+' ';
  if ch7 in aMask then result := result+sLMDMIDIChannel7+' ';
  if ch8 in aMask then result := result+sLMDMIDIChannel8+' ';
  if ch9 in aMask then result := result+sLMDMIDIChannel9+' ';
  if ch10 in aMask then result := result+sLMDMIDIChannel10+' ';
  if ch11 in aMask then result := result+sLMDMIDIChannel11+' ';
  if ch12 in aMask then result := result+sLMDMIDIChannel12+' ';
  if ch13 in aMask then result := result+sLMDMIDIChannel13+' ';
  if ch14 in aMask then result := result+sLMDMIDIChannel14+' ';
  if ch15 in aMask then result := result+sLMDMIDIChannel15+' ';
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.SupportToStr(aSupp : TLMDmidiOutSupports) : string;
begin
  result := '';
  if mosCACHE in aSupp then result := result+sLMDMIDIOutSupportCACHE+' ';
  if mosLRVOLUME in aSupp then result := result+sLMDMIDIOutSupportLRVOLUME+' ';
  if mosSTREAM in aSupp then result := result+sLMDMIDIOutSupportSTREAM+' ';
  if mosVOLUME in aSupp then result := result+sLMDMIDIOutSupportVOLUME+' ';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);

  FPropertiesDesc.Add(cpidTechnology, sLMDSysmidiOutAudioPropTitleTechnology, sLMDSysmidiOutAudioPropDescTechnology);
  FPropertiesDesc.Add(cpidVoices, sLMDSysmidiOutAudioPropTitleVoices, sLMDSysmidiOutAudioPropDescVoices);
  FPropertiesDesc.Add(cpidNotes, sLMDSysmidiOutAudioPropTitleNotes, sLMDSysmidiOutAudioPropDescNotes);
  FPropertiesDesc.Add(cpidChannelMask, sLMDSysmidiOutAudioPropTitleChannelMask, sLMDSysmidiOutAudioPropDescChannelMask);
  FPropertiesDesc.Add(cpidSupport, sLMDSysmidiOutAudioPropTitleSupport, sLMDSysmidiOutAudioPropDescSupport);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;

  FPropertiesDesc.PropertyByID(cpidTechnology).Text :=  MIDITechnologyToStr(FTechnology);
  FPropertiesDesc.PropertyByID(cpidVoices).Text := IntToStr(FVoices);
  FPropertiesDesc.PropertyByID(cpidNotes).Text := IntToStr(FNotes);
  FPropertiesDesc.PropertyByID(cpidChannelMask).Text :=  ChannelMaskToStr(FChannelMask);
  FPropertiesDesc.PropertyByID(cpidSupport).Text :=  SupportToStr(FSupport);
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.GetElementTitle : string;
begin
  result := sLMDSysmidiOutAudioGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.GetElementDescription : string;
begin
  result := sLMDSysmidiOutAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioItem.GetElementType : TLMDSysInfoType;
begin
  result := itMIDIiOutAudio;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.Apply;
var
  Vol: DWORD;
begin
  inherited;
  Vol:= FVolumeR shl 8 or FVolumeL;
  if PropChanged(strMMmidiVolumeL) or
    PropChanged(strMMmidiVolumeR) then
    begin
      WriteToLog(strMMmidiVolumeL);
      WriteToLog(strMMmidiVolumeR);
      midiOutSetVolume(FDeviceID, Vol);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.SetDummyChannels(const Value: TLMDMIDIChannels);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.SetDummySupport(const Value: TLMDmidiOutSupports);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.SetDummyTechnology(const Value: TLMDMIDITechnology);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioItem.SetVolume(Index: Integer;const Value: Word);
begin
  case Index of
    0:
      if FVolumeL <> Value then
        begin
          RememberChange(strMMmidiVolumeL, IntToStr(FVolumeL), IntToStr(Value));
          FVolumeL:= Value;
        end;
    1:
      if FVolumeR <> Value then
        begin
          RememberChange(strMMmidiVolumeR, IntToStr(FVolumeR), IntToStr(Value));
          FVolumeR:= Value;
        end;
  end;
end;

{ TLMDmidiOutAudioInfo }
{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.Add: TLMDmidiOutAudioItem;
begin
  Result:= TLMDmidiOutAudioItem(inherited Add)
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDmidiOutAudioInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDmidiOutAudioItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.GetItem(Index: Integer): TLMDmidiOutAudioItem;
begin
  Result:= TLMDmidiOutAudioItem(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioInfo.Refresh;
var
  LMidiOutCaps: TMidiOutCaps;
  I: LongInt;
  J: TLMDMIDIChannel;
  Vol: DWORD;
begin
  Clear;
DoProgress(sLMDSysmidiOutAudioGroupTitle, 100, 0);
  for I:= 0 to midiOutGetNumDevs - 1 do
    begin
      DoProgress(sLMDSysmidiOutAudioGroupTitle, 100, Round(i*100/midiOutGetNumDevs));
      midiOutGetDevCaps(I, @LMidiOutCaps, SizeOf(midioutcaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= LMidiOutCaps.wMid;
          FProductID:= LMidiOutCaps.wPid;
          FMajorVer:= LMidiOutCaps.vDriverVersion shr 8;
          FMinorVer:= LMidiOutCaps.vDriverVersion and $00FF;
          FName:= LMidiOutCaps.szPname;
          case LMidiOutCaps.wTechnology of
            MOD_MIDIPORT: FTechnology:= mtMIDIPORT;
            MOD_SYNTH: FTechnology:= mtSYNTH;
            MOD_SQSYNTH: FTechnology:= mtSQSYNTH;
            MOD_FMSYNTH: FTechnology:= mtFMSYNTH;
            MOD_MAPPER: FTechnology:= mtMAPPER;
            {MOD_WAVETABLE} 6: FTechnology:= mtWAVETABLE;
            {MOD_SWSYNTH} 7: FTechnology:= mtSWSYNTH;
          end;
          FVoices:= LMidiOutCaps.wVoices;
          FNotes:= LMidiOutCaps.wNotes;
          FChannelMask:= [];
          for J:= ch0 to ch15 do
            if Ord(J) and LMidiOutCaps.wChannelMask <> 0 then
              FChannelMask:= FChannelMask + [J];

          FSupport:= [];
          if LMidiOutCaps.dwSupport and MIDICAPS_CACHE <> 0 then
            FSupport:= FSupport + [mosCACHE];
          if LMidiOutCaps.dwSupport and MIDICAPS_LRVOLUME <> 0 then
            FSupport:= FSupport + [mosLRVOLUME];
          if LMidiOutCaps.dwSupport and MIDICAPS_STREAM <> 0 then
            FSupport:= FSupport + [mosSTREAM];
          if LMidiOutCaps.dwSupport and MIDICAPS_VOLUME <> 0 then
            FSupport:= FSupport + [mosVOLUME];
          midiOutGetVolume(FDeviceID, @Vol);
          FVolumeL:= Vol and $00FF;
          FVolumeR:= Vol shl 8;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDmidiOutAudioInfo.SetItem(Index: Integer; Value: TLMDmidiOutAudioItem);
begin
  inherited SetItem(Index, Value)
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.GetElementTitle : string;
begin
  result := sLMDSysmidiOutAudioGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.GetElementDescription : string;
begin
  result := sLMDSysmidiOutAudioGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDmidiOutAudioInfo.GetElementType : TLMDSysInfoType;
begin
  result := itMidiOutAudioGroup;
end;

{ TLMDJoystickItem }
{ ---------------------------------------------------------------------------- }
procedure TLMDJoystickItem.SetDummyCaps(const Value: TLMDjoyCaps);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickItem.JoyCapsToStr(aCaps : TLMDjoyCaps) : string;
begin
  result := '';
  if jcHASZ in aCaps then result := result + ' ' + sJoyCapHASZ;
  if jcHASR in aCaps then result := result + ' ' + sJoyCapHASR;
  if jcHASU in aCaps then result := result + ' ' + sJoyCapHASU;
  if jcHASV in aCaps then result := result + ' ' + sJoyCapHASV;
  if jcHASPOV in aCaps then result := result + ' ' + sJoyCapHASPOV;
  if jcPOV4DIR in aCaps then result := result + ' ' + sJoyCapPOV4DIR;
  if jcPOVCTS in aCaps then result := result + ' ' + sJoyCapPOVCTS;
end;

{ ---------------------------- protected ------------------------------------- }
procedure TLMDJoystickItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidDeviceID, sLMDSysMultimediaCmnPropTitleDeviceID, sLMDSysMultimediaCmnPropDescDeviceID);
  FPropertiesDesc.Add(cpidManufacturerID, sLMDSysMultimediaCmnPropTitleManufacturerID, sLMDSysMultimediaCmnPropDescManufacturerID);
  FPropertiesDesc.Add(cpidProductID, sLMDSysMultimediaCmnPropTitleProductID, sLMDSysMultimediaCmnPropDescProductID);
  FPropertiesDesc.Add(cpidMajorVer, sLMDSysMultimediaCmnPropTitleMajorVer, sLMDSysMultimediaCmnPropDescMajorVer);
  FPropertiesDesc.Add(cpidMinorVer, sLMDSysMultimediaCmnPropTitleMinorVer, sLMDSysMultimediaCmnPropDescMinorVer);
  FPropertiesDesc.Add(cpidName, sLMDSysMultimediaCmnPropTitleName, sLMDSysMultimediaCmnPropDescName);

  FPropertiesDesc.Add(cpidXmin, sLMDSysJoystickPropTitleXmin, sLMDSysJoystickPropDescXmin);
  FPropertiesDesc.Add(cpidXmax, sLMDSysJoystickPropTitleXmax, sLMDSysJoystickPropDescXmax);
  FPropertiesDesc.Add(cpidYmin, sLMDSysJoystickPropTitleYmin, sLMDSysJoystickPropDescYmin);
  FPropertiesDesc.Add(cpidYmax, sLMDSysJoystickPropTitleYmax, sLMDSysJoystickPropDescYmax);
  FPropertiesDesc.Add(cpidZmin, sLMDSysJoystickPropTitleZmin, sLMDSysJoystickPropDescZmin);
  FPropertiesDesc.Add(cpidZmax, sLMDSysJoystickPropTitleZmax, sLMDSysJoystickPropDescZmax);
  FPropertiesDesc.Add(cpidNumButtons, sLMDSysJoystickPropTitleNumButtons, sLMDSysJoystickPropDescNumButtons);
  FPropertiesDesc.Add(cpidPeriodMin, sLMDSysJoystickPropTitlePeriodMin, sLMDSysJoystickPropDescPeriodMin);
  FPropertiesDesc.Add(cpidPeriodMax, sLMDSysJoystickPropTitlePeriodMax, sLMDSysJoystickPropDescPeriodMax);
  FPropertiesDesc.Add(cpidRmin, sLMDSysJoystickPropTitleRmin, sLMDSysJoystickPropDescRmin);
  FPropertiesDesc.Add(cpidRmax, sLMDSysJoystickPropTitleRmax, sLMDSysJoystickPropDescRmax);
  FPropertiesDesc.Add(cpidUmin, sLMDSysJoystickPropTitleUmin, sLMDSysJoystickPropDescUmin);
  FPropertiesDesc.Add(cpidUmax, sLMDSysJoystickPropTitleUmax, sLMDSysJoystickPropDescUmax);
  FPropertiesDesc.Add(cpidVmin, sLMDSysJoystickPropTitleVmin, sLMDSysJoystickPropDescVmin);
  FPropertiesDesc.Add(cpidVmax, sLMDSysJoystickPropTitleVmax, sLMDSysJoystickPropDescVmax);
  FPropertiesDesc.Add(cpidCaps, sLMDSysJoystickPropTitleCaps, sLMDSysJoystickPropDescCaps);
  FPropertiesDesc.Add(cpidMaxAxes, sLMDSysJoystickPropTitleMaxAxes, sLMDSysJoystickPropDescMaxAxes);
  FPropertiesDesc.Add(cpidNumAxes, sLMDSysJoystickPropTitleNumAxes, sLMDSysJoystickPropDescNumAxes);
  FPropertiesDesc.Add(cpidMaxButtons, sLMDSysJoystickPropTitleMaxButtons, sLMDSysJoystickPropDescMaxButtons);
  FPropertiesDesc.Add(cpidRegKey, sLMDSysJoystickPropTitleRegKey, sLMDSysJoystickPropDescRegKey);
  FPropertiesDesc.Add(cpidOEMVxD, sLMDSysJoystickPropTitleOEMVxD, sLMDSysJoystickPropDescOEMVxD);
end;

{ ---------------------------- public ---------------------------------------- }
procedure TLMDJoystickItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidDeviceID).Text := IntToStr(FDeviceID);
  FPropertiesDesc.PropertyByID(cpidManufacturerID).Text := IntToStr(FManufacturerID);
  FPropertiesDesc.PropertyByID(cpidProductID).Text := IntToStr(FProductID);
  FPropertiesDesc.PropertyByID(cpidMajorVer).Text := IntToStr(FMajorVer);
  FPropertiesDesc.PropertyByID(cpidMinorVer).Text := IntToStr(FMinorVer);
  FPropertiesDesc.PropertyByID(cpidName).Text := FName;

  FPropertiesDesc.PropertyByID(cpidXmin).Text := IntToStr(FXMin);
  FPropertiesDesc.PropertyByID(cpidXmax).Text := IntToStr(FXMax);
  FPropertiesDesc.PropertyByID(cpidYmin).Text := IntToStr(FYMin);
  FPropertiesDesc.PropertyByID(cpidYmax).Text := IntToStr(FYMax);
  FPropertiesDesc.PropertyByID(cpidZmin).Text := IntToStr(FZMin);
  FPropertiesDesc.PropertyByID(cpidZmax).Text := IntToStr(FZMax);
  FPropertiesDesc.PropertyByID(cpidNumButtons).Text := IntToStr(FNumButtons);
  FPropertiesDesc.PropertyByID(cpidPeriodMin).Text := IntToStr(FPeriodMin);
  FPropertiesDesc.PropertyByID(cpidPeriodMax).Text := IntToStr(FPeriodMax);
  FPropertiesDesc.PropertyByID(cpidRmin).Text := IntToStr(FRmin);
  FPropertiesDesc.PropertyByID(cpidRmax).Text := IntToStr(FRmax);
  FPropertiesDesc.PropertyByID(cpidUmin).Text := IntToStr(FUmin);
  FPropertiesDesc.PropertyByID(cpidUmax).Text := IntToStr(FUmax);
  FPropertiesDesc.PropertyByID(cpidVmin).Text := IntToStr(FVmin);
  FPropertiesDesc.PropertyByID(cpidVmax).Text := IntToStr(FVmax);
  FPropertiesDesc.PropertyByID(cpidCaps).Text :=  JoyCapsToStr(FCaps);
  FPropertiesDesc.PropertyByID(cpidMaxAxes).Text := IntToStr(FMaxAxes);
  FPropertiesDesc.PropertyByID(cpidNumAxes).Text := IntToStr(FNumAxes);
  FPropertiesDesc.PropertyByID(cpidMaxButtons).Text := IntToStr(FMaxButtons);
  FPropertiesDesc.PropertyByID(cpidRegKey).Text := FRegKey;
  FPropertiesDesc.PropertyByID(cpidOEMVxD).Text := FOEMVxD;
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickItem.GetElementTitle : string;
begin
  result := sLMDSysJoystickGroupTitle + ' ['+Name+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickItem.GetElementDescription : string;
begin
  result := sLMDSysJoystickGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickItem.GetElementType : TLMDSysInfoType;
begin
  result := itJoystick;
end;

{ TLMDJoystickInfo }
{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.Add: TLMDJoystickItem;
begin
  Result:= TLMDJoystickItem(inherited Add)
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDJoystickInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDJoystickItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.GetItem(Index: Integer): TLMDJoystickItem;
begin
  Result:= TLMDJoystickItem(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{------------------------------------------------------------------------------}
function TLMDJoystickInfo.GetNumberConJoysticks: Integer;
var
  joyinfo: TJoyInfo;
  i:Integer;
begin
  result:=0;
  for i:=0 to joyGetNumDevs-1 do
    if joyGetPos(i,@joyinfo)=JOYERR_NOERROR then Inc(result);
    end;

{ ---------------------------------------------------------------------------- }
procedure TLMDJoystickInfo.Refresh;
var
  joycaps: TJoyCaps;
  i, tmp: LongInt;

begin
  Clear;
  DoProgress(sLMDSysJoystickGroupDesc, 100, 0);

  tmp:=GetNumberConJoysticks;
  for i:= 0 to tmp-1 do
    begin
      DoProgress(sLMDSysJoystickGroupDesc, 100, Round(i*100/tmp));
      // ATTENTION: Error - used mixerInGetDevCaps instead of joyGetDevCaps
      joyGetDevCaps(I, @joycaps, SizeOf(joycaps));
      with Add do
        begin
          FDeviceID:= I;
          FManufacturerID:= joycaps.wMid;
          FProductID:= joycaps.wPid;
          //      FMajorVer:= joycaps.vDriverVersion shr 8;
          //      FMinorVer:= joycaps.vDriverVersion and $00FF;
          FName:= joycaps.szPname;
          FXMin:= joycaps.wXmin;
          FXMax:= joycaps.wXmax;
          FYMin:= joycaps.wYmin;
          FYMax:= joycaps.wYmax;
          FZMin:= joycaps.wZmin;
          FZMax:= joycaps.wZmax;
          FNumButtons:= joycaps.wNumButtons;
          FPeriodMin:= joycaps.wPeriodMin;
          FPeriodMax:= joycaps.wPeriodMax;
          FRmin:= joycaps.wRmin;
          FRmax:= joycaps.wRmax;
          FUmin:= joycaps.wUmin;
          FUmax:= joycaps.wUmax;
          FVmin:= joycaps.wVmin;
          FVmax:= joycaps.wVmax;
          FCaps:= [];
          if joycaps.wCaps and JOYCAPS_HASZ <> 0 then FCaps:= FCaps + [jcHASZ];
          if joycaps.wCaps and JOYCAPS_HASR <> 0 then FCaps:= FCaps + [jcHASR];
          if joycaps.wCaps and JOYCAPS_HASU <> 0 then FCaps:= FCaps + [jcHASU];
          if joycaps.wCaps and JOYCAPS_HASV <> 0 then FCaps:= FCaps + [jcHASV];
          if joycaps.wCaps and JOYCAPS_HASPOV <> 0 then FCaps:= FCaps + [jcHASPOV];
          if joycaps.wCaps and JOYCAPS_POV4DIR <> 0 then FCaps:= FCaps + [jcPOV4DIR];
          if joycaps.wCaps and JOYCAPS_POVCTS <> 0 then FCaps:= FCaps + [jcPOVCTS];
          FMaxAxes:= joycaps.wMaxAxes;
          FNumAxes:= joycaps.wNumAxes;
          FMaxButtons:= joycaps.wMaxButtons;
          FRegKey:= joycaps.szRegKey;
          FOEMVxD:= joycaps.szOEMVxD;
          Refresh;
        end;
    end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDJoystickInfo.SetItem(Index: Integer;Value: TLMDJoystickItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.GetElementTitle : string;
begin
  result := sLMDSysJoystickGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.GetElementDescription : string;
begin
  result := sLMDSysJoystickGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDJoystickInfo.GetElementType : TLMDSysInfoType;
begin
  result := itJoystickGroup;
end;

end.
