unit LMDShFavMenu;
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

LMDShFavMenu unit (DS)
------------------------
Contains TLMDShellFavoritesMenu component.


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

{.$DEFINE DX_MENUS}
// outcomment this compiler switch to enable DevExpressBar support of FavMenu
 interface
uses
  Classes, Menus, ShlObj, Windows, Graphics,
  {$IFDEF DX_MENUS}  dxBar, {$ENDIF}
  LMDShBase, LMDShMisc, LMDShUtils;

type

{ ************************ class TLMDShellFavoritesMenu ********************** }
  TLMDShellFavoritesClickEvent = procedure(Sender: TObject; aValue: String;
    var DefaultAction: Boolean) of object;

  TLMDShellFavoritesMenu = class(TLMDShellComponent)
  private
    FEnabled: Boolean;
    FURLHints: Boolean;
    FHelpContext: THelpContext;
    FHint: String;
    FMaxLength: Byte;
    FMenuItem: {$IFDEF DX_MENUS}TdxBarSubItem{$ELSE} TMenuItem {$ENDIF};
    FOnCustomHandler: TLMDShellFavoritesClickEvent;
    FSeparator: Boolean;
    FURLBitmap,
    FFolderBitmap:TBitmap;
    FOldClick: TNotifyEvent;
    FItemsPath: TStrings;
    FFavoritesShellFolder: PItemIDList;
    FFavoritesFolder: TLMDRoot;
    procedure SetMaxLength(aValue: Byte);
    procedure SetMenuItem(aValue: {$IFDEF DX_MENUS}TdxBarSubItem{$ELSE} TMenuItem {$ENDIF});
    procedure SetFavoritesShellFolder(const Value: PItemIDList);
    procedure SetFavoritesFolder(Value: TLMDRoot);
  protected
     procedure Build;
     procedure ClearMenu;
     procedure Loaded; override;
     procedure Notification(AComponent: TComponent; Operation: TOperation);
       override;
     procedure MainClick(Sender: TObject);
     procedure OnClick(Sender: TObject);
  public
    { Public declarations }
     constructor Create(AOwner : TComponent ); override;
     destructor Destroy; override;
     property FavoritesShellFolder: PItemIDList read FFavoritesShellFolder write SetFavoritesShellFolder;
  published
    property FavoritesFolder: TLMDRoot read FFavoritesFolder write SetFavoritesFolder;
    property Enabled: Boolean read FEnabled write FEnabled default true;
    property HelpContext: THelpContext read FHelpContext write FHelpContext
      default 0;
    property Hint: String read FHint write FHint;
    property InsertSeparator: Boolean read FSeparator write FSeparator
      default false;
    property MaxLength: Byte read FMaxLength write SetMaxLength default 255;
    property MenuItem: {$IFDEF DX_MENUS}TdxBarSubItem{$ELSE} TMenuItem {$ENDIF} read FMenuItem write SetMenuItem;
    property URLHints: Boolean read FUrlHints write FURLHints;
    property OnCustomHandler: TLMDShellFavoritesClickEvent read FOnCustomHandler write FOnCustomHandler;
  end;

implementation
uses
  IniFiles, SysUtils, ShellApi, TypInfo, Consts, Variants, 
  LMDShConsts, LMDProcs, LMDShPIDL, LMDStrings;

{ ************************ class TLMDShellFavoritesMenu ********************** }

{$IFDEF DX_MENUS}
const
  LMD_DATA   =  29;
{$ELSE}
type
  TLMDFavMenuItem=class(TMenuItem);
{$ENDIF}
{--------------------------- private ------------------------------------------}
procedure TLMDShellFavoritesMenu.SetMaxLength(aValue:Byte);
begin
  if (aValue<>FMaxLength) and (aValue>7) then
    begin
      FMaxLength:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.SetMenuItem(aValue:{$IFDEF DX_MENUS}TdxBarSubItem{$ELSE} TMenuItem {$ENDIF});
var
  MI: TMenuItem;
begin
  if aValue <> FMenuItem then
    begin
      if FMenuItem <> nil then
        begin
          FMenuItem.OnClick:= FOldClick;
          FOldClick:= nil;
        end;
      FMenuItem:= aValue;
      FOldClick:= nil;
      if FMenuItem <> nil then
        begin
          FMenuItem.FreeNotification(Self);
          If Assigned(FMenuItem.OnClick) then
            FOldClick:= FMenuItem.OnClick;
          FMenuItem.OnClick:= MainClick;
          if FMenuItem.Count <= 0 then
          begin
            MI:= NewItem('', 0,false, false,nil, 0, '');
            mi.Visible:= false;
            FMenuItem.Add(MI);
          end;
        end;
    end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDShellFavoritesMenu.Build;
{$IFDEF DX_MENUS}
   function AddMenu(Item:TdxBarSubItem; Caption:string):TdxBarSubItem;
   begin
      result := TdxBarSubItem.Create(Item);
      result.Data := TObject(LMD_DATA);
      result.HelpContext:=FHelpContext;
      result.Hint:=FHint;
      result.Caption:=Caption;
      result.Glyph :=FFolderBitmap;
      Item.ItemLinks.Add.Item := result;
    end;

  function AddItem(Item:TdxBarSubItem; PathName, FileName:string):TdxBarButton;
  var
    tmp:String;
  begin
    result := TdxBarButton.Create(Item);
    result.Data := TObject(LMD_DATA);
    tmp:=PathName+'\'+Filename;
    result.Tag:=FItemsPath.Add(tmp);
    if not FUrlHints then
      result.Hint:=FHint
    else
      with TIniFile.Create(tmp) do
        try
          result.Hint:=ReadString('InternetShortcut','URL','');
        finally
           free;
        end;

    result.HelpContext:=FHelpContext;
    tmp:=ChangeFileExt(ExtractFileName(FileName),'');
    if Length(tmp)>FMaxLength then
      tmp:=Trim(copy(tmp, 1, MaxLength-2))+'...';
    result.Caption:=tmp;
    result.OnClick := OnClick;
    result.Glyph:=FURLBitmap;
    with Item.ItemLinks.Add do
    begin
      Item := result;
    end;
  end;

  procedure FindItems(Item:TdxBarSubItem;PathName:string);
  var
    s:TStringlist;
    sr: TSearchRec;
    r:Integer;
    SubMenuItem: TdxBarSubItem;
    tmp:string;
  begin
     s:=TStringList.create;
     r:=FindFirst(pathname+'\*.*',faAnyFile,sr);
     try
       while r=0 do
         begin
           if (sr.name<>'.') and (sr.name<>'..') then
             if (sr.Attr=faDirectory) or (sr.Attr=48) then
               s.Add('1'+sr.name)
             else
               s.Add('2'+sr.name);
           r:=FindNext(sr);
         end;
     finally
       FindClose(sr);
     end;
     s.sort;
     for r:=0 to s.Count-1 do
       begin
         tmp:=s[r];
         tmp:=copy(tmp, 2, Length(tmp));
         if s[r][1]='1' then
           begin
             SubMenuItem := AddMenu(Item, tmp);
             FindItems(SubMenuItem, PathName+'\'+tmp);
           end
         else
           begin
             if LowerCase(ExtractFileExt(tmp))='.url' then AddItem(Item,pathname, tmp);
           end;
       end;
  end;

var
  dummy:TdxBarButton;
  n:Integer;
begin
  if ComponentState<>[] then exit;
  ClearMenu;
  if Assigned(FMenuItem) then
    begin
      n:=FMenuItem.ItemLinks.Count;
      if (Length(GetPath FavoritesShellFolder.PathName) > 0) then
        FindItems(FMenuItem, GetPath FavoritesShellFolder.PathName);
      if n=FMenuItem.ItemLinks.Count then
        begin
          dummy:= TdxBarButton.Create(FMenuItem);
          dummy.Data := TObject(LMD_DATA);
          dummy.Caption:=rsEMPTY;
          dummy.Enabled:=False;
          with FMenuItem.ItemLinks.Add do Item := dummy;
        end;
       if FSeparator then
         FMenuItem.ItemLinks.Items[n].BeginGroup := True;
     end;
{$ELSE}
var
  tmp:string;

   function AddMenu(Item:TMenuItem; Caption:string):TMenuItem;
   begin
      result := TLMDFavMenuItem.Create(Item);
      result.HelpContext:=FHelpContext;
      result.Hint:=FHint;
      result.Caption:=Caption;
      TMenuItem(result).Bitmap:=FFolderBitmap;
      Item.Add(result);
    end;

  function AddItem(Item:TMenuItem; const PathName, FileName:string):TMenuItem;
  var
    tmp:String;
  begin
    result := TLMDFavMenuItem.Create(Item );
    tmp:=PathName+'\'+Filename;
    result.Tag:=FItemsPath.Add(tmp);
    if not FUrlHints then
      result.Hint:=FHint
    else
      with TIniFile.Create(tmp) do
        try
          result.Hint:=ReadString('InternetShortcut','URL','');
        finally
           free;
        end;

    result.HelpContext:=FHelpContext;
    tmp:=ChangeFileExt(ExtractFileName(FileName),'');
    if Length(tmp)>FMaxLength then
      tmp:=Trim(copy(tmp, 1, MaxLength-2))+'...';
    result.Caption:=tmp;
    result.OnClick := OnClick;
    result.Bitmap:=FURLBitmap;
    Item.Add(result);
  end;

  procedure FindItems(Item:TMenuItem;PathName:string);
  var
    s:TStringlist;
    sr: TSearchRec;
    r:Integer;
    SubMenuItem: TMenuItem;
    tmp:string;
  begin
     s:=TStringList.create;
     r:=FindFirst(pathname+'\*.*',faAnyFile,sr);
     try
       while r=0 do
         begin
           if (sr.name<>'.') and (sr.name<>'..') then
             if (sr.Attr=faDirectory) or (sr.Attr=48) then
               s.Add('1'+sr.name)
             else
               s.Add('2'+sr.name);
           r:=FindNext(sr);
         end;
     finally
       FindClose(sr);
     end;
     s.sort;
     for r:=0 to s.Count-1 do
       begin
         tmp:=s[r];
         tmp:=copy(tmp, 2, Length(tmp));
         if s[r][1]='1' then
           begin
             SubMenuItem := AddMenu(Item, tmp);
             FindItems(SubMenuItem, PathName+'\'+tmp);
           end
         else
           begin
             if LowerCase(ExtractFileExt(tmp))='.url' then AddItem(Item,pathname, tmp);
           end;
       end;
  end;

var
  dummy:TMenuItem;
  n:Integer;
begin
  if ComponentState<>[] then exit;
  ClearMenu;
  if Assigned(FMenuItem) then
    begin
      if FSeparator then
        begin
          dummy:=TLMDFavMenuItem.Create(FMenuItem);
          dummy.Caption:='-';
          dummy.Enabled:=False;
          FMenuItem.Add(dummy);
        end;

      n:=FMenuItem.Count;
      tmp:= LMDPidlToPath(FavoritesShellFolder);//, SHGDN_FORPARSING);

      if (Length(tmp) > 0) then
        FindItems(FMenuItem, tmp);

      if n=FMenuItem.Count then
        begin
          dummy:=TLMDFavMenuItem.Create(FMenuItem);
          dummy.Caption:=sEmpty;
          dummy.Enabled:=False;
          FMenuItem.Add(dummy);
        end;
    end;
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.ClearMenu;
{$IFDEF DX_Menus}
var
  i : integer;
  it:TdxBarItem;
begin
  if Assigned(FMenuItem) and (FMenuItem.ItemLinks.Count>0) then
    begin
      for i:=Pred(FMenuItem.ItemLinks.Count) downto 0 do
        if (FMenuItem.ItemLinks[i].Item.Data=TObject(LMD_DATA)) then
          begin
            it:=FMenuItem.ItemLinks[i].Item;
            FMenuItem.ItemLinks.Delete(i);
            it.Free;
          end;
    end;

  FItemsPath.Clear;
  if Assigned(FMenuItem) then
    begin
//      it:= TdxBarButton.Create(FMenuItem);
//      it.Data := TObject(LMD_DATA);
//      it.Caption:='-';
//      FMenuItem.ItemLinks.Add.Item := it;
    end;
{$ELSE}
var
  i : integer;
  it:TMenuItem;

  function VisibleItems:Boolean;
  var
    j:Integer;
  begin
    result:=false;
    if FMenuItem.Count>0 then
      for j:=0 to FMenuItem.Count-1 do
        if FMenuItem[j].Visible then
          begin
            result:=true;
            break;
          end;
  end;

begin
  if Assigned(FMenuItem) and (FMenuItem.Count>0) then
    begin
      for i:=Pred(FMenuItem.Count) downto 0 do
        if FMenuItem[i] is TLMDFavMenuItem then
          begin
            it:=FMenuItem.Items[i];
            FMenuItem.Delete(i);
            it.Free;
          end;
    end;

  FItemsPath.Clear;
  if Enabled and Assigned(FMenuItem) and VisibleItems then
    begin
      it:=TLMDFavMenuItem.Create(FMenuItem);
      it.Caption:='-';
      FMenuItem.Add(it);
    end;
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.Loaded;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FMenuItem) and (Operation = opRemove) then
    begin
      FMenuItem:=nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.MainClick(Sender: TObject);
begin
  If Enabled then Build;
  If Assigned(FOldClick) then FOldClick(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.OnClick(Sender: TObject);
var
  default:Boolean;
  szUrl:String;
begin
  default:=True;
  szUrl:=FItemsPath[{$IFDEF DX_MENUS}TdxBarItem{$ELSE}TMenuItem{$ENDIF}(Sender).Tag];
  if Assigned(FOnCustomHandler) then FOnCustomHandler(self, szUrl, default);
  if default then
    begin
      LMDExecute('open', szURL);
{
      with TIniFile.Create(szUrl) do
        try
          szUrl:=ReadString('InternetShortcut','URL','');
        finally
           free;
        end;

      LMDExecute('open', szURL);
}
//      ShellExecute(0, int_Ref('open'), Int_Ref(szURL), int_Ref(''), nil, SW_NORMAL);
//      ShellExecute(0, nil, Int_Ref(szURL), nil, nil, SW_SHOWNORMAL);
    end;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDShellFavoritesMenu.Create(AOwner: TComponent);
begin
  inherited;
  FSeparator:=False;
  FMaxLength:=255;
  FItemsPath:=TStringList.Create;
  FEnabled:=True;
  FFavoritesShellFolder:= nil;
  FavoritesFolder:= sRFFavorites;
  FFolderBitmap := Graphics.TBitmap.Create;
  FFolderBitmap.Handle:=LoadBitmap(HInstance, 'LMDSHELLFOLDER');
  FFolderBitmap.Transparent:=True;
  FURLBitmap := Graphics.TBitmap.Create;
  FURLBitmap.Handle := LoadBitmap(HInstance, 'LMDSHELLURL');
  FURLBitmap.Transparent:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellFavoritesMenu.Destroy;
begin
  SetMenuItem(nil);
  FreeAndNil(FItemsPath);
  if assigned(FFavoritesShellFolder) then LMDShPIDLFree(FFavoritesShellFolder);
  FreeAndNil(FFolderBitmap);
  FreeAndNil(FUrlBitmap);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.SetFavoritesShellFolder(const Value: PItemIDList);
begin
  if LMDPIDLIsEqual( FFavoritesShellFolder, Value) then Exit;

  if assigned(FFavoritesShellFolder) then LMDShPIDLFree(FFavoritesShellFolder);
  FFavoritesShellFolder :=  LMDShPIDLClone(value);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFavoritesMenu.SetFavoritesFolder(Value: TLMDRoot);
var
  NewPIDL: PItemIDList;
  RootIdx       : integer;
  Ok: Boolean;
begin
  if not LMDAnsiSameText(FFavoritesFolder, Value) then
    begin
      Ok := False;
      RootIdx := GetEnumValue(TypeInfo(TLMDRootFolder), Value);
      if  RootIdx >= 0 then
        begin
          NewPIDL:=LMDGetRootFolderID(TLMDSystemFolder(RootIdx));
          Ok := Assigned(NewPIDL);
        end
      else if Length(Value) > 0 then
        begin
          if Value[Length(Value)] = ':' then Value:= Value + '\';
          Ok := LMDPathToPidl(Value, NewPIDL{, nil});
        end;

      if  not Ok then
        begin
          raise Exception.CreateFmt(sErrorSettingPath, [Value]);
        end;
      FFavoritesFolder:= Value;
      if Assigned(FFavoritesShellFolder) then
        LMDShPIDLFree(FFavoritesShellFolder);
      FFavoritesShellFolder:= NewPIDL;
    end;
end;

end.
