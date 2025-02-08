unit CommCtrl_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'CommCtrl' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Types, Messages, Windows, CommCtrl,
  Messages_LMDSW, Windows_LMDSW;


{ Unit wrapper }

type
  CommCtrl_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ CommCtrl_sw }

function CommCtrl_Header_SetBitmapMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_SetBitmapMargin(hwnd: HWND; iWidth: Integ...

  Result := CommCtrl.Header_SetBitmapMargin(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function CommCtrl_Header_GetBitmapMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_GetBitmapMargin(hwnd: HWND): Integer;

  Result := CommCtrl.Header_GetBitmapMargin(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_Header_SetFilterChangeTimeout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_SetFilterChangeTimeout(hwnd: HWND; i: Int...

  Result := CommCtrl.Header_SetFilterChangeTimeout(HWND_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]));
end;

function CommCtrl_Header_EditFilter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_EditFilter(hwnd: HWND; i: Integer; fDisca...

  Result := CommCtrl.Header_EditFilter(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), BOOL_sw.FromVar(AArgs[2]));
end;

function CommCtrl_Header_ClearFilter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_ClearFilter(hwnd: HWND; i: Integer): Inte...

  Result := CommCtrl.Header_ClearFilter(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function CommCtrl_Header_ClearAllFilters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_ClearAllFilters(hwnd: HWND): Integer;

  Result := CommCtrl.Header_ClearAllFilters(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_Header_GetItemDropDownRect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function Header_GetItemDropDownRect(hwnd: HWND; iItem: In...

  v_1 := TRect_sw.FromVar(AArgs[2]);
  Result := BOOL_sw.ToVar(CommCtrl.Header_GetItemDropDownRect(HWND_sw.FromVar(
    AArgs[0]), Integer(AArgs[1]), v_1));
  AssignRefParam(AArgs[2], TRect_sw.ToVar(v_1));
end;

function CommCtrl_Header_GetOverflowRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function Header_GetOverflowRect(hwnd: HWND; var lprc: TRe...

  v_1 := TRect_sw.FromVar(AArgs[1]);
  Result := BOOL_sw.ToVar(CommCtrl.Header_GetOverflowRect(HWND_sw.FromVar(
    AArgs[0]), v_1));
  AssignRefParam(AArgs[1], TRect_sw.ToVar(v_1));
end;

function CommCtrl_Header_GetFocusedItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_GetFocusedItem(hwnd: HWND): Integer;

  Result := CommCtrl.Header_GetFocusedItem(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_Header_SetFocusedItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Header_SetFocusedItem(hwnd: HWND; iItem: Integer...

  Result := BOOL_sw.ToVar(CommCtrl.Header_SetFocusedItem(HWND_sw.FromVar(
    AArgs[0]), Integer(AArgs[1])));
end;

function CommCtrl_ListView_SetSelectedColumn_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_SetSelectedColumn(hwnd: HWND; iCol: Int...

  Result := CommCtrl.ListView_SetSelectedColumn(HWND_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]));
end;

function CommCtrl_ListView_SetView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_SetView(hwnd: HWND; iView: Integer): In...

  Result := CommCtrl.ListView_SetView(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function CommCtrl_ListView_GetView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetView(hwnd: HWND): Integer;

  Result := CommCtrl.ListView_GetView(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_ListView_RemoveGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_RemoveGroup(hwnd: HWND; iGroupId: Integ...

  Result := CommCtrl.ListView_RemoveGroup(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function CommCtrl_ListView_MoveGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_MoveGroup(hwnd: HWND; iGroupId: Integer...

  Result := CommCtrl.ListView_MoveGroup(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]));
end;

function CommCtrl_ListView_GetGroupCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetGroupCount(hwnd: HWND): Integer;

  Result := CommCtrl.ListView_GetGroupCount(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_ListView_MoveItemToGroup_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_MoveItemToGroup(hwnd: HWND; idItemFrom:...

  Result := CommCtrl.ListView_MoveItemToGroup(HWND_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]), Integer(AArgs[2]));
end;

function CommCtrl_ListView_GetGroupRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function ListView_GetGroupRect(hwnd: HWND; iGroupId: Inte...

  v_1 := TRect_sw.FromVar(AArgs[3]);
  Result := CommCtrl.ListView_GetGroupRect(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]), v_1);
  AssignRefParam(AArgs[3], TRect_sw.ToVar(v_1));
end;

function CommCtrl_ListView_EnableGroupView_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_EnableGroupView(hwnd: HWND; fEnable: BO...

  Result := CommCtrl.ListView_EnableGroupView(HWND_sw.FromVar(AArgs[0]), 
    BOOL_sw.FromVar(AArgs[1]));
end;

function CommCtrl_ListView_RemoveAllGroups_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_RemoveAllGroups(hwnd: HWND): Integer;

  Result := CommCtrl.ListView_RemoveAllGroups(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_ListView_HasGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_HasGroup(hwnd: HWND; dwGroupId: Integer...

  Result := CommCtrl.ListView_HasGroup(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]));
end;

function CommCtrl_ListView_SetGroupState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_SetGroupState(hwnd: HWND; dwGroupId: UI...

  Result := CommCtrl.ListView_SetGroupState(HWND_sw.FromVar(AArgs[0]), UINT_sw.
    FromVar(AArgs[1]), UINT_sw.FromVar(AArgs[2]), UINT_sw.FromVar(AArgs[3]));
end;

function CommCtrl_ListView_GetGroupState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetGroupState(hwnd: HWND; dwGroupId: UI...

  Result := CommCtrl.ListView_GetGroupState(HWND_sw.FromVar(AArgs[0]), UINT_sw.
    FromVar(AArgs[1]), UINT_sw.FromVar(AArgs[2]));
end;

function CommCtrl_ListView_GetFocusedGroup_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetFocusedGroup(hwnd: HWND): Integer;

  Result := CommCtrl.ListView_GetFocusedGroup(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_ListView_GetInsertMarkRect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function ListView_GetInsertMarkRect(hwnd: HWND; var rc: T...

  v_1 := TRect_sw.FromVar(AArgs[1]);
  Result := CommCtrl.ListView_GetInsertMarkRect(HWND_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TRect_sw.ToVar(v_1));
end;

function CommCtrl_ListView_SetInsertMarkColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_SetInsertMarkColor(hwnd: HWND; color: T...

  Result := TColorRef_sw.ToVar(CommCtrl.ListView_SetInsertMarkColor(HWND_sw.
    FromVar(AArgs[0]), TColorRef_sw.FromVar(AArgs[1])));
end;

function CommCtrl_ListView_GetInsertMarkColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetInsertMarkColor(hwnd: HWND): TColorRef;

  Result := TColorRef_sw.ToVar(CommCtrl.ListView_GetInsertMarkColor(HWND_sw.
    FromVar(AArgs[0])));
end;

function CommCtrl_ListView_GetSelectedColumn_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetSelectedColumn(hwnd: HWND): UINT;

  Result := UINT_sw.ToVar(CommCtrl.ListView_GetSelectedColumn(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_ListView_IsGroupViewEnabled_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_IsGroupViewEnabled(hwnd: HWND): BOOL;

  Result := BOOL_sw.ToVar(CommCtrl.ListView_IsGroupViewEnabled(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_ListView_GetOutlineColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_GetOutlineColor(hwnd: HWND): TColorRef;

  Result := TColorRef_sw.ToVar(CommCtrl.ListView_GetOutlineColor(HWND_sw.
    FromVar(AArgs[0])));
end;

function CommCtrl_ListView_SetOutlineColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_SetOutlineColor(hwnd: HWND; color: TCol...

  Result := TColorRef_sw.ToVar(CommCtrl.ListView_SetOutlineColor(HWND_sw.
    FromVar(AArgs[0]), TColorRef_sw.FromVar(AArgs[1])));
end;

function CommCtrl_ListView_CancelEditLabel_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_CancelEditLabel(hwnd: HWND): Integer;

  Result := CommCtrl.ListView_CancelEditLabel(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_ListView_MapIndexToID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_MapIndexToID(hwnd: HWND; index: UINT): ...

  Result := UINT_sw.ToVar(CommCtrl.ListView_MapIndexToID(HWND_sw.FromVar(
    AArgs[0]), UINT_sw.FromVar(AArgs[1])));
end;

function CommCtrl_ListView_MapIDToIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_MapIDToIndex(hwnd: HWND; id: UINT): UINT;

  Result := UINT_sw.ToVar(CommCtrl.ListView_MapIDToIndex(HWND_sw.FromVar(
    AArgs[0]), UINT_sw.FromVar(AArgs[1])));
end;

function CommCtrl_ListView_IsItemVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ListView_IsItemVisible(hwnd: HWND; index: UINT):...

  Result := UINT_sw.ToVar(CommCtrl.ListView_IsItemVisible(HWND_sw.FromVar(
    AArgs[0]), UINT_sw.FromVar(AArgs[1])));
end;

function CommCtrl_ListView_GetFooterRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function ListView_GetFooterRect(hwnd: HWND; var prc: TRec...

  v_1 := TRect_sw.FromVar(AArgs[1]);
  Result := BOOL_sw.ToVar(CommCtrl.ListView_GetFooterRect(HWND_sw.FromVar(
    AArgs[0]), v_1));
  AssignRefParam(AArgs[1], TRect_sw.ToVar(v_1));
end;

function CommCtrl_ListView_GetFooterItemRect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function ListView_GetFooterItemRect(hwnd: HWND; iItem: UI...

  v_1 := TRect_sw.FromVar(AArgs[2]);
  Result := BOOL_sw.ToVar(CommCtrl.ListView_GetFooterItemRect(HWND_sw.FromVar(
    AArgs[0]), UINT_sw.FromVar(AArgs[1]), v_1));
  AssignRefParam(AArgs[2], TRect_sw.ToVar(v_1));
end;

function CommCtrl_TreeView_SetLineColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_SetLineColor(hwnd: HWND; clr: TColorRef...

  Result := TColorRef_sw.ToVar(CommCtrl.TreeView_SetLineColor(HWND_sw.FromVar(
    AArgs[0]), TColorRef_sw.FromVar(AArgs[1])));
end;

function CommCtrl_TreeView_GetLineColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_GetLineColor(hwnd: HWND): Integer;

  Result := CommCtrl.TreeView_GetLineColor(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_TreeView_SetExtendedStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_SetExtendedStyle(hwnd: HWND; dw: DWORD;...

  Result := UINT_sw.ToVar(CommCtrl.TreeView_SetExtendedStyle(HWND_sw.FromVar(
    AArgs[0]), DWORD_sw.FromVar(AArgs[1]), UINT_sw.FromVar(AArgs[2])));
end;

function CommCtrl_TreeView_GetExtendedStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_GetExtendedStyle(hwnd: HWND): DWORD;

  Result := DWORD_sw.ToVar(CommCtrl.TreeView_GetExtendedStyle(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_TreeView_SetAutoScrollInfo_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_SetAutoScrollInfo(hwnd: HWND; uPixPerSe...

  Result := LRESULT_sw.ToVar(CommCtrl.TreeView_SetAutoScrollInfo(HWND_sw.
    FromVar(AArgs[0]), UINT_sw.FromVar(AArgs[1]), UINT_sw.FromVar(AArgs[2])));
end;

function CommCtrl_TreeView_GetSelectedCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TreeView_GetSelectedCount(hwnd: HWND): DWORD;

  Result := DWORD_sw.ToVar(CommCtrl.TreeView_GetSelectedCount(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_Button_GetIdealSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TSize;
begin
  // function Button_GetIdealSize(hwnd: HWND; var psize: TSize...

  v_1 := TSize_sw.FromVar(AArgs[1]);
  Result := BOOL_sw.ToVar(CommCtrl.Button_GetIdealSize(HWND_sw.FromVar(
    AArgs[0]), v_1));
  AssignRefParam(AArgs[1], TSize_sw.ToVar(v_1));
end;

function CommCtrl_Button_SetTextMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Button_SetTextMargin(hwnd: HWND; const pmargin: ...

  Result := BOOL_sw.ToVar(CommCtrl.Button_SetTextMargin(HWND_sw.FromVar(
    AArgs[0]), TRect_sw.FromVar(AArgs[1])));
end;

function CommCtrl_Button_GetTextMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function Button_GetTextMargin(hwnd: HWND; var pmargin: TR...

  v_1 := TRect_sw.FromVar(AArgs[1]);
  Result := BOOL_sw.ToVar(CommCtrl.Button_GetTextMargin(HWND_sw.FromVar(
    AArgs[0]), v_1));
  AssignRefParam(AArgs[1], TRect_sw.ToVar(v_1));
end;

function CommCtrl_Button_SetDropDownState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Button_SetDropDownState(hwnd: HWND; fDropDown: B...

  Result := BOOL_sw.ToVar(CommCtrl.Button_SetDropDownState(HWND_sw.FromVar(
    AArgs[0]), BOOL_sw.FromVar(AArgs[1])));
end;

function CommCtrl_Button_GetNoteLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Button_GetNoteLength(hwnd: HWND): LRESULT;

  Result := LRESULT_sw.ToVar(CommCtrl.Button_GetNoteLength(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_Button_SetElevationRequiredState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Button_SetElevationRequiredState(hwnd: HWND; fRe...

  Result := LRESULT_sw.ToVar(CommCtrl.Button_SetElevationRequiredState(HWND_sw.
    FromVar(AArgs[0]), BOOL_sw.FromVar(AArgs[1])));
end;

function CommCtrl_Edit_HideBalloonTip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Edit_HideBalloonTip(hwnd: HWND): BOOL;

  Result := BOOL_sw.ToVar(CommCtrl.Edit_HideBalloonTip(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_Edit_SetHilite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Edit_SetHilite(hwndCtl: HWND; ichStart: Integer...

  CommCtrl.Edit_SetHilite(HWND_sw.FromVar(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]));
end;

function CommCtrl_Edit_GetHilite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Edit_GetHilite(hwndCtl: HWND): LRESULT;

  Result := LRESULT_sw.ToVar(CommCtrl.Edit_GetHilite(HWND_sw.FromVar(
    AArgs[0])));
end;

function CommCtrl_ComboBox_SetMinVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ComboBox_SetMinVisible(hwnd: HWND; iMinVisible: ...

  Result := BOOL_sw.ToVar(CommCtrl.ComboBox_SetMinVisible(HWND_sw.FromVar(
    AArgs[0]), Integer(AArgs[1])));
end;

function CommCtrl_ComboBox_GetMinVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ComboBox_GetMinVisible(hwnd: HWND): Integer;

  Result := CommCtrl.ComboBox_GetMinVisible(HWND_sw.FromVar(AArgs[0]));
end;

function CommCtrl_DefSubclassProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefSubclassProc(hWnd: HWND; uMsg: UINT; wParam: ...

  Result := LRESULT_sw.ToVar(CommCtrl.DefSubclassProc(HWND_sw.FromVar(AArgs[0]),
    UINT_sw.FromVar(AArgs[1]), WPARAM_sw.FromVar(AArgs[2]), LPARAM_sw.FromVar(
    AArgs[3])));
end;

class function CommCtrl_sw.GetUnitName: WideString;
begin
  Result := 'CommCtrl';
end;

class procedure CommCtrl_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddFunction('Header_SetBitmapMargin', CommCtrl_Header_SetBitmapMargin_si, Integer_sw, 2, False);
  AData.AddFunction('Header_GetBitmapMargin', CommCtrl_Header_GetBitmapMargin_si, Integer_sw, 1, False);
  AData.AddFunction('Header_SetFilterChangeTimeout', CommCtrl_Header_SetFilterChangeTimeout_si, Integer_sw, 2, False);
  AData.AddFunction('Header_EditFilter', CommCtrl_Header_EditFilter_si, Integer_sw, 3, False);
  AData.AddFunction('Header_ClearFilter', CommCtrl_Header_ClearFilter_si, Integer_sw, 2, False);
  AData.AddFunction('Header_ClearAllFilters', CommCtrl_Header_ClearAllFilters_si, Integer_sw, 1, False);
  AData.AddFunction('Header_GetItemDropDownRect', CommCtrl_Header_GetItemDropDownRect_si, BOOL_sw, 3, False);
  AData.AddFunction('Header_GetOverflowRect', CommCtrl_Header_GetOverflowRect_si, BOOL_sw, 2, False);
  AData.AddFunction('Header_GetFocusedItem', CommCtrl_Header_GetFocusedItem_si, Integer_sw, 1, False);
  AData.AddFunction('Header_SetFocusedItem', CommCtrl_Header_SetFocusedItem_si, BOOL_sw, 2, False);
  AData.AddFunction('ListView_SetSelectedColumn', CommCtrl_ListView_SetSelectedColumn_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_SetView', CommCtrl_ListView_SetView_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_GetView', CommCtrl_ListView_GetView_si, Integer_sw, 1, False);
  AData.AddFunction('ListView_RemoveGroup', CommCtrl_ListView_RemoveGroup_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_MoveGroup', CommCtrl_ListView_MoveGroup_si, Integer_sw, 3, False);
  AData.AddFunction('ListView_GetGroupCount', CommCtrl_ListView_GetGroupCount_si, Integer_sw, 1, False);
  AData.AddFunction('ListView_MoveItemToGroup', CommCtrl_ListView_MoveItemToGroup_si, Integer_sw, 3, False);
  AData.AddFunction('ListView_GetGroupRect', CommCtrl_ListView_GetGroupRect_si, Integer_sw, 4, False);
  AData.AddFunction('ListView_EnableGroupView', CommCtrl_ListView_EnableGroupView_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_RemoveAllGroups', CommCtrl_ListView_RemoveAllGroups_si, Integer_sw, 1, False);
  AData.AddFunction('ListView_HasGroup', CommCtrl_ListView_HasGroup_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_SetGroupState', CommCtrl_ListView_SetGroupState_si, Integer_sw, 4, False);
  AData.AddFunction('ListView_GetGroupState', CommCtrl_ListView_GetGroupState_si, Integer_sw, 3, False);
  AData.AddFunction('ListView_GetFocusedGroup', CommCtrl_ListView_GetFocusedGroup_si, Integer_sw, 1, False);
  AData.AddFunction('ListView_GetInsertMarkRect', CommCtrl_ListView_GetInsertMarkRect_si, Integer_sw, 2, False);
  AData.AddFunction('ListView_SetInsertMarkColor', CommCtrl_ListView_SetInsertMarkColor_si, TColorRef_sw, 2, False);
  AData.AddFunction('ListView_GetInsertMarkColor', CommCtrl_ListView_GetInsertMarkColor_si, TColorRef_sw, 1, False);
  AData.AddFunction('ListView_GetSelectedColumn', CommCtrl_ListView_GetSelectedColumn_si, UINT_sw, 1, False);
  AData.AddFunction('ListView_IsGroupViewEnabled', CommCtrl_ListView_IsGroupViewEnabled_si, BOOL_sw, 1, False);
  AData.AddFunction('ListView_GetOutlineColor', CommCtrl_ListView_GetOutlineColor_si, TColorRef_sw, 1, False);
  AData.AddFunction('ListView_SetOutlineColor', CommCtrl_ListView_SetOutlineColor_si, TColorRef_sw, 2, False);
  AData.AddFunction('ListView_CancelEditLabel', CommCtrl_ListView_CancelEditLabel_si, Integer_sw, 1, False);
  AData.AddFunction('ListView_MapIndexToID', CommCtrl_ListView_MapIndexToID_si, UINT_sw, 2, False);
  AData.AddFunction('ListView_MapIDToIndex', CommCtrl_ListView_MapIDToIndex_si, UINT_sw, 2, False);
  AData.AddFunction('ListView_IsItemVisible', CommCtrl_ListView_IsItemVisible_si, UINT_sw, 2, False);
  AData.AddFunction('ListView_GetFooterRect', CommCtrl_ListView_GetFooterRect_si, BOOL_sw, 2, False);
  AData.AddFunction('ListView_GetFooterItemRect', CommCtrl_ListView_GetFooterItemRect_si, BOOL_sw, 3, False);
  AData.AddFunction('TreeView_SetLineColor', CommCtrl_TreeView_SetLineColor_si, TColorRef_sw, 2, False);
  AData.AddFunction('TreeView_GetLineColor', CommCtrl_TreeView_GetLineColor_si, Integer_sw, 1, False);
  AData.AddFunction('TreeView_SetExtendedStyle', CommCtrl_TreeView_SetExtendedStyle_si, UINT_sw, 3, False);
  AData.AddFunction('TreeView_GetExtendedStyle', CommCtrl_TreeView_GetExtendedStyle_si, DWORD_sw, 1, False);
  AData.AddFunction('TreeView_SetAutoScrollInfo', CommCtrl_TreeView_SetAutoScrollInfo_si, LRESULT_sw, 3, False);
  AData.AddFunction('TreeView_GetSelectedCount', CommCtrl_TreeView_GetSelectedCount_si, DWORD_sw, 1, False);
  AData.AddFunction('Button_GetIdealSize', CommCtrl_Button_GetIdealSize_si, BOOL_sw, 2, False);
  AData.AddFunction('Button_SetTextMargin', CommCtrl_Button_SetTextMargin_si, BOOL_sw, 2, False);
  AData.AddFunction('Button_GetTextMargin', CommCtrl_Button_GetTextMargin_si, BOOL_sw, 2, False);
  AData.AddFunction('Button_SetDropDownState', CommCtrl_Button_SetDropDownState_si, BOOL_sw, 2, False);
  AData.AddFunction('Button_GetNoteLength', CommCtrl_Button_GetNoteLength_si, LRESULT_sw, 1, False);
  AData.AddFunction('Button_SetElevationRequiredState', CommCtrl_Button_SetElevationRequiredState_si, LRESULT_sw, 2, False);
  AData.AddFunction('Edit_HideBalloonTip', CommCtrl_Edit_HideBalloonTip_si, BOOL_sw, 1, False);
  AData.AddProcedure('Edit_SetHilite', CommCtrl_Edit_SetHilite_si, 3, False);
  AData.AddFunction('Edit_GetHilite', CommCtrl_Edit_GetHilite_si, LRESULT_sw, 1, False);
  AData.AddFunction('ComboBox_SetMinVisible', CommCtrl_ComboBox_SetMinVisible_si, BOOL_sw, 2, False);
  AData.AddFunction('ComboBox_GetMinVisible', CommCtrl_ComboBox_GetMinVisible_si, Integer_sw, 1, False);
  AData.AddFunction('DefSubclassProc', CommCtrl_DefSubclassProc_si, LRESULT_sw, 4, False);
end;

class function CommCtrl_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CommCtrl_sw);
end;

initialization
  RegisterUnitWrapper(CommCtrl_sw);

end.
