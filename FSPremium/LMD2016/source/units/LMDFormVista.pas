unit LMDFormVista;

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

LMDFormVista unit (AH)
----------------------


Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}
{$I lmdcmps.inc}
interface

uses
  {$ifndef LMDCOMP11}LMDDWMApi,{$endif}
  Classes, Windows, SysUtils, Messages, Forms, UxTheme,
  LMDSysIn, LMDCustomComponent, LMDWndProcComponent;

type
  TLMDFormVistaExtension = class(TLMDCustomComponent)
  private
    FAppStyle: Integer;
    FMainFrmStyle: Integer;
    FOldTitle: String;
    FEnabled: boolean;
    FOwnerFormShow: TNotifyEvent;
    procedure SetEnabled(const Value: boolean);
    procedure OwnerFormShow(Sender:TObject);
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Install;
    procedure UnInstall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef LMDCOMP9}
    procedure ShowModalChildForm(const AForm: TCustomForm);
    {$endif}
    procedure FixFonts(const AForm: TCustomForm);
  published
    property About;
    property Enabled: boolean read FEnabled write SetEnabled default False;
  end;

  TLMDFormGlass = class(TLMDWndProcComponent)
  private
    FRight: Integer;
    FBottom: Integer;
    FTop: Integer;
    FLeft: Integer;
    procedure SetBottom(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetRight(const Value: Integer);
    procedure SetTop(const Value: Integer);
  protected
    procedure GlassRectChanged;
    procedure GlassPaint;
    procedure WndProc(var Message: TMessage); override;
    procedure SetEnabled(aValue: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About;
    property Enabled;
    property TopMargin: Integer read FTop write SetTop;
    property LeftMargin: Integer read FLeft write SetLeft;
    property BottomMargin: Integer read FBottom write SetBottom;
    property RightMargin: Integer read FRight write SetRight;
  end;

var
  LMDVistaSupportEnable: boolean;

implementation
uses
  LMDClass, LMDUtils;

const
  CVistaFont = 'Segoe UI';

type
  TLMDMainFormHelper = class
  protected
    function HookedWndProc(var Message : TMessage): Boolean;
  end;

var
  LMDMainFormHelper: TLMDMainFormHelper;
  LMDFormVistaCount: integer;

{------------------------------------------------------------------------------}
function TLMDMainFormHelper.HookedWndProc(var Message: TMessage): Boolean;
begin
  Result := False;
  if LMDVistaSupportEnable then
  begin
    if Message.Msg = WM_SYSCOMMAND then
    begin
      case (Message.WParam and $FFF0) of
        SC_RESTORE, SC_MINIMIZE, SC_MAXIMIZE:
        begin
          Message.Result := DefWindowProc(Application.MainForm.Handle, Message.Msg, Message.WParam, Message.LParam);
          Result := True;
        end;
      end;
    end;
  end;
end;

{*********************** Class TLMDFormVistaExtension *************************}
{------------------------- Private --------------------------------------------}
procedure TLMDFormVistaExtension.SetEnabled(const Value: boolean);
begin
  if [csDesigning, csLoading]*ComponentState<>[] then
    begin
      FEnabled:=Value;
      exit;
    end;
  if FEnabled <> Value then
    begin
      FEnabled := Value;// and DWMAvailable;
      if FEnabled then
        Install
      else
        UnInstall;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormVistaExtension.OwnerFormShow(Sender: TObject);
begin
  if Assigned(FOwnerFormShow) then FOwnerFormShow(Sender);
  if not (csDesigning in ComponentState) then
    If Enabled then Install;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDFormVistaExtension.ReadState(Reader: TReader);
begin
  inherited;
  if not LMDSIWindowsVista then exit;
  if not (csDesigning in ComponentState) and Enabled then
    begin
      FOwnerFormShow:=TForm(Owner).OnShow;
      TForm(Owner).OnShow:=OwnerFormShow;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormVistaExtension.Install;
begin
  if LMDSIWindowsVista then
  begin
    LMDVistaSupportEnable := True;
    ShowWindow(Application.Handle, SW_HIDE);
    FAppStyle := GetWindowLong(Application.Handle, GWL_EXSTYLE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE, FAppStyle
                  and not WS_EX_APPWINDOW or WS_EX_TOOLWINDOW);
    FOldTitle := Application.Title;
    Application.Title := '';
    ShowWindow(Application.Handle, SW_SHOW);

    LMDMainFormHelper := TLMDMainFormHelper.Create;
    Application.HookMainWindow(LMDMainFormHelper.HookedWndProc);

    if Assigned(Application.MainForm) and (Application.MainForm.HandleAllocated) then
    begin
      ShowWindow(Application.MainForm.Handle, SW_HIDE);
      FMainFrmStyle := GetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE);
      SetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE, FMainFrmStyle
                    and not WS_EX_TOOLWINDOW or WS_EX_APPWINDOW);
      ShowWindow(Application.MainForm.Handle, SW_SHOW);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormVistaExtension.Uninstall;
begin
  if LMDSIWindowsVista then
  begin
    ShowWindow(Application.Handle, SW_HIDE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE, FAppStyle);
    Application.Title := FOldTitle;
    ShowWindow(Application.Handle, SW_SHOW);

    if Assigned(Application.MainForm) and (Application.MainForm.HandleAllocated) then
    begin
      ShowWindow(Application.MainForm.Handle, SW_HIDE);
      SetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE, FMainFrmStyle);
      ShowWindow(Application.MainForm.Handle, SW_SHOW);
    end;

    Application.UnHookMainWindow(LMDMainFormHelper.HookedWndProc);

    if Assigned(LMDMainFormHelper) then
      FreeAndNil(LMDMainFormHelper);
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDFormVistaExtension.Create(AOwner: TComponent);
begin
  inherited;
  inc(LMDFormVistaCount);
  if LMDFormVistaCount > 1 then
    raise ELMDOneInstError.Create(self.ClassName,1);
end;

{------------------------------------------------------------------------------}
destructor TLMDFormVistaExtension.Destroy;
begin
  dec(LMDFormVistaCount);
  if Enabled then
    Uninstall;
  inherited;
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
procedure TLMDFormVistaExtension.ShowModalChildForm(const AForm: TCustomForm);
var
  LParentForm: TCustomForm;
begin
  if LMDVistaSupportEnable then
  begin
    LParentForm := LMDGetOwnerForm(Self);
    AForm.PopupParent := LParentForm;
    AForm.ShowModal;
  end;
end;
{$endif}

{------------------------------------------------------------------------------}
procedure TLMDFormVistaExtension.FixFonts(const AForm: TCustomForm);
var
  LFontSize: Integer;
  LOldFontName: String;
begin
  if LMDVistaSupportEnable then
  begin
    if AForm.Font.Name <> CVistaFont then
    begin
      LFontSize := AForm.Font.Size + 1;
      LOldFontName := AForm.Font.Name;
      AForm.Font.Name := CVistaFont;
      if AForm.Font.Name <> CVistaFont then
        AForm.Font.Name := LOldFontName
      else
        AForm.Font.Size := LFontSize;
    end;
  end;
end;

{ TLMDFormGlass }

constructor TLMDFormGlass.Create(AOwner: TComponent);
begin
  inherited;
  {$ifndef LMDCOMP11}
  Init;
  {$endif}
end;

procedure TLMDFormGlass.GlassPaint;
var
  LClientRect: TRect;
  LSaveState: Integer;
  LOwner: TForm;
begin
  LOwner := GetOwnerForm;
  LSaveState := SaveDC(LOwner.Canvas.Handle);
  try
    LClientRect := LOwner.ClientRect;
    ExcludeClipRect(LOwner.Canvas.Handle, FLeft, FTop, LClientRect.Right - FRight, LClientRect.Bottom - FBottom);
    FillRect(LOwner.Canvas.Handle, LClientRect, GetStockObject(BLACK_BRUSH));
  finally
    RestoreDC(LOwner.Canvas.Handle, LSaveState);
  end;
end;

procedure TLMDFormGlass.GlassRectChanged;
{$ifndef LMDCOMP11}
var
  LMargins: TMargins;
{$endif}
begin
  {$ifndef LMDCOMP11}
  if GetOwnerForm.HandleAllocated then
  begin
    if (not Enabled) or (not LMDDwmEnabled) then
    begin
      LMargins.cxLeftWidth := 0;
      LMargins.cxRightWidth := 0;
      LMargins.cyTopHeight := 0;
      LMargins.cyBottomHeight := 0;
    end
    else
    begin
      LMargins.cxLeftWidth := FLeft;
      LMargins.cxRightWidth := FRight;
      LMargins.cyTopHeight := FTop;
      LMargins.cyBottomHeight := FBottom;
    end;
    LMDDwmExtendFrameIntoClientArea(GetOwnerHandle, LMargins);
    GetOwnerForm.Invalidate;
  end;
  {$else}
  GetOwnerForm.GlassFrame.Enabled := Enabled;
  with GetOwnerForm.GlassFrame do
  begin
    Top := FTop;
    Bottom := FBottom;
    Left := FLeft;
    Right := FRight;
  end;
  {$endif}
end;

procedure TLMDFormGlass.SetBottom(const Value: Integer);
begin
  FBottom := Value;
  GlassRectChanged;
end;

procedure TLMDFormGlass.SetEnabled(aValue: Boolean);
begin
  inherited;
  GlassRectChanged;
end;

procedure TLMDFormGlass.SetLeft(const Value: Integer);
begin
  FLeft := Value;
  GlassRectChanged;
end;

procedure TLMDFormGlass.SetRight(const Value: Integer);
begin
  FRight := Value;
  GlassRectChanged;
end;

procedure TLMDFormGlass.SetTop(const Value: Integer);
begin
  FTop := Value;
  GlassRectChanged;
end;

procedure TLMDFormGlass.WndProc(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
  WM_PAINT: GlassPaint;
  end;
end;

initialization
  LMDFormVistaCount := 0;

end.
