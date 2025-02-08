unit LMDPluginModule;
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

pLMDPluginModule unit (AIH)
----------------------------
Description
Expert for LMD Plugin Framework.
Visual projecting LMD Plugin as TDataModule descendant

ToDo
----

Changes
-------

Release 0.1 (July 2008)
* Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDTypes, LMDPluginManager, LMDPluginImpl, intfLMDBase;

type
  TLMDCustomPluginParameter = class(TCollectionItem)
  private
    FName: TLMDString;
    FParamType: TLMDParameterType;
    FIsOptional: Boolean;
  public
    property Name: TLMDString read FName write FName;
    property ParamType: TLMDParameterType read FParamType write FParamType;
    property IsOptional: Boolean read FIsOptional write FIsOptional;
  end;

  TLMDPluginParameter = class(TLMDCustomPluginParameter)
  published
    property Name;
    property ParamType;
    property IsOptional;
  end;
  TLMDPluginParameters = class(TOwnedCollection)

  end; 

  TLMDCustomPluginAction = class(TCollectionItem)
  private
    FName: TLMDString;
    FParameters: TLMDPluginParameters;
    FOnPerformAction: TLMDPerformActionEvent;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy(); override;
    property Name: TLMDString read FName write FName;
    property Parameters: TLMDPluginParameters read FParameters write FParameters;
    property OnPerformAction: TLMDPerformActionEvent read FOnPerformAction write FOnPerformAction;
  end;

  TLMDPluginAction = class(TLMDCustomPluginAction)
  published
    property Name;
    property Parameters;
    property OnPerformAction;
  end;

  TLMDPluginActions = class(TOwnedCollection)
  end;

  TLMDPluginForms = class(TOwnedCollection)

  end;

  TLMDCustomPluginForm = class(TCollectionItem)
  private
    FForm: TLMDPluginForm;
    FName: TLMDString;
  public
    property Form: TLMDPluginForm read FForm write FForm;
    property Name: TLMDString read FName write FName;  
  end;

  TLMDPluginForm = class(TLMDCustomPluginForm)
  published
    property Form;
    property Name;
  end;

  TLMDGuid = class(TCollectionItem)
  private
    FGuid: TGUID;
    function GetGuid(): String;
    procedure SetGuid(AValue: String);
  public
    constructor Create(Collection: TCollection); override; 
  published
    property Guid: string read GetGuid write SetGuid;
  end;
  TLMDGuids = class(TOwnedCollection)

  end;
    TLMDCustomPluginModule = class(TDataModule, ILMDComponent)
  private
    FAbout    : TLMDAboutVar;

    FAuthor: String;
    FMajorVersion: Word;
    FMinorVersion: Word;
    FProjectFolder: string;
    FActions: TLMDPluginActions;
    FFileName: TLMDString;
    FGuids: TLMDGuids;
    FDescription: TLMDString;
    FPlugin: TLMDPlugin;
    function GetPluginEvent(): ILMDPluginEvent;
    function getLMDPackage:TLMDPackageID;
    procedure InitPlugin();
  protected
    { Protected declarations }
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    function GetPlugin(): ILMDPlugin;
    property Author: string read FAuthor write FAuthor;
    property MajorVersion: Word read FMajorVersion write FMajorVersion;
    property MinorVersion: Word read FMinorVersion write FMinorVersion;
    property ProjectFolder: string read FProjectFolder write FProjectFolder;
    property Actions: TLMDPluginActions read FActions write FActions;

    property FileName: TLMDString read FFileName write FFileName;
    property Guids: TLMDGuids read FGuids write FGuids;
    property Description: TLMDString read FDescription write FDescription;
    property PluginEvent: ILMDPluginEvent read GetPluginEvent;
    property Plugin: TLMDPlugin read FPlugin;
    { Published declarations }
  end;

  TLMDPluginModule = class(TLMDCustomPluginModule)
  published
    property Author;
    property MajorVersion;
    property MinorVersion;
    property ProjectFolder;
    property Actions;
    property FileName;
    property Guids;
    property Description;
    property About;
  end;

implementation

constructor TLMDGuid.Create(Collection: TCollection);
var
  i: Byte;
begin
  inherited Create(Collection);
  FGuid.D1 := 0;
  FGuid.D2 := 0;
  FGuid.D3 := 0;
  for i := 0 to Length(FGuid.D4) - 1 do
    FGuid.D4[i] := 0;
end;

function TLMDGuid.GetGuid(): String;
begin
  try
    Result := GUIDToString(FGuid);
  except
    Result := '';
  end;
end;

procedure TLMDGuid.SetGuid(AValue: String);
begin
  try
    FGuid := StringToGUID(AValue)
  except
    Raise EParserError.Create('Wrong GUID format');
  end;
end;

constructor TLMDCustomPluginModule.Create(AOwner: TComponent);
begin
  FActions := TLMDPluginActions.Create(Self, TLMDPluginAction);
  FGuids := TLMDGuids.Create(Self, TLMDGuid);
  inherited Create(AOwner);
  InitPlugin();
end;

destructor TLMDCustomPluginModule.Destroy();
begin
  FActions.Free;
  FGuids.Free;
  inherited;
end;

function TLMDCustomPluginModule.GetPlugin(): ILMDPlugin;
begin
  Result := FPlugin;
end;

procedure TLMDCustomPluginModule.InitPlugin();
var
  LAction: TLMDAction;
  LParam: ILMDParameter;
  i, j: Integer;
  LPluginAction: TLMDPluginAction;
  LPluginParam: TLMDPluginParameter;  
begin
  FPlugin := TLMDPlugin.Create(Author, Description, MajorVersion, MinorVersion);
  for i := 0 to FActions.Count - 1 do
  begin
    LPluginAction := TLMDPluginAction(FActions.Items[i]);
    LAction := FPlugin.AddAction(LPluginAction.Name);
    LAction.OnPerformAction := LPluginAction.OnPerformAction;
    for j := 0 to LPluginAction.Parameters.Count - 1 do
    begin
      LPluginParam := TLMDPluginParameter(LPluginAction.Parameters.Items[j]);
      LParam := LAction.AddParameter(LPluginParam.Name);
      LParam.ParameterType := LPluginParam.ParamType;
      LParam.IsOptional := LPluginParam.IsOptional; 
    end;
  end;

  for i := 0 to Guids.Count - 1 do
    FPlugin.AddIdentifier( StringToGUID(TLMDGuid(Guids.Items[i]).Guid) );
end;

function TLMDCustomPluginModule.GetPluginEvent(): ILMDPluginEvent;
begin
  if Assigned(FPlugin) then
    Result := FPlugin.GetEventCallback();
end;
constructor TLMDCustomPluginAction.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FParameters := TLMDPluginParameters.Create(Self, TLMDPluginParameter);
end;

destructor TLMDCustomPluginAction.Destroy();
begin
  FParameters.Free;
  inherited;
end;

function TLMDCustomPluginModule.getLMDPackage:TLMDPackageID;
begin
  Result := pi_LMD_PLUGIN;
end;

end.
