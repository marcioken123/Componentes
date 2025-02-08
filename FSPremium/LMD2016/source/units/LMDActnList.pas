unit LMDActnList;
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

LMDActnList unit (AH)
---------------------
Unicode ActionList

Changes
-------
Release 9.0 (September 2008)
 - Initial Release

###############################################################################}

interface

uses
  Classes, ActnList, SysUtils, Menus, Controls, LMDObjectList, LMDUtils,
  LMDTypes, LMDUnicodeControl, intfLMDBase;

type
  TLMDActionList = class(TActionList, ILMDComponent)
  private
    FReplacedClassesList: TLMDObjectList;
    FAbout: TLMDAboutVar;
  public
    function GetReplacedActionClass(const AOriginal: TBasicActionClass): TBasicActionClass;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  end;

  {$IFNDEF LMDCOMP17}
  ILMDUnicodeAction = interface(IInterface)
    ['{F934E5AA-A7F1-477B-BD1D-06E991076F9D}']
    function GetHint: WideString;
    function GetCaption: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  end;

  TLMDCustomUnicodeAction = class(TCustomAction, ILMDUnicodeAction)
  private
    FHint: WideString;
    FCaption: WideString;
    procedure SetCaption(const Value: WideString);
    procedure SetHint(const Value: WideString);
    function GetCaption: WideString;
    function GetHint: WideString;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDAction = class(TAction{$IFDEF LMDCOMP17})
  private
    FAbout: TLMDAboutVar;
  {$ElSE}, ILMDUnicodeAction)
  private
    FAbout: TLMDAboutVar;
    FHint: WideString;
    FCaption: WideString;
    procedure SetCaption(const Value: WideString);
    procedure SetHint(const Value: WideString);
    function GetCaption: WideString;
    function GetHint: WideString;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  {$ENDIF}
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    {$IFNDEF LMDCOMP17}
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
    {$ENDIF}
  end;

{$IFNDEF LMDCOMP17}
procedure LMDAssignAction(ADestination: ILMDUnicodeAction; Source: TPersistent);
procedure LMDSetHintForTAction(AClients: TList; const AValue: WideString);
procedure LMDSetCaptionForTAction(AClients: TList; const AValue: WideString);
{$ENDIF}

implementation

uses
  LMDProcs;

type
  THackLMDActionLink = class(TActionLink);
{$IFNDEF LMDCOMP17}
{ ---------------------------------------------------------------------------- }
procedure LMDAssignAction(ADestination: ILMDUnicodeAction; Source: TPersistent);
var
  LTemp: ILMDUnicodeAction;
begin
  if Source is TCustomAction then
  begin
    if Supports(Source, ILMDUnicodeAction, LTemp) then
    begin
      ADestination.SetCaption(LTemp.GetCaption);
      ADestination.SetHint(LTemp.GetHint);
    end
    else
    begin
      ADestination.SetCaption(TCustomAction(Source).Caption);
      ADestination.SetHint(TCustomAction(Source).Hint);
    end;
  end;
  if Source is TControl then
  begin
    // TODO Alex
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDSetCaptionForTAction(AClients: TList; const AValue: WideString);
var
  i: Integer;
  LLink: TActionLink;
begin
  for I := 0 to AClients.Count - 1 do
  begin
    LLink := TObject(AClients.List[I]) as TActionLink;
    if Assigned(LLink) then
      THackLMDActionLink(LLink).SetCaption(LMDConvertVCLHint(AValue));
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDSetHintForTAction(AClients: TList; const AValue: WideString);
var
  i: Integer;
  LLink: TActionLink;
begin
  for I := 0 to AClients.Count - 1 do
  begin
    LLink := TObject(AClients.List[I]) as TActionLink;
    if Assigned(LLink) then
      THackLMDActionLink(LLink).SetHint(LMDConvertVCLHint(AValue));
      end;
end;

{ TLMDCustomUnicodeAction }
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomUnicodeAction.Assign(Source: TPersistent);
begin
  if Source is TLMDCustomUnicodeAction then
  begin
    FCaption := TLMDCustomUnicodeAction(Source).Caption;
    FHint := TLMDCustomUnicodeAction(Source).Hint;
  end
  else
    if Source is TCustomAction then
    begin
      FCaption := TCustomAction(Source).Caption;
      FHint := TCustomAction(Source).Hint;
    end
    else
      inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomUnicodeAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomUnicodeAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomUnicodeAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomUnicodeAction.SetCaption(const Value: WideString);
begin
  FCaption := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomUnicodeAction.SetHint(const Value: WideString);
begin
  FHint := Value;
end;

{ TLMDUnicodeAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDAction.Assign(Source: TPersistent);
begin
  if Source is TLMDCustomUnicodeAction then
  begin
    FCaption := TLMDCustomUnicodeAction(Source).Caption;
    FHint := TLMDCustomUnicodeAction(Source).Hint;
  end
  else
    if Source is TCustomAction then
    begin
      FCaption := TCustomAction(Source).Caption;
      FHint := TCustomAction(Source).Hint;
    end
    else
      inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;
{$ENDIF}

{ TLMDActionList }
{ ---------------------------------------------------------------------------- }
constructor TLMDActionList.Create(AOwner: TComponent);
begin
  inherited;
  FReplacedClassesList := TLMDObjectList.Create;
  FReplacedClassesList.AutoClearObjects := True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDActionList.Destroy;
begin
  FreeAndNil(FReplacedClassesList);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDActionList.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{ ---------------------------------------------------------------------------- }
function TLMDActionList.GetReplacedActionClass(const AOriginal: TBasicActionClass): TBasicActionClass;
begin
  Result := TBasicActionClass(GetClass('TLMDU' + Copy(AOriginal.ClassName, 2, Length(AOriginal.ClassName))));
  if Result = nil then
    Result := AOriginal;
end;

initialization
  RegisterClass(TLMDAction);

end.
