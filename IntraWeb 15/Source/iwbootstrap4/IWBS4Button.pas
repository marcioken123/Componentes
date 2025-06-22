unit IWBS4Button;

(**
    Icon Usage in a button (icon at 4x normal size)

    <button class="btn">
      <i class="fa fa-book" style="font-size:48px;color:dodgerblue;">
      Click Me
    </button>
**)

interface

{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, db, StrUtils, Controls, IWRenderContext, IWBaseInterfaces,
  IWRegion, IWHTMLTag, IWScriptEvents, IWBS4CustomControl, IWBS4Common,
  IWBS4CommonInterfaces, IWBS4Badge, IWBS4Tooltip, IWBS4Region, IWBS4Moab;

type
  // TIWBSCustomButton.BSButtonStyle
  TIWBS4ButtonStyle = (bs4bsBasic, bs4bsPrimary, bs4bsSecondary, bs4bsSuccess, bs4bsInfo, bs4bsWarning, bs4bsDanger, bs4bsDark, bs4bsLight, bs4bsLink,
    // used by Dialogs, but it is NOT one of the styles of a BS button
    bs4bsClose);

  // TIWBS4Button.ButtonSize
  TIWBS4ButtonSize = (bs4bszSmall, bs4bszDefault, bs4bszLarge);

  // Base class for TIWBSButton and TIWBSDropDown
  TIWBS4CustomButton = class(TIWBS4CustomControl)
  private
    FBlockLevel: Boolean;
    FButtonSize: TIWBS4ButtonSize;
    FButtonStyle: TIWBS4ButtonStyle;
    FCaption: string;
    FFontAwesome: string;
    FGoogleMaterial: string;
    FIconOnRight: Boolean;
    FIconTextGap: string;
    FRawText: Boolean;
    procedure SetFontAwesome(const Value: string);
    procedure SetButtonStyle(const Value: TIWBS4ButtonStyle);
    procedure SetBlockLevel(const Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetRawText(const Value: Boolean);
    procedure SetGoogleMaterial(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
  published
    // Boostrap Block Level Button @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSBlockLevel: Boolean read FBlockLevel write SetBlockLevel default False;
    // Boostrap Button Size @br
    // http://getbootstrap.com/css/#buttons-sizes
    property BSButtonSize: TIWBS4ButtonSize read FButtonSize write FButtonSize default bs4bszDefault;
    // Bootstrap Button Style @br
    // http://getbootstrap.com/css/#buttons-options
    property BSButtonStyle: TIWBS4ButtonStyle read FButtonStyle write SetButtonStyle default bs4bsBasic;
    // Bootstrap Glyphicon @br
    // http://getbootstrap.com/components/#glyphicons
    property FontAwesome: string read FFontAwesome write SetFontAwesome;
    property GoogleMaterial: string read FGoogleMaterial write SetGoogleMaterial;
    property IconOnRight: Boolean read FIconOnRight write FIconOnRight;
    // Sets left or right margin, depending on value of FIconOnRight,
    // for those who are not happy with the amount of space between the text and the icon
    property IconTextGap: string read FIconTextGap write FIconTextGap;
    // Button Text
    property Caption: string read FCaption write SetCaption;
    // If true, the Caption will be rendered as Raw HTML
    property RawText: Boolean read FRawText write SetRawText default False;
  end;

  // TIWBS4Button.DataDismiss
  TIWBS4ButtonDataDismiss = (bs4bdNone, bs4bdModal, bs4bdAlert);

  // TIWBS4Button.ButtonType
  TIWBS4ButtonType = (bs4btButton, bs4btSubmit, bs4btReset);

  // TIWBS4Button.ElementTypeType
  TIWBS4ButtonElementType = (bs4etAuto, bs4etAnchor, bs4etButton);

  // TIWBS4Button.AsyncClickProc
  TIWBS4AsyncEventProc = reference to procedure(Sender: TObject; EventParams: TStringList);

  // Bootstrap Button @br
  // http://getbootstrap.com/css/#buttons @br
  // http://www.w3schools.com/bootstrap/bootstrap_buttons.asp
  {$include IWPlatformAttrib.inc}
  TIWBS4Button = class(TIWBS4CustomButton)
  private
    FAsyncClickProc: TIWBS4AsyncEventProc;
    FButtonType: TIWBS4ButtonType;
    FDataDismiss: TIWBS4ButtonDataDismiss;
    FDataParent: TIWCustomRegion;  // do not use interfaces here!!!
    FDataTarget: TIWCustomRegion;  // do not use interfaces here!!!
    FDataTargetID: string;
    FDataTargetRegion: TIWBS4Region;
    FDataTargetMoab: TIWBS4Moab;
    FElementType: TIWBS4ButtonElementType;
    FHotKey: string;
    FHref: string;
    FTarget: string;
    FOutline: Boolean;
    FActive: Boolean;
    FModalBackdrop: string;
    FModalKeyboardEscape: Boolean;
    FBadge: TIWBS4Badge;
    FTooltip: TJSTooltip;
  //FDisabled: Boolean; -- do not need such a field because the built-in Enabled property is used to set the "disabled" attribute
    procedure DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
    procedure SetAsyncClickProc(Value: TIWBS4AsyncEventProc);
    function IsHrefStored: Boolean;
    function IsTargetStored: Boolean;
    function IsAnchor: Boolean;
    procedure SetDataTarget(const Value: TIWCustomRegion);
    procedure SetDataParent(const Value: TIWCustomRegion);
    procedure SetHref(const Value: string);
    procedure SetTarget(const Value: string);
    procedure SetDataDismiss(const Value: TIWBS4ButtonDataDismiss);
    function GetDataToggle: string;
    procedure SetElementType(const Value: TIWBS4ButtonElementType);
    procedure SetOutline(const Value: Boolean);
    procedure SetDataTargetID(const Value: string);
    procedure SetDataTargetRegion(const Value: TIWBS4Region);
    procedure SetDataTargetMoab(const Value: TIWBS4Moab);
    procedure SetModalBackdrop(const Value: string);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InitRuntime;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // Anonymous procedure that let you execute code when button is pressed without the need of declare an event. @br
    // Usefull when you create buttons at runtime
    property AsyncClickProc: TIWBS4AsyncEventProc read FAsyncClickProc write SetAsyncClickProc;
  published
    // Button type
    property ButtonType: TIWBS4ButtonType read FButtonType write FButtonType default bs4btButton;
    // Used when button in placed on a TIWBSModal or TIWBSAlert. @br
    // Let the button automatically close the dialog.
    property DataDismiss: TIWBS4ButtonDataDismiss read FDataDismiss write SetDataDismiss default bs4bdNone;
    // Specifies the parent region off collapsable regions to autoclose other regions when one is toggled. See accordion example. @br
    // http://getbootstrap.com/javascript/#collapse-example-accordion @br
    // http://www.w3schools.com/bootstrap/bootstrap_collapse.asp
    property DataParent: TIWCustomRegion read FDataParent write SetDataParent;
    // Specifies the target region for for toggle visiblity of TIWBSModal or TIWBSRegion.Collapse @br
    // http://www.w3schools.com/bootstrap/bootstrap_modal.asp @br
    // http://www.w3schools.com/bootstrap/bootstrap_collapse.asp
    property DataTarget: TIWCustomRegion read FDataTarget write SetDataTarget;

    // Added by SS to allow setting a data-target that is defined in HTML in another control like a TLabel
    property DataTargetID: string read FDataTargetID write SetDataTargetID;

    // Toogle operation
    property DataTargetRegion: TIWBS4Region read FDataTargetRegion write SetDataTargetRegion;
    property DataTargetMoab: TIWBS4Moab read FDataTargetMoab write SetDataTargetMoab;
    property DataToggle: string read GetDataToggle;
    // acceskey tag atribute @br
    // http://www.w3schools.com/tags/att_global_accesskey.asp
    property HotKey: string read FHotkey write FHotKey;
    // this property determines if the element will be type anchor or button, default is Auto
    property ElementType: TIWBS4ButtonElementType read FElementType write SetElementType default bs4etAuto;
    // Destination address to jump when button is pressed. @br
    // Requires following property values: Anchor = true, DataTarget = nil, OnAsyncClic = nil. @br
    // http://www.w3schools.com/html/html_links.asp
    property Href: string read FHref write SetHref stored IsHrefStored;
    // The target attribute specifies where to open the linked document. Apply when Href is used. @br
    // http://www.w3schools.com/html/html_links.asp
    property Target: string read FTarget write SetTarget stored IsTargetStored;
    // The outline is part of the core css for button "purpose", but does not apply to Basic or Link
    property Outline: Boolean read FOutline write SetOutline default False;
    // "active" can be applied to any button which basically makes it look like the hover color
    property Active: Boolean read FActive write FActive default False;
    property ModalBackdrop: string read FModalBackdrop write SetModalBackdrop;
    property ModalKeyboardEscape: Boolean read FModalKeyboardEscape write FModalKeyboardEscape;
    property Badge: TIWBS4Badge read FBadge write FBadge;
    // JS Tooltip
    property Tooltip: TJSTooltip read FTooltip write FTooltip;
  end;

const
  // @exclude
  aIWBS4ButtonStyle: array[bs4bsBasic..bs4bsLink] of string = ('btn', 'btn-primary', 'btn-secondary', 'btn-success', 'btn-info', 'btn-warning', 'btn-danger', 'btn-dark', 'btn-light', 'btn-link'); //, 'close');

  aIWBS4ButtonSize: array[bs4bszSmall..bs4bszLarge] of string = ('btn-sm', '', 'btn-lg');

implementation

uses
  {$IFDEF IW_14_3_0_UP}
  IW.Common.SysTools, {$ELSE} IW.Common.System, {$ENDIF} IWAppForm,
  IWBS4InputCommon, IWBS4InputForm, IWBS4ModalOld, IWBS4CustomRegion,
  IWBS4Navbar, IWBS4List, IWBS4ButtonGroup, IWContainer, IWBS4Color,
  IWVCLBaseControl;

{$region 'TIWBS4CustomButton'}
constructor TIWBS4CustomButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := bs4bszDefault;
  FButtonStyle := bs4bsBasic;
  FCaption := '';
  FFontAwesome := '';
  FGoogleMaterial := '';
  FIconTextGap := '';
  FNeedsFormTag := True;
  FFriendlyName := '-';
  Height := 25;
  Width := 200;
end;

procedure TIWBS4CustomButton.SetBlockLevel(const Value: Boolean);
begin
  FBlockLevel := Value;
  Invalidate;
end;

procedure TIWBS4CustomButton.SetButtonStyle(const Value: TIWBS4ButtonStyle);
begin
  FButtonStyle := Value;
  Invalidate;
end;

procedure TIWBS4CustomButton.SetCaption(const Value: string);
begin
  FCaption := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4CustomButton.SetFontAwesome(const Value: string);
begin
  FFontAwesome := Value;
  Invalidate;
end;

procedure TIWBS4CustomButton.SetGoogleMaterial(const Value: string);
begin
  FGoogleMaterial := Value;
end;

procedure TIWBS4CustomButton.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;
{$endregion}

{$region 'TIWBS4Button'}

type
  TIWPageContext40Access = class(TIWPageContext40);

constructor TIWBS4Button.Create(AOwner: TComponent);
begin
  inherited;
  FButtonType := bs4btButton;
  FDataDismiss := bs4bdNone;
  FElementType := bs4etAuto;
  FFriendlyName := '-';
  FHotKey := '';
  FHref := '#';
  FTarget := '';
  FBadge := TIWBS4Badge.Create(Self);
  FTooltip := TJSTooltip.Create;

  if not Self.IsDesignMode then
    InitRuntime;
end;

procedure TIWBS4Button.InitRuntime;
const
  TooltipInitCode = '$(''[data-toggle="tooltip"]'').tooltip();';
var
  HostForm: TIWAppForm;
  Daddy: TWinControl;
begin
  // Find IWForm and initialize Tooltip. This should only execute at runtime
  HostForm := nil;
  if Assigned(Owner) then
  begin
    if Owner is TIWAppForm then
    begin
      HostForm := TIWAppForm(Owner);
    end
    else
    begin
      if Owner is TIWContainer then
      begin
        Daddy := TIWContainer(Owner).Parent;
        if Assigned(Daddy) then
        begin
          while Assigned(Daddy) and not (Daddy is TIWAppForm) do
          begin
            Daddy := Daddy.Parent;
          end;
        end;
        if Daddy is TIWAppForm then
        begin
          HostForm := TIWAppForm(Daddy);
        end;
      end;
    end;
  end
  else
  begin
    if Assigned(Self.Parent) then
    begin
      if Self.Parent is TIWAppForm then
      begin
        HostForm := TIWAppForm(Self.Parent);
      end
      else
      begin
        if Self.Parent.Parent is TIWAppForm then
        begin
          HostForm := TIWAppForm(Self.Parent.Parent);
        end;
      end;
    end;
  end;

  if Assigned(HostForm) then
  begin
    // Make loaded only once, because there could be many elements in one page that need it
    if Pos(TooltipInitCode, TIWPageContext40Access(HostForm).FInitProc) = 0 then
      HostForm.PageContext.AddToInitProc(TooltipInitCode);
  end;
end;

destructor TIWBS4Button.Destroy;
begin
  FBadge.Free;
  FTooltip.Free;

  inherited;
end;

procedure TIWBS4Button.InternalRenderCss(var ACss: string);
var
  S: string;
begin
  inherited;

  if (Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtListGroup) then
  begin
    TIWBS4Common.AddCssClass(ACss, 'list-group-item');
  end
  else if (FDataTarget <> nil) and (FDataTarget is TIWBS4NavBarCollapse) then
  begin
    TIWBS4Common.AddCssClass(ACss, 'navbar-toggle');
  end
  else if (Parent is TIWBS4ButtonGroup) or not IsAnchor then
  begin
    // Initial "btn" class
    TIWBS4Common.AddCssClass(ACss, 'btn');

    // *** New for BS4: outline css modifier (only applies to 8 of the styles)
    if not FOutline then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4ButtonStyle[FButtonStyle]);
    end
    else
    begin
      S := aIWBS4ButtonStyle[FButtonStyle];
      Insert('-outline', S, Pos('-', S));
      TIWBS4Common.AddCssClass(ACss, S);
    end;

    // In IWBS3 the size css class came before the style, but BS recommends that the style come first
    if FButtonSize <> bs4bszDefault then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4ButtonSize[FButtonSize]);
    end;

    // Block level
    if FBlockLevel then
    begin
      TIWBS4Common.AddCssClass(ACss, 'btn-block');
    end;

    // Active
    if FActive then
    begin
      TIWBS4Common.AddCssClass(ACss, 'active');
    end;

    // "disabled" is tricky because it is an attribute for a button, but a class for link button
    // But this block is only for non-anchors, so we have to figure out where to add this class


    if Parent is TIWBS4NavBarBase then
    begin
      TIWBS4Common.AddCssClass(ACss, 'navbar-btn')
    end
    else if (Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtDropDown) then
    begin
      TIWBS4Common.AddCssClass(ACss, 'dropdown-toggle');
    end;
  end;
end;

procedure TIWBS4Button.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
const
  aIWBS4ButtonDataDismiss: array[bs4bdNone..bs4bdAlert] of string = ('', 'modal', 'alert');
var
  s: string;
  lAnchor: Boolean;
  lTarget: string;
  InnerTag: TIWHTMLTag;
  BadgeTag: TIWHTMLTag;
  SpanClass: string;
begin
  inherited;

  lAnchor := IsAnchor;

  AHTMLTag := TIWHTMLTag.CreateTag(iif(lAnchor, 'a', 'button'));
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);

    // button type
    if not lAnchor then
    begin
      if FButtonType = bs4btButton then
        AHTMLTag.AddStringParam('type', 'button')
      else if FButtonType = bs4btSubmit then
        AHTMLTag.AddStringParam('type', 'submit')
      else if FButtonType = bs4btReset then
        AHTMLTag.AddStringParam('type', 'reset');
    end;

    // Going to handle this through the TIWBS4Tooltip class now
   {if ShowHint and (Hint <> '') then
    begin
      AHTMLTag.AddStringParam('title', Hint);
    end;}

    if FModalBackdrop <> '' then
    begin
      AHTMLTag.AddStringParam('data-backdrop', FModalBackdrop);
    end;

    if FModalKeyboardEscape then
    begin
      AHTMLTag.AddStringParam('data-keyboard', 'true');
    end;

    if IsDisabled then
    begin
      AHTMLTag.Add('disabled');
    end;

    AHTMLTag.AddStringParam('style', ActiveStyle);

    if TabIndex <> 0 then
    begin
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    end;

    // caption
    if FRawText then
      s := Caption
    else
      s := TextToHTML(Caption);

    // hotkey
    if FHotKey <> '' then
    begin
      AHTMLTag.AddStringParam('accesskey', FHotKey);
      s := StringReplace(s, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]);
    end;

    // Glyphicon no longer used in BS4, but if someone still wants to use it (perhaps to not break existing code),
    // then just uncomment this and a few other places I will make easy to uncomment
  (*if FGlyphicon <> '' then
    begin
      with AHTMLTag.Contents.AddTag('span') do
      begin
        AddClassParam('glyphicon glyphicon-' + FGlyphicon);
        AddBoolParam('aria-hidden', True);
        s := ' ' + s;
      end;
    end;**)

    // close button
    if FButtonStyle = bs4bsClose then
    begin
      AHTMLTag.AddStringParam('aria-label', 'Close');
      if (s = '') and (FontAwesome = '') then
      begin
        s := '&times;';
      end;
    end;

    // data-dismiss
    if FDataDismiss <> bs4bdNone then
    begin
      AHTMLTag.AddStringParam('data-dismiss', aIWBS4ButtonDataDismiss[FDataDismiss]);
    end;

    // datatarget / href
    //
    // 2018-11-20 - SS - Fix for alternate DataTarget properties...
    if (FDataTarget = nil) and (FDataTargetMoab = nil) and (FDataTargetRegion = nil) and (FDataTargetID = '') then
    begin
      if lAnchor then
      begin
        AHTMLTag.AddStringParam('href', FHref);
        if FTarget = '' then
        begin
          if AnsiStartsStr('#', FHref) then
            lTarget := '_self'
          else
            lTarget := '_blank';
        end
        else
        begin
          lTarget := FTarget;
        end;
        AHTMLTag.AddStringParam('target', lTarget);
      end;
    end
    else
    begin
      if Assigned(FDataTargetMoab) then
      begin
        AHTMLTag.AddStringParam('data-target', '#' + FDataTargetMoab.HTMLName);
      end
      else if FDataTargetID <> '' then
      begin
        AHTMLTag.AddStringParam('data-toggle', 'collapse');
        AHTMLTag.AddStringParam('data-target', '#' + FDataTargetID);
      end
      else if Assigned(FDataTargetRegion) then
      begin
        AHTMLTag.AddStringParam('data-toggle', 'collapse');
        AHTMLTag.AddStringParam('data-target', '#' + FDataTargetRegion.HTMLName);
      end
      else if lAnchor then
        AHTMLTag.AddStringParam('href', '#' + FDataTarget.HTMLName)
      else
        AHTMLTag.AddStringParam('data-target', '#' + FDataTarget.HTMLName);

      if FDataParent <> nil then
      begin
        AHTMLTag.AddStringParam('data-parent', '#' + FDataParent.HTMLName);
      end;

      // draw a menu button if no caption and no glyphicon
      if (s = '') and (FontAwesome = '') then
      begin
        // BS3
       {AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');
        AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');
        AHTMLTag.Contents.AddTag('span').AddClassParam('icon-bar');}
        // BS4
        AHTMLTag.Contents.AddTag('span').AddClassParam('navbar-toggler-icon');
      end;
    end;

    // datatoggle
    AHTMLTag.AddStringParam('data-toggle', DataToggle);

    // Tooltip
    // Todo: the Add method seems to have a counter -- we might need to add each attribute separately (but it works as is)
    if FTooltip.Enabled then
    begin
      AHTMLTag.Add(FTooltip.GetAttributeString);
    end;

    // Determine if icon goes before or after the button text (innerHTML)
    if s <> '' then
    begin
      if FIconOnRight then
      begin
        AHTMLTag.Contents.AddText(s);

        // See if badge is wanted
        if FBadge.Enabled then
        begin
          BadgeTag := AHTMLTag.Contents.AddTag('span');
          if FBadge.BadgePill then
            SpanClass := 'badge badge-pill badge-' + aIWBS4ContextualClass[FBadge.ContextualColor]
          else
            SpanClass := 'badge badge-' + aIWBS4ContextualClass[FBadge.ContextualColor];
          BadgeTag.AddClassParam(SpanClass);
          BadgeTag.Contents.AddText(FBadge.BadgeText);
        end;
      end;

      if FFontAwesome <> '' then
      begin
        InnerTag := AHTMLTag.Contents.AddTag('i');
        InnerTag.AddClassParam('fa ' + FFontAwesome);
        // If the user wants a non-standard Icon-Text gap
        if FIconTextGap <> '' then
        begin
          if FIconOnRight then
            InnerTag.AddStringParam('style', 'margin-left:' + FIconTextGap)
          else
            InnerTag.AddStringParam('style', 'margin-right:' + FIconTextGap);
        end;
      end;

      if FGoogleMaterial <> '' then
      begin
        InnerTag := AHTMLTag.Contents.AddTag('i');
        InnerTag.AddClassParam('material-icons');
        InnerTag.Contents.AddText(FGoogleMaterial);
        // If the user wants a non-standard Icon-Text gap
        if FIconTextGap <> '' then
        begin
          if FIconOnRight then
            InnerTag.AddStringParam('style', 'margin-left:' + FIconTextGap)
          else
            InnerTag.AddStringParam('style', 'margin-right:' + FIconTextGap);
        end;
      end;

      if not FIconOnRight then
      begin
        // See if badge is wanted
        if FBadge.Enabled then
        begin
          BadgeTag := AHTMLTag.Contents.AddTag('span');
          if FBadge.BadgePill then
            SpanClass := 'badge badge-pill ' + aIWBS4ContextualClass[FBadge.ContextualColor]
          else
            SpanClass := 'badge ' + aIWBS4ContextualClass[FBadge.ContextualColor];
          BadgeTag.AddClassParam(SpanClass);
          BadgeTag.Contents.AddText(FBadge.BadgeText);
        end;

        AHTMLTag.Contents.AddText(s);
      end;
    end;
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if Parent is TIWBS4InputGroup then
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'btn')
  else
    AHTMLTag := IWBS4CreateFormGroup(Parent, IWBS4FindParentInputForm(Parent), AHTMLTag, AHTMLName, True);

  // wrap item if parent is list
  TIWBS4List.WrapItem(Self, AHTMLTag);
end;

function TIWBS4Button.IsAnchor: Boolean;
begin
  if FElementType = bs4etAuto then
  begin
    if FDataTarget <> nil then
      Result := False
    else if FHref <> '#' then
      Result := True
    else if Parent is TIWBS4NavBarBase then
      Result := False
    else if Parent is TIWBS4List then
      Result := True
    else if (Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtListGroup) then
      Result := True
    else if (Parent is TIWBS4ButtonGroup) and TIWBS4ButtonGroup(Parent).BSJustified then
      Result := True
    else
      Result := False;
  end
  else
  begin
    Result := FElementType = bs4etAnchor;
  end;
end;

function TIWBS4Button.IsHrefStored: Boolean;
begin
  Result := FHref <> '#';
end;

function TIWBS4Button.IsTargetStored: Boolean;
begin
  Result := FTarget <> '';
end;

procedure TIWBS4Button.DoAsyncClickProc(Sender: TObject; EventParams: TStringList);
begin
  FAsyncClickProc(Sender, EventParams);
end;

function TIWBS4Button.GetDataToggle: string;
begin
  if (Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtDropDown) then
    Result := 'dropdown'
  else if FDataTarget = nil then
    Result := ''
  else if FDataTarget is TIWBS4ModalOld then
    Result := 'modal'
  else if (FDataTarget is TIWBS4CustomRegion) and TIWBS4CustomRegion(FDataTarget).Collapse then
    Result := 'collapse'
  else if FDataTarget is TIWBS4NavBarCollapse then
    Result := 'collapse';
end;

procedure TIWBS4Button.SetAsyncClickProc(Value: TIWBS4AsyncEventProc);
begin
  FAsyncClickProc := Value;
  OnAsyncClick := DoAsyncClickProc
end;

procedure TIWBS4Button.SetHref(const Value: string);
begin
  FHref := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetModalBackdrop(const Value: string);
begin
  if (Value <> '') and (Value <> 'true') and (Value <> 'false') and (Value <> 'static') then
  begin
    raise Exception.Create('Invalid value. Correct choices: true, false, static');
  end;

  FModalBackdrop := Value;
end;

procedure TIWBS4Button.SetOutline(const Value: Boolean);
begin
  if Value then
  begin
    if (FButtonStyle = bs4bsBasic) or (FButtonStyle = bs4bsLink) then
    begin
      raise Exception.Create('Cannot apply the "outline" Bootstrap class to Basic or Link');
    end;
  end;

  FOutline := Value;
end;

procedure TIWBS4Button.SetTarget(const Value: string);
begin
  FTarget := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetDataDismiss(const Value: TIWBS4ButtonDataDismiss);
begin
  FDataDismiss := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetDataParent(const Value: TIWCustomRegion);
begin
  if FDataParent <> Value then
  begin
    FDataParent := Value;
    AsyncRefreshControl;
  end;
end;

procedure TIWBS4Button.SetDataTarget(const Value: TIWCustomRegion);
begin
  if FDataTarget <> Value then
  begin
    FDataTarget := Value;
    AsyncRefreshControl;
  end;
end;

procedure TIWBS4Button.SetDataTargetID(const Value: string);
begin
  FDataTargetID := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetDataTargetRegion(const Value: TIWBS4Region);
begin
  FDataTargetRegion := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetDataTargetMoab(const Value: TIWBS4Moab);
begin
  FDataTargetMoab := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Button.SetElementType(const Value: TIWBS4ButtonElementType);
begin
  FElementType := Value;
  AsyncRefreshControl;
end;
{$endregion}

end.

