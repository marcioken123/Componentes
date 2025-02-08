unit pLMDPeMain;
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

LMD-Tools Main Controls Property Editors (RM)
---------------------------------------------
Centralized unit for all LMD-Tools Main Controls property editors.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Classes, Sysutils, Dialogs, Graphics, TypInfo, Forms, ImgList,
  LMDBase, LMDClass, LMDButtonBar, LMDNoteBook, LMDAssist, LMDCustomMMButton,
  LMDVldBase, LMDRegExpr, LMDShadow, pLMDVldRegExpEditor, 
  LMDCustom3DButton, LMDCustomImageList;

type

  {LMD-Tools related objects}
  {****************************************************************************}
  {----------------------------------------------------------------------------}
  TLMDAssistPageProperty = class(TComponentProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonFaceProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCaptionProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLEDProperty= class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDShadowProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDShapeProperty = class(TEnumProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDShapeFillProperty = class(TClassProperty,ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDSimpleBevelProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDTeethProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDDateListProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  // 4.01
  {----------------------------------------------------------------------------}
  TLMDRegionMaskProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFilterProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDPointListProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLightColorProperty = class(TEnumProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDVldRegExprProperty = class(TPropertyEditor)
  protected
    FEditorForm: TLMDRegExprForm;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    destructor Destroy; override;

    function GetValue: string; override;
    procedure SetValue(const Value: string); override;

    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  // 6.0
  {----------------------------------------------------------------------------}
  TLMDNoteBookPageProperty = class(TComponentProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {----------------------------------------------------------------------------}
  //7.0
  TLMDPanelCaptionProperty=class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  procedure LMDCPGetButtonFaceMM(aComponent: TComponent; aList:TCustomImageList);

implementation
uses
  DesignConst, IStreams, StFilSys, ToolsApi,
  Consts, StdCtrls, ExtCtrls, Buttons, Controls, Registry, Extdlgs,
  pLMDCPGetMain, pLMDCEMain, LMDGraph, LMDButtonBase,
  LMDShapeFill, LMDShape, LMDSimpleBevel, LMDTeeth, LMDRegionMask,
  LMDLEDCustomLabel, LMDLED, LMDCustomLight, LMDMMButtonFaceController,

  //LMD3DCaption,
  //LMDFXCaption,
  LMDCaption,
  //LMDSmallBar,
  //LMDBitmapEffectObject,

  LMDUtils, LMDProcs,
  LMDDatel, { Calendar/DateList }
  LMDPointList,
  //LMDFormStyler,

  pLMDLEDEditorDlg, pLMDFilterPropertyEditorDlg, pLMDMMButtonFaceEditorDlg

  ;

{LMD-Tools related objects}
{********************* TLMDAssistPageEditor ***********************************}
{------------------------------------------------------------------------------}
function TLMDAssistPageProperty.GetAttributes: TPropertyAttributes;
begin
  result:=[paValueList];
end;

{------------------------------------------------------------------------------}
procedure TLMDAssistPageProperty.GetValues(Proc: TGetStrProc);
var
  i:Integer;
begin
  with TLMDAssist(GetComponent(0)) do
    for i:=0 to Pred(Count) do Proc(Page[I].Name);
end;

{********************* Class TLMDButtonFaceProperty ***************************}
{------------------------------------------------------------------------------}
procedure TLMDButtonFaceProperty.Edit;
var
  PropInfo:PPropInfo;
  tmp:TComponent;
  //tmpL:TCustomImageList;
begin
  tmp:=TComponent(GetComponent(0));
  if tmp is TLMDCustom3DButton then
    LMDCPGetButtonFace3D(TLMDCustom3DButton(GetComponent(0)))
  else
    begin
      // 7.0 --> modified to work with any kind of ButtonFace supporting control
      PropInfo:=TypInfo.GetPropInfo(tmp.ClassInfo,'ButtonFaceImageList');
      if (PropInfo<>nil) and
         (PropInfo^.PropType^.Kind=tkClass) then
        LMDCPGetButtonFaceMM(tmp, TLMDCustomImageList(GetObjectProp(GetComponent(0), PropInfo)))
      else
        ; // do nothing (for now - situation should not happen either)
    end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonFaceProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{********************* Class TLMDCaptionProperty ******************************}
{------------------------------------------------------------------------------}
procedure TLMDCaptionProperty.Edit;
var
  aG:TLMDCaption;
begin
  aG:=TLMDCaption.Create;
  try
    aG.Assign(TLMDCaption(Pointer(GetOrdValue)));
    if LMDCPGetLMDCaption(aG, True) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDLEDProperty***********************************}
{------------------------------------------------------------------------------}
procedure TLMDLEDProperty.Edit;
var
  GEditor: TLMDLEDEditorDlg;
  tmp:TComponent;
begin
  GEditor := TLMDLEDEditorDlg.Create(nil);
  with GEditor do
    try
      test.LED.Assign(TLMDLED(Pointer(GetOrdValue)));
      tmp:=TComponent(GetComponent(0));
      if tmp is TLMDLEDCustomLabel then
        with TLMDLEDCustomLabel(tmp) do
          begin
            test.Transparent:=Transparent;
            test.Color:=Color;
          end;
      SetLabels;
      if Showmodal=mrOK then
        SetOrdValue(Longint(Pointer(test.LED)));
        finally
      GEditor.Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDLEDProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDShadowProperty *******************************}
{------------------------------------------------------------------------------}
procedure TLMDShadowProperty.Edit;
var
  aG:TLMDShadow;
begin
  aG:=TLMDShadow.Create;
  try
    aG.Assign(TLMDShadow(Pointer(GetOrdValue)));
    if LMDCPGetShadow(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  ACanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDShadow(Pointer(GetOrdValue)) do
  ACanvas.TextOut (ARect.Left+1, ARect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDShadowProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDShapeFillProperty ****************************}
{------------------------------------------------------------------------------}
procedure TLMDShapeFillProperty.Edit;
var
  aG:TLMDShapeFill;
begin
  aG:=TLMDShapeFill.Create;
  try
  aG.Assign(TLMDShapeFill(Pointer(GetOrdValue)));
    if LMDCPGetShapeFill(aG) then
      SetOrdValue(LongInt(Pointer(aG)));
  finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFillProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  ACanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDShapeFill(Pointer(GetOrdValue)) do
  ACanvas.TextOut (ARect.Left+1, ARect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFillProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDShapeFillProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDShapeProperty ********************************}
{------------------------------------------------------------------------------}
procedure TLMDShapeProperty.Edit;
begin
  SetOrdValue(longint(LMDCPGetShape(TLMDShapeType(GetOrdValue))));
end;

{------------------------------------------------------------------------------}
function TLMDShapeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paValueList, paRevertable];
end;

{********************* Class TLMDSimpleBevelProperty **************************}
{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelProperty.Edit;
var
  aG:TLMDSimpleBevel;
begin
  aG:=TLMDSimpleBevel.Create;
  try
    aG.Assign(TLMDSimpleBevel(Pointer(GetOrdValue)));
    if LMDCPGetSimpleBevel(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSimpleBevelProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDTeethProperty ********************************}
{------------------------------------------------------------------------------}
procedure TLMDTeethProperty.Edit;
var
  aG:TLMDTeeth;
begin
  aG:=TLMDTeeth.Create;
  try
    aG.Assign(TLMDTeeth(Pointer(GetOrdValue)));
    if LMDCPGetTeeth(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTeethProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDDateListProperty *****************************}
{------------------------------------------------------------------------------}
procedure TLMDDateListProperty.Edit;
var
  dl : TLMDDateList;
begin
   dl:= (TLMDDateList(Pointer(GetOrdValue)));
   if LMDCPGetDateList (dl) then
     SetOrdValue(Longint(Pointer(dl)));
   end;

{------------------------------------------------------------------------------}
function TLMDDateListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMaskProperty.Edit;
var
  ar:TLMDRegionMask;
  b:boolean;
begin

  ar := TLMDRegionMask.Create;
  try
    ar.Assign (TLMDRegionMask(Pointer(GetOrdValue)));
    if GetComponent(0).Classname = 'TLMDRegion' then
      b := false
    else
      b := true;
    if LMDCPGetRegionMask (ar, b) then
      SetOrdValue(Longint(Pointer(ar)));
      finally
    ar.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRegionMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDFilterProperty.Edit;
var
  Filter:string;
  FilterEditor: TLMDFilterPropsDlg;
begin
  Filter := GetStrValue;
  FilterEditor := TLMDFilterPropsDlg.Create(Application);
  try
    FilterEditor.Filter := Filter;
    if FilterEditor.ShowModal=mrOk then SetStrValue(FilterEditor.Filter);
  finally
    FilterEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFilterProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------- TLMDPointListProperty ------------------------------------}
procedure TLMDPointListProperty.Edit;
var
  pl : TLMDPointList;
begin
  pl:= (TLMDPointList(Pointer(GetOrdValue)));
  if LMDCPGetPointList (pl) then
    SetOrdValue(Longint(Pointer(pl)));
  end;

{------------------------------------------------------------------------------}
function TLMDPointListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

// 6.0
{********************* TLMDNoteBookPageEditor *********************************}
{------------------------------------------------------------------------------}
function TLMDNoteBookPageProperty.GetAttributes: TPropertyAttributes;
begin
  result:=[paValueList];
end;

{------------------------------------------------------------------------------}
procedure TLMDNoteBookPageProperty.GetValues(Proc: TGetStrProc);
var
  i:Integer;
begin
  with TLMDNoteBook(GetComponent(0)) do
    for i:=0 to Pred(Count) do Proc(Page[I].Name);
end;

{------------------------------------------------------------------------------}
procedure TLMDLightColorProperty.Edit;
begin
  SetOrdValue(longint(LMDCPGetLightColor(TLMDLightColor(GetOrdValue))));
end;

{------------------------------------------------------------------------------}
function TLMDLightColorProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paValueList, paRevertable];
end;

// 7.0
{********************TLMDPanelCaptionProperty**********************************}
{------------------------------------------------------------------------------}
function TLMDPanelCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paMultiSelect];
end;

{******************** TLMDVldRegExprProperty **********************************}
{------------------------------------------------------------------------------}
function TLMDVldRegExprProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
function TLMDVldRegExprProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDVldRegExprProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{------------------------------------------------------------------------------}
constructor TLMDVldRegExprProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited;
  Self.FEditorForm := TLMDRegExprForm.Create(nil);
end;

{------------------------------------------------------------------------------}
destructor TLMDVldRegExprProperty.Destroy;
begin
  Self.FEditorForm.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDVldRegExprProperty.Edit;
var
  res: string;
begin
  res := Self.FEditorForm.EditExpression(GetStrValue);
  SetStrValue(res);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDCPGetButtonFaceMM(aComponent: TComponent; aList:TCustomImageList);
var
  LMDButtonFaceDlg:TLMDButtonFaceDlg;

  procedure GetFaceIndices;
  begin
    if aComponent is TLMDCustomMMButton then
      TLMDCustomMMButton(aComponent).GetButtonFaceIndices(LMDButtonFaceDlg.FTempIndices);
    if aComponent is TLMDMMButtonFaceController then
      TLMDMMButtonFaceController(aComponent).GetButtonFaceIndices(LMDButtonFaceDlg.FTempIndices);
    LMDMMCopyFace(LMDButtonFaceDlg.FIndices, LMDButtonFaceDlg.FTempIndices);
  end;

begin
  if (aList=nil) then
    begin
      showmessage('Can''t run Editor because no ButtonFaceImageList is selected.');
      exit;
    end;
  if (aComponent is TLMDCustomMMButton) and (TLMDCustomMMButton(aComponent).ButtonFaceController<>nil) then
    begin
      showmessage('Can''t run Editor because control is connected to a ButtonFaceController component.');
      exit;
    end;

  LMDButtonFaceDlg:=TLMDButtonFaceDlg.Create(nil);
  with LMDButtonFaceDlg do
    try
      FImageList:=aList;

      // this could be nicer!!!
      GetFaceIndices;
      ShowModal;
      if ModalResult=mrOK then
        begin
          if aComponent is TLMDMMButtonFaceController then
            begin
              TLMDMMButtonFaceController(aComponent).SetButtonFaceIndices(FIndices);
              TLMDMMButtonFaceController(aComponent).SetTransCol;
            end;
          if aComponent is TLMDCustomMMButton then
            begin
              TLMDCustomMMButton(aComponent).SetButtonFaceIndices(FIndices);
              TLMDCustomMMButton(aComponent).SetTransCol;
            end
        end;
    finally
      free;
    end;
end;

end.
