unit CustomizeDlg_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'CustomizeDlg' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, CheckLst, ComCtrls, Menus, ExtCtrls, ImgList,
  Buttons, ActnMan, ActnCtrls, ActnMenus, CustomizeDlg, Windows_LMDSW,
  Messages_LMDSW, SysUtils_LMDSW, Variants_LMDSW, Classes_LMDSW,
  Graphics_LMDSW, Controls_LMDSW, Forms_LMDSW, Dialogs_LMDSW, StdCtrls_LMDSW,
  ActnList_LMDSW, CheckLst_LMDSW, ComCtrls_LMDSW, Menus_LMDSW, ExtCtrls_LMDSW,
  ImgList_LMDSW, Buttons_LMDSW, ActnMan_LMDSW, ActnCtrls_LMDSW,
  ActnMenus_LMDSW;


{ Type wrappers }

type
  TCustomizeFrm_sw = class;
  TCustomizeDlg_sw = class;

  TCustomizeFrm_sc = class of TCustomizeFrm;
  TCustomizeFrm_sw = class(TForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomizeFrm): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeFrm;
    class function ClassToVar(AClass: TCustomizeFrm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomizeFrm_sc;
  end;

  TCustomizeDlg_sc = class of TCustomizeDlg;
  TCustomizeDlg_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomizeDlg): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomizeDlg;
    class function ClassToVar(AClass: TCustomizeDlg_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomizeDlg_sc;
  end;


{ Unit wrapper }

type
  CustomizeDlg_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TCustomizeFrm_sw }

function TCustomizeFrm_CloseBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CloseBtn: TButton;

  if IsGet then
    Result := TButton_sw.ToVar(TCustomizeFrm(AObj).CloseBtn)
  else
    TCustomizeFrm(AObj).CloseBtn := TButton_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_Tabs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Tabs: TPageControl;

  if IsGet then
    Result := TPageControl_sw.ToVar(TCustomizeFrm(AObj).Tabs)
  else
    TCustomizeFrm(AObj).Tabs := TPageControl_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ToolbarsTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ToolbarsTab: TTabSheet;

  if IsGet then
    Result := TTabSheet_sw.ToVar(TCustomizeFrm(AObj).ToolbarsTab)
  else
    TCustomizeFrm(AObj).ToolbarsTab := TTabSheet_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionsTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionsTab: TTabSheet;

  if IsGet then
    Result := TTabSheet_sw.ToVar(TCustomizeFrm(AObj).ActionsTab)
  else
    TCustomizeFrm(AObj).ActionsTab := TTabSheet_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_OptionsTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OptionsTab: TTabSheet;

  if IsGet then
    Result := TTabSheet_sw.ToVar(TCustomizeFrm(AObj).OptionsTab)
  else
    TCustomizeFrm(AObj).OptionsTab := TTabSheet_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ToolbarsLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ToolbarsLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).ToolbarsLbl)
  else
    TCustomizeFrm(AObj).ToolbarsLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionBarList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionBarList: TCheckListBox;

  if IsGet then
    Result := TCheckListBox_sw.ToVar(TCustomizeFrm(AObj).ActionBarList)
  else
    TCustomizeFrm(AObj).ActionBarList := TCheckListBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ResetBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResetBtn: TButton;

  if IsGet then
    Result := TButton_sw.ToVar(TCustomizeFrm(AObj).ResetBtn)
  else
    TCustomizeFrm(AObj).ResetBtn := TButton_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CloseMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CloseMenu: TPopupMenu;

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TCustomizeFrm(AObj).CloseMenu)
  else
    TCustomizeFrm(AObj).CloseMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CloseItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CloseItem: TMenuItem;

  if IsGet then
    Result := TMenuItem_sw.ToVar(TCustomizeFrm(AObj).CloseItem)
  else
    TCustomizeFrm(AObj).CloseItem := TMenuItem_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_PersonalizeLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PersonalizeLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).PersonalizeLbl)
  else
    TCustomizeFrm(AObj).PersonalizeLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_OptionsBevel2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OptionsBevel2: TBevel;

  if IsGet then
    Result := TBevel_sw.ToVar(TCustomizeFrm(AObj).OptionsBevel2)
  else
    TCustomizeFrm(AObj).OptionsBevel2 := TBevel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_RecentlyUsedChk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecentlyUsedChk: TCheckBox;

  if IsGet then
    Result := TCheckBox_sw.ToVar(TCustomizeFrm(AObj).RecentlyUsedChk)
  else
    TCustomizeFrm(AObj).RecentlyUsedChk := TCheckBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ResetUsageBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResetUsageBtn: TButton;

  if IsGet then
    Result := TButton_sw.ToVar(TCustomizeFrm(AObj).ResetUsageBtn)
  else
    TCustomizeFrm(AObj).ResetUsageBtn := TButton_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_LargeIconsChk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LargeIconsChk: TCheckBox;

  if IsGet then
    Result := TCheckBox_sw.ToVar(TCustomizeFrm(AObj).LargeIconsChk)
  else
    TCustomizeFrm(AObj).LargeIconsChk := TCheckBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ShowTipsChk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShowTipsChk: TCheckBox;

  if IsGet then
    Result := TCheckBox_sw.ToVar(TCustomizeFrm(AObj).ShowTipsChk)
  else
    TCustomizeFrm(AObj).ShowTipsChk := TCheckBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ShortCutTipsChk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortCutTipsChk: TCheckBox;

  if IsGet then
    Result := TCheckBox_sw.ToVar(TCustomizeFrm(AObj).ShortCutTipsChk)
  else
    TCustomizeFrm(AObj).ShortCutTipsChk := TCheckBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_OptionsBevel1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OptionsBevel1: TBevel;

  if IsGet then
    Result := TBevel_sw.ToVar(TCustomizeFrm(AObj).OptionsBevel1)
  else
    TCustomizeFrm(AObj).OptionsBevel1 := TBevel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_OtherLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OtherLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).OtherLbl)
  else
    TCustomizeFrm(AObj).OtherLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionImages: TImageList;

  if IsGet then
    Result := TImageList_sw.ToVar(TCustomizeFrm(AObj).ActionImages)
  else
    TCustomizeFrm(AObj).ActionImages := TImageList_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_Label1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Label1: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).Label1)
  else
    TCustomizeFrm(AObj).Label1 := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_MenuAnimationStyles_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuAnimationStyles: TComboBox;

  if IsGet then
    Result := TComboBox_sw.ToVar(TCustomizeFrm(AObj).MenuAnimationStyles)
  else
    TCustomizeFrm(AObj).MenuAnimationStyles := TComboBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_InfoLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var InfoLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).InfoLbl)
  else
    TCustomizeFrm(AObj).InfoLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_DescGroupBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DescGroupBox: TGroupBox;

  if IsGet then
    Result := TGroupBox_sw.ToVar(TCustomizeFrm(AObj).DescGroupBox)
  else
    TCustomizeFrm(AObj).DescGroupBox := TGroupBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_HintLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).HintLbl)
  else
    TCustomizeFrm(AObj).HintLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionsCatLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionsCatLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).ActionsCatLbl)
  else
    TCustomizeFrm(AObj).ActionsCatLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CatList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CatList: TListBox;

  if IsGet then
    Result := TListBox_sw.ToVar(TCustomizeFrm(AObj).CatList)
  else
    TCustomizeFrm(AObj).CatList := TListBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionsList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionsList: TListBox;

  if IsGet then
    Result := TListBox_sw.ToVar(TCustomizeFrm(AObj).ActionsList)
  else
    TCustomizeFrm(AObj).ActionsList := TListBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionsActionsLbl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionsActionsLbl: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).ActionsActionsLbl)
  else
    TCustomizeFrm(AObj).ActionsActionsLbl := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ActionList1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ActionList1: TActionList;

  if IsGet then
    Result := TActionList_sw.ToVar(TCustomizeFrm(AObj).ActionList1)
  else
    TCustomizeFrm(AObj).ActionList1 := TActionList_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ResetActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResetActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).ResetActn)
  else
    TCustomizeFrm(AObj).ResetActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CloseActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CloseActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).CloseActn)
  else
    TCustomizeFrm(AObj).CloseActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ResetUsageDataActn_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResetUsageDataActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).ResetUsageDataActn)
  else
    TCustomizeFrm(AObj).ResetUsageDataActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_RecentlyUsedActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecentlyUsedActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).RecentlyUsedActn)
  else
    TCustomizeFrm(AObj).RecentlyUsedActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_FullMenusActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FullMenusActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).FullMenusActn)
  else
    TCustomizeFrm(AObj).FullMenusActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ShowHintsActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShowHintsActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).ShowHintsActn)
  else
    TCustomizeFrm(AObj).ShowHintsActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ShowShortCutsInTipsActn_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShowShortCutsInTipsActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).ShowShortCutsInTipsActn)
  else
    TCustomizeFrm(AObj).ShowShortCutsInTipsActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ListPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ListPanel: TPanel;

  if IsGet then
    Result := TPanel_sw.ToVar(TCustomizeFrm(AObj).ListPanel)
  else
    TCustomizeFrm(AObj).ListPanel := TPanel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ComboPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ComboPanel: TPanel;

  if IsGet then
    Result := TPanel_sw.ToVar(TCustomizeFrm(AObj).ComboPanel)
  else
    TCustomizeFrm(AObj).ComboPanel := TPanel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ListCombo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ListCombo: TComboBox;

  if IsGet then
    Result := TComboBox_sw.ToVar(TCustomizeFrm(AObj).ListCombo)
  else
    TCustomizeFrm(AObj).ListCombo := TComboBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ApplyToAllActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ApplyToAllActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).ApplyToAllActn)
  else
    TCustomizeFrm(AObj).ApplyToAllActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CaptionOptionsGrp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CaptionOptionsGrp: TGroupBox;

  if IsGet then
    Result := TGroupBox_sw.ToVar(TCustomizeFrm(AObj).CaptionOptionsGrp)
  else
    TCustomizeFrm(AObj).CaptionOptionsGrp := TGroupBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_ApplyToAllChk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ApplyToAllChk: TCheckBox;

  if IsGet then
    Result := TCheckBox_sw.ToVar(TCustomizeFrm(AObj).ApplyToAllChk)
  else
    TCustomizeFrm(AObj).ApplyToAllChk := TCheckBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_Label4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Label4: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).Label4)
  else
    TCustomizeFrm(AObj).Label4 := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_LargeIconsActn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LargeIconsActn: TAction;

  if IsGet then
    Result := TAction_sw.ToVar(TCustomizeFrm(AObj).LargeIconsActn)
  else
    TCustomizeFrm(AObj).LargeIconsActn := TAction_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CaptionOptionsCombo_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CaptionOptionsCombo: TComboBox;

  if IsGet then
    Result := TComboBox_sw.ToVar(TCustomizeFrm(AObj).CaptionOptionsCombo)
  else
    TCustomizeFrm(AObj).CaptionOptionsCombo := TComboBox_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_Label2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Label2: TLabel;

  if IsGet then
    Result := TLabel_sw.ToVar(TCustomizeFrm(AObj).Label2)
  else
    TCustomizeFrm(AObj).Label2 := TLabel_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_SeparatorBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SeparatorBtn: TButton;

  if IsGet then
    Result := TButton_sw.ToVar(TCustomizeFrm(AObj).SeparatorBtn)
  else
    TCustomizeFrm(AObj).SeparatorBtn := TButton_sw.FromVar(AArgs[0]);
end;

function TCustomizeFrm_CatListClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CatListClick(Sender: TObject);

  TCustomizeFrm(AObj).CatListClick(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionsListStartDrag_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDragObject;
begin
  // procedure ActionsListStartDrag(Sender: TObject; var DragO...

  v_1 := TDragObject_sw.FromVar(AArgs[1]);
  TCustomizeFrm(AObj).ActionsListStartDrag(TObject_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TDragObject_sw.ToVar(v_1));
end;

function TCustomizeFrm_FormClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TCloseAction;
begin
  // procedure FormClose(Sender: TObject; var Action: TCloseAc...

  v_1 := TCloseAction_sw.FromVar(AArgs[1]);
  TCustomizeFrm(AObj).FormClose(TObject_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TCloseAction_sw.ToVar(v_1));
end;

function TCustomizeFrm_CloseBtnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseBtnClick(Sender: TObject);

  TCustomizeFrm(AObj).CloseBtnClick(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_CatListStartDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDragObject;
begin
  // procedure CatListStartDrag(Sender: TObject; var DragObjec...

  v_1 := TDragObject_sw.FromVar(AArgs[1]);
  TCustomizeFrm(AObj).CatListStartDrag(TObject_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TDragObject_sw.ToVar(v_1));
end;

function TCustomizeFrm_ActionBarListClickCheck_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ActionBarListClickCheck(Sender: TObject);

  TCustomizeFrm(AObj).ActionBarListClickCheck(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionsListMeasureItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // procedure ActionsListMeasureItem(Control: TWinControl; In...

  v_1 := Integer(AArgs[2]);
  TCustomizeFrm(AObj).ActionsListMeasureItem(TWinControl_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function TCustomizeFrm_FormCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FormCreate(Sender: TObject);

  TCustomizeFrm(AObj).FormCreate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionsListClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ActionsListClick(Sender: TObject);

  TCustomizeFrm(AObj).ActionsListClick(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_MenuAnimationStylesChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MenuAnimationStylesChange(Sender: TObject);

  TCustomizeFrm(AObj).MenuAnimationStylesChange(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ResetActnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetActnUpdate(Sender: TObject);

  TCustomizeFrm(AObj).ResetActnUpdate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ResetActnExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).ResetActnExecute(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ResetUsageDataActnExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetUsageDataActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).ResetUsageDataActnExecute(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_RecentlyUsedActnExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RecentlyUsedActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).RecentlyUsedActnExecute(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ShowHintsActnExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowHintsActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).ShowHintsActnExecute(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ShowHintsActnUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowHintsActnUpdate(Sender: TObject);

  TCustomizeFrm(AObj).ShowHintsActnUpdate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ShowShortCutsInTipsActnExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowShortCutsInTipsActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).ShowShortCutsInTipsActnExecute(TObject_sw.FromVar(
    AArgs[0]));
end;

function TCustomizeFrm_RecentlyUsedActnUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RecentlyUsedActnUpdate(Sender: TObject);

  TCustomizeFrm(AObj).RecentlyUsedActnUpdate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionBarListClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ActionBarListClick(Sender: TObject);

  TCustomizeFrm(AObj).ActionBarListClick(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionsListData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // procedure ActionsListData(Control: TWinControl; Index: In...

  v_1 := string(AArgs[2]);
  TCustomizeFrm(AObj).ActionsListData(TWinControl_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function TCustomizeFrm_LargeIconsActnExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LargeIconsActnExecute(Sender: TObject);

  TCustomizeFrm(AObj).LargeIconsActnExecute(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ListComboSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ListComboSelect(Sender: TObject);

  TCustomizeFrm(AObj).ListComboSelect(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_CaptionOptionsComboChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CaptionOptionsComboChange(Sender: TObject);

  TCustomizeFrm(AObj).CaptionOptionsComboChange(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_FormResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FormResize(Sender: TObject);

  TCustomizeFrm(AObj).FormResize(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_LargeIconsActnUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LargeIconsActnUpdate(Sender: TObject);

  TCustomizeFrm(AObj).LargeIconsActnUpdate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_SeparatorBtnStartDrag_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDragObject;
begin
  // procedure SeparatorBtnStartDrag(Sender: TObject; var Drag...

  v_1 := TDragObject_sw.FromVar(AArgs[1]);
  TCustomizeFrm(AObj).SeparatorBtnStartDrag(TObject_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TDragObject_sw.ToVar(v_1));
end;

function TCustomizeFrm_ApplyToAllActnUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyToAllActnUpdate(Sender: TObject);

  TCustomizeFrm(AObj).ApplyToAllActnUpdate(TObject_sw.FromVar(AArgs[0]));
end;

function TCustomizeFrm_ActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter...

  if IsGet then
    Result := TCustomActionManager_sw.ToVar(TCustomizeFrm(AObj).ActionManager)
  else
    TCustomizeFrm(AObj).ActionManager := TCustomActionManager_sw.FromVar(
      AArgs[0]);
end;

function TCustomizeFrm_ActiveActionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveActionList: TCustomActionList read <getter...

  if IsGet then
    Result := TCustomActionList_sw.ToVar(TCustomizeFrm(AObj).ActiveActionList)
  else
    TCustomizeFrm(AObj).ActiveActionList := TCustomActionList_sw.FromVar(
      AArgs[0]);
end;

class function TCustomizeFrm_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeFrm';
end;

class function TCustomizeFrm_sw.GetWrappedClass: TClass;
begin
  Result := TCustomizeFrm;
end;

class procedure TCustomizeFrm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddField('CloseBtn', TCustomizeFrm_CloseBtn_si, TButton_sw);
  AData.AddField('Tabs', TCustomizeFrm_Tabs_si, TPageControl_sw);
  AData.AddField('ToolbarsTab', TCustomizeFrm_ToolbarsTab_si, TTabSheet_sw);
  AData.AddField('ActionsTab', TCustomizeFrm_ActionsTab_si, TTabSheet_sw);
  AData.AddField('OptionsTab', TCustomizeFrm_OptionsTab_si, TTabSheet_sw);
  AData.AddField('ToolbarsLbl', TCustomizeFrm_ToolbarsLbl_si, TLabel_sw);
  AData.AddField('ActionBarList', TCustomizeFrm_ActionBarList_si, TCheckListBox_sw);
  AData.AddField('ResetBtn', TCustomizeFrm_ResetBtn_si, TButton_sw);
  AData.AddField('CloseMenu', TCustomizeFrm_CloseMenu_si, TPopupMenu_sw);
  AData.AddField('CloseItem', TCustomizeFrm_CloseItem_si, TMenuItem_sw);
  AData.AddField('PersonalizeLbl', TCustomizeFrm_PersonalizeLbl_si, TLabel_sw);
  AData.AddField('OptionsBevel2', TCustomizeFrm_OptionsBevel2_si, TBevel_sw);
  AData.AddField('RecentlyUsedChk', TCustomizeFrm_RecentlyUsedChk_si, TCheckBox_sw);
  AData.AddField('ResetUsageBtn', TCustomizeFrm_ResetUsageBtn_si, TButton_sw);
  AData.AddField('LargeIconsChk', TCustomizeFrm_LargeIconsChk_si, TCheckBox_sw);
  AData.AddField('ShowTipsChk', TCustomizeFrm_ShowTipsChk_si, TCheckBox_sw);
  AData.AddField('ShortCutTipsChk', TCustomizeFrm_ShortCutTipsChk_si, TCheckBox_sw);
  AData.AddField('OptionsBevel1', TCustomizeFrm_OptionsBevel1_si, TBevel_sw);
  AData.AddField('OtherLbl', TCustomizeFrm_OtherLbl_si, TLabel_sw);
  AData.AddField('ActionImages', TCustomizeFrm_ActionImages_si, TImageList_sw);
  AData.AddField('Label1', TCustomizeFrm_Label1_si, TLabel_sw);
  AData.AddField('MenuAnimationStyles', TCustomizeFrm_MenuAnimationStyles_si, TComboBox_sw);
  AData.AddField('InfoLbl', TCustomizeFrm_InfoLbl_si, TLabel_sw);
  AData.AddField('DescGroupBox', TCustomizeFrm_DescGroupBox_si, TGroupBox_sw);
  AData.AddField('HintLbl', TCustomizeFrm_HintLbl_si, TLabel_sw);
  AData.AddField('ActionsCatLbl', TCustomizeFrm_ActionsCatLbl_si, TLabel_sw);
  AData.AddField('CatList', TCustomizeFrm_CatList_si, TListBox_sw);
  AData.AddField('ActionsList', TCustomizeFrm_ActionsList_si, TListBox_sw);
  AData.AddField('ActionsActionsLbl', TCustomizeFrm_ActionsActionsLbl_si, TLabel_sw);
  AData.AddField('ActionList1', TCustomizeFrm_ActionList1_si, TActionList_sw);
  AData.AddField('ResetActn', TCustomizeFrm_ResetActn_si, TAction_sw);
  AData.AddField('CloseActn', TCustomizeFrm_CloseActn_si, TAction_sw);
  AData.AddField('ResetUsageDataActn', TCustomizeFrm_ResetUsageDataActn_si, TAction_sw);
  AData.AddField('RecentlyUsedActn', TCustomizeFrm_RecentlyUsedActn_si, TAction_sw);
  AData.AddField('FullMenusActn', TCustomizeFrm_FullMenusActn_si, TAction_sw);
  AData.AddField('ShowHintsActn', TCustomizeFrm_ShowHintsActn_si, TAction_sw);
  AData.AddField('ShowShortCutsInTipsActn', TCustomizeFrm_ShowShortCutsInTipsActn_si, TAction_sw);
  AData.AddField('ListPanel', TCustomizeFrm_ListPanel_si, TPanel_sw);
  AData.AddField('ComboPanel', TCustomizeFrm_ComboPanel_si, TPanel_sw);
  AData.AddField('ListCombo', TCustomizeFrm_ListCombo_si, TComboBox_sw);
  AData.AddField('ApplyToAllActn', TCustomizeFrm_ApplyToAllActn_si, TAction_sw);
  AData.AddField('CaptionOptionsGrp', TCustomizeFrm_CaptionOptionsGrp_si, TGroupBox_sw);
  AData.AddField('ApplyToAllChk', TCustomizeFrm_ApplyToAllChk_si, TCheckBox_sw);
  AData.AddField('Label4', TCustomizeFrm_Label4_si, TLabel_sw);
  AData.AddField('LargeIconsActn', TCustomizeFrm_LargeIconsActn_si, TAction_sw);
  AData.AddField('CaptionOptionsCombo', TCustomizeFrm_CaptionOptionsCombo_si, TComboBox_sw);
  AData.AddField('Label2', TCustomizeFrm_Label2_si, TLabel_sw);
  AData.AddField('SeparatorBtn', TCustomizeFrm_SeparatorBtn_si, TButton_sw);
  AData.AddProcedure('CatListClick', TCustomizeFrm_CatListClick_si, 1, False);
  AData.AddProcedure('ActionsListStartDrag', TCustomizeFrm_ActionsListStartDrag_si, 2, False);
  AData.AddProcedure('FormClose', TCustomizeFrm_FormClose_si, 2, False);
  AData.AddProcedure('CloseBtnClick', TCustomizeFrm_CloseBtnClick_si, 1, False);
  AData.AddProcedure('CatListStartDrag', TCustomizeFrm_CatListStartDrag_si, 2, False);
  AData.AddProcedure('ActionBarListClickCheck', TCustomizeFrm_ActionBarListClickCheck_si, 1, False);
  AData.AddProcedure('ActionsListMeasureItem', TCustomizeFrm_ActionsListMeasureItem_si, 3, False);
  AData.AddProcedure('FormCreate', TCustomizeFrm_FormCreate_si, 1, False);
  AData.AddProcedure('ActionsListClick', TCustomizeFrm_ActionsListClick_si, 1, False);
  AData.AddProcedure('MenuAnimationStylesChange', TCustomizeFrm_MenuAnimationStylesChange_si, 1, False);
  AData.AddProcedure('ResetActnUpdate', TCustomizeFrm_ResetActnUpdate_si, 1, False);
  AData.AddProcedure('ResetActnExecute', TCustomizeFrm_ResetActnExecute_si, 1, False);
  AData.AddProcedure('ResetUsageDataActnExecute', TCustomizeFrm_ResetUsageDataActnExecute_si, 1, False);
  AData.AddProcedure('RecentlyUsedActnExecute', TCustomizeFrm_RecentlyUsedActnExecute_si, 1, False);
  AData.AddProcedure('ShowHintsActnExecute', TCustomizeFrm_ShowHintsActnExecute_si, 1, False);
  AData.AddProcedure('ShowHintsActnUpdate', TCustomizeFrm_ShowHintsActnUpdate_si, 1, False);
  AData.AddProcedure('ShowShortCutsInTipsActnExecute', TCustomizeFrm_ShowShortCutsInTipsActnExecute_si, 1, False);
  AData.AddProcedure('RecentlyUsedActnUpdate', TCustomizeFrm_RecentlyUsedActnUpdate_si, 1, False);
  AData.AddProcedure('ActionBarListClick', TCustomizeFrm_ActionBarListClick_si, 1, False);
  AData.AddProcedure('ActionsListData', TCustomizeFrm_ActionsListData_si, 3, False);
  AData.AddProcedure('LargeIconsActnExecute', TCustomizeFrm_LargeIconsActnExecute_si, 1, False);
  AData.AddProcedure('ListComboSelect', TCustomizeFrm_ListComboSelect_si, 1, False);
  AData.AddProcedure('CaptionOptionsComboChange', TCustomizeFrm_CaptionOptionsComboChange_si, 1, False);
  AData.AddProcedure('FormResize', TCustomizeFrm_FormResize_si, 1, False);
  AData.AddProcedure('LargeIconsActnUpdate', TCustomizeFrm_LargeIconsActnUpdate_si, 1, False);
  AData.AddProcedure('SeparatorBtnStartDrag', TCustomizeFrm_SeparatorBtnStartDrag_si, 2, False);
  AData.AddProcedure('ApplyToAllActnUpdate', TCustomizeFrm_ApplyToAllActnUpdate_si, 1, False);
  AData.AddProperty('ActionManager', TCustomizeFrm_ActionManager_si, TCustomActionManager_sw, True, True, 0, False, False);
  AData.AddProperty('ActiveActionList', TCustomizeFrm_ActiveActionList_si, TCustomActionList_sw, True, True, 0, False, False);
end;

class function TCustomizeFrm_sw.ToVar(const AValue: TCustomizeFrm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeFrm_sw.FromVar(
  const AValue: OleVariant): TCustomizeFrm;
begin
  Result := TCustomizeFrm(ConvFromVar(AValue, TCustomizeFrm));
end;

class function TCustomizeFrm_sw.ClassToVar(
  AClass: TCustomizeFrm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomizeFrm_sw.ClassFromVar(
  const AClass: OleVariant): TCustomizeFrm_sc;
begin
  Result := TCustomizeFrm_sc(ConvClsFromVar(AClass, TCustomizeFrm));
end;

{ TCustomizeDlg_sw }

function TCustomizeDlg_Show_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Show;

  TCustomizeDlg(AObj).Show();
end;

function TCustomizeDlg_CustomizeForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomizeForm: TCustomizeFrm read <getter>;

  Result := TCustomizeFrm_sw.ToVar(TCustomizeDlg(AObj).CustomizeForm);
end;

function TCustomizeDlg_ActionManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionManager: TCustomActionManager read <getter...

  if IsGet then
    Result := TCustomActionManager_sw.ToVar(TCustomizeDlg(AObj).ActionManager)
  else
    TCustomizeDlg(AObj).ActionManager := TCustomActionManager_sw.FromVar(
      AArgs[0]);
end;

function TCustomizeDlg_StayOnTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StayOnTop: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomizeDlg(AObj).StayOnTop
  else
    TCustomizeDlg(AObj).StayOnTop := Boolean(AArgs[0]);
end;

function TCustomizeDlg_OnClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClose: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomizeDlg(AObj).OnClose)
  else
    TCustomizeDlg(AObj).OnClose := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomizeDlg_OnShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShow: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomizeDlg(AObj).OnShow)
  else
    TCustomizeDlg(AObj).OnShow := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomizeDlg_sw.GetTypeName: WideString;
begin
  Result := 'TCustomizeDlg';
end;

class function TCustomizeDlg_sw.GetWrappedClass: TClass;
begin
  Result := TCustomizeDlg;
end;

class procedure TCustomizeDlg_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Show', TCustomizeDlg_Show_si, 0, False);
  AData.AddProperty('CustomizeForm', TCustomizeDlg_CustomizeForm_si, TCustomizeFrm_sw, True, False, 0, False, False);
  AData.AddProperty('ActionManager', TCustomizeDlg_ActionManager_si, TCustomActionManager_sw, True, True, 0, False, False);
  AData.AddProperty('StayOnTop', TCustomizeDlg_StayOnTop_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnClose', TCustomizeDlg_OnClose_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShow', TCustomizeDlg_OnShow_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCustomizeDlg_sw.ToVar(const AValue: TCustomizeDlg): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomizeDlg_sw.FromVar(
  const AValue: OleVariant): TCustomizeDlg;
begin
  Result := TCustomizeDlg(ConvFromVar(AValue, TCustomizeDlg));
end;

class function TCustomizeDlg_sw.ClassToVar(
  AClass: TCustomizeDlg_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomizeDlg_sw.ClassFromVar(
  const AClass: OleVariant): TCustomizeDlg_sc;
begin
  Result := TCustomizeDlg_sc(ConvClsFromVar(AClass, TCustomizeDlg));
end;

{ CustomizeDlg_sw }

function CustomizeDlg_TCustomizeFrm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeFrm = class(TForm);

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeFrm_sw);
end;

function CustomizeDlg_TCustomizeDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomizeDlg = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomizeDlg_sw);
end;

class function CustomizeDlg_sw.GetUnitName: WideString;
begin
  Result := 'CustomizeDlg';
end;

class procedure CustomizeDlg_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomizeFrm_sw, CustomizeDlg_TCustomizeFrm_si);
  AData.AddType(TCustomizeDlg_sw, CustomizeDlg_TCustomizeDlg_si);
end;

class function CustomizeDlg_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CustomizeDlg_sw);
end;

initialization
  RegisterUnitWrapper(CustomizeDlg_sw);
  RegisterClassWrapper(TCustomizeFrm_sw);
  RegisterClassWrapper(TCustomizeDlg_sw);

end.
