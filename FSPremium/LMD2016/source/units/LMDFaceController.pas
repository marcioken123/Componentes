unit LMDFaceController;
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

LMDFaceController unit (JH)
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, Controls, Messages, Windows,
  LMD3DCaption, LMDFillObject, LMDBevel, LMDBitmapEffectObject, LMDCFCStateObject,
  LMDCFCSettingObject, LMDCustomComponent, LMDStyleMan, LMDBaseController;

type
  TLMDSetFaceControllerEvent = procedure(Sender: TObject; AControl: TControl; var ACanSetController: boolean) of object;

type
  TLMDFaceController = class (TLMDCustomComponent)
  private
    FOnSetFaceController: TLMDSetFaceControllerEvent;

    FStyleMgrLink: TLMDChangeLink;
    //<--vb
    FStyleManager: TLMDStyleManager;
    FStyleName: string;
    FUpdatingStyle: boolean;
    //-->

    FSettingObjects   : TLMDCFCSettingObjects;
    FControls         : TList;
    { FDefinedStates:
      is a predefined list of states per control class type
      the number of supported control classes (i.e.) the class list
      is managed by the register function
    }
    FDefinedStates    : TLMDCFCStateObjects;

    procedure SetStateObjects (anObject: TLMDCFCStateObjects);
    procedure SetSettingObjects (aValue: TLMDCFCSettingObjects);

    procedure LoadSettingsFromStream(Stream:TStream);
    procedure SaveSettingsToStream(Stream:TStream);
    //vb
    procedure SetStyleManager(AValue: TLMDStyleManager);
    //--
  protected
    //-- Style manager support
    procedure ApplyStateStyle(aControl: TControl; const AState: TLMDStateList);
    //--

    procedure DefineProperties (Filer: TFiler); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    //read control settings!!
    function controlFocused     (aControl: TControl): Boolean;
    function controlMouseAbove  (aControl: TControl): Boolean;
    function controlTransparent (aControl: TControl): Boolean;
    function controlBackCtlXP   (aControl: TControl): Boolean;
    function controlBackColor   (aControl: TControl): TColor;
    function controlBorderCtlXP (aControl: TControl): Boolean;
    function controlBorderCtl3D (aControl: TControl): Boolean;
    function controlPressed     (aControl: TControl): Boolean;
    function controlModified    (aControl: TControl): Boolean;
    function controlReadOnly    (aControl: TControl): Boolean;
    function controlWrongData   (aControl: TControl): Boolean;
    function controlDisabled    (aControl: TControl): Boolean;

    procedure StyleMgrChange(Sender : TObject);
    procedure SetStyleName(const AValue: string);

    function GetStateObject(aControl: TControl; objectClass: TPersistentClass): TPersistent;
    procedure Loaded;override;
  public
    constructor Create (aComponent: TComponent); override;
    destructor Destroy; override;
    procedure Assign (Source: TPersistent); override;

    function AddSettingObject(aSettingObject: TPersistent {Name}):Integer;overload;
    function AddSettingObject(aKind: TLMDCFCSettingObjectKind{Name}):Integer;overload;
    procedure FillControlList;
    procedure StateChanged(aControl: TControl); overload;
    procedure RemoveSettingObject (aSettingObject: TPersistent);

    function GetFont        (aControl: TControl): TFont;
    function GetFont3D      (aControl: TControl): TLMD3DCaption;
    function GetTransparent (aControl: TControl): Boolean;
    function GetBackCtlXP   (aControl: TControl): Boolean;
    function GetBackColor   (aControl: TControl): TColor;
    function GetFillObject  (aControl: TControl): TLMDFillObject;
    function GetBackFX      (aControl: TControl): TLMDBitmapEffectObject;
    function GetBorderCtlXP (aControl: TControl): Boolean;
    function GetBorderCtl3D (aControl: TControl): Boolean;
    function GetBevel       (aControl: TControl): TLMDBevel;

    //paint control
    function findState (aControl: TControl): TLMDCFCStateObject;
    function Paint (aControl: TControl): Boolean;

    //register / unregister controls -> registered controls will be informed of
    //component changes
    procedure RegisterControl (aControl: TControl);
    procedure UnregisterControl (aControl: TControl);

    {i/o}
    procedure LoadFromFile(const aFilename: string);
    procedure SaveToFile(const aFilename: string);

    procedure UpdateControls;
    procedure UpdateStyle;
{    property SettingObject [index: Integer]: TLMDCFCSettingObject
                                                        read GetSettingObject
                                                        write SetSettingObject;}

    property Settings: TLMDCFCSettingObjects read FSettingObjects write SetSettingObjects;
  published
    property About;
    property States : TLMDCFCStateObjects read FDefinedStates write SetStateObjects;
    property StyleManager: TLMDStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property OnSetFaceController: TLMDSetFaceControllerEvent read FOnSetFaceController write FOnSetFaceController;
  end;

implementation

uses
  SysUtils,
  intfLMDBase,
  intfLMDBackground,
  intfLMDFaceController,
  intfLMDFaceControllerPressable,
  intfLMDFaceControllerEditable;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if Operation = opRemove then
    begin
      if AComponent = FStyleManager then
        StyleManager := nil;
    end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFaceController.SetSettingObject (index: Integer; anObject: TPersistent);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SetStateObjects (anObject: TLMDCFCStateObjects);
begin
  FDefinedStates.Assign(anObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SetSettingObjects (aValue: TLMDCFCSettingObjects);
begin
  FSettingObjects.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.LoadSettingsFromStream(Stream: TStream);
begin
  FSettingObjects.LoadFromStream(Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SaveSettingsToStream(Stream: TStream);
begin
  FSettingObjects.SaveToStream(Stream);
end;

{ --------------------------------- protected -------------------------------- }
function TLMDFaceController.controlFocused    (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetFocused
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlMouseAbove (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetMouseAbove
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlTransparent (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetTransparent
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlBackCtlXP   (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetCtlXP
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlBackColor   (aControl: TControl): TColor;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetBackColor
  else
    result := clBackground;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlBorderCtlXP (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetCtlXP
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlBorderCtl3D (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := itmp.fcGetBorderCtl3D
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlPressed     (aControl: TControl): Boolean;
var
  itmp:ILMDFaceControllerPressable;
begin
  if LMDSupports (aControl, ILMDFaceControllerPressable, itmp) then
    result := itmp.fcGetPressed
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlModified    (aControl: TControl): Boolean;
var
  itmp:ILMDFaceControllerEditable;
begin
  if LMDSupports (aControl, ILMDFaceControllerEditable, itmp) then
    result := itmp.fcGetModified
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlReadOnly    (aControl: TControl): Boolean;
var
  itmp:ILMDFaceControllerEditable;
begin
  if LMDSupports (aControl, ILMDFaceControllerEditable, itmp) then
    result := itmp.fcGetReadOnly
  else
    result := false;
end;
{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlWrongData   (aControl: TControl): Boolean;
var
  itmp:ILMDFaceControllerEditable;
begin
  if LMDSupports (aControl, ILMDFaceControllerEditable, itmp) then
    result := itmp.fcGetInvalidData
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.controlDisabled   (aControl: TControl): Boolean;
var
  itmp:ILMDFaceController;
begin
  if LMDSupports (aControl, ILMDFaceController, itmp) then
    result := not itmp.fcGetEnabled
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetStateObject(aControl: TControl; objectClass: TPersistentClass): TPersistent;
var
  i     : Integer;
  aState: TLMDCFCStateObject;
begin
  result := nil;
  aState := findState (aControl);
  if aState <> nil then
    begin
      for i := 0 to aState.Settings.Count - 1 do
        if TPersistent(aState.Settings.Objects[i]) is objectClass then
          begin
            result := TPersistent(aState.Settings.Objects[i]);
            break;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.DefineProperties (Filer: TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineBinaryProperty('Settings', LoadSettingsFromStream, SaveSettingsToStream, FSettingObjects.Count>0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.Loaded;
begin
  inherited;
  FDefinedStates.Synchronize;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDFaceController.Create (aComponent: TComponent);
begin
  inherited Create (aComponent);
  FUpdatingStyle := false;
  FSettingObjects := TLMDCFCSettingObjects.Create(self);
  FDefinedStates  := TLMDCFCStateObjects.Create(self);
  FDefinedStates.SettingsObjects:=FSettingObjects;
  FControls       := TList.Create;

  //<-- VB StyleManager support
  FStyleMgrLink := TLMDChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  //-->
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFaceController.Destroy;
begin
  FreeAndNil(FDefinedStates);
  FreeAndNil(FSettingObjects);
  FreeAndNil(FControls);
  FreeAndNil(FStyleMgrLink);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.Assign (Source: TPersistent);
begin
  if Source is TLMDFaceController then
    begin
      // 1.! Before DefinedStates
      FSettingObjects.Assign((Source as TLMDFaceController).Settings);
      // ---
      FDefinedStates.SettingsObjects:=FSettingObjects;
      FDefinedStates.Assign((Source as TLMDFaceController).States);
      exit;
    end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.AddSettingObject(aSettingObject: TPersistent {Name}):Integer;
begin
  result:=FSettingObjects.Add(aSettingObject);
//  if result>-1 then
//    FSettingObjects[result]:= aSettingObject;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.AddSettingObject(aKind: TLMDCFCSettingObjectKind{Name}):Integer;
begin
  result:=FSettingObjects.Add(aKind);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.FillControlList;
var
  i:integer;
  LIFc:ILMDFaceController;
  CanSet: boolean;
begin
  with Owner do
    for i := 0 to ComponentCount - 1 do
      if Components[i].InheritsFrom(TControl) and LMDSupports (Components[i], ILMDFaceController, LIFc) then
        begin
          CanSet := true;
          if Assigned(FOnSetFaceController) then
            FOnSetFaceController(Self, TControl(Components[i]), CanSet);
          if CanSet then
            begin
              LIFc.fcSetFaceController(self);
            end;
        end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.RemoveSettingObject (aSettingObject: TPersistent);
begin
  FSettingObjects.Remove(aSettingObject);
  FDefinedStates.Synchronize;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDFaceController.GetStateObject (focused, mouseabove: Boolean): TLMDCFCStateObject;
begin
end;}

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetFont        (aControl: TControl): TFont;
begin
  result := TFont(GetStateObject(aControl, TFont));
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetFont3D      (aControl: TControl): TLMD3DCaption;
begin
  result := TLMD3DCaption(GetStateObject(aControl, TLMD3DCaption));
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetTransparent (aControl: TControl): Boolean;
var
  tmp:TLMDCtlSettings;
begin
  tmp:=TLMDCtlSettings(GetStateObject(aControl, TLMDCtlSettings));
  if Assigned(tmp) then
    result:=tmp.Transparent
  else
    result := controlTransparent (aControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBackCtlXP   (aControl: TControl): Boolean;
begin
  result := controlBackCtlXP (aControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBackColor   (aControl: TControl): TColor;
var
  tmp:TLMDColorObject;
begin
  tmp:=TLMDColorObject(GetStateObject(aControl, TLMDColorObject));
  if Assigned(tmp) then
    result:=tmp.Color
  else
    result:=controlBackColor(aControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetFillObject  (aControl: TControl): TLMDFillObject;
begin
  result := TLMDFillObject(GetStateObject(aControl, TLMDFillObject));
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBackFX      (aControl: TControl): TLMDBitmapEffectObject;
begin
  result := TLMDBitmapEffectObject(GetStateObject(aControl, TLMDBitmapEffectObject));
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBorderCtlXP (aControl: TControl): Boolean;
var
  tmp:TLMDCtlSettings;
begin
  tmp:=TLMDCtlSettings(GetStateObject(aControl, TLMDCtlSettings));
  if Assigned(tmp) then
    result:=tmp.CtlXP
  else
    result := controlBorderCtlXP (aControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBorderCtl3D (aControl: TControl): Boolean;
begin
  result := controlBorderCtl3D (aControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.GetBevel(aControl: TControl): TLMDBevel;
begin
  result := TLMDBevel(GetStateObject(aControl, TLMDBevel));
end;

{ --------------------------- findState -------------------------------------- }
function LMDCFCfindState (disabled: boolean; error: boolean; focused: boolean;
                    readonly: boolean; hot: boolean; pressed: boolean;
                    modified: boolean): TLMDStateList;
const
  val: array[false..true] of byte = (2, 1);
var
  compareList,
  givenStateList: TLMDStateList;
  i: Integer;
  sk: TLMDStateKind;
  ok: boolean;
begin
  givenStateList[skDisabled]   := val[disabled];
  givenStateList[skFocused]    := val[focused];
  givenStateList[skMouseAbove] := val[hot];
  givenStateList[skDown]       := val[pressed];
  givenStateList[skModified]   := val[modified];
  givenStateList[skReadOnly]   := val[readonly];
  givenStateList[skWrongData]  := val[error];

  //
  i := 0;
  while i <LMDCFCgetAvailableStatesCount  do
    begin
      compareList := LMDCFCgetAvailableState(i);
      ok := true;
      for sk := Low (TLMDStateKind) to High(TLMDStateKind) do
        begin
          if not (compareList[sk] in [givenStateList[sk], StateIgnore]) then
            ok := false;
        end;
      if ok then break;
      inc(i);
    end;
  //will always return a valid i because of state "normal"
  result := compareList;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.findState (aControl: TControl): TLMDCFCStateObject;
var
  i   : Integer;
  s   : TLMDStateList;

begin
  result := nil;

  s := LMDCFCfindState (controlDisabled   (aControl),
                        controlWrongData  (aControl),
                        controlFocused    (aControl),
                        controlReadOnly   (aControl),
                        controlMouseAbove (aControl),
                        controlPressed    (aControl),
                        controlModified   (aControl));
  //s now contains the most approbates state
  //we'll now have to lookup whether there is an approbiate state defined in the
  //controller

  for i := 0 to FDefinedStates.Count - 1 do
    begin
      if LMDCFCcompareStates(FDefinedStates[i].getKind, s) then
        begin
          result := FDefinedStates[i];
          break;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFaceController.Paint (aControl: TControl): Boolean;
begin
  result := findState (aControl).Paint (aControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.RegisterControl (aControl: TControl);
begin
  FControls.Add(aControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.UnregisterControl (aControl: TControl);
begin
  if [csDestroying]*Componentstate<>[] then exit;
  if Assigned(FControls) then
    FControls.Remove(aControl)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SaveToFile (const aFilename: String);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(aFilename, fmCreate or fmShareDenyWrite);
  try
    SaveSettingsToStream(Stream);
    with TWriter.Create(Stream, 4096) do
      try
        WriteCollection(FDefinedStates);
      finally
        Free;
      end
  finally
    Stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.LoadFromFile (const aFilename: String);
var
  Stream: TFileStream;
begin
  Stream:=TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
  try
     LoadSettingsFromStream(Stream);
     with TReader.Create(Stream, 4096) do
       try
         CheckValue(vaCollection);
         ReadCollection(FDefinedStates);
       finally
         Free;
       end;
     FDefinedStates.Synchronize;
  finally
    Stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.UpdateControls;
var
  i: Integer;
begin
  for i := 0 to FControls.Count - 1 do
    TControl(FControls[i]).Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SetStyleManager(AValue: TLMDStyleManager);
begin
  if FStyleManager <> AValue then
    begin
      if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
        FStyleManager.RemoveFreeNotification(Self);
      if FStyleManager <> nil then
         FStyleManager.UnregisterChanges (FStyleMgrLink);
      FStyleManager := AValue;
      if FStyleManager <> nil then
        begin
          FStyleManager.FreeNotification(Self);
          FStyleManager.RegisterChanges(FStyleMgrLink);
          UpdateStyle;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.UpdateStyle;
var
  i:integer;
begin
  if (FControls.Count = 0) then
    exit;
  FUpdatingStyle := true;
  if (FStyleManager <> nil) then
    for i := 0 to FControls.Count - 1 do
      if TComponent(FControls[i])<>nil then
        if (TComponent(FControls[i]).ComponentState * [csLoading, csReading] = []) then
          FStyleManager.ApplyStyle(TComponent(FControls[i]), StyleName, true);
  FUpdatingStyle := false;        
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.StyleMgrChange(Sender : TObject);
var
  i: integer;
begin
  if (FStyleManager <> nil) and (FControls.Count > 0) then
    for i := 0 to FControls.Count - 1 do
      if (TComponent(FControls[i]) <> nil) and
         (TComponent(FControls[i]).ComponentState * [csLoading, csReading] = []) then
        begin
          if (TComponent(FControls[i]) is TWinControl) and (TWinControl(TComponent(FControls[i])).HandleAllocated) then
            SendMessage(TWinControl(TComponent(FControls[i])).Handle, WM_SETREDRAW, 0, 0);
          FStyleManager.ApplyStyle(TComponent(FControls[i]), StyleName, true);
          if (TComponent(FControls[i]) is TWinControl) and (TWinControl(TComponent(FControls[i])).HandleAllocated) then
            begin
              SendMessage(TWinControl(TComponent(FControls[i])).Handle, WM_SETREDRAW, 1, 0);
              TWinControl(TComponent(FControls[i])).Invalidate;
            end;
        end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.SetStyleName(const AValue: string);
begin
  if FStyleName <> AValue then
  begin
    FStyleName := AValue;
    UpdateStyle;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.ApplyStateStyle(aControl: TControl; const AState: TLMDStateList);
var
  i,j: integer;
  LStyleName: string;
begin
  //<-- If facecontroller is currently changing general style via UpdateStyle method,
  //    then all state style changes must be ingored, otherwise we get an endless loop
  //    for control that was focused while UpdateStyle was called
  if FUpdatingStyle then
    exit;
  //-->
  if (StyleManager <> nil) then
    if LMDCFCCompareStates(aState, stateNormal) then
      StyleManager.ApplyStyle(aControl, StyleName, true)
    else
      begin
        i := FDefinedStates.ItemByKind(AState);
        if i >= 0 then
           begin
             j := FDefinedStates.Items[i].IndexOfSetting(cfcStyle);
             if j >= 0 then
               begin
                 LStyleName := TLMDStyleObject(FDefinedStates.Items[i].Settings.Objects[j]).StyleName;
                 StyleManager.ApplyStyle(aControl, StyleName, true, LStyleName);
               end;
           end
         else
           StyleManager.ApplyStyle(aControl, StyleName, true);
      end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFaceController.StateChanged(aControl: TControl);
var
  s: TLMDStateList;
begin
  if FStyleManager = nil  then
    exit;
  s := LMDCFCfindState (controlDisabled   (aControl),
                        controlWrongData  (aControl),
                        controlFocused    (aControl),
                        controlReadOnly   (aControl),
                        controlMouseAbove (aControl),
                        controlPressed    (aControl),
                        controlModified   (aControl));
  ApplyStateStyle(aControl, s);
end;

end.
