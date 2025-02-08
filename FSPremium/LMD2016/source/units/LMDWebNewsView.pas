unit LMDWebNewsView;
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

LMDWebNewsView unit (DD)
-----------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, LMDWebBase, LMDWebConst,
  LMDURLSupp, LMDWebXML, LMDNews, LMDWebNewsViewForm;

type
  TLMDWebNewsFormOptions = class(TPersistent)
  private
    FCaption: String;
    FShowToolsBar: Boolean;
    FShowGetNewsButton: Boolean;
    FShowHelpButton: Boolean;
    FShowPropertiesButton: Boolean;
    FGetNewsButtonHint: String;
    FHelpButtonHint: String;
    FPropertiesButtonHint: String;
  public
    constructor Create;
  published
    property Caption: String read FCaption write FCaption;
    property ShowToolsBar: Boolean read FShowToolsBar write FShowToolsBar default false;
    property ShowGetNewsButton: Boolean read FShowGetNewsButton write FShowGetNewsButton default True;
    property ShowHelpButton: Boolean read FShowHelpButton write FShowHelpButton default True;
    property ShowPropertiesButton: Boolean read FShowPropertiesButton write FShowPropertiesButton default True;
    property GetNewsButtonHint: String read FGetNewsButtonHint write FGetNewsButtonHint;
    property HelpButtonHint: String read FHelpButtonHint write FHelpButtonHint;
    property PropertiesButtonHint: String read FPropertiesButtonHint write FPropertiesButtonHint;
  end;

  TLMDWebNewsView = class(TLMDWebComponent)
  private
    FLoading: Boolean;
    FImageList: TImageList;
    FNews: TLMDWebNews;
    FNewsFormOptions: TLMDWebNewsFormOptions;
    FOnNewsClick: TLMDOnNewsEvent;
    FOnNewsHint:TNotifyEvent;
    FOnGetNewsClick: TNotifyEvent;
    FOnHelpClick: TNotifyEvent;
    FOnPropertiesClick: TNotifyEvent;    
    procedure SetImageList(const Value: TImageList);
    procedure SetLoading(const Value: Boolean);
    procedure SetNews(const Value: TLMDWebNews);
    procedure SetNewsFormOptions(const Value: TLMDWebNewsFormOptions);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
  published
    property  News: TLMDWebNews read FNews write SetNews;
    property  ImageList: TImageList read FImageList write SetImageList;
    property  Loading: Boolean read FLoading write SetLoading default True;
    property  NewsFormOptions: TLMDWebNewsFormOptions read FNewsFormOptions
     write SetNewsFormOptions;
    property OnNewsClick: TLMDOnNewsEvent read FOnNewsClick write FOnNewsClick;
    property OnNewsHint: TNotifyEvent read FOnNewsHint write FOnNewsHint;
    property OnGetNewsClick: TNotifyEvent read FOnGetNewsClick write FOnGetNewsClick;
    property OnHelpClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;
    property OnPropertiesClick: TNotifyEvent read FOnPropertiesClick write FOnPropertiesClick;
  end;

implementation

constructor TLMDWebNewsFormOptions.Create;
begin
  inherited Create;
  FCaption := 'Latest news';
  FShowToolsBar := False;
  FShowGetNewsButton := True;
  FShowHelpButton := True;
  FShowPropertiesButton := True;
  FGetNewsButtonHint := '';
  FHelpButtonHint := '';
  FPropertiesButtonHint := '';
end;

{ TLMDWebNewsView }

procedure TLMDWebNewsView.Execute;
var
  VF : TLMDWebNewsViewForm_;
begin
  VF := TLMDWebNewsViewForm_.Create(nil);
  try
    VF.LMDWebNews := News;
    VF.ImageList := ImageList;
    VF.bLoading := Loading;
    VF.Caption := NewsFormOptions.Caption;
    VF.ToolBar.Visible := NewsFormOptions.ShowToolsBar;
    VF.GetNewsButton.Visible := NewsFormOptions.ShowGetNewsButton;
    VF.HelpButton.Visible := NewsFormOptions.ShowHelpButton;
    VF.PropertiesButton.Visible := NewsFormOptions.ShowPropertiesButton;
    VF.GetNewsButton.Hint := NewsFormOptions.GetNewsButtonHint;
    VF.GetNewsButton.ShowHint := NewsFormOptions.GetNewsButtonHint <> '';
    VF.HelpButton.Hint := NewsFormOptions.HelpButtonHint;
    VF.HelpButton.ShowHint := NewsFormOptions.HelpButtonHint <> '';
    VF.PropertiesButton.Hint := NewsFormOptions.PropertiesButtonHint;
    VF.PropertiesButton.ShowHint := NewsFormOptions.PropertiesButtonHint <> '';
    VF.OnNewsClick := FOnNewsClick;
    VF.OnNewsHint := FOnNewsHint;
    VF.OnGetNewsClick := FOnGetNewsClick;
    VF.OnHelpClick := FOnHelpClick;
    VF.OnPropertiesClick := FOnPropertiesClick;
    VF.ShowModal;
  finally
    VF.Free;
  end;
end;

procedure TLMDWebNewsView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FImageList) and (Operation = opRemove) then
    FImageList := nil
  else
    if (AComponent = FNews) and (Operation = opRemove) then
      FNews := nil;
end;

constructor TLMDWebNewsView.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FNewsFormOptions := TLMDWebNewsFormOptions.Create;
  FLoading := True;
end;

destructor TLMDWebNewsView.Destroy;
begin
  FreeAndNil(FNewsFormOptions);
  inherited Destroy;
end;

procedure TLMDWebNewsView.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
  if FImageList <> nil then
  begin
    FImageList.FreeNotification(Self);
  end;
end;

procedure TLMDWebNewsView.SetLoading(const Value: Boolean);
begin
  FLoading := Value;
end;

procedure TLMDWebNewsView.SetNews(const Value: TLMDWebNews);
begin
  FNews := Value;
  if FNews<>nil then
  begin
    FNews.FreeNotification(Self);
  end;
end;

procedure TLMDWebNewsView.SetNewsFormOptions(const Value: TLMDWebNewsFormOptions);
begin
  FNewsFormOptions.Assign(Value);
end;

end.
