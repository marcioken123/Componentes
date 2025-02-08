unit LMDStorFormProperties;
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

LMDStorFormProperties unit (VO)
-------------------------------


Changes
-------
Release 2.02 (December 2007)
* Minor change for better support of MDI forms in connection with TLMDBack/TLMDFormFill

Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Forms, Messages, Classes, SysUtils,
  LMDStorPropertiesStorage, LMDStorBase;

type
  // helper type
  TLMDStorFormProps = set of (fpColor, fpFont, fpPosition, fpHeight, fpWidth, fpWindowState);
  TLMDStorFormPosition = (dfpUseDefaultValues, dfpDesktopCenter, dfpMainFormCenter, dfpOwnerFormCenter, dfpScreenPosCenter);

const
  def_FormProps=[fpPosition, fpHeight, fpWidth, fpWindowState];

type
  {-------------------  Class TLMDStorCustomFormProperties --------------------}
  TLMDStorCustomFormProperties = class(TLMDStorCustomPropertiesStorage)
  private
    FStorFormProps: TLMDStorFormProps;
    FDefaultTop,
    FDefaultLeft,
    FDefaultWidth,
    FDefaultHeight: Integer;
    FDefaultWindowState: TWindowState;
    FDefaultPosition: TLMDStorFormPosition;
    procedure SetDefaultTop(const Value: Integer);
    procedure SetDefaultLeft(const Value: Integer);
    procedure SetDefaultWidth(const Value: Integer);
    procedure SetDefaultHeight(const Value: Integer);
    procedure SetDefaultPosition(const Value: TLMDStorFormPosition);
    procedure SetDefaultWindowState(const Value: TWindowState);
    procedure SetStorFormProps(const Value: TLMDStorFormProps);
    procedure SetStorProps;
  protected
    function IsPropListEmpty: boolean; override;
    property DefaultTop: Integer read FDefaultTop write SetDefaultTop default 0;
    property DefaultLeft: Integer read FDefaultLeft write SetDefaultLeft default 0;
    property DefaultWidth: Integer read FDefaultWidth write SetDefaultWidth default 0;
    property DefaultHeight: Integer read FDefaultHeight write SetDefaultHeight default 0;
    property DefaultPosition: TLMDStorFormPosition read FDefaultPosition write SetDefaultPosition default dfpUseDefaultValues;
    property DefaultWindowState: TWindowState read FDefaultWindowState write SetDefaultWindowState default wsNormal;
    property StoredFormProps: TLMDStorFormProps read FStorFormProps write SetStorFormProps; //default def_FormProps;
    procedure DoOnLoadData(Sender: TObject; var Stream: TMemoryStream); override;
    // RM - maybe not right method, please check
    procedure DoOnSaving; override;
    procedure OwnerFormDestroy(Sender: TObject); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save; override;
  end;

  {-------------------  Class TLMDStorFormStorage -----------------------------}
  TLMDStorFormStorage = class(TLMDStorCustomFormProperties)
  published
    property DefaultTop;
    property DefaultLeft;
    property DefaultWidth;
    property DefaultHeight;
    property DefaultPosition;
    property DefaultWindowState;
    property StoredFormProps;
    property Enabled;
    property StorageVault;
    property AutoLoad;
    property AutoSave;
    property OnLoading;
    property OnSaving;
    property OnLoadData;
    property OnSaveData;
    property OnNoStorageData;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{********************* TLMDStorCustomFormProperties ***************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomFormProperties.SetDefaultTop(const Value: Integer);
begin
  if Value <> FDefaultTop then FDefaultTop := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetDefaultLeft(const Value: Integer);
begin
  if Value <> FDefaultLeft then FDefaultLeft := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetDefaultWidth(const Value: Integer);
begin
  if Value <> FDefaultWidth then FDefaultWidth := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.Save;
begin
  if (FPropertyStorage.Count = 0) then
    SetStorProps;
  inherited;
end;

procedure TLMDStorCustomFormProperties.SetDefaultHeight(const Value: Integer);
begin
  if Value <> FDefaultHeight then FDefaultHeight := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetDefaultPosition(const Value: TLMDStorFormPosition);
begin
  if Value <> FDefaultPosition then FDefaultPosition := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetDefaultWindowState(const Value: TWindowState);
begin
  if Value <> FDefaultWindowState then FDefaultWindowState := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetStorFormProps(const Value: TLMDStorFormProps);
begin
  if Value <> FStorFormProps then
  begin
    FPropertyStorage.Clear;
    FStorFormProps := Value;
    SetStorProps;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.SetStorProps;

  procedure AddProp(Comp, Prop: String);
  var
    PropItem: TLMDStorPropertyStorageItem;
  begin
    PropItem := FPropertyStorage.Add;
    PropItem.ComponentName := Comp;
    PropItem.PropertyName := Prop;
  end;

begin
  if fpColor in FStorFormProps then
    AddProp(TForm(Owner).Name, 'Color');
  if fpFont in FStorFormProps then
    AddProp(TForm(Owner).Name, 'Font');

  if fpPosition in FStorFormProps then
     begin
       AddProp(TForm(Owner).Name, 'Left');
       AddProp(TForm(Owner).Name, 'Top');
       {$IFDEF LMDCOMP9}
       if TForm(Owner).FormStyle=fsNormal then
       {$ENDIF}
         AddProp(TForm(Owner).Name, 'Position');
     end;
  if fpWidth in FStorFormProps then AddProp(TForm(Owner).Name, 'Width');
  if fpHeight in FStorFormProps then AddProp(TForm(Owner).Name, 'Height');

  if fpWindowState in FStorFormProps then //AddProp(TForm(Owner).Name, 'WindowsState');
    AddProp(TForm(Owner).Name,'WindowState');
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.DoOnLoadData(Sender: TObject; var Stream: TMemoryStream);
begin
  //LockWindowUpdate ?
  if not (fpPosition in FStorFormProps) then
    with TForm(Owner) do
      begin
        if (DefaultTop <> 0) then
        begin
          Top := DefaultTop;
          if Top + Height > Screen.DesktopHeight then
            Top := Screen.DesktopHeight - Height;
        end;
        if (DefaultLeft <> 0) then
        begin
          Left := DefaultLeft;
          if Left + Width > Screen.DesktopWidth then
           Left := Screen.DesktopWidth - Width;
        end;
        if (DefaultPosition <> dfpUseDefaultValues) then
        case DefaultPosition of
          dfpDesktopCenter: Position := poDesktopCenter;
          dfpMainFormCenter: Position := poMainFormCenter;
          dfpOwnerFormCenter: Position := poOwnerFormCenter;
          dfpScreenPosCenter: Position := poScreenCenter;
        end;
      end;
  if not (fpWidth in FStorFormProps) and (DefaultWidth <> 0) then
     TForm(Owner).Width := DefaultWidth;
  if not (fpHeight in FStorFormProps) and (DefaultHeight <> 0) then
     TForm(Owner).Left := DefaultHeight;
  if not (fpWindowState in FStorFormProps) then
   TForm(Owner).WindowState := DefaultWindowState;
  inherited DoOnLoadData(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.DoOnSaving;
var
 TWP    : TWindowPlacement;
begin
  inherited;
  // For MainForm of application, WindowState property is handled differently!
  if not IsLibrary and Assigned(Owner) then
    begin
     if (TCustomForm(Owner)=Application.MainForm) and IsIconic(Application.Handle) then
       TCustomForm(Owner).WindowState:=wsMinimized;
     if (fpWindowState in FStorFormProps) and (TCustomForm(Owner).WindowState in [wsMinimized, wsMaximized]) then
       begin
         TWP.length := sizeof(TWP);
         GetWindowPlacement(TCustomForm(owner).Handle, @TWP);
         TCustomForm(Owner).BoundsRect := TWP.rcNormalPosition;
       end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomFormProperties.OwnerFormDestroy(Sender: TObject);
begin
  SetStorProps;
  inherited OwnerFormDestroy(Sender);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorCustomFormProperties.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSkipNotFoundComponents := True;
  FDefaultTop := 0;
  FDefaultLeft := 0;
  FDefaultWidth := 0;
  FDefaultHeight := 0;
  FDefaultWindowState := wsNormal;
  FStorFormProps:=def_FormProps;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomFormProperties.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomFormProperties.IsPropListEmpty: boolean;
begin
  result := (inherited IsPropListEmpty) and (StoredFormProps = []);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
