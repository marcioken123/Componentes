unit IWBS4InputForm;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWApplication, IWRenderContext,
  IWHTMLTag, IW.HTTP.Request, IW.HTTP.Reply, IWBaseInterfaces, IWBS4InputTypes,
  IWBS4Common, IWBS4RestServer, IWBS4BaseContainer, IWBS4CustomRegion;

type
  // See if we can get rid of this class
  TIWBS4FormOptions = class(TPersistent)
  private
  //FCaptionsSize: TIWBS4GridOptions; // cannot find such a thing
  //FInputsSize: TIWBS4InputSize;
  protected
    procedure SetCaptionsSize(const Value: TIWBS4GridOptions);
    procedure SetInputsSize(const Value: TIWBS4GridOptions);
  public
    constructor Create(AOwner: IIWBaseControl);
    destructor Destroy; override;
    function GetOffsetClassString: string;
    procedure Assign(Source: TPersistent); override;
  published
  //property CaptionsSize: TIWBS4GridOptions read FCaptionsSize write SetCaptionsSize;
  //property InputsSize: TIWBS4InputSize read FInputsSize write SetInputsSize;
  end;
  {$include IWPlatformAttrib.inc}
  TIWBS4InputForm = class(TIWBS4CustomRegion)
  private
    FEncType: TIWBS4FormEncType;
    FFormType: TIWBS4FormType;
  //FFormOptions: TIWBS4FormOptions;
    FInputsSize: TIWBS4InputSize;
    FOnSubmit: TIWBS4InputFormSubmitEvent;
    procedure DoSubmit(AApplication: TIWApplication; ARequest: THttpRequest; AReply: THttpReply; AParams: TStrings);
    procedure SetEncType(const Value: TIWBS4FormEncType);
    procedure SetFormType(const Value: TIWBS4FormType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
  published
    property BSFormType: TIWBS4FormType read FFormType write SetFormType default bs4ftStacked;
  //property BSFormOptions: TIWBS4FormOptions read FFormOptions write FFormOptions;
    property InputsSize: TIWBS4InputSize read FInputsSize write FInputsSize default bs4isDefault;
    property EncType: TIWBS4FormEncType read FEncType write SetEncType default bs4feDefault;
    property OnSubmit: TIWBS4InputFormSubmitEvent read FOnSubmit write FOnSubmit;
  end;
  {$include IWPlatformAttrib.inc}
  TIWBS4InputGroup = class(TIWBS4CustomRegion)
  private
    FCaption: string;
    FRelativeSize: TIWBS4RelativeSize;
    procedure SetCaption(const Value: string);
    procedure SetRelativeSize(const Value: TIWBS4RelativeSize);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write SetCaption;
    property BSRelativeSize: TIWBS4RelativeSize read FRelativeSize write SetRelativeSize default bs4rzDefault;
  end;
  {$include IWPlatformAttrib.inc}
  TIWBS4FormGroup = class(TIWBS4CustomRegion)
  private
    FCaption: string;
    FFormCheck: Boolean;
    procedure SetCaption(const Value: string);
  public
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Caption: string read FCaption write SetCaption;
    property FormCheck: Boolean read FFormCheck write FFormCheck;
  end;

function IWBS4FindParentInputForm(AParent: TControl): TIWBS4InputForm;

implementation

uses
  IWBS4InputCommon, IWBS4NavBar, IWContainer;

type
  TIWContainerHack = class(TIWContainer);

function IWBS4FindParentInputForm(AParent: TControl): TIWBS4InputForm;
begin
  if AParent is TIWBS4InputForm then
  begin
    Result := TIWBS4InputForm(AParent)
  end
  else if (AParent <> nil) and (AParent.Parent <> nil) then
    Result := IWBS4FindParentInputForm(AParent.Parent)
  else
    Result := nil;
end;
{$region 'TIWBS4FormOptions'}
constructor TIWBS4FormOptions.Create(AOwner: IIWBaseControl);
begin
//FCaptionsSize := TIWBS4GridOptions.Create(AOwner);
//FInputsSize := TIWBS4GridOptions.Create(AOwner);
end;

destructor TIWBS4FormOptions.Destroy;
begin
//FreeAndNil(FCaptionsSize);
//FreeAndNil(FInputsSize);
  inherited;
end;

procedure TIWBS4FormOptions.SetCaptionsSize(const Value: TIWBS4GridOptions);
begin
//FCaptionsSize.Assign(Value);
end;

procedure TIWBS4FormOptions.SetInputsSize(const Value: TIWBS4GridOptions);
begin
//FInputsSize.Assign(Value);
end;

function TIWBS4FormOptions.GetOffsetClassString: string;
begin
 {Result := FInputsSize.GetClassString(
    FCaptionsSize.GridSmOffset + FCaptionsSize.GridSmSpan,
    FCaptionsSize.GridMdOffset + FCaptionsSize.GridMdSpan,
    FCaptionsSize.GridLgOffset + FCaptionsSize.GridLgSpan,
    FCaptionsSize.GridXlOffset + FCaptionsSize.GridXlSpan);}
end;

procedure TIWBS4FormOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBS4FormOptions then
  begin
  //CaptionsSize.Assign(TIWBS4FormOptions(Source).CaptionsSize);
  //InputsSize.Assign(TIWBS4FormOptions(Source).InputsSize);
  end
  else
  begin
    inherited;
  end;
end;
{$endregion}

{$region 'TIWBS4InputFormOld'}

constructor TIWBS4InputForm.Create(AOwner: TComponent);
begin
  inherited;
  FEncType := bs4feDefault;
//FFormOptions := TIWBS4FormOptions.Create(Self);
  FInputsSize := bs4isDefault;
  FFormType := bs4ftStacked;
  FTagName := 'form'
end;

destructor TIWBS4InputForm.Destroy;
begin
//FreeAndNil(FFormOptions);

  inherited;
end;

procedure TIWBS4InputForm.InternalRenderCss(var ACss: string);
begin
  if FFormType = bs4ftInline then
  begin
    TIWBS4Common.AddCssClass(ACss, 'form-inline');
  end;

  if Parent is TIWBS4NavBarBase then
  begin
    TIWBS4Common.AddCssClass(ACss, 'navbar-form');
  end;

  inherited;
end;

function TIWBS4InputForm.GetRoleString: string;
begin
  Result := 'form';
end;

procedure TIWBS4InputForm.DoSubmit(AApplication: TIWApplication; ARequest: THttpRequest; AReply: THttpReply; AParams: TStrings);
begin
  if Assigned(FOnSubmit) then
  begin
    FOnSubmit(ARequest, AParams);
  end;
  AReply.SendRedirect(AApplication.SessionUrlBase);
end;

function TIWBS4InputForm.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  LParentForm: TIWBS4InputForm;
begin
  LParentForm := IWBS4FindParentInputForm(Parent);
  if LParentForm <> nil then
  begin
    raise Exception.Create('forms can not be nested, you try to put ' + Name + ' inside ' + LParentForm.Name);
  end;

  Result := inherited;

  if Assigned(FOnSubmit) then
  begin
    Result.AddStringParam('method', 'post');
    if FEncType = bs4feMultipart then
    begin
      Result.AddStringParam('enctype', 'multipart/form-data')
    end
    else if FEncType = bs4feText then
    begin
      Result.AddStringParam('enctype', 'text/plain');
    end;

    Result.AddStringParam('action', IWBS4RegisterRestCallBack(AContext.WebApplication, HTMLName + '.FormSubmit', DoSubmit, (FEncType = bs4feMultipart)));
  end
  else
  begin
    // #CSP: FormDefaultSubmit() function will be hooked into onSubmit event of all
    // forms having iw_default_submit_form class.
    // This occurs in JavaScript, so we don't need to use inline JavaScript here
    Result.AddClassParam('iw_default_submit_form');
    //Result.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
  end;
end;

procedure TIWBS4InputForm.SetEncType(const Value: TIWBS4FormEncType);
begin
  FEncType := Value;
  Invalidate;
end;

procedure TIWBS4InputForm.SetFormType(const Value: TIWBS4FormType);
begin
  FFormType := Value;
  Invalidate;
end;
{$endregion}

constructor TIWBS4InputGroup.Create(AOwner: TComponent);
begin
  inherited;
  FRelativeSize := bs4rzDefault;
end;

procedure TIWBS4InputGroup.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'input-group');
  if FRelativeSize <> bs4rzDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, 'input-group-' + aIWBS4RelativeSize[FRelativeSize]);
  end;

  inherited;
end;

function TIWBS4InputGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;
  Result := IWBS4CreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);
end;

procedure TIWBS4InputGroup.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TIWBS4InputGroup.SetRelativeSize(const Value: TIWBS4RelativeSize);
begin
  FRelativeSize := Value;
  Invalidate;
end;

function TIWBS4FormGroup.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
 {Result := inherited;
  Result := IWBS4CreateInputFormGroup(Self, Parent, Result, FCaption, HTMLName);}

  FRegionDiv := TIWHTMLTag.CreateTag('div');
  if FFormCheck then
    FRegionDiv.AddClassParam('form-check')
  else
    FRegionDiv.AddClassParam('form-group');

  Result := FRegionDiv;
end;

procedure TIWBS4FormGroup.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

end.

