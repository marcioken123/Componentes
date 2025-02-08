unit ElOpts;
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

ElOpts unit
-----------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

{ Component template to store and load properties }

interface

uses
  //Windows,
  SysUtils,
  //Messages,
  Classes,
  Registry,
  IniFiles,
  ElIni,
  intfLMDBase,
  LMDTypes,
  ElVCLUtils,

Types,

  TypInfo;

type

  TElStorageType = (eosRegistry, eosIni, eosElIni);

  TElOptions = class(TComponent, ILMDComponent)
  protected
    FAutoSave: Boolean;
    FIniName: string;
    FIniSection: string;
    FLoading: Boolean;
    FStorage: TElIniFile;
    FStorageType: TElStorageType;
    procedure SetAutoSave(Value: Boolean); virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Load; virtual;
    procedure Save; virtual;
    property Loading: Boolean read FLoading;
    function getLMDPackage:TLMDPackageID;
  published
    property AutoSave: Boolean read FAutoSave write SetAutoSave;
    property IniName: string read FIniName write FIniName;
    property IniSection: string read FIniSection write FIniSection;
    property Storage: TElIniFile read FStorage write FStorage;
    property StorageType: TElStorageType read FStorageType write FStorageType;
  end;

implementation

{
*************************************** TElOptions ***************************************
}
constructor TElOptions.Create(AOwner : TComponent);
  { Creates an object of type TElOptions, and initializes properties. }
begin
  inherited Create(AOwner);
  FStorageType := eosRegistry;
  FIniSection := 'Options';
end;

destructor TElOptions.Destroy;
begin
  if FAutoSave then Save;
  inherited Destroy;
end;
{$warnings off}

function TElOptions.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TElOptions.Load;
var

  Ini: TRegIniFile;

  Ini1: TIniFile;
  Ini2: TElIniFile;
  PropName: string;
  i: Integer;
  j: Integer;
  PropCount: Integer;
  PropList: PPropList;
  S, TV: string;
  Section: string;
  Obj : TObject;
begin

  FLoading := true;
  Section := FIniSection;
  case FStorageType of
    eosRegistry : Ini := TRegIniFile.Create(FIniName);
    eosIni : Ini1 := TIniFile.Create(FIniName);
    eosElIni :
      begin
        if FStorage = nil then
        begin
          Ini2 := TElIniFile.Create(nil);
          Ini2.Path := FIniName;
        end
        else
          Ini2 := FStorage;
        Section := Ini2.Delimiter + Section;
      end;
  end;
  PropCount := GetPropList(ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkClass, tkSet], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkClass, tkSet], PropList);
  for i := 0 to PropCount - 1 do
  begin
    PropName := PropList[i]^.Name;
    case PropList[i]^.PropType^.Kind of
      tkSet:
        begin
          TV := GetSetProp(self, PropList[i]);
          case FStorageType of
            eosRegistry : S := Ini.ReadString(Section, PropName, TV);
            eosIni : S := Ini1.ReadString(Section, PropName, TV);
            eosElIni : Ini2.ReadString(Section, PropName, TV, S);
          end;
          if S <> '' then
            SetSetProp(Self, PropList[i], S);
        end;
      tkString, tkLString :
        begin
          TV := GetStrProp(self, PropList[i]);
          case FStorageType of
            eosRegistry : S := Ini.ReadString(Section, PropName, TV);
            eosIni : S := Ini1.ReadString(Section, PropName, TV);
            eosElIni : Ini2.ReadString(Section, PropName, TV, S);
          end;
          SetStrProp(Self, PropList[i], S);
        end;
      tkEnumeration,
        tkInteger :
        begin
          case FStorageType of
            eosRegistry : J := Ini.ReadInteger(Section, PropName, GetOrdProp(self, PropList[i]));
            eosIni : J := Ini1.ReadInteger(Section, PropName, GetOrdProp(self, PropList[i]));
            eosElIni : Ini2.ReadInteger(Section, PropName, GetOrdProp(self, PropList[i]), J);
          end;
          SetOrdProp(self, PropList[i], J);
        end;
      tkClass:
        begin
          Obj := TObject(Pointer(GetOrdProp(Self, PropList[i])));
          if (Obj is TStrings) and (FStorageType = eosElIni) then
            Ini2.ReadMultiString(Section, PropName, TStrings(Obj));
        end;
    end;
  end;
  FreeMem(PropList);
  case FStorageType of
    eosRegistry : Ini.Free;
    eosIni : Ini1.Free;
    eosElIni :
      if FStorage <> Ini2 then Ini2.Free;
  end;
  FLoading := false;
  Loaded;
end;

procedure TElOptions.Save;
var
  Ini: TRegIniFile;
  Ini1: TIniFile;
  Ini2: TElIniFile;
  PropName: string;
  i: Integer;
  PropCount: Integer;
  PropList: PPropList;
  Section: string;
  TV : string;
  Obj : TObject;

  function GetSetProp(Instance: TObject; PropInfo: PPropInfo; Brackets: Boolean): string;
  var
    S: TIntegerSet;
    TypeInfo: PTypeInfo;
    I: Integer;
  begin
    result := '';
    Integer(S) := GetOrdProp(Instance, PropInfo);
    TypeInfo := GetTypeData(PropInfo^.PropType^)^.CompType^;
    for I := 0 to SizeOf(Integer) * 8 - 1 do
      if I in S then
      begin
        if Result <> '' then
          Result := Result + ',';
        Result := Result + GetEnumName(TypeInfo, I);
      end;
    if Brackets then
      Result := '[' + Result + ']';
  end;
  begin
  Section := FIniSection;
  case FStorageType of
  eosRegistry : Ini := TRegIniFile.Create(FIniName);
  eosIni : Ini1 := TIniFile.Create(FIniName);
    eosElIni :
      begin
        if FStorage = nil then
        begin
          Ini2 := TElIniFile.Create(nil);
          Ini2.Path := FIniName;
        end
        else
          Ini2 := FStorage;
        Section := Ini2.Delimiter + Section;
        Ini2.OpenKey(Section, true);
      end;
  end;
  PropCount := GetPropList(ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkClass, tkSet], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkClass, tkSet], PropList);
  for i := 0 to PropCount - 1 do
  begin
    PropName := PropList[i]^.Name;
    case PropList[i]^.PropType^.Kind of
      tkSet:
        begin
          TV := GetSetProp(self, PropList[i], true);
          case FStorageType of
            eosRegistry : Ini.WriteString(Section, PropName, TV);
            eosIni : Ini1.WriteString(Section, PropName, TV);
            eosElIni : Ini2.WriteString('', PropName, TV);
          end;
        end;
      tkString,
        tkLString :
        case FStorageType of
          eosRegistry : Ini.WriteString(Section, PropName, GetStrProp(self, PropList[i]));
          eosIni : Ini1.WriteString(Section, PropName, GetStrProp(self, PropList[i]));
          eosElIni : Ini2.WriteString('', PropName, GetStrProp(self, PropList[i]));
        end;
      tkEnumeration,
        tkInteger :
        case FStorageType of
          eosRegistry : Ini.WriteInteger(Section, PropName, GetOrdProp(self, PropList[i]));
          eosIni : Ini1.WriteInteger(Section, PropName, GetOrdProp(self, PropList[i]));
          eosElIni : Ini2.WriteInteger('', PropName, GetOrdProp(self, PropList[i]));
        end;
      tkClass:
        begin
          Obj := TObject(Pointer(GetOrdProp(Self, PropList[i])));
          if (Obj is TStrings) and (FStorageType = eosElIni) then
            Ini2.WriteMultiString('', PropName, TStrings(Obj));
        end;
    end;
  end;
  FreeMem(PropList);
  case FStorageType of
    eosRegistry : Ini.Free;
    eosIni : Ini1.Free;
    eosElIni :
      begin
        //Ini2.Save;
        if FStorage <> Ini2 then Ini2.Free;
      end;
  end;
end;

{$warnings on}
procedure TElOptions.SetAutoSave(Value: Boolean);
begin
  FAutoSave := Value;
end;

{$WARNINGS OFF}

{$WARNINGS ON}

end.
