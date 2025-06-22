unit IWBS4Dialogs;

interface
{$Include IWBootstrap4.inc}

uses Classes, SysUtils, Controls,
     IWControl, IWRenderContext, IWBaseRenderContext, IWHTMLTag, IWForm,
     IWBS4CustomRegion, IWBS4Region, IWBS4ModalOld, IWBS4Button, IWBS4Controls;

type
  TIWBS4DialogCloseButton = (iwbs4dcNone, iwbs4dcCaption, iwbs4dcFooter, iwbs4dcBoth);

  {$include IWPlatformAttrib.inc}
  TIWBS4Dialog = class(TIWBS4ModalOld)
  private
    FContent: TIWBS4Region;
    FHeader: TIWBS4Region;
    FBody: TIWBS4Region;
    FFooter: TIWBS4Region;
    FBodyControl: TIWBS4Text;
    FTitleControl: TIWBS4Label;
    FAsyncDismissProc: TIWBS4AsyncEventProc;
    procedure SetBodyText(const Value: string);
    function GetBodyText: string;
    procedure SetTitleText(const Value: string);
    function GetTitleText: string;
  protected
    procedure DoOnAsyncHide(AParams: TStringList); override;
  public
    constructor Create(AForm: TIWForm; const ATitleText, ABodyText: string; ACloseButton: TIWBS4DialogCloseButton = iwbs4dcBoth; AAsyncDismissProc: TIWBS4AsyncEventProc = nil); reintroduce; overload;
    constructor Create(const ATitleText, ABodyText: string; ACloseButton: TIWBS4DialogCloseButton = iwbs4dcBoth; AAsyncDismissProc: TIWBS4AsyncEventProc = nil); reintroduce; overload;
    constructor Create(const ATitleText, ABodyText: string; AAsyncDismissProc: TIWBS4AsyncEventProc); reintroduce; overload;

    function AddButton(AParent: TIWBS4Region; const ACaption: string; AAsyncClickProc: TIWBS4AsyncEventProc = nil; ADismiss: Boolean = True): TIWBS4Button;
    function GetHeader: TIWBS4Region;
    function GetBody: TIWBS4Region;
    function GetFooter: TIWBS4Region;
    function GetBodyControl: TIWBS4Text;
    function GetTitleControl: TIWBS4Label;
    property BodyText: string read GetBodyText write SetBodyText;
    property TitleText: string read GetTitleText write SetTitleText;
  end;

  // Discarding this implementation of alert -- based on wrong class, causes run-time error
  // (which is probably why it wasn't listed in Register procedure
  TIWBS4AlertStyle = (bs4asSuccess, bs4asInfo, bs4asWarning, bs4asDanger);
  TIWBS4AlertPosition = (bs4apDefault, bs4apRightTop, bs4apRightCenter, bs4apRightBottom);

  {$include IWPlatformAttrib.inc}
  TIWBS4Alert = class(TIWBS4CustomRegion)
  private
    FAlertVisible: Boolean;
    FAlertPosition: TIWBS4AlertPosition;
    FAlertStyle: TIWBS4AlertStyle;
    FAlertText: string;
    FFade: Boolean;
    FOnAsyncClose: TIWAsyncEvent;
    FAlertLabel: TIWBS4Label;
    FCloseButton: TIWBS4Button;
  protected
    procedure DoOnAsyncClose(AParams: TStringList); virtual;
    function GetCloseScript: string;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
    procedure SetAlertStyle(AValue: TIWBS4AlertStyle);
  public
    constructor Create(AForm: TIWForm; const AAlertText: string; AAlertStyle: TIWBS4AlertStyle = bs4asSuccess); reintroduce; overload;
    constructor Create(const AAlertText: string; AAlertStyle: TIWBS4AlertStyle = bs4asSuccess); reintroduce; overload;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function AddButton(const ACaption: string; AAsyncClickProc: TIWBS4AsyncEventProc = nil): TIWBS4Button;
    property AlertStyle: TIWBS4AlertStyle read FAlertStyle write SetAlertStyle default bs4asSuccess;
    property AlertPosition: TIWBS4AlertPosition read FAlertPosition write FAlertPosition default bs4apRightTop;
    property AlertText: string read FAlertText write FAlertText;
    property Fade: Boolean read FFade write FFade default True;
    property AlertLabel: TIWBS4Label read FAlertLabel;
    property OnAsyncClose: TIWAsyncEvent read FOnAsyncClose write FOnAsyncClose;
  end;

var
  sIWBS4DialogCloseCaption: string = 'Close';

implementation

uses IWApplication, IWBS4Utils, IWBS4Common;

{$region 'TIWBS4Dialog'}
constructor TIWBS4Dialog.Create(AForm: TIWForm; const ATitleText, ABodyText: string;
  ACloseButton: TIWBS4DialogCloseButton = iwbs4dcBoth; AAsyncDismissProc: TIWBS4AsyncEventProc = nil);
begin
  inherited Create(AForm);
  Parent := AForm;

  DestroyOnHide := True;
  ModalVisible := True;

  FContent := TIWBS4Region.Create(Owner);
  FContent.BSRegionType := bs4rtModalContent;
  FContent.Parent := Self;

  FAsyncDismissProc := AAsyncDismissProc;

  if ACloseButton in [iwbs4dcCaption, iwbs4dcBoth] then
    with TIWBS4Button.Create(Owner) do
    begin
      Parent := GetHeader;
      Top := 0;
      Left := 0;
      Caption := '';
      BSButtonStyle := bs4bsClose;
      DataDismiss := bs4bdModal;
    end;

  SetBodyText(ABodyText);
  SetTitleText(ATitleText);

  if ACloseButton in [iwbs4dcFooter, iwbs4dcBoth] then
  begin
    with TIWBS4Button.Create(Owner) do
    begin
      Parent := GetFooter;
      Caption := sIWBS4DialogCloseCaption;
      Top := 0;
      Left := MaxInt;
      DataDismiss := bs4bdModal;
    end;
  end;
end;

constructor TIWBS4Dialog.Create(const ATitleText, ABodyText: string; AAsyncDismissProc: TIWBS4AsyncEventProc);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), ATitleText, ABodyText, iwbs4dcBoth, AAsyncDismissProc);
end;

constructor TIWBS4Dialog.Create(const ATitleText, ABodyText: string; ACloseButton: TIWBS4DialogCloseButton = iwbs4dcBoth; AAsyncDismissProc: TIWBS4AsyncEventProc = nil);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), ATitleText, ABodyText, ACloseButton, AAsyncDismissProc);
end;

procedure TIWBS4Dialog.DoOnAsyncHide(AParams: TStringList);
begin
  if Assigned(FAsyncDismissProc) then
  begin
    FAsyncDismissProc(Self, AParams);
  end;
  inherited;
end;

function TIWBS4Dialog.GetBodyControl: TIWBS4Text;
begin
  if FBodyControl = nil then
  begin
    FBodyControl := TIWBS4Text.Create(Owner);
    FBodyControl.Parent := GetBody;
    FBodyControl.Top := 0;
    FBodyControl.Left := 0;
  end;
  Result := FBodyControl;
end;

function TIWBS4Dialog.GetBodyText: string;
begin
  if FBodyControl <> nil
    then Result := FBodyControl.Lines.Text
    else Result := '';
end;

function TIWBS4Dialog.GetTitleControl: TIWBS4Label;
begin
  if FTitleControl = nil then
  begin
    FTitleControl := TIWBS4Label.Create(Owner);
    FTitleControl.Parent := GetHeader;
    FTitleControl.Top := 0;
    FTitleControl.Left := 20;
  end;
  Result := FTitleControl;
end;

function TIWBS4Dialog.GetTitleText: string;
begin
  if FTitleControl <> nil
    then Result := FTitleControl.Caption
    else Result := '';
end;

function TIWBS4Dialog.GetHeader: TIWBS4Region;
begin
  if FHeader = nil then
  begin
    FHeader := TIWBS4Region.Create(Owner);
    FHeader.Parent := FContent;
    FHeader.BSRegionType := bs4rtModalHeader;
    FHeader.Top := 100;
  end;
  Result := FHeader;
end;

function TIWBS4Dialog.GetBody: TIWBS4Region;
begin
  if FBody = nil then
  begin
    FBody := TIWBS4Region.Create(Owner);
    FBody.Parent := FContent;
    FBody.BSRegionType := bs4rtModalBody;
    FBody.Top := 200;
  end;
  Result := FBody;
end;

function TIWBS4Dialog.GetFooter: TIWBS4Region;
begin
  if FFooter = nil then
  begin
    FFooter := TIWBS4Region.Create(Owner);
    FFooter.Parent := FContent;
    FFooter.BSRegionType := bs4rtModalFooter;
    FFooter.Top := 300;
  end;
  Result := FFooter;
end;

procedure TIWBS4Dialog.SetBodyText(const Value: string);
begin
  if Value <> '' then
  begin
    GetBodyControl.Lines.Text := Value;
  end;
end;

procedure TIWBS4Dialog.SetTitleText(const Value: string);
begin
  if Value <> '' then
  begin
    GetTitleControl.Caption := Value;
  end;
end;

function TIWBS4Dialog.AddButton(AParent: TIWBS4Region; const ACaption: string;
  AAsyncClickProc: TIWBS4AsyncEventProc = nil; ADismiss: Boolean = True): TIWBS4Button;
begin
  Result := TIWBS4Button.Create(Owner);
  Result.Parent := AParent;
  Result.Caption := ACaption;
  if Assigned(AAsyncClickProc) then
  begin
    Result.AsyncClickProc :=
      procedure(Sender: TObject; EventParams: TStringList)
      begin
        AAsyncClickProc(Sender, EventParams);
        if ADismiss then
        begin
          FAsyncDismissProc := nil;
          ModalVisible := False;
        end;
      end;
  end else
  begin
    Result.DataDismiss := bs4bdModal;
  end;
end;
{$endregion}

{$region 'TIWBS4Alert'}
constructor TIWBS4Alert.Create(AForm: TIWForm; const AAlertText: string;
  AAlertStyle: TIWBS4AlertStyle = bs4asSuccess);
begin
  inherited Create(AForm);
  Parent := AForm;
  FAlertVisible := False;
  FAlertPosition := bs4apRightTop;
  FAlertStyle := bs4asSuccess;
  FAlertText := AAlertText;
  FFade := True;

  FAlertLabel := TIWBS4Label.Create(Self);
  FAlertLabel.Parent := Self;
  FAlertLabel.Name := Name + '_LABEL';
  FAlertLabel.Caption := AAlertText;
  FCloseButton := TIWBS4Button.Create(Self);
  FCloseButton.Parent := Self;
  FCloseButton.Name := Name + '_CLOSEBTN';
  FCloseButton.Caption := '';
  FCloseButton.BSButtonStyle := bs4bsClose;
  FCloseButton.DataDismiss := bs4bdAlert;
end;

constructor TIWBS4Alert.Create(const AAlertText: string; AAlertStyle: TIWBS4AlertStyle = bs4asSuccess);
begin
  Create(TIWForm(GGetWebApplicationThreadVar.ActiveForm), AAlertText, AAlertStyle);
end;

destructor TIWBS4Alert.Destroy;
begin
  if FAlertVisible then
  begin
    IWBS4ExecuteAsyncJScript(GetCloseScript);
    FAlertVisible := False;
  end;

  inherited;
end;

procedure TIWBS4Alert.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  inherited;

  AScript.Add('$("#' + AHTMLName + '").on("closed.bs.alert", function(e){ executeAjaxEvent("", null, "' + AHTMLName + '.DoOnAsyncClose", true, null, true); });');
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnAsyncClose', DoOnAsyncClose);
end;

function TIWBS4Alert.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
begin
  xHTMLName := HTMLName;

  Result := inherited;

  FAlertVisible := True;
end;

procedure TIWBS4Alert.SetAlertStyle(AValue: TIWBS4AlertStyle);
begin
  FAlertStyle := AValue;
end;

procedure TIWBS4Alert.InternalRenderCss(var ACss: string);
const
  aIWBS4AlertStyle: array[bs4asSuccess..bs4asDanger] of string = ('success', 'info', 'warning', 'danger');
  aIWBS4AlertPosition: array[bs4apRightTop..bs4apRightBottom] of string = ('right-top', 'right-center', 'right-bottom');
begin
  TIWBS4Common.AddCssClass(ACss, 'alert alert-' + aIWBS4AlertStyle[FAlertStyle]);
  if FFade then
  begin
    TIWBS4Common.AddCssClass(ACss, 'fade in');
  end;
  if FAlertPosition <> bs4apDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, 'flyover flyover-' + aIWBS4AlertPosition[FAlertPosition]);
  end;

  inherited;
end;

function TIWBS4Alert.GetCloseScript: string;
begin
  Result := '$("#' + HTMLName + '").alert("close");';
end;

procedure TIWBS4Alert.DoOnAsyncClose(AParams: TStringList);
begin
  if Assigned(FOnAsyncClose) then
  begin
    FOnAsyncClose(Self, AParams);
  end;
  FAlertVisible := False;
  Free;
end;

function TIWBS4Alert.AddButton(const ACaption: string; AAsyncClickProc: TIWBS4AsyncEventProc = nil): TIWBS4Button;
begin
  Result := TIWBS4Button.Create(Owner);
  Result.Parent := Self;
  Result.Caption := ACaption;
  Result.AsyncClickProc := AAsyncClickProc;
end;
{$endregion}

end.
