unit pLMDCEMain;
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

LMD-Tools Main Controls Component Editors (RM)
---------------------------------------------
Centralized unit for all LMD-Tools Main Controls component editors.

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

  {$R pLMDCEMain.RES}

uses
  DesignIntf, DesignEditors, VCLEditors, DesignMenus, ColnEdit,
  Classes, Sysutils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, Menus, ComCtrls,
  pLMDCECore, pLMDCEX, pLMDGlobalEditors,
  LMDNotebook, LMDPageControl, LMDCustomSheetControl,
  LMDCaptionPanelGroup, LMDAssist, LMDClass, LMDCont;

type

  {----------------------------------------------------------------------------}
  TLMDAniCtrlComponentEditor = class(TLMDCustomLImageComponentEditor)
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDAssistComponentEditor = class(TComponentEditor)
  private
    FInternal:Byte;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDExtGraphicButtonComponentEditor = class(TLMDBaseGraphicButtonComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  // 7.0
  {----------------------------------------------------------------------------}
  TLMDButtonFaceControllerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDClockComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCustomShapeComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSwitchComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLightComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFaceControllerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFillComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFormFillComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFormStylerComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDHideNonVCEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLabelFillComponentEditor = class(TLMDLabelComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLEDLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDShapeHintComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDShadowComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  //6.0
  {----------------------------------------------------------------------------}
  TLMDDlgButtonComponentEditor = class(TLMDSimplePanelComponentEditor)
  private
    FNew:Byte;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  //6.0
  {----------------------------------------------------------------------------}
  TLMDNoteBookComponentEditor = class(TComponentEditor)
  private
    function GetNoteBook:TLMDCustomSheetControl;
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDTechnicalLineComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDGraphicLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDMessageBoxComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDScrollTextComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonBarCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass:TCollectionEditorClass; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonBarCollectionEditor = class(TLMDCollectionItemsEditor)
  protected
    function GetWorkCollection(index:Integer):TCollection;override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonBarComponentEditor = class(TDefaultEditor)
  protected // 6.0
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDExtDlgEditor = class(TLMDDlgEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFormShapeComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDWndButtonShapeComponentEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDPanelShapeComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  // 7.0
  {----------------------------------------------------------------------------}
  TLMDCaptionPanelGroupEditor = class(TComponentEditor)
  private
    FComponent:TControl;
    function GetGroupControl:TLMDCaptionPanelGroup;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSendKeyComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFilterComponentEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function LMDCPIsDBControl(aValue:TComponent):Boolean;
// loads and saves Delphi/CBuilder custom colors list
function LMDCPGetColorCP(aColor:TColor):TColor;

implementation
uses
  ToolsApi, Contnrs, ImgList,
  pLMDPECst, pLMDPEMain, pLMDCommon, pLMDCPGetMain,
  LMDBase, LMDGraph, LMDLED, LMDClock, LMDMsg, LMDCustomImageList, LMDFormShape,
  LMDBaseDialog, LMDBrowseDlg, LMDCustomFormFill, LMDFormShadow, LMDBack,
  LMDFormStyler, LMDLEDCustomLabel, LMDHideNonVC, pLMDCPGetCore, LMDFormA, LMDFaceController,
  pLMDHideNonVC,LMDGrlf, LMDCustomLabel, LMDCustomLabelFill,
  LMDBaseShape, LMDCustom3DButton, LMDShadowFill, LMDTechnicalLine, LMDCustomBevelPanel,
  LMDGraphicLabel, LMDScrollText, LMDFormFill, LMDCustomMMButton,
  LMDDlgButtonPanel, LMDButtonBar, LMDRegion, LMDWndButtonShape, LMDPanelShape,
  LMDSendKeys, LMDCustomSwitch, LMDCustomLight, LMDMMButtonFaceController,
  LMDCaptionPanel, LMDMMButton, LMDCustomCheckListDlg, LMDCustomShapeHint, LMDShapeHint, LMDAniCtrl,
  LMDBaseGraphicButton, LMDFill,

  pLMDDsgnCPGetX, pLMDCPGetBase, pLMDPeCore,
  // 8.0
  pLMDControlFaceEditorDlg,

  pLMDDlgBtnEditorDlg, pLMDButtonBarEditorDlg, pLMDSendKeyEditorDlg,
  pLMDFilterPropertyEditorDlg, pLMDGraphicLabelEditorDlg;

{procedure LMDWriteComponent (component : TComponent);
var
  f : TFileStream;
  i : Integer;
begin
  i := 0;
  while fileexists (component.ClassName+'_'+IntToStr(i)+'.template') do
    inc(i);
  f := TFileStream.Create (component.ClassName+'_'+IntToStr(i)+'.template', fmCreate);
  try
    f.WriteComponent (component);
  finally
    f.Free;
  end;
end;}

{procedure LMDSelectComponentTemplate (component : TComponent);
var
  cst : TfrmTLMDComponentSelectorDlg;
  comp : TComponent;
begin
  cst := TfrmTLMDComponentSelectorDlg.Create(nil);
  try
    cst.init (component.className);
    if cst.ShowModal = mrOk then
      if (cst.componentList.Selected <> nil) and (cst.componentList.Selected.Data <> nil) then
        begin
          comp := cst.componentList.Selected.Data;
          Component.Assign (comp);
        end;
  finally
    cst.Free;
  end;
end;}

{helper to determine if special control is datasensitive, works
 only with TLMDDB-controls :-) }
{------------------------------------------------------------------------------}
function LMDCPIsDBControl(aValue:TComponent):Boolean;
begin
  result:=Pos('TLMDDB', aValue.ClassName)>0;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetColorCP(aColor:TColor):TColor;
var
  tmp:TStringList;
begin
 tmp:=TStringList.Create;
 try
   LMDComLoadDelphiCustomColor(tmp);
   result:=LMDCPGetColor(aColor, tmp);
   if result<>aColor then
     LMDComSaveDelphiCustomColor(tmp);
 finally
   tmp.Free;
 end;
end;

{********************** Class TLMDAniControlEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDAniCtrlComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDAniCtrl(Component) do
    case Index of
      0..4:inherited;
      5:TLMDAniCtrl(Component).Animate:=not TLMDAniCtrl(Component).Animate;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrlComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0..4:result:=inherited GetVerb(Index);
    5:result:='Animate'+Boolstr[TLMDAniCtrl(Component).Animate];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrlComponentEditor.GetVerbCount: Integer;
begin
  Result:=6;
end;

{************************ TLMDAssistComponentEditor ***************************}
{------------------------------------------------------------------------------}
procedure TLMDAssistComponentEditor.ExecuteVerb(Index: Integer);
var
  tmp:TLMDAssist;
begin

  //tmp:=nil;
  if Component is TLMDAssist then tmp:=TLMDAssist(Component)
  else if Component is TLMDAssistPage then tmp:=TLMDAssistPage(Component).AssistControl
  else exit;

  if FInternal=1 then index:=4;

  with tmp do
    begin
      case Index of
        4:with TLMDAssistPage.Create(Designer.Root)do
            try
              Name:=Designer.UniqueName(ClassName);
              AssistControl:=tmp;
            except
              Free;
              raise;
            end;
        0:if ActivePage.PageIndex=Pred(Count) then ActivePage:=Page[0] else ActivePage:=Page[ActivePage.PageIndex+1];
        1:if ActivePage.PageIndex=0 then ActivePage:=Page[Pred(Count)] else ActivePage:=Page[ActivePage.PageIndex-1];
        2:FirstPage;
        3:LastPage;
      end;

      Designer.Modified;
      if (ActivePage<>nil) then
        Designer.SelectComponent(ActivePage);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDAssistComponentEditor.GetVerb(Index: Integer): String;
begin
  if FInternal=1 then index:=4;
  case index of
    0:result:='Ne&xt Page';
    1:result:='&Previous Page';
    2:result:='&First Page';
    3:result:='&Last Page';
    4:result:='&New Page'
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAssistComponentEditor.GetVerbCount: Integer;
begin
  FInternal:=0;
  if ((Component is TLMDAssist) and (TLMDAssist(Component).Count>1)) or
     ((Component is TLMDAssistPage) and (TLMDAssistPage(Component).AssistControl.Count>1)) then
    result:=5
  else
    begin
       FInternal:=1;
       result:=1;
    end;
end;

{************* Class TLMDExtGraphicButtonComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDExtGraphicButtonComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  if (Component is TLMDCustom3DButton) or (Component is TLMDMMButton) then Dec(index);
  with TLMDBaseGraphicButton(Component) do
    case Index of
     -1: if Component is TLMDMMButton then
           begin
              if (TLMDMMButton(Component).ButtonFaceImageList=nil) or
                 (LMDIMLCount(TLMDMMButton(Component).ButtonFaceImageList)=0) then
                begin
                  t1:=ListIndex;
                  t2:=ImageIndex;
                  t3:=TLMDMMButton(Component).ButtonFaceImageList;
                  if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
                  TLMDMMButton(Component).ButtonFaceImageList:=t3;
                end
              else
                LMDCPGetButtonFaceMM(Component, TLMDMMButton(Component).ButtonFaceImageList)
           end
         else
           LMDCPGetButtonFace3D(TLMDCustom3DButton(Component));
    else
      inherited;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDExtGraphicButtonComponentEditor.GetVerb(Index: Integer): string;
begin
  if (Component is TLMDCustom3DButton) or (Component is TLMDMMButton) then Dec(index);
  case index of
    -1: if (Component is TLMDMMButton) then
          begin
            result:='ButtonFace';
            if (TLMDMMButton(Component).ButtonFaceImageList=nil) or
               (TLMDMMButton(Component).ButtonFaceImageList.Count=0) then
              result:='Select '+result
            else
              result:='ButtonFace';
          end
        else
          result:='Button-Editor';
  else
    result:=inherited GetVerb(Index);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDExtGraphicButtonComponentEditor.GetVerbCount: Integer;
begin
  result:=inherited GetVerbCount;
  if (Component is TLMDCustom3DButton) or
     (Component is TLMDMMButton) then Inc(result);
end;

{***************** Class TLMDButtonFaceControllerEditor ***********************}
{------------------------------------------------------------------------------}
procedure TLMDButtonFaceControllerEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;

begin
  if (TLMDMMButtonFaceController(Component).ButtonFaceImageList=nil) or (Index=1) then
    begin
      t1:=0;
      t2:=0;
      t3:=TLMDMMButtonFaceController(Component).ButtonFaceImageList;
      if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
      TLMDMMButtonFaceController(Component).ButtonFaceImageList:=t3;
      Designer.Modified;
      exit;
    end;
  LMDCPGetButtonFaceMM(Component, TLMDMMButtonFaceController(Component).ButtonFaceImageList);
end;

{------------------------------------------------------------------------------}
function TLMDButtonFaceControllerEditor.GetVerb(Index: Integer): string;
begin
  if (TLMDMMButtonFaceController(Component).ButtonFaceImageList=nil) then Inc(index);
  case index of
    0: result:='ButtonFace-Editor';
    1: result:='Select ButtonFaceImageList';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonFaceControllerEditor.GetVerbCount: Integer;
begin
  Result:=2;
  if TLMDMMButtonFaceController(Component).ButtonFaceImageList=nil then Dec(result);
end;

// 6.0
{********************* Class TLMDDlgButtonComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDDlgButtonComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index>=FNew then
    inherited ExecuteVerb(index-FNew)
  else
    with TLMDDlgButtonEditorDlg.Create(nil) do
      try
        BtnPanel:=TLMDDlgButtonPanel(Component);
        FForm:=TCustomForm(self.Designer.Root);
        nb.PageIndex:=Index;
        case Index of
          0:begin
              // Insert Buttons
              GetIniSettings;
              if ShowModal = mrOk then
                begin
                  SetIniSettings;
                  self.Designer.Modified;
                end;
            end;
          1:begin
              nb.PageIndex:=1;  // Change Button order
              lbfill;
              if ShowModal = mrOk then
                begin
                  self.Designer.Modified;
                end;
            end;
        end;
     finally
       Free;
     end;
end;

{------------------------------------------------------------------------------}
function TLMDDlgButtonComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index>=FNew then
    result:=inherited GetVerb(Index-FNew)
  else
    case index of
      0:result:='Add Buttons...';
      1:result:='Change Button Order...';
      2:result:='-';
    end;
end;

{------------------------------------------------------------------------------}
function TLMDDlgButtonComponentEditor.GetVerbCount: Integer;
begin
  FNew:=3;
  result:=inherited GetVerbCount+FNew;
end;

//6.0
{************************ TLMDNoteBookComponentEditor *************************}
{------------------------------------------------------------------------------}
function TLMDNoteBookComponentEditor.GetNoteBook:TLMDCustomSheetControl;
begin
  result:=nil;
  if Component is TLMDCustomSheetControl then
    result:=TLMDCustomSheetControl(Component)
  else
    if Component is TLMDCustomSheet then result:=TLMDCustomSheet(Component).SheetControl
end;

{------------------------------------------------------------------------------}
procedure TLMDNoteBookComponentEditor.ExecuteVerb(Index: Integer);
var
  tmp:TLMDCustomSheetControl;
begin
  tmp:=GetNoteBook;
  if tmp=nil then exit;

  with tmp do
    begin
      case Index of
        0:Designer.SelectComponent(tmp);
        1: with tmp.GetSheetClass.Create(self.Designer.Root) do
            try
              Name:=Designer.UniqueName(ClassName);
              SheetControl:=tmp;
            except
              Free;
              raise;
            end;
      else
        ActiveSheet:=tmp.Sheet[index-3]
      end;

      Designer.Modified;
      if (Index>0) and (ActiveSheet<>nil) then
        Designer.SelectComponent(ActiveSheet);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDNoteBookComponentEditor.GetVerb(Index: Integer): String;
begin
  case index of
    0:result:='Select Control';
    1:result:='&New Page';
    2:result:='-';
  else
    result:='Display Page '+GetNoteBook.Sheet[index-3].Name;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDNoteBookComponentEditor.GetVerbCount: Integer;
var
  tmp:TLMDCustomSheetControl;
begin
  result:=3;
  tmp:=GetNoteBook;
  if tmp=nil then exit;
  if tmp.Count>1 then Inc(result,tmp.Count);
end;

{****************** Class TLMDClockComponentEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDClockComponentEditor.ExecuteVerb(Index: Integer);
var
  s: string;
begin
  with TLMDClock(Component) do
    case Index of
      0:if not LMDCPGetBevel(Bevel) then exit;
      1:if not LMDCPGetLED(Digital) then exit;
      2:DigitalOnly:=not DigitalOnly;
      3:begin
          s := CustomDateTimeFormat;
          if not LMDCPGetDateTimeFormat (s) then exit;
          CustomDateTimeFormat := s;
        end;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDClockComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Bevel';
    1: result:='Digital';
    2: result:='Digital'+'Only'+BoolStr[TLMDClock(Component).DigitalOnly];
    3: result:='CustomDateTimeFormat';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDClockComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
  if Component is TLMDCustomLabel then Inc(result);
end;

{********************* Class TLMDCustomShapeComponentEditor *******************}
{------------------------------------------------------------------------------}
procedure TLMDCustomShapeComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDBaseShape(Component) do
    case Index of
      0: if not (TLMDBaseShape(Component).Teeth=nil) then
           begin
             if not LMDCPGetTeeth(Teeth) then exit
           end
         else
           shape:=LMDCPGetShape(Shape);
      1: if not LMDCPGetBrush(Brush) then exit;
      2: if not LMDCPGetLMDCaption(Caption, True) then exit;
      3: if not LMDCPGetShadow(Shadow) then exit;
      4: Square:=not Square;
      5: if (Mode=scmTeethFill) then
           begin
             if not LMDCPGetShapeFill(TLMDBaseShape(Component).ShapeFill) then exit
           end
         else
           if not LMDCPGetSimpleBevel(Bevel) then exit;
      6: if not LMDCPGetShapeFill(TLMDBaseShape(Component).ShapeFill) then exit

    end;
  Designer.Modified;

end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: if not (TLMDBaseShape(Component).Teeth=nil) then
         result:='Teeth'
       else
         result:='Shape';
    1: Result:='Brush';
    2: Result:='Caption';
    3: Result:='Shadow';
    4: Result:='Square' + Boolstr[TLMDBaseShape(Component).Square];
    5: if TLMDBaseShape(Component).Mode= scmTeethFill then
         Result:='ShapeFill'
       else
         Result:='Bevel';
    6: Result:='ShapeFill';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeComponentEditor.GetVerbCount: Integer;
begin
  with TLMDBaseShape(Component) do
    if Mode=scmShapeFill then
      result:= 7
    else if not (Teeth=nil) then
      result:= 5
    else
      result:= 6;
end;

{********************* Class TLMDSwitchComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDSwitchComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDCustomSwitch(Component) do
    case Index of
      0:if not LMDCPIsDBControl(Component) then Checked:=not Checked;
      1:if not LMDCPGetBevel(Bevel) then exit;
      2:if not LMDCPGetLMDCaption(CaptionChecked, True) then exit;
      3:if not LMDCPGetLMDCaption(CaptionUnChecked, True) then exit;
      4:ColorChecked:=LMDCPGetColorCP(ColorChecked);
      5:ColorUnChecked:=LMDCPGetColorCP(ColorUnChecked);
      6:Enabled:=not Enabled;
    end;
  Designer.Modified;

end;

{------------------------------------------------------------------------------}
function TLMDSwitchComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: if LMDCPIsDBControl(Component) then
         result:='[DB] Option not available'
       else
         Result:='Checked' + BoolStr[TLMDCustomSwitch(Component).Checked];
    1: result:='Bevel';
    2: Result:='Caption Checked';
    3: Result:='Caption UnChecked';
    4: Result:='Color Checked';
    5: Result:='Color UnChecked';
    6: Result:='Enabled'+ BoolStr[TLMDCustomSwitch(Component).Enabled];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSwitchComponentEditor.GetVerbCount: Integer;
begin
  Result := 7;
end;

{********************* Class TLMDLightComponentEditor *************************}
{------------------------------------------------------------------------------}
procedure TLMDLightComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDCustomLight(Component) do
    case Index of
      0:if not LMDCPIsDBControl(Component) then active:= not active;
      1:if not LMDCPGetSimpleBevel(Bevel) then exit;
      2:LightColor:=LMDCPGetLightColor(LightColor);
      3:if Style=ltRound then Style:=ltRect else Style:=ltRound;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDLightComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:if LMDCPIsDBControl(Component) then result:='[DB] Not available' else result:='Active';
    1:result:='Bevel';
    2:result:='LightColor';
    3:if TLMDCustomLight(Component).Style=ltRound then
        result:='Style: ltRound'
      else
        result:='Style: ltRectangle';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDLightComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{********************* Class TLMDExtDlgEditor *********************************}
{------------------------------------------------------------------------------}
procedure TLMDExtDlgEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  case index of
    0 : if Component is TLMDBaseDialog then
          TLMDBaseDialog(Component).Execute
        else
          inherited ExecuteVerb(index);
    1 : with TLMDBaseDialog(Component) do
          begin
            t1:=ListIndex;
            t2:=ImageIndex;
            t3:=ImageList;
            if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
            ImageList:=t3;
            ListIndex:=t1;
            ImageIndex:=t2;
          end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDExtDlgEditor.GetVerb(Index: Integer): string;
begin
  case index of
    1: Result:='ImageList';
  else
    result:=inherited GetVerb(Index);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDExtDlgEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{*****************************TLMDFaceControllerEditor*************************}
{ ---------------------------------------------------------------------------- }
function LMDCPGetFaceSettings (Component: TLMDFaceController): boolean;
var
  FEditor: TfrmLMDControlFaceComponentEditor;
begin
  result:=false;
  FEditor:=TfrmLMDControlFaceComponentEditor.Create(nil);
  try
    with FEditor do
      begin
        FEditor.Edit (Component);
        if ShowModal = mrOk then
          begin
            Component.Assign (FEditor.EditFaceController);
            result := true;
          end;
      end;
  finally
    FEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFaceControllerEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0: LMDCPGetFaceSettings (TLMDFaceController(Component));
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFaceControllerEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result :='State settings';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFaceControllerEditor.GetVerbCount: Integer;
begin
  result:=1
end;

{********************* Class TLMDFillComponentEditor **************************}
{------------------------------------------------------------------------------}
procedure TLMDFillComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDFill(Component) do
    case Index of
      0:begin

          { store actual settings in temporary variables }
          t1:=ListIndex;
          t2:=ImageIndex;
          // ToDo RM
          t3:=TLMDCustomImageList(ImageList);

          if LMDCPGetIMLExt(Designer, t3, t1, t2) then
            begin
              { if Editor closed with OK set the values }
              ImageList := t3;
              ListIndex:=t1;
              ImageIndex:=t2;
            end;
        end;
      1:if not LMDCPGetFillObject(FillObject) then exit;
      2:if not LMDCPGetBevel(Bevel) then exit;
      3:if not LMDCPGetLMDCaption(Caption, True) then exit;
      4:Color:=LMDCPGetColorCP(Color);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='FillObject';
    2:result:='Bevel';
    3:result:='Caption';
    4:result:='Color';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFillComponentEditor.GetVerbCount: Integer;
begin
  Result:=5;
end;

{********************* Class TLMDFormFillComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDFormFillComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  with TLMDCustomFormFill(Component) do
    case Index of
      0:if Component is TLMDFormFill then
          begin
            if not LMDCPGetFillObject(TLMDFormFill(Component).FillObject) then exit;
          end
        else
          with TLMDBack(Component) do
             begin
               { store actual settings in temporary variables }
               t1:=ListIndex;
               t2:=ImageIndex;
               t3:=ImageList;
               if LMDCPGetIMLExt(Designer, t3, t1, t2) then
                 begin
                   { if Editor closed with OK set the values }
                   ImageList := t3;
                   ListIndex:=t1;
                   ImageIndex:=t2;
                 end;
             end;
      1:DefaultFill:=not DefaultFill;
      2:Enabled:=not Enabled;
      3:with TLMDFormFill(Component) do
          begin
            { store actual settings in temporary variables }
            t1:=ListIndex;
            t2:=ImageIndex;
            t3:=ImageList;
            if LMDCPGetIMLExt(Designer, t3, t1, t2) then
              begin
                { if Editor closed with OK set the values }
                ImageList := t3;
                ListIndex:=t1;
                ImageIndex:=t2;
              end;
          end;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFormFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:if Component is TLMDFormFill then
        result:='FillObject'
      else
        begin
          result:='ImageList';
{          if (TLMDBack(Component).ImageList=nil) or
             (TLMDBack(Component).ImageList.Count=0) then result:=result+PE[Ord(unavailable)];}
        end;
    1:result:='DefaultFill' + BoolStr[TLMDCustomFormFill(Component).DefaultFill];
    2:result:='Enabled' + BoolStr[TLMDCustomFormFill(Component).Enabled];
    3:begin
        result:='ImageList';
        {if (TLMDFormFill(Component).ImageList=nil) or
           (TLMDFormFill(Component).ImageList.Count=0) then result:=result+PE[Ord(unavailable)];}
      end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormFillComponentEditor.GetVerbCount: Integer;
begin
  Result:=3;
  if Component is TLMDFormFill then Inc(Result);
end;

{********************* Class TLMDFormStylerComponentEditor ********************}
{------------------------------------------------------------------------------}
procedure TLMDFormStylerComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFormStyler(Component) do
    case Index of
      0:Enabled:=not Enabled;
      1:if not LMDCPGetFont(Font) then exit;
      2:if not LMDCPGetFont3D(Font3D) then exit;
      3:if fsAdjustRect in Options then
          Options:=Options-[fsAdjustRect]
        else
          Options:=Options+[fsAdjustRect];
      4:if fsUseDefaultFont in Options then
          Options:=Options-[fsUseDefaultFont]
        else
          Options:=Options+[fsUseDefaultFont];
      5:if fsInactiveGradient in Options then
          Options:=Options-[fsInactiveGradient]
        else
          Options:=Options+[fsInactiveGradient];
      6:if fsDrawCaptionEvent in Options then
          Options:=Options-[fsDrawCaptionEvent]
        else
          Options:=Options+[fsDrawCaptionEvent];
      7:if fsUseFormCaption in Options then
          Options:=Options-[fsUseFormCaption]
        else
          Options:=Options+[fsUseFormCaption];
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFormStylerComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Enabled' + BoolStr[TLMDFormStyler(Component).Enabled];
    1:result:='Font';
    2:result:='Font3D';
    3:result:='AdjustRect' + BoolStr[fsAdjustRect in TLMDFormStyler(Component).Options];
    4:result:='UseDefaultFont' + BoolStr[fsUseDefaultFont in TLMDFormStyler(Component).Options];
    5:result:='InactiveGradient' + BoolStr[fsInactiveGradient in TLMDFormStyler(Component).Options];
    6:result:='DrawCaptionEvent' + BoolStr[fsDrawCaptionEvent in TLMDFormStyler(Component).Options];
    7:result:='UseFormCaption' + BoolStr[fsUseFormCaption in TLMDFormStyler(Component).Options];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormStylerComponentEditor.GetVerbCount: Integer;
begin
  Result:=8;
end;

{****************** Class TLMDHideNonVCEditor *********************************}
{------------------------------------------------------------------------------}
procedure TLMDHideNonVCEditor.ExecuteVerb(Index: Integer);
begin

  if LMDHideNonVCfrm = nil then
    LMDHideNonVCfrm := TLMDHideNonVCfrm.Create(Application);
  LMDHideNonVCfrm.Designer:=self.Designer;
  with LMDHideNonVCfrm do
    begin
      DComponent:=TLMDHideNonVC(Component);
      Initialize;
      Show;
      UpdateSelection;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Editor';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDHideNonVCEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

{********************* Class TLMDLabelFillComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDLabelFillComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDCustomLabelFill(Component) do
    case Index of
      0..6:inherited ExecuteVerb(Index);
      7:if not LMDCPGetFillObject(TLMDCustomLabelFill(Component).FillObject) then exit;
      8:BrushBackColor:=LMDCPGetColorCP(BrushBackColor);
      9:begin
          { store actual settings in temporary variables }
          t1:=ListIndex;
          t2:=ImageIndex;
          // ToDo RM
          t3:=TLMDCustomImageList(ImageList);
          if LMDCPGetIMLExt(Designer, t3, t1, t2) then
            begin
              { if Editor closed with OK set the values }
              ImageList := t3;
              ListIndex:=t1;
              ImageIndex:=t2;
            end;
        end;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDLabelFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0..6:result:=inherited GetVerb(Index);
    7:result:='FillObject';
    8:result:='BrushBackColor';
    9:result:='ImageList';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDLabelFillComponentEditor.GetVerbCount: Integer;
begin
  Result:=inherited GetVerbCount+2;
end;

{****************** Class TLMDLEDLabelComponentEditor *************************}
{------------------------------------------------------------------------------}
procedure TLMDLEDLabelComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDLEDCustomLabel(Component) do
    case Index of
      0:if not LMDCPIsDBControl(Component) then Caption:=LMDCPGetCaption(Caption, -1) else exit;
      1:AutoSize:=not AutoSize;
      2:if not LMDCPGetBEvel(Bevel) then exit;
      3:if not LMDCPGetLED(LED) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDLEDLabelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: if LMDCPIsDBControl(Component) then result:='[DB] No caption available' else result:='Caption';
    1: Result:='AutoSize'+BoolStr[TLMDLEDCustomLabel(Component).AutoSize];
    2: Result:='Bevel';
    3: Result:='LED';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDLEDLabelComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{********************* Class TLMDShapeHintComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDShapeHintComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDShapeHint(Component) do
    case Index of
      0:BorderColor:=LMDCPGetColorCP(BorderColor);
      1:Color:=LMDCPGetColorCP(Color);
      2:Enabled:=not Enabled;
      3:if not LMDCPGetFont(Font) then exit;
      4:if not LMDCPGetFont3D(Font3D) then exit;
      5:if not LMDCPGetShadow(Shadow) then exit;
    end;
  Designer.Modified;

end;

{------------------------------------------------------------------------------}
function TLMDShapeHintComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='BorderColor';
    1: Result:='Color';
    2: Result:='Enabled' + BoolStr[TLMDCustomShapeHint(Component).Enabled];
    3: Result:='Font';
    4: Result:='Font3D';
    5: Result:='Shadow';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShapeHintComponentEditor.GetVerbCount: Integer;
begin
  Result := 6;
end;

{********************* Class TLMDShadowComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDShadowComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFormShadow(Component) do
    case Index of
      0:if not LMDCPGetShadow(Shadow) then exit;
      1:ShowInactive:=not ShowInactive;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDShadowComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='Shadow';
    1: Result:='ShowInActive ' + BoolStr[TLMDFormShadow(Component).ShowInActive];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShadowComponentEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{******************* class TLMDTechnicalLineComponentEditor *******************}
function TLMDTechnicalLineComponentEditor.GetVerb (Index : Integer) : String;
begin
  Case Index Of
    0 : If (Component as TLMDTechnicalLine).Arrowed Then
          Result := 'Arrowed [True]'
        Else
          Result := 'Arrowed [False]';
    1 :  If (Component as TLMDTechnicalLine).ShadowVisible Then
          Result := 'Shadowed [True]'
        Else
          Result := 'Shadowed [False]';
    2 : Result := 'Arrow Right';
    3 : Result := 'Arrow Left';
    4 : Result := 'Arrow Up';
    5 : Result := 'Arrow Down';
  End;
end;

{------------------------------------------------------------------------------}
function TLMDTechnicalLineComponentEditor.GetVerbCount : Integer;
begin
  Result := 6;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLineComponentEditor.ExecuteVerb(Index : Integer);
begin
  Case Index Of
    0 : (Component as TLMDTechnicalLine).Arrowed := ((Component as TLMDTechnicalLine).Arrowed = False);
    1 : (Component as TLMDTechnicalLine).ShadowVisible := ((Component as TLMDTechnicalLine).ShadowVisible = False);
    2 : begin
          (Component as TLMDTechnicalLine).LineType := (lsStraightLeftToRight);
          (Component as TLMDTechnicalLine).SignPlaces := (spEnd);
          (Component as TLMDTechnicalLine).LineEndingSign := (leOpenArrowRight);
        end;
    3 : begin
          (Component as TLMDTechnicalLine).LineType := (lsStraightLeftToRight);
          (Component as TLMDTechnicalLine).SignPlaces := (spStart);
          (Component as TLMDTechnicalLine).LineStartSign := (leOpenArrowLeft);
        end;
    4 : begin
          (Component as TLMDTechnicalLine).LineType := (lsStraightTopToBottom);
          (Component as TLMDTechnicalLine).SignPlaces := (spStart);
          (Component as TLMDTechnicalLine).LineStartSign := (leOpenArrowUp);
        end;
    5 : begin
          (Component as TLMDTechnicalLine).LineType := (lsStraightTopToBottom);
          (Component as TLMDTechnicalLine).SignPlaces := (spEnd);
          (Component as TLMDTechnicalLine).LineEndingSign := (leOpenArrowDown);
        end;
  End;
  Designer.Modified;
end;

{******************* class TLMDGraphicLabelComponentEditor ********************}
function TLMDGraphicLabelComponentEditor.GetVerb (Index : Integer) : String;
begin
  Case Index Of
    0 : Result := 'Editor';
    1 : Result := '-';
    2 : Result := 'Wave';
    3 : Result := 'Normal';
    4 : If (Component as TLMDGraphicLabel).AutoSize Then
          Result := 'AutoSize [True]'
        else
          Result := 'AutoSize [False]';
    5 : Result := 'FillObject';
    6 : Result := 'Font';
    7 : Result := 'FontFX';
    8 : If (Component as TLMDGraphicLabel).Perspective = tpBird Then
          Result := 'Perspective (tpBird)'
        else
          Result := 'Perspective (tpFrog)';

  End;
end;
{------------------------------------------------------------------------------}
function TLMDGraphicLabelComponentEditor.GetVerbCount : Integer;
begin
  If taPerspective In (Component as TLMDGraphicLabel).Attributes Then
    Result := 9
  else
    Result := 8;
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicLabelComponentEditor.ExecuteVerb(Index : Integer);
begin
  Case Index Of
    0 : with TLMDFormGraphicLabelEditor.Create(Application) do
          try
            Hide;
            SetValue ((Component as TLMDGraphicLabel));
            if ShowModal = mrOk Then
              (Component as TLMDGraphicLabel).Assign (LMDGraphicLabel);
          finally
            Free;
          end;
    2 : (Component as TLMDGraphicLabel).Transform := tmWave;
    3 : (Component as TLMDGraphicLabel).Transform := tmNone;
    4 : (Component as TLMDGraphicLabel).Autosize := ( (Component as TLMDGraphicLabel).AutoSize = False);
    5 : if not LMDCPGetFillObject((Component as TLMDGraphicLabel).FillObject) then exit;
    6 : if not LMDCPGetFont((Component as TLMDGraphicLabel).Font) then exit;
    7 : if not LMDCPGetFontFX((Component as TLMDGraphicLabel).FontFX) then exit;
    8 : If (Component as TLMDGraphicLabel).Perspective = tpBird Then
           (Component as TLMDGraphicLabel).Perspective := tpFrog
        else
           (Component as TLMDGraphicLabel).Perspective := tpBird;
  End;
  Designer.Modified;
end;

{******************* class TLMDMessageBoxComponentEditor ********************}
function TLMDMessageBoxComponentEditor.GetVerb (Index : Integer) : String;
begin
  Case Index Of
    0 : Result := 'Demo';
  End;
end;

{------------------------------------------------------------------------------}
function TLMDMessageBoxComponentEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageBoxComponentEditor.ExecuteVerb(Index : Integer);
begin
  Case Index Of
    0 : begin
          if LMDApplication.MsgBox <> nil then
            TLMDMessageBoxDlg(LMDApplication.MsgBox).Execute ('','Test - Message',[0], [], -1, -1, -1, -1, 0);
        end;
  end;
end;

{********************* Class TLMDScrollTextComponentEditor ******************* }
{------------------------------------------------------------------------------}
procedure TLMDScrollTextComponentEditor.ExecuteVerb(Index: Integer);
var
  Ident: String;
  Module: IOTAModule;
begin
  case index of
    0:if not LMDCPGetBevel((Component as TLMDScrollText).Bevel) then exit;
    1:if not LMDCPGetFont((Component as TLMDScrollText).Font) then exit;
    2:if not LMDCPGetFont3D((Component as TLMDScrollText).Font3D) then exit;
    3:(Component as TLMDScrollText).Transparent := not (Component as TLMDScrollText).Transparent;
    4:(Component as TLMDScrollText).Scroll := not (Component as TLMDScrollText).Scroll;
    5:begin
        Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Ident';
        Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
        if (Module <> nil) and (Module.GetModuleFileCount > 0) then
          Module.GetModuleFileEditor(0).Show
        else
          if not LMDCPGetStrings((Component as TLMDScrollText).Lines, Ident) then exit;
      end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDScrollTextComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Bevel';
    1:result:='Font';
    2:result:='Font3D';
    3:result:='Transparent'+BoolStr[TLMDScrollText(Component).Transparent];
    4:result:='Scroll'+BoolStr[TLMDScrollText(Component).Scroll];
    5:result:='Lines';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDScrollTextComponentEditor.GetVerbCount: Integer;
begin
  Result:=6;
end;

{***************** Class TLMDButtonBarCollectionEditor ************************}
{------------------------------------------------------------------------------}
function TLMDButtonBarCollectionEditor.GetWorkCollection(Index:Integer):TCollection;
begin
  result:=TLMDButtonBarSection(Collection.Items[ListView1.Selected.Index]).Items;
end;

{***************** Class TLMDButtonBarCollectionProperty **********************}
{------------------------------------------------------------------------------}
function TLMDButtonBarCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  result:=TLMDButtonBarCollectionEditor;
end;

{****************** Class TLMDButtonBarComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDButtonBarComponentEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'Sections')=0) then
  begin
    Prop.Edit;
    Continue := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonBarComponentEditor.ExecuteVerb(Index: Integer);
begin
//  with TLMDButtonBar(Component) do
    case Index of
      0: with TfrmLMDButtonBarEditorDlg.Create(nil) do
           try
             // AssignValues für Editor
             bbar.Assign (TLMDButtonBar(Component));
             InitBoxes;
             FDesigner:=self.Designer;
             if ShowModal=mrOK then
               begin
                 //AssignValues für Komponente
                 TLMDButtonBar(Component).Assign (bbar);
               end;
           finally
             Free;
           end;
      1:if not LMDCPGetFont3D(TLMDButtonBar(Component).Font3D) then exit;
      2:if not LMDCPGetFont(TLMDButtonBar(Component).Font) then exit;
      3:if not LMDCPGetBevel(TLMDButtonBar(Component).Bevel) then exit;
      5:Edit;
      6:TLMDButtonBar(Component).AddNamedSection ('Section '+IntToStr (TLMDButtonBar(Component).Sections.Count));//Edit;
      7:TLMDButtonBar(Component).NextSection;
      8:TLMDButtonBar(Component).PrevSection;
     10: if TLMDButtonBar(Component).Sections.Count > 0 then
           TLMDButtonBar(Component).AddNamedItem ('Item '+IntToStr(TLMDButtonBar(Component).Sections[TLMDButtonBar(Component).Open].Items.Count));
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDButtonBarComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Component-Editor';
    1: result := 'Font3D';
    2: result := 'Font';
    3: result := 'Bevel';
    4: result := '-';
    5: result := 'Section Editor';
    6: result := 'Add Section';
    7: result := 'Next section';
    8: result := 'Prev section';
    9: result := '-';
   10: result := 'Add item';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonBarComponentEditor.GetVerbCount: Integer;
begin
  result := 11;
end;

{****************** Class TLMDFormShapeComponentEditor *****************************}
{------------------------------------------------------------------------------}
function TLMDFormShapeComponentEditor.GetVerbCount;
begin
  result:=1;
end;

{------------------------------------------------------------------------------}
function TLMDFormShapeComponentEditor.GetVerb;
begin
  with TLMDFormShape(Component) do
    case index of
      0: Result :='Refresh';
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShapeComponentEditor.ExecuteVerb;
begin
//  FDesigner:=Designer;
  case Index of
    0: begin
         TLMDFormShape(Component).PaintBorder(0);//ReRegion; (DC = 0 => component editor)
       end;
  end;
//  FDesigner.Modified;
end;

{****************** Class TLMDWndButtonShapeComponentEditor *****************************}
{------------------------------------------------------------------------------}
function TLMDWndButtonShapeComponentEditor.GetVerbCount:Integer;
begin
  result:=5
end;

{------------------------------------------------------------------------------}
function TLMDWndButtonShapeComponentEditor.GetVerb;
begin
  case index of
    0: result:='OnClick...';
    1: result:='ImageList';
    2: result :='Transparent'+ BoolStr[TLMDWndButtonShape(Component).Transparent];
    3: result:='FontFX';
    4: result:='Font';
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWndButtonShapeComponentEditor.ExecuteVerb;
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDWndButtonShape(Component) do
    case index of
      0: inherited Edit;//ExecuteVerb(Index);//Designer.CreateMethod('Click', GetTypeData (pt.GetPropInfo {(TLMDWndButtonShape(Component).OnClick(Component))}));
//      nil{GetTypeData (OnClick){GetPropInfo(Component.ClassInfo, 'OnClick')});
      1: begin
           { store actual settings in temporary variables }
           t1:=ListIndex;
           t2:=ImageIndex;
           t3:=ImageList;

           if LMDCPGetIMLExt(Designer, t3, t1, t2) then
             begin
               { if Editor closed with OK set the values }
               ImageList := t3;
               ListIndex:=t1;
               ImageIndex:=t2;
             end;
         end;
      2:Transparent:=not Transparent;
      3:if not LMDCPGetFontFX(FontFX) then exit;
      4:if not LMDCPGetFont(Font) then exit;
    end;
  Designer.Modified;
end;

{****************** Class TLMDPanelShapeComponentEditor ***********************}
{------------------------------------------------------------------------------}
function TLMDPanelShapeComponentEditor.GetVerbCount;
begin
  result:=4
end;

{------------------------------------------------------------------------------}
function TLMDPanelShapeComponentEditor.GetVerb;
begin
  case index of
    0: result:='ImageList';
    1: result :='Transparent'+ BoolStr[TLMDPanelShape(Component).Transparent];
    2: result:='FontFX';
    3: result:='Font';
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelShapeComponentEditor.ExecuteVerb;
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDPanelShape(Component) do
    case index of
      0: begin
           { store actual settings in temporary variables }
           t1:=ListIndex;
           t2:=ImageIndex;
           t3:=ImageList;

           if LMDCPGetIMLExt(Designer, t3, t1, t2) then
             begin
               { if Editor closed with OK set the values }
               ImageList := t3;
               ListIndex:=t1;
               ImageIndex:=t2;
             end;
         end;
      1:Transparent:=not Transparent;
      2:if not LMDCPGetFontFX(FontFX) then exit;
      3:if not LMDCPGetFont(Font) then exit;
    end;
  Designer.Modified;
end;

{************** Class TLMDCaptionPanelGroupEditor *****************************}
{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroupEditor.GetGroupControl: TLMDCaptionPanelGroup;
var
  tmp: TControl;
begin
  result:=nil;
  tmp:=TControl(Component);
  if not Assigned(tmp) then exit;
  if tmp is TLMDCaptionPanelGroup then
    result:=TLMDCaptionPanelGroup(tmp)
  else
    if (tmp is TLMDCaptionPanel) and (tmp.Parent is TLMDCaptionPanelGroup) then
      result:=TLMDCaptionPanelGroup(TLMDCaptionPanel(tmp).Parent);
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroupEditor.GetVerbCount;
begin
  FComponent:=GetGroupControl;
  result:=7;
  If FComponent<>nil then
    if Component is TLMDCaptionPanel then
      result:=12
    else
      result:=11;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroupEditor.GetVerb;
const
  EXP:array[Boolean] of string=('Expand','Collapse');

begin
  if FComponent=nil then
    begin
      case Index of
        0: result:='Bevel';
        1: result:='Caption';
        2: result:='Caption Position';
        3: result:='Caption Buttons';
        4: result:='Transparent'+ Boolstr[TLMDCaptionPanel(Component).Transparent];
        5: result:='-';
        6: result:=EXP[TLMDCaptionPanel(Component).Expanded];
      end;
    end
  else
    case Index of
      0: Result:='Select PanelGroup';
      1: Result:='Add Panel';
      2: Result:='-';
      3: result:='Select all Panels';
      4: result:='Expand all Panels';
      5: result:='Collapse all Panels';
      6: Result:='-';
      7: result:='Bevel';
      8: result:='Transparent'+Boolstr[TLMDCustomBevelPanel(Component).Transparent];
      9: Result:='-';
     10: if Component is TLMDCaptionPanel then
           result:='Move Up'
         else
           begin
              Result:='Change Orientation ';
              if TLMDCaptionPanelGroup(Component).Orientation=toVertical then
                result:=result+'to horizontal'
              else
                result:=result+'to vertical';
            end;
     11:  result:='Move Down';
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroupEditor.ExecuteVerb;
var
  FDesigner:IDesigner;
  Panel: TLMDCaptionPanel;
  FSelectionList:IDesignerSelections;
  tmp:TList;
  i:Integer;

begin
  FDesigner:=Designer;
  if FComponent=nil then
    begin
      case Index of
        0: if not LMDCPGetBevel(TLMDCaptionPanel(Component).Bevel) then exit;
        1: TLMDCaptionPanel(Component).Caption:=LMDCPGetCaption(TLMDCaptionPanel(Component).Caption, -1);
        2: if not LMDCPSelectValueDialog(TLMDCaptionPanel(Component).CaptionSettings, 'Position') then exit;
        3: if not LMDCPSelectValueDialog(TLMDCaptionPanel(Component).CaptionSettings, 'Buttons') then exit;
        4: TLMDCaptionPanel(Component).Transparent:=not TLMDCaptionPanel(Component).Transparent;
        6: TLMDCaptionPanel(Component).Expanded:=not TLMDCaptionPanel(Component).Expanded;
      end;
    end
  else
    case Index of
      0: FDesigner.SelectComponent(FComponent);
      1: begin
           Panel:=TLMDCaptionPanel.Create(FComponent.Owner);
           //Panel.PanelIndex:=-1;
           if Component is TLMDCaptionPanel then
             begin
               Panel.CaptionSettings.Assign(TLMDCaptionPanel(Component).CaptionSettings);
               Panel.SetSilentIndex(TLMDCaptionPanel(Component).PanelIndex+1);
             end
           else
             Panel.SetSilentIndex(99999);  // dummy value
           Panel.Name:=FDesigner.UniqueName(TLMDCaptionPanel.ClassName);
           Panel.Parent:=TLMDCaptionPanelGroup(FComponent);
           TLMDCaptionPanelGroup(FComponent).Change;
           TLMDCaptionPanelGroup(FComponent).ScrollInView(Panel);
           FDesigner.SelectComponent(Panel);
         end;
      3: begin
           FDesigner.NoSelection;
           FSelectionList:=CreateSelectionList;
           try
             tmp:=tList.Create;
             try
               TLMDCaptionPanelGroup(FComponent).PanelList(tmp);
               for i:=0 to tmp.Count-1 do
                 FSelectionList.Add(TComponent(tmp[i]));
               FDesigner.SetSelections(FSelectionList);
             finally
               tmp.Free;
             end;
           finally
             FSelectionList:=nil;
           end;
         end;
      4: TLMDCaptionPanelGroup(FComponent).ExpandAll;
      5: TLMDCaptionPanelGroup(FComponent).CollapseAll;
      7: if not LMDCPGetBevel(TLMDCustomBevelPanel(Component).Bevel) then exit;
      8: TLMDCustomBevelPanel(Component).Transparent:=not TLMDCustomBevelPanel(Component).Transparent;
      10: if Component is TLMDCaptionPanel then
           TLMDCaptionPanel(Component).PanelIndex:=TLMDCaptionPanel(Component).PanelIndex-1
         else
           with TLMDCaptionPanelGroup(FComponent) do
              if Orientation=toVertical then
                begin
                  BeginUpdate;
                  SetBounds(Left,Top, Height, Width);
                  Orientation:=toHorizontal;
                  EndUpdate(true);
                end
              else
                begin
                  BeginUpdate;
                  SetBounds(Left,Top, Height, Width);
                  Orientation:=toVertical;
                  EndUpdate(true);
                end;
     11: TLMDCaptionPanel(Component).PanelIndex:=TLMDCaptionPanel(Component).PanelIndex+1;
    end;
  FDesigner.Modified;
end;

{****************** Class TLMDSendKeyComponentEditor ************************}
{------------------------------------------------------------------------------}
function TLMDSendKeyComponentEditor.GetVerbCount;
begin
  result:=1
end;

{------------------------------------------------------------------------------}
function TLMDSendKeyComponentEditor.GetVerb;
begin
  result:='SendKeys Test-Editor';
end;

{------------------------------------------------------------------------------}
procedure TLMDSendKeyComponentEditor.ExecuteVerb;
begin
  with TLMDSendKeysEditorDlg.Create(nil) do
    try
      ShowModal;
    finally
      Free
    end;

end;

{****************** Class TLMDFilterComponentEditor ***************************}
{------------------------------------------------------------------------------}
procedure TLMDFilterComponentEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
begin
  Prop.Edit;
  Continue := False;
end;

{------------------------------------------------------------------------------}
function TLMDFilterComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{------------------------------------------------------------------------------}
function TLMDFilterComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit Filters'
  else Result := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDFilterComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

end.
