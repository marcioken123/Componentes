unit LMDSysFileAssocInfo;
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

LMDSysFileAssocInfo unit (JH)
-----------------------------
TLMDFileAssocItem - collection item for holding info about a FileAssoc
TLMDFileAssocInfo - collection of all available FileAssocs

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Dialogs, Graphics,
  LMDSysObject, LMDSysBase;

type
  { ************************************************************************** }
  TLMDFileAction = class(TLMDSysCollectionItem)
  private
    FActionName: string;
    FActionFile: string;
    procedure SetDummyString(const Value: string);
    procedure SetString(const Value: string);
  protected
    function GetDisplayName: string; override;
    procedure RegisterProperties; override;
  public
    procedure Apply; override;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property ActionName: string read FActionName write SetDummyString;
    property ActionFile: string read FActionFile write SetString;
  end;

  { ************************************************************************** }
  TLMDFileActions = class(TLMDSysCollection)
  private
    FOwner: TPersistent;
    function GetItem(Index: Integer): TLMDFileAction;
    procedure SetItem(Index: Integer; Value: TLMDFileAction);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDFileAction;
    constructor Create(aOwner: TPersistent);
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
    property Items[Index: Integer]: TLMDFileAction read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDFileAssocItem = class(TLMDSysCollectionItem,  ILMDSysContainer)
  private
    FSubClass: string;
    FDescription: string;
    FExt: string;
    FActions: TLMDFileActions;
    FDefaultIconStr: string;
    procedure SetDummyActions(const Value: TLMDFileActions);
    procedure SetDummyString(const Value: string);
    procedure SetString(Index: LongInt; const Value: string);
  protected
    procedure RegisterProperties; override;
    function GetDisplayName: string; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Apply; override;
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;

  published
    property Ext: string read FExt write SetDummyString;
    property Description: string index 0 read FDescription write SetString;
    property DefaultIconStr: string index 1 read FDefaultIconStr write SetString;
    property Actions: TLMDFileActions read FActions write SetDummyActions;
  end;

  { ************************************************************************** }
  TLMDFileAssocsInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDFileAssocItem;
    procedure SetItem(Index: Integer; Value: TLMDFileAssocItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDFileAssocItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDFileAssocItem read GetItem write SetItem; default;
  end;

implementation

uses
  SysUtils, Registry, LMDSysLogStrings, LMDSysConst;

const
  cpidActionName = 0;
  cpidActionFile = 1;
  cpidassocExt = 2;
  cpidassocDescription = 3;
  cpidassocDefaultIconStr = 4;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
procedure TLMDFileAction.Apply;
var
  R: TRegistry;
begin
  inherited;
  R:= TRegistry.Create;
  try
    if PropChanged(Format(strFileAssocActionFile, [(TLMDFileActions(Collection).FOwner as
        TLMDFileAssocItem).Index])) then
      begin
        WriteToLog(Format(strFileAssocActionFile, [(TLMDFileActions(Collection).FOwner as
            TLMDFileAssocItem).Index]));
        R.RootKey:= HKEY_CLASSES_ROOT;
        R.OpenKey((TLMDFileActions(Collection).FOwner as
          TLMDFileAssocItem).FSubClass + '\shell\' + FActionName + '\command', false);
        R.WriteString('', FActionFile);
        R.CloseKey;
      end;
  finally
    R.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFileAction.GetDisplayName: string;
begin
  Result:= FActionName;
end;

{------------------------------------------------------------------------------}
procedure TLMDFileAction.SetDummyString(const Value: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDFileAction.SetString(const Value: string);
begin
  if FActionFile <> Value then
    begin
      RememberChange(Format(strFileAssocActionFile, [(TLMDFileActions(Collection).FOwner as
          TLMDFileAssocItem).Index]), FActionFile, Value);
      FActionFile:= Value;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAction.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidActionName, sLMDSysFileActionPropTitleActionName, sLMDSysFileActionPropDescActionName);
  FPropertiesDesc.Add(cpidActionFile, sLMDSysFileActionPropTitleActionFile, sLMDSysFileActionPropDescActionFile);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAction.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidActionName).Text := FActionName;
  FPropertiesDesc.PropertyByID(cpidActionFile).Text := FActionFile;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileAction.GetElementTitle : string;
begin
  result := sLMDSysFileActionTitle + ' ['+FActionName+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileAction.GetElementDescription : string;
begin
  result := sLMDSysFileActionDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileAction.GetElementType : TLMDSysInfoType;
begin
  result := itFileAction;
end;

{ **************************************************************************** }
{ ---------------------------------------------------------------------------- }
function TLMDFileActions.Add: TLMDFileAction;
begin
  Result:= TLMDFileAction(inherited Add)
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDFileActions.Create(aOwner: TPersistent);
begin
  inherited Create(TLMDFileAction);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileActions.GetItem(Index: Integer): TLMDFileAction;
begin
  Result:= TLMDFileAction(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileActions.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileActions.SetItem(Index: Integer; Value: TLMDFileAction);
begin
  inherited SetItem(Index, Value)
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileActions.GetElementTitle : string;
begin
  result := sLMDSysFileActionGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileActions.GetElementDescription : string;
begin
  result := sLMDSysFileActionGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileActions.GetElementType : TLMDSysInfoType;
begin
  result := itFileActionGroup;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
procedure TLMDFileAssocItem.SetDummyActions(const Value: TLMDFileActions);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAssocItem.SetDummyString(const Value: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDFileAssocItem.SetString(Index: Integer; const Value: string);
begin
  case Index of
    0:
      if FDescription <> Value then
        begin
          RememberChange(strFileAssocDescription, FDescription, Value);
          FDescription:= Value;
        end;
    1:
      if FDefaultIconStr <> Value then
        begin
          RememberChange(strFileAssocDefIcon, FDefaultIconStr, Value);
          FDefaultIconStr:= Value;
        end;
  end;
end;
{ -------------------------- public ----------------------------------------- }
function TLMDFileAssocItem.GetDisplayName: string;
begin
  Result:= FExt + ' - ' + FDescription;
end;

{------------------------------------------------------------------------------}
constructor TLMDFileAssocItem.Create;
begin
  inherited;
  FActions:= TLMDFileActions.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFileAssocItem.Destroy;
begin
  FActions.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAssocItem.Apply;
var
  R: TRegistry;
begin
  inherited;
  R:= TRegistry.Create;
  try
    R.RootKey:= HKEY_CLASSES_ROOT;
    R.OpenKey(FSubClass, false);
    if PropChanged(strFileAssocDescription) then
      begin
        WriteToLog(strFileAssocDescription);
        R.WriteString('', FDescription);
      end;
    if PropChanged(strFileAssocDefIcon) then
      begin
        WriteToLog(strFileAssocDefIcon);
        R.WriteString('DefaultIcon', FDefaultIconStr);
      end;
    FActions.Apply;
  finally
    R.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAssocItem.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidassocExt, sLMDSysFileAssocPropTitleassocExt, sLMDSysFileAssocPropDescassocExt);
  FPropertiesDesc.Add(cpidassocDescription, sLMDSysFileAssocPropTitleassocDescription, sLMDSysFileAssocPropDescassocDescription);
  FPropertiesDesc.Add(cpidassocDefaultIconStr, sLMDSysFileAssocPropTitleassocDefaultIconStr, sLMDSysFileAssocPropDescassocDefaultIconStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDFileAssocItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidassocExt).Text := FExt;
  FPropertiesDesc.PropertyByID(cpidassocDescription).Text := FDescription;
  FPropertiesDesc.PropertyByID(cpidassocDefaultIconStr).Text := FDefaultIconStr;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocItem.GetElementTitle : string;
begin
  result := sLMDSysFileAssocTitle + ' ['+FExt+']';
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocItem.GetElementDescription : string;
begin
  result := sLMDSysFileAssocDesc;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocItem.GetElementType : TLMDSysInfoType;
begin
  result := itFileAssoc;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocItem.GetElementCount : integer;
begin
  result := 1;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocItem.GetElement(index : integer) : TObject;
begin
  result := FActions;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }

function TLMDFileAssocsInfo.GetItem(Index: Integer): TLMDFileAssocItem;
begin
  Result:= TLMDFileAssocItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFileAssocsInfo.SetItem(Index: Integer; Value: TLMDFileAssocItem);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }

function TLMDFileAssocsInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ -------------------------- public ------------------------------------------ }

function TLMDFileAssocsInfo.Add: TLMDFileAssocItem;
begin
  Result:= TLMDFileAssocItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDFileAssocsInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDFileAssocItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFileAssocsInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileAssocsInfo.Refresh;
var
  R: TRegistry;
  sExtentions: TStringList;
  sActions: TStringList;
  I, J: LongInt;
  s1: string;
begin
  DoProgress(sLMDSysFileAssocGroupTitle, 100, 0);
  R:= TRegistry.Create;
  sExtentions:= TStringList.Create;
  sActions:= TStringList.Create;
  try
    R.RootKey:= HKEY_CLASSES_ROOT;
    R.OpenKey('', false);
    R.GetKeyNames(sExtentions);
    for I:= 0 to sExtentions.Count - 1 do
      begin
        DoProgress(sLMDSysFileAssocGroupTitle, 100, Round(i*100/sExtentions.Count));
        if sExtentions[I][1] = '.' then
          begin
            R.OpenKey(sExtentions[I], false);
            if R.ValueExists('') then
              begin
                s1:= R.ReadString('');
                R.CloseKey;
                if R.OpenKey(s1, false) then
                  begin
                    with Add do
                      begin
                        FSubClass:= s1;
                        FExt:= sExtentions[I];
                        if R.ValueExists('') then
                          FDescription:= R.ReadString('')
                        else
                          FDescription:= '';
                        if R.OpenKey('\' + FSubClass + '\DefaultIcon', false) then
                          begin
                            if R.ValueExists('') then
                              FDefaultIconStr:= R.ReadString('')
                            else
                              FDefaultIconStr:= '';
                            R.CloseKey;
                          end;
                        if R.OpenKey(FSubClass + '\shell', false) then
                          begin
                            sActions.Clear;
                            R.GetKeyNames(sActions);
                            for J:= 0 to sActions.Count - 1 do
                              begin
                                if R.OpenKey('\' + FSubClass + '\shell\' + sActions[J], false) then
                                  begin
                                    with Actions.Add do
                                      begin
                                        FActionName:= R.ReadString('');
                                        if FActionName = '' then FActionName:= sActions[J];
                                        if R.OpenKey('\' + FSubClass + '\shell\' + sActions[J] + '\command', false) then
                                          begin
                                            FActionFile:= R.ReadString('');
                                            R.CloseKey;
                                          end;
                                        Refresh;
                                      end;
                                    R.CloseKey;
                                  end;
                              end;
                          end;
                        R.CloseKey;
                        Refresh;
                      end;
                    R.CloseKey;
                  end;
              end
            else
              R.CloseKey;
          end;
      end;
    R.CloseKey;
  finally
    R.Free;
    sExtentions.Free;
    sActions.Free;
  end;
DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocsInfo.GetElementTitle : string;
begin
  result := sLMDSysFileAssocGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocsInfo.GetElementDescription : string;
begin
  result := sLMDSysFileAssocGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDFileAssocsInfo.GetElementType : TLMDSysInfoType;
begin
  result := itFileAssocGroup;
end;

end.
