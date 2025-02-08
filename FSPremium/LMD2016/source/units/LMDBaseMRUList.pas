unit LMDBaseMRUList;
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

LMDBaseMRUList unit (RM)
------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Menus, ComCtrls,
  LMDCustomIniComponent;

type
  {------------------------- TLMDBaseMRUList ----------------------------------}
  TLMDMRUListOption=(moFileNameOnly, moShowAccel, moSubIfEmpty, moSubClearOption);
  TLMDMRUListOptions=set of TLMDMRUListOption;

  TLMDMRUDisplay=(mdFileName, mdDefault);
  TLMDMRUListStyle=(msAfterItem, msBeforeItem, msCreateSubMenu);

  TLMDMRUClickEvent=procedure(Sender:TObject; const aValue:String; var Remove:Boolean) of object;

  TLMDBaseMRUList = class(TLMDCustomIniComponent)
  private
    FMaxEntries,
    FMaxLength:Byte;
    FMenuItem:TMenuItem;
    FHelpContext:THelpContext;
    FHint:String;
    FItems:TStrings;
    FOnClick:TLMDMRUClickEvent;
    FOnChange:TNotifyEvent;
    FOptions:TLMDMRUListOptions;
    FOnClearListClick:TNotifyEvent;
    FStyle:TLMDMRUListStyle;
    FShared:Boolean;
    //5.0
    FDisplay:TLMDMRUDisplay;
    //8.0
    FToolButton:TToolButton;
    procedure SetDisplay(aValue:TLMDMRUDisplay);
    procedure SetHelpContext(aValue:THelpContext);
    procedure SetHint(const aValue:String);
    procedure SetMaxEntries(aValue:Byte);
    procedure SetMaxLength(aValue:Byte);
    procedure SetMenuItem(aValue:TMenuItem);
    procedure SetStyle(aValue:TLMDMRUListStyle);
    procedure SetToolButton(aValue:TToolButton);
    procedure HandleMenuClick(Sender:TObject);
  protected
    FPopUpMenu:TPopupMenu;
    procedure AssignPopupMenu;virtual;
    procedure CreateSectionDefault(var aValue:String);override;
    function InternalPopupRequired:Boolean;virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(const aValue:String);
    procedure AddItems(aValue:TStrings);
    procedure ClearMenu;
    procedure Remove(const aValue:String);
    procedure RemoveAll;
    procedure ShareList(aValue:TStrings);
    procedure RestoreState;override;
    procedure SaveState;override;
    procedure ReadData;
    procedure WriteData;
    //4.0
    procedure CheckSharedFile(const aValue:String);
    procedure CheckClearList(Sender:TObject);

    property Items:TStrings read FItems;
  published
    property About;
    property HelpContext:THelpContext read FHelpContext write SetHelpContext default 0;
    property Display:TLMDMRUDisplay read FDisplay write SetDisplay default mdFileName;
    property Hint:String read FHint write SetHint;
    property MaxEntries:Byte read FMaxEntries write SetMaxEntries default 4;
    property MaxLength:Byte read FMaxLength write SetMaxLength default 255;
    property MenuItem:TMenuItem read FMenuItem write SetMenuItem;
    property Options:TLMDMRUListOptions read FOptions write FOptions default [moShowAccel, moSubIfEmpty];
    property Shared:Boolean read FShared write FShared default false;
    property Style:TLMDMRUListStyle read FStyle write SetStyle default msAfterItem;
    property IniLink;
    property IniUse;
    property Section;
    // 8.0
    property ToolButton:TToolButton read FToolButton write SetToolButton;
    // --
    {Events}
    property OnClick:TLMDMRUClickEvent read FOnClick write FOnClick;
    property OnClearListClick:TNotifyEvent read FOnClearListClick write FOnClearListClick;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
  Controls, Forms, SysUtils,
  Dialogs, Consts, LMDClass, LMDIniCtrl, LMDStrings, LMDRTLXConst;

{use RTTI to distinguish MRUList-Entries from standard entries}
type
  TLMDMRUItem=class(TMenuItem);

{************************* Class TLMDBaseMRUList ******************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDBaseMRUList.SetDisplay(aValue:TLMDMRUDisplay);
begin
  if aValue<>FDisplay then
    begin
      FDisplay:=aValue;
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetHelpContext(aValue:THelpContext);
begin
  if aValue<>FHelpContext then
    begin
      FHelpContext:=aValue;
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetHint(const aValue:String);
begin
  if aValue<>FHint then
    begin
      FHint:=aValue;
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetMenuItem(aValue:TMenuItem);
begin
  if aValue<>FMenuItem then
    begin
      FMenuItem:=AValue;
      if FMenuItem<>nil then FMenuItem.FreeNotification(Self);
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetMaxEntries(aValue:Byte);
begin
  if aValue<>FMaxEntries then
    begin
      FMaxEntries:=aValue;
      While FItems.Count>FMaxEntries do FItems.Delete(Pred(FItems.Count));
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetMaxLength(aValue:Byte);
begin
  if aValue<>FMaxLength then
    begin
      FMaxLength:=aValue;
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetStyle(aValue:TLMDMRUListStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SetToolButton(aValue:TToolButton);
begin
  if aValue<>FToolButton then
    begin
      if (FToolButton<>nil) and (aValue=nil) then FToolButton.DropDownMenu:=nil;
      FToolButton:=aValue;
      if FToolButton<>nil then
        FToolButton.FreeNotification(Self);
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.HandleMenuClick(Sender:TObject);
var
  r:Boolean;
begin
  r:=False;
  with TLMDMRUItem(Sender) do
    if Tag=$FFFF then
      begin
        if Assigned(FOnClearListClick) then
          FOnClearListClick(Sender);
        if not FShared then
          if MessageDlg(IDS_CLEARLISTREQUEST, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              RemoveAll;
              UpdateMenu;
            end;
      end
    else
      begin
        if Tag>FItems.Count-1 then exit;
        if Assigned(FOnClick) then
          FOnClick(Sender, FItems[Tag], r);
        if not FShared then
          if r then
            self.Remove(FItems[Tag])
          else
            self.Add(FItems[Tag]);
      end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDBaseMRUList.AssignPopupMenu;
begin
  if Assigned(FToolButton) then
    FToolButton.DropDownMenu:=FPopupMenu;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.CreateSectionDefault(var aValue:String);
begin
  if LMDAnsiEmpty(aValue) then
    aValue:=TComponent(Owner).Name+'.'+copy(ClassName, 5, 13);
end;

{------------------------------------------------------------------------------}
function TLMDBaseMRUList.InternalPopupRequired: Boolean;
begin
  result:=Assigned(FToolButton);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  case Operation of
    opRemove:
      begin
        if (AComponent=FMenuItem) then MenuItem:=nil;
        if (AComponent=FToolButton) then ToolButton:=nil;
      end;
    opInsert:
      NotificationStandard(aComponent);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.UpdateMenu;
var
  pos:Integer;
  dummy:Boolean;
  Main:TMenuItem;
  MyMenu:TLMDMRUItem;

  procedure CreateSeparator;
  begin
    MyMenu:=TLMDMRUItem.Create(Main);
    MyMenu.Caption := '-';
    Main.Insert(pos,MyMenu);
    Inc(Pos);
  end;

  procedure CreateList(aValue:Boolean);
  var
    i, j, d, last:Integer;
    tmp, tmp1, tmp2:String;

  begin
    for i:=0 to Pred(FItems.Count) do
      begin
        MyMenu:=TLMDMRUItem.Create(Main);
        with MyMenu do
          begin
            if (moFileNameOnly in FOptions) or (FMaxLength<13) then
              tmp:=ExtractFileName(FItems[i])
            else
              if (FMaxLength=255) or (Length(FItems[i])<=FMaxLength) then
                tmp:=FItems[i]
              else
                case FDisplay of
                  mdFileName:
                    begin
                      tmp:=ExpandFileName(FItems[i]);
                      tmp1:=ExtractFilePath(tmp);
                      tmp:='\'+ExtractFileName(tmp);
                      d:=FMaxLength-Length(tmp);
                      last:=0;
                      if d>0 then
                        begin
                          j:=1;
                          tmp2:=tmp1;
                          while (last<d) and (j>0) do
                            begin
                              j:=System.Pos('\', tmp2);
                              if j<>0 then
                                begin
                                  tmp2:=copy(tmp2, j+1, Length(tmp2));
                                  Inc(last,j);
                                end
                            end;
                        end;
                      if last<4 then
                        tmp:=copy(tmp1, 1,3)+'...'+tmp
                      else
                        tmp:=copy(tmp1, 1, last)+'...'+tmp;
                    end;
                  mdDefault:
                    tmp:=Trim(copy(FItems[i], 1, MaxLength-3))+'...';
                end;

            if moShowAccel in FOptions then
              if i<9 then
                Caption:=Format('&%d %s', [Succ(i), tmp])
              else
                Caption:=Format('&%s %s', [Char(i+56), tmp])
            else
              Caption:=tmp;

            OnClick:=HandleMenuClick;
            Tag:=i;
            HelpContext:=FHelpContext;
            Hint:=FHint;
            Main.Insert(pos, MyMenu);
            inc(pos);
          end;
      end;

    if aValue then
      if (moSubClearOption in FOptions) then
        begin
          CreateSeparator;
          MyMenu:=TLMDMRUItem.Create(Main);
          with MyMenu do
            begin
              Caption:=IDS_CLEARLIST;
              OnClick:=HandleMenuClick;
              Tag:=$FFFF;

              HelpContext:=FHelpContext;
              Hint:=IDS_CLEARLISTHINT;
              Main.Insert(pos, MyMenu);
            end;
        end;
  end;

  function IsSeparator(aValue:TMenuItem):Boolean;
  begin
    result:=(aValue.Caption='-') and aValue.Visible;
  end;

begin
  if ([csDesigning, csLoading]*ComponentState<>[]) or isUpdating then exit;

  ClearMenu;

  if Assigned(FMenuItem) then
    begin
    {check type of FMenuItem}
    If FMenuItem.Count=0 then
      begin                                          {menu item within a main menu}
        if (FStyle in [msAfterItem, msBeforeItem]) and (FItems.Count=0) then exit;
        pos:=FMenuItem.Parent.IndexOf(FMenuItem);    {position of MenuItem}
        dummy:=False;
        with FMenuItem do
          case style of
            msAfterItem:
              begin
                Main:=FMenuItem.Parent;
                Inc(pos);
                if (pos<Pred(Count)) and not IsSeparator(Main[pos]) then Dummy:=True;
                if not IsSeparator(FMenuItem) then CreateSeparator;
                CreateList(false);
                if Dummy then CreateSeparator;
              end;
            msBeforeItem:
              begin
                Main:=FMenuItem.Parent;
                if (pos>0) and not IsSeparator(Main[pos-1]) then CreateSeparator;
                CreateList(false);
                If not IsSeparator(FMenuItem) then CreateSeparator;
              end;
            msCreateSubMenu:
              begin
                Main:=FMenuItem;
                pos:=0;
                if FItems.Count>0 then
                  CreateList(True)
                else
                  if moSubIfEmpty in FOptions then
                    begin
                      Main.Enabled:=True;
                      MyMenu:=TLMDMRUItem.Create(Main);
                      Main.Insert(pos, MyMenu);
                      MyMenu.Caption:=srNone;
                      MyMenu.Enabled:=False;
                    end
                  else
                    Main.Enabled:=False;
              end;
          end;
      end
    else
      begin                       {mainmenu, append entries to the end}
        if FItems.Count=0 then exit;
        Main:=FMenuItem;
        pos:=Main.Count;          {last entry}
        CreateSeparator;
        CreateList(false);
      end;
  end;

  if InternalPopupRequired then
    begin
      if FPopupMenu=nil then
        FPopupMenu:=TPopupMenu.Create(self);
      Main:=FPopupMenu.Items;
      pos:=0;
      if FItems.Count>0 then
        CreateList(True)
      else
        begin
          Main.Enabled:=True;
          MyMenu:=TLMDMRUItem.Create(Main);
          Main.Insert(pos, MyMenu);
          MyMenu.Caption:=srNone;
          MyMenu.Enabled:=False;
        end;
      AssignPopupMenu;
    end;

  if Assigned(FOnChange) and (Assigned(FToolButton) or Assigned(FMenuItem)) then
    FOnChange(Self);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDBaseMRUList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FItems:=TStringList.Create;
  FHelpContext:=0;
  FMaxEntries:=4;
  FMaxLength:=255;
  FStyle:=msAfterItem;
  FShared:=False;
  FOptions:=[moShowAccel, moSubIfEmpty];
  FDisplay:=mdFileName;
  SetSectionDefault;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseMRUList.Destroy;
begin
  FItems.Free;
  FMenuItem:=nil;
  if FPopupMenu<>nil then
    begin
      while FPopUpMenu.Items.Count > 0 do
        FPopupMenu.Items[Pred(FPopupMenu.Items.Count)].Free;
      FPopupMenu.Free;
      if FToolButton<>nil then
        FToolButton.DropDownMenu:=nil;
    end;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.Add(const aValue:String);
var
  i:integer;
begin
  if LMDAnsiEmpty(aValue) then exit;
  i:=FItems.IndexOf(aValue);
  if i>-1 then FItems.Move(i, 0) else FItems.Insert(0, aValue);
  if FItems.Count>FMaxEntries then FItems.Delete(FMaxEntries);
  UpdateMenu;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.AddItems(aValue:TStrings);
var
  i:integer;
begin
  BeginUpdate;
  try
    for i:=Pred(aValue.Count) downto 0 do
      Add(aValue[i]);
  finally
    EndUpdate;
  end;
  UpdateMenu;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.ClearMenu;
var
  i:Integer;
  Main, it:TMenuItem;
begin
  if Assigned(FMenuItem) then
    begin
      if FMenuItem.Count=0 then Main:=FMenuItem.Parent else Main:=FMenuItem;
      for i:=Pred(Main.Count) downto 0 do
      if Main[i] is TLMDMRUItem then
        begin
          it:=Main.Items[i];
          Main.Delete(i);
          it.Free;
        end;
    end;

  //internal popmenu
  if FPopupMenu<>nil then
    begin
      while FPopUpMenu.Items.Count > 0 do
        FPopupMenu.Items[Pred(FPopupMenu.Items.Count)].Free;
      if not InternalPopupRequired then
        FreeAndNil(FPopupMenu);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.CheckSharedFile(const aValue:String);
var
  r:Boolean;
begin
  r:=False;
  if Assigned(FOnClick) then
    FOnClick(self, aValue, r);
  if r then
    self.Remove(aValue)
  else
    self.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.CheckClearList(Sender:TObject);
begin
  if Assigned(FOnClearListClick) then FOnClearListClick(self);
  HandleMenuClick(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.Remove(const aValue:String);
var
  pos:Integer;
begin
  pos:=FItems.IndexOf(aValue);
  if pos>-1 then
    begin
      FItems.Delete(pos);
      UpdateMenu;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.RemoveAll;
begin
  ClearMenu;
  FItems.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.RestoreState;

  procedure ReadFiles(aLink:TLMDIniCtrl);
  begin
    aLink.ReadStringsExt(inherited Section, 'H', FItems, FMaxEntries);
    UpdateMenu;
  end;

begin
  case IniUse of
    ioUseLink  :if IniLink<>nil then ReadFiles(IniLink);
    ioUseGlobal:ReadFiles(LMDApplication.Ini);
    ioNone: ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.SaveState;

  procedure WriteFiles(aLink:TLMDIniCtrl);
  begin
    aLink.WriteStringsExt(inherited Section, 'H', FItems, FMaxEntries);
  end;

begin
  case IniUse of
    ioUseLink  :if IniLink<>nil then WriteFiles(IniLink);
    ioUseGlobal:WriteFiles(LMDApplication.Ini);
    ioNone: ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.ReadData;
begin
  RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.WriteData;
begin
  SaveState;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMRUList.ShareList(aValue:TStrings);
begin
  BeginUpdate;
  try
    FItems.Clear;
    FItems.Assign(aValue);
  finally
    EndUpdate;
  end;
  UpdateMenu;
end;

end.
