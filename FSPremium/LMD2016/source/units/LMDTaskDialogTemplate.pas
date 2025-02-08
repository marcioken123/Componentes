unit LMDTaskDialogTemplate;
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

LMDTaskDialogTemplate unit (AH)
------------------------------


Changes
-------
Release 9.1 (June 2009)
 - TaskDialogIndirect incorrect result returning was fixed (BTS #708)

Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  Math, LMDTypes, LMDUnicode, LMDProcs, LMDGraphUtils, Controls, CommCtrl,
  LMDTaskDialog, LMDUnicodeCtrls, LMDStrings;

type
  TLMDTaskCheckBox = TLMDWideCheckbox;
  TLMDTaskRadioButton = TLMDWideRadioButton;
  TLMDTaskButton = TLMDWideButton;
  TLMDTaskLabel = TLMDWideLabel;

  TLMDCommandLinkButton = class(TCustomControl)
  private
    FIsDefault: boolean;
    FIsElevationButton: boolean;
    FModalResult: TModalResult;
    FDefaultHeight: Integer;
    FNote: TLMDString;
    FShowIcon: boolean;
    FCaption: TLMDString;
    FMarginVertical: Integer;
    FMarginHorizontal: Integer;
    FTextRect: TRect;
    procedure SetIsDefault(const Value: boolean);
    procedure SetIsElevationButton(const Value: boolean);
    procedure DrawDefaultBorder;
    procedure DrawHotBorder;
    procedure DrawCaption;
    procedure DrawNote;
    procedure SetNote(const Value: TLMDString);
    procedure SetShowIcon(const Value: boolean);
    procedure SetMarginHorizontal(const Value: Integer);
    procedure SetMarginVertical(const Value: Integer);
  protected
    FCanvas: TCanvas;
    FMouseInControl: Boolean;
    FButtonDown: Boolean;
    FImages: TImageList;
    procedure ReCalcHeight;
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetCaption(const Value: TLMDString); virtual;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Note: TLMDString read FNote write SetNote;
    property IsDefault: boolean read FIsDefault write SetIsDefault;
    property IsElevationButton: boolean read FIsElevationButton write SetIsElevationButton;
    property MarginVertical: Integer read FMarginVertical write SetMarginVertical;
    property MarginHorizontal: Integer read FMarginHorizontal write SetMarginHorizontal;
    property ShowIcon: boolean read FShowIcon write SetShowIcon;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property Caption: TLMDString read FCaption write SetCaption;
    property OnClick;
  end;

  TLMDProgressBar = class(TProgressBar)
  private
    FMarquee: Boolean;
    FMarqueeDelay: Cardinal;
    FMarqueeSpeed: Cardinal;
    procedure SetMarquee(const Value: boolean);
    procedure SetMarqueeSpeed(const Value: Cardinal);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateProgressBar;
  published
    property Marquee: boolean read FMarquee write SetMarquee default False;
    property MarqueeSpeed: Cardinal read FMarqueeSpeed write SetMarqueeSpeed default 60;
  end;

  TLMDCollapseButton = class(TCustomControl)
  private
    FChecked: Boolean;
    FCaptionPadding: Integer;
    FCollapsedText: TLMDString;
    FExpandedText: TLMDString;
    FMouseAbove: Boolean;
    FDown: Boolean;
    FImages: TImageList;
    FCaption: TLMDString;
    FTextWidth: Integer;
    FTextHeight: Integer;
    procedure SetCollapsedText(const Value: TLMDString);
    procedure SetExpandedText(const Value: TLMDString);
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure Toggle;
    procedure SetChecked(Value: Boolean); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Click; override;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    property MouseAbove: Boolean read FMouseAbove;
    property Down: Boolean read FDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcNewSize;
    property Caption: TLMDString read FCaption write SetCaption;
    property CollapsedText: TLMDString read FCollapsedText write SetCollapsedText;
    property ExpandedText: TLMDString read FExpandedText write SetExpandedText;
    property Checked: Boolean read FChecked write SetChecked;
    property OnClick;
  end;

  TLMDCustomTaskDialog = class(TForm)
  private
    FVericalControlPadding: Integer;
    FHorzPadding: integer;
    FCalculatedWidth: Integer;
    FLeftMargin: Integer;
    FShieldBmp: TBitmap;
    FSmallShield: TBitmap;
    function IsSetFlag(AValue: Cardinal): Boolean;
    function IsCommonButtonExists(ACommonButton: Integer): boolean;
    function IsButtonsExists: Boolean;
    function IsRadioButtonsExists: Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FreeListObjects(ATempList: TList);
    procedure SetupVerificationCheckBox;
    procedure SetupCommonButtons(var ALeftPos: Integer);
    procedure SetupButtons(var ALeftPos: Integer);
    function ClickButton(AList: TList; AButtonId: Integer): Boolean;
    function EnableButton(AList: TList; AButtonId: Integer; AEnabled: Boolean): Boolean;
    function GetButtonById(AList: TList; AButtonId: Integer): TControl;
    procedure SetupCollapse;
    procedure SetupFooterContent;
    procedure SetupMainIcon;
    procedure SetupFooterIcon;
    procedure SetupExpandInfo;
    procedure SetupCommandLinks;
    procedure ClearList(LList: TList);
    procedure SetupWindow;
    procedure CorrectButtonsPosition(LOldClientWidth: Integer);
  protected
    FMainInstruction: TLMDTaskLabel;
    FContent: TLMDTaskLabel;
    FExpandText: TLMDTaskLabel;
    FProgressBar: TLMDProgressBar;
    FButtonPanel: TPanel;
    FFooterPanel: TPanel;
    FExpandedInfo: TPanel;
    FFooterText: TLMDTaskLabel;
    FCommonButtons: TList;
    FButtons: TList;
    FRadioButtons: TList;
    FGarbageList: TList;
    FCallbackTimer: TTimer;
    FTimerCount: Cardinal;
    FConfig: TTaskDialogConfig;
    FVerification: TLMDTaskCheckBox;
    FCollapse: TLMDCollapseButton;

    FFooterIcon: TImage;
    FMainIcon: TImage;

    FResultButton: Integer;

    function GetResultRadioButtonId: Integer;
    procedure TriggerShow(Sender: TObject);
    procedure TriggerCreated; virtual;
    procedure TriggerNavigated; virtual;
    procedure TriggerDialogConstructed; virtual;
    procedure TriggerRadionButtonClick(Sender: TObject); virtual;
    procedure TriggerButtonClick(Sender: TObject); virtual;
    procedure TriggerTimer(Sender: TObject); virtual;
    procedure TriggerLinkClick(Sender: TObject; AHref: TLMDString); virtual;
    procedure TriggerExpandArea(Sender: TObject); virtual;

    procedure SetupRadioButtons; virtual;
    procedure SetupProgressBar; virtual;
    procedure SetupContent; virtual;
    procedure SetupMainInstruction; virtual;

    procedure VerticalRealignControls;
    procedure HorizontalRealignControls;

    procedure WndProc(var Message: TMessage); override;
    procedure PrepareTaskDialog;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function TaskDialogIndirect(const ptc: TTaskDialogConfig; var pnButton: Integer;
                           var pnRadioButton: Integer;
                           var pfVerificationFlagChecked: Boolean): HRESULT; stdcall;
function TaskDialog(hwndParent: HWND; hInstance: longword; pszWindowTitle: PWideChar;
                   pszMainInstruction: PWideChar; pszContent: PWideChar; dwCommonButtons: dword;
                   pszIcon: LPWSTR; var pnButton: integer): HRESULT; stdcall;

implementation

uses
  LMDSysIn, LMDUtils, LMDBmp;

{$R *.dfm}

type
  TLMDControlAccess = class(TControl);

const
  PBM_SETMARQUEE = WM_USER + 10;
  PBS_MARQUEE = $08;
  CRoundRadius = 3;

  { TLMDCommandLinkButton }

procedure TLMDCommandLinkButton.Click;
var
  LForm: TCustomForm;
begin
  inherited;
  LForm := GetParentForm(Self);
  if Assigned(LForm) and (FModalResult >= 0) then
    LForm.ModalResult := FModalResult;
end;

procedure TLMDCommandLinkButton.DrawCaption;
var
  LRect: TRect;
begin
  FCanvas.Font.Size := 11;
  if Enabled then
    FCanvas.Font.Color := RGB(21, 28, 145)
  else
    FCanvas.Font.Color := RGB(173, 173, 173);

  if FShowIcon then
    LRect := Rect(FImages.Width + FMarginHorizontal, FMarginVertical, Width, Height)
  else
    LRect := Rect(FMarginHorizontal, FMarginVertical, Width, Height);
  LMDDrawText(FCanvas.Handle, FCaption, Length(FCaption), LRect, DT_CALCRECT or DT_EXPANDTABS or DT_LEFT or DT_VCENTER);
  LMDDrawText(FCanvas.Handle, FCaption, Length(FCaption), LRect, DT_EXPANDTABS or DT_LEFT or DT_VCENTER)
end;

procedure TLMDCommandLinkButton.CMMouseenter(var Message: TMessage);
begin
  FMouseInControl := True;
  invalidate;
end;

procedure TLMDCommandLinkButton.CMMouseleave(var Message: TMessage);
begin
  FMouseInControl := False;
  FButtonDown := False;
  Invalidate;
end;

constructor TLMDCommandLinkButton.Create(AOwner: TComponent);
var
  LBitmap: TBitmap;
begin
  inherited;
  FMarginHorizontal := 10;
  FMarginVertical := 10;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FDefaultHeight := 41;
  Height := FDefaultHeight;

  FImages := TImageList.Create(Self);
  FImages.Width := 16;
  FImages.Height := 16;

  LBitmap := TBitmap.Create;
  try
    LBitmap.LoadFromResourceName(HInstance, 'LMDBMPCL_ARROWS');
    FImages.AddMasked(LBitmap, clNone);
  finally
    LBitmap.Free;
  end;
end;

destructor TLMDCommandLinkButton.Destroy;
begin
  FCanvas.Free;
  FImages.Free;
  inherited;
end;

procedure TLMDCommandLinkButton.DrawHotBorder;
var
  LOldColor: TColor;
begin
  LOldColor := FCanvas.Pen.Color;
  if FButtonDown then
    FCanvas.Pen.Color := RGB(173, 173, 173)
  else
    FCanvas.Pen.Color := RGB(198, 198, 198);
  FCanvas.RoundRect(0, 0, Width, Height, CRoundRadius, CRoundRadius);
  FCanvas.Pen.Color := LOldColor;
end;

procedure TLMDCommandLinkButton.DrawNote;
var
  LRect: TRect;
  LLeft: Integer;
begin
  FCanvas.Font.Size := 7;
  if Enabled then
    FCanvas.Font.Color := clBlue //RGB(21, 28, 145)
  else
    FCanvas.Font.Color := clRed; //RGB(173, 173, 173);

  if FShowIcon then
    LLeft := FImages.Width + FMarginHorizontal + 2
  else
    LLeft := FMarginHorizontal + 2;

  LRect := Rect(LLeft, FMarginVertical + (FTextRect.Bottom - FTextRect.Top), Width, Height);
  LMDDrawText(Canvas.Handle, FNote, Length(FNote), LRect, DT_LEFT or DT_VCENTER or DT_EXPANDTABS or
               DT_WORDBREAK);
end;

procedure TLMDCommandLinkButton.DrawDefaultBorder;
var
  LOldColor: TColor;
begin
  LOldColor := FCanvas.Pen.Color;
  FCanvas.Pen.Color := RGB(151, 234, 255);
  FCanvas.RoundRect(0, 0, Width, Height, CRoundRadius, CRoundRadius);
  FCanvas.Pen.Color := LOldColor;
end;

procedure TLMDCommandLinkButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button in [mbLeft] then
  begin
    FButtonDown := True;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button in [mbLeft] then
  begin
    FButtonDown := False;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.Paint;
var
  LIconToDraw: Integer;
begin
  if FIsElevationButton then
    LIconToDraw := 3
  else
  begin
    if FMouseInControl and not (FButtonDown) then
      LIconToDraw := 1
    else if Enabled then
      LIconToDraw := 0
    else
      LIconToDraw := 2;
  end;

  if FIsDefault then
    DrawDefaultBorder;

  if FMouseInControl then
    DrawHotBorder;

  if FShowIcon then
    FImages.Draw(FCanvas, 5, FMarginVertical + ((FTextRect.Bottom - FImages.Height) div 2), LIconToDraw);

  DrawCaption;
  DrawNote;
end;

procedure TLMDCommandLinkButton.RecalcHeight;
var
  LRect: TRect;
  LHeight: Integer;
begin
  FCanvas.Font.Size := 11;
  FTextRect := Rect(0, 0, 0, 0);
  LMDDrawText(FCanvas.Handle, FCaption, Length(FCaption), FTextRect,
               DT_CALCRECT or DT_EXPANDTABS or DT_LEFT or DT_VCENTER);
  LHeight := FTextRect.Bottom - FTextRect.Top;

  FCanvas.Font.Size := 7;
  LRect := Rect(0, 0, 0, 0);
  LMDDrawText(FCanvas.Handle, FNote, Length(FNote), LRect,
               DT_CALCRECT or DT_EXPANDTABS or DT_LEFT or DT_VCENTER);

  LHeight := LHeight + (LRect.Bottom - LRect.Top);
  LHeight := LHeight + FMarginVertical * 2;
  Height := Max(LHeight, FDefaultHeight);
end;

procedure TLMDCommandLinkButton.SetCaption(const Value: TLMDString);
begin
  FCaption := Value;
  RecalcHeight;
end;

procedure TLMDCommandLinkButton.SetIsDefault(const Value: boolean);
var
  LForm: TCustomForm;
begin
  if FIsDefault <> Value then
  begin
    LForm := GetParentForm(Parent);
    if Assigned(LForm) then
    begin
      LForm.ActiveControl := Self;
      LForm.Perform(CM_FOCUSCHANGED, 0, LPARAM(LForm.ActiveControl));
      end;

    FIsDefault := Value;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.SetIsElevationButton(const Value: boolean);
begin
  if FIsElevationButton <> Value then
  begin
    FIsElevationButton := Value;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.SetMarginHorizontal(const Value: Integer);
begin
  if FMarginHorizontal <> Value then
  begin
    FMarginHorizontal := Value;
    RecalcHeight;
  end;
end;

procedure TLMDCommandLinkButton.SetMarginVertical(const Value: Integer);
begin
  if FMarginVertical = Value then
  begin
    FMarginVertical := Value;
    RecalcHeight;
  end;
end;

procedure TLMDCommandLinkButton.SetShowIcon(const Value: boolean);
begin
  if FShowIcon <> Value then
  begin
    FShowIcon := Value;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.SetNote(const Value: TLMDString);
var
  LRect: TRect;
begin
  if FNote <> Value then
  begin
    FNote := Value;
    LRect := Rect(0, 0, Width, Height);
    LMDDrawText(FCanvas.Handle, FNote, Length(FNote), LRect, DT_CALCRECT or DT_WORDBREAK);
    RecalcHeight;
    Invalidate;
  end;
end;

procedure TLMDCommandLinkButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  FCanvas.Brush.Color := clWindow;
  FCanvas.FillRect(ClientRect);
  Message.Result := 1;
end;

procedure TLMDCommandLinkButton.CMDialogChar(var Message: TCMDialogChar);
begin
  Click;
end;

{ TLMDProgressBar }

constructor TLMDProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  FMarquee := False;
  FMarqueeDelay := 60;
end;

procedure TLMDProgressBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.Style := Params.Style or PBS_MARQUEE;
end;

procedure TLMDProgressBar.SetMarquee(const Value: boolean);
begin
  if FMarquee <> Value then
  begin
    FMarquee := Value;
    if Value then
      SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or PBS_MARQUEE)
    else
      SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not PBS_MARQUEE);
    UpdateProgressBar;
  end;
end;

procedure TLMDProgressBar.SetMarqueeSpeed(const Value: Cardinal);
begin
  if FMarqueeSpeed <> Value then
  begin
    FMarqueeSpeed := Value;
    UpdateProgressBar;
  end;
end;

procedure TLMDProgressBar.UpdateProgressBar;
begin
  if Handle <> 0 then
    SendMessage(Handle, PBM_SETMARQUEE, WParam(FMarquee), FMarqueeSpeed);
end;

{ TLMDCollapseButton }

procedure TLMDCollapseButton.CalcNewSize;
var
  LRect: TRect;
begin
  LRect := Rect(0, 0, 0, 0);
  LMDDrawText(Canvas.Handle, FCaption, Length(FCaption), LRect, DT_CALCRECT);
  FTextWidth := (LRect.Right - LRect.Left);
  Width := FImages.Width + FCaptionPadding + FTextWidth;
  FTextHeight := (LRect.Bottom - LRect.Top);
  Height := Max(FImages.Height, FTextHeight);
end;

procedure TLMDCollapseButton.Click;
begin
  Toggle;
  inherited;
end;

procedure TLMDCollapseButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseAbove := True;
  Repaint;
end;

procedure TLMDCollapseButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseAbove := False;
  Repaint;
end;

procedure TLMDCollapseButton.CMTextchanged(var Message: TMessage);
begin
  CalcNewSize;
end;

constructor TLMDCollapseButton.Create(AOwner: TComponent);
var
  LBitmap: TBitmap;
begin
  inherited;
  ControlState := ControlState + [csCustomPaint];

  Height := 19;
  FCaptionPadding := 5;

  FImages := TImageList.Create(Self);
  FImages.Width := 19;
  FImages.Height := 19;

  LBitmap := TBitmap.Create;
  try
    LBitmap.LoadFromResourceName(HInstance, 'LMDBMPCOL_BUTTON');
    FImages.AddMasked(LBitmap, clNone);
  finally
    LBitmap.Free;
  end;
end;

destructor TLMDCollapseButton.Destroy;
begin
  FImages.Clear;
  FImages.Free;
  inherited;
end;

procedure TLMDCollapseButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := True;
  Repaint;
end;

procedure TLMDCollapseButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := False;
  Repaint;
end;

procedure TLMDCollapseButton.Paint;
var
  LIconDraw: Integer;
  LRect: TRect;
begin
  if MouseAbove and (not Down) then
    LIconDraw := 4
  else if Down then
    LIconDraw := 5
  else
    LIconDraw := 3;
  if Checked then
    Dec(LIconDraw, 3);

  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Self.Color;
  Canvas.FillRect(ClientRect);

  FImages.Draw(Canvas, 0, (Height - FImages.Height) div 2, LIconDraw);
  LRect := ClientRect;
  LRect.Left := LRect.Left + FImages.Width + FCaptionPadding;
  LRect.Top := (Height - FTextHeight) div 2;
  LMDDrawText(Canvas.Handle, FCaption, Length(FCaption), LRect, DT_LEFT or DT_TOP);
end;

procedure TLMDCollapseButton.PaintWindow(DC: HDC);
begin
  Canvas.Lock;
  try
    Canvas.Handle := DC;
    try
      TControlCanvas(Canvas).UpdateTextFlags;
      Paint;
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
end;

procedure TLMDCollapseButton.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    CalcNewSize;
    Repaint;
  end;
end;

procedure TLMDCollapseButton.SetChecked(Value: Boolean);
begin
  FChecked := Value;
  if Checked  then
    Caption := ExpandedText
  else
    Caption := CollapsedText;
  Repaint;
end;

procedure TLMDCollapseButton.SetCollapsedText(const Value: TLMDString);
begin
  FCollapsedText := Value;
  Invalidate;
end;

procedure TLMDCollapseButton.SetExpandedText(const Value: TLMDString);
begin
  FExpandedText := Value;
  Invalidate;
end;

procedure TLMDCollapseButton.Toggle;
begin
  FChecked := not FChecked;
  if Checked  then
    Caption := ExpandedText
  else
    Caption := CollapsedText;
end;

function TaskDialogIndirect(const ptc: TTaskDialogConfig; var pnButton: Integer;
                            var pnRadioButton: Integer; var pfVerificationFlagChecked: Boolean): HRESULT; stdcall;

var
  LTaskDialog: TLMDCustomTaskDialog;
  lCtrl: TControl;
begin
  if ptc.hwndParent <> 0 then
  begin
    lCtrl := FindControl(ptc.hwndParent);
    if lCtrl is TCustomForm then
      LTaskDialog := TLMDCustomTaskDialog.Create(lCtrl)
    else
      LTaskDialog := TLMDCustomTaskDialog.Create(nil);
  end
  else
  LTaskDialog := TLMDCustomTaskDialog.Create(nil);
  try
    try
      Result := S_OK;
      LTaskDialog.FConfig := ptc;
      LTaskDialog.PrepareTaskDialog;
      // To start timer
      LTaskDialog.FTimerCount := GetTickCount;
      if (Screen.ActiveForm <> nil) and
         (Screen.ActiveForm.FormStyle = fsStayOnTop) then
        LTaskDialog.FormStyle := fsStayOnTop;
      if Assigned(GOnCustomizationEvent) then
        GOnCustomizationEvent(LTaskDialog, LTaskDialog);
      LTaskDialog.ShowModal;
      pfVerificationFlagChecked := LTaskDialog.FVerification.Checked;
      pnButton := LTaskDialog.FResultButton;
      pnRadioButton := LTaskDialog.GetResultRadioButtonId;
    except
      Result := E_OUTOFMEMORY;
    end;
  finally
    LTaskDialog.Free;
  end;
end;

function TaskDialog(hwndParent: HWND; hInstance: longword; pszWindowTitle: PWideChar;
                   pszMainInstruction: PWideChar; pszContent: PWideChar; dwCommonButtons: dword;
                   pszIcon: LPWSTR; var pnButton: integer): HRESULT; stdcall;

var
  LConfig: TTaskDialogConfig;
  LRadioButton: Integer;
  LVerification: Boolean;
begin
  ZeroMemory(@LConfig, SizeOf(LConfig));
  LConfig.cbSize := SizeOf(LConfig);
  LConfig.hInstance := hInstance;
  LConfig.hwndParent := hwndParent;
  LConfig.pszWindowTitle := pszWindowTitle;
  LConfig.pszMainInstruction := pszMainInstruction;
  LConfig.pszContent := pszContent;
  LConfig.dwCommonButtons := dwCommonButtons;
  LConfig.pszMainIcon := pszIcon;
  Result := TaskDialogIndirect(LConfig, pnButton, LRadioButton, LVerification);
end;

procedure TLMDCustomTaskDialog.Paint;
begin
  inherited;
  Canvas.Pen.Color := RGB(140, 140, 140);
  Canvas.Rectangle(ClientRect);
end;

procedure TLMDCustomTaskDialog.PrepareTaskDialog;
var
  LLeftPos: Integer;
  LOldClientWidth: Integer;
begin
  TriggerDialogConstructed;

  SetupWindow;

  LLeftPos := ClientWidth;
  LOldClientWidth := ClientWidth;
  SetupCommonButtons(LLeftPos);
  if IsButtonsExists and (not IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON))then
    SetupButtons(LLeftPos);

  if Assigned(FConfig.pszExpandedInformation) and Assigned(FConfig.pszVerificationText) then
    if Max(FCollapse.BoundsRect.Right, FVerification.BoundsRect.Right) > LLeftPos then
      ClientWidth := ClientWidth + abs(LLeftPos - Max(FCollapse.BoundsRect.Right, FVerification.BoundsRect.Right));

  if LLeftPos < 0 then
    ClientWidth := ClientWidth + (abs(LLeftPos) + FHorzPadding);

  CorrectButtonsPosition(LOldClientWidth);

  // Setup main ocpn to calculate width
  SetupMainIcon;

  if IsButtonsExists and IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
    SetupCommandLinks;

  SetupCollapse;
  SetupVerificationCheckBox;
  SetupRadioButtons;

  SetupFooterIcon;

  HorizontalRealignControls;

  SetupMainInstruction;
  SetupContent;
  SetupProgressBar;

  FFooterPanel.Visible := Assigned(FConfig.pszFooter);

  SetupFooterContent;
  SetupExpandInfo;

  FCallbackTimer.Enabled := IsSetFlag(TDF_CALLBACK_TIMER);

  VerticalRealignControls;

  TriggerCreated;
end;

constructor TLMDCustomTaskDialog.Create(AOwner: TComponent);
begin
  inherited;
  FVericalControlPadding := 13;
  FHorzPadding := 10;
  FLeftMargin := FHorzPadding;

  OnKeyUp := FormKeyDown;

  FShieldBmp := TBitmap.Create;

  FShieldBmp.LoadFromResourceName(HInstance, 'LMDBMPSHIELD_BIG');
  FSmallShield := TBitmap.Create;
  FSmallShield.LoadFromResourceName(HInstance, 'LMDBMPSHIELD_SMALL');
  FMainIcon := TImage.Create(Self);
  FMainIcon.Parent := Self;
  FMainIcon.Visible := False;
  FMainIcon.AutoSize := True;

  FProgressBar := TLMDProgressBar.Create(Self);
  FProgressBar.Parent := Self;
  FProgressBar.Visible := False;

  OnActivate := TriggerShow;

  FMainInstruction := TLMDTaskLabel.Create(Self);
  FMainInstruction.Parent := Self;
  FMainInstruction.WordWrap := True;
  FMainInstruction.AutoSize := True;
  FMainInstruction.IsHTML := True;
  FMainInstruction.OnLinkClick := TriggerLinkClick;
  FMainInstruction.Font.Size := 11;
  FMainInstruction.Font.Color := {$IFNDEF LMDCOMP7}TColor($FF000000 or COLOR_HOTLIGHT){$ELSE}clHotLight{$ENDIF};

  FContent := TLMDTaskLabel.Create(Self);
  FContent.Parent := Self;
  FContent.IsHTML := True;
  FContent.OnLinkClick := TriggerLinkClick;
  FContent.WordWrap := True;
  FContent.AutoSize := True;

  FButtonPanel := TPanel.Create(Self);
  FButtonPanel.Parent := Self;
  FButtonPanel.BorderStyle := bsNone;
  {$ifdef LMDCOMP9}
  FButtonPanel.BevelKind := bkFlat;
  FButtonPanel.BevelEdges := [beTop];
  {$endif}
  FButtonPanel.Parent := Self;
  FButtonPanel.Color := RGB(240, 240, 240);
  FButtonPanel.BevelOuter := bvNone;
  {$IFDEF LMDCOMP7}
  FButtonPanel.ParentBackground := False;
  {$ENDIF}

  FVerification := TLMDTaskCheckBox.Create(Self);
  FVerification.Parent := FButtonPanel;
  //FVerification.CtlXp := true;

  FCollapse := TLMDCollapseButton.Create(Self);
  FCollapse.Parent := FButtonPanel;
  FCollapse.Checked := IsSetFlag(TDF_EXPANDED_BY_DEFAULT);
  FCollapse.OnClick := TriggerExpandArea;

  FFooterPanel := TPanel.Create(Self);
  FFooterPanel.Parent := Self;
  {$ifdef LMDCOMP9}
  FFooterPanel.BevelKind := bkFlat;
  FFooterPanel.BevelEdges := [beTop];
  {$endif}
  FFooterPanel.Color := RGB(240, 240, 240);
  FFooterPanel.BevelOuter := bvNone;
  {$ifdef LMDCOMP7}
  FFooterPanel.ParentBackground := False;
  {$endif}

  FFooterText := TLMDTaskLabel.Create(Self);
  FFooterText.Parent := FFooterPanel;
  FFooterText.IsHTML := True;
  FFooterText.OnLinkClick := TriggerLinkClick;
  FFooterText.WordWrap := True;

  FFooterIcon := TImage.Create(Self);
  FFooterIcon.Parent := FFooterPanel;
  FFooterIcon.Visible := False;
  FFooterIcon.Width := 16;
  FFooterIcon.Height := 16;

  FExpandedInfo := TPanel.Create(Self);
  FExpandedInfo.Parent := Self;
  {$ifdef LMDCOMP9}
  FExpandedInfo.BevelKind := bkFlat;
  FExpandedInfo.BevelEdges := [beTop];
  {$endif}
  FExpandedInfo.Color := RGB(240, 240, 240);
  FExpandedInfo.BevelOuter := bvNone;
  {$ifdef LMDCOMP7}
  FExpandedInfo.ParentBackground := False;
  {$endif}
  FExpandedInfo.Visible := False;

  FExpandText := TLMDTaskLabel.Create(Self);
  FExpandText.IsHTML := True;
  FExpandText.WordWrap := True;
  FExpandText.OnLinkClick := TriggerLinkClick;

  FCallbackTimer := TTimer.Create(Self);
  FCallbackTimer.Enabled := False;
  FCallbackTimer.Interval := 1; // 1ms
  FCallbackTimer.OnTimer := TriggerTimer;
  FTimerCount := 0;

  FButtons := TList.Create;
  FCommonButtons := TList.Create;
  FRadioButtons := TList.Create;
  FGarbageList := TList.Create;
end;

destructor TLMDCustomTaskDialog.Destroy;
begin
  try
    FreeListObjects(FRadioButtons);
    FreeListObjects(FGarbageList);
    FreeListObjects(FButtons);
    FreeListObjects(FCommonButtons);
  finally
    FRadioButtons.Free;
    FButtons.Free;
    FCommonButtons.Free;
    FGarbageList.Free;
  end;

  FShieldBmp.Free;
  FSmallShield.Free;
  FFooterIcon.Free;
  FMainIcon.Free;
  FVerification.Free;
  FCollapse.Free;
  FMainInstruction.Free;
  FProgressBar.Free;
  FButtonPanel.Free;
  FFooterPanel.Free;
  FExpandText.Free;
  FExpandedInfo.Free;
  inherited;
end;

procedure TLMDCustomTaskDialog.CorrectButtonsPosition(LOldClientWidth: Integer);
var
  i: Integer;
begin
  if LOldClientWidth <> ClientWidth then
  begin
    for i := 0 to FCommonButtons.Count - 1 do
    begin
      TControl(FCommonButtons.Items[i]).Left := TControl(FCommonButtons.Items[i]).Left + abs(ClientWidth - LOldClientWidth);
    end;
    if IsButtonsExists and (not IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON)) then
      for i := 0 to FButtons.Count - 1 do
      begin
        TControl(FButtons.Items[i]).Left := TControl(FButtons.Items[i]).Left + abs(ClientWidth - LOldClientWidth);
      end;
  end;
end;

procedure TLMDCustomTaskDialog.SetupWindow;
begin
  if IsSetFlag(TDF_ALLOW_DIALOG_CANCELLATION) then
    BorderIcons := BorderIcons + [biSystemMenu];
  if IsSetFlag(TDF_CAN_BE_MINIMIZED) then
    BorderIcons := BorderIcons + [biMinimize];

  if IsSetFlag(TDF_POSITION_RELATIVE_TO_WINDOW) and (FConfig.hwndParent <> 0)then
    Position := poOwnerFormCenter
  else
    Position := poScreenCenter;

  // Set window's title
  if FConfig.pszWindowTitle <> '' then
    Caption := FConfig.pszWindowTitle
  else
    Caption := ExtractFileName(Application.ExeName);
  if FConfig.cxWidth > 0 then
    Width := FConfig.cxWidth;
end;

procedure TLMDCustomTaskDialog.ClearList(LList: TList);
var
  k: Integer;
begin
  for k := 0 to LList.Count - 1 do
  begin
    if (TObject(LList.Items[k]) is TControl) then
      TControl(LList.Items[k]).Visible := False;
    FGarbageList.Add(LList.Items[k]);
  end;
  LList.Clear;
end;

procedure TLMDCustomTaskDialog.SetupCommandLinks;
var
  i: Integer;
  LCommandLink: TLMDCommandLinkButton;
  LStr: TLMDString;
begin
  if IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
  begin
    FreeListObjects(FButtons);
    for i := 0 to FConfig.cButtons - 1 do
    begin
      LCommandLink := TLMDCommandLinkButton.Create(Self);
      LCommandLink.Parent := Self;
      LStr := FConfig.pButtons[i].pszButtonText;
      LCommandLink.Tag := FConfig.pButtons[i].nButtonId;
      if Pos(LMDLF, LStr) > 0 then
      begin
      LCommandLink.Caption := Copy(LStr, 1, Pos(LMDLF, LStr) - 1);
      LCommandLink.Note := Copy(LStr, Pos(LMDLF, LStr) + 1, Length(LStr));
      end
      else
      begin
        LCommandLink.Caption := LStr;
        LCommandLink.Note := '';
      end;
      LCommandLink.ShowIcon := not IsSetFlag(TDF_USE_COMMAND_LINKS_NO_ICON);
      LCommandLink.ModalResult := mrNone;
      LCommandLink.OnClick := TriggerButtonClick;
      if FConfig.pButtons[i].nButtonId = FConfig.nDefaultButton then
        LCommandLink.IsDefault := True;
      FButtons.Add(LCommandLink);
    end;
  end;
end;

procedure TLMDCustomTaskDialog.SetupExpandInfo;
begin
  FExpandText.Width := FExpandedInfo.ClientWidth - FHorzPadding * 2;
  if IsSetFlag(TDF_EXPAND_FOOTER_AREA) then
  begin
    FExpandText.Parent := FExpandedInfo;
    FExpandText.Left := FHorzPadding;
    FExpandedInfo.Visible := IsSetFlag(TDF_EXPANDED_BY_DEFAULT) or FCollapse.Checked;
  end
  else
  begin
    FExpandText.Parent := Self;
    FExpandText.Visible := IsSetFlag(TDF_EXPANDED_BY_DEFAULT) or FCollapse.Checked;
    FExpandedInfo.Visible := False;
  end;
  FExpandText.Caption := FConfig.pszExpandedInformation;
end;

procedure TLMDCustomTaskDialog.SetupFooterIcon;
var
  LIconHandle: THandle;
  LIconName: PWideChar;
  LIconSize: Integer;
begin
  LIconSize := LMDSIDPIAwareSmallIconSize();
  if IsSetFlag(TDF_USE_HICON_FOOTER) then
  begin
    LIconHandle := FConfig.hFooterIcon;
    if LIconHandle <> 0 then
    begin
      FFooterIcon.Picture.Icon.Handle := CopyImage(LIconHandle, IMAGE_ICON, LIconSize, LIconSize, LR_SHARED);
      FFooterIcon.Visible := True;
    end
    else
      FFooterIcon.Visible := False;
  end
  else
  begin
    LIconName := FConfig.pszFooterIcon;
    if not ((LIconName = MAKEINTRESOURCEW(TD_ICON_BLANK)) or (LIconName = MAKEINTRESOURCEW(TD_ICON_BLANK_AGAIN)))
       and (Assigned(LIconName))
       then
    begin
      if LIconName = MAKEINTRESOURCEW(TD_ICON_WARNING) then
        FFooterIcon.Picture.Icon.Handle := LoadImage(GetModuleHandle('user32'), MAKEINTRESOURCE(101), IMAGE_ICON, LIconSize, LIconSize, LR_DEFAULTCOLOR);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_QUESTION) then
        FFooterIcon.Picture.Icon.Handle := LoadImage(GetModuleHandle('user32'), MAKEINTRESOURCE(102), IMAGE_ICON, LIconSize, LIconSize, LR_DEFAULTCOLOR);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_ERROR) then
        FFooterIcon.Picture.Icon.Handle := LoadImage(GetModuleHandle('user32'), MAKEINTRESOURCE(103), IMAGE_ICON, LIconSize, LIconSize, LR_DEFAULTCOLOR);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_INFORMATION) then
        FFooterIcon.Picture.Icon.Handle := LoadImage(GetModuleHandle('user32'), MAKEINTRESOURCE(104), IMAGE_ICON, LIconSize, LIconSize, LR_DEFAULTCOLOR);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_SHIELD) then
      begin
        FFooterIcon.Picture.Bitmap := FSmallShield;
        FFooterIcon.Transparent := True;
      end;
      FFooterIcon.Visible := True;
    end
    else
      FFooterIcon.Visible := False;
  end;
end;

procedure TLMDCustomTaskDialog.SetupMainIcon;
var
  LIconHandle: THandle;
  LIconName: PWideChar;
  LIconSize: Integer;
begin
  LIconSize := LMDSIDPIAwareIconSize();
  if IsSetFlag(TDF_USE_HICON_MAIN) then
  begin
    LIconHandle := FConfig.hMainIcon;
    if (LIconHandle <> 0) then
    begin
      FMainIcon.Picture.Icon.Handle := CopyImage(LIconHandle, IMAGE_ICON, LIconSize, LIconSize, LR_SHARED);
      FMainIcon.Visible := True;
    end
    else
      FMainIcon.Visible := False;
  end
  else
  begin
    LIconName := FConfig.pszMainIcon;
    if not ((LIconName = MAKEINTRESOURCEW(TD_ICON_BLANK)) or (LIconName = MAKEINTRESOURCEW(TD_ICON_BLANK_AGAIN)))
       and (Assigned(LIconName))
       then
    begin
      if LIconName = MAKEINTRESOURCEW(TD_ICON_WARNING) then
        FMainIcon.Picture.Icon.Handle := CopyImage(LoadIcon(0, IDI_WARNING), IMAGE_ICON, LIconSize, LIconSize, LR_COPYDELETEORG);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_QUESTION) then
        FMainIcon.Picture.Icon.Handle := CopyImage(LoadIcon(0, IDI_QUESTION), IMAGE_ICON, LIconSize, LIconSize, LR_COPYDELETEORG);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_ERROR) then
        FMainIcon.Picture.Icon.Handle := CopyImage(LoadIcon(0, IDI_ERROR), IMAGE_ICON, LIconSize, LIconSize, LR_COPYDELETEORG);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_INFORMATION) then
        FMainIcon.Picture.Icon.Handle := CopyImage(LoadIcon(0, IDI_INFORMATION), IMAGE_ICON, LIconSize, LIconSize, LR_COPYDELETEORG);
      if LIconName = MAKEINTRESOURCEW(TD_ICON_SHIELD) then
      begin
        FMainIcon.Picture.Bitmap := FShieldBmp;
        FMainIcon.Transparent := True;
      end;
      FMainIcon.Visible := True;
    end
    else
      FMainIcon.Visible := False;
  end;
end;

procedure TLMDCustomTaskDialog.SetupFooterContent;
var
  LStr: TLMDString;
begin
  LStr := LMDReplaceStr(FConfig.pszFooter, LMDCRLF, '<br>');
  LStr := LMDReplaceStr(LStr, LMDCR, '<br>');
  FFooterText.Caption := LStr;
  FFooterIcon.Left := FHorzPadding;
end;

procedure TLMDCustomTaskDialog.SetupCollapse;
begin
  FCollapse.Visible := Assigned(FConfig.pszExpandedInformation);
  FCollapse.CollapsedText := FConfig.pszCollapsedControlText;
  if not Assigned(FConfig.pszCollapsedControlText) then
    FCollapse.CollapsedText := 'See details';
  FCollapse.ExpandedText := FConfig.pszExpandedControlText;
  if not Assigned(FConfig.pszExpandedControlText) then
    FCollapse.ExpandedText := 'Hide details';
  FCollapse.Checked := IsSetFlag(TDF_EXPANDED_BY_DEFAULT);
  FCollapse.Left := FHorzPadding;
end;

function TLMDCustomTaskDialog.GetButtonById(AList: TList; AButtonId: Integer): TControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AList.Count - 1 do
  begin
    if TControl(AList.Items[i]).Tag = AButtonId then
      Result := TControl(AList.Items[i]);
  end;
end;

function TLMDCustomTaskDialog.GetResultRadioButtonId: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FRadioButtons.Count - 1 do
  begin
    if TLMDTaskRadioButton(FRadioButtons.Items[i]).Checked then
    begin
      Result := i;
      exit;
    end;
  end;
end;

procedure TLMDCustomTaskDialog.HorizontalRealignControls;
var
  i: Integer;
begin
  if FMainIcon.Visible then
  begin
    FMainIcon.Left := FHorzPadding;
    FCalculatedWidth := ClientWidth - (FHorzPadding * 2 + FMainIcon.Width);
    if FLeftMargin < FMainIcon.Width then
      Inc(FLeftMargin, FMainIcon.Width);
  end
  else
  begin
    FCalculatedWidth := ClientWidth - (FHorzPadding * 2);
    FLeftMargin := FHorzPadding;
  end;

  FMainInstruction.Left := FLeftMargin + FHorzPadding;
  FMainInstruction.Width := FCalculatedWidth - FHorzPadding;

  FContent.Left := FLeftMargin + FHorzPadding;
  FContent.Width := FCalculatedWidth - FHorzPadding;

  if not IsSetFlag(TDF_EXPAND_FOOTER_AREA) then
  begin
    FExpandText.Left := FLeftMargin + FHorzPadding;
    FExpandText.Width := FCalculatedWidth - FHorzPadding;
  end;

  FProgressBar.Width := FCalculatedWidth - FHorzPadding;
  FProgressBar.Left := FLeftMargin + FHorzPadding;

  for i := 0 to FRadioButtons.Count - 1 do
  begin
    TLMDTaskRadioButton(FRadioButtons.Items[i]).Left := FLeftMargin + FHorzPadding + 8;
    TLMDTaskRadioButton(FRadioButtons.Items[i]).Width := FCalculatedWidth - FHorzPadding;
  end;

  if IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
  begin
    for i := 0 to FButtons.Count - 1 do
    begin
      TLMDCommandLinkButton(FButtons.Items[i]).Left := FLeftMargin + FHorzPadding;
      TLMDCommandLinkButton(FButtons.Items[i]).Width := FCalculatedWidth - FHorzPadding;
    end;
  end;

  FButtonPanel.Left := 1;
  FButtonPanel.Width := ClientWidth - 2;
  FFooterPanel.Left := 1;
  FFooterPanel.Width := ClientWidth - 2;
  FExpandedInfo.Left := 1;
  FExpandedInfo.Width := ClientWidth - 2;

  FFooterText.Width := FFooterPanel.ClientWidth - (FHorzPadding * 2);
  FFooterIcon.Left := FHorzPadding;
  if FFooterIcon.Visible then
  begin
    FFooterText.Left := FHorzPadding + FFooterIcon.Width + FHorzPadding;
    FFooterText.Width := FFooterText.Width - (FFooterIcon.Width + FHorzPadding);
  end
  else
    FFooterText.Left := FHorzPadding;
end;

function TLMDCustomTaskDialog.ClickButton(AList: TList; AButtonId: Integer): Boolean;
var
  LButton: TControl;
begin
  Result := False;
  LButton := GetButtonById(AList, AButtonId);
  if Assigned(LButton) then
  begin
    Result := False;
    TLMDControlAccess(LButton).Click;
    end;
end;

function TLMDCustomTaskDialog.EnableButton(AList: TList; AButtonId: Integer; AEnabled: Boolean): Boolean;
var
  LButton: TControl;
begin
  Result := False;
  LButton := GetButtonById(AList, AButtonId);
  if Assigned(LButton) then
  begin
    Result := False;
    LButton.Enabled := AEnabled;
  end;
end;

function TLMDCustomTaskDialog.IsRadioButtonsExists: Boolean;
begin
  Result := (FConfig.cRadioButtons > 0) and (Assigned(FConfig.pRadioButtons));
end;

function TLMDCustomTaskDialog.IsButtonsExists: Boolean;
begin
  Result := (FConfig.cButtons > 0) and (Assigned(FConfig.pButtons));
end;

procedure TLMDCustomTaskDialog.SetupButtons(var ALeftPos: Integer);
var
  LButton: TControl;
  i: Integer;
begin
  if not IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
  begin
    FreeListObjects(FButtons);
    for i := FConfig.cButtons - 1 downto 0 do
    begin
      LButton := TLMDTaskButton.Create(Self);
      dec(ALeftPos, (LButton.Width + 5));
      with (LButton as TLMDTaskButton) do
      begin
        Parent := FButtonPanel;
        Left := ALeftPos;
        Caption := FConfig.pButtons[i].pszButtonText;
        Tag := FConfig.pButtons[i].nButtonId;
        ModalResult := mrNone;
        if FConfig.pButtons[i].nButtonId = FConfig.nDefaultButton then
          Default := True;
        OnClick := TriggerButtonClick;
      end;
      FButtons.Add(LButton);
    end;
  end;
end;

procedure TLMDCustomTaskDialog.SetupCommonButtons(var ALeftPos: Integer);
var
  LCommonButton: TLMDTaskButton;
  j: Integer;
  i: Integer;
begin
  i := 1;
  j := 5;
  FreeListObjects(FCommonButtons);
  while i >= TDCBF_OK_BUTTON do
  begin
    i := 1 shl j;
    dec(j);
    if IsCommonButtonExists(i) then
    begin
      LCommonButton := TLMDTaskButton.Create(Self);
      LCommonButton.Parent := FButtonPanel;
      //LCommonButton.CtlXP := true;
      LCommonButton.ModalResult := -1;
      LCommonButton.OnClick := TriggerButtonClick;
      LCommonButton.Tag := i;
      case i of
        TDCBF_OK_BUTTON:
        begin
          LCommonButton.Caption := 'OK';
          LCommonButton.Tag := mrOk;
          LCommonButton.ModalResult := mrNone;
        end;
        TDCBF_YES_BUTTON:
        begin
          LCommonButton.Caption := '&Yes';
          LCommonButton.Tag := mrYes;
          LCommonButton.ModalResult := mrNone;
        end;
        TDCBF_NO_BUTTON:
        begin
          LCommonButton.Caption := '&No';
          LCommonButton.Tag := mrNo;
          LCommonButton.ModalResult := mrNone;
        end;
        TDCBF_CANCEL_BUTTON:
          begin
            LCommonButton.Caption := 'Cancel';
            LCommonButton.Cancel := True;
            LCommonButton.Tag := mrCancel;
            LCommonButton.ModalResult := mrNone;
          end;
        TDCBF_RETRY_BUTTON:
        begin
          LCommonButton.Caption := '&Retry';
          LCommonButton.Tag := mrRetry;
          LCommonButton.ModalResult := mrNone;
        end;
        TDCBF_CLOSE_BUTTON:
        begin
          LCommonButton.Caption := 'Close';
          LCommonButton.Tag := mrAbort;
          LCommonButton.ModalResult := mrNone;
        end;
      end;
      dec(ALeftPos, (LCommonButton.Width + 5));
      LCommonButton.Left := ALeftPos;
      FCommonButtons.Add(LCommonButton);
    end;
  end;
end;

procedure TLMDCustomTaskDialog.SetupVerificationCheckBox;
begin
  FVerification.Visible := Assigned(FConfig.pszVerificationText);
  FVerification.Checked := IsSetFlag(TDF_VERIFICATION_FLAG_CHECKED);
  FVerification.Left := FHorzPadding + 2;
  FVerification.Caption := FConfig.pszVerificationText;
  // TODO: Change this
  FVerification.Width := FVerification.Width + 100;
end;

function TLMDCustomTaskDialog.IsCommonButtonExists(ACommonButton: Integer): boolean;
begin
  Result := (FConfig.dwCommonButtons and not ACommonButton) <> FConfig.dwCommonButtons;
end;

procedure TLMDCustomTaskDialog.FreeListObjects(ATempList: TList);
var
  i: Integer;
begin
  for i := 0 to ATempList.Count - 1 do
    TObject(ATempList.Items[i]).Free;
  ATempList.Clear;
end;

procedure TLMDCustomTaskDialog.SetupMainInstruction;
var
  LStr: TLMDString;
begin
  LStr := LMDReplaceStr(FConfig.pszMainInstruction, LMDCRLF, '<br>');
  LStr := LMDReplaceStr(LStr, LMDCR, '<br>');
  FMainInstruction.Caption := LStr;
end;

procedure TLMDCustomTaskDialog.SetupContent;
var
  LStr: TLMDString;
begin
  LStr := LMDReplaceStr(FConfig.pszContent, LMDCRLF, '<br>');
  LStr := LMDReplaceStr(LStr, LMDCR, '<br>');
  FContent.Caption := LStr;
end;

procedure TLMDCustomTaskDialog.SetupProgressBar;
begin
  if IsSetFlag(TDF_SHOW_PROGRESS_BAR or TDF_SHOW_MARQUEE_PROGRESS_BAR) then
  begin
    FProgressBar.UpdateProgressBar;
    FProgressBar.Visible := true;
    if IsSetFlag(TDF_SHOW_MARQUEE_PROGRESS_BAR) then
      FProgressBar.Marquee := True;
  end
  else
    FProgressBar.Visible := False;
end;

procedure TLMDCustomTaskDialog.SetupRadioButtons;
var
  LRadioButton: TLMDTaskRadioButton;
  i: Integer;
  LHasDefault: Boolean;
begin
  if IsRadioButtonsExists then
  begin
    LHasDefault := False;
    FreeListObjects(FRadioButtons);
    for i := 0 to FConfig.cRadioButtons - 1 do
    begin
      LRadioButton := TLMDTaskRadioButton.Create(Self);
      LRadioButton.Parent := Self;
      //LRadioButton.CtlXP := true;
      LRadioButton.Caption := FConfig.pRadioButtons^[i].pszButtonText;
      LRadioButton.Tag := FConfig.pRadioButtons^[i].nButtonId;
      LRadioButton.OnClick := TriggerRadionButtonClick;
      if not IsSetFlag(TDF_NO_DEFAULT_RADIO_BUTTON) then
        if LRadioButton.Tag = FConfig.nDefaultRadioButton then
        begin
          LRadioButton.Checked := True;
          LHasDefault := True;
        end;
      FRadioButtons.Add(LRadioButton);
    end;
    if (not IsSetFlag(TDF_NO_DEFAULT_RADIO_BUTTON)) and not LHasDefault then
      TLMDTaskRadioButton(FRadioButtons.Items[0]).Checked := true;
  end;
end;

function TLMDCustomTaskDialog.IsSetFlag(AValue: Cardinal): Boolean;
begin
  Result := (FConfig.dwFlags and not AValue) <> FConfig.dwFlags;
end;

procedure TLMDCustomTaskDialog.TriggerDialogConstructed;
begin
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    FConfig.pfCallback(Handle, TDN_DIALOG_CONSTRUCTED, 0, 0, FConfig.lpCallbackData);
end;

procedure TLMDCustomTaskDialog.TriggerExpandArea(Sender: TObject);
begin
  //Invalidate;//!!!
  FExpandedInfo.Visible := IsSetFlag(TDF_EXPAND_FOOTER_AREA) and FCollapse.Checked;
  FExpandText.Visible := FCollapse.Checked;
  VerticalRealignControls;
end;

procedure TLMDCustomTaskDialog.TriggerLinkClick(Sender: TObject; AHref: TLMDString);
begin
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    FConfig.pfCallback(Handle, TDN_HYPERLINK_CLICKED, 0, TLMDPtrInt(PWideChar(AHref)), FConfig.lpCallbackData);
end;

procedure TLMDCustomTaskDialog.TriggerRadionButtonClick(Sender: TObject);
begin
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    FConfig.pfCallback(Handle, TDN_RADIO_BUTTON_CLICKED, THandle((Sender as TLMDTaskRadioButton).Tag), 0, FConfig.lpCallbackData);
end;

procedure TLMDCustomTaskDialog.TriggerShow(Sender: TObject);
begin
  ActiveControl := TWinControl(GetButtonById(FButtons, FConfig.nDefaultButton));
end;

procedure TLMDCustomTaskDialog.TriggerTimer(Sender: TObject);
var
  LReset: Boolean;
begin
  // Call timer notification
  if HandleAllocated and Assigned(FConfig.pfCallback) then
  begin
    LReset := Boolean(FConfig.pfCallback(Handle, TDN_TIMER, GetTickCount() - FTimerCount, 0, FConfig.lpCallbackData));
    if LReset then
      FTimerCount := GetTickCount
  end;
end;

procedure TLMDCustomTaskDialog.VerticalRealignControls;
var
  LVerticalStartPosition: Integer;
  LLastBottom: Integer;
  i: Integer;
  LPanelPadding: Integer;
  LIncrement: Integer;
  {$ifdef LMDCOMP7}
  LHeight: Integer;
  {$endif}
begin
  LVerticalStartPosition := 10;
  FMainIcon.Top := LVerticalStartPosition;
  FMainInstruction.Top := LVerticalStartPosition;
  LLastBottom := FMainInstruction.BoundsRect.Bottom;
  FContent.Top := LLastBottom + FVericalControlPadding;
  LLastBottom := FContent.BoundsRect.Bottom;

  if not IsSetFlag(TDF_EXPAND_FOOTER_AREA) and ((FCollapse.Checked) or (IsSetFlag(TDF_EXPANDED_BY_DEFAULT))) then
  begin
    FExpandText.Top := LLastBottom + FVericalControlPadding;
    LLastBottom := FExpandText.BoundsRect.Bottom;
  end;

  if IsSetFlag(TDF_SHOW_PROGRESS_BAR or TDF_SHOW_MARQUEE_PROGRESS_BAR) then
  begin
    FProgressBar.Top := LLastBottom + FVericalControlPadding;
    LLastBottom := FProgressBar.BoundsRect.Bottom + FVericalControlPadding;
  end;

  if IsRadioButtonsExists then
  begin
    for i := 0 to FRadioButtons.Count - 1 do
    begin
      TLMDTaskRadioButton(FRadioButtons.Items[i]).Top := LLastBottom;
      {$ifdef LMDCOMP7}
      TLMDTaskRadioButton(FRadioButtons.Items[i]).WordWrap := true;
      LHeight := TLMDTaskRadioButton(FRadioButtons.Items[i]).Height;
      TLMDTaskRadioButton(FRadioButtons.Items[i]).Height := LHeight * ((Length(TLMDTaskRadioButton(FRadioButtons.Items[i]).Caption) div 70) + 1);
      {$endif}
      LLastBottom := TLMDTaskRadioButton(FRadioButtons.Items[i]).BoundsRect.Bottom + 5;
    end;
  end;

  LPanelPadding := 22;
  FButtonPanel.Height := FCollapse.Height + FVerification.Height + LPanelPadding;

  Inc(LLastBottom, 12);
  for i := 0 to FButtons.Count - 1 do
  begin
    if IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
    begin
      TLMDCommandLinkButton(FButtons.Items[i]).Top := LLastBottom;
      LLastBottom := TLMDCommandLinkButton(FButtons.Items[i]).BoundsRect.Bottom;
    end
    else
      with TLMDTaskButton(FButtons.Items[i]) do
        Top := LPanelPadding div 2;
  end;

//  if IsSetFlag(TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
//    inc(LLastBottom, 10);

  for i := 0 to FCommonButtons.Count - 1 do
    with TLMDTaskButton(FCommonButtons.Items[i]) do
      Top := LPanelPadding div 2;

  FButtonPanel.Top := LLastBottom + FVericalControlPadding;
  if FVerification.Visible then
    LIncrement := FVerification.Height + 5
  else
    LIncrement := 0;

  FCollapse.Top := (FButtonPanel.Height - (FCollapse.Height + LIncrement)) div 2;

  if FCollapse.Visible then
    FVerification.Top := FCollapse.BoundsRect.Bottom + 5
  else
    FVerification.Top := (FButtonPanel.Height - FVerification.Height) div 2;

  LLastBottom := FButtonPanel.BoundsRect.Bottom;

  if Assigned(FConfig.pszFooter) then
  begin
    FFooterPanel.Top := LLastBottom;
    FFooterPanel.Height := LPanelPadding + FFooterText.Height;
    LLastBottom := FFooterPanel.BoundsRect.Bottom;

    FFooterText.Top := (FFooterPanel.Height - FFooterText.Height) div 2;
    FFooterIcon.Top := (FFooterPanel.Height - FFooterIcon.Height) div 2;
  end;

  if IsSetFlag(TDF_EXPAND_FOOTER_AREA) and (FCollapse.Checked) then
  begin
    FExpandedInfo.Height := LPanelPadding + FExpandText.Height;
    FExpandedInfo.Top := LLastBottom;
    LLastBottom := FExpandedInfo.BoundsRect.Bottom;
    FExpandText.Top := (FExpandedInfo.Height - FExpandText.Height) div 2;
  end;

  ClientHeight := LLastBottom + 1;
end;

procedure TLMDCustomTaskDialog.TriggerButtonClick(Sender: TObject);
var
  LResult: Boolean;
  LForm: TCustomForm;
begin
  LResult := True;
  FResultButton := Integer((Sender as TControl).Tag);
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    LResult := Boolean(FConfig.pfCallback(Handle, TDN_BUTTON_CLICKED, FResultButton, 0, FConfig.lpCallbackData));
  if not LResult then
  begin
    if Sender is TLMDCommandLinkButton then
      (Sender as TLMDCommandLinkButton).ModalResult := FResultButton
    else
      (Sender as TLMDTaskButton).ModalResult := FResultButton;
    LForm := GetParentForm(TControl(Sender));
    if Assigned(LForm) then
      LForm.ModalResult := FResultButton;
  end
  else
  begin
    if Sender is TLMDCommandLinkButton then
      (Sender as TLMDCommandLinkButton).ModalResult := mrNone
    else
      (Sender as TLMDTaskButton).ModalResult := mrNone;
  end;
end;

procedure TLMDCustomTaskDialog.TriggerCreated;
begin
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    FConfig.pfCallback(Handle, TDN_CREATED, 0, 0, FConfig.lpCallbackData);
end;

procedure TLMDCustomTaskDialog.TriggerNavigated;
begin
  if HandleAllocated and Assigned(FConfig.pfCallback) then
    FConfig.pfCallback(Handle, TDM_NAVIGATE_PAGE, 0, 0, FConfig.lpCallbackData);
end;

procedure TLMDCustomTaskDialog.WndProc(var Message: TMessage);
var
  LButton: TControl;
begin
  inherited;
  case Message.Msg of
    TDM_SET_PROGRESS_BAR_RANGE:
    begin
      FProgressBar.Min := Message.LParamLo;
      FProgressBar.Max := Message.LParamHi;
    end;

    TDM_SET_PROGRESS_BAR_POS:
    begin
      FProgressBar.Position := Message.WParam;
    end;

    TDM_SET_PROGRESS_BAR_STATE:
    begin
      // not implemented
    end;

    TDM_CLICK_RADIO_BUTTON:
      ClickButton(FRadioButtons, Message.WParam);

    TDM_CLICK_BUTTON:
    begin
      if not ClickButton(FButtons, Message.WParam) then
        ClickButton(FCommonButtons, Message.WParam);
    end;

    TDM_SET_ELEMENT_TEXT:
    begin
      case Message.WParam of
      TDE_CONTENT:
        FContent.Caption := PWideChar(Message.LParam);
        TDE_MAIN_INSTRUCTION:
        FMainInstruction.Caption := PWideChar(Message.LParam);
        TDE_FOOTER:
        FFooterText.Caption := PWideChar(Message.LParam);
        TDE_EXPANDED_INFORMATION:
        FExpandText.Caption := PWideChar(Message.LParam);
        end;
      HorizontalRealignControls;
      VerticalRealignControls;
    end;

    TDM_UPDATE_ICON:
    begin
      case Message.WParam of
      TDIE_ICON_MAIN:
      begin
        if IsSetFlag(TDF_USE_HICON_MAIN) then
          FConfig.hMainIcon := Message.LParam
          else
          FConfig.pszMainIcon := PWideChar(Message.LParam);
          SetupMainIcon;
      end;
      TDIE_ICON_FOOTER:
      begin
        if IsSetFlag(TDF_USE_HICON_FOOTER) then
          FConfig.hFooterIcon := Message.LParam
          else
          FConfig.pszFooterIcon := PWideChar(Message.LParam);
          SetupFooterIcon;
      end;
      end;
      HorizontalRealignControls;
    end;

    TDM_ENABLE_RADIO_BUTTON:
      EnableButton(FRadioButtons, Message.WParam, Boolean(Message.LParam));

    TDM_ENABLE_BUTTON:
      if not EnableButton(FButtons, Message.WParam, Boolean(Message.LParam)) then
        EnableButton(FCommonButtons, Message.WParam, Boolean(Message.LParam));

    TDM_CLICK_VERIFICATION:
      TLMDControlAccess(FVerification).Click;
      TDM_NAVIGATE_PAGE:
    begin
      FConfig := PTaskDialogConfig(Message.LParam)^;
      FreeListObjects(FGarbageList);
      ClearList(FButtons);
      ClearList(FRadioButtons);
      ClearList(FCommonButtons);
      PrepareTaskDialog;
      TriggerNavigated;
    end;

    TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE:
    begin
      LButton := GetButtonById(FButtons, Message.WParam);
      if Assigned(LButton) then
      begin
        if IsSetFlag (TDF_USE_COMMAND_LINKS or TDF_USE_COMMAND_LINKS_NO_ICON) then
          TLMDCommandLinkButton(LButton).IsElevationButton := Boolean(Message.LParam);
          end;
    end;

    TDM_UPDATE_FLAGS:
      FConfig.dwFlags := Message.LParam;
  end;
end;

procedure TLMDCustomTaskDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s, s1: TLMDString;
  i: integer;
begin
  if (Shift = [ssCtrl]) and ((Key = VK_INSERT) or (Key = ord('C'))) then
  begin
    s := '---------------------------';
    s := s + #13#10 + Caption;
    s := s + #13#10 + '---------------------------';
    s := s + #13#10 + FMainInstruction.Caption;
    s := s + #13#10 + '---------------------------';
    s := s + #13#10 + FContent.Caption;
    s := s + #13#10 + '---------------------------';
    s1 := '';
    for i := ComponentCount - 1 downto 0 do
      if Components[i] is TLMDTaskButton and TLMDTaskButton(Components[i]).Visible then
      if s1 = '' then
        s1 := TLMDTaskButton(Components[i]).Caption
      else
        s1 := s1  + ' ' + TLMDTaskButton(Components[i]).Caption;

    s1 := LMDReplaceStr(s1, '&', '');

    s := s + #13#10 + s1 + #13#10 + '---------------------------';
    s := s + #13#10 + FExpandText.Caption;
    s := s + #13#10 + '---------------------------';
    s := s + #13#10 + FFooterText.Caption;
    s := s + #13#10 + '---------------------------';

    LMDCopyTextToClipboard(s);
    Key := 0;
  end;
end;

end.
