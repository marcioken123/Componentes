unit LMDVldBase;
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

LMDVldBase unit (RS)
--------------------

Base classes and interfaces for validation components pack

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, Dialogs,
  LMDTypes, LMDCustomComponent;

type
  //TLMDErrorLevel = (elError, elWarning, elHint, elNone);
  TLMDErrorLevel = integer;
  TLMDValueType = (vtNumber, vtString, vtDate);
  TLMDRefSign = (rsEqual, rsGreater, rsLess);
  TLMDValidatedListValue = (vlvText, vlvIndex);

  TLMDValidationErrorEvent = procedure(Sender: TObject; ErrorLevel:
    TLMDErrorLevel) of object;

  TLMDValidationEntity = class;

  {$hints off}
  ILMDValidatedControl = interface
    ['{ED0CAB4C-DBF2-4078-8C06-000841566690}']
    procedure SetValidationMsgString(val: TLMDString);
    function GetValidationMsgString: TLMDString;
    function GetControl: TControl;
    function GetControlBackBrush: TBrush;
    function GetControlFont: TFont;
    function GetValueToValidate: TLMDString;
    function SupportsDefaultIndication: boolean;
    property ControlFont: TFont read GetControlFont;
    property ControlBackBrush: TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    function GetValidator: TLMDValidationEntity;
    procedure SetValidator(Validator: TLMDValidationEntity);
    property ValidationMsgString: TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Control: TControl read GetControl;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
  end;
  {$hints on}

  ILMDValidatingMsgControl = interface
    ['{F85159D2-2952-4FAB-B795-D772368DEBC4}']
    procedure SetErrorMessage(val: TLMDString; errorLevel: integer);
    function GetLastErrorMessage: TLMDString;
  end;

  TLMDCustomValidator = class;
  TLMDValidators = class;
  TLMDCustomValidationGroup = class;
  TLMDCustomErrorProvider = class;

  TLMDValidatorItem = class(TCollectionItem)
  private
    procedure SetValidator(const Value: TLMDValidationEntity);
  protected
    FValidator: TLMDValidationEntity;
    FTag: Integer;
  published
    property Validator: TLMDValidationEntity read FValidator write SetValidator;
    property Tag: Integer read FTag write FTag;
  end;

  TLMDValidators = class(TCollection)
  private
    function GetItem(Index: Integer): TLMDValidatorItem;
    procedure SetItem(Index: Integer; const Value: TLMDValidatorItem);
  protected
    FOwnerComponent: TComponent;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AComponent: TComponent);
    function Add: TLMDValidatorItem;
    property Items[Index: Integer]: TLMDValidatorItem read GetItem write
      SetItem; default;
  end;

  TLMDErrorProviderItem = class(TCollectionItem)
  protected
    FErrorProvider: TLMDCustomErrorProvider;
    procedure SetErrorProvider(const Value: TLMDCustomErrorProvider);
  public
    constructor Create(Collection: TCollection); override;
  published
    property ErrorProvider: TLMDCustomErrorProvider read FErrorProvider write SetErrorProvider;
  end;

  TLMDErrorProviders = class(TCollection)
  protected
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDErrorProviderItem;
    procedure SetItem(Index: Integer; const Value: TLMDErrorProviderItem);
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner: TComponent);
    function Add: TLMDErrorProviderItem;
    property Items[Index: Integer]: TLMDErrorProviderItem read GetItem write SetItem; default;
    function GetByProviderName(name: string): TLMDErrorProviderItem;
  end;

  TLMDValidatedControls = class;
  TLMDValidatedControlItem = class(TCollectionItem)
  protected
    FControl: ILMDValidatedControl;
    procedure SetControl(const Value: ILMDValidatedControl);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Control: ILMDValidatedControl read FControl write SetControl;
  end;

  TLMDValidatedControls = class(TCollection)
  private
    FValidationGroup: TLMDCustomValidationGroup;
    function GetItem(Index: Integer): TLMDValidatedControlItem;
    procedure SetItem(Index: Integer; const Value: TLMDValidatedControlItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Group: TLMDCustomValidationGroup);
    function Add: TLMDValidatedControlItem;
    property Items[Index: Integer]: TLMDValidatedControlItem read GetItem write SetItem; default;
    property ValidationGroup: TLMDCustomValidationGroup read FValidationGroup;
  end;

  TLMDCustomErrorProvider = class(TLMDCustomComponent)
  private
    FMaxErrorLevel: integer;
    FMinErrorLevel: integer;
    FActive: boolean;
  protected
    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); virtual;
  published
    property About;
    property MinErrorLevel: integer read FMinErrorLevel write FMinErrorLevel default 0;
    property MaxErrorLevel: integer read FMaxErrorLevel write FMaxErrorLevel default 100;
    property Active: boolean read FActive write FActive default true;
  end;

  TLMDValidationEntity = class(TLMDCustomComponent)
  private
    FErrorLevel: integer;
    FActive: boolean;
  protected
    property ErrorLevel: integer read FErrorLevel write FErrorLevel default 1;
    property Active: boolean read FActive write FActive default true;
  public
    constructor Create(AComponent: TComponent); override;
    function Validate(Sender: ILMDValidatedControl): TLMDErrorLevel; overload;
    function Validate(Sender: ILMDValidatedControl; doIndication: boolean): TLMDErrorLevel; overload; virtual; abstract;
//    procedure AcceptControl(Control: ILMDValidatedControl); virtual;
//    procedure ReleaseControl(Control: ILMDValidatedControl); virtual;
    function GetMessage(Sender: ILMDValidatedControl; errorLevel: TLMDErrorLevel): string; virtual; abstract;
  published
    property About;
  end;

  TLMDCustomValidator = class(TLMDValidationEntity)
  private
    FErrorMessage: string;
    FControl: ILMDValidatedControl;
    FErrorProvider: TLMDCustomErrorProvider;
    FValidateOnFocus: Boolean;
    FValidateOnLostFocus: Boolean;
    procedure SetErrorProvider(const Value: TLMDCustomErrorProvider);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function PerformValidation(value: string): TLMDErrorLevel; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    function Validate(Sender: ILMDValidatedControl; doIndication: boolean): TLMDErrorLevel; override;
    function GetMessage(Sender: ILMDValidatedControl; errorLevel: TLMDErrorLevel): string; override;
    property Control: ILMDValidatedControl read FControl;
  published
    property ValidateOnFocus: Boolean read FValidateOnFocus write FValidateOnFocus;
    property ValidateOnLostFocus: Boolean read FValidateOnLostFocus write FValidateOnLostFocus;
    property ErrorProvider: TLMDCustomErrorProvider read FErrorProvider write SetErrorProvider;
    property ErrorMessage: string read FErrorMessage write FErrorMessage;
    property ErrorLevel;
    property Active;
  end;

  TLMDCustomValidationGroup = class(TLMDValidationEntity)
  private
    FFirstErrorOnly: Boolean;
    FValidators: TLMDValidators;
//    FControls: TInterfaceList;
    FErrorProviders: TLMDErrorProviders;
    procedure SetValidators(const Value: TLMDValidators);
    procedure SetErrorProviders(const Value: TLMDErrorProviders);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property Validators: TLMDValidators read FValidators write SetValidators;
    property ErrorProviders: TLMDErrorProviders read FErrorProviders write SetErrorProviders;
    property FirstErrorOnly: Boolean read FFirstErrorOnly write FFirstErrorOnly default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
//    procedure AcceptControl(Control: ILMDValidatedControl); override;
//    procedure ReleaseControl(Control: ILMDValidatedControl); override;
    function Validate(Sender: ILMDValidatedControl; doIndication: boolean): TLMDErrorLevel; override;
    function GetMessage(Sender: ILMDValidatedControl; errorLevel: TLMDErrorLevel): string; override;
  end;

  TLMDValidationGroup = class(TLMDCustomValidationGroup)
  published
    property Validators;
    property ErrorProviders;
    property FirstErrorOnly;
    property Active;
  end;

  TLMDTypedValidator = class(TLMDCustomValidator)
  public

  end;

  TLMDCustomRangeValidator = class(TLMDTypedValidator)

  end;

function ValidatorItemsCompare(Item1, Item2: Pointer): integer;

implementation

{****************** Object TLMDRequiredFieldValidator *************************}
{------------------------- Private --------------------------------------------}
procedure TLMDValidatorItem.SetValidator(const Value: TLMDValidationEntity);
begin
  if Assigned(Self.FValidator) then
    Self.FValidator.RemoveFreeNotification(TLMDValidators(Self.Collection).FOwnerComponent);
  Self.FValidator := Value;
  if Assigned(Self.FValidator) then
    Self.FValidator.FreeNotification(TLMDValidators(Self.Collection).FOwnerComponent);
end;

{****************** Object TLMDValidators *************************************}
{------------------------- Private --------------------------------------------}
function TLMDValidators.GetItem(Index: Integer): TLMDValidatorItem;
begin
  Result := TLMDValidatorItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDValidators.SetItem(Index: Integer; const Value: TLMDValidatorItem);
begin
  inherited SetItem(Index, Value);
end;

{------------------------- Protected ------------------------------------------}
function TLMDValidators.GetOwner: TPersistent;
begin
  Result := Self.FOwnerComponent;
end;

{------------------------------------------------------------------------------}
procedure TLMDValidators.Update(Item: TCollectionItem);
begin
  inherited;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDValidators.Create(AComponent: TComponent);
begin
  inherited Create(TLMDValidatorItem);
  Self.FOwnerComponent := AComponent;
end;

{------------------------------------------------------------------------------}
function TLMDValidators.Add: TLMDValidatorItem;
begin
  Result := TLMDValidatorItem(inherited Add);
end;

{****************** Object TLMDErrorProviderItem ******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDErrorProviderItem.SetErrorProvider(
  const Value: TLMDCustomErrorProvider);
begin
  if Assigned(Self.FErrorProvider) then
    Self.FErrorProvider.RemoveFreeNotification(TLMDErrorProviders(Self.Collection).FOwner);
  Self.FErrorProvider := Value;
  if Assigned(Self.FErrorProvider) then
    Self.FErrorProvider.FreeNotification(TLMDErrorProviders(Self.Collection).FOwner);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDErrorProviderItem.Create(Collection: TCollection);
begin
  inherited;
end;

{****************** Object TLMDErrorProviders *********************************}
{------------------------- Protected ------------------------------------------}
function TLMDErrorProviders.GetItem(Index: Integer): TLMDErrorProviderItem;
begin
  Result := TLMDErrorProviderItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDErrorProviders.SetItem(Index: Integer;
  const Value: TLMDErrorProviderItem);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}
function TLMDErrorProviders.GetOwner: TPersistent;
begin
  Result := Self.FOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDErrorProviders.Update(Item: TCollectionItem);
begin
  inherited;

end;

{------------------------- Public ---------------------------------------------}
constructor TLMDErrorProviders.Create(Owner: TComponent);
begin
  inherited Create(TLMDErrorProviderItem);
  Self.FOwner := Owner;
end;

{------------------------------------------------------------------------------}
function TLMDErrorProviders.Add: TLMDErrorProviderItem;
begin
  Result := TLMDErrorProviderItem(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDErrorProviders.GetByProviderName(name: string): TLMDErrorProviderItem;
var
  i: integer;
  found: boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < Self.Count) do
    begin
      found := Self[i].ErrorProvider.Name = name;
      if not found then
        Inc(i);
    end;
  if found then
    Result := Self[i]
  else
    Result := nil;
end;

{****************** Object TLMDValidatedControlItem ***************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDValidatedControlItem.SetControl(const Value: ILMDValidatedControl);
begin
  FControl := Value;
  if (Assigned(Self.FControl)) then
    begin
      if Self.GetOwner <> nil then
        begin
          Self.FControl.SetValidator(TLMDValidatedControls(Self.GetOwner).ValidationGroup);
        end
      else
        Self.FControl.SetValidator(nil);
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDValidatedControlItem.Create(Collection: TCollection);
begin
  inherited;

end;

{------------------------------------------------------------------------------}
destructor TLMDValidatedControlItem.Destroy;
begin

  inherited;
end;

{****************** Object TLMDValidatedControls ******************************}
{------------------------- Private --------------------------------------------}
function TLMDValidatedControls.GetItem(Index: Integer): TLMDValidatedControlItem;
begin
  Result := TLMDValidatedControlItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDValidatedControls.SetItem(Index: Integer; const Value: TLMDValidatedControlItem);
begin
  inherited SetItem(Index, Value);

end;

{------------------------- Protected ------------------------------------------}
function TLMDValidatedControls.GetOwner: TPersistent;
begin
  Result := Self.FValidationGroup;
end;

{------------------------------------------------------------------------------}
procedure TLMDValidatedControls.Update(Item: TCollectionItem);
begin
  inherited;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDValidatedControls.Create(Group: TLMDCustomValidationGroup);
begin
  inherited Create(TLMDValidatedControlItem);
  Self.FValidationGroup := Group;
end;

{------------------------------------------------------------------------------}
function TLMDValidatedControls.Add: TLMDValidatedControlItem;
begin
  Result := TLMDValidatedControlItem(inherited Add);
end;

{****************** Object TLMDCustomErrorProvider ****************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDCustomErrorProvider.Create(AOwner: TComponent);
begin
  inherited;
  Self.MaxErrorLevel := 100;
  Self.Active := true;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomErrorProvider.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomErrorProvider.DisplayError(
  control: ILMDValidatedControl; ErrorMsg: string;
  ErrorLevel: TLMDErrorLevel);
begin
  if Self.Active then
    Self.DoDisplayError(control, ErrorMsg, ErrorLevel);
end;

{****************** Object TLMDValidationEntity *******************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDValidationEntity.Create(AComponent: TComponent);
begin
  inherited;
  Self.ErrorLevel := 1;
  Self.Active := true;
end;

{------------------------------------------------------------------------------}
{procedure TLMDValidationEntity.AcceptControl(Control: ILMDValidatedControl);
begin

end;

{------------------------------------------------------------------------------}
{procedure TLMDValidationEntity.ReleaseControl(Control: ILMDValidatedControl);
begin

end;

{------------------------------------------------------------------------------}
function TLMDValidationEntity.Validate(Sender: ILMDValidatedControl): TLMDErrorLevel;
begin
  Result := Self.Validate(Sender, true);
end;

{****************** Object TLMDValidationEntity *******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDCustomValidator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (Operation = opRemove) then
    Exit;
  if Assigned(Self.FControl) and AComponent.IsImplementorOf(Self.FControl) then
    Self.FControl := nil;
  if (Operation = opRemove) then
    begin
      if (AComponent = Self.ErrorProvider) then
        Self.FErrorProvider := nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomValidator.SetErrorProvider(const Value: TLMDCustomErrorProvider);
begin
  FErrorProvider := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{------------------------- Public --------------------------------------------}
constructor TLMDCustomValidator.Create(AOwner: TComponent);
begin
  inherited;
  Self.ErrorLevel := 1;
end;

{------------------------------------------------------------------------------}
function TLMDCustomValidator.Validate(Sender: ILMDValidatedControl; doIndication: boolean): TLMDErrorLevel;
var
  ErrorMsg: string;
begin
  Result := 0;
  if Self.FActive then
  begin
    Result := Self.PerformValidation(Sender.GetValueToValidate);
    ErrorMsg := Self.GetMessage(Sender, Result);
    if (Self.ErrorProvider <> nil) and doIndication then
      Self.ErrorProvider.DisplayError(Sender, ErrorMsg, Result);
    if Result > 0 then
      Sender.RespondToError(Result);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomValidator.GetMessage(Sender: ILMDValidatedControl;
                                        errorLevel: TLMDErrorLevel): string;
begin
  if errorLevel > 0 then
    Result := StringReplace(Self.ErrorMessage, '%F', Sender.ValidationMsgString,
      [rfReplaceAll, rfIgnoreCase])
  else
    Result := '';
end;

{****************** Object TLMDValidationEntity *******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDCustomValidationGroup.SetValidators(const Value: TLMDValidators);
begin
  FValidators.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomValidationGroup.SetErrorProviders(const Value: TLMDErrorProviders);
begin
  FErrorProviders.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomValidationGroup.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: integer;
  found: boolean;
begin
  inherited;

  if not (Operation = opRemove) then
    Exit;

  if Assigned(FErrorProviders) then
    begin
      i := 0;
      found := false;
      while (i < FErrorProviders.Count) and (not found) do
        begin
          found := FErrorProviders[i].ErrorProvider = AComponent;
          if not found then
            Inc(i);
        end;
      if found then
        begin
          FErrorProviders.Delete(i);
          Exit;
        end;
    end;

  if Assigned(FValidators) then
    begin
      i := 0;
      found := false;
      while (i < Self.Validators.Count) and (not found) do
        begin
          found := FValidators[i].Validator = AComponent;
          if not found then
            Inc(i);
        end;
      if found then
        FValidators.Delete(i);
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomValidationGroup.Create(AOwner: TComponent);
begin
  inherited;
  FValidators := TLMDValidators.Create(Self);
  FErrorProviders := TLMDErrorProviders.Create(Self);
  // code removed, because it has no functionality, either (RM)
  //  FControls := TInterfaceList.Create;
  FFirstErrorOnly := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomValidationGroup.Destroy;
begin
  inherited; //Notification should be called before FValidators and FErrorProviders are freed //VB Oct 2009
  if Assigned(FValidators) then
    FValidators.Clear;
  FreeAndNil(FValidators);

  if Assigned(FErrorProviders) then
    FErrorProviders.Clear;
  FreeAndNil(FErrorProviders);
end;

{------------------------------------------------------------------------------}
function TLMDCustomValidationGroup.Validate(Sender: ILMDValidatedControl;
                                            doIndication: boolean): TLMDErrorLevel;
var
  i, e: integer;
  strCurMessage: string;
  elCurResult, elMaxResult: TLMDErrorLevel;
  errorMessages: TStringList;
  curProvider: TLMDCustomErrorProvider;
  errorFound: Boolean;
  vldList: TList;
  curValidator: TLMDValidationEntity;

  function GetPrivoder(level: TLMDErrorLevel): TLMDCustomErrorProvider;
  var
    p: integer;
    found: boolean;
  begin
    p := 0;
    found := false;
    while (not found) and (p < Self.FErrorProviders.Count) do
      begin
        found := (Self.FErrorProviders[p].ErrorProvider.MinErrorLevel <= level) and
                 (Self.FErrorProviders[p].ErrorProvider.MaxErrorLevel >= level);
        if not found then
          Inc(p);
      end;
    if found then
      Result := Self.FErrorProviders[p].ErrorProvider
    else
      Result := nil;
  end;

begin
  vldList := TList.Create;
  for i := 0 to Self.Validators.Count - 1 do
    vldList.Add(Self.Validators[i]);
  vldList.Sort(ValidatorItemsCompare);

  errorMessages := TStringList.Create;
  i := 0;
  errorFound := false;
  elMaxResult := 0;
  while (i < Self.Validators.Count) and
        (not (Self.FFirstErrorOnly and errorFound)) do
    begin
      strCurMessage := '';
      curValidator := Self.Validators[i].Validator;
      elCurResult := curValidator.Validate(Sender, false);
      if elCurResult > elMaxResult then
        elMaxResult := elCurResult;
      if elCurResult > 0 then
        begin
          strCurMessage := curValidator.GetMessage(Sender, elCurResult);
          for e := 0 to Self.FErrorProviders.Count - 1 do
            begin
              //curProvider := GetPrivoder(elCurResult);
              curProvider := Self.FErrorProviders[e].ErrorProvider;
              //if Assigned(curProvider) then
              if (curProvider.MinErrorLevel <= elCurResult) and
                 (curProvider.MaxErrorLevel >= elCurResult) then
                begin
                  if errorMessages.IndexOfName(curProvider.Name) = -1 then
                    errorMessages.Add(curProvider.Name + '=' + strCurMessage)
                  else
                    errorMessages.Values[curProvider.Name] :=
                      errorMessages.Values[curProvider.Name]
                      + ' ' + strCurMessage;
                end;
            end;
          errorFound := true;
        end;
      Inc(i);
    end;

  if doIndication then
    for i := 0 to Self.ErrorProviders.Count - 1 do
      begin
        curProvider := Self.ErrorProviders[i].ErrorProvider;
        if errorMessages.IndexOfName(curProvider.Name) <> -1 then
          curProvider.DisplayError(Sender, errorMessages.Values[curProvider.Name],
            curProvider.MaxErrorLevel)
        else
          curProvider.DisplayError(Sender, '', 0)
      end;

  errorMessages.Free;
  vldList.Free;
  Result := elMaxResult;
end;

{------------------------------------------------------------------------------}
function TLMDCustomValidationGroup.GetMessage(Sender: ILMDValidatedControl;
  errorLevel: TLMDErrorLevel): string;
var
  strCurMessage: string;
  i: integer;
begin
  for i := 0 to Self.Validators.Count - 1 do
    begin
      strCurMessage := Self.Validators.Items[i].Validator.GetMessage(Sender,
        errorLevel);
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + strCurMessage;
    end;
end;

{****************** Non-member functions **************************************}

function ValidatorItemsCompare(Item1, Item2: Pointer): integer;

var
  vi1, vi2: TLMDValidatorItem;
begin
  Result := 0;
  try
    if Assigned(Item1) and Assigned(Item2) then
      begin
        vi1 := TLMDValidatorItem(Item1);
        vi2 := TLMDValidatorItem(Item2);
        if Assigned(vi1.Validator) and Assigned(vi2.Validator) then
          begin
            if vi1.Validator.ErrorLevel > vi2.Validator.ErrorLevel then
              Result := 1;
            if vi1.Validator.ErrorLevel < vi2.Validator.ErrorLevel then
              Result := -1;
          end;
      end;
  except
  end;
end;

end.
