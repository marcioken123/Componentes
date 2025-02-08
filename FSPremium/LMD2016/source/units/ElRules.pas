unit ElRules;
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

ElRules unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Windows, Messages, Classes, ElObjList, ElIni, ElList;

type

  TElRulePartClass = class of TElRulePart;
  TElRuleConditionClass = class of TElRuleCondition;
  TElRuleActionClass = class of TElRuleAction;

  TElRules = class;
  TElRule = class;
  TElRulePart = class;
  TElRuleAction = class;
  TElRuleActions = class;
  TElRuleConditions = class;
  TElRuleParts = class;

  {:
  }
  TElRuleParts = class (TElHeteroObjectList)
  public
    function GetOwner: TPersistent; override;
  end;

  {:
  }
  TElRules = class (TElObjectList)
  private
    function GetItems(Index: Integer): TElRule;
    procedure SetItems(Index: Integer; Value: TElRule);
  public
    constructor Create(Owner : TPersistent); virtual;
    function Add: TElRule;
    procedure ProcessAllRules(TimeMoment : TDateTime);
    property Items[Index: Integer]: TElRule read GetItems write SetItems;
        default;
  end;

  {:
  }
  TElRule = class (TElObjectListItem)
  private
    FActions: TElRuleActions;
    FConditions: TElRuleConditions;
    FEnabled: Boolean;
    FHidden: Boolean;
    FInProgress: Boolean;
    FMeetAllConditions: Boolean;
    FName: String;
    FOneTime: Boolean;
    procedure SetActions(Value: TElRuleActions);
    procedure SetConditions(Value: TElRuleConditions);
  public
    constructor Create(List : TElObjectList); override;
    destructor Destroy; override;
    procedure AfterLoad(IniFile : TElIniFile; KeyName : string); override;
    procedure AfterSave(IniFile : TElIniFile; KeyName : string); override;
    procedure Assign(Source : TPersistent); override;
    function IsInEffect: Boolean;
    procedure Process(CurrentTime : TDateTime);
    property InProgress: Boolean read FInProgress write FInProgress;
  published
    property Actions: TElRuleActions read FActions write SetActions;
    property Conditions: TElRuleConditions read FConditions write SetConditions;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Hidden: Boolean read FHidden write FHidden;
    property MeetAllConditions: Boolean read FMeetAllConditions write
        FMeetAllConditions;
    property Name: String read FName write FName;
    property OneTime: Boolean read FOneTime write FOneTime;
  end;

  {:
  }
  TElRulePart = class (TElObjectListItem)
  protected
    FDetails: String;
  public
    procedure AfterLoad(IniFile : TElIniFile; KeyName : string); override;
    procedure Assign(Source : TPersistent); override;
    procedure BeforeSave(IniFile : TElIniFile; KeyName : string); override;
    procedure CreateDetailsString; virtual;
    {:
    Returns the descriptive name of the rule part itself
    (in format, suitable for further use in ElHTMLView).
    Example:

      <a href="12345678">2Connect.exe</a> is running

    12345678 = IntToStr(TLMDPtrInt(Pointer(Rule part object)))
    }
    function GetDescriptionString: String; virtual; abstract;
    {:
    Returns the descriptive name of the rule part class
    Example:

      When the application is running
    }
    class function GetNameString: String; virtual; abstract;
    procedure ParseDetailsString; virtual;
  published
    property Details: String read FDetails write FDetails;
  end;

  {:
  }
  TElRuleAction = class (TElRulePart)
  public
    {:
    Perform MUST return true, if further processing is allowed
    and makes sence. If the processing must be stopped, the
    function MUST return false.
    }
    function Perform(CurrentTime : TDateTime): Boolean; virtual; abstract;
  end;

  {:
  }
  TElRuleActions = class (TElRuleParts)
  private
    function GetItems(Index: Integer): TElRuleAction;
    procedure SetItems(Index: Integer; Value: TElRuleAction);
  public
    function Add(ActionClass : TElRuleActionClass): TElRuleAction;
    procedure Assign(Source : TPersistent); override;
    property Items[Index: Integer]: TElRuleAction read GetItems write SetItems;
        default;
  end;

  {:
  }
  TElRuleCondition = class (TElRulePart)
  private
    FInverted: Boolean;
  public
    {:
    TElRuleCondition.ActionPerformed
    (AtTime)
    TElRuleCondition.ActionPerformed
    (AtTime)
    TElRuleCondition.ActionPerformed
    (AtTime)
    TElRuleCondition.ActionPerformed
    (AtTime)
    This method is called when the rule, to which the condition
    belongs, has performed its actions.
    The condition object can override this method and perform
    some internal operations, like resetting some flag or
    anything else it likes.
    }
    procedure ActionPerformed(AtTime : TDateTime); virtual;
    procedure Assign(Source : TPersistent); override;
    {:
    The condition MUST return the value, that determines,
    whether the condition is met. This method is called only
    when Enabled property is set to true.
    }
    function IsInEffect(CurrentTime : TDateTime): Boolean; virtual; abstract;
  published
    property Inverted: Boolean read FInverted write FInverted;
  end;

  {:
  }
  TElRuleConditions = class (TElRuleParts)
  private
    function GetItems(Index: Integer): TElRuleCondition;
    procedure SetItems(Index: Integer; Value: TElRuleCondition);
  public
    function Add(ConditionClass : TElRuleConditionClass): TElRuleCondition;
    procedure Assign(Source : TPersistent); override;
    property Items[Index: Integer]: TElRuleCondition read GetItems write
        SetItems; default;
  end;

implementation

{:
}
{:
}
{
*********************************** TElRules ***********************************
}
constructor TElRules.Create(Owner : TPersistent);
begin
  inherited Create(Owner, TElRule);
end;

function TElRules.Add: TElRule;
begin
  Result := TElRule(inherited Add);
end;

function TElRules.GetItems(Index: Integer): TElRule;
begin
  result := TElRule(inherited Items[Index]);
end;

procedure TElRules.ProcessAllRules(TimeMoment : TDateTime);
var
  I: Integer;
  CurrentTime: TDateTime;
begin
  for i := 0 to Count -1 do
  begin
    if Items[i].Enabled and (not Items[i].InProgress) then
       Items[i].Process(TimeMoment);
  end;
end;

procedure TElRules.SetItems(Index: Integer; Value: TElRule);
begin
  inherited Items[Index] := Value;
end;

{:
}
{
****************************** TElRuleConditions *******************************
}
function TElRuleConditions.Add(ConditionClass : TElRuleConditionClass):
    TElRuleCondition;
begin
  ListItemClass := ConditionClass;
  result := TElRuleCondition(inherited Add);
end;

procedure TElRuleConditions.Assign(Source : TPersistent);
var
  I: Integer;
  Item: TElRuleCondition;
begin
    if Source is TElRuleConditions then
    begin
      Clear;
      for i := 0 to TElRuleConditions(Source).Count -1 do
      begin
        Item := TElRuleCondition(TElRuleConditions(
            Source).Items[i].ClassType).Create(Self);
        Item.Assign(TElRuleConditions(Source).Items[i]);
        inherited AddItem(Item);
      end;
    end
    else
      inherited;
end;

function TElRuleConditions.GetItems(Index: Integer): TElRuleCondition;
begin
  result := TElRuleCondition(inherited Items[Index]);
end;

procedure TElRuleConditions.SetItems(Index: Integer; Value: TElRuleCondition);
begin
  inherited Items[Index] := Value;
end;

{:
}
{
********************************* TElRuleParts *********************************
}
function TElRuleParts.GetOwner: TPersistent;
begin
  result := inherited GetOwner;
end;

{:
}
{
******************************* TElRuleCondition *******************************
}
{:
TElRuleCondition.ActionPerformed
(AtTime)
TElRuleCondition.ActionPerformed
(AtTime)
TElRuleCondition.ActionPerformed
(AtTime)
TElRuleCondition.ActionPerformed
(AtTime)
TElRuleCondition.ActionPerformed
(AtTime)
This method is called when the rule, to which the condition
belongs, has performed its actions.
The condition object can override this method and perform
some internal operations, like resetting some flag or
anything else it likes.
}
procedure TElRuleCondition.ActionPerformed(AtTime : TDateTime);
begin
end;

procedure TElRuleCondition.Assign(Source : TPersistent);
begin
  inherited Assign(Source);
  if Source is TElRuleCondition then
    Inverted := TElRuleCondition(Source).Inverted;
end;

{:
}
{
******************************** TElRuleActions ********************************
}
function TElRuleActions.Add(ActionClass : TElRuleActionClass): TElRuleAction;
begin
  ListItemClass := ActionClass;
  result := TElRuleAction(inherited Add);
end;

procedure TElRuleActions.Assign(Source : TPersistent);
var
  Item: TElRuleAction;
  I: Integer;
begin
    if Source is TElRuleActions then
    begin
      Clear;
      for i := 0 to TElRuleActions(Source).Count -1 do
      begin
        Item := TElRuleAction(TElRuleActions(Source).Items[i].ClassType).Create(
            Self);
        Item.Assign(TElRuleActions(Source).Items[i]);
        inherited AddItem(Item);
      end;
    end
    else
      inherited;
end;

function TElRuleActions.GetItems(Index: Integer): TElRuleAction;
begin
  result := TElRuleAction(inherited Items[Index]);
end;

procedure TElRuleActions.SetItems(Index: Integer; Value: TElRuleAction);
begin
  inherited Items[Index] := Value;
end;

{:
}
{
*********************************** TElRule ************************************
}
constructor TElRule.Create(List : TElObjectList);
begin
  inherited Create(List);
  FConditions := TElRuleConditions.Create(Self, TElRuleCondition);
  FActions := TElRuleActions.Create(Self, TElRuleAction);
end;

destructor TElRule.Destroy;
begin
  FConditions.Free;
  FActions.Free;
  inherited Destroy;
end;

procedure TElRule.AfterLoad(IniFile : TElIniFile; KeyName : string);
begin
  inherited AfterLoad(IniFile, KeyName);
  //IniFile.ReadObject(KeyName + IniFile.Delimiter + 'Conditions', FConditions);
  //IniFile.ReadObject(KeyName + IniFile.Delimiter + 'Actions', FActions);
end;

procedure TElRule.AfterSave(IniFile : TElIniFile; KeyName : string);
begin
  inherited AfterSave(IniFile, KeyName);
  //IniFile.WriteObject(KeyName + IniFile.Delimiter + 'Conditions', FConditions);
  //IniFile.WriteObject(KeyName + IniFile.Delimiter + 'Actions', FActions);
end;

procedure TElRule.Assign(Source : TPersistent);
begin
  if Source is TElRule then
  begin
    Actions.Assign(TElRule(Source).Actions);
    Conditions.Assign(TElRule(Source).Conditions);
    Enabled := TElRule(Source).Enabled;
    MeetAllConditions := TElRule(Source).MeetAllConditions;
    OneTime := TElRule(Source).OneTime;
    Name := TElRule(Source).Name;
  end else
    inherited;
end;

function TElRule.IsInEffect: Boolean;
var
  b: Boolean;
  I: Integer;
  CurrentTime: TDateTime;
  ACondition: TElRuleCondition;
begin
  b := false;
  CurrentTime := Now;
  for i := 0 to Conditions.Count - 1 do
  begin
    ACondition := Conditions[i];
    //if ACondition.Enabled then
      if ACondition.IsInEffect(CurrentTime) xor ACondition.Inverted then
      begin
        if not MeetAllConditions then
        begin
          b := true;
          break;
        end;
      end else
      begin
        if MeetAllConditions then
        begin
          b := false;
          break;
        end;
      end;
  end;
  result := b;
end;

procedure TElRule.Process(CurrentTime : TDateTime);
var
  b: Boolean;
  I: Integer;
  ACondition: TElRuleCondition;
begin
  b := false;
  for i := 0 to Conditions.Count - 1 do
  begin
    ACondition := Conditions[i];
    //if ACondition.Enabled then
      if ACondition.IsInEffect(CurrentTime) xor ACondition.Inverted then
      begin
        if not MeetAllConditions then
        begin
          b := true;
          break;
        end;
      end else
      begin
        if MeetAllConditions then
        begin
          b := false;
          break;
        end;
      end;
  end;
  if b then
    for i := 0 to FActions.Count - 1 do
    begin
      if not Actions[i].Perform(CurrentTime) then break;
    end
  else
    exit;
  for i := 0 to Conditions.Count - 1 do
  begin
    ACondition := Conditions[i];
    ACondition.ActionPerformed(CurrentTime);
  end;
  if OneTime then Enabled := false;
end;

procedure TElRule.SetActions(Value: TElRuleActions);
begin
  FActions.Assign(Value);
end;

procedure TElRule.SetConditions(Value: TElRuleConditions);
begin
  FConditions.Assign(Value);
end;

{:
}
{
********************************* TElRulePart **********************************
}
procedure TElRulePart.AfterLoad(IniFile : TElIniFile; KeyName : string);
var
  S: String;
begin
  inherited AfterLoad(IniFile, KeyName);
  if IniFile.ReadString(KeyName, 'RulePartDetails', '', S) then
     ParseDetailsString;
end;

procedure TElRulePart.Assign(Source : TPersistent);
begin
  if Source is TElRulePart then
  begin
    Details := TElRulePart(Source).Details;
  end else
    inherited;
end;

procedure TElRulePart.BeforeSave(IniFile : TElIniFile; KeyName : string);
begin
  inherited BeforeSave(IniFile, KeyName);
  CreateDetailsString;
  IniFile.WriteString(KeyName, 'RulePartDetails', FDetails);
end;

procedure TElRulePart.CreateDetailsString;
begin
end;

procedure TElRulePart.ParseDetailsString;
begin
end;

initialization
end.
