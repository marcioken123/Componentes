unit LMDCFCStateObject;
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

LMDCFCStateObject unit (JH)
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Controls, Classes,
  LMDCFCSettingObject, LMDCustomComponent, LMDClass;

type
  TLMDStateKind = (skFocused, skMouseAbove, skDown, skModified, skReadOnly,
                   skWrongData, skDisabled);
{$NODEFINE TLMDStateList}

  TLMDStateList = array[Low (TLMDStateKind)..High(TLMDStateKind)] of Byte;
{$HPPEMIT 'namespace Lmdcfcstateobject {'}
{$HPPEMIT 'typedef Byte TLMDStateList[7];'}
{$HPPEMIT '#define TLMDStateList TLMDStateList*'}
(*$HPPEMIT '}'*)
const
  CFCSELFLINK    = -2;
  CFCCONTROLLINK = -1;

  StateIgnore = 0;
  StateOn     = 1;
  StateOff    = 2;

  //Disabled > Error > Focused > ReadOnly > Hot > Down > Modified
  stateNormal  : TLMDStateList = (2,2,2,2,2,2,2);
  stateDisabled: TLMDStateList = (0,0,0,0,0,0,1);
  stateError   : TLMDStateList = (0,0,0,0,0,1,2);
  stateFocused : TLMDStateList = (1,0,0,0,0,2,2);
  stateReadOnly: TLMDStateList = (2,0,0,0,1,2,2);
{
  examplatory additional state:
  stateHotPress: TLMDStateList = (2,1,1,0,2,2,2);
  this state must be inserted before Hot (and so before pressed)
  otherwise it would never be selected by the algorithm, because
  stateHot already matches its internal search criteria
}
  stateHot     : TLMDStateList = (2,1,0,0,2,2,2);
  statePressed : TLMDStateList = (2,2,1,0,2,2,2);
  stateModified: TLMDStateList = (2,2,2,1,2,2,2);

  //state taking algorithm

  //build up control specific state list
  //-> e.g. (2,1,1,1,2,1,1)
  // (imaging we have another state DE (0,0,0,0,0,1,1);
  // 7x equals Disabled by 6 substitutions
  // 7x equals DE by only 5 substitutions
  //image we have a second state in addition (2, 1, 2, 2,2,2,2)
  // => 7x equals this state by 2 substitutions ... dammned
  //decicion by backtracking alg ...

const
  TLMDStateKindStr : array[Low (TLMDStateKind)..High(TLMDStateKind)] of String =
           ('Focused', 'MouseAbove', 'Down',
            'Modified', 'ReadOnly', 'WrongData', 'Disabled');

type
  TLMDCFCStateObject = class (TCollectionItem)
  private
    FKind      : TLMDStateList;
//    FFocused,
//    FMouseAbove: Boolean;
    FSettings  : TStringList;
    FLinkIndex : Integer;
    procedure SetStringList(const Value: TStringList); //-2 (self); -1 (control); 0 .. (other states)
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadKind(Reader:TReader);
    procedure WriteKind(Writer:TWriter);
    procedure ReadSettings(Reader:TReader);
    procedure WriteSettings(Writer:TWriter);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Synchronize;
    procedure SynchronizeName;
    function Paint (aControl: TControl): Boolean;
    function getKind:TLMDStateList;
    procedure setKind (aStateList: TLMDStateList);
    function Add(aSettingObject: TPersistent; replace: Boolean): Boolean;
    //function Remove(aSettingObject: TLMDCFCSettingObject):Boolean;
    function IndexOfSetting(const aValue:TLMDCFCSettingObjectKind):Integer;
  published
    property Settings: TStringList read FSettings write SetStringList;
  end;

  { -------------------------------------------------------------------------- }
  TLMDCFCStateObjects = class (TOwnedCollection)
  private
    FObjects:TLMDCFCSettingObjects;
    function GetItem(Index: Integer): TLMDCFCStateObject;
    procedure SetItem(Index: Integer; Value: TLMDCFCStateObject);
    procedure SetObjects(aValue:TLMDCFCSettingObjects);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner : TLMDCustomComponent);
    destructor Destroy; override;
    function Add: TLMDCFCStateObject;
    function ItemByKind(Index:TLMDStateList):Integer;
    property Items[Index: Integer]: TLMDCFCStateObject read GetItem write SetItem; default;
    property SettingsObjects:TLMDCFCSettingObjects read FObjects write SetObjects;
    procedure Synchronize;
    procedure SynchronizeNames;
  end;

  function LMDCFCCompareStates (s1, s2: TLMDStateList): boolean;
  function LMDCFCGetAvailableStatesCount: Integer;
  {$EXTERNALSYM LMDCFCGetAvailableState}
  function LMDCFCGetAvailableState(index: Integer): TLMDStateList;
  {$EXTERNALSYM LMDCFCGetStateByDescription}
  function LMDCFCGetStateByDescription (const des: String): TLMDStateList;
  function LMDCFCGetStateDescription (state: TLMDStateList): String; overload;
  function LMDCFCGetStateDescription (index: Integer): String; overload;

implementation
uses
  SysUtils;

type

  TLMDStateEntry = record
    sl: TLMDStateList;
    name: string;
  end;
  PLMDStateEntry = ^TLMDStateEntry;

var
  AvailableStates: TList;

{----------------------- private ----------------------------------------------}
procedure TLMDCFCStateObject.SetStringList(const Value: TStringList);
begin
  FSettings.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty ('Kind', ReadKind, WriteKind, true);
end;

{ --------------------------- findState -------------------------------------- }
function LMDCFCfindState (state: TLMDStateList): TLMDStateList;
var
  i: Integer;
begin
  for i := 0 to LMDCFCgetAvailableStatesCount - 1 do
    if LMDCFCcompareStates (state, LMDCFCgetAvailableState (i)) then
      begin
        result := LMDCFCgetAvailableState (i);
        exit;
      end;
  result := stateNormal;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.ReadKind(Reader:TReader);
var
  sk: TLMDStateKind;
  oops: boolean;
  sl: TLMDStateList;

begin
  Reader.ReadListBegin;
  sk := Low (TLMDStateKind);
  oops := false;
  while not Reader.EndOfList do
    begin
      if not oops then
        sl[sk] := Reader.ReadInteger;
      if sk = High (TLMDStateKind) then
        oops := true;
      sk := Succ (sk);
    end;
  Reader.ReadListEnd;
  FKind := LMDCFCfindState (sl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.WriteKind(Writer:TWriter);
var
  sk: TLMDStateKind;
begin
  Writer.WriteListBegin;
  for sk := Low (TLMDStateKind) to High (TLMDStateKind) do
    Writer.WriteInteger (FKind[sk]);
  Writer.WriteListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.ReadSettings(Reader:TReader);
//var
//  i: Integer;
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin
      Reader.ReadInteger;
      //add pointer to the object with the given index i
    end;
  Reader.ReadListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.WriteSettings(Writer:TWriter);
begin
  //settings is only a list of pointers to objects managed by the
  //face controller
  //so it's enough to store the index of the used objects
  Writer.WriteListBegin;

  Writer.WriteListEnd;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDCFCStateObject.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FLinkIndex := CFCCONTROLLINK; //control
  FSettings := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCFCStateObject.Destroy;
begin
  FreeAndNil(FSettings);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.Assign(Source: TPersistent);
begin
  if Source is TLMDCFCStateObject then
    begin
      FSettings.Assign((Source as TLMDCFCStateObject).Settings);
      FKind := (Source as TLMDCFCStateObject).getKind;
      Synchronize;
      exit;
    end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObject.Paint (aControl: TControl): Boolean;
begin
  if (FLinkIndex = -1) then
    begin
      //control should paint itself ...
      result := false;
      exit;
    end;

  //paint background

  //paint border

  //paint content

  result := true;

end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObject.getKind : TLMDStateList;
begin
  result := FKind;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.setKind (aStateList: TLMDStateList);
begin
  FKind := aStateList;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObject.IndexOfSetting(const aValue: TLMDCFCSettingObjectKind): Integer;
var
  tmp:TPersistentClass;
  i:Integer;
begin
  result:=-1;
  if aValue=cfcUnknown then exit;
  tmp:=LMDCFCGetSettingsClass(aValue);
  for i:=0 to FSettings.Count-1 do
     if FSettings.Objects[i] is tmp then
     begin
       result:=i;
       exit;
     end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObject.Add (aSettingObject: TPersistent; replace: Boolean): Boolean;
var
  i: Integer;
  aName:String;
begin
  result := false;
  try
//    i := -1;
    // check whether aSettingObject is member of connected SettingsObject
    if TLMDCFCStateObjects(Collection).FObjects.IndexOfObject(aSettingObject)=-1 then
      exit
    else
      aName:=TLMDCFCStateObjects(Collection).FObjects.NameOfObject(aSettingObject);

    //check whether that class of object already exists -> every class is only
    //allowed to be placed once into a list!!!
    for i := 0 to FSettings.Count - 1 do
      begin
        if TPersistent(FSettings.Objects[i]).Classname = aSettingObject.ClassName then
          break;
      end;
    if (FSettings.Count = 0) or (i = FSettings.Count) then
      begin
        result:=FSettings.AddObject(aName, aSettingObject)<>-1;
      end
    else
      if replace then
        begin
          FSettings.Objects[i] := aSettingObject;
          FSettings[i]:=aName;
          result:=True;
        end
  except
    On Exception do ;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.Synchronize;
var
  i, tmp:Integer;
begin
  i:=FSettings.Count-1;
  while i>=0 do
    begin
      tmp:=TLMDCFCStateObjects(Collection).FObjects.IndexOf(FSettings[i]);
      if tmp>-1 then  // object does not exist
        FSettings.Objects[i]:=TLMDCFCStateObjects(Collection).FObjects[tmp]
      else
        FSettings.Delete(i);
      Dec(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObject.SynchronizeName;
var
  i, tmp:Integer;
begin
  i:=FSettings.Count-1;
  while i>=0 do
    begin
      tmp:=TLMDCFCStateObjects(Collection).FObjects.IndexOf(FSettings[i]);
      if tmp=-1 then  // object does not exist or new name
        begin
          tmp:=TLMDCFCStateObjects(Collection).FObjects.IndexOfObject(TPersistent(FSettings.Objects[i]));
          if tmp=-1 then
            FSettings.Delete(i)
          else
            FSettings[i]:=TLMDCFCStateObjects(Collection).FObjects.Names[tmp];
        end;
      Dec(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObjects.Synchronize;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].Synchronize;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObjects.SynchronizeNames;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].SynchronizeName;
end;

{ **************************************************************************** }
{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObjects.GetItem(Index: Integer): TLMDCFCStateObject;
begin
  result := TLMDCFCStateObject(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObjects.ItemByKind(Index: TLMDStateList): Integer;
var
  i:Integer;
begin
  result:=-1;
  for i:=0 to Count-1 do
    if LMDCFCCompareStates(index,Items[i].getKind) then
      begin
        result:=i;
        exit;
      end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObjects.SetItem(Index: Integer; Value: TLMDCFCStateObject);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObjects.SetObjects(aValue: TLMDCFCSettingObjects);
begin
  FObjects:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCStateObjects.Update(Item: TCollectionItem);
begin
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCFCStateObjects.Create(Owner: TLMDCustomComponent);
begin
  inherited Create(Owner, TLMDCFCStateObject);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCFCStateObjects.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCStateObjects.Add: TLMDCFCStateObject;
begin
  result := TLMDCFCStateObject(inherited Add);
end;

//******************************************************************************

{ ----------------------------- addState ------------------------------------- }
procedure addState (aState: TLMDStateList; const str: String);
var
  se: PLMDStateEntry;
begin

  New (se);

  se.sl := aState;
  se.name := str;//StrNew(PCHar(str));
  AvailableStates.Add (se);
end;

{ The initAvailableStatesList procedure initializes the list of available
  state definitions. Thereby the order of insertion is relevant!!
  The earlier an item is inserted the more important it is:
  e.g. disabled superseeds every one else
}
procedure initAvailableStatesList;
begin
  addState (stateDisabled, 'Disabled');
  addState (stateError, 'Error');
  addState (stateFocused, 'Focused');
  addState (stateReadOnly, 'ReadOnly');
  addState (stateHot, 'Hot');
  addState (statePressed, 'Pressed');
  addState (stateModified, 'Modified');
  addState (stateNormal, 'Normal');
end;

{ ---------------------- getAvailableStatesCount ----------------------------- }
function LMDCFCgetAvailableStatesCount: Integer;
begin
  result := AvailableStates.Count;
end;

{ ------------------------- getAvailableState -------------------------------- }
function LMDCFCgetAvailableState(index: Integer): TLMDStateList;
begin
  Result := PLMDStateEntry(AvailableStates[index]).sl;
//  TLMDStateList (TLMDStateEntry(AvailableStates[index]).sl);
end;

{ ---------------------- getStateByDescription ------------------------------- }
function LMDCFCgetStateByDescription (const des: String): TLMDStateList;
var
  i: Integer;
begin
  result := stateNormal;
  for i := 0 to LMDCFCgetAvailableStatesCount - 1 do
    if LMDCFCgetStateDescription(i) = des then
      begin
        result := LMDCFCgetAvailableState (i);
        break;
      end;
end;

{ ------------------- getAvailableStateDescription --------------------------- }
function getAvailableStateDescription(index: Integer): String;
begin
  result := PLMDStateEntry(AvailableStates[index]).name;
end;

{ --------------------------- insertState ------------------------------------ }
{procedure insertState (index: Integer; aState: TLMDStateList; const str: String);
var
  se: ^TLMDStateEntry;
begin
  New (se);
  se^.sl := aState;
  se^.name := str;

  AvailableStates.Insert(index, se);
end;

{ ---------------------------- freeStates ------------------------------------ }
procedure freeStates;
var
  i: Integer;
begin
  for i := 0 to LMDCFCgetAvailableStatesCount - 1 do
    begin
//      StrDispose(PChar(TLMDStateEntry(AvailableStates[i]^).Name));

      Dispose (PLMDStateEntry(AvailableStates[i]));

    end;
end;

{ -------------------------- compareStates ----------------------------------- }
function LMDCFCcompareStates (s1, s2: TLMDStateList): boolean;
var
  sk: TLMDStateKind;
begin
  for sk := Low (TLMDStateKind) to High(TLMDStateKind) do
  begin
    Result := s1[sk] = s2[sk];
    if not Result then
      break;
  end;
end;

{ ---------------------- getStateDescription --------------------------------- }
function LMDCFCgetStateDescription (state: TLMDStateList): String;
var
  i: Integer;
begin
  result := '';
  i := 0;
  while (i < LMDCFCgetAvailableStatesCount) and not (LMDCFCcompareStates (state, LMDCFCgetAvailableState (i))) do
    inc (i);
  if (i < LMDCFCgetAvailableStatesCount) and (LMDCFCcompareStates (state, LMDCFCgetAvailableState (i))) then
    result := getAvailableStateDescription (i);
end;

{ ---------------------- getStateDescription --------------------------------- }
function LMDCFCgetStateDescription (index: Integer): String;
begin
  result := getAvailableStateDescription (index);
end;

initialization
  AvailableStates:= TList.Create;
  initAvailableStatesList;

finalization
  freeStates;
  AvailableStates.Free;
end.

