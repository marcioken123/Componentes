unit LMDSysObject;
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

LMDSysObject unit (JH, AH)
--------------------------
The TLMDSysObject is the ancestor class for the LMDSys system objects.
Important: property descriptions, hints (from file: see FInfoFilename)

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, LMDSysBase, LMDSysPropertyDesc, LMDSysLog;

type
  TLMDSysAvailability = (aUnDefined, aOther, aUnknown, aRunning, aWarning,
    aInTest, aNotApplicable, aPowerOff, aOffLine, aOffDuty, aDegraded,
    aNotInstalled, aInstallError, aPowerSaveUnknown, aPowerSaveLowPowerMode,
    aPowerSaveStandby, aPowerCycle, aPowerSaveWarning);

  TLMDSysPowerManagementCapability = (pmUnknown, pmNotSupported, pmDisabled,
    pmEnabled, pmPowerSavingModesEnteredAutomatically, pmPowerStateSettable,
    pmPowerCyclingSupported, pmTimedPowerOnSupported);
  TLMDSysPowerManagementCapabilities = set of TLMDSysPowerManagementCapability;

  TLMDSysStatusInfo = (siUndefined, siOther, siUnknown, siEnabled, siDisabled,
    siNotApplicable);

  TLMDOnFilterPropName=procedure (const Name:String; var Cancel:Boolean) of object;

  { ************************************************************************** }
  TLMDSysObject = class(TPersistent, IUnknown, ILMDSysDescriptor, ILMDSysPublisher)
  private
    FApplyChangesAtOnce: Boolean;
    //pointer to an owner! This pointer is not maintained by the object => test
    //before use!!
    FOwner: TPersistent;
    FOnChangeLog: TLMDSysLogChangeEvent;
    FRegistry: TRegistry;

    //file containing property descriptions and hints
    FInfoFilename: string;

    FChanges: TList;
    //FWMIObject : TLMDSysWMIObject;

    // required only for descendants which initialize static properties --> See Init
    procedure SetRegistry(aValue: TRegistry);
  protected
    FInit:Boolean;
    FInstantUpdate: Boolean;
    FRefCount: Integer;
    FPropertiesDesc : TLMDSysPropertiesDesc;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure SetChangeLog(const Value: TLMDSysLogChangeEvent);
    procedure DoLog(Sender: TObject; propertyDescription, oldValue, newValue: string; datetime: TDateTime);

    //if set to true sys-property changes will be set at once
    property ApplyChangesAtOnce: Boolean read FApplyChangesAtOnce write FApplyChangesAtOnce default false;
    //a call to this procedure will fire the OnChangeLog event (if it is assigned)
    procedure LogChange(const valueDescription, oldValue, newValue: string; datetime: TDateTime);
    //wrapper around LogChange, adds Now as datetime
    procedure Log(const valueDescription, oldValue, newValue: string);
    //function for retrieving property description from a file
    //function GetPropDesFromFile (const propName: String): String;
    //function GetPropHintFromFile (const propName: String): String;
    //if InstantUpdate is enabled the information to be read is extracted again!
    property InstantUpdate: Boolean read FInstantUpdate write FInstantUpdate;

    // register property names, fill FDescription Collection
    procedure RegisterProperties; virtual;

    // if Programmer calls GetValues, we need to filter out [..]Info properties
    procedure DoFilterProperty(const Name:String; var Cancel:Boolean);virtual;

    // Log / Change methods
    procedure RememberChange(const valueDescription, oldValue, newValue: string);
    procedure ClearChanges;
    function PropChanged(const valueDescription: string): Boolean;
    procedure WriteToLog(const valueDescription: string);

    //property WMIObject : TLMDSysWMIObject read FWMIObject;
    procedure DoProgress(aCaption : string; aMax, aPosition : integer);
  public
    //if this event is assigned all property changes are reported through it BEFORE they are set
    property OnChangeLog: TLMDSysLogChangeEvent read FOnChangeLog write SetChangeLog;
    //set the owner of the object
    procedure SetOwner(aValue: TPersistent);

    property Owner: TPersistent read FOwner write SetOwner;

    //GetValues shall return all sys-property settings as strings
    procedure GetValues(aText: TStrings); virtual;
    procedure GetValuesEx(aText: TStrings); virtual;

    // is called by owner  control to initialize static properties
    procedure Init; virtual;

    //If Refresh is called all property values are discarded and retrieved again
    procedure Refresh; virtual; abstract;

    //If Apply is called, and FApplyChangesAtOnce is false the property changes will be set
    //change to function for error handling?
    procedure Apply; virtual; abstract;
    constructor Create; virtual;
//    constructor Create(aOwner:TComponent); virtual; overload;
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;

    function GetElementTitle : string; virtual;
    function GetElementDescription : string; virtual;
    function GetElementType : TLMDSysInfoType; virtual;
    function GetPropertiesCount: integer; virtual;
    function GetPropAvailability(index : integer) : boolean; virtual;
    function GetPropType(index : integer) : TLMDSysPropertyType; virtual;
    function GetPropValue(index : integer) : variant; virtual;
    function GetPropText(index : integer) : string; virtual;
    function GetPropTitle(index : integer) : string; virtual;
    function GetPropDescription(index : integer) : string; virtual;

    //procedure BindWMIObject(aObject : ISWbemObject);

    property Registry: TRegistry read FRegistry write SetRegistry;
    //opens the system registry for retrieving/writing registry data
    //if readonly is enabled the data can only be written
    procedure OpenRegistry(aReadOnly: Boolean);
    //closes a previously opened registry session
    //used automatically by the destructor
    procedure CloseRegistry;
    //open the specified the root key in the registry
    procedure SetRegistryRootKey(aRootKey: HKEY);
    //open the sub key, returns false if this fails
    function OpenRegistrySubKey(const aSubKey: string): Boolean;
    //close registry sub key, will save changes if there are changes to be saved

    procedure CloseRegistrySubKey;
    //checks whether the property with the given name is
    //available on the current platform, this function should be overriden if
    //the derived sysobject provides proeprties not available in all systems
    function isPropertyAvailable(const propName: string): Boolean; virtual;
    //the getPropertyX function shall return texts which can be used by a programmer
    //for displaying further information about the property
    //by default they will return an empty string.
    //It should be possible to use ressource strings as well as external text files
    //ini files with sections names Classname.propertyname (.d = des; .h = hint)
    function getPropertyDescription(const propName: string): string; virtual;
    function getPropertyHint(const propName: string): string; virtual;
  published
  end;

  TLMDSysObjectClass = class of TLMDSysObject;

  TLMDSysBaseCollection = class(TCollection, IUnknown, ILMDSysContainer, ILMDSysDescriptor)
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure DoProgress(aCaption : string; aMax, aPosition : integer);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    function GetElementCount : integer; virtual;
    function GetElement(index : integer) : TObject;  virtual;
    function GetElementTitle : string;  virtual;
    function GetElementDescription : string;  virtual;
    function GetElementType : TLMDSysInfoType; virtual;
    property RefCount: Integer read FRefCount;
  end;

  TLMDSysBaseCollectionItem = class(TCollectionItem, IUnknown, ILMDSysDescriptor, ILMDSysPublisher)
  protected
    FRefCount: Integer;
    FPropertiesDesc : TLMDSysPropertiesDesc;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure RegisterProperties; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    function GetElementTitle : string; virtual;
    function GetElementDescription : string; virtual;
    function GetElementType : TLMDSysInfoType; virtual;
    function GetPropertiesCount: integer; virtual;
    function GetPropAvailability(index : integer) : boolean; virtual;
    function GetPropType(index : integer) : TLMDSysPropertyType; virtual;
    function GetPropValue(index : integer) : variant; virtual;
    function GetPropText(index : integer) : string; virtual;
    function GetPropTitle(index : integer) : string; virtual;
    function GetPropDescription(index : integer) : string; virtual;
    property RefCount: Integer read FRefCount;
  end;

  TLMDSysCollection = class(TLMDSysBaseCollection)
  private
    FChanges: TList;
    FOnChangeLog: TLMDSysLogChangeEvent;
    procedure SetChangeLog(const Value: TLMDSysLogChangeEvent);
  protected
    procedure LogChange(const valueDescription, oldValue, newValue: string; datetime: TDateTime);
    procedure Log(const valueDescription, oldValue, newValue: string);
  public
    constructor Create(ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    procedure RememberChange(const valueDescription, oldValue, newValue: string);
    function PropChanged(const valueDescription: string): Boolean;
    procedure WriteToLog(const valueDescription: string);
    procedure Apply; virtual;
    procedure GetValues(aText: TStrings); virtual;
    procedure GetValuesEx(aText: TStrings); virtual;
    property OnChangeLog: TLMDSysLogChangeEvent read FOnChangeLog write SetChangeLog;
  end;

  TLMDSysCollectionItem = class(TLMDSysBaseCollectionItem)
  public
    procedure RememberChange(const valueDescription, oldValue, newValue: string);
    function PropChanged(const valueDescription: string): Boolean;
    procedure WriteToLog(const valueDescription: string);
    procedure Apply; virtual;
  end;

function BoolToStr(aValue: Boolean): string;
function SysStatusInfoToStr(SysStatusInfo : TLMDSysStatusInfo) : string;
function SysPowerManagementCapabilitiesToStr(PowerCaps : TLMDSysPowerManagementCapabilities) : string;
function SysAvailabilityToStr(aSysAvailability : TLMDSysAvailability) : string;

implementation

uses
  TypInfo, LMDSysConst, LMDSysBaseComponent;

type
  TPropChange = class
    propName: string;
    oldValue: string;
    newValue: string;
  end;

  TLogProc = procedure(const valueDescription, oldValue, newValue: string) of object;

function SysAvailabilityToStr(aSysAvailability : TLMDSysAvailability) : string;
begin
  case aSysAvailability of
    aUnDefined : result := sLMDSysAvailabilityUnDefined;
    aOther : result := sLMDSysAvailabilityOther;
    aUnknown : result := sLMDSysAvailabilityUnknown;
    aRunning : result := sLMDSysAvailabilityRunning;
    aWarning : result := sLMDSysAvailabilityWarning;
    aInTest : result := sLMDSysAvailabilityInTest;
    aNotApplicable : result := sLMDSysAvailabilityNotApplicable;
    aPowerOff : result := sLMDSysAvailabilityPowerOff;
    aOffLine : result := sLMDSysAvailabilityOffLine;
    aOffDuty : result := sLMDSysAvailabilityOffDuty;
    aDegraded : result := sLMDSysAvailabilityDegraded;
    aNotInstalled : result := sLMDSysAvailabilityNotInstalled;
    aInstallError : result := sLMDSysAvailabilityInstallError;
    aPowerSaveUnknown : result := sLMDSysAvailabilityPowerSaveUnknown;
    aPowerSaveLowPowerMode : result := sLMDSysAvailabilityPowerSaveLowPowerMode;
    aPowerSaveStandby : result := sLMDSysAvailabilityPowerSaveStandby;
    aPowerCycle : result := sLMDSysAvailabilityPowerCycle;
    aPowerSaveWarning : result := sLMDSysAvailabilityPowerSaveWarning;
  end;
end;

function SysPowerManagementCapabilitiesToStr(PowerCaps : TLMDSysPowerManagementCapabilities) : string;
begin
  result := '';
  if pmUnknown in PowerCaps then result := result + ' ' + sLMDSysPMCpmUnknown;
  if pmNotSupported in PowerCaps then result := result + ' ' + sLMDSysPMCpmNotSupported;
  if pmDisabled in PowerCaps then result := result + ' ' + sLMDSysPMCpmDisabled;
  if pmEnabled in PowerCaps then result := result + ' ' + sLMDSysPMCpmEnabled;
  if pmPowerSavingModesEnteredAutomatically in PowerCaps then result := result + ' ' + sLMDSysPMCpmPowerSavingModesEnteredAutomatically;
  if pmPowerStateSettable in PowerCaps then result := result + ' ' + sLMDSysPMCpmPowerStateSettable;
  if pmPowerCyclingSupported in PowerCaps then result := result + ' ' + sLMDSysPMCpmPowerCyclingSupported;
  if pmTimedPowerOnSupported in PowerCaps then result := result + ' ' + sLMDSysPMCpmTimedPowerOnSupported;
end;

function SysStatusInfoToStr(SysStatusInfo : TLMDSysStatusInfo) : string;
begin
  case SysStatusInfo of
    siUndefined : result := sLMDSysSIUndefined;
    siOther : result := sLMDSysSIOther;
    siUnknown : result := sLMDSysSIUnknown;
    siEnabled : result := sLMDSysSIEnabled;
    siDisabled : result := sLMDSysSIDisabled;
    siNotApplicable : result := sLMDSysSINotApplicable;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure InternalRememberChange(aChanges: TList; const valueDescription, oldValue, newValue: string);
var
  I: LongInt;
  P: TPropChange;
begin
  for I:= 0 to aChanges.Count - 1 do
    if TPropChange(aChanges[I]).propName = valueDescription then
      begin
        if newValue = TPropChange(aChanges[I]).oldValue then
          begin
            TPropChange(aChanges[I]).Free;
            aChanges.Delete(I);
          end
        else
          TPropChange(aChanges[I]).newValue:= newValue;
        exit;
      end;
  P:= TPropChange.Create;
  P.propName:= valueDescription;
  P.oldValue:= oldValue;
  P.newValue:= newValue;
  aChanges.Add(P);
end;

{ ---------------------------------------------------------------------------- }
function InternalPropChanged(aChanges: TList; const valueDescription: string): Boolean;
var
  I: LongInt;
begin
  for I:= 0 to aChanges.Count - 1 do
    if TPropChange(aChanges[I]).propName = valueDescription then
      begin
        Result:= true;
        exit;
      end;
  Result:= false;
end;

{ ---------------------------------------------------------------------------- }
procedure InternalWriteToLog(aChanges: TList; aLogProc: TLogProc; const valueDescription: string);
var
  I: LongInt;
begin
  for I:= 0 to aChanges.Count - 1 do
    if TPropChange(aChanges[I]).propName = valueDescription then
      begin
        aLogProc(TPropChange(aChanges[I]).propName, TPropChange(aChanges[I]).oldValue,
          TPropChange(aChanges[I]).newValue);
        TPropChange(aChanges[I]).Free;
        aChanges.Delete(I);
        exit;
      end;
end;

{ ***************************** TLMDSysObject ******************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysObject.SetRegistry(aValue: TRegistry);
begin
  //FRegistry := aValue;
end;

{ ------------------------------- protected ---------------------------------- }

function TLMDSysObject.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.LogChange(const valueDescription, oldValue, newValue: string; datetime: TDateTime);
begin
  if Assigned(FOnChangeLog) then
    FOnChangeLog(self, valueDescription, oldValue, newValue, datetime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.Log(const valueDescription, oldValue, newValue: string);
begin
  LogChange(valueDescription, oldValue, newValue, Now);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.RegisterProperties;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.DoProgress(aCaption : string; aMax, aPosition : integer);
begin
  if Owner = nil then Exit;
  if Owner is TLMDSysBaseComponent then
    TLMDSysBaseComponent(Owner).DoProgress(aCaption, aMax, aPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.DoFilterProperty(const Name: String; var Cancel: Boolean);
begin
  if Name='DisplayInfo' then Cancel:=True;
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSysObject.SetOwner(aValue: TPersistent);
begin
  FOwner:= aValue;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSysObject.Create;
begin
  inherited Create;

  //set default filename for property descriptions and hints for the file
  FInfoFilename:= ClassName + '.lsi';

  //extract info only once!
  FInstantUpdate:= false;
  FChanges:= TList.Create;
  FPropertiesDesc := TLMDSysPropertiesDesc.Create;
  //FWMIObject := TLMDSysWMIObject.Create;
  RegisterProperties;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysObject.Destroy;
begin
  CloseRegistry;
  FOwner:= nil;
  FChanges.Free;
  //FWMIObject.Free;
  FPropertiesDesc.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysObject.AfterConstruction;
begin
  inherited;
//  InterlockedDecrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.BeforeDestruction;
begin
  inherited;
//  if RefCount <> 0 then RunError(204);
  if RefCount > 1 then RunError(204);
end;

{ ---------------------------------------------------------------------------- }

class function TLMDSysObject.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TLMDSysObject(Result).FRefCount := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetElementTitle : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetElementDescription : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetElementType : TLMDSysInfoType;
begin
  result := itUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropertiesCount: integer;
begin
  result := FPropertiesDesc.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropAvailability(index : integer) : boolean;
begin
  result := False;
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Available;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropType(index : integer) : TLMDSysPropertyType;
begin
  result := ptUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropValue(index : integer) : variant;
begin
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropText(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropTitle(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Title;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.GetPropDescription(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Description;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.OpenRegistry(aReadOnly: Boolean);
begin
  if not Assigned(FRegistry) then
    if aReadOnly then
      FRegistry:= TRegistry.Create(KEY_READ)
    else
      FRegistry:= TRegistry.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.CloseRegistry;
begin
  if not Assigned(FRegistry) then exit;
  FreeAndNil(FRegistry);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.SetRegistryRootKey(aRootKey: HKEY);
begin
  if not Assigned(FRegistry) then exit;
  FRegistry.RootKey:= aRootKey;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.OpenRegistrySubKey(const aSubKey: string): Boolean;
begin
  Result:= false;
  if not Assigned(FRegistry) then exit;
  Result:= FRegistry.OpenKey(aSubKey, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.CloseRegistrySubKey;
begin
  if not Assigned(FRegistry) then exit;
  FRegistry.CloseKey;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.isPropertyAvailable(const propName: string): Boolean;
begin
  Result:= true;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.getPropertyDescription(const propName: string): string;
begin
  Result:= '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.getPropertyHint(const propName: string): string;
begin
  Result:= '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.RememberChange(const valueDescription, oldValue, newValue: string);
begin
  InternalRememberChange(FChanges, valueDescription, oldValue, newValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.ClearChanges;
begin
  while FChanges.Count <> 0 do
    begin
      TPropChange(FChanges[0]).Free;
      FChanges.Delete(0);
    end;
end;

{ ---------------------------------------------------------------------------- }
function BoolToStr(aValue: Boolean): string;
begin
  if aValue then
    Result:= 'true'
  else
    Result:= 'false';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.SetChangeLog(const Value: TLMDSysLogChangeEvent);
begin
  FOnChangeLog:= Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysObject.PropChanged(const valueDescription: string): Boolean;
begin
  Result:= InternalPropChanged(FChanges, valueDescription);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.WriteToLog(const valueDescription: string);
begin
  InternalWriteToLog(FChanges, Log, valueDescription);
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDSysObject.BindWMIObject(aObject : ISWbemObject);
begin
  FWMIObject.Bind(aObject);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysObject.Init;
begin
  Finit:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure InternalGetValues(aObject: TObject; aText: TStrings; aPrefix: String; aTypeName: Boolean; CheckProc:TLMDOnFilterPropName=nil);
var
  PList: PPropList;
  Count: integer;
  I, J: integer;
  //  nam, kindname: string;
  Value: string;
  clsVal: TObject;
  Cancel:Boolean;
begin
  Count := GetTypeData(aObject.ClassInfo)^.PropCount;
  GetMem(PList, Count * SizeOf(Pointer));
  try
    GetPropInfos(aObject.ClassInfo, PList);
    for I:= 0 to Count - 1 do
    begin
        Value := '';
        Cancel := False;
        case PList^[I]^.PropType^.Kind of
        tkUnknown: ;
          tkInteger:
            Value:= IntToStr(GetOrdProp(aObject, String(PList^[I]^.Name)));
          tkInt64:
            Value:= IntToStr(GetInt64Prop(aObject, String(PList^[I]^.Name)));
          tkChar, tkString, tkWChar, tkLString, tkWString{$IFDEF LMDCOMP12}, tkUString{$ENDIF}:
            Value:= GetStrProp(aObject, String(PList^[I]^.Name));
          tkEnumeration:
            Value:= GetEnumProp(aObject, String(PList^[I]^.Name));
          tkFloat:
            Value:= FloatToStr(GetFloatProp(aObject, String(PList^[I]^.Name)));
          tkSet:
            Value:= '[' + GetSetProp(aObject, String(PList^[I]^.Name)) + ']';
          tkClass:
            begin
              clsVal:= GetObjectProp(aObject, String(PList^[I]^.Name));
              if clsVal is TStrings then
                Value:= TStrings(clsVal).CommaText
              else
                begin
                  InternalGetValues(clsVal, aText, aPrefix + String(PList^[I]^.Name) + '.', aTypeName, CheckProc);
                  Continue;
                end;
            end;
          tkMethod,
            tkVariant,
            tkArray,
            tkRecord,
            tkInterface,
            tkDynArray:
            Value:= 'UNKNOWN';
        end;
        if Assigned(CheckProc) then
          CheckProc(String(PList^[I]^.Name), Cancel);
        if not Cancel then
          if aTypeName then
            aText.Add( aPrefix + String(PList^[I]^.Name) + ': ' + String(PList^[I]^.PropType^.Name) + ' = ' + Value)
          else
            aText.Add( aPrefix + String(PList^[I]^.Name) + ' = ' + Value);
        end;
  finally
    FreeMem(PList, Count * SizeOf(Pointer));
    end;

  if aObject is TCollection then
    for J:= 0 to TCollection(aObject).Count - 1 do
      begin
        InternalGetValues(TCollection(aObject).Items[J], aText,
          aPrefix + 'Item[' + IntToStr(J) + '].', aTypeName, CheckProc);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.GetValues(aText: TStrings);
begin
  InternalGetValues(self, aText, '', false, DoFilterProperty);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.GetValuesEx(aText: TStrings);
begin
  InternalGetValues(self, aText, '', true, DoFilterProperty);
end;

{ ******************************* TLMDSysBaseCollection ********************** }
{ ------------------------------- private ------------------------------------ }
{ ------------------------------- protected ---------------------------------- }

function TLMDSysBaseCollection.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;
{ ------------------------------- public ------------------------------------- }
procedure TLMDSysBaseCollection.AfterConstruction;
begin
  inherited;
//  InterlockedDecrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseCollection.BeforeDestruction;
begin
  inherited;
//  if RefCount <> 0 then RunError(204);
  if RefCount > 1 then RunError(204);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDSysBaseCollection.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TLMDSysBaseCollection(Result).FRefCount := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection.GetElementCount : integer;
begin result := count; end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection.GetElement(index : integer) : TObject;
begin
  result := nil;
  if (index < 0) or (index >= count) then Exit;
  result := TObject(inherited GetItem(index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection.GetElementTitle : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection.GetElementDescription : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollection.GetElementType : TLMDSysInfoType;
begin
  result := itUnknown;
end;

{ ---------------------------------------------------------------------------- }

{ ******************************* TLMDSysBaseCollectionItem ****************** }
{ ------------------------------- private ------------------------------------ }
{ ------------------------------- protected ---------------------------------- }

function TLMDSysBaseCollectionItem.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseCollectionItem.RegisterProperties;
begin FPropertiesDesc.Clear; end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysBaseCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FPropertiesDesc := TLMDSysPropertiesDesc.Create;
  RegisterProperties;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysBaseCollectionItem.Destroy;
begin
  FPropertiesDesc.Free;
  inherited Destroy;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDSysBaseCollectionItem.AfterConstruction;
begin
  inherited;
//  InterlockedDecrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseCollectionItem.BeforeDestruction;
begin
  inherited;
//  if RefCount <> 0 then RunError(204);
  if RefCount > 1 then RunError(204);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDSysBaseCollectionItem.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TLMDSysBaseCollectionItem(Result).FRefCount := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetElementTitle : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetElementDescription : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetElementType : TLMDSysInfoType;
begin
  result := itUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropertiesCount: integer;
begin
  result := FPropertiesDesc.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropAvailability(index : integer) : boolean;
begin
  result := False;
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Available;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropType(index : integer) : TLMDSysPropertyType;
begin result := ptUnknown; end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropValue(index : integer) : variant;
begin result := 0; end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropText(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropTitle(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Title;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseCollectionItem.GetPropDescription(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Description;
end;

{ ---------------------------------------------------------------------------- }

{ ************************************************************************** }
{ TLMDSysCollection }
{ ------------------------------- protected ---------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseCollection.DoProgress(aCaption : string; aMax, aPosition : integer);
begin
  if GetOwner = nil then Exit;
  if GetOwner is TLMDSysBaseComponent then
    TLMDSysBaseComponent(GetOwner).DoProgress(aCaption, aMax, aPosition);
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSysCollection.Apply;
var
  I: LongInt;
begin
  for I:= 0 to Count - 1 do
    (Items[I] as TLMDSysCollectionItem).Apply;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSysCollection.Create;
begin
  inherited;
  FChanges:= TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysCollection.Destroy;
begin
  FChanges.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.GetValues(aText: TStrings);
begin
  InternalGetValues(self, aText, '', false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.GetValuesEx(aText: TStrings);
begin
  InternalGetValues(self, aText, '', true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.Log(const valueDescription, oldValue,
  newValue: string);
begin
  LogChange(valueDescription, oldValue, newValue, Now);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.LogChange(const valueDescription, oldValue,
  newValue: string; datetime: TDateTime);
begin
  if Assigned(FOnChangeLog) then
    FOnChangeLog(self, valueDescription, oldValue, newValue, datetime);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysCollection.PropChanged(
  const valueDescription: string): Boolean;
begin
  Result:= InternalPropChanged(FChanges, valueDescription);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.RememberChange(const valueDescription,
  oldValue, newValue: string);
begin
  InternalPropChanged(FChanges, valueDescription);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.SetChangeLog(
  const Value: TLMDSysLogChangeEvent);
begin
  FOnChangeLog:= Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollection.WriteToLog(const valueDescription: string);
begin
  InternalWriteToLog(FChanges, Log, valueDescription);
end;

{ ************************************************************************** }
{ TLMDSysCollectionItem }
{ ------------------------------- protected ---------------------------------- }
{ ------------------------------- public ------------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollectionItem.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysCollectionItem.PropChanged(
  const valueDescription: string): Boolean;
begin
  result := (Collection as TLMDSysCollection).PropChanged(Format(valueDescription, [Index]));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollectionItem.RememberChange(const valueDescription,
  oldValue, newValue: string);
begin
  (Collection as TLMDSysCollection).RememberChange(Format(valueDescription, [Index]), oldValue, newValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysCollectionItem.WriteToLog(const valueDescription: string);
begin
  (Collection as TLMDSysCollection).WriteToLog(Format(valueDescription, [Index]));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysObject.DoLog(Sender: TObject; propertyDescription,
  oldValue, newValue: string; datetime: TDateTime);
begin
  LogChange(propertyDescription, oldValue, newValue, datetime);
end;

end.
