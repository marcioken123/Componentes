unit LMDSysMenu;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
¨Ï by LMD Innovative
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

LMDSysMenu unit (RM)
------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Dialogs, Windows, Classes, Messages, Menus, Forms,
  LMDProcs, LMDClass, LMDWndProcComponent;

type
  TLMDSysMenuEntry = (smRestore, smMove, smSize, smMinimize, smMaximize, smClose, smSwitch);
  TLMDSysMenuEntries = set of TLMDSysMenuEntry;

const
  defShowEntries:TLMDSysMenuEntries=[smRestore, smMove, smSize, smMinimize, smMaximize, smClose, smSwitch];

type
  {------------------------- TLMDSysMenu --------------------------------------}
  TLMDSysMenuClickEvent=procedure(Sender:TObject; Index:Integer; aCaption:String) of object;

  TLMDSysMenuMode=(mmItems, mmMenu);

  TLMDSysMenu = class(TLMDWndProcComponent)
  private
    FFirst:Integer;
    FActive:Boolean;
    FMenuList,
    FItems:TStringList;
    FSysEntries:TLMDSysMenuEntries;
    FMenu:TPopUpMenu;
    it:TMenuItem; {dummy variable}
    FMode:TLMDSysMenuMode;

    FOnClick:TLMDSysmenuClickEvent;
    FOnChange:TNotifyEvent;

    procedure ActivateMenu(aValue:Boolean);
    procedure ActivatePopUpMenu;
    procedure CheckSysEntries(hMenu, hAppMenu:THandle);
    procedure DeActivateMenu(aValue:Boolean);
    procedure UpdatePopUpMenu;

    function GetSystemMenuHandle:THandle;
    function GetItems:TStrings;
    function GetItemsCount:Integer;

    procedure SetItems(aValue:TStrings);
    procedure SetFirst(aValue:Integer);
    procedure SetMenu(aValue:TPopUpMenu);
    procedure SetMode(aValue:TLMDSysMenuMode);
  protected
    procedure Init;override;
    procedure RestoreState;override;
    procedure GetChange(Sender:TObject);override;
    procedure SetEnabled(aValue:Boolean);overload; override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;

    function AppWndProc(var Message: TMessage):Boolean;override;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetChecked(Index:Integer; aValue:Boolean);
    procedure SetEnabled(Index:Integer; aValue:Boolean);reintroduce; overload;
    function GetChecked(Index:Integer):Boolean;
    function GetEnabled(Index:Integer):Boolean;

    procedure UpdateMenu;
    procedure ForceUpdate;
    function MenuString(Index:Integer):String;

    property MenuCount:Integer read GetItemsCount;
  published
    property About;
    property Enabled;
    property Items:TStrings read GetItems write SetItems;
    property InsertFrom:Integer read FFirst write SetFirst default -1;
    property HandleApp;
    property Menu:TPopUpMenu read FMenu write SetMenu;
    property Mode:TLMDSysMenuMode read FMode write SetMode default mmItems;
    property ShowEntries:TLMDSysMenuEntries read FSysEntries write FSysEntries default
             [smRestore, smMove, smSize, smMinimize, smMaximize, smClose, smSwitch];

    property OnClick:TLMDSysMenuClickEvent read FOnClick write FOnClick;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

procedure LMDCheckSystemMenu(aFlag:TLMDSysMenuEntries; aHandle:THandle; aW:Boolean);
procedure LMDCheckFormSysMenu(aForm:TForm; aFlag:TLMDSysMenuEntries);
procedure LMDCheckApplicationSysMenu(aFlag:TLMDSysMenuEntries);

implementation

uses
  Controls, SysUtils;

{------------------------------------------------------------------------------}
procedure LMDCheckSystemMenu(aFlag:TLMDSysMenuEntries; aHandle:THandle; aW:Boolean);

  procedure DelEntries(h:THandle; aValue:Integer);
  begin
    DeleteMenu(h, aValue, MF_BYPosition);
    DeleteMenu(h, Pred(aValue), MF_BYPosition);
  end;

begin

  if aHandle=0 then exit;
  if not aW then   {Application System-Menu?}
    begin
      {form-Menu}
      if not (smSwitch in aFlag) and not NewStyleControls then DelEntries(aHandle, 8);
      if not (smClose in aFlag) then
        DelEntries(aHandle, 6)
      else
        if aFlag=[smClose] then DeleteMenu(aHandle, 5, MF_BYPosition);
      if not (smMaximize in aFlag) then DeleteMenu(aHandle, 4, MF_BYPosition);
      if not (smMinimize in aFlag) then DeleteMenu(aHandle, 3, MF_BYPosition);
      if not (smSize in aFlag) then DeleteMenu(aHandle, 2, MF_BYPosition);
      if not (smMove in aFlag) then DeleteMenu(aHandle, 1, MF_BYPosition);
      if not (smRestore in aFlag) then DeleteMenu(aHandle, 0, MF_BYPosition);
      exit;
    end;

  {16bit             32bit NT 3.51         32bit NT4/Win95
   0: Restore        0: Restore            0: Restore
   1: Move           1: Move               1: Minimize
   2: Size           2: Minimize           2: --------
   3: Minimize       3: --------           3: Close
   4: Maximize       4: Close
   5: --------       5: --------
   6: Close          6: Switch
   7: --------
   8: Switch
   }

  if not (smSwitch in aFlag) then
  if not NewStyleControls then DelEntries(aHandle, 6);

  if not (smClose in aFlag) then
    begin
      if NewStyleControls then DelEntries(aHandle, 3) else DelEntries(aHandle, 4)
    end
  else
    if aFlag=[smClose] then
      if NewStyleControls then
        DeleteMenu(aHandle, 2, MF_BYPosition)
      else
        DeleteMenu(aHandle, 3, MF_BYPosition);

  if not (smMinimize in aFlag) then
    if NewStyleControls then
      DeleteMenu(aHandle, 1, MF_BYPosition)
    else
      DeleteMenu(aHandle, 2, MF_BYPosition);

  if not (smMove in aFlag) then
    if not NewStyleControls then
      DeleteMenu(aHandle, 1, MF_BYPosition);

  if not (smRestore in aFlag) then DeleteMenu(aHandle, 0, MF_BYPosition);
end;

{------------------------------------------------------------------------------}
procedure LMDCheckFormSysMenu(aForm:TForm; aFlag:TLMDSysMenuEntries);
begin
  if not Assigned(aForm) then exit;
  LMDCheckSystemMenu(aFlag, GetSystemMenu(aForm.Handle, False), False);
end;

{------------------------------------------------------------------------------}
procedure LMDCheckApplicationSysMenu(aFlag:TLMDSysMenuEntries);
begin
  LMDCheckSystemMenu(aFlag, GetSystemMenu(Application.Handle, False), True);
end;

{************************* Class TLMDSysMenu **********************************}
{--------------------------- Private ------------------------------------------}
function TLMDSysMenu.GetItems:TStrings;
begin
  result:=FItems;
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.GetItemsCount:Integer;
begin
  result:=FMenuList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.GetSystemMenuHandle:THandle;
begin
  result:=0;
  if FActive then
    result:=GetSystemMenu(WndHandle, False)
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetFirst(aValue:Integer);
begin
  if aValue<>FFirst then
    begin
      if (aValue<-1) or (aValue>15) then aValue:=-1;
      FFirst:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetItems(aValue:TStrings);
begin
  FItems.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetMenu(aValue:TPopUpMenu);
begin
  FMenu:=aValue;
  if FMenu<>nil then FMenu.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetMode(aValue:TLMDSysMenuMode);
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    FMode:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.ActivateMenu(aValue:Boolean);
var
  HAppMenu,
  HMenu:THandle;
  i,p:Integer;
  buffer: array[0..255] of Char;

begin

  if FActive then DeActivateMenu(False);

  hMenu:=GetSystemMenu(WndHandle, False);
  if hMenu=0 then exit;

  If HandleApp then HAppMenu:=GetSystemMenu(Application.Handle, False) else HAppMenu:=0;
  if FSysEntries<>defShowEntries then CheckSysEntries(hMenu, hAppMenu);

  if FItems.Count=0 then exit;
  FMenuList.Assign(FItems);
  p:=FFirst;
  For i:=0 to FMenuList.Count-1 do
    begin
      if FMenuList[i]='-' then
        begin
          InsertMenu(hMenu, p, MF_BYPOSITION or MF_SEPARATOR, 0, nil);
          If HandleApp then InsertMenu(hAppMenu, p, MF_BYPOSITION or MF_SEPARATOR, 0, nil)
        end
      else
        begin

          StrPCopy(buffer, FMenuList[i]);
          InsertMenu(hMenu, p, MF_BYPOSITION or MF_STRING, i+1, buffer);

          If HandleApp then InsertMenu(hAppMenu, p, MF_BYPOSITION or MF_STRING, i+1, buffer);
        end;
      if p<>-1 then Inc(p);
    end;

  {zum Schlu©¬}
  FActive:=True;

  if aValue then
    begin
      DrawMenubar(WndHandle);
      if HandleApp then DrawMenubar(Application.Handle);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.ActivatePopUpMenu;
var
  HAppMenu,
  HMenu:THandle;
  i, ds:Integer;
  d1, d2:Word;
  buffer:array[0..255] of Char;

  procedure AddMenuItem(m1, m2:THandle; MenuItem:TMenuItem);
  var
    wc1, wc2:Word;
    ws,j :Integer;

  begin
    with MenuItem do
      for j:=0 to Pred(Count) do
        with Items[j] do
          begin
            if not visible then Continue;
            wc1:=Command;
            wc2:=wc1;
            if Caption='-' then ws:=MF_SEPARATOR else
              if Count=0 then ws:=MF_STRING else
                begin
                  wc1:=CreateMenu;
                  if m2<>0 then wc2:=CreateMenu else wc2:=0;
                  ws:=MF_POPUP;
                end;

            StrPCopy(buffer, Caption+#9+ShortCutToText(ShortCut));
            AppendMenu(m1, ws, wc1, buffer);

            if m2<>0 then
              begin

                StrPCopy(buffer, Caption);
                AppendMenu(m2, ws, wc2, buffer);

              end;
            If ws=MF_POPUP then AddMenuItem(wc1, wc2, MenuItem.Items[j]);
          end;
  end;

begin
  if FActive then DeActivateMenu(False);
  hMenu:=GetSystemMenu(WndHandle, False);
  if hMenu=0 then exit;

  If HandleApp then HAppMenu:=GetSystemMenu(Application.Handle, False) else HAppMenu:=0;
  if FSysEntries<>defShowEntries then CheckSysEntries(hMenu, hAppMenu);

  if not Assigned(FMenu) then exit;
  with FMenu do
    begin
      AutoPopUp:=False;
      for i:=0 to Pred(Items.Count) do
        with Items[i] do
          begin
            if not visible then Continue;
            d1:=Command;
            d2:=d1;
            if Caption='-' then ds:=MF_SEPARATOR else
              if Count=0 then ds:=MF_STRING else
                begin
                  d1:=CreateMenu;
                  if HAppMenu<>0 then d2:=CreateMenu else d2:=0;
                  ds:=MF_POPUP;
                end;

            StrPCopy(buffer, Caption+#9+ShortCutToText(ShortCut));
            AppendMenu(hMenu, ds, d1, buffer);

            if HAppMenu<>0 then
              begin

                StrPCopy(buffer, Caption);
                AppendMenu(HAppMenu, ds, d2, buffer);

              end;
            If ds=MF_POPUP then AddMenuItem(d1, d2, FMenu.Items[i]);
          end;

    end;
  FActive:=True;
  UpdatePopUpMenu;

  if (FMode=mmMenu) and (Owner is TForm) then
    with TForm(Owner) do
      if (PopUpMenu=nil) then PopUpMenu:=FMenu;

end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.CheckSysEntries(hMenu, hAppMenu:THandle);
begin
  if hMenu<>0 then LMDCheckSystemMenu(FSysEntries, HMenu, False);
  if hAppMenu<>0 then LMDCheckSystemMenu(FSysEntries, HAppMenu, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.DeActivateMenu(aValue:Boolean);
begin
  FActive:=False;
  FMenuList.Clear;
  if not ValidOwner then exit;
  GetSystemMenu(WndHandle, True); {Remove old menu by restoring system menu...}
  if HandleApp then GetSystemMenu(Application.Handle, True);
  if aValue then
    begin
      DrawMenubar(WndHandle);
      if HandleApp then DrawMenubar(Application.Handle);
    end;
  if (FMode=mmMenu) and (Owner is TForm) then
    with TForm(Owner) do
      if (PopUpMenu<>nil) and (PopUpMenu=FMenu) then PopUpMenu:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.UpdatePopUpMenu;
var
  HAppMenu,
  HMenu:THandle;
  i:Integer;

const
  ck:array[false..true] of Word=(MF_BYCOMMAND or MF_UNCHECKED, MF_BYCOMMAND or MF_CHECKED);
  en:array[false..true] of Word=(MF_BYCOMMAND or MF_GRAYED, MF_BYCOMMAND or MF_ENABLED);

  procedure Check(com:Word; aValue:Boolean);
    begin
      CheckMenuItem(HMenu, com, ck[aValue]);
      if HAppMenu<>0 then CheckMenuItem(HAppMenu, com, ck[aValue]);
    end;

  procedure Enable(com:Word; aValue:Boolean);
    begin
      EnableMenuItem(HMenu, com, en[aValue]);
      if HAppMenu<>0 then EnableMenuItem(HAppMenu, com, en[aValue]);
    end;

  procedure UpdateInner(MenuItem:TMenuItem);
  var
    j:Integer;
    begin
      for j:=0 to Pred(MenuItem.Count) do
        with MenuItem.Items[j] do
          begin
            Check(Command, Checked);
            Enable(Command, Enabled);
            if Count<>0 then UpdateInner(MenuItem.Items[j]);
          end;
    end;

begin
  if not Assigned(FMenu) then exit;
  hMenu:=GetSystemMenu(WndHandle, False);
  If HandleApp then HAppMenu:=GetSystemMenu(Application.Handle, False) else HAppMenu:=0;

  with FMenu do
    for i:=0 to Pred(Items.Count) do
      with Items[i] do
        begin
          Check(Command, Checked);
          Enable(Command, Enabled);
          if Count<>0 then UpdateInner(FMenu.Items[i]);
        end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDSysMenu.GetChange(Sender:TObject);
begin
  if Sender=FItems then
    if not (csDesigning in ComponentState) and FActive then
      If Assigned(FOnChange) then FOnChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.Init;
begin
  inherited Init;
  if Enabled then
    if FMode=mmItems then ActivateMenu(True) else ActivatePopUpMenu;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.Notification(AComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(aComponent,Operation);
  if (Operation=opRemove) and (aComponent is TPopUpMenu) and (aComponent=FMenu) then
    begin
      FMenu:=nil;
      if (FMode=mmMenu) and not ([csDesigning, csDestroying]*ComponentState<>[]) then RestoreState;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.RestoreState;
begin
  DeActivateMenu(True);
  inherited RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.WndProc(var Message: TMessage);
begin

   if not Enabled then
    begin
      inherited WndProc(Message);
      exit;
    end;

   with Message do
     begin
       case msg of
         WM_SYSCOMMAND:
           if (FMode=mmMenu) and Assigned(FMenu) then
             begin
               it:=FMenu.FindItem(wParam, fkCommand);
               if it<>nil then it.Click;
             end
           else
             if Assigned(FOnClick) then
               if FMenuList.Count>0 then
                 if LoWord(wParam)<=FMenuList.Count then
                   begin
                     FOnClick(Self, LoWord(wParam)-1, FMenuList[LoWord(wParam)-1]);
                     result:=0;
                   end;
       end;
       inherited WndProc(Message);
     end;
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.AppWndProc(var Message: TMessage):Boolean;
begin

   Result:=False;
   case Message.msg of
     WM_SYSCOMMAND:
       if (FMode=mmMenu) and Assigned(FMenu) then
         begin
           it:=FMenu.FindItem(Message.wParam, fkCommand);
           if it<>nil then
             begin
               it.Click;
               result:=True;
             end;
         end
       else
         if Assigned(FOnClick) then
           if FMenuList.Count>0 then
             if LoWord(Message.wParam)<=FMenuList.Count then
               begin
                 FOnClick(Self, LoWord(Message.wParam)-1, FMenuList[LoWord(Message.wParam)-1]);
                 result:=True;
               end;
   end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDSysMenu.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FHandleMDI:=True; {wichtig!}

  FActive:=False;
  FFirst:=-1;
  FMenuList:=TStringList.Create;
  FItems:=TStringList.Create;
  FItems.OnChange:=GetChange;

  FSysEntries:=defShowEntries;
  FMenu:=nil;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);

end;

{------------------------------------------------------------------------------}
destructor TLMDSysMenu.Destroy;
begin
  FItems.OnChange:=nil;
  FreeAndNil(FMenuList);
  FreeAndNil(FItems);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.UpdateMenu;
begin
  if FMode=mmItems then
    ActivateMenu(True)
  else
    If FActive then UpdatePopUpMenu;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.ForceUpdate;
begin
  if FActive and (FMode=mmMenu) then
    begin
      RestoreState;
      Init;
      //ActivatePopUpMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetChecked(Index:Integer; aValue:Boolean);

  procedure Check(flag:Word);
    begin
      CheckMenuItem(GetSystemMenuHandle, Index+1, flag);
      if HandleApp then CheckMenuItem(GetSystemMenu(Application.Handle, false), Index+1, flag);
    end;

begin
  if not (FActive and (Index<FMenuList.Count)) then exit;
  if aValue then Check(MF_CHECKED) else Check(MF_UNCHECKED);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetEnabled(Index:Integer; aValue:Boolean);

  procedure Enable(flag:Word);
    begin
      EnableMenuItem(GetSystemMenuHandle, Index+1, flag);
      if HandleApp then EnableMenuItem(GetSystemMenu(Application.Handle, false), Index+1, flag);
    end;

begin
  if not (FActive and (Index<FMenuList.Count)) then exit;
  if aValue then Enable(MF_ENABLED) else Enable(MF_DISABLED or MF_GRAYED);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMenu.SetEnabled(aValue:Boolean);
begin
  inherited SetEnabled(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.GetChecked(Index:Integer):Boolean;
begin
  result:=False;
  if not (FActive and (Index<FMenuList.Count)) then exit;
  result:=(GetMenuState(GetSystemMenuHandle, Index+1, 0) and MF_CHECKED)=MF_CHECKED;
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.GetEnabled(Index:Integer):Boolean;
begin
  result:=False;
  if not (FActive and (Index<FMenuList.Count)) then exit;
  result:=(GetMenuState(GetSystemMenuHandle, Index+1, 0) and MF_ENABLED)=MF_ENABLED;
end;

{------------------------------------------------------------------------------}
function TLMDSysMenu.MenuString(Index:Integer):String;
begin
  result:='';
  if not (FActive and (Index<FMenuList.Count)) then exit;
  result:=FMenuList[Index];
end;

end.
