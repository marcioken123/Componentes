{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       description : adapter unit - converts RAI2 calls to delphi calls

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}
{$INCLUDE RA.INC}

unit RAI2_Menus;

interface

uses RAI2;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);

implementation

uses Classes, Menus;


  { EMenuError }

  { TMenuItem }

{ constructor Create(AOwner: TComponent) }
procedure TMenuItem_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMenuItem.Create(V2O(Args.Values[0]) as TComponent));
end;

{  procedure Insert(Index: Integer; Item: TMenuItem); }
procedure TMenuItem_Insert(var Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Insert(Args.Values[0], V2O(Args.Values[1]) as TMenuItem);
end;

{  procedure Delete(Index: Integer); }
procedure TMenuItem_Delete(var Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Delete(Args.Values[0]);
end;

{  procedure Click; }
procedure TMenuItem_Click(var Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Click;
end;

{  function IndexOf(Item: TMenuItem): Integer; }
procedure TMenuItem_IndexOf(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).IndexOf(V2O(Args.Values[0]) as TMenuItem);
end;

{  procedure Add(Item: TMenuItem); }
procedure TMenuItem_Add(var Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Add(V2O(Args.Values[0]) as TMenuItem);
end;

{  procedure Remove(Item: TMenuItem); }
procedure TMenuItem_Remove(var Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Remove(V2O(Args.Values[0]) as TMenuItem);
end;

{ property Read Command: Word }
procedure TMenuItem_Read_Command(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Command;
end;

{ property Read Handle: HMENU }
procedure TMenuItem_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TMenuItem(Args.Obj).Handle);
end;

{ property Read Count: Integer }
procedure TMenuItem_Read_Count(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Count;
end;

{ property Read Items[Integer]: TMenuItem }
procedure TMenuItem_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMenuItem(Args.Obj).Items[Args.Values[0]]);
end;

{ property Read MenuIndex: Integer }
procedure TMenuItem_Read_MenuIndex(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).MenuIndex;
end;

{ property Write MenuIndex(Value: Integer) }
procedure TMenuItem_Write_MenuIndex(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).MenuIndex := Value;
end;

{ property Read Parent: TMenuItem }
procedure TMenuItem_Read_Parent(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMenuItem(Args.Obj).Parent);
end;

{ property Read Break: TMenuBreak }
procedure TMenuItem_Read_Break(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Break;
end;

{ property Write Break(Value: TMenuBreak) }
procedure TMenuItem_Write_Break(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Break := Value;
end;

{ property Read Caption: string }
procedure TMenuItem_Read_Caption(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Caption;
end;

{ property Write Caption(Value: string) }
procedure TMenuItem_Write_Caption(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Caption := Value;
end;

{ property Read Checked: Boolean }
procedure TMenuItem_Read_Checked(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Checked;
end;

{ property Write Checked(Value: Boolean) }
procedure TMenuItem_Write_Checked(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Checked := Value;
end;

{ property Read Default: Boolean }
procedure TMenuItem_Read_Default(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Default;
end;

{ property Write Default(Value: Boolean) }
procedure TMenuItem_Write_Default(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Default := Value;
end;

{ property Read Enabled: Boolean }
procedure TMenuItem_Read_Enabled(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Enabled;
end;

{ property Write Enabled(Value: Boolean) }
procedure TMenuItem_Write_Enabled(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Enabled := Value;
end;

{ property Read GroupIndex: Byte }
procedure TMenuItem_Read_GroupIndex(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).GroupIndex;
end;

{ property Write GroupIndex(Value: Byte) }
procedure TMenuItem_Write_GroupIndex(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).GroupIndex := Value;
end;

{ property Read HelpContext: THelpContext }
procedure TMenuItem_Read_HelpContext(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).HelpContext;
end;

{ property Write HelpContext(Value: THelpContext) }
procedure TMenuItem_Write_HelpContext(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).HelpContext := Value;
end;

{ property Read Hint: string }
procedure TMenuItem_Read_Hint(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Hint;
end;

{ property Write Hint(Value: string) }
procedure TMenuItem_Write_Hint(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Hint := Value;
end;

{ property Read RadioItem: Boolean }
procedure TMenuItem_Read_RadioItem(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).RadioItem;
end;

{ property Write RadioItem(Value: Boolean) }
procedure TMenuItem_Write_RadioItem(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).RadioItem := Value;
end;

{ property Read ShortCut: TShortCut }
procedure TMenuItem_Read_ShortCut(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).ShortCut;
end;

{ property Write ShortCut(Value: TShortCut) }
procedure TMenuItem_Write_ShortCut(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).ShortCut := Value;
end;

{ property Read Visible: Boolean }
procedure TMenuItem_Read_Visible(var Value: Variant; Args: TArgs);
begin
  Value := TMenuItem(Args.Obj).Visible;
end;

{ property Write Visible(Value: Boolean) }
procedure TMenuItem_Write_Visible(const Value: Variant; Args: TArgs);
begin
  TMenuItem(Args.Obj).Visible := Value;
end;

  { TMenu }

{  function DispatchCommand(ACommand: Word): Boolean; }
procedure TMenu_DispatchCommand(var Value: Variant; Args: TArgs);
begin
  Value := TMenu(Args.Obj).DispatchCommand(Args.Values[0]);
end;

{  function DispatchPopup(AHandle: HMENU): Boolean; }
procedure TMenu_DispatchPopup(var Value: Variant; Args: TArgs);
begin
  Value := TMenu(Args.Obj).DispatchPopup(Args.Values[0]);
end;

{  function FindItem(Value: Integer; Kind: TFindItemKind): TMenuItem; }
procedure TMenu_FindItem(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMenu(Args.Obj).FindItem(Args.Values[0], Args.Values[1]));
end;

{  function GetHelpContext(Value: Integer; ByCommand: Boolean): THelpContext; }
procedure TMenu_GetHelpContext(var Value: Variant; Args: TArgs);
begin
  Value := TMenu(Args.Obj).GetHelpContext(Args.Values[0], Args.Values[1]);
end;

(*
{  function IsShortCut(var Message: TWMKey): Boolean; }
procedure TMenu_IsShortCut(var Value: Variant; Args: TArgs);
begin
  Value := TMenu(Args.Obj).IsShortCut(Args.Values[0]);
end;
*)

{ property Read Handle: HMENU }
procedure TMenu_Read_Handle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TMenu(Args.Obj).Handle);
end;

{ property Read WindowHandle: HWND }
procedure TMenu_Read_WindowHandle(var Value: Variant; Args: TArgs);
begin
  Value := Integer(TMenu(Args.Obj).WindowHandle);
end;

{ property Write WindowHandle(Value: HWND) }
procedure TMenu_Write_WindowHandle(const Value: Variant; Args: TArgs);
begin
  TMenu(Args.Obj).WindowHandle := Value;
end;

{ property Read Items: TMenuItem }
procedure TMenu_Read_Items(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMenu(Args.Obj).Items);
end;

  { TMainMenu }

{ constructor Create(AOwner: TComponent) }
procedure TMainMenu_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TMainMenu.Create(V2O(Args.Values[0]) as TComponent));
end;

{  procedure Merge(Menu: TMainMenu); }
procedure TMainMenu_Merge(var Value: Variant; Args: TArgs);
begin
  TMainMenu(Args.Obj).Merge(V2O(Args.Values[0]) as TMainMenu);
end;

{  procedure Unmerge(Menu: TMainMenu); }
procedure TMainMenu_Unmerge(var Value: Variant; Args: TArgs);
begin
  TMainMenu(Args.Obj).Unmerge(V2O(Args.Values[0]) as TMainMenu);
end;

{ property Read AutoMerge: Boolean }
procedure TMainMenu_Read_AutoMerge(var Value: Variant; Args: TArgs);
begin
  Value := TMainMenu(Args.Obj).AutoMerge;
end;

{ property Write AutoMerge(Value: Boolean) }
procedure TMainMenu_Write_AutoMerge(const Value: Variant; Args: TArgs);
begin
  TMainMenu(Args.Obj).AutoMerge := Value;
end;

  { TPopupMenu }

{ constructor Create(AOwner: TComponent) }
procedure TPopupMenu_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPopupMenu.Create(V2O(Args.Values[0]) as TComponent));
end;

{  procedure Popup(X, Y: Integer); }
procedure TPopupMenu_Popup(var Value: Variant; Args: TArgs);
begin
  TPopupMenu(Args.Obj).Popup(Args.Values[0], Args.Values[1]);
end;

{ property Read PopupComponent: TComponent }
procedure TPopupMenu_Read_PopupComponent(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TPopupMenu(Args.Obj).PopupComponent);
end;

{ property Write PopupComponent(Value: TComponent) }
procedure TPopupMenu_Write_PopupComponent(const Value: Variant; Args: TArgs);
begin
  TPopupMenu(Args.Obj).PopupComponent := V2O(Value) as TComponent;
end;

{ property Read Alignment: TPopupAlignment }
procedure TPopupMenu_Read_Alignment(var Value: Variant; Args: TArgs);
begin
  Value := TPopupMenu(Args.Obj).Alignment;
end;

{ property Write Alignment(Value: TPopupAlignment) }
procedure TPopupMenu_Write_Alignment(const Value: Variant; Args: TArgs);
begin
  TPopupMenu(Args.Obj).Alignment := Value;
end;

{ property Read AutoPopup: Boolean }
procedure TPopupMenu_Read_AutoPopup(var Value: Variant; Args: TArgs);
begin
  Value := TPopupMenu(Args.Obj).AutoPopup;
end;

{ property Write AutoPopup(Value: Boolean) }
procedure TPopupMenu_Write_AutoPopup(const Value: Variant; Args: TArgs);
begin
  TPopupMenu(Args.Obj).AutoPopup := Value;
end;

{ property Read HelpContext: THelpContext }
procedure TPopupMenu_Read_HelpContext(var Value: Variant; Args: TArgs);
begin
  Value := TPopupMenu(Args.Obj).HelpContext;
end;

{ property Write HelpContext(Value: THelpContext) }
procedure TPopupMenu_Write_HelpContext(const Value: Variant; Args: TArgs);
begin
  TPopupMenu(Args.Obj).HelpContext := Value;
end;

{ function ShortCut(Key: Word; Shift: TShiftState): TShortCut; }
procedure RAI2_ShortCut(var Value: Variant; Args: TArgs);
begin 
  Value := ShortCut(Args.Values[0], TShiftState(Byte(V2S(Args.Values[1]))));
end;

{ procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState); }
procedure RAI2_ShortCutToKey(var Value: Variant; Args: TArgs);
var
  Shift: TShiftState;
begin
  Shift := TShiftState(Byte(V2S(Args.Values[2])));
  ShortCutToKey(Args.Values[0], Word(TVarData(Args.Values[1]).vSmallint), Shift);
  Args.Values[2] := S2V(Byte(Shift));
end;

{ function ShortCutToText(ShortCut: TShortCut): string; }
procedure RAI2_ShortCutToText(var Value: Variant; Args: TArgs);
begin
  Value := ShortCutToText(Args.Values[0]);
end;

{ function TextToShortCut(Text: string): TShortCut; }
procedure RAI2_TextToShortCut(var Value: Variant; Args: TArgs);
begin
  Value := TextToShortCut(Args.Values[0]);
end;

(*
{ function NewMenu(Owner: TComponent; const AName: string; Items: array of TMenuItem): TMainMenu; }
procedure RAI2_NewMenu(var Value: Variant; Args: TArgs);
begin
  Value := O2V(NewMenu(V2O(Args.Values[0]) as TComponent, Args.Values[1], Args.Values[2]));
end;

{ function NewPopupMenu(Owner: TComponent; const AName: string; Alignment: TPopupAlignment; AutoPopup: Boolean; Items: array of TMenuitem): TPopupMenu; }
procedure RAI2_NewPopupMenu(var Value: Variant; Args: TArgs);
begin
  Value := O2V(NewPopupMenu(V2O(Args.Values[0]) as TComponent, Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4]));
end;

{ function NewSubMenu(const ACaption: string; hCtx: Word; const AName: string; Items: array of TMenuItem): TMenuItem; }
procedure RAI2_NewSubMenu(var Value: Variant; Args: TArgs);
begin
  Value := O2V(NewSubMenu(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3]));
end;
*)

{ function NewItem(const ACaption: string; AShortCut: TShortCut; AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: Word; const AName: string): TMenuItem; }
procedure RAI2_NewItem(var Value: Variant; Args: TArgs);
begin
  Value := O2V(NewItem(Args.Values[0], Args.Values[1], Args.Values[2], Args.Values[3], nil, Args.Values[5], Args.Values[6]));
end;

{ function NewLine: TMenuItem; }
procedure RAI2_NewLine(var Value: Variant; Args: TArgs);
begin
  Value := O2V(NewLine);
end;


procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
   { EMenuError }
    AddClass('Menus', EMenuError, 'EMenuError');
   { TMenuItem }
    AddClass('Menus', TMenuItem, 'TMenuItem');
    AddGet(TMenuItem, 'Create', TMenuItem_Create, 1, [varEmpty]);
    AddGet(TMenuItem, 'Insert', TMenuItem_Insert, 2, [varEmpty, varEmpty]);
    AddGet(TMenuItem, 'Delete', TMenuItem_Delete, 1, [varEmpty]);
    AddGet(TMenuItem, 'Click', TMenuItem_Click, 0, [0]);
    AddGet(TMenuItem, 'IndexOf', TMenuItem_IndexOf, 1, [varEmpty]);
    AddGet(TMenuItem, 'Add', TMenuItem_Add, 1, [varEmpty]);
    AddGet(TMenuItem, 'Remove', TMenuItem_Remove, 1, [varEmpty]);
    AddGet(TMenuItem, 'Command', TMenuItem_Read_Command, 0, [0]);
    AddGet(TMenuItem, 'Handle', TMenuItem_Read_Handle, 0, [0]);
    AddGet(TMenuItem, 'Count', TMenuItem_Read_Count, 0, [0]);
    AddGet(TMenuItem, 'Items', TMenuItem_Read_Items, 1, [0]);
    AddGet(TMenuItem, 'MenuIndex', TMenuItem_Read_MenuIndex, 0, [0]);
    AddSet(TMenuItem, 'MenuIndex', TMenuItem_Write_MenuIndex, 0, [0]);
    AddGet(TMenuItem, 'Parent', TMenuItem_Read_Parent, 0, [0]);
    AddGet(TMenuItem, 'Break', TMenuItem_Read_Break, 0, [0]);
    AddSet(TMenuItem, 'Break', TMenuItem_Write_Break, 0, [0]);
    AddGet(TMenuItem, 'Caption', TMenuItem_Read_Caption, 0, [0]);
    AddSet(TMenuItem, 'Caption', TMenuItem_Write_Caption, 0, [0]);
    AddGet(TMenuItem, 'Checked', TMenuItem_Read_Checked, 0, [0]);
    AddSet(TMenuItem, 'Checked', TMenuItem_Write_Checked, 0, [0]);
    AddGet(TMenuItem, 'Default', TMenuItem_Read_Default, 0, [0]);
    AddSet(TMenuItem, 'Default', TMenuItem_Write_Default, 0, [0]);
    AddGet(TMenuItem, 'Enabled', TMenuItem_Read_Enabled, 0, [0]);
    AddSet(TMenuItem, 'Enabled', TMenuItem_Write_Enabled, 0, [0]);
    AddGet(TMenuItem, 'GroupIndex', TMenuItem_Read_GroupIndex, 0, [0]);
    AddSet(TMenuItem, 'GroupIndex', TMenuItem_Write_GroupIndex, 0, [0]);
    AddGet(TMenuItem, 'HelpContext', TMenuItem_Read_HelpContext, 0, [0]);
    AddSet(TMenuItem, 'HelpContext', TMenuItem_Write_HelpContext, 0, [0]);
    AddGet(TMenuItem, 'Hint', TMenuItem_Read_Hint, 0, [0]);
    AddSet(TMenuItem, 'Hint', TMenuItem_Write_Hint, 0, [0]);
    AddGet(TMenuItem, 'RadioItem', TMenuItem_Read_RadioItem, 0, [0]);
    AddSet(TMenuItem, 'RadioItem', TMenuItem_Write_RadioItem, 0, [0]);
    AddGet(TMenuItem, 'ShortCut', TMenuItem_Read_ShortCut, 0, [0]);
    AddSet(TMenuItem, 'ShortCut', TMenuItem_Write_ShortCut, 0, [0]);
    AddGet(TMenuItem, 'Visible', TMenuItem_Read_Visible, 0, [0]);
    AddSet(TMenuItem, 'Visible', TMenuItem_Write_Visible, 0, [0]);
   { TMenu }
    AddClass('Menus', TMenu, 'TMenu');
    AddGet(TMenu, 'DispatchCommand', TMenu_DispatchCommand, 1, [varEmpty]);
    AddGet(TMenu, 'DispatchPopup', TMenu_DispatchPopup, 1, [varEmpty]);
    AddGet(TMenu, 'FindItem', TMenu_FindItem, 2, [varEmpty, varEmpty]);
    AddGet(TMenu, 'GetHelpContext', TMenu_GetHelpContext, 2, [varEmpty, varEmpty]);
   // AddGet(TMenu, 'IsShortCut', TMenu_IsShortCut, 1, [varByRef]);
    AddGet(TMenu, 'Handle', TMenu_Read_Handle, 0, [0]);
    AddGet(TMenu, 'WindowHandle', TMenu_Read_WindowHandle, 0, [0]);
    AddSet(TMenu, 'WindowHandle', TMenu_Write_WindowHandle, 0, [0]);
    AddGet(TMenu, 'Items', TMenu_Read_Items, 0, [0]);
   { TMainMenu }
    AddClass('Menus', TMainMenu, 'TMainMenu');
    AddGet(TMainMenu, 'Create', TMainMenu_Create, 1, [varEmpty]);
    AddGet(TMainMenu, 'Merge', TMainMenu_Merge, 1, [varEmpty]);
    AddGet(TMainMenu, 'Unmerge', TMainMenu_Unmerge, 1, [varEmpty]);
    AddGet(TMainMenu, 'AutoMerge', TMainMenu_Read_AutoMerge, 0, [0]);
    AddSet(TMainMenu, 'AutoMerge', TMainMenu_Write_AutoMerge, 0, [0]);
   { TPopupMenu }
    AddClass('Menus', TPopupMenu, 'TPopupMenu');
    AddGet(TPopupMenu, 'Create', TPopupMenu_Create, 1, [varEmpty]);
    AddGet(TPopupMenu, 'Popup', TPopupMenu_Popup, 2, [varEmpty, varEmpty]);
    AddGet(TPopupMenu, 'PopupComponent', TPopupMenu_Read_PopupComponent, 0, [0]);
    AddSet(TPopupMenu, 'PopupComponent', TPopupMenu_Write_PopupComponent, 0, [0]);
    AddGet(TPopupMenu, 'Alignment', TPopupMenu_Read_Alignment, 0, [0]);
    AddSet(TPopupMenu, 'Alignment', TPopupMenu_Write_Alignment, 0, [0]);
    AddGet(TPopupMenu, 'AutoPopup', TPopupMenu_Read_AutoPopup, 0, [0]);
    AddSet(TPopupMenu, 'AutoPopup', TPopupMenu_Write_AutoPopup, 0, [0]);
    AddGet(TPopupMenu, 'HelpContext', TPopupMenu_Read_HelpContext, 0, [0]);
    AddSet(TPopupMenu, 'HelpContext', TPopupMenu_Write_HelpContext, 0, [0]);
    AddFun('Menus', 'ShortCut', RAI2_ShortCut, 2, [varEmpty, varEmpty]);
    AddFun('Menus', 'ShortCutToKey', RAI2_ShortCutToKey, 3, [varEmpty, varByRef, varByRef]);
    AddFun('Menus', 'ShortCutToText', RAI2_ShortCutToText, 1, [varEmpty]);
    AddFun('Menus', 'TextToShortCut', RAI2_TextToShortCut, 1, [varEmpty]);
   { AddFun('Menus', 'NewMenu', RAI2_NewMenu, 3, [varEmpty, varEmpty, varEmpty]);
    AddFun('Menus', 'NewPopupMenu', RAI2_NewPopupMenu, 5, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddFun('Menus', 'NewSubMenu', RAI2_NewSubMenu, 4, [varEmpty, varEmpty, varEmpty, varEmpty]); }
    AddFun('Menus', 'NewItem', RAI2_NewItem, 7, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty]);
    AddFun('Menus', 'NewLine', RAI2_NewLine, 0, [0]);
  end;    { with }
  RegisterClasses([TMainMenu, TPopupMenu, TMenuItem]);
end;    { RegisterRAI2Adapter }

end.
