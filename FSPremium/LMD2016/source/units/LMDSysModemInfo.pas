unit LMDSysModemInfo;
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

LMDSysModemInfo unit (JH)
-------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  windows,
  classes,
  LMDSysObject,
  LMDSysBase,
  LMDSysConst;

type

  TLMDSysModemDisplayInfo=(mopidName, mopidAttachedTo, mopidUserInit, mopidPortSpeed);
  TLMDSysModemDisplayInfos=set of TLMDSysModemDisplayInfo;

const
  def_TLMDSysModemDisplayInfos=[mopidName, mopidAttachedTo, mopidUserInit, mopidPortSpeed];

  LMDSysModemProps:array[TLMDSysModemDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysModemTitleName; Description: sLMDSysModemDescName),
    (Name: sLMDSysModemTitleAttachedTo; Description: sLMDSysModemDescAttachedTo),
    (Name: sLMDSysModemTitleUserInit; Description: sLMDSysModemDescUserInit),
    (Name: sLMDSysModemTitlePortSpeed; Description: sLMDSysModemDescPortSpeed));

type
  { ************************************************************************** }
  TLMDModemItem = class(TLMDSysCollectionItem)
  private
    FSubKeyName: string;
    FPortSpeed: LongInt;
    FAttachedTo: string;
    FName: string;
    FUserInit: string;
    procedure SetDummyLong(const Value: LongInt);
    procedure SetDummyString(const Value: string);
    procedure SetString(const Value: string);
  protected
    procedure RegisterProperties; override;
    function GetDisplayInfo:TLMDSysModemDisplayInfos;
  public
    procedure Apply; override;
    procedure Refresh;
    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Name: string read FName write SetDummyString stored false;
    property AttachedTo: string read FAttachedTo write SetDummyString stored false;
    property UserInit: string read FUserInit write SetString stored false;
    property PortSpeed: LongInt read FPortSpeed write SetDummyLong stored false;
  end;

  { ************************************************************************** }
  TLMDModemInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDModemItem;
    procedure SetItem(Index: Integer; Value: TLMDModemItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDModemItem;
    constructor Create(aOwner: TComponent);
    procedure Refresh;
    procedure UpdateProperties;
    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType; override;
    property Items[Index: Integer]: TLMDModemItem read GetItem write SetItem; default;
  end;

implementation

uses
  Registry,
  LMDSysLogStrings, SysUtils, LMDSysModem, LMDSysSystemInfo;

const
  mdmSubKey = '\SYSTEM\CurrentControlSet\Control\Class\{4D36E96D-E325-11CE-BFC1-08002BE10318}';

{ TLMDModemInfo }
{----------------------------- public -----------------------------------------}
constructor TLMDModemInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDModemItem);
  FOwner:= aOwner;
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.Add: TLMDModemItem;
begin
  Result:= TLMDModemItem(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.GetItem(Index: Integer): TLMDModemItem;
begin
  Result:= TLMDModemItem(inherited GetItem(Index))
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDModemInfo.Refresh;
var
  R: TRegistry;
  S: TStrings;
  I: LongInt;
  buffer: array[0..3] of byte;
begin
  Clear;
  DoProgress(sLMDSysModemGroupTitle, 100, 0);
  R:= TRegistry.Create(KEY_READ);
  S:= TStringList.Create;
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    R.OpenKeyReadOnly(mdmSubKey);
    R.GetKeyNames(S);
    for I:= 0 to S.Count - 1 do
      begin
        DoProgress(sLMDSysModemGroupTitle, 100, Round(i*100/S.count));
        R.OpenKeyReadOnly(mdmSubKey + '\' + S[I]);
        with Add do
          begin
            FSubKeyName:= S[I];
            FName:= R.ReadString('FriendlyName');
            FAttachedTo:= R.ReadString('AttachedTo');
            FUserInit:= R.ReadString('UserInit');
            if R.ValueExists('MaximumPortSpeed') then
            begin
              //FPortSpeed := R.ReadInteger('MaximumPortSpeed');
              R.ReadBinaryData('MaximumPortSpeed', buffer, 4);
              FPortSpeed := 65536*(buffer[0]*256 + buffer[1]) + buffer[2]*256 + buffer[3];
            end;
            Refresh;
          end;
        R.CloseKey;
      end;
    R.CloseKey;
  finally
    S.Free;
    R.Free;
  end;
DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDModemInfo.UpdateProperties;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].RegisterProperties;
end;

{------------------------------------------------------------------------------}
procedure TLMDModemInfo.SetItem(Index: Integer; Value: TLMDModemItem);
begin
  inherited SetItem(Index, Value);
end;

{ ************************************************************************** }
{ TLMDModemItem }
{------------------------------------------------------------------------------}
procedure TLMDModemItem.Apply;
var
  R: TRegistry;
begin
  inherited;
  R:= TRegistry.Create;
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    if PropChanged(strModemUserInit) then
      begin
        WriteToLog(strModemUserInit);
        R.OpenKey(mdmSubKey + '\' + FSubKeyName, false);
        R.WriteString('UserInit', FUserInit);
        R.CloseKey;
      end;
  finally
    R.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDModemItem.SetDummyLong(const Value: LongInt);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDModemItem.SetDummyString(const Value: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDModemItem.SetString(const Value: string);
begin
  if FUserInit <> Value then
    begin
      RememberChange(strModemUserInit, FUserInit, Value);
      FUserInit:= Value;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDModemItem.GetDisplayInfo:TLMDSysModemDisplayInfos;
begin
  result:=[];
  with TLMDModemInfo(Collection) do
    if FOwner=nil then
      result:=def_TLMDSysModemDisplayInfos
    else
      if FOwner is TLMDSysModem then
        result:=TLMDSysModem(FOwner).DisplayInfo
      else
        if FOwner is TLMDSysSystemInfo then
          result:=TLMDSysSystemInfo(FOwner).ModemsDisplayInfo
end;
{------------------------------------------------------------------------------}
procedure TLMDModemItem.RegisterProperties;
var
  tmp:TLMDSysModemDisplayInfos;
  i:TLMDSysModemDisplayInfo;
begin
 tmp:=GetDisplayInfo;
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysModemDisplayInfo) to High(TLMDSysModemDisplayInfo) do
    if i in tmp then
      FPropertiesDesc.Add(Ord(i), LMDSysModemProps[i].Name, LMDSysModemProps[i].Description);
end;

{------------------------------------------------------------------------------}
procedure TLMDModemItem.Refresh;
var
  tmp:TLMDSysModemDisplayInfos;
  i:TLMDSysModemDisplayInfo;

begin
  tmp:=GetDisplayInfo;
  FPropertiesDesc.InvalidateProperties;
  for i:=Low(TLMDSysModemDisplayInfo) to High(TLMDSysModemDisplayInfo) do
    if i in tmp then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          mopidName:Text := FName;
          mopidAttachedTo:Text := FAttachedTo;
          mopidUserInit:Text := FUserInit;
          mopidPortSpeed:Text := IntToStr(FPortSpeed);
        end;
end;

{------------------------------------------------------------------------------}
function TLMDModemItem.GetElementTitle : string;
begin
  result := sLMDSysModemTitle;
end;

{------------------------------------------------------------------------------}
function TLMDModemItem.GetElementDescription : string;
begin
  result := sLMDSysModemDesc;
end;

{------------------------------------------------------------------------------}
function TLMDModemItem.GetElementType : TLMDSysInfoType;
begin
  result := itModem;
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.GetElementTitle : string;
begin
  result := sLMDSysModemGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.GetElementDescription : string;
begin
  result := sLMDSysModemGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDModemInfo.GetElementType : TLMDSysInfoType;
begin
  result := itModemGroup;
end;

end.
