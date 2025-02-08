unit pLMDCECore;
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

LMD-Tools Core Controls Component Editors (RM)
----------------------------------------------
Centralized unit for all LMD-Tools Core Controls component editors.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface
uses
  DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  Classes, Sysutils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, Menus, ComCtrls,
  LMDClass, LMDCont, LMDPageControl, pLMDGlobalEditors, pLMDCEBase;

type
  // 10.08
  {----------------------------------------------------------------------------}
  TLMDFlowPanelEditor = class(TLMDComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBaseGraphicButtonComponentEditor = class(TLMDDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDColorComboBoxComponentEditor = class(TLMDComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFontComboBoxComponentEditor = class(TLMDComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFontSizeComboBoxComponentEditor = class(TLMDComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonPanelEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCustomButtonComponentEditor = class(TLMDDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCustomLImageComponentEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDDrawEdgeComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFormDisplayComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDHintComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDListBoxComponentEditor = class(TDefaultEditor) //TComponentEditor)
  protected // 6.0
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteSectionEditor;
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDMousePosEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDNImageComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  // 6.1
  {----------------------------------------------------------------------------}
  TLMDPageControlEditor = class(TComponentEditor)
  protected
    function GetPageControl: TLMDPageControl;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDPanelFillComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDProgressComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDProgressFillComponentEditor = class(TLMDProgressComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSectionEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDShadowFillComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSimplePanelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDWaveEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDStatusBarComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCustomListBoxComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDImageListBoxComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDImageComboBoxComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonControlComponentEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDCustomButtonGroupComponentEditor = class(TLMDComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDGroupBoxComponentEditor = class(TLMDComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBackPanelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDTrackBarComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDInfoLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSplitterPaneEditor = class(TDefaultEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSplitterPanelEditor = class(TDefaultEditor)
  private
    FSelected : Integer;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDEditComponentEditor = class(TLMDDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDMemoComponentEditor = class(TLMDEditComponentEditor)
  private
    FOld:Integer;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDHTMLLabelComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDScrollBarComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  {----------------------------------------------------------------------------}
  TLMDToolBarEditor = class(TLMDButtonPanelEditor)
  protected
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

const
  BoolStr:array[Boolean] of String=(' [False]', ' [True]');

  function LMDCPIsDBControl(aValue:TComponent):Boolean;
  // loads and saves Delphi/CBuilder custom colors list
  function LMDCPGetColorCP(aColor:TColor):TColor;

implementation
uses
  ToolsApi,Contnrs, ImgList,
  pLMDCPGetCore, pLMDCPGetBase, pLMDPECst, pLMDCommon, LMDPNGImage, LMDPNGImageList,
  LMDFlowPanel,
  LMDCustomCheckListDlg,
  LMDMaskEdit,
  LMDCustomExtSpinEdit,
  LMDBase,
  LMDGraph,
  LMDSysIn,
  LMDCustomImageList,
  LMDBaseDialog,
  LMDCustomSpeedButton,
  LMDCustomEdit,
  LMDCustomExtCombo,
  LMDListBox,
  LMDStatusBar,
  LMDCustomFormFill,
  LMDFormDisplay,
  LMDBackPanel,
  LMDSimplePanel,
  LMDFormStyler,
  LMDBaseEdit,
  LMDCustomLImage,
  LMDImageListBox,
  LMDImageComboBox,
  LMDCustomNImage,
  LMDNImage,
  LMDFontComboBox,
  LMDColorComboBox,
  LMDWaveComp,
  LMDCustomBrowseEdit,
  LMDSplt,
  LMDSBar,
  pLMDStatusBarEditorDlg,
  LMDFontSizeComboBox,
  LMDBaseLabel,
  LMDCustomMemo,
  LMDCustomListBox,
  LMDCustomImageListBox,
  LMDBaseMeter,
  LMDCustomProgress,
  LMDProgress,
  LMDProgressFill,
  LMDCustomLabel,
  LMDCustomSimpleLabel,
  LMDCustomGlyphLabel,
  LMDBaseGraphicButton,
  LMDCustomButton,
  LMDGroupBox,
  LMDShadowFill,
  LMDCustomTrackBar,
  LMDInformationLabel,
  LMDCustomButtonGroup,
  LMDCustomBevelPanel,
  LMDFill,
  LMDMousePositioner,
  LMDPanelFill,
  LMDButtonControl,
  LMDCustomCheckBox,
  LMDRadioButton,
  LMDDrawEdge,
  LMDHint,
  LMDThemes,
  LMDGlyphLabel,
  LMDSimpleLabel,
  LMDLImage,
  LMDHTMLLabel,
  LMDButtonPanel,
  LMDCustomToolbar,
  LMDToolbar,
  pLMDDsgnCPGetX,
  pLMDToolbarEditorDlg,
  pLMDPeCore;

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

{************************ Class TLMDFlowPanelEditor ***************************}
{------------------------------------------------------------------------------}
procedure TLMDFlowPanelEditor.ExecuteVerb(Index : Integer);
var
  LSep: TLMDFlowPanelSeparator;
begin
  case Index of
    0:
    begin
      LSep:=TLMDFlowPanelSeparator.Create(Designer.Root);
      LSep.Name:=Designer.UniqueName(LSep.ClassName);
      LSep.Top := (Component as TLMDFlowPanel).Height;
      LSep.Left := (Component as TLMDFlowPanel).Width;
      LSep.Parent := Component as TLMDFlowPanel;
      Designer.Modified;
      Designer.SelectComponent(LSep);
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFlowPanelEditor.GetVerb(Index : Integer) : string;
begin
  Result := 'Add separator';
end;

{------------------------------------------------------------------------------}
function TLMDFlowPanelEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

{************ Class TLMDBaseGraphicButtonComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDBaseGraphicButtonComponentEditor.ExecuteVerb(Index: Integer);
var
  tmp:TBitmap;
  t1, t2:Word;
  t3:TCustomImageList;

begin
  with TLMDBaseGraphicButton(Component) do
    case Index of
      0: inherited Edit;
      1:  begin
            tmp:=TBitmap.Create;
            try
              tmp.Assign(Glyph);
              if not LMDCPGetBitmap(tmp) then exit else Glyph:=tmp;
            finally
              tmp.Free;
            end;
          end;
       2: begin
            t1:=ListIndex;t2:=ImageIndex;
            // ToDo RM
            t3:=TLMDCustomImageList(ImageList);
            if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
            ListIndex:=t1;ImageIndex:=t2; ImageList:=t3;
          end;
      3:Caption:=LMDCPGetCaption(Caption, -1);
      4:if not LMDCPGetButtonLayout(ButtonLayout) then exit;
      5:Color:=LMDCPGetColorCP(Color);
      6:Enabled:=not Enabled;
      7:EnterColor:=LMDCPGetColorCP(EnterColor);
      8:EnterColorChange:=not EnterColorChange;
      9:if not LMDCPGetFont(Font) then exit;
     10:if not LMDCPGetFontFx(FontFx) then exit;
     11:LMDCPSelectValueDialog(Component, 'ButtonStyle');
     //12:TLMDCustomSpeedButton(Component).CtlXP:=not TLMDCustomSpeedButton(Component).CtlXP;
     14:LMDSetThemeMode(TCustomForm(Owner), TLMDCustomSpeedButton(Component).ThemeMode);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicButtonComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
     0: result:='OnClick...';
     1: result:='Glyph';
     2: result:='Select Glyph';
     3: result:='Caption';
     4: result:='ButtonLayout';
     5: result:='Color';
     6: result:='Enabled'+BoolStr[TLMDBaseGraphicButton(Component).Enabled];
     7: result:='EnterColor';
     8: result:='EnterColorChange'+BoolStr[TLMDBaseGraphicButton(Component).EnterColorChange];
     9: result:='Font';
    10: result:='FontFX';
    11: result:='ButtonStyle';
    12: result:=IDS_THEMEMODE;
    13: result:='-';
    14: result:=IDS_UPDATECTLXP;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGraphicButtonComponentEditor.GetVerbCount: Integer;
begin
  Result:=11;
  if Component is TLMDCustomSpeedButton then Inc(result, 4);
end;

{********************* Class TLMDColorComboBoxComponentEditor *****************}
{------------------------------------------------------------------------------}
procedure TLMDColorComboBoxComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDColorComboBox(Component) do
    case Index of
      0:Color:=LMDCPGetColorCP(Color);
      1:Enabled:=not Enabled;
      2:if not LMDCPGetFont(Font) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDColorComboBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Color';
    1:result:='Enabled' + BoolStr[TLMDColorComboBox(Component).Enabled];
    2:result:='Font';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDColorComboBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=3;
end;

{********************* Class TLMDFontComboBoxComponentEditor *****************}
{------------------------------------------------------------------------------}
procedure TLMDFontComboBoxComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFontComboBox(Component) do
    case Index of
      0:Enabled:=not Enabled;
      1:if not LMDCPGetFont(Font) then exit;
      2:LMDCPSelectValueDialog(Component, 'Options');
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFontComboBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Enabled' + BoolStr[TLMDFontComboBox(Component).Enabled];
    1:result:='Font';
    2:result:='Options';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFontComboBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=3;
end;

{********************* Class TLMDFontSizeComboBoxComponentEditor **************}
{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBoxComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFontSizeComboBox(Component) do
    case Index of
      0: Enabled:=not Enabled;
      1: OpenEditorDlg('Font'); //if not LMDCPGetFont(Font) then exit;
      2: UseNearestSize := (UseNearestSize = false);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Enabled' + BoolStr[TLMDFontSizeComboBox(Component).Enabled];
    1:result:='Font';
    2:result:='UseNearestSize' + BoolStr[TLMDFontSizeComboBox(Component).UseNearestSize];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=3;
end;

{***************** Class TLMDButtonPanelEditor ********************************}
{------------------------------------------------------------------------------}
procedure TLMDButtonPanelEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'Buttons')=0) then
    begin
      Prop.Edit;
      Continue := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanelEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  with TLMDButtonPanel(Component) do
    case Index of
      0: Edit;
      1: LMDCPSelectValueDialog(Component, 'ButtonStyle');
      2: CtlXP:=not CtlXP;
      3: if not LMDCPGetBevel(Bevel) then exit;
      4: Color:=LMDCPGetColorCP(Color);
      5: begin
           t1:=ListIndex;t3:=ImageList;t2:=0;
           if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
           ImageList:=t3; ListIndex:=t1;
         end;
      6: if not LMDCPGetFillObject(FillObject) then exit;
      7: Transparent:=not Transparent;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDButtonPanelEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Buttons';
    1: result:='ButtonStyle';
    2: result:='CtlXP '+BoolStr[TLMDButtonPanel(Component).Transparent];
    3: result:='Bevel';
    4: result:='Color';
    5: result:='ImageList';
    6: result:='FillObject';
    7: result:='Transparent '+BoolStr[TLMDButtonPanel(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonPanelEditor.GetVerbCount: Integer;
begin
  Result:=8
end;

{************ Class TLMDCustomButtonComponentEditor ***************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomButtonComponentEditor.ExecuteVerb(Index: Integer);
var
  tmp:TBitmap;
  t1,t2:Word;
  t3:TCustomImageList;
begin
  with TLMDCustomButton(Component) do
    case Index of
      0:inherited Edit{inherited ExecuteVerb(Index)};
      1:  begin
            tmp:=TBitmap.Create;
            try
              tmp.Assign(Glyph);
              if not LMDCPGetBitmap(tmp) then exit else Glyph:=tmp;
            finally
              tmp.Free;
            end;
          end;
      2:  begin
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
              end
            else
              exit;

           end;
      3:LMDCPSelectValueDialog(Component, 'ButtonStyle');
      4:Caption:=LMDCPGetCaption(Caption, -1);
      5:if not LMDCPGetButtonLayout(ButtonLayout) then exit;
      6:Color:=LMDCPGetColorCP(Color);
      7:Enabled:=not Enabled;
      8:if not LMDCPGetFont(Font) then exit;
      9:if not LMDCPGetFontFx(FontFx) then exit;
     // --
     12:LMDSetThemeMode(TCustomForm(Owner), ThemeMode);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='OnClick...';
    1: result:='Glyph';
    2: result:='SelectImage';
    3: result:='ButtonStyle';
    4: result:='Caption';
    5: result:='ButtonLayout';
    6: result:='Color';
    7: result:='Enabled'+BoolStr[TLMDCustomButton(Component).Enabled];
    8: result:='Font';
    9: result:='FontFX';
   10: result:='ThemeMode'; //  CtlXP'+BoolStr[TLMDCustomButton(Component).CtlXP];
   11: result:='-';
   12: result:=IDS_UPDATECTLXP;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonComponentEditor.GetVerbCount: Integer;
begin
  Result:=13;
end;

{*************** Class TLMDCustomLImageComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomLImageComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  with TLMDCustomLImage(Component) do
    case Index of
      0:begin
          // ToDo RM
          t1:=ListIndex;t3:=TLMDCustomImageList(ImageList);
          if Component.ClassName='TLMDAniCtrl' then t2:=0 else t2:=ImageIndex;
          if not LMDCPGetIMLExt(Designer, t3, t1, t2) then exit;
          ImageList:=t3; ListIndex:=t1;ImageList:=t3;
          if not (Component.ClassName='TLMDAniCtrl') then ImageIndex:=t2;
        end;
      1:if not LMDCPGetBevel(Bevel) then exit;
      2:Color:=LMDCPGetColorCP(Color);
      3:Transparent:= not Transparent;
      4:TLMDLImage(Component).Style:=LMDCPGetBitmapStyle(TLMDLImage(Component).Style);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImageComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='Bevel';
    2:result:='Color';
    3:result:='Transparent' + Boolstr[TLMDCustomLImage(Component).Transparent];
    4:result:='Style';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImageComponentEditor.GetVerbCount: Integer;
begin
  Result := 5;
  // Caution: TLMDAniCtrl-Editor derives from this component editor
end;

{********************* Class TLMDDrawEdgeComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDDrawEdgeComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDDrawEdge(Component) do
    case Index of
      0: Filled:= not Filled;
      1,2: begin
             Style:=esEdge;
             EdgeStyle:=etEtched;
             if Index=1 then
               begin FrameSides:=[fsTop]; Height:=3; end
             else
               begin FrameSides:=[fsLeft]; Width:=3; end
           end;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDDrawEdgeComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='Filled'+BoolStr[TLMDDrawEdge(Component).Filled];
    1: Result:='Horizontal Line';
    2: Result:='Vertical Line';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDDrawEdgeComponentEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

{********************* Class TLMDFormDisplayComponentEditor *******************}
{------------------------------------------------------------------------------}
procedure TLMDFormDisplayComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFormDisplay(Component) do
    case Index of
      0:if not LMDCPGetBevel(Bevel) then exit;
      1:Color:=LMDCPGetColorCP(Color);
      2:Enabled:=not Enabled;
      3:SaveResources:=not SaveResources;
      4:UseResForms := (UseResForms = false);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplayComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Bevel';
    1:result:='Color';
    2:result:='Enabled' + Boolstr[TLMDFormDisplay(Component).Enabled];
    3:result:='SaveResources' + Boolstr[TLMDFormDisplay(Component).SaveResources];
    4:result:='UseResForms' + Boolstr[TLMDFormDisplay(Component).UseResForms];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormDisplayComponentEditor.GetVerbCount: Integer;
begin
  Result:=5;
end;

{********************* Class TLMDHintComponentEditor **************************}
{------------------------------------------------------------------------------}
procedure TLMDHintComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDHint(Component) do
    case Index of
      0:if not LMDCPGetBEvel(Bevel) then exit;
      1:Color:=LMDCPGetColorCP(Color);
      2:Enabled:=not Enabled;
      3:if not LMDCPGetFont(Font) then exit;
      4:if not LMDCPGetFont3D(Font3D) then exit;
    end;
  Designer.Modified;

end;

{------------------------------------------------------------------------------}
function TLMDHintComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Bevel';
    1: Result:='Color';
    2: Result:='Enabled' + BoolStr[TLMDHint(Component).Enabled];
    3: Result:='Font';
    4: Result:='Font3D';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDHintComponentEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{****************** Class TLMDLabelComponentEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDLabelComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
  with TLMDBaseLabel(Component) do
    case Index of
      0:if not LMDCPIsDBControl(Component) then Caption:=LMDCPGetCaption(Caption, -1) else exit;
      1:AutoSize:=not AutoSize;
      2:Color:=LMDCPGetColorCP(Color);
      3:if not LMDCPGetFont(Font) then exit;
      4:if Component is TLMDCustomSimpleLabel then
          begin
            if not LMDCPGetFont3D(TLMDCustomSimpleLabel(Component).Font3D) then exit;
          end
        else
          if Component is TLMDGlyphLabel then
            begin
              if not LMDCPGetFont3D(TLMDGlyphLabel(Component).Font3D) then exit;
            end
          else
            if not LMDCPGetFontFx(TLMDCustomLabel(Component).FontFx) then exit;
      5:MultiLine:=not MultiLine;
      6:Transparent:=not Transparent;
      7: if Component is TLMDGlyphLabel then
           with TLMDGlyphLabel(Component) do
             begin
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
             end
           else
             if not LMDCPGetBevel(TLMDCustomLabel(Component).Bevel) then exit;
      8: if not LMDCPGetGlyphTextLayout(TLMDCustomGlyphLabel(Component).Alignment) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDLabelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: if LMDCPIsDBControl(Component) then result:='[DB] No caption available' else result:='Caption';
    1: Result:='AutoSize'+BoolStr[TLMDBaseLabel(Component).AutoSize];
    2: result:='Color';
    3: Result:='Font';
    4: if (Component is TLMDCustomSimpleLabel) or (Component is TLMDGlyphLabel) then
          Result:='Font3D'
       else
         Result:='FontFX';
    5: Result:='MultiLine' + BoolStr[TLMDBaseLabel(Component).MultiLine];
    6: result:='Transparent'+ BoolStr[TLMDBaseLabel(Component).Transparent];
    7: if Component is TLMDGlyphLabel then Result := 'ImageList' else Result:='Bevel';
    8: result:='Alignment';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDLabelComponentEditor.GetVerbCount: Integer;
begin
  Result:=7;
  if (Component is TLMDCustomLabel) then Inc(result);
  if (Component is TLMDCustomGlyphLabel) then Inc(result,2);
end;

{********************* Class SectionEditor ************************************}
{------------------------------------------------------------------------------}

  {$R pLMDSectionEdit.DFM}

type
  TLMDSectionEditorDlg = class(TForm)
    ScrollBox1: TScrollBox;
    lb: TLMDListBox;
    lb1: TLMDListBox;
    Bevel1: TBevel;
    ok: TButton;
    cancel: TButton;
    fs: TLMDFormStyler;
    procedure sized(Sender: TObject; ASection, AWidth: Integer);
  end;

{********************* Class SectionEditorDlg *********************************}
{------------------------------------------------------------------------------}
procedure TLMDSectionEditorDlg.sized(Sender: TObject; ASection,
  AWidth: Integer);
var
  i{,w}:Integer;
begin
  lb1.Clear;
//  w:=0;
  for i:=0 to Pred(lb.Header.sections.count) do
    begin
      lb1.Addline([lb.Header.Sections[i].Text, inttostr(lb.Header.Sections[i].Width)]);
//      inc(w,lb.Header.Sections[i].Width);
    end;
end;

{********************* Class TLMDListBoxComponentEditor ***********************}
{------------------------------------------------------------------------------}
procedure TLMDListBoxComponentEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'HeaderSections')=0) then
    begin
      Prop.Edit;
      Continue := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBoxComponentEditor.ExecuteSectionEditor;
var
  SEditor: TLMDSectionEditorDlg;
  tmp:TLMDLIstBox;
  i:Integer;

begin
  tmp:=TLMDListBox(Component);
  SEditor := TLMDSectionEditorDlg.Create(nil);
  try
    with SEditor do
      begin
        Lb.header.Sections.Assign(tmp.Header.Sections);
        lb.HeaderFont.Assign(tmp.HeaderFont);
        lb.VirtualAutoWidth:=True;
        sized(lb,0,0);
        if Showmodal=mrOK then
          for i:=0 to lb.Header.Sections.Count-1 do
            tmp.header.SectionWidth[i]:=lb.Header.Sections[i].Width;
        //tmp.lb.Refresh;
      end;
  finally
    SEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListBoxComponentEditor.ExecuteVerb(Index: Integer);
var
  Ident: String;
  Module: IOTAModule;
begin
  if  TLMDListBox(Component).Header.Sections.Count>1 then Dec(index);
  with TLMDListBox(Component) do
    case Index of
      -1:ExecuteSectionEditor;
      0:begin
          Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Items';
          Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
          if (Module <> nil) and (Module.GetModuleFileCount > 0) then
            Module.GetModuleFileEditor(0).Show
          else
            begin
              if not LMDCPGetStrings(Items, Ident) then exit;
            end;
        end;
      1:Edit;
      2:if not LMDCPGetBevel(Bevel) then exit;
      3:Color:=LMDCPGetColorCP(Color);
      4:Enabled:=not Enabled;
      5:if not LMDCPGetFont(Font) then exit;
      6:if not LMDCPGetFont(HeaderFont) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDListBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  if  TLMDListBox(Component).Header.Sections.Count>1 then Dec(index);
  case index of
    -1:result:='Resize Sections...';
    0:result:='Items';
    1:result:='HeaderSections';
    2:result:='Bevel';
    3:result:='Color';
    4:result:='Enabled' + Boolstr[TLMDListBox(Component).Enabled];
    5:result:='Font';
    6:result:='HeaderFont';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDListBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=7;
  if  TLMDListBox(Component).Header.Sections.Count>1 then Inc(result);
end;

{********************* Class TLMDMousePosEditor *******************************}
{------------------------------------------------------------------------------}
procedure TLMDMousePosEditor.ExecuteVerb(Index: Integer);
begin
  TLMDMousePositioner(Component).Execute;
end;

{------------------------------------------------------------------------------}
function TLMDMousePosEditor.GetVerb(Index: Integer): string;
begin
  result:='&Test...';
end;

{------------------------------------------------------------------------------}
function TLMDMousePosEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDNImageComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDNImageComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDCustomNImage(Component) do
    case Index of
      0:if not LMDCPIsDBControl(Component) then
          if not LMDCPGetBitmap(TLMDNImage(Component).Bitmap) then exit;
      1:if not LMDCPGetBevel(Bevel) then exit;
      2:Color:=LMDCPGetColorCP(Color);
      3:Style:=LMDCPGetBitmapStyle(Style);
      4:Transparent:= not Transparent;
      5:if not LMDCPGetTransparent(TransparentStyle) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDNImageComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:if LMDCPIsDBControl(Component) then
        result:='[DB] No bitmap'
      else
        result:='Bitmap';
    1:result:='Bevel';
    2:result:='Color';
    3:result:='Style';
    4:result:='Transparent' + Boolstr[TLMDNImage(Component).Transparent];
    5:result:='TransparentStyle';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDNImageComponentEditor.GetVerbCount: Integer;
begin
  Result := 6;
end;

{****************** Class TLMDPageControlEditor *******************************}
{------------------------------------------------------------------------------}
function TLMDPageControlEditor.GetPageControl: TLMDPageControl;
var
  tmp: TComponent;
begin
  Result:=nil;
  tmp:=Component;
  if not Assigned(tmp) then exit;
  if tmp is TLMDPageControl then
    result:=TLMDPageControl(tmp)
  else
    if tmp is TLMDTabSheet then
      result:=TLMDPageControl(TLMDTabSheet(tmp).PageControl);
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControlEditor.ExecuteVerb(Index: Integer);
var
  pgc: TLMDPageControl;
  ts:TLMDTabSheet;
begin
  pgc:=GetPageControl;
  if not Assigned(pgc) then exit;

  case Index of
    0: begin
         ts:=TLMDTabSheet.Create(self.Designer.Root);
         ts.Name:=Designer.UniqueName(ts.ClassName);
         ts.PageControl:=pgc;
         pgc.ActivePage:=ts;
       end;
  else
     pgc.ActivePage:=pgc.Pages[index-2]
   end;
  Designer.Modified;
  if (pgc.ActivePage<>nil) then
    Designer.SelectComponent(pgc.ActivePage);
end;

{------------------------------------------------------------------------------}
function TLMDPageControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:='&New Page';
    1: Result:='-';
  else
    result:='Display Page '+GetPageControl.Pages[index-2].Name;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPageControlEditor.GetVerbCount: Integer;
var
  tmp:TLMDPageControl;
begin
  result:=1;
  tmp:=GetPageControl;
  if tmp=nil then exit;
  if tmp.Count>1 then
    Inc(result, tmp.Count+1);
end;

{********************* Class TLMDPanelFillComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDPanelFillComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDPanelFill(Component) do
    case Index of
      0:begin
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
      1:if not LMDCPGetFillObject(FillObject) then exit;
      2:if not LMDCPGetBevel(Bevel) then exit;
      3:Caption:=LMDCPGetCaption(Caption,-1);
      4:Enabled:=not Enabled;
      5:if not LMDCPGetFont(Font) then exit;
      6:if not LMDCPGetFontFX(FontFX) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDPanelFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='FillObject';
    2:result:='Bevel';
    3:result:='Caption';
    4:result:='Enabled' + Boolstr[TLMDPanelFill(Component).Enabled];
    5:result:='Font';
    6:result:='FontFX';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPanelFillComponentEditor.GetVerbCount: Integer;
begin
  Result:=7;
end;

{****************** Class TLMDProgressComponentEditor *************************}
{------------------------------------------------------------------------------}
procedure TLMDProgressComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDBaseMeter(Component) do
    case Index of
      0: if not LMDCPGetSmallBar(TLMDCustomProgress(Component).SmallBar) then exit;
      1: if not LMDCPGetBevel(Bevel) then exit;
      2: Caption:=LMDCPGetCaption(Caption, -1);
      3: if not LMDCPGetFont(Font) then exit;
      4: if not LMDCPGetFont3D(Font3D) then exit;
      5: UseFontColor:=not UseFontColor;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDProgressComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='SmallBar';
    1: Result:='Bevel';
    2: Result:='Caption';
    3: Result:='Font';
    4: Result:='Font3D';
    5: Result:='UseFontColor'+BoolStr[TLMDBaseMeter(Component).UseFontColor];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDProgressComponentEditor.GetVerbCount: Integer;
begin
  Result:=6;
end;

{****************** Class TLMDProgressFillComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDProgressFillComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  with TLMDProgressFill(Component) do
    case Index of
      1:begin
          if not LMDCPGetFillObject(FillObject) then exit;
          Designer.Modified;
        end;
      0: begin
          { store actual settings in temporary variables }
          t1:=ListIndex;
          t2:=ImageIndex;
          // ToDo RM
          t3:=TLMDCustomImagelist(ImageList);
          if LMDCPGetIMLExt(Designer, t3, t1, t2) then
            begin
              { if Editor closed with OK set the values }
              ImageList := t3;
              ListIndex:=t1;
              ImageIndex:=t2;
            end;
        end;
      2..6:
        inherited ExecuteVerb(index-1);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDProgressFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    1: result:='FillObject';
    0: result:='ImageList';
  2..6:
    result:=inherited GetVerb(index-1);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDProgressFillComponentEditor.GetVerbCount: Integer;
begin
  Result:=7;
end;

{********************* Class TLMDSectionEditor ********************************}
{------------------------------------------------------------------------------}
procedure TLMDSectionEditor.ExecuteVerb(Index: Integer);
var
  SEditor: TLMDSectionEditorDlg;
  tmp:TLMDLIstBox;
  i:Integer;

begin
  tmp:=TLMDListBox(Component);
  if tmp.Header.Sections.Count<2 then
    raise Exception.Create('One or more Sections required to start Section-Editor dialog!');
  SEditor := TLMDSectionEditorDlg.Create(nil);
  try
    with SEditor do
      begin
        Lb.Width:=tmp.Width;
        Lb.header.Sections.Assign(tmp.Header.Sections);
        for i:=0 to tmp.Header.Sections.Count-1 do
          lb.header.Sections[i].Width:=tmp.Header.Sections[i].Width;
        sized(lb,0,0);
        if Showmodal=mrOK then
          for i:=0 to tmp.Header.Sections.Count-1 do
            tmp.header.Sections[i].Width:=lb.Header.Sections[i].Width;
        tmp.Refresh;
      end;
  finally
    SEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Section-Editor';
end;

{------------------------------------------------------------------------------}
function TLMDSectionEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDSimplePanelComponentEditor *******************}
{------------------------------------------------------------------------------}
procedure TLMDSimplePanelComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  if Component is TLMDBackPanel then Dec(index);
  with TLMDSimplePanel(Component) do
    case Index of
     -1:with TLMDBackPanel(Component) do
{          if (ImageList<>nil) and (ImageList.Count>0) then
            begin
              t1:=ListIndex;
              t2:=ImageIndex;
              if not LMDCPGetIML(ImageList, t1, t2) then exit;
              ListIndex:=t1;
              ImageIndex:=t2;
            end;}
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
      0:if not LMDCPGetBevel(Bevel) then exit;
      1:Color:=LMDCPGetColorCP(Color);
      2:Enabled:=not Enabled;
      3:if not LMDCPGetFont(Font) then exit;
      4:Transparent := (Transparent = false);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDSimplePanelComponentEditor.GetVerb(Index: Integer): string;
begin
  if Component is TLMDBackPanel then Dec(index);
  case index of
   -1: begin
         result:='ImageList';
{         if (TLMDBackPanel(Component).ImageList=nil) or
            (TLMDBackPanel(Component).ImageList.Count=0) then result:=result+PE[Ord(unavailable)]}
       end;
    0:result:='Bevel';
    1:result:='Color';
    2:result:='Enabled' + Boolstr[TLMDSimplePanel(Component).Enabled];
    3:result:='Font';
    4:result:='Transparent'+Boolstr[TLMDSimplePanel(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSimplePanelComponentEditor.GetVerbCount: Integer;
begin
  Result:=5;
  if Component is TLMDBackPanel then inc(result);
end;

{********************* Class TLMDShadowFillComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDShadowFillComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDShadowFill(Component) do
    case Index of
      0:ShadowColor:=LMDCPGetColorCP(ShadowColor);
      1:if not LMDCPGetBevel(Bevel) then exit;
    end;
  Designer.Modified;

end;

{------------------------------------------------------------------------------}
function TLMDShadowFillComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='ShadowColor';
    1: Result:='Bevel';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShadowFillComponentEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{********************* Class TLMDWaveEditor ***********************************}
{------------------------------------------------------------------------------}
procedure TLMDWaveEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetWave(TLMDWaveComp(Component).Wave) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDWaveEditor.GetVerb(Index: Integer): string;
begin
  Result:='Specify Wave';
end;

{------------------------------------------------------------------------------}
function TLMDWaveEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDStatusBarComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDStatusBarComponentEditor.ExecuteVerb(Index: Integer);
var
  editdlg : TLMDStatusBarEditorDlg;

  procedure createInfo (it : TLMDInfoType;capt, dt : String;use : boolean;a : TAlign; bs : TLMDFrameSides);
  begin
    with TLMDInformationLabel.Create (Designer.Root) do
        begin
          Name:=Designer.UniqueName(ClassName);
          Parent := TLMDStatusBar(Component);
          Align := a;
          Alignment := agCenter;
          UseStandardCaption := use;
          Font3D.DisabledStyle := ds3d;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsSingleLowered;
          Transparent := false;
          if not use then
            InsertTabs := 0;
          Caption := capt;
          if dt <> '' then
            DateTimeFormat := dt;
          Info := it;
        end;
  end;

  procedure createSimpleInfo (capt:  String;a : TAlign);
  begin
    with TLMDSimpleLabel.Create (Designer.Root) do
        begin
          Name:=Designer.UniqueName(ClassName);
          Parent := TLMDStatusBar(Component);
          Font3D.DisabledStyle := ds3d;
          Transparent := false;
          Align := a;
          Alignment := agCenter;
          if capt <> '' then
            Caption := capt;
        end;
  end;

begin
  if TLMDStatusBar(Component).OldStyle then
    with TLMDStatusBar(Component) do
      case Index of
        0 : begin
              editdlg := TLMDStatusBarEditorDlg.Create (Application);
              try
                if editdlg.ShowModal = mrOk then
                  begin
                    case editdlg.ListBox.ItemIndex of
                      0 : begin
                            createSimpleInfo ('HintText',alLeft);
                            createInfo (itCurrentDateTime,'','hh:mm:ss',false, alRight, []);
                            createInfo (itNumLock,'Num:','',false, alRight, [fsRight]);
                            createInfo (itScroll,'Scroll:','',false, alRight, [fsRight]);
                            createInfo (itCapsLock,'Caps:','',false, alRight, [fsRight, fsLeft]);
                          end;
                      1 : begin
                            createSimpleInfo ('HintText',alLeft);
                            createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alRight, []);
                            createInfo (itNumLock,'Num:','',false, alRight, [fsRight]);
                            createInfo (itScroll,'Scroll:','',false, alRight, [fsRight]);
                            createInfo (itCapsLock,'Caps:','',false, alRight, [fsRight, fsLeft]);
                          end;
                      2 : begin
                            SimplePanel := True;
                            SimpleText := 'HintText';
                            Alignment := agCenter;
                          end;
                      3 : begin
                            createInfo (itNumLock,'Num:','',false, alLeft, [fsRight]);
                            createInfo (itScroll,'Scroll:','',false, alLeft, [fsRight]);
                            createInfo (itCapsLock,'Caps:','',false, alLeft, [fsRight]);
                          end;
                      4 : createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alLeft, [fsRight]);
  (*                    5 : begin
                            createDBInfo (itDBState,'',true, alLeft, [fsRight]);
                            createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alRight, []);
                            createInfo (itNumLock,'Num:','',false, alRight, [fsRight]);
                            createInfo (itScroll,'Scroll:','',false, alRight, [fsRight]);
                            createInfo (itCapsLock,'Caps:','',false, alRight, [fsRight, fsLeft]);
                          end;
                      6 : begin
                            createSimpleInfo ('HintText',alLeft);
                            createDBInfo (itDBState,'',true, alLeft, [fsRight]);
                            createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alRight, []);
                            createInfo (itNumLock,'Num:','',false, alRight, [fsRight]);
                            createInfo (itScroll,'Scroll:','',false, alRight, [fsRight]);
                            createInfo (itCapsLock,'Caps:','',false, alRight, [fsRight, fsLeft]);
                          end;
                      7 : begin
                            createDBInfo (itDBState,'',true, alLeft, [fsRight]);
                            createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alRight, [fsLeft]);
                          end;*)
                      5 : begin
                            createInfo (itUser,'','',true, alLeft, [fsRight]);
                          end;
                    end;
                  end;
              finally
                editdlg.Free;
              end;
            end;
        2 : if not LMDCPGetFont(Font) then exit;
        3 : if not LMDCPGetFont3D(Font3D) then exit;
        4 : if not LMDCPGetBevel(Bevel) then exit;
        6 : createInfo (itCurrentDateTime,'','dd/mm/yy hh:mm:ss',false, alLeft, [fsRight]);
        7 : createInfo (itCapsLock,'Caps:','',false, alLeft, [fsRight]);
        8 : createInfo (itNumLock,'Num:','',false, alLeft, [fsRight]);
        9 : createInfo (itScroll,'Scroll:','',false, alLeft, [fsRight]);
       10 : createInfo (itUser,'','',true, alLeft, [fsRight]);
       11: createSimpleInfo ('', alLeft);
  {      8: createDBInfo (itDBRecords,'', true, alLeft, [fsRight]);}
      end
  else
    with TLMDStatusBar(Component) do
      case Index of
        0 : if not LMDCPGetFont(Font) then exit;
        1 : if not LMDCPGetFont3D(Font3D) then exit;
        2 : if not LMDCPGetBevel(Bevel) then exit;
      end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDStatusBarComponentEditor.GetVerb(Index: Integer): string;
begin
  if TLMDStatusBar(Component).OldStyle then
    case index of
      0: result := 'Editor';
      1: result := '-';
      2: result := 'Font';
      3: result := 'Font3D';
      4: result := 'Bevel';
      5: result := '-';
      6: result := 'DateTime';
      7: result := 'Caps';
      8: result := 'Num';
      9: result := 'Scroll';
     10: result := 'System Info';
     11: result := 'Normal Info';
  {    8: result := 'DB Info';}
    end
  else
    case index of
      0: result := 'Font';
      1: result := 'Font3D';
      2: result := 'Bevel';
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStatusBarComponentEditor.GetVerbCount: Integer;
begin
  if TLMDStatusBar(Component).OldStyle then
    Result:=12
  else
    Result:=3;
end;

{********************* Class TLMDCustomButtonGroupComponentEditor *************}
{------------------------------------------------------------------------------}
procedure TLMDCustomButtonGroupComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
  //IsEditor: Boolean;
  Ident: String;
  Module: IOTAModule;

begin
  case index of
    0: with (Component as TLMDCustomButtonGroup) do
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
    1: with (Component as TLMDCustomButtonGroup) do
        begin

          { store actual settings in temporary variables }
          t1:=GlyphListIndex;
          t2:=GlyphImageIndex;
          t3:=GlyphImageList;

          if LMDCPGetIMLExt(Designer, t3, t1, t2) then
            begin
              { if Editor closed with OK set the values }
              GlyphImageList := t3;
              GlyphListIndex:=t1;
              GlyphImageIndex:=t2;
            end;
        end;
    2:if not LMDCPGetFont((Component as TLMDCustomButtonGroup).Font) then exit;
    3:if not LMDCPGetFont3D((Component as TLMDCustomButtonGroup).Font3D) then exit;
    4: with (Component as TLMDCustomButtonGroup) do
         Caption := LMDCPGetCaption(Caption, -1);
    5:if not LMDCPGetFont((Component as TLMDCustomButtonGroup).CaptionFont) then exit;
    6:if not LMDCPGetFont3D((Component as TLMDCustomButtonGroup).CaptionFont3D) then exit;
    7:(Component as TLMDCustomButtonGroup).Transparent := not (Component as TLMDCustomButtonGroup).Transparent;
    8:begin
        Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Items';
        Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
        if (Module <> nil) and (Module.GetModuleFileCount > 0) then
          Module.GetModuleFileEditor(0).Show
        else
          begin
            if not LMDCPGetStrings((Component as TLMDCustomButtonGroup).Items, Ident) then exit;
          end;
      end;
   10:TLMDCustomButtonGroup(Component).Bevel.Mode:=bmWindows;
   //11:TLMDCustomButtonGroup(Component).CtlXP:=not TLMDCustomButtonGroup(Component).CtlXP;
   13:LMDSetThemeMode(TCustomForm(Component.Owner), TLMDCustomButtonGroup(Component).ThemeMode);

  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroupComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='GlyphImageList';
    2:result:='Font';
    3:result:='Font3D';
    4:result:='Caption';
    5:result:='CaptionFont';
    6:result:='CaptionFont3D';
    7:result:='Transparent'+BoolStr[TLMDCustomButtonGroup(Component).Transparent];
    8:result:='Items';
    9:result:='-';
   10:result:='Make Bevel CtlXP compatible';
   11:result:=IDS_THEMEMODE;
   12:result:='-';
   13:result:=IDS_UPDATECTLXP;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomButtonGroupComponentEditor.GetVerbCount: Integer;
begin
  Result:=14;
end;

{***************** Class TLMDButtonControlComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDButtonControlComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  case index of
    0: inherited Edit;
    1: (Component as TLMDButtonControl).Caption:=LMDCPGetCaption((Component as TLMDButtonControl).Caption, -1);
    2: if not LMDCPGetGlyphTextLayout(TLMDButtonControl(Component).Alignment) then exit;
    3: with (Component as TLMDButtonControl) do
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
     4:if Component is TLMDCustomCheckBox then
         (Component as TLMDCustomCheckBox).Checked := not (Component as TLMDCustomCheckBox).Checked
       else
         (Component as TLMDRadioButton).Checked := not (Component as TLMDRadioButton).Checked;
     5:if not LMDCPGetFont((Component as TLMDButtonControl).Font) then exit;
     6:if not LMDCPGetFont3D((Component as TLMDButtonControl).Font3D) then exit;
     7:(Component as TLMDButtonControl).Transparent := not (Component as TLMDButtonControl).Transparent;
   end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDButtonControlComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: if Component is TLMDCustomCheckBox then
         result:='OnChange...'
       else result:='OnClick...';
    1:result:='Caption';
    2:result:='Alignment';
    3:result:='ImageList';
    4:if Component is TLMDRadioButton then
        result:='Checked'+BoolStr[TLMDRadioButton(Component).Checked]
      else
        result:='Checked'+BoolStr[TLMDCustomCheckBox(Component).Checked];
    5:result:='Font';
    6:result:='Font3D';
    7:result:='Transparent'+BoolStr[TLMDButtonControl(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonControlComponentEditor.GetVerbCount: Integer;
begin
  Result:=8
end;

{------------------------------------------------------------------------------}

{********************* Class TLMDGroupBoxComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDGroupBoxComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  case index of
    0: with (Component as TLMDGroupBox) do
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
    1:if not LMDCPGetFont((Component as TLMDGroupBox).Font) then exit;
    2: with (Component as TLMDGroupBox) do
          Caption := LMDCPGetCaption(Caption, -1);
    3:if not LMDCPGetFont((Component as TLMDGroupBox).CaptionFont) then exit;
    4:if not LMDCPGetFont3D((Component as TLMDGroupBox).CaptionFont3D) then exit;
    5:(Component as TLMDGroupBox).Transparent := not (Component as TLMDGroupBox).Transparent;
    6:if not LMDCPGetBevel((Component as TLMDGroupBox).Bevel) then Exit;
    8:TLMDGroupBox(Component).Bevel.Mode:=bmWindows;
    //9:TLMDGroupBox(Component).CtlXP:=not TLMDGroupBox(Component).CtlXP;
   11:LMDSetThemeMode(TCustomForm(Component.Owner), TLMDGroupBox(Component).ThemeMode);
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDGroupBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='Font';
    2:result:='Caption';
    3:result:='CaptionFont';
    4:result:='CaptionFont3D';
    5:result:='Transparent'+BoolStr[TLMDGroupBox(Component).Transparent];
    6:result:='Bevel';
    7:result:='-';
    8:result:='Make Bevel Theme compatible';
    9:result:=IDS_THEMEMODE;
   10:result:='-';
   11:result:=IDS_UPDATECTLXP;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDGroupBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=12;
end;

{********************* Class TLMDBackPanelComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDBackPanelComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  case index of
    0: with (Component as TLMDBackPanel) do
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
    1:if not LMDCPGetFont((Component as TLMDBackPanel).Font) then exit;
    2:if not LMDCPGetBevel((Component as TLMDBackPanel).Bevel) then exit;
    3:(Component as TLMDBackPanel).Transparent := not (Component as TLMDBackPanel).Transparent;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBackPanelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='Font';
    2:result:='Bevel';
    3:result:='Transparent'+BoolStr[TLMDBackPanel(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBackPanelComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{********************* Class TLMDTrackBarComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDTrackBarComponentEditor.ExecuteVerb(Index: Integer);
var
  t1, t2:Word;
  t3 : TCustomImageList;
begin
  case index of
    0: with (Component as TLMDCustomTrackBar) do
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
    1:if not LMDCPGetFont((Component as TLMDCustomTrackBar).Font) then exit;
    2:(Component as TLMDCustomTrackBar).Transparent := not (Component as TLMDCustomTrackBar).Transparent;
{    4:LMDWriteComponent(Component);
    5:LMDSelectComponentTemplate(Component);}
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDTrackBarComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='ImageList';
    1:result:='Font';
    2:result:='Transparent'+BoolStr[TLMDCustomTrackBar(Component).Transparent];
    3:result:='-';
    4:result:='Save component';
    5:result:='Select template';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTrackBarComponentEditor.GetVerbCount: Integer;
begin
  Result:=6;
end;

{*************** Class TLMDCustomListBoxComponentEditor ***********************}
{------------------------------------------------------------------------------}
procedure TLMDCustomListBoxComponentEditor.ExecuteVerb(Index: Integer);
var
  Ident: String;
  Module: IOTAModule;
begin
  case index of
    0:if not LMDCPGetFont((Component as TLMDCustomListBox).Font) then exit;
    1:if not LMDCPGetFont3D((Component as TLMDCustomListBox).Font3D) then exit;
    2:(Component as TLMDCustomListBox).Transparent := not (Component as TLMDCustomListBox).Transparent;
    3: begin
        Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Items';
        Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
        if (Module <> nil) and (Module.GetModuleFileCount > 0) then
         Module.GetModuleFileEditor(0).Show
        else
         if not LMDCPGetStrings((Component as TLMDCustomListBox).Items, Ident) then exit;
      end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Font';
    1:result:='Font3D';
    2:result:='Transparent'+BoolStr[TLMDCustomListBox(Component).Transparent];
    3:result:='Items';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
  if (Component is TLMDCustomDerivedImageListBox) then Dec(Result);
end;

{********************* Class TLMDImageListBoxComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDImageListBoxComponentEditor.ExecuteVerb(Index: Integer);
var
  Ident: String;
  Module: IOTAModule;
begin
  case index of
    0:if not LMDCPGetFont((Component as TLMDCustomImageListBox).Font) then exit;
    1:if not LMDCPGetFont3D((Component as TLMDCustomImageListBox).Font3D) then exit;
    2:(Component as TLMDCustomImageListBox).Transparent := not (Component as TLMDCustomImageListBox).Transparent;
    3:if not LMDCPGetGlyphTextLayout((Component as TLMDCustomImageListBox).Layout) then exit;
    4: begin
         Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Items';
         Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
         Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
         if (Module <> nil) and (Module.GetModuleFileCount > 0) then
           Module.GetModuleFileEditor(0).Show
         else
           begin
            if not LMDCPGetStrings((Component as TLMDCustomImageListBox).Items, Ident) then exit;
           end;
       end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDImageListBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Font';
    1:result:='Font3D';
    2:result:='Transparent'+BoolStr[TLMDCustomImageListBox(Component).Transparent];
    3:result:='Layout';
    4:result:='Items';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDImageListBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=5;
end;

{********************* Class TLMDImageComboBoxEditor ***************************}
{------------------------------------------------------------------------------}
procedure TLMDImageComboBoxComponentEditor.ExecuteVerb(Index: Integer);
var
  Ident: String;
  Module: IOTAModule;
begin
  case index of
    0:if not LMDCPGetFont((Component as TLMDImageComboBox).Font) then exit;
    1:if not LMDCPGetFont3D((Component as TLMDImageComboBox).Font3d) then exit;
    2:if not LMDCPGetGlyphTextLayout((Component as TLMDImageComboBox).Layout) then exit;
    3:begin
        Ident:= Designer.GetRoot.Name + '.' + Component.Name + '.Items';
        Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
        if (Module <> nil) and (Module.GetModuleFileCount > 0) then
          Module.GetModuleFileEditor(0).Show
        else
          if not LMDCPGetStrings((Component as TLMDImageComboBox).Items, Ident) then exit;
       end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDImageComboBoxComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Font';
    1:result:='Font3D';
    2:result:='Layout';
    3:result:='Items';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDImageComboBoxComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{****************** Class TLMDInformationLabelComponentEditor *****************}
{------------------------------------------------------------------------------}
procedure TLMDInfoLabelComponentEditor.ExecuteVerb(Index: Integer);
var
  s : string;
begin
  with TLMDInformationLabel(Component) do
    case Index of
      0:Transparent:=not Transparent;
      1:AutoSize:=not AutoSize;
      2:if not LMDCPGetFont3D(TLMDInformationLabel(Component).Font3D) then exit;
      3:if not LMDCPGetFont(Font) then exit;
      4:if not LMDCPGetBevel(TLMDInformationLabel(Component).Bevel) then exit;
      5:begin
          s := TLMDInformationLabel(Component).DateTimeFormat;
          if not LMDCPGetDateTimeFormat(s) then exit;
          TLMDInformationLabel(Component).DateTimeFormat := s;
        end;
      7:Info:=itCurrentDateTime;
      8:Info:=itCapsLock;
      9:Info:=itNumLock;
      10:Info:=itScroll;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDInfoLabelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result :='Transparent'+ BoolStr[TLMDBaseLabel(Component).Transparent];
    1: Result :='AutoSize'+ BoolStr[TLMDBaseLabel(Component).Autosize];
    2: result:='Font3D';
    3: Result:='Font';
    4: Result:='Bevel';
    5: Result:='DateTime Format';
    6: result:='-';
    7: result:='show DateTime';
    8: result:='show Caps';
    9: result:='show Num';
    10:result:='show Scroll';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDInfoLabelComponentEditor.GetVerbCount: Integer;
begin
  Result:=11;
end;

  {************** Class TLMDSplitterPaneEditor **********************************}
  {------------------------------------------------------------------------------}
  function TLMDSplitterPaneEditor.GetVerbCount;
  begin
    result:=5;
  end;

  {------------------------------------------------------------------------------}
  function TLMDSplitterPaneEditor.GetVerb;
  begin
    case Index of
      0: if TLMDSplitterPanel(TLMDSplitterPane(Component).ParentControl).PaneCount<4 then
           Result:='Add Pane'
         else
           result:='Edit Splitter';
      1: Result:='Rotate Panes';
      2: Result:='-';
      3: result:='Bevel';
      4: result:='Transparent'+ Boolstr[TLMDSplitterPane(Component).Transparent];
    end;
  end;

  {------------------------------------------------------------------------------}
  procedure TLMDSplitterPaneEditor.ExecuteVerb;
  var
    FDesigner: IDesigner;
    Pane,NewPane: TLMDSplitterPane;
    Main:TLMDSplitterPanel;
  begin
    FDesigner:=Designer;
    Main:=TLMDSplitterPanel(TLMDSplitterPane(Component).ParentControl);
    case Index of
      0: if Main.PaneCount<4 then
           begin
             Pane:=TLMDSplitterPane(Component);
             if Main=nil then exit;
             NewPane:=TLMDSplitterPane.Create(Pane.Owner);
             NewPane.Name:=FDesigner.UniqueName(TLMDSplitterPane.ClassName);
             NewPane.ParentControl:=Main;
             FDesigner.SelectComponent(NewPane);
           end
         else
            LMDCPShowBarItemDlg(Main, FDesigner);
      1: TLMDSplitterPanel(Main).RotatePanes;
      3: if not LMDCPGetBevel(TLMDSplitterPane(Component).Bevel) then exit;
      4: TLMDSplitterPane(Component).Transparent:=not TLMDSplitterPane(Component).Transparent;
    end;
    FDesigner.Modified;
  end;

  {************** Class TLMDSplitterControlEditor *******************************}
  {------------------------------------------------------------------------------}
  function TLMDSplitterPanelEditor.GetVerbCount;
  var
    i:Integer;
  begin
    Result:=6;
    FSelected:=-1;
    with TLMDSplitterPanel(Component) do
      // 5.03
      if PaneCount=0 then
        inc(result,3)
      else
        for i:=0 to Pred(Bars.Count) do
          if Bars[i].Selected then
            begin
              FSelected:=i;
              Inc(result);
              exit;
            end;
  end;

  {------------------------------------------------------------------------------}
  function TLMDSplitterPanelEditor.GetVerb;
  begin
    if FSelected>-1 then Dec(index);
    case Index of
      -1:Result:='Edit Splitter';
      0: Result:='Bars movable'+BoolStr[TLMDSplitterPanel(Component).Movable];
      1: if TLMDSplitterPanel(Component).PaneCount<4 then Result:='Add Pane' else Result:='-';
      2: Result:='RotatePanes';
      3: result:='-';
      4: result:='Bevel';
      5: result:='Transparent'+ Boolstr[TLMDSplitterPanel(Component).Transparent];
      6: result:='-';
      7: result:='Add 2 Panes (Vertical)';
      8: result:='Add 2 Panes (Horizontal)';
    end;
  end;

  {------------------------------------------------------------------------------}
  procedure TLMDSplitterPanelEditor.ExecuteVerb;
  var
    FDesigner:IDesigner;

    function SplitAddPanel:TLMDSplitterPane;
    begin
      result:=TLMDSplitterPane.Create(TLMDSplitterPanel(Component).Owner);
      result.Name:=FDesigner.UniqueName(TLMDSplitterPane.ClassName);
      result.ParentControl:=TLMDSplitterPanel(Component);
    end;

  begin
    FDesigner:=Designer;
    if FSelected>-1 then Dec(index);
    with TLMDSplitterPanel(Component) do
      case index of
       -1: {if not Movable then
             LMDCPShowBarItemDlg(TLMDSplitterPanel(Component), FDesigner)
           else}
             FDesigner.SelectComponent(Bars[FSelected]);
        0: Movable:=not Movable;
        1: if PaneCount<4 then
             FDesigner.SelectComponent(SplitAddPanel)
           else
             exit;
        2: RotatePanes;
        4: if not LMDCPGetBevel(Bevel) then exit;
        5: Transparent:=not Transparent;
        7,8:
           begin
              if index=7 then Orientation:=spVertRight else Orientation:=spHorzUp;
              SplitAddPanel;
              FDesigner.SelectComponent(SplitAddPanel);
           end
       end;
    FDesigner.Modified;
  end;

{****************** Class TLMDEditComponentEditor *****************************}
{----------------------- private ----------------------------------------------}
procedure TLMDEditComponentEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  tmp:string;
begin
  tmp:=Prop.GetName;
  if (CompareText(tmp,'CustomButtons')=0) then
    begin
      Prop.Edit;
      Continue := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDEditComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDBaseEdit(Component) do
    case Index of
      0:Transparent:=not Transparent;
      1:if not LMDCPGetFont3D(TLMDBaseEdit(Component).Font3D) then exit;
      2:if not LMDCPGetFont(TLMDBaseEdit(Component).Font) then exit;
      3:if not LMDCPGetBevel(TLMDBaseEdit(Component).Bevel) then exit;
      4:LMDCPSelectValueDialog(TLMDCustomEdit(Component), 'CustomButtonsStyle');
      //5:CtlXP:=not CtlXP;
      7:LMDSetThemeMode(TCustomForm(Owner), ThemeMode);
      9:Edit;
    10: TLMDCustomEdit(Component).CustomButtonParentCtlXP:=not TLMDCustomEdit(Component).CustomButtonParentCtlXP;
    12: TLMDCustomExtSpinEdit(Component).SpinBtnDiag:=not TLMDCustomExtSpinEdit(Component).SpinBtnDiag;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDEditComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result :='Transparent'+ BoolStr[TLMDBaseEdit(Component).Transparent];
    1: result:='Font3D';
    2: Result:='Font';
    3: Result:='Bevel';
    // 7.0
    4: Result:='CustomButtonsStyle';
    5: Result:=IDS_THEMEMODE;
    6: Result:='-';// ---
    7: Result:=IDS_UPDATECTLXP;
    8: Result:='-'; // ----
    9: Result:='CustomButtons';
   10: Result:='CustomButtonParentCtlXP'+BoolStr[TLMDCustomEdit(Component).CustomButtonParentCtlXP];
   11: Result:='-';
   12: Result:='SpinBtnDiag';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDEditComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
  if Component is TLMDCustomEdit then
    Inc(result, 7);
  if Component is TLMDCustomExtSpinEdit then
    Inc(result, 2)
  else if (Component is TLMDCustomExtCombo)
          or (Component is TLMDCustomBrowseEdit)
          or (Component.ClassName='TLMDCalendarEdit')
          or (Component.ClassName='TLMDCalculatorEdit')
    then Dec(result, 2);
end;

{****************** Class TLMDMemoComponentEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDMemoComponentEditor.ExecuteVerb(Index: Integer);
var
  aList:TStringList;
begin
  if Index=Fold then
    begin
      aList:=TStringlist.Create;
      try
        aList.Text:=TLMDCustomMemo(Component).Lines.Text;
        if LMDCPGetStrings(aList) then
          begin
            TLMDCustomMemo(Component).Lines.Assign(aList);
            Designer.Modified;
          end;
      finally
        aList.Free;
      end;
    end
  else
    inherited ExecuteVerb(Index);
end;

{------------------------------------------------------------------------------}
function TLMDMemoComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index=Fold then
    result:='Lines'
  else
    result:=inherited GetVerb(Index);

end;

{------------------------------------------------------------------------------}
function TLMDMemoComponentEditor.GetVerbCount: Integer;
begin
  result:=inherited GetVerbCount;
  FOld:=Result;
  if not LMDCPIsDBControl(Component) then Inc(result);
end;

{********************* Class TLMDColorContainerComponentEditor ****************}
{------------------------------------------------------------------------------}
procedure TLMDHTMLLabelComponentEditor.ExecuteVerb(Index: Integer);
var
  tmp:TLMDHTMLString;
begin
  case index of
    //0: inherited Edit;
    0: begin
         tmp:=TLMDHTMLLabel(Component).Caption;
         if not LMDCPGetHTMLString(tmp) then exit;
         TLMDHTMLLabel(Component).Caption:=tmp;
       end;
    1: if not LMDCPGetBevel(TLMDHTMLLabel(Component).Bevel) then exit;
    2:TLMDHTMLLabel(Component).Color:=LMDCPGetColorCP(TLMDHTMLLabel(Component).Color);
    3:TLMDHTMLLabel(Component).Transparent:= not TLMDHTMLLabel(Component).Transparent;
   end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDHTMLLabelComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    //0: result:='OnClick...';
    0: result:='Caption';
    1: result:='Bevel';
    2:result:='Color';
    3:result:='Transparent' + Boolstr[TLMDHTMLLabel(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDHTMLLabelComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{****************** Class TLMDScrollBarComponentEditor ************************}
{------------------------------------------------------------------------------}
function TLMDScrollBarComponentEditor.GetVerbCount;
begin
  result:=4
end;

{------------------------------------------------------------------------------}
function TLMDScrollBarComponentEditor.GetVerb;
begin
  case index of
    0: result :='Transparent'+ BoolStr[TLMDScrollBar(Component).Transparent];
    1: result:='Back';
    2: result:='Bevel';
    3: if TLMDScrollBar(Component).Kind = lmdsbar.skHorizontal then
         result:='Kind (Horiz)'
       else
         result:='Kind (Vert)';
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollBarComponentEditor.ExecuteVerb;
begin
  with TLMDScrollBar(Component) do
    case index of
      0:Transparent:=not Transparent;
      1:if not LMDCPGetFillObject(Back) then exit;
      2:if not LMDCPGetBevel(Bevel) then exit;
      3:if Kind = lmdsbar.skHorizontal then
          Kind := lmdsbar.skVertical
        else
          Kind := lmdsbar.skHorizontal;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDToolBarEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Edit...';
    1: result:='Buttons';
    2: result:='ButtonStyle';
    3: result:='CtlXP '+BoolStr[TLMDButtonPanel(Component).Transparent];
    4: result:='Bevel';
    5: result:='Color';
    6: result:='ImageList';
    7: result:='FillObject';
    8: result:='Transparent '+BoolStr[TLMDButtonPanel(Component).Transparent];
  end;
end;

{------------------------------------------------------------------------------}
function TLMDToolBarEditor.GetVerbCount: Integer;
begin
  Result:=9
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDToolbarEditor.ExecuteVerb(Index: Integer);
var
  tbEditor: TLMDToolBarEditorDlg;
  ltb: TLMDToolBar;
begin
  ltb := TLMDToolBar(Component);
  case Index of
    0:
      begin
        tbEditor := TLMDToolBarEditorDlg.Create(nil);
        try
          with tbEditor do
          begin
            if ltb.ImageList = nil then
              ShowMessage('Imagelist is not assigned. Glyphs will be stored directly in PngGlyph property of the tool buttons.');
            tbEditor.ToolBar.Assign(ltb);
            if Showmodal=mrOK then
            begin
              ltb.Assign(tbEditor.ToolBar);
              ltb.SetBorders;
            end;
          end;
        finally
          tbEditor.Free;
        end;
      end;
    1..8: inherited ExecuteVerb(Index - 1);
  end;
  Designer.Modified;
end;


end.
