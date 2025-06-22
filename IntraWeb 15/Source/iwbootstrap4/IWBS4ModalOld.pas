unit IWBS4ModalOld;

interface

uses
  SysUtils, Classes, Controls, StrUtils, IWApplication, IWControl, IWHTMLTag,
  IWRenderContext, IWBS4Common, IWBS4Customregion;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4ModalOld = class(TIWBS4CustomRegion)
  private
    FWrapperSuffix: string;
    FDestroyOnHide: Boolean;
    FDialogSize: TIWBS4Size;
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
    property BSDialogSize: TIWBS4Size read FDialogSize write FDialogSize default bs4szDefault;
    property ModalVisible: Boolean read FModalVisible write SetModalVisible default False;
    property DestroyOnHide: Boolean read FDestroyOnHide write FDestroyOnHide default False;
    property OnAsyncShow: TIWAsyncEvent read FOnAsyncShow write FOnAsyncShow;
    property OnAsyncHide: TIWAsyncEvent read FOnAsyncHide write FOnAsyncHide;
  end;

implementation

uses
  IWBS4Utils;

constructor TIWBS4ModalOld.Create(AOwner: TComponent);
begin
  inherited;
  FDestroyOnHide := False;
  FDialogSize := bs4szDefault;
  FFade := False;
  FModalVisible := False;
  FWrapperSuffix := '_wrp';
end;

destructor TIWBS4ModalOld.Destroy;
begin
  SetModalVisible(False);
  inherited;
end;

procedure TIWBS4ModalOld.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'modal-dialog');
  if FDialogSize in [bs4szLg, bs4szSm] then
  begin
    TIWBS4Common.AddCssClass(ACss, 'modal-' + aIWBS4Size[FDialogSize]);
  end;
  inherited;
end;

function TIWBS4ModalOld.GetRoleString: string;
begin
  Result := 'dialog';
end;

function TIWBS4ModalOld.GetShowScript: string;
begin
  Result := '$("#' + HTMLName + FWrapperSuffix + '").modal({backdrop: "static", "keyboard": true});';
end;

function TIWBS4ModalOld.GetHideScript: string;
begin
  Result := '$("#' + HTMLName + FWrapperSuffix + '").modal("hide");';
end;

procedure TIWBS4ModalOld.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
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

function TIWBS4ModalOld.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  lCss: string;
begin
  inherited;

  FMainID := HTMLName + FWrapperSuffix;
  Result := TIWHTMLTag.CreateTag('div');
  Result.Contents.AddTagAsObject(FRegionDiv);
  Result.AddStringParam('id', FMainID);
  lCss := 'modal';
  if FFade then
  begin
    TIWBS4Common.AddCssClass(lCss, 'fade');
  end;
  Result.AddClassParam(lCss);
end;

procedure TIWBS4ModalOld.SetModalVisible(AValue: Boolean);
begin
  if AValue <> FModalVisible then
  begin
    if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    begin
      if AValue then
        IWBS4ExecuteAsyncJScript(GetShowScript)
      else
        IWBS4ExecuteAsyncJScript(GetHideScript);
    end;
    FModalVisible := AValue;
  end;
end;

procedure TIWBS4ModalOld.DoOnAsyncShow(AParams: TStringList);
begin
  FOnAsyncShow(Self, AParams);
end;

procedure TIWBS4ModalOld.DoOnAsyncHide(AParams: TStringList);
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

end.

