unit IWBS4DropDown;

interface

{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, StrUtils, IWRenderContext, IWHTMLTag, IWControl, IWRegion,
  IWBS4Common, IWBS4CommonInterfaces, IWBS4Button;

type
  // Bootstrap DropDown @br
  // http://getbootstrap.com/components/#dropdowns @br
  // http://www.w3schools.com/bootstrap/bootstrap_dropdowns.asp
  {$include IWPlatformAttrib.inc}
  TIWBS4DropDown = class(TIWBS4CustomButton)
  private
    FDropDownItems: TOwnedCollection;
    FItemsTree: TList;
    FDropup: Boolean;
    FDropDownRight: Boolean;
    FDropDownMenuCss: string;
    function GetDropDownItems: TOwnedCollection;
    function IsStoredDropDownItems: Boolean;
    procedure SetDropDownItems(const Value: TOwnedCollection);
    procedure DoOnItemAsyncClick(AParams: TStringList);
    function RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AHref, AStyle: string; ADisabled, AHeader: Boolean; AItemIdx: Integer; AOnAsyncClick: Boolean; ADataParent, ADataTarget: TIWCustomRegion; ADropDownItems: TOwnedCollection): TIWHTMLTag;
    procedure SetDropUp(const Value: Boolean);
    procedure SetDropDownRight(const Value: Boolean);
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  public
    destructor Destroy; override;
  published
    property DropDownMenuCss: string read FDropDownMenuCss write FDropDownMenuCss;
    property DropDownItems: TOwnedCollection read GetDropDownItems write SetDropDownItems stored IsStoredDropDownItems;
    property DropUp: Boolean read FDropup write SetDropUp default False;
    property DropDownRight: Boolean read FDropDownRight write SetDropDownRight default False;
  end;

  TIWBS4DropDownItem = class(TCollectionItem)
  private
    FCaption: string;
    FCss: string;
    FDisabled: Boolean;
    FDropDownItems: TOwnedCollection;
    FGlyphicon: string;
    FHeader: Boolean;
    FHint: string;
    FOnAsyncClick: TIWAsyncEvent;
    FStyle: string;
    FHref: string;
    FTarget: string;
    FDataParent: TIWCustomRegion;  // do not use interfaces here!!!
    FDataTarget: TIWCustomRegion;  // do not use interfaces here!!!
    function GetDropDownItems: TOwnedCollection;
    function IsStoredDropDownItems: Boolean;
    procedure SetDropDownItems(const Value: TOwnedCollection);
    function IsHrefStored: Boolean;
    procedure SetHref(const Value: string);
    function IsTargetStored: Boolean;
    procedure SetTarget(const Value: string);
    procedure SetDataParent(const Value: TIWCustomRegion);
    procedure SetDataTarget(const Value: TIWCustomRegion);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    constructor Create(Collection: TCollection); override;
    property Caption: string read FCaption write FCaption;
    property Css: string read FCss write FCss;
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
    property DataParent: TIWCustomRegion read FDataParent write SetDataParent;
    property DataTarget: TIWCustomRegion read FDataTarget write SetDataTarget;
    property DropDownItems: TOwnedCollection read GetDropDownItems write SetDropDownItems stored IsStoredDropDownItems;
    property Header: Boolean read FHeader write FHeader default False;
    property Href: string read FHref write SetHref stored IsHrefStored;
    property Style: string read FStyle write FStyle;
    property Target: string read FTarget write SetTarget stored IsTargetStored;
    property OnAsyncClick: TIWAsyncEvent read FOnAsyncClick write FOnAsyncClick;
  end;

implementation

uses {$IFDEF  IW_14_3_0_UP}
  IW.Common.SysTools, {$ELSE} IW.Common.System, {$ENDIF}
  IWBS4ModalOld, IWBS4CustomRegion, IWBS4Navbar, IWBS4List, IWBS4ButtonGroup,
  IWBS4InputForm;

{$region 'TIWBSDropDownItem'}
constructor TIWBS4DropDownItem.Create(Collection: TCollection);
begin
  inherited;
  FHref := '#';
  FTarget := '_self';
end;

procedure TIWBS4DropDownItem.Assign(Source: TPersistent);
begin
  if Source is TIWBS4DropDownItem then
  begin
    Caption := TIWBS4DropDownItem(Source).Caption;
    BSGlyphicon := TIWBS4DropDownItem(Source).BSGlyphicon;
    DataParent := TIWBS4DropDownItem(Source).DataParent;
    DataTarget := TIWBS4DropDownItem(Source).DataTarget;
    Header := TIWBS4DropDownItem(Source).Header;
    Href := TIWBS4DropDownItem(Source).Href;
    Target := TIWBS4DropDownItem(Source).Target;
    OnAsyncClick := TIWBS4DropDownItem(Source).OnAsyncClick;
    DropDownItems.Assign(TIWBS4DropDownItem(Source).DropDownItems);
  end
  else
  begin
    inherited;
  end;
end;

function TIWBS4DropDownItem.GetDisplayName: string;
begin
  Result := FCaption;
  if Result = '' then
  begin
    Result := inherited GetDisplayName;
  end;
end;

function TIWBS4DropDownItem.GetDropDownItems: TOwnedCollection;
begin
  if FDropDownItems = nil then
  begin
    FDropDownItems := TOwnedCollection.Create(Self, TIWBS4DropDownItem);
  end;
  Result := FDropDownItems;
end;

function TIWBS4DropDownItem.IsHrefStored: Boolean;
begin
  Result := FHref <> '#';
end;

function TIWBS4DropDownItem.IsStoredDropDownItems: Boolean;
begin
  Result := (FDropDownItems <> nil) and (FDropDownItems.Count > 0);
end;

function TIWBS4DropDownItem.IsTargetStored: Boolean;
begin
  Result := FTarget <> '_self';
end;

procedure TIWBS4DropDownItem.SetDataParent(const Value: TIWCustomRegion);
begin
  FDataParent := Value;
end;

procedure TIWBS4DropDownItem.SetDataTarget(const Value: TIWCustomRegion);
begin
  FDataTarget := Value;
end;

procedure TIWBS4DropDownItem.SetDropDownItems(const Value: TOwnedCollection);
begin
  FDropDownItems.Assign(Value);
end;

procedure TIWBS4DropDownItem.SetHref(const Value: string);
begin
  FHref := Value;
end;

procedure TIWBS4DropDownItem.SetTarget(const Value: string);
begin
  FTarget := Value;
end;
{$endregion}

{$region 'TIWBS4DropDown'}

destructor TIWBS4DropDown.Destroy;
begin
  FreeAndNil(FDropDownItems);
  FreeAndNil(FItemsTree);
  inherited;
end;

function TIWBS4DropDown.GetDropDownItems: TOwnedCollection;
begin
  if FDropDownItems = nil then
  begin
    FDropDownItems := TOwnedCollection.Create(Self, TIWBS4DropDownItem);
  end;
  Result := FDropDownItems;
end;

function TIWBS4DropDown.IsStoredDropDownItems: Boolean;
begin
  Result := (FDropDownItems <> nil) and (FDropDownItems.Count > 0);
end;

procedure TIWBS4DropDown.SetDropDownItems(const Value: TOwnedCollection);
begin
  if Value = nil then
    FreeAndNil(FDropDownItems)
  else
    FDropDownItems.Assign(Value);
end;

procedure TIWBS4DropDown.SetDropDownRight(const Value: Boolean);
begin
  FDropDownRight := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4DropDown.SetDropUp(const Value: Boolean);
begin
  FDropup := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4DropDown.DoOnItemAsyncClick(AParams: TStringList);
var
  idx: Integer;
begin
  if FItemsTree = nil then
    Exit;

  idx := StrToIntDef(AParams.Values['itemidx'], -1);
  if (idx >= 0) and (idx < FItemsTree.Count) then
  begin
    Caption := TIWBS4DropDownItem(FItemsTree.Items[idx]).Caption;
    if (Assigned(TIWBS4DropDownItem(FItemsTree.Items[idx]).OnAsyncClick)) then
      TIWBS4DropDownItem(FItemsTree.Items[idx]).OnAsyncClick(FItemsTree.Items[idx], AParams);
  end;
end;

function TIWBS4DropDown.RenderAnchorTag(const AHTMLName, ACaption, ACss, AGlyphicon, AHint, AHref, AStyle: string; ADisabled, AHeader: Boolean; AItemIdx: Integer; AOnAsyncClick: Boolean; ADataParent, ADataTarget: TIWCustomRegion; ADropDownItems: TOwnedCollection): TIWHTMLTag;
var
  i: Integer;
  IsButton: Boolean;
  LItemIdx: Integer;
begin
  IsButton := (AItemIdx < 0) and (not (Parent is TIWBS4List));

  if (AItemIdx < 0) and (Parent is TIWBS4InputGroup) then
  begin
    Result := TIWHTMLTag.CreateTag('span');
    Result.AddClassParam('input-group-btn');
  end
  else if IsButton then
    Result := TIWHTMLTag.CreateTag('div')
  else
    Result := TIWHTMLTag.CreateTag('li');

  try
    // divider
    if (AItemIdx >= 0) and (ACaption = '-') then
    begin
      Result.AddClassParam('divider');
      Result.AddStringParam('role', 'separator');
      Exit;
    end;

    // header
    if AHeader then
    begin
      Result.AddClassParam('dropdown-header');
      Result.Contents.AddText(ACaption);
      Exit;
    end;

    // items
    Result.AddStringParam('id', AHTMLName + iif(AItemIdx >= 0, IntToStr(AItemIdx)));
    if ADropDownItems <> nil then
    begin
      if Parent is TIWBS4ButtonGroup then
        Result.AddClassParam('btn-group')
      else if FDropUp then
        Result.AddClassParam('dropup')
      else
        Result.AddClassParam('dropdown');

      if AItemIdx >= 0 then
      begin
        Result.AddClassParam('dropdown-submenu');
      end;
    end;

    // anchor or button
    with Result.Contents.AddTag(iif(IsButton, 'button', 'a')) do
    begin
      AddClassParam(ACss);

      if IsButton then
      begin
        AddClassParam('btn');

        if BSButtonSize <> bs4bszDefault then
        begin
        //AddClassParam('btn-' + aIWBS4Size[BSButtonSize]);
          AddClassParam(aIWBS4ButtonSize[BSButtonSize]);
        end;

        AddClassParam(aIWBS4ButtonStyle[BSButtonStyle]);
        if Parent is TIWBS4NavBarBase then
        begin
          AddClassParam('navbar-btn');
        end;
      end
      else if ADataTarget = nil then
        AddStringParam('href', AHref)
      else
        AddStringParam('href', '#' + ADataTarget.HTMLName);

      if Showhint and (AHint <> '') then
      begin
        AddStringParam('title', AHint);
      end;
      if ADisabled then
      begin
        Add('disabled');
      end;
      AddStringParam('style', AStyle);

      if ADropDownItems <> nil then
      begin
        AddClassParam('dropdown-toggle');
        AddStringParam('data-toggle', 'dropdown');
      end
      else
      begin
        if (AItemIdx >= 0) and AOnAsyncClick then
          AddStringParam('data-item-idx', IntToStr(AItemIdx));
        if ADataTarget <> nil then
        begin
          if ADataParent <> nil then
          begin
            AddStringParam('data-parent', '#' + ADataParent.HTMLName);
          end;
          if ADataTarget is TIWBS4ModalOld then
            AddStringParam('data-toggle', 'modal')
          else if (ADataTarget is TIWBS4CustomRegion) and TIWBS4CustomRegion(ADataTarget).Collapse then
          begin
            AddStringParam('data-toggle', 'collapse');
          end;
        end;
      end;

      Contents.AddText(TextToHTML(ACaption));

      if AGlyphicon <> '' then
        with Contents.AddTag('span') do
        begin
          AddClassParam('glyphicon glyphicon-' + AGlyphicon);
          AddBoolParam('aria-hidden', True);
        end
      else if ADropDownItems <> nil then
      begin
        with Contents.AddTag('span') do
          if AItemIdx < 0 then
            AddClassParam('caret')
          else if FDropDownRight then
            AddClassParam('caret-left')
          else
            AddClassParam('caret-right');
      end;
    end;

    // unordered list
    if ADropDownItems <> nil then
    begin
      with Result.Contents.AddTag('div') do
      begin
        AddClassParam('dropdown-menu');
        if (FDropDownMenuCss <> '') then
        begin
          AddClassParam(FDropDownMenuCss);
        end;
        if FDropDownRight then
        begin
          AddClassParam('dropdown-menu-right');
        end;
        for i := 0 to ADropDownItems.Count - 1 do
        begin
          LItemIdx := FItemsTree.Add(ADropDownItems.Items[i]);
          with TIWBS4DropDownItem(ADropDownItems.Items[i]) do
          begin
            if Pos('dropdown-item', FCss) = 0 then
            begin
              FCss := 'dropdown-item' + FCss;
            end;

            Contents.AddTagAsObject(RenderAnchorTag(AHTMLName, FCaption, FCss, FGlyphicon, FHint, FHref, FStyle, FDisabled, FHeader, LItemIdx, Assigned(FOnAsyncClick), FDataParent, FDataTarget, FDropDownItems));
          end;
        end;
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIWBS4DropDown.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  FreeAndNil(FItemsTree);
  FItemsTree := TList.Create;
  AHTMLTag := RenderAnchorTag(AHTMLName, Caption, ActiveCss, FontAwesome, Hint, '#', ActiveStyle, IsDisabled, False, -1, False, nil, nil, FDropDownItems);
end;

procedure TIWBS4DropDown.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  AScript.Add('$("#' + AHTMLName + ' a[data-toggle=dropdown]").off().on("click", function(e) { $(this).parent().toggleClass("open").find("li").removeClass("open"); $(this).parent().siblings().removeClass("open").find("li").removeClass("open"); return false; });');
  AScript.Add('$("#' + AHTMLName + ' a[data-item-idx]").off().on("click", function(e) { executeAjaxEvent("&itemidx="+$(this).attr("data-item-idx"), null, "' + AHTMLName + '.DoOnAsyncClick", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnAsyncClick', DoOnItemAsyncClick);
end;
{$endregion}

end.

