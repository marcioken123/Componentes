unit LMDPluginImpl;
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

LMDPluginImpl unit (AIH, AH)
----------------------------
Description
LMD Plugin Framework:
Plugin helpers
(TLMDPlugin, TLMDAction, TLMDParameter, TLMDPluginForn, TLMDParameterEnum)

ToDo
----

Changes
-------

Release 0.2 (February 2008)
* Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, Controls, Types, LMDTypes, LMDPluginManager, LMDCustomComponent;

type
  TLMDAction = class;

  { ************************** TLMDPluginComponent *************************** }
  TLMDPluginComponent = class(TLMDCustomComponent)
  public
    function getLMDPackage: TLMDPackageID; override;
  published
    property About;
  end;

  { *************************** TLMDCustomPlugin ***************************** }
  TLMDCustomPlugin = class(TInterfacedObject, ILMDPlugin)
  protected
    FHandle: HMODULE;
    FAuthor: WideString;
    FDescription: WideString;
    FMajorVersion: Integer;
    FMinorVersion: Integer;
    FFileName: string;
    FHost: ILMDHost;
    FOnSetHost: TLMDSetHostEvent;
    FActions: TInterfaceList;
    FForms: TInterfaceList;
    FIdentifiers: TList;
    FEventInterface: ILMDPluginEvent;
    function GetNamedAction(const AName: WideString): ILMDAction; stdcall;
    function GetNamedForm(const AName: WideString): ILMDPluginForm; stdcall;
    function GetPluginForm(AFormName: WideString; out APluginForm: ILMDPluginForm): HRESULT; stdcall;
    function GetIdentifierCount(): Integer; stdcall;
    function GetIdentifier(ANum: Integer): TGUID; stdcall;
  public
    constructor Create;
    destructor Destroy; override;
    function GetHandle: THandle; stdcall;
    procedure SetHandle(AHandle: THandle); stdcall;
    function GetAuthor: WideString; stdcall;
    function GetDescription: WideString; stdcall;
    function GetMajorVersion: Integer; stdcall;
    function GetMinorVersion: Integer; stdcall;
    function GetFileName: WideString; stdcall;
    function GetHost(out AHost: ILMDHost): HRESULT; stdcall;
    procedure SetFileName(AFileName: WideString); stdcall;
    function SetHost(AHost: ILMDHost): HRESULT; stdcall;
    function GetAction(const AName: WideString; out AnAction: ILMDAction): HRESULT; stdcall;
    function SetOnSetHostEvent(AnEvent: TLMDSetHostEvent): HRESULT; stdcall;
    function AddAction(const AName: WideString): TLMDAction;
    procedure EventCallback(AEventInterface: ILMDPluginEvent); stdcall;
    function GetEventCallback(): ILMDPluginEvent; stdcall;
    procedure AddForm(const AForm: ILMDPluginForm); stdcall;
    procedure AddIdentifier(const AIdentifier: TGUID); stdcall;
    property Author: WideString read GetAuthor;
    property FileName: WideString read GetFileName write SetFileName;
    property Actions[const AName: WideString]: ILMDAction read GetNamedAction;
    property IdentifierCount: Integer read GetIdentifierCount;
    property Identifiers[AIndex: Integer]: TGUID read GetIdentifier;
  end;

  { ******************************** TLMDPlugin ****************************** }
  TLMDPlugin = class (TLMDCustomPlugin)
  public
    constructor Create(const AAuthor, ADescription: WideString; const AMajorVersion, AMinorVersion: Integer);
  end;

  { *************************** TLMDParametersEnum *************************** }
  TLMDParametersEnum = class (TInterfacedObject, ILMDParametersEnum)
  private
    FCount: Integer;
    FTail: Integer;
    FParams: TInterfaceList;
    FPosition: Integer;
  public
    constructor Create(ACount: Integer);
    destructor Destroy(); override;
    procedure Add(const AParam: ILMDParameter);
    function Reset(): HRESULT; stdcall;
    function Skip(ACount: Integer): HRESULT; stdcall;
    function Next(out AParam: ILMDParameter; out AFetched: boolean): HRESULT; stdcall;
    function Clone(out AClone: ILMDParametersEnum): HRESULT; stdcall;
    function Count: Integer; stdcall;
  end;

  { ***************************** TLMDParameter ****************************** }
  TLMDParameter = class(TInterfacedObject, ILMDParameter)
  protected
    FValue: Pointer;
    FType: TLMDParameterType;
    FIsOptional: Boolean;
    FName: TLMDString;
    procedure SetAsBoolean(const AValue: Boolean); stdcall;
    procedure SetAsInteger(const AValue: Integer); stdcall;
    procedure SetAsReal(const AValue: Extended); stdcall;
    procedure SetAsString(const AValue: WideString); stdcall;
    procedure SetAsCurrency(const AValue: Currency); stdcall;
    procedure SetAsSmallInt(const AValue: Smallint); stdcall;
    procedure SetAsWord(const AValue: Word); stdcall;
    procedure SetAsLongWord(const AValue: LongWord); stdcall;
    procedure SetAsInt64(const AValue: Int64); stdcall;
    procedure SetAsObject(const AValue: TObject); stdcall;
    procedure SetAsPointer(const AValue: Pointer); stdcall;
    function GetAsBoolean: Boolean; stdcall;
    function GetAsInteger: Integer; stdcall;
    function GetAsReal: Extended; stdcall;
    function GetAsString: WideString; stdcall;
    function GetAsCurrency: Currency; stdcall;
    function GetAsSmallInt: Smallint; stdcall;
    function GetAsWord: Word; stdcall;
    function GetAsLongWord: LongWord; stdcall;
    function GetAsInt64: Int64; stdcall;
    function GetAsObject: TObject; stdcall;
    function GetAsPointer: Pointer; stdcall;
    function GetAsByteDynArray: TByteDynArray; stdcall;
    procedure SetAsByteDynArray(const AValue: TByteDynArray); stdcall;
    procedure SetAsIntegerDynArray(const AValue: TIntegerDynArray); stdcall;
    procedure SetAsWordDynArray(const AValue: TWordDynArray); stdcall;
    procedure SetAsInt64DynArray(const AValue: TInt64DynArray); stdcall;
    procedure SetAsWideStringDynArray(const AValue: TWideStringDynArray); stdcall;
    procedure SetAsLongWordDynArray(const AValue: TLongWordDynArray); stdcall;
    procedure SetAsDoubleDynArray(const AValue: TDoubleDynArray); stdcall;
    procedure SetAsBooleanDynArray(const AValue: TBooleanDynArray); stdcall;
    function GetAsIntegerDynArray: TIntegerDynArray; stdcall;
    function GetAsWordDynArray: TWordDynArray; stdcall;
    function GetAsInt64DynArray: TInt64DynArray; stdcall;
    function GetAsWideStringDynArray: TWideStringDynArray; stdcall;
    function GetAsLongWordDynArray: TLongWordDynArray; stdcall;
    function GetAsDoubleDynArray: TDoubleDynArray; stdcall;
    function GetAsBooleanDynArray: TBooleanDynArray; stdcall;
    procedure SetType(const AType: TLMDParameterType); stdcall;
    function GetType: TLMDParameterType; stdcall;
    function GetIsOptional: boolean; stdcall;
    procedure SetIsOptional(const AIsOptional: boolean); stdcall;
    function GetName: TLMDString; stdcall;
    function GetAsGUID: TGUID; stdcall;
    procedure SetAsGUID(const Value: TGUID); stdcall;
  public
    constructor Create; overload;
    constructor Create(const AName: WideString); overload;
    destructor Destroy; override;
    function GetValue(out APointer: Pointer): HRESULT; stdcall;
    function SetValue(const APointer: Pointer): HRESULT; stdcall;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsReal: Extended read GetAsReal write SetAsReal;
    property AsString: WideString read GetAsString write SetAsString;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsSmallInt: Smallint read GetAsSmallInt write SetAsSmallInt;
    property AsWord: Word read GetAsWord write SetAsWord;
    property AsLongWord: LongWord read GetAsLongWord write SetAsLongWord;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsPointer: Pointer read GetAsPointer write SetAsPointer;
    property AsByteDynArray: TByteDynArray read GetAsByteDynArray write SetAsByteDynArray;
    property AsIntegerDynArray: TIntegerDynArray read GetAsIntegerDynArray write SetAsIntegerDynArray;
    property AsWordDynArray: TWordDynArray read GetAsWordDynArray write SetAsWordDynArray;
    property AsInt64DynArray: TInt64DynArray read GetAsInt64DynArray write SetAsInt64DynArray;
    property AsWideStringDynArray: TWideStringDynArray read GetAsWideStringDynArray write SetAsWideStringDynArray;
    property AsLongWordDynArray: TLongWordDynArray read GetAsLongWordDynArray write SetAsLongWordDynArray;
    property AsDoubleDynArray: TDoubleDynArray read GetAsDoubleDynArray write SetAsDoubleDynArray;
    property AsBooleanDynArray: TBooleanDynArray read GetAsBooleanDynArray write SetAsBooleanDynArray;
    property AsGUID: TGUID read GetAsGUID write SetAsGUID;
    property ParameterType: TLMDParameterType read GetType write SetType;
    property Name: TLMDString read GetName;
    property IsOptional: Boolean read GetIsOptional write SetIsOptional;
  end;

  { ******************************* ILMDAction ******************************* }
  TLMDAction = class (TInterfacedObject, ILMDAction)
  protected
    FName: WideString;
    FParameters: TInterfaceList;
    FParamCount: Integer;
    FResult: ILMDParameter;
    FOnPerformAction: TLMDPerformActionEvent;
    function GetParameter(AIndex: Integer): ILMDParameter; stdcall;
    procedure SetParameter(AIndex: Integer; const AParameter: ILMDParameter); stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(const AName: WideString);
    destructor Destroy; override;

    function PerformAction: ILMDParameter; virtual; stdcall;
    function GetParametersEnum(var AParamEnum: ILMDParametersEnum): HRESULT; stdcall;
    function IsParametersCorrect: HRESULT; stdcall;

    function AddParameter: TLMDParameter; overload;
    function AddParameter(const AName: WideString): TLMDParameter; overload;

    function GetParameterByName(AName: WideString): ILMDParameter; stdcall;

    property Name: WideString read GetName;
    property Parameters[Index: Integer]: ILMDParameter read GetParameter write SetParameter; default;
    property ParametersByName[Index: WideString]: ILMDParameter read GetParameterByName;
    property ParamCount: Integer read FParamCount;
    property OnPerformAction: TLMDPerformActionEvent read FOnPerformAction write FOnPerformAction;
  end;

  { ***************************** TLMDPluginForm ***************************** }
  TLMDPluginForm = class(TInterfacedObject, ILMDPluginForm)
  private
    FForm: TForm;
    FFormName: WideString;
    function GetTitle: WideString; stdcall;
    procedure SetTitle(ATitle: WideString); stdcall;
    function GetVisible: boolean; stdcall;
    procedure SetVisible (AVisible: boolean); stdcall;
    function GetFormName: WideString; stdcall;
  public
    constructor Create(const AName: WideString; AForm: TFormClass);
    destructor Destroy(); override;
    procedure Show; virtual; stdcall;
    procedure Hide; virtual; stdcall;
    procedure ShowAsMDIChild(AParentForm: TForm); virtual; stdcall;
    procedure ShowModal; virtual; stdcall;
    procedure ShowParented(AParentWindow: HWND); virtual; stdcall;
    procedure SetFormData(AData: Pointer); virtual; stdcall;
    property FormName: WideString read GetFormName;
    property Title: WideString read GetTitle write SetTitle;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TLMDDelphiPluginForm = class(TLMDPluginForm, ILMDPluginForm, ILMDDelphiPluginForm)
    function GetTFormInstance: TForm; stdcall;
  end;

  TLMDPluginEvent = class(TInterfacedObject, ILMDPluginEvent)
  private
    FOnPerformEvent: TLMDPluginModuleOnPerformEvent;
  public
    constructor Create(AOnPerformEvent: TLMDPluginModuleOnPerformEvent);
    procedure PerformEvent(const AName: WideString; AData: Pointer); stdcall;
  end;

implementation

uses
  SysUtils, StdCtrls, LMDUnicode, LMDStrings, Math;

function TLMDPluginComponent.getLMDPackage;
begin
  Result := pi_LMD_PLUGIN; 
end;

{ ***************************** TLMDCustomPlugin ***************************** }
{--------------------------------- private ------------------------------------}
function TLMDCustomPlugin.GetIdentifierCount(): Integer;
begin
  Result := FIdentifiers.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetIdentifier(ANum: Integer): TGUID;
begin
  try
    Result := TGuid(FIdentifiers.Items[ANum]^);
  except
    Raise ERangeError.Create('Index is out of bounds');
  end;
end;

{-------------------------------- public --------------------------------------}
constructor TLMDCustomPlugin.Create();
begin
  inherited Create;
  FActions := TInterfaceList.Create;
  FActions.Clear;
  FForms := TInterfaceList.Create;
  FForms.Clear;
  FIdentifiers := TList.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPlugin.AddIdentifier(const AIdentifier: TGUID); stdcall;
var
  LGuid: PGUID;
begin
  GetMem(LGuid, SizeOf(TGuid));
  CopyMemory(LGuid, @AIdentifier, SizeOf(TGuid));
  FIdentifiers.Add(LGuid)
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPlugin.EventCallback(AEventInterface: ILMDPluginEvent);
begin
  FEventInterface := AEventInterface;
end;

function TLMDCustomPlugin.GetEventCallback(): ILMDPluginEvent;
begin
  Result := FEventInterface;  
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.AddAction(const AName: WideString): TLMDAction;
begin
  Result := TLMDAction.Create(AName);
  try
    FActions.Add(ILMDAction(Result))
  except
    Raise Exception.Create('Unknown exception');
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPlugin.AddForm(const AForm: ILMDPluginForm);
begin
  try
    FForms.Add(AForm);
  except
    Raise Exception.Create('Unknown exception');
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetPluginForm(AFormName: WideString; out APluginForm: ILMDPluginForm): HRESULT;
var
  i: Integer;
begin
  Result := S_OK;
  APluginForm := nil;
  for i := 0 to FForms.Count - 1 do
    if ILMDPluginForm(FForms.Items[i]).FormName = AFormName then
    begin
      APluginForm := ILMDPluginForm(FForms.Items[i]);
      Break;
    end;
  if APluginForm = nil then
    Raise ERangeError.Create('Wrong index');
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.SetHost(AHost: ILMDHost): HRESULT;
var
  LAccept: Boolean;
begin
  Result := S_OK;
  try
    LAccept := True;
    if Assigned(FOnSetHost) then
      FOnSetHost(Self, LAccept);
    if LAccept then
      FHost := AHost;
  except
    Result := E_UNEXPECTED;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetHandle: THandle;
begin
  Result := FHandle;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPlugin.SetHandle(AHandle: THandle);
begin
  FHandle := AHandle;
end;

{------------------------------------------------------------------------------}
function  TLMDCustomPlugin.GetAuthor: WideString;
begin
  Result := FAuthor;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetDescription: WideString;
begin
  Result := FDescription;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetMajorVersion: Integer;
begin
  Result := FMajorVersion;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetMinorVersion: Integer;
begin
  Result := FMinorVersion;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetNamedAction(const AName: WideString): ILMDAction;
begin
  GetAction(AName, Result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetNamedForm(const AName: WideString): ILMDPluginForm;
begin
  GetPluginForm(AName, Result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetFileName: WideString;
begin
  Result := FFileName;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetHost(out AHost: ILMDHost): HRESULT;
begin
  Result := S_OK;
  AHost := FHost;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPlugin.SetFileName(AFileName: WideString);
begin
  FFileName := AFileName;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.GetAction(const AName: WideString; out AnAction: ILMDAction): HRESULT;
var
  i: Integer;
begin
  Result := S_OK;
  try
    for i := 0 to FActions.Count - 1 do
      if LMDWideUpperCase(AName) = ILMDAction(FActions.Items[i]).Name then
      begin
        AnAction := ILMDAction(FActions.Items[i]);
        Result := S_OK;
        break;
      end;
  except
    Result := E_UNEXPECTED;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomPlugin.Destroy();
var
  i: Integer;
begin
  FActions.Clear;
//  FActions := nil;
  FActions.Free;
  FForms.Clear;
  FForms.Free;
  for i := 0 to FIdentifiers.Count - 1 do
    FreeMem(FIdentifiers.Items[i], SizeOf(TGuid));
  FIdentifiers.Clear;
  FIdentifiers.Free;
//  FForms := nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPlugin.SetOnSetHostEvent(AnEvent: TLMDSetHostEvent): HRESULT;
begin
  Result := S_OK;
  try
    FOnSetHost := AnEvent;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ *************************** TLMDParametersEnum ***************************** }
{ ------------------------------ public -------------------------------------- }
constructor TLMDParametersEnum.Create(ACount: Integer);
begin
  inherited Create;
  FParams := TInterfaceList.Create;
  FParams.Count := ACount;
  FPosition := 0;
  FCount := ACount;
end;

{------------------------------------------------------------------------------}
destructor TLMDParametersEnum.Destroy();
begin
  FParams.Clear;
  FreeAndNil(FParams);
end;

{------------------------------------------------------------------------------}
procedure TLMDParametersEnum.Add(const AParam: ILMDParameter);
begin
  if FTail < FParams.Count then
  begin
    FParams[FTail] := AParam;
    Inc(FTail);
 end
  else
    raise Exception.Create('You need to increase Count of Actions');
end;

{------------------------------------------------------------------------------}
function TLMDParametersEnum.Reset(): HRESULT; stdcall;
begin
  FPosition := 0;
  Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDParametersEnum.Skip(ACount: Integer): HRESULT; stdcall;
begin
  Result := S_OK;
  Inc(FPosition, ACount);
  if FPosition >= FCount  then
    Result := E_INVALIDARG;
end;

{------------------------------------------------------------------------------}
function TLMDParametersEnum.Next(out AParam: ILMDParameter; out AFetched: boolean): HRESULT; stdcall;
begin
  Result := S_OK;
  if FPosition < FCount then
  begin
    AParam := ILMDParameter(FParams[FPosition]);
    inc(FPosition);
    AFetched := True;
  end
  else
  begin
    AFetched := False;
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDParametersEnum.Clone(out AClone: ILMDParametersEnum): HRESULT; stdcall;
begin
  Result := S_OK;
  try
    AClone := TLMDParametersEnum.Create(FCount);
    with TLMDParametersEnum(AClone) do
    begin
      FCount := Self.FCount;
      FTail := Self.FTail;
      FParams := Self.FParams;
    end;
  except
    Result := E_UNEXPECTED;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDParametersEnum.Count: Integer; stdcall;
begin
  Result := FParams.Count;
end;

{ ******************************** TLMDAction ******************************** }
{----------------------------- private ----------------------------------------}
function TLMDAction.GetParameter(AIndex: Integer): ILMDParameter;
begin
  if AIndex > FParamCount - 1 then
    Raise ERangeError.Create('Index wrong');
  Result := ILMDParameter(FParameters[AIndex]);
end;

{------------------------------------------------------------------------------}
procedure TLMDAction.SetParameter(AIndex: Integer; const AParameter: ILMDParameter);
begin
  if AIndex > FParamCount - 1 then
    Raise ERangeError.Create('Index wrong');
  FParameters[AIndex] := AParameter;
end;

{------------------------------------------------------------------------------}
function TLMDAction.GetName: WideString; stdcall;
begin
  Result := FName;
end;

{-------------------------------- public -------------------------------------}
constructor TLMDAction.Create(const AName: WideString);
begin
  inherited Create;
  FName := LMDWideUpperCase(AName);
  FParamCount := 0;
  FParameters := TInterfaceList.Create;
  FParameters.Count := FParamCount;
  FResult := TLMDParameter.Create;
end;

{------------------------------------------------------------------------------}
function TLMDAction.PerformAction: ILMDParameter;
begin
  Result := nil;
  if Assigned(FOnPerformAction) then
  begin
    FOnPerformAction(Self, FResult);
    Result := FResult;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAction.GetParametersEnum(var AParamEnum: ILMDParametersEnum): HRESULT; stdcall;
var
  LEnum: TLMDParametersEnum;
  i: Integer;
begin
  Result := S_OK;
  try
    LEnum := TLMDParametersEnum.Create(FParamCount);
    for i := 0 to FParameters.Count - 1 do
      LEnum.Add(ILMDParameter(FParameters.Items[i]));
    AParamEnum := LEnum;
  except
    Result := E_UNEXPECTED;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAction.IsParametersCorrect: HRESULT; stdcall;
begin
  // TODO: make parameters validation
  // add your verification here
  Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDAction.AddParameter: TLMDParameter;
begin
  Result := AddParameter('');
end;

{------------------------------------------------------------------------------}
function TLMDAction.AddParameter(const AName: WideString): TLMDParameter stdcall;
begin
  Result := TLMDParameter.Create(AName);
  Inc(FParamCount);
  try
    FParameters.Add(ILMDParameter(Result));
  except
    raise Exception.Create('');
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDAction.Destroy;
begin
  FParameters.Clear;
  FParameters.Free;
  FResult := nil
end;

{------------------------------------------------------------------------------}
function TLMDAction.GetParameterByName(AName: WideString): ILMDParameter;
var
  i: Integer;
begin
  for i := 0 to FParamCount - 1 do
    if Parameters[i].Name = LMDWideUpperCase(AName) then
    begin
      Result := Parameters[i];
      exit;
    end;
  Result := nil;
end;

{ ******************************* TLMDParameter ****************************** }
{------------------------------- private --------------------------------------}
function TLMDParameter.GetName: TLMDString; stdcall;
begin
  Result := FName;
end;

{------------------------------------------------------------------------------}
function TLMDParameter.GetType: TLMDParameterType; stdcall;
begin
  Result := FType;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetType(const AType: TLMDParameterType); stdcall;
begin
  FType := AType;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetIsOptional: boolean; stdcall;
begin
  //insert yor checking here
  Result := FIsOptional;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetIsOptional(const AIsOptional: Boolean); stdcall;
begin
  //insert yor checking here
  FIsOptional := AIsOptional;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsBoolean(const AValue: Boolean);
var
  LPar: PSmallInt;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := SmallInt(AValue);
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsInteger(const AValue: Integer);
var
  LPar: PINT;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsReal(const AValue: Extended);
var
  LPar: PExtended;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsString(const AValue: WideString);
var
  LPar: PWideChar;
begin
  GetMem(LPar, (Length(AValue) + 1) * SizeOf(WideChar));
  FillChar(LPar, 0, (Length(AValue) + 1) * SizeOf(WideChar));
  LMDWideStrPCopy(LPar, AValue);
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsCurrency(const AValue: Currency);
var
  LPar: PCurrency;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsSmallInt(const AValue: Smallint);
var
  LPar: PSmallInt;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsWord(const AValue: Word);
var
  LPar: PWORD;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsLongWord(const AValue: LongWord);
var
  LPar: PLongWord;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsInt64(const AValue: Int64);
var
  LPar: PInt64;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := AValue;
  SetValue(LPar)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsObject(const AValue: TObject);
begin
  SetValue(AValue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsPointer(const AValue: Pointer);
begin
  SetValue(AValue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsByteDynArray(const AValue: TByteDynArray);
begin
  SetValue(AValue)
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsBoolean: Boolean;
begin
  Result := Boolean(PSmallInt(FValue)^);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsInteger: Integer;
begin
  Result := PINT(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsReal: Extended;
begin
  Result := PExtended(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsString: WideString;
begin
  Result := LMDWideStrPas(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsCurrency: Currency;
begin
  Result := PCurrency(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsSmallInt: Smallint;
begin
  Result := PSmallInt(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsWord: Word;
begin
  Result := PWord(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsLongWord: LongWord;
begin
  Result := PLongWord(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsInt64: Int64;
begin
  Result := PINT64(FValue)^;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsObject: TObject;
begin
  Result := TObject(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsPointer: Pointer;
begin
  Result := FValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsByteDynArray: TByteDynArray;
begin
  Result := TByteDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsIntegerDynArray(const AValue: TIntegerDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsWordDynArray(const AValue: TWordDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsInt64DynArray(const AValue: TInt64DynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsWideStringDynArray(const AValue: TWideStringDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsLongWordDynArray(const AValue: TLongWordDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsDoubleDynArray(const AValue: TDoubleDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsBooleanDynArray(const AValue: TBooleanDynArray);
begin
  SetValue(AValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsIntegerDynArray: TIntegerDynArray;
begin
  Result := TIntegerDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsWordDynArray: TWordDynArray;
begin
  Result := TWordDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsInt64DynArray: TInt64DynArray;
begin
  Result := TInt64DynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsWideStringDynArray: TWideStringDynArray;
begin
  Result := TWideStringDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsLongWordDynArray: TLongWordDynArray;
begin
  Result := TLongWordDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsDoubleDynArray: TDoubleDynArray;
begin
  Result := TDoubleDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetAsBooleanDynArray: TBooleanDynArray;
begin
  Result := TBooleanDynArray(FValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParameter.SetAsGUID(const Value: TGUID);
var
  LPar: PGUID;
begin
  GetMem(LPar, SizeOf(LPar^));
  LPar^ := Value;
  SetValue(LPar);
end;

{------------------------------------------------------------------------------}
function TLMDParameter.GetAsGUID: TGUID;
begin
  Result := PGUID(FValue)^;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDParameter.Create;
begin
  inherited Create;
  FValue := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDParameter.Create(const AName: WideString);
begin
  inherited Create;
  FName := LMDWideUpperCase(AName);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDParameter.Destroy;
begin
  if Assigned(FValue) then
  begin
    FreeMem(FValue);
    FValue := nil;
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.SetValue(const APointer: Pointer): HRESULT; stdcall;
begin
  if Assigned(FValue) then
  begin
    Dispose(FValue);
    FValue := nil
  end;
  FValue := APointer;
  Result := S_OK;
end;

{ ---------------------------------------------------------------------------- }
function TLMDParameter.GetValue(out APointer: Pointer): HRESULT; stdcall;
begin
  Result := S_OK;
  APointer := FValue;
end;

{ ****************************** TLMDPluginForm ****************************** }
{ ----------------------------- private -------------------------------------- }
function TLMDPluginForm.GetFormName: WideString; stdcall;
begin
  Result := FFormName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPluginForm.GetTitle: WideString; stdcall;
begin
  Result := '';
  if Assigned(FForm) then
    Result := FForm.Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.SetFormData(AData: Pointer);
var
  LForm: ILMDFormWithData;
begin
  if Assigned(FForm) then
    if Supports(FForm, ILMDFormWithData, LForm) then
      LForm.SetFormData(AData);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.SetTitle(ATitle: WideString); stdcall;
begin
  if Assigned(FForm) then
    FForm.Caption := ATitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPluginForm.GetVisible: boolean; stdcall;
begin
  Result := false;
  if Assigned(FForm) then
    Result := FForm.Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.SetVisible (AVisible: boolean); stdcall;
begin
  if Assigned(FForm) then
    FForm.Visible := AVisible;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDPluginForm.Create(const AName: WideString; AForm: TFormClass);
begin
  inherited Create;
  // Application.CreateForm(AForm, FForm);
  FForm := AForm.Create(nil);
  FFormName := AName;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPluginForm.Destroy();
begin
  if Visible then
    FForm.Hide;
  FreeAndNil(FForm);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.Hide; stdcall;
begin
  Visible := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.Show; stdcall;
begin
  Visible := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.ShowAsMDIChild(AParentForm: TForm); stdcall;
begin
  FForm.FormStyle := fsMDIChild;
  FForm.Show;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.ShowModal; stdcall;
begin
  if Assigned(FForm) then
    FForm.ShowModal;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginForm.ShowParented(AParentWindow: HWND); stdcall;
begin
  if Assigned(FForm) then
  begin
    FForm.ParentWindow := AParentWindow;
    FForm.Show;
  end
  else
    Raise EInvalidOp.Create('Nil form');
end;

{******************************* TLMDDelphiPlugin *****************************}
{ ---------------------------------------------------------------------------- }
function TLMDDelphiPluginForm.GetTFormInstance: TForm;
begin
  Result := FForm;
end;

{********************************** TLMDPlugin ********************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDPlugin.Create(const AAuthor, ADescription: WideString; const AMajorVersion,
  AMinorVersion: Integer);
begin
  inherited Create;
  FAuthor := AAuthor;
  FDescription := ADescription;
  FMajorVersion := AMajorVersion;
  FMinorVersion := AMinorVersion;
end;

{******************************* TLMDPluginEvent ******************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDPluginEvent.Create(AOnPerformEvent: TLMDPluginModuleOnPerformEvent);
begin
  FOnPerformEvent := AOnPerformEvent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPluginEvent.PerformEvent(const AName: WideString; AData: Pointer); stdcall;
begin
  if Assigned(FOnPerformEvent) then
    FOnPerformEvent(AName, AData); 
end;  

end.
