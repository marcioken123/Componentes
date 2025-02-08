unit LMDIniCtrl;
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

LMDIniCtrl unit (RM)
-------------------

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, IniFiles, LMDProcs, LMDCustomComponent;

const
  IDS_ROOT: String='#ROOT';  {--> TLMDIniCtrl, Registry: Use Root Section for Key}
  IDS_COMMON: String='Common';

type
  TLMDIniCtrl=class;

  {-------------------  Class TLMDMemIniFile ---------------------------------}
  TLMDMemIniFile = class(TMemIniFile)
  public
    destructor Destroy; override;

    procedure RenameSection(const AOldName, ANewName: string);
    procedure LoadFromStream(AValue: TStream);
    procedure Normalize(ARemToken: string = ''; TrimValue: boolean = true);
  end;

  // 7.0: extended Encode/Decode functionality
  TLMDIniCryptMode=(icmKey, icmTextKey, {--Y add additional here <---}icmCustom);
  TLMDIniCryptEvent=procedure(Sender:TObject; var data:String) of object;
  //

  // IniCtrl-Event
  TLMDIniCtrlEvent=procedure(Sender:TObject; aIniCtrl:TLMDIniCtrl; Section:String) of object;

  {specifies, which TLMDIniCtrl (global, link or none) should be used}
  TLMDIniUse=(ioUseLink, ioUseGlobal, ioNone);
  TLMDIniTarget=(itIniFile, itRegistry, itAuto, itMemIniFile);
  TLMDRegRootKey=(rpClassesRoot, rpCurrentUser, rpLocalMachine, rpUsers,
                  rpCurrentConfig, rpDynData);

  {**************************** TLMDIniCtrl ***********************************}
  {----------------------------------------------------------------------------}
  TLMDIniCtrl = class(TLMDCustomComponent)
  private
    {IniFiles}
    FCommon: Boolean;
    FNetUser:Boolean;

    FIniFile,
    FLastSection,
    FUser: String;
    FIniPrefix : TLMDPathPrefix;  {location of IniFile}
    // 7.1
    FMemIniFile: TLMDMemIniFile;
    // ----
    {nur Registry}
    FRootKey:TLMDRegRootKey;    {main root in registry}
    FRemoteComputer,
    FRegPath:String;

    {General}
    FAlphaCounter:Boolean;
    FMaxEntries:Byte;           {max entries for saving TStrings-List}
    FTarget, FHTarget:TLMDIniTarget;

    //5.05
    FKey:Word;
    FCoded:Boolean;
    // 7.0
    FCryptMode: TLMDIniCryptMode;
    FOnEncodeString: TLMDIniCryptEvent;
    FOnDecodeString: TLMDIniCryptEvent;
    FMemIniUtf8: Boolean;
    // ---

    {IniFiles}
    procedure SetIniFile(const aValue:String);
    procedure SetNetUser(aValue:Boolean);
    procedure SetAlphaCounter(aValue:Boolean);
    procedure SetMaxEntries(aValue:Byte);

    {general}
    function GetCounterIdent(aValue:Byte):String;
    procedure SetSection(const aValue:String);
    procedure SetTarget(aValue:TLMDIniTarget);
    procedure SetMemIniUtf8(const Value: Boolean);

    procedure RecreateMemIni;
  protected
    function GetNetUserName:String;virtual;
    function DoEncode(const Value:String):String;virtual;
    function DoDecode(const Value:String):String;virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;

    // 7.1
    //MemIniFile support
    procedure Clear;
    procedure Load;
    procedure Save;

    function SectionExists(const Section: string):Boolean;
    function ValueExists(const Section, Ident: string): Boolean;
    // ----

    {General}
    function GetIniName:String;
    function GetRegPath:String;
    function GetSectionName(const aValue:String):String;

    {Section}
    procedure ReadSection(const Section: string; Strings: TStrings);
    procedure ReadSections(Strings: TStrings);
    procedure ReadSectionValues(const Section: string; Strings: TStrings);

    {Erase, delete}
    procedure DeleteKey(const Section, Ident: String);
    procedure EraseSection(const Section : string);

    {read procedures}
    function ReadBool(const Section, Ident:string; ADefault: Boolean):Boolean;
    procedure ReadColorList(const Section:string; Strings:TStrings);
    function ReadDate(const Section, Ident:string; ADefault: TDateTime):TDateTime;
    function ReadDateTime(const Section, Ident:string; ADefault: TDateTime):TDateTime;
    function ReadFloat(const Section, Ident:string; ADefault: Extended):Extended;
    function ReadInteger(const Section, Ident:string; ADefault: LongInt):LongInt;
    function ReadString(const Section, Ident, ADefault: String):String;
    procedure ReadStrings(const Section, IdentPrefix:String; Strings:TStrings);
    procedure ReadStringsExt(const Section, IdentPrefix:String; Strings:TStrings; Entries:Byte);
    function ReadTime(const Section, Ident: string; ADefault:  TDateTime):TDateTime;
    function ReadColor(const Section, Ident:string; ADefault: TColor):TColor;
    function ReadFont(const Section, Ident:string; aValue:TFont):Boolean;
    function ReadPoint(const Section, Ident:string; ADefault: TPoint):TPoint;
    function ReadRect(const Section, Ident:string; ADefault: TRect):TRect;
    // 5.03 --> simple TObject descendant Read support
    procedure ReadObject(const Section:string; aValue:TObject);

    procedure WriteColor(const Section, Ident:string; aValue:TColor);
    procedure WriteColorList(const Section:string; Strings:TStrings);
    procedure WriteFont(const Section, Ident:string; aValue:TFont);
    procedure WriteRect(const Section, Ident:string; aValue:TRect);
    procedure WritePoint(const Section, Ident:string; aValue:TPoint);
    procedure WriteBool(const Section, Ident:string; Value: Boolean);
    procedure WriteDate(const Section, Ident:string; Value: TDateTime);
    procedure WriteDateTime(const Section, Ident:string; Value: TDateTime);
    procedure WriteInteger(const Section, Ident:string; Value: LongInt);
    procedure WriteFloat(const Section, Ident:string; Value: Extended);
    procedure WriteString(const Section, Ident, Value:String);
    procedure WriteStrings(const Section, IdentPrefix:String; Strings:TStrings);
    Procedure WriteStringsExt(const Section, IdentPrefix:String; Strings:TStrings; Entries:Byte);
    procedure WriteTime(const Section, Ident:string; Value: TDateTime);
    // 5.03 --> simple TObject descendant Read support
    procedure WriteObject(const Section:string; aValue:TObject);
    // 7.1
    property MemIniFile:TLMDMemIniFile read FMemIniFile;
    // ---
    property Section:String read FLastSection write SetSection;
  published
    property About;
    property AlphaCounter:Boolean read FAlphaCounter write SetAlphaCounter default false;
    property Common:Boolean read FCommon write FCommon default True;
    property IniFile:String read FIniFile write SetIniFile;
    property MemIniUtf8: Boolean read FMemIniUtf8 write SetMemIniUtf8 default False;
    property IniPrefix:TLMDPathPrefix read FIniPrefix write FIniPrefix default ppWindows;
    property MaxEntries:Byte read FMaxEntries write SetMaxEntries default 16;
    property NetUser:Boolean read FNetUser write SetNetUser default false;
    property User:String read FUser write FUser;
    property RegPath:String read FRegPath write FRegPath;
    property RegRoot:TLMDRegRootKey read FRootKey write FRootKey default rpCurrentUser;
//    property RegRemoteComp:String read FRemoteComputer write FRemoteComputer;
    property Target: TLMDIniTarget read FHTarget write SetTarget default itAuto;

    // 5.05
    property EncKey:Word read FKey write FKey default 12345;
    property Encoded:Boolean read FCoded write FCoded default false;
    // 7.0
    property CryptMode:TLMDIniCryptMode read FCryptMode write FCryptMode default icmKey;
    property OnEncodeString:TLMDIniCryptEvent read FOnEncodeString write FOnEnCodeString;
    property OnDecodeString:TLMDIniCryptEvent read FOnDecodeString write FOnDeCodeString;
    // ---
  end;

  function LMDGetRootKey(aValue:TLMDRegRootKey):HKey;

  // 5.03
  procedure LMDSaveObjectProperties(IniFile : TCustomIniFile; szSection: String; AInstance: TObject);
  procedure LMDLoadObjectProperties(IniFile : TCustomIniFile; szSection: String; AInstance: TObject);

implementation
uses
  Registry, SysUtils, TypInfo,
  LMDSysIn, LMDStrings, LMDClass;

{******************************************************************************}
{helpers}
{------------------------------------------------------------------------------}
function LMDGetRootKey(aValue:TLMDRegRootKey):HKey;
begin
  result:=0;
  case aValue of
    rpClassesRoot:result:=HKEY_CLASSES_ROOT;
    rpCurrentUser:result:=HKEY_CURRENT_USER;
    rpLocalMachine:result:=HKEY_LOCAL_MACHINE;
    rpUsers: result:=HKEY_USERS;
    rpCurrentConfig:result:=HKEY_CURRENT_CONFIG;
    rpDynData: result:=HKEY_DYN_DATA;
  else
    exit;
  end;
end;

type
  TLMDRegIniFile = class(TRegIniFile)
  private
    FLMDFileName: String;
  public
    constructor Create(Key:HKey; ReadOnly:Boolean; const FileName,
                       RemoteComputer: string);
    property FileName: string read FLMDFileName;
  end;

{------------------------------------------------------------------------------}
procedure LMDSaveObjectProperties(IniFile : TCustomIniFile;
  szSection:String; AInstance : TObject);
// Done: AH, 05.26.2004
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;

  procedure WriteProperty(ALInstance: TObject; APropInfo: Pointer);
  var
    PropType: PTypeInfo;

    {--------------------------------------------------------------------------}
    procedure WriteOrdProp;
    var
      Value: Longint;

      function IsDefaultValue: Boolean;
      begin
        Result := Value = PPropInfo(APropInfo)^.Default;
      end;

    begin
      Value := GetOrdProp(ALInstance, APropInfo);
      if not IsDefaultValue then
        IniFile.WriteInteger(szSection, String(PPropInfo(APropInfo)^.Name), Value);
    end;

    {--------------------------------------------------------------------------}
    procedure WriteFloatProp;
    var
      Value: Extended;

      function IsDefaultValue: Boolean;
      begin
        Result := Value = 0;
      end;

    begin
      Value := GetFloatProp(ALInstance, APropInfo);
      if not IsDefaultValue then
        IniFile.WriteFloat(szSection, String(PPropInfo(APropInfo)^.Name), Value);
    end;

    {--------------------------------------------------------------------------}
    procedure WriteStrProp;
    var
      Value: string;

      function IsDefault: Boolean;
      begin
        Result := Value = '';
      end;

    begin
      Value := GetStrProp(ALInstance, APropInfo);
      if not IsDefault then
        IniFile.WriteString(szSection, String(PPropInfo(APropInfo)^.Name), Value);
    end;

  begin
    if PPropInfo(APropInfo)^.SetProc <> nil then
    begin
      PropType := PPropInfo(APropInfo)^.PropType^;
      case PropType^.Kind of
        tkInteger, tkChar, tkEnumeration, tkSet: WriteOrdProp;
        tkFloat: WriteFloatProp;
        tkString, tkLString, tkWString {$IFDEF LMDCOMP12}, tkUString{$ENDIF}: WriteStrProp;
      end;
    end;
  end;

begin
  Count := GetTypeData(AInstance.ClassInfo)^.PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(AInstance.ClassInfo, PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if PropInfo = nil then break;
            if IsStoredProp(AInstance, PropInfo) then
              WriteProperty(AInstance, PropInfo);
          end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDLoadObjectProperties(IniFile : TCustomIniFile; szSection:String; AInstance: TObject);
// Done AH, 05.26.2004
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
  procedure ReadProperty(ALInstance: TObject; APropInfo: Pointer);
  var
    PropType: PTypeInfo;
    procedure ReadOrdProp;
    var
      Value: Longint;
    begin
       Value := GetOrdProp(ALInstance, APropInfo);
       Value := IniFile.ReadInteger(szSection, String(PPropInfo(APropInfo)^.Name), Value);
       SetOrdProp(ALInstance, APropInfo, Value);
    end;

    {--------------------------------------------------------------------------}
    procedure ReadFloatProp;
    var
      Value: Extended;
    begin
      Value := GetFloatProp(ALInstance, APropInfo);
      Value := IniFile.ReadFloat(szSection, String(PPropInfo(APropInfo)^.Name), Value);
      SetFloatProp(ALInstance, APropInfo, Value);
    end;

    {--------------------------------------------------------------------------}
    procedure ReadStrProp;
    var
      Value: string;

    begin
      Value := GetStrProp(ALInstance, APropInfo);
      Value := IniFile.ReadString(szSection, String(PPropInfo(APropInfo)^.Name), Value);
      SetStrProp(ALInstance, APropInfo, Value);
    end;

  begin
    if PPropInfo(APropInfo)^.SetProc <> nil then
    begin
      PropType := PPropInfo(APropInfo)^.PropType^;
      case PropType^.Kind of
      tkInteger, tkChar, tkEnumeration, tkSet: ReadOrdProp;
        tkFloat: ReadFloatProp;
        tkString, tkLString, tkWString{$ifdef LMDCOMP12}, tkUString{$endif}: ReadStrProp;
      end;
    end;
  end;

begin
  Count := GetTypeData(AInstance.ClassInfo)^.PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(AInstance.ClassInfo, PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if PropInfo = nil then break;
            ReadProperty(AInstance, PropInfo);
          end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
    end;
end;

{*************************** Class TLMDRegIniFile *****************************}
{----------------------------  Public -----------------------------------------}
constructor TLMDRegIniFile.Create(Key:HKey; ReadOnly:Boolean; const FileName, RemoteComputer:String);
begin
  inherited Create;
  LazyWrite:=True;
  FLMDFileName:=FileName;
  RootKey:=Key;
  // 5.02
  if ReadOnly then
    begin
      Access:=KEY_READ;
      OpenKeyReadOnly(FileName);
    end
  else
    begin
      Access:=KEY_ALL_ACCESS;
      OpenKey(FileName, True);
      {  if RemoteComputer <> '' then //RootKey has to be HKEY_LOCAL_MACHINE or HKEY_USERS
        if not RegistryConnect (RemoteComputer) then ShowMessage (':-(');}
    end;
end;

{*************************** Class TLMDIniCtrl ********************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDIniCtrl.SetAlphaCounter(aValue:Boolean);
begin
  if FAlphaCounter<>aValue then
    begin
      FAlphaCounter:=aValue;
      if FMaxEntries>26 then FMaxEntries:=26;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.SetIniFile(const aValue:String);
begin
  if LMDAnsiEmpty(ExtractFileExt(aValue)) then
    FIniFile := ChangeFileExt(aValue, '.INI')
  else
    FIniFile := aValue;
  if (FTarget = itMemIniFile) and Assigned(FMemIniFile) then
    FMemIniFile.Rename(FIniFile, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.SetMaxEntries(aValue:Byte);
begin
  if aValue<>FMaxEntries then
    if not AlphaCounter then
      FMaxEntries:=aValue
    else
      if aValue<=26 then FMaxEntries:=aValue;
end;

procedure TLMDIniCtrl.SetMemIniUtf8(const Value: Boolean);
begin
  if FMemIniUtf8 <> Value then
  begin
    FMemIniUtf8 := Value;
    RecreateMemIni;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.SetNetUser(aValue:Boolean);
begin
  if aValue<>FNetUser then
    begin
      FNetUser:=aValue;
      if FNetUser then
        FUser:=GetNetUserName;
    end;
end;

{------------------------------------------------------------------------------}
{procedure TLMDIniCtrl.SetPathPrefix(aValue:TLMDPathPrefix);
begin
  if aValue<>FIniPrefix then FIniPrefix:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.SetSection(const aValue:String);
begin
  GetSectionName(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.SetTarget(aValue:TLMDIniTarget);
begin
  if aValue<>FHTarget then
  begin
    FHTarget := aValue;

    if FHTarget = itAuto then
      FTarget := itRegistry
    else
      FTarget := FHTarget;

    RecreateMemIni;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.GetCounterIdent(aValue:Byte):String;
begin
  if AlphaCounter then result:=Chr(65+aValue) else result:=InttoStr(aValue);
end;

{---------------------------- Protected ---------------------------------------}
function TLMDIniCtrl.GetNetUserName:String;
begin
  result:=LMDSIUserName;     {LMDSIUsername does not depend on installed BDE}
end;

{ ---------------------------------------------------------------------------- }
function TLMDIniCtrl.DoEncode(const Value: String): String;
begin
  result:=Value;
  case FCryptMode of
    icmKey: result:=LMDAnsiEnCode(Value, FKey);
    icmTextKey: result:=LMDAnsiEncode64(LMDAnsiEnCode(Value, FKey));
    icmCustom: if Assigned(FOnEncodeString) then FOnEncodeString(self, result);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIniCtrl.DoDecode(const Value: String): String;
begin
  result:=Value;
  case FCryptMode of
    icmKey: result:=LMDAnsiDeCode(Value, FKey);
    icmTextKey: result:=LMDAnsiDeCode(LMDAnsiDecode64(Value), FKey);
    icmCustom: if Assigned(FOnDecodeString) then FOnDecodeString(self, result);
  end;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDIniCtrl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FHTarget:=itAuto;
  FTarget:=itRegistry;

  FKey:=12345;
  FCryptMode:=icmKey;

  {Inifiles related variables}
  FUser:='';
  FCommon:=True;
  FIniPrefix:=ppWindows;
  FMemIniFile := nil;

  {Registry related variables}
  FRootKey:=rpCurrentUser;
  FRemoteComputer := '';

  {General}
  FAlphaCounter:=False;
  FMaxEntries:=16;
end;

{------------------------------------------------------------------------------}
destructor TLMDIniCtrl.Destroy;
begin
  if Assigned(FMemIniFile) then
    FreeAndNil(FMemIniFile);
  inherited;
end;

{general}
{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.DeleteKey(const Section, Ident: String);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.DeleteKey(GetSectionName(Section), Ident);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          DeleteKey(GetSectionName(Section), Ident);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          DeleteKey(GetSectionName(Section), Ident);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.EraseSection(const Section : string);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.EraseSection(GetSectionName(Section));
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          EraseSection(GetSectionName(Section));
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          EraseSection(GetSectionName(Section));
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.GetIniName:String;
begin
  if FIniFile = '' then
    FIniFile := ChangeFileExt(ParamStr(0),'.INI');
  if FIniPrefix <> ppFixed then
    Result := LMDCreatePathPrefix(FIniPrefix, True) + ExtractFileName(FIniFile)
  else
    Result := FIniFile;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.GetRegPath:String;
begin
  if not LMDAnsiEmpty(FRegPath) then
    result:=LMDAnsiSlashAdd(FRegPath)
  else
    result:=LMDApplication.GetDefaultRegPath;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.GetSectionName(const aValue:String) : String;
begin

  if LMDAnsiEmpty(aValue) then
    begin
      if LMDAnsiEmpty(FLastSection) then
        result:=IDS_COMMON
      else
        result:=FLastSection;
      exit;
    end;

  case FTarget of
    itIniFile, itMemIniFile:
      if FCommon then
        Result:=aValue
      else
        if FNetUser then
          Result := GetNetUserName+'.'+aValue
        else
          Result := FUser+'.'+aValue;
    itRegistry:
      if aValue=IDS_ROOT then result:='' else result:=aValue;
  end;

  FLastSection:=result;
end;

{Section}
{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadSection(const Section: string; Strings: TStrings);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.ReadSection(GetSectionName(Section), Strings);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          ReadSection(GetSectionName(Section), Strings);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          ReadSection(GetSectionName(Section),Strings);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadSections(Strings: TStrings);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.ReadSections(Strings);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          ReadSections(Strings);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          ReadSections(Strings);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadSectionValues(const Section: string; Strings: TStrings);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.ReadSectionValues(GetSectionName(Section),Strings);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          ReadSectionValues(GetSectionName(Section),Strings);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          ReadSectionValues(GetSectionName(Section), Strings);
        finally
          Free;
        end;
  end;
end;

{Read Methods}
{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadBool(const Section, Ident: string; ADefault:  Boolean):Boolean;
begin
  result:=ADefault;
  case FTarget of
    itMemIniFile:
      result:=FMemIniFile.ReadBool(GetSectionName(Section),Ident, ADefault);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          result:=ReadBool(GetSectionName(Section),Ident,ADefault);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          result:=ReadBool(GetSectionName(Section),Ident,ADefault);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadColorList(const Section:string; Strings:TStrings);
begin
  Strings.Clear;
  case FTarget of
    itMemIniFile:
      FMemIniFile.ReadSectionValues(Section, Strings);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          ReadSectionValues(Section, Strings);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          ReadSectionValues(Section, Strings);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadDate(const Section, Ident: string; ADefault:  TDateTime):TDateTime;
var
  s: string;
  i: integer;
begin
  s := ReadString(Section, Ident, DateToStr(ADefault));
  if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator, s) > 0 then
    result:=StrToDate(s)
  else
    begin
      for i := 1 to Length(s) do
        if (s[i] = '.') or (s[i] = '-') or (s[i] = '/') then
          s[i] := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator;
      result:=StrToDate(s);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadDateTime(const Section, Ident: string; ADefault:  TDateTime):TDateTime;
var
  s: string;
  i: integer;
begin
  s := ReadString(Section, Ident, DateTimeToStr(ADefault));
  if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator, s) > 0 then
    result:=StrToDateTime(s)
  else
    begin
      for i := 1 to Length(s) do
        if (s[i] = '.') or (s[i] = '-') or (s[i] = '/') then
          s[i] := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator;
      result:=StrToDateTime(s);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadFloat(const Section, Ident: string; ADefault: Extended):Extended;
begin
  result:=StrToFloat(ReadString(Section, Ident, FloatToStr(ADefault)));
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadInteger(const Section, Ident: string; ADefault:  LongInt):LongInt;
begin
  result:=ADefault;
  case FTarget of
    itMemIniFile:
      result:=FMemIniFile.ReadInteger(GetSectionName(Section),Ident,ADefault);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          result:=ReadInteger(GetSectionName(Section),Ident,ADefault);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          result:=ReadInteger(GetSectionName(Section),Ident,ADefault);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadString(const Section, Ident, ADefault: String):String;
begin
  case FTarget of
    itMemIniFile:
      with FMemIniFile do
        if FCoded then
          result:=DoDecode(ReadString(GetSectionName(Section),Ident, DoEncode(ADefault)))
        else
          result:=ReadString(GetSectionName(Section),Ident,ADefault);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          if FCoded then
            result:=DoDecode(ReadString(GetSectionName(Section),Ident, DoEncode(ADefault)))
          else
            result:=ReadString(GetSectionName(Section),Ident,ADefault)
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          if FCoded then
            result:=DoDecode(ReadString(GetSectionName(Section),Ident,DoEncode(ADefault)))
          else
            result:=ReadString(GetSectionName(Section),Ident,ADefault);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadObject(const Section:String; aValue:TObject);
var
  tmp:TCustomIniFile;
begin
  case FTarget of
    itMemIniFile:
      LMDLoadObjectProperties(FMemIniFile, GetSectionName(Section), aValue);
    itIniFile:
      begin
        tmp:=TIniFile.Create(GetIniName);
        try
          LMDLoadObjectProperties(tmp, GetSectionName(Section), aValue);
        finally
          tmp.Free;
        end;
      end;
    itRegistry:
      begin
        tmp:=TRegistryIniFile.Create(GetRegPath);
        if FRootKey<>rpCurrentUser then
          begin
            TRegistryIniFile(tmp).RegIniFile.RootKey:=LMDGetRootKey(FRootKey);
            TRegistryIniFile(tmp).RegIniFile.OpenKeyReadOnly(GetRegPath);
          end;
        try
          LMDLoadObjectProperties(tmp, GetSectionName(Section), aValue);
        finally
          tmp.Free;
        end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadStrings(const Section, IdentPrefix:String; Strings:TStrings);
begin
   ReadStringsExt(Section, IdentPrefix, Strings, FMaxEntries);
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.ReadStringsExt(const Section, IdentPrefix:String;
                                     Strings:TStrings; Entries:Byte);
var
  tmp:String;
  i:Integer;
begin
  case FTarget of
    itMemIniFile:
      with FMemIniFile do
        begin
          Strings.Clear;
          if FCoded then
            begin
              for i:=0 to Pred(Entries) do
                begin
                  tmp:=DoDecode(ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), ''));
                  if tmp<>'' then Strings.Add(tmp) else break;
                end;
            end
          else
            for i:=0 to Pred(Entries) do
              begin
                tmp:=ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), '');
                if tmp<>'' then Strings.Add(tmp) else break;
              end;
        end;
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          Strings.Clear;
          if FCoded then
            begin
              for i:=0 to Pred(Entries) do
                begin
                  tmp:=DoDecode(ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), ''));
                  if tmp<>'' then Strings.Add(tmp) else break;
                end;
            end
          else
            for i:=0 to Pred(Entries) do
              begin
                tmp:=ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), '');
                if tmp<>'' then Strings.Add(tmp) else break;
              end;
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), true, GetRegPath, FRemoteComputer) do
        try
          Strings.Clear;
          if FCoded then
            begin
              for i:=0 to Pred(Entries) do
                begin
                  tmp:=DoDecode(ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), ''));
                  if tmp<>'' then Strings.Add(tmp) else break;
                end;
            end
          else
            for i:=0 to Pred(Entries) do
              begin
                tmp:=ReadString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), '');
                if tmp<>'' then Strings.Add(tmp) else break;
              end;
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadTime(const Section, Ident: string;
  ADefault: TDateTime):TDateTime;
begin
  Result := StrToTime(ReadString(Section, Ident, TimeToStr(ADefault)));
end;

procedure TLMDIniCtrl.RecreateMemIni;
{$IFDEF LMDCOMP12}
var
  enc: TEncoding;
{$ENDIF}
begin
  if FMemIniFile <> nil then
  begin
    FMemIniFile.Clear;
    FreeAndNil(FMemIniFile);
  end;

  if FTarget = itMemIniFile then
  begin
    {$IFDEF LMDCOMP12}
    if FMemIniUtf8 then
      enc := TEncoding.UTF8
    else
      enc := nil;
    FMemIniFile := TLMDMemIniFile.Create(GetIniName, enc);
    {$ELSE}
    FMemIniFile := TLMDMemIniFile.Create(GetIniName);
    {$ENDIF}
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadColor(const Section, Ident:string; ADefault: TColor):TColor;
begin
  result:=StringToColor(ReadString(Section, Ident, ColorToString(ADefault)));
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadFont(const Section, Ident:string; aValue:TFont):Boolean;
var
  tmp:String;
begin
  result:=false;
  tmp:=ReadString(Section, Ident, '');
  if tmp='' then exit;
  LMDAnsiStringToFont(tmp, aValue);
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadPoint(const Section, Ident:string; ADefault: TPoint):TPoint;
begin
  result:=LMDAnsiStringToPoint(ReadString(Section, Ident,
                               LMDAnsiPointToString(ADefault)));
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ReadRect(const Section, Ident:string; ADefault: TRect):TRect;
begin
  result:=LMDAnsiStringToRect(ReadString(Section, Ident,
                              LMDAnsiRectToString(ADefault)));
end;

{meminifile support methods}
{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.Save;
begin
  if (FTarget = itMemIniFile) and Assigned(FMemIniFile) then
    FMemIniFile.UpdateFile;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.Clear;
begin
  if Assigned(FMemIniFile) then
    FMemIniFile.Clear;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.SectionExists(const Section: string): Boolean;
begin
  result := false;
  case FTarget of
    itMemIniFile:
      if Assigned(FMemIniFile) then
        result := FMemIniFile.SectionExists(Section);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          result:=SectionExists(Section);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          result := KeyExists(Section);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDIniCtrl.ValueExists(const Section, Ident: string): Boolean;
var
  Key, OldKey: HKEY;
begin
  result := false;
  case FTarget of
    itMemIniFile:
      if Assigned(FMemIniFile) then
        result := FMemIniFile.ValueExists(GetSectionName(Section), Ident);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          result:=ValueExists(GetSectionName(Section), Ident);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          Key := GetKey(GetSectionName(Section));
          if Key <> 0 then
            try
              OldKey := CurrentKey;
              SetCurrentKey(Key);
              try
                result := ValueExists(Ident);
              finally
                SetCurrentKey(OldKey);
              end;
            finally
              RegCloseKey(Key);
            end;
        finally
         Free;
       end;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.Load;
begin
  RecreateMemIni;
end;

{write methods}
{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteColor(const Section, Ident:string; aValue:TColor);
begin
  WriteString(Section,Ident, ColorToString(aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteColorList(const Section:string; Strings:TStrings);
var
   i,j:integer;
   colorstr:string;
begin
  case FTarget of
    itMemIniFile:
      with FMemIniFile do
        for i:=0 to Pred(Strings.Count) do
          begin
            colorstr:=Strings.Strings[I];
            j:=Pos('=', colorstr);
            if j<>0 then
              begin
                colorstr:=copy(colorstr,1,j-1);
                WriteString(Section, colorstr, Strings.Values[colorstr])
              end;
          end;
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          for i:=0 to Pred(Strings.Count) do
            begin
              colorstr:=Strings.Strings[I];
              j:=Pos('=', colorstr);
              if j<>0 then
                begin
                  colorstr:=copy(colorstr,1,j-1);
                  WriteString(Section, colorstr, Strings.Values[colorstr])
                end;
            end;
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          for i:=0 to Pred(Strings.Count) do
            begin
              colorstr:=Strings.Strings[I];
              j:=Pos('=', colorstr);
              if j<>0 then
                begin
                  colorstr:=copy(colorstr,1,j-1);
                  WriteString(Section, colorstr, Strings.Values[colorstr])
                end;
            end;
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteFont(const Section, Ident:string; aValue:TFont);
begin
  WriteString(Section,Ident, LMDAnsiFontToString(aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteRect(const Section, Ident:string; aValue:TRect);
begin
  WriteString(Section,Ident, LMDAnsiRectToString(aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WritePoint(const Section, Ident:string; aValue:TPoint);
begin
  WriteString(Section,Ident, LMDAnsiPointToString(aValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.WriteBool(GetSectionName(Section),Ident,Value);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          WriteBool(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          WriteBool(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteDate(const Section, Ident: string; Value: TDateTime);
begin
  WriteString(Section,Ident,DateToStr(Value));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteDateTime(const Section, Ident: string; Value: TDateTime);
begin
  WriteString(Section,Ident,DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteFloat(const Section, Ident: string; Value: Extended);
begin
  WriteString(Section, Ident, FloatToStr(Value));
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteInteger(const Section, Ident: string; Value: LongInt);
begin
  case FTarget of
    itMemIniFile:
      FMemIniFile.WriteInteger(GetSectionName(Section),Ident,Value);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          WriteInteger(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          WriteInteger(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteString(const Section, Ident, Value: String);
begin
  case FTarget of
    itMemIniFile:
      with FMemIniFile do
        if FCoded then
          WriteString(GetSectionName(Section),Ident,DoEncode(Value))
        else
          WriteString(GetSectionName(Section),Ident,Value);
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          if FCoded then
            WriteString(GetSectionName(Section),Ident,DoEncode(Value))
          else
            WriteString(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          if FCoded then
            WriteString(GetSectionName(Section),Ident,DoEncode(Value))
          else
            WriteString(GetSectionName(Section),Ident,Value);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteStrings(const Section, IdentPrefix:String; Strings:TStrings);
begin
  WriteStringsExt(Section, IdentPrefix, Strings, FMaxEntries);
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteStringsExt(const Section, IdentPrefix:String;
                                      Strings:TStrings; Entries:Byte);
var
  i:Integer;
begin
  case FTarget of
    itMemIniFile:
      with FMemIniFile do
        begin
          EraseSection(GetSectionName(Section));
          if FCoded then
            begin
              for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
                WriteString(GetSectionName(Section),IdentPrefix+GetCounterIdent(i),DoEncode(Strings[i]))
            end
          else
            for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
              WriteString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), Strings[i]);
        end;
    itIniFile:
      with TIniFile.Create(GetIniName) do
        try
          EraseSection(GetSectionName(Section));
          if FCoded then
            begin
              for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
                WriteString(GetSectionName(Section),IdentPrefix+GetCounterIdent(i),DoEncode(Strings[i]))
            end
          else
            for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
              WriteString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), Strings[i]);
        finally
          Free;
        end;
    itRegistry:
      with TLMDRegIniFile.Create(LMDGetRootKey(FRootKey), false, GetRegPath, FRemoteComputer) do
        try
          EraseSection(GetSectionName(Section));
          if FCoded then
            begin
              for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
                WriteString(GetSectionName(Section),IdentPrefix+GetCounterIdent(i),DoEncode(Strings[i]))
            end
          else
            for i:=0 to LMDMin([Strings.Count-1, Entries-1]) do
              WriteString(GetSectionName(Section), IdentPrefix+GetCounterIdent(i), Strings[i]);
        finally
          Free;
        end;
  end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDIniCtrl.WriteObject(const Section:String; aValue:TObject);
var
  tmp:TCustomIniFile;
begin
  case FTarget of
    itMemIniFile:
      LMDSaveObjectProperties(FMemIniFile, GetSectionName(Section), aValue);
    itIniFile:
      begin
        tmp:=TIniFile.Create(GetIniName);
        try
          LMDSaveObjectProperties(tmp, GetSectionName(Section), aValue);
        finally
          tmp.Free;
        end;
      end;
    itRegistry:
      begin
        tmp:=TRegistryIniFile.Create(GetRegPath);
        try
          if FRootKey<>rpCurrentUser then
            begin
              TRegistryIniFile(tmp).RegIniFile.RootKey:=LMDGetRootKey(FRootKey);
              TRegistryIniFile(tmp).RegIniFile.OpenKey(GetRegPath, true);
            end;
          LMDSaveObjectProperties(tmp, GetSectionName(Section), aValue);
        finally
          tmp.Free;
        end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIniCtrl.WriteTime(const Section, Ident: string; Value: TDateTime);
begin
  WriteString(Section,Ident,TimeToStr(Value));
end;

// *************************** TLMDMemIniFile *********************************
{------------------------------------------------------------------------------}
destructor TLMDMemIniFile.Destroy;
begin
  Clear;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDMemIniFile.LoadFromStream(AValue: TStream);
var
  L: TStringList;
begin
  L := TStringList.Create;
  Clear;
  try
    L.LoadFromStream(AValue);
    SetStrings(L);
  finally
    L.Clear;
    L.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMemIniFile.Normalize(ARemToken: string = ''; TrimValue: boolean = true);
var
  S: string;
  SL: TStringList;
  i,j,k: integer;
  LDoTrimRem: Boolean;
begin
  SL := TStringList.Create;
  try
    GetStrings(SL);
    Clear;
    LDoTrimRem := (ARemToken <> '');
    for i := 0 to SL.count - 1 do
      begin
        S := SL[i];
        j := AnsiPos('=', SL[i]);
        if (j > 0) then
        begin
          //clear remarks from value strings
          SL[i] := '';
          k := 0;
          if LDoTrimRem then
            k := AnsiPos(ARemToken, S);
          if k <= 0 then
            k := Length(S) + 1;
          if TrimValue then
            SL[i] := Trim(Copy(S, 1, j - 1)) + '=' + Trim(Copy(S, j + 1, k - j - 1))
          else
            SL[i] := Trim(Copy(S, 1, j - 1)) + '=' + Copy(S, j + 1, k - j - 1);
        end
        else
        begin
          //clear remarks from section name strings
          k := AnsiPos(ARemToken, S);
          if k > 0 then
            SL[i] := Trim(Copy(S, 1, k - 1));
        end;
      end;
    SetStrings(SL);
  finally
    SL.Clear;
    SL.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMemIniFile.RenameSection(const AOldName, ANewName: string);
var
   SL: TStringList;
   i:  Integer;
begin
  SL := TStringList.Create;
  try
    GetStrings(SL);
    i := SL.IndexOf('['+AOldName+']');
    if i < 0 then
      Exit;
    SL[i] := '['+ANewName+']';
    SetStrings(SL);
  finally
    SL.Clear;
    SL.Free;
  end;
end;

end.
