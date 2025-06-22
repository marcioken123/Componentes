unit IWBS4Modal;

interface

uses
  SysUtils, Classes, Controls, StrUtils, IWApplication, IWControl, IWHTMLTag,
  IWRenderContext, IWBS4Common, IWBS4Customregion;

type
  TIWBS4Modal = class(TIWBS4CustomRegion)
  private
    FWrapperSuffix: string;
    FDestroyOnHide: Boolean;
    FFade: Boolean;
    FModalVisible: Boolean;
    FOnAsyncShow: TIWAsyncEvent;
    FOnAsyncHide: TIWAsyncEvent;
  protected
    function GetShowScript: string;
    function GetHideScript: string;
    procedure SetModalVisible(AValue: Boolean);
    procedure DoOnAsyncShow(AParams: TStringList); virtual;
    procedure DoOnAsyncHide(AParams: TStringList); virtual;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRoleString: string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSFade: Boolean read FFade write FFade default False;
    property ModalVisible: Boolean read FModalVisible write SetModalVisible default False;
    property DestroyOnHide: Boolean read FDestroyOnHide write FDestroyOnHide default False;
    property OnAsyncShow: TIWAsyncEvent read FOnAsyncShow write FOnAsyncShow;
    property OnAsyncHide: TIWAsyncEvent read FOnAsyncHide write FOnAsyncHide;
  end;

  TIWBS4ModalDialog = class(TIWBS4CustomRegion)
  private
    FCentered: Boolean;
    FDialogSize: TIWBS4Size;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Centered: Boolean read FCentered write FCentered default True;
    property BSDialogSize: TIWBS4Size read FDialogSize write FDialogSize default bs4szDefault;
  end;

  TIWBS4ModalContent = class(TIWBS4CustomRegion)
  private
    //
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
  end;

implementation

uses IWBS4Utils;

constructor TIWBS4Modal.Create(AOwner: TComponent);
begin
  inherited;
  FDestroyOnHide := False;
  FFade := False;
  FModalVisible := False;
  FWrapperSuffix := '_wrp';
end;

destructor TIWBS4Modal.Destroy;
begin
  SetModalVisible(False);
  inherited;
end;

procedure TIWBS4Modal.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'modal-dialog');
  inherited;
end;

function TIWBS4Modal.GetRoleString: string;
begin
  Result := 'dialog';
end;

function TIWBS4Modal.GetShowScript: string;
begin
  Result := '$("#' + HTMLName + FWrapperSuffix + '").modal({backdrop: "static", "keyboard": true});';
end;

function TIWBS4Modal.GetHideScript: string;
begin
  Result := '$("#' + HTMLName + FWrapperSuffix + '").modal("hide");';
end;

procedure TIWBS4Modal.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  AScript.Add('$("#' + AHTMLName + FWrapperSuffix + '").off("shown.bs.modal").on("shown.bs.modal", function() { var elem; elem = $(this).find("[autofocus]"); if (elem.length !== 0) {elem.focus();} else {$(this).find("button:last").focus(); } });');
  if Assigned(FOnAsyncShow) then
  begin
    AScript.Add('$("#' + AHTMLName + FWrapperSuffix + '").off("show.bs.modal").on("show.bs.modal", function(e){ executeAjaxEvent("", null, "' + AHTMLName + '.DoOnAsyncShow", true, null, true); });');
    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnAsyncShow', DoOnAsyncShow);
  end;
  AScript.Add('$("#' + AHTMLName + FWrapperSuffix + '").off("hidden.bs.modal").on("hidden.bs.modal", function(e){ executeAjaxEvent("", null, "' + AHTMLName + '.DoOnAsyncHide", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnAsyncHide', DoOnAsyncHide);
  if FModalVisible then
  begin
    AScript.Add(GetShowScript);
  end;

  inherited;
end;

function TIWBS4Modal.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  lCss: string;
begin
  inherited;

  if FFade
    then FRegionDiv.AddClassParam('modal fade')
    else FRegionDiv.AddClassParam('modal');

  Result := FRegionDiv;

  Exit;


//FMainID := HTMLName + FWrapperSuffix;
  Result := TIWHTMLTag.CreateTag('div');
//Result.Contents.AddTagAsObject(FRegionDiv);
  Result.AddStringParam('id', FMainID);
  lCss := 'modal';
  if FFade then
  begin
    TIWBS4Common.AddCssClass(lCss, 'fade');
  end;
  Result.AddClassParam(lCss);
end;

procedure TIWBS4Modal.SetModalVisible(AValue: Boolean);
begin
  if AValue <> FModalVisible then
  begin
    if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    begin
      if AValue
        then IWBS4ExecuteAsyncJScript(GetShowScript)
        else IWBS4ExecuteAsyncJScript(GetHideScript);
    end;
    FModalVisible := AValue;
  end;
end;

procedure TIWBS4Modal.DoOnAsyncShow(AParams: TStringList);
begin
  FOnAsyncShow(Self, AParams);
end;

procedure TIWBS4Modal.DoOnAsyncHide(AParams: TStringList);
begin
  FModalVisible := False;
  if Assigned(FOnAsyncHide) then
  begin
    FOnAsyncHide(Self, AParams);
  end;
  if FDestroyOnHide then
  begin
    AsyncRemoveControl;
    Release;
  end;
end;

constructor TIWBS4ModalDialog.Create(AOwner: TComponent);
begin
  inherited;
  FCentered := True;
  FDialogSize := bs4szDefault;
end;

procedure TIWBS4ModalDialog.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'modal-dialog');
  if FDialogSize in [bs4szLg, bs4szSm] then
  begin
    TIWBS4Common.AddCssClass(ACss, 'modal-' + aIWBS4Size[FDialogSize]);
  end;
  if FCentered then
  begin
    TIWBS4Common.AddCssClass(ACss, 'modal-dialog-centered');
  end;

  inherited;
end;

function TIWBS4ModalDialog.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  lCss: string;
begin
  inherited;

  FMainID := HTMLName; // + FWrapperSuffix;
  Result := TIWHTMLTag.CreateTag('div');
  Result.Contents.AddTagAsObject(FRegionDiv);
  Result.AddStringParam('id', FMainID);
  lCss := 'modal';
  Result.AddClassParam(lCss);
end;

constructor TIWBS4ModalContent.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TIWBS4ModalContent.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'modal-content');
  inherited;
end;

function TIWBS4ModalContent.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  inherited;

  Result := TIWHTMLTag.CreateTag('div');
  Result.AddStringParam('id', FMainID);
  Result.AddClassParam('modal-dialog');
end;

end.
