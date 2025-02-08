unit ElPromptDlg;
{$I lmdcmps.inc}

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

ElPromptDlg unit
----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Clipbrd, Dialogs,
  Math, ImgList, TypInfo, Consts, Types,StdCtrls, ExtCtrls,
  LMDElConst, ElBtnCtl, ElCheckCtl, ElPopBtn, ElStrPool, ElStrArray,
  {$ifdef LMD_UNICODE} LMDUnicodeStrings, {$endif} ElStyleMan,
  ElImgLst, ElHTMLLbl, LMDHTMLUnit, LMDTypes, ElFrmPers, LMDGraphUtils, LMDUtils,
  ElVCLUtils, ElXPThemedControl, ElPanel, ElCaption, ElCLabel, ElComponent, intfLMDBase;

type

  TPromptCloseEvent = procedure (Sender : TObject; Result : integer) of object;

  TElPromptForm = class(TForm)
    Timer: TTimer;
    ElPanel1: TElPanel;
    TimeLabel: TLabel;
    Image: TImage;
    MessageLabel: TElHTMLLabel;
    ShowAgainCB: TElCheckBox;
    HelpBtn: TElPopupButton;
    OkBtn: TElPopupButton;
    IgnoreBtn: TElPopupButton;
    YesBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    NoBtn: TElPopupButton;
    NoToAllBtn: TElPopupButton;
    AbortBtn: TElPopupButton;
    RetryBtn: TElPopupButton;
    YesToAllBtn: TElPopupButton;
    ElFormPersist1: TElFormPersist;
    DisabledImages: TElImageList;
    EnabledImages: TElImageList;
    Captions: TElFormCaption;
    ElPopupButton1: TElPopupButton;
    procedure TimerTimer(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnClick(Sender: TObject);
    procedure MessageLabelLinkClick(Sender: TObject; HRef: TLMDString);
    procedure MessageLabelImageNeeded(Sender: TObject; Src: TLMDString; var Image: TBitmap);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FDisableOk : boolean;
    FLeft      : integer;
    FShowTime  : boolean;
    FSaveDefText: TLMDString;
    SecondsCaption: TLMDString;
    DefaultButton : TElPopupButton;
    Modal      : boolean;
    FOnImageNeed: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnTimer    : TNotifyEvent;
    FOnClose    : TPromptCloseEvent;
    FCaption: TLMDString;

    procedure WMSysCommand(var Message : TWMSysCommand); message WM_SYSCOMMAND;
  public
    CustomData  : pointer;   // should be later TLMDDataTag
  end;

  TElPromptFormClass = class of TElPromptForm;

  TElPromptDialog = class(TCommonDialog, ILMDComponent)
  protected
    FDisableCustomCaption: Boolean;
    FMaxWidth: integer;
    FAbout: TLMDAboutVar;
    FTopmost      : boolean;
    FControlTexts : TLMDStringArray;
    FMessage    : TLMDString;
    FCaptionIdx,
    FMessageIdx : integer;
    FDlgType    : TMsgDlgType;
    FCaptions,
    FTexts      : TLMDStringArray;
    FButtons    : TMsgDlgButtons;
    FDefBtn     : TMsgDlgBtn;
    FCancelBtn  : TMsgDlgBtn;
    FShowGlyphs : boolean;
    FTimeLimit  : integer;
    FShowOnceMore: boolean;
    FShowAgainChecked : boolean;
    FTimedShow  : boolean;
    FHelpCtx    : THelpContext;
    FShowAgainText : TLMDString;
    FDlgCaption    : TLMDString;
    FIsHTML        : boolean;
    FPosition      : TPosition;

    FOnBeforeShow  : TNotifyEvent;
    FOnTimer    : TNotifyEvent;
    FOnClose    : TPromptCloseEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FClass      : TElPromptFormClass;
    FParentFont,
    FParentCaptionFont : Boolean;
    FFont,
    FCaptionFont : TFont;
    FForm       : TElPromptForm;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FUseXPThemes: Boolean;
    FShowAccelChar: Boolean;
    procedure SetDisableCustomCaption(const Value: Boolean);
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure CloseTransfer(Sender : TObject; Result : integer);
    procedure SetTexts(anArray : TLMDStringArray);
    procedure SetCaptions(anArray : TLMDStringArray);
    procedure SetControlTexts(newValue : TLMDStringArray);
    function  CreateWndx : TElPromptForm;
    procedure SetParentFont(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetParentCaptionFont(Value: Boolean);
    procedure SetCaptionFont(Value: TFont);
    procedure FontChange(Sender : TObject);
    procedure CaptionFontChange(Sender : TObject);
  public
    CustomData : pointer;   // should be later TLMDDataTag

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function ShowModal : integer;
    procedure Show;
    function Execute: Boolean; override;
    function getLMDPackage:TLMDPackageID;
    property FormClass : TElPromptFormClass read FClass write FClass;
  published
    property MaxWidth: integer read FMaxWidth write FMaxWidth default 0;
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property DisableCustomCaption: Boolean read FDisableCustomCaption write SetDisableCustomCaption default False;
    property DisableDefault: boolean read FTimedShow write FTimedShow default false;
    property DefaultButton : TMsgDlgBtn read FDefBtn write FDefBtn default mbYes;
    property CancelButton  : TMsgDlgBtn read FCancelBtn write FCancelBtn default mbYes;
    property TimeDelay     : integer read FTimeLimit write FTimeLimit default 0;
    property ShowGlyphs    : boolean read FShowGlyphs write FShowGlyphs default false;
    property Texts         : TLMDStringArray read FTexts write SetTexts;
    property ControlTexts  : TLMDStringArray read FControlTexts write SetControlTexts;  { Published }
    property DialogCaption : TLMDString read FDlgCaption write FDlgCaption;
    property Message       : TLMDString read FMessage write FMessage;
    property MessageIdx    : integer read FMessageIdx write FMessageIdx default -1;
    property DlgType       : TMsgDlgType read FDlgType write FDlgType default mtWarning;
    property Buttons       : TMsgDlgButtons read FButtons write FButtons default [];
    property ShowAgainCheck   : boolean read FShowOnceMore write FShowOnceMore default false;
    property ShowAgainChecked : boolean read FShowAgainChecked write FShowAgainChecked default false;
    property ShowAgainText    : TLMDString read FShowAgainText write FShowAgainText;
    property Captions         : TLMDStringArray read FCaptions write SetCaptions;
    property CaptionIdx       : integer read FCaptionIdx write FCaptionIdx default -1;
    property HelpContext      : THelpContext read FHelpCtx write FHelpCtx default 0;
    property IsHTML           : boolean read FIsHTML write FIsHTML default false;
    property TopMost          : boolean read FTopmost write FTopmost default false;
    property Position         : TPosition read FPosition write FPosition default poDesigned;
    property OnTimer          : TNotifyEvent read FOnTimer write FOnTimer;
    property OnClose          : TPromptCloseEvent read FOnClose write FOnClose;
    property OnBeforeShow     : TNotifyEvent read FOnBeforeShow write FOnBeforeShow;
    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick      : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property ParentFont       : Boolean read FParentFont write SetParentFont default true;
    property Font             : TFont read FFont write SetFont;
    property ParentCaptionFont: Boolean read FParentCaptionFont write SetParentCaptionFont default true;
    property CaptionFont      : TFont read FCaptionFont write SetCaptionFont;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property ShowAccelChar    : Boolean read FShowAccelChar write FShowAccelChar;
  end;

var
  ElPromptForm: TElPromptForm;

function ElMessageDlg(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
function ElMessageDlgEx(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; FormClass : TElPromptFormClass): Word;
function ElMessageDlgEx2(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; IsHTML : boolean; OnLinkClick : TElHTMLLinkClickEvent ): Word;

implementation

uses LMDStrings, LMDObjectList;

{$R *.DFM}

const
  ModalResults: array[TMsgDlgBtn] of Integer = (
           mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
           mrYesToAll, 0 {$ifdef lmdcomp12}, 0 {$endif});

function ElMessageDlg(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
begin
  result := ElMessageDlgEx(Msg, DlgType, Buttons, HelpCtx, TElPromptForm);
end;

function ElMessageDlgEx2(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; IsHTML : boolean; OnLinkClick : TElHTMLLinkClickEvent): Word;
var Dlg : TElPromptDialog;
begin
  Dlg := TElPromptDialog.Create(nil);
  try
    Dlg.Position := poDesktopCenter;
    Dlg.DlgType := DlgType;
    Dlg.Buttons := Buttons;

    if mbOk in Buttons then
      Dlg.DefaultButton := mbOk
    else
    if mbYes in Buttons then
      Dlg.DefaultButton := mbYes
    else
      Dlg.DefaultButton := mbRetry;

    if mbCancel in Buttons then
      Dlg.CancelButton := mbCancel
    else
    if mbNo in Buttons then
      Dlg.CancelButton := mbNo
    else
      Dlg.CancelButton := mbOk;

    Dlg.Message := Msg;
    Dlg.HelpContext := HelpCtx;
    Dlg.IsHTML := true;
    Dlg.OnLinkClick := OnLinkClick;
    result := Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

function ElMessageDlgEx(const Msg: TLMDString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; FormClass : TElPromptFormClass): Word;
var Dlg : TElPromptDialog;
begin
  Dlg := TElPromptDialog.Create(nil);
  try
    Dlg.Position := poDesktopCenter;
    Dlg.DlgType := DlgType;
    Dlg.Buttons := Buttons;

    if mbOk in Buttons then
      Dlg.DefaultButton := mbOk
    else
    if mbYes in Buttons then
      Dlg.DefaultButton := mbYes
    else
      Dlg.DefaultButton := mbRetry;

    if mbCancel in Buttons then
      Dlg.CancelButton := mbCancel
    else
    if mbNo in Buttons then
      Dlg.CancelButton := mbNo
    else
      Dlg.CancelButton := mbOk;

    Dlg.Message := Msg;
    Dlg.HelpContext := HelpCtx;
    Dlg.FormClass := FormClass;
    result := Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TElPromptDialog.SetCaptions(anArray : TLMDStringArray);
begin
  FCaptions.Assign(anArray);
end;

procedure TElPromptDialog.SetTexts(anArray : TLMDStringArray);
begin
  FTexts.Assign(anArray);
end;

constructor TElPromptDialog.Create(AOwner : TComponent);
begin
  inherited;
  FMaxWidth := 0;
  FUseXPThemes := true;
  FTexts := TLMDStringArray.Create;
  FCaptions:= TLMDStringArray.Create;
  FControlTexts := TLMDStringArray.Create;
  FControlTexts.Capacity := 13;

//  FParentFont := true;
//  FParentCaptionFont := true;

  FControlTexts[0] := SMsgDlgYes;
  FControlTexts[1] := SMsgDlgNo;
  FControlTexts[2] := SMsgDlgOK;
  FControlTexts[3] := SMsgDlgCancel;
  FControlTexts[4] := SMsgDlgAbort;
  FControlTexts[5] := SMsgDlgRetry;
  FControlTexts[6] := SMsgDlgIgnore;
  FControlTexts[7] := SMsgDlgAll;
  FControlTexts[8] := SMsgDlgNoToAll;
  FControlTexts[9] := SMsgDlgYesToAll;
  FControlTexts[10]:= SMsgDlgHelp;

  FControlTexts[11]:= SLMDShowNextTime;
  FControlTexts[12] := SLMDDSecondsLeft;

  FMessageIdx := -1;
  FCaptionIdx := -1;
  FFont := TFont.Create;
  FCaptionFont := TFont.Create;

  ParentFont := true;
  ParentCaptionFont := true;

  FFont.OnChange := FontChange;
  FCaptionFont.OnChange := CaptionFontChange;
end;

destructor TElPromptDialog.Destroy;
begin
  FTexts.Free;
  FCaptions.Free;
  FControlTexts.Free;
  FFont.Free;
  FCaptionFont.Free;
  inherited;
end;

function TElPromptDialog.Execute: Boolean;
begin
  Result := ShowModal in [mrOk, mrYes, mrYesToAll];
end;

function TElPromptDialog.ShowModal : integer;
begin
  with CreateWndx do
  try
    Modal := true;
    result := ShowModal;
    Self.ShowAgainChecked := ShowAgainCB.Checked;
  finally
    Free;
  end;
end;

procedure TElPromptDialog.Show;
begin
  with CreateWndx do
  begin
    Application.BringToFront;
    BringToFront;
    Modal := false;
    Show;
  end;
end;

var ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero

function TElPromptDialog.CreateWndx : TElPromptForm;
const
    IconIDs: array[TMsgDlgType] of PChar =
             (IDI_EXCLAMATION, IDI_HAND, IDI_ASTERISK, IDI_QUESTION, nil);

var
    FButtons : TLMDObjectList;
  s2: TLMDString;

    function GetBtn(ABtnType : TMsgDlgBtn) : TElPopupButton;
    var i : integer;
    begin
      result := nil;
      for i := 0 to FButtons.Count - 1 do
      begin
        if TElPopupButton(FButtons[i]).ModalResult = ModalResults[aBtnType] then
        begin
          result := TElPopupButton(FButtons[i]);
          exit;
        end;
      end;
    end;

var
  i, j : integer;
  S    : String;
  DialogUnits: TPoint;
  LMaxWidth: integer;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, Y, ALeft: Integer;
  B: TMsgDlgBtn;
  aBtn     : TElPopupButton;
  Rect1,
  TxtRect  : TRect;
  TOrder   : integer;
  AControl : TControl;
  yoffs    : integer;
  IconID   : PChar;
  PropInfo :  PPropInfo ;  // later --> TLMDPropInfo (LMDTypes)
  LOwner: TComponent;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
begin
  case DlgType of
    mtError: i := MB_ICONHAND;
    mtWarning: i := MB_ICONEXCLAMATION;
    mtInformation: i := MB_ICONASTERISK;
    mtConfirmation: i := MB_ICONQUESTION;
    else i := -1;
  end;
  MessageBeep(i);
  if Assigned(Owner) then
    LOwner := Owner
  else
    LOwner := Application;

  if FClass = nil then
    Application.CreateForm(TElPromptForm, Result)
  else
    Application.CreateForm(FClass, Result);

  result.MessageLabel.WordWrap := not FIsHTML;
  result.MessageLabel.IsHTML := FIsHTML;
  if FMessageIdx <> -1 then
     Result.MessageLabel.Caption := FTexts[FMessageIdx]
  else
     Result.MessageLabel.Caption := FMessage;

  if FCaptionIdx <> -1 then
     Result.FCaption := FCaptions[FCaptionIdx]
  else
     Result.FCaption := DialogCaption;

  Result.FOnImageNeed := FOnImageNeeded;
  Result.FOnLinkClick := FOnLinkClick;

  FButtons := TLMDObjectList.Create;

  Result.Font := Font;
  // Result.Font.Style := []; //Force label font style to normal

  if not ParentCaptionFont then
  begin
    Result.Captions.Font := CaptionFont;
    Result.Captions.SystemFont := false;
  end
  else
    Result.Captions.SystemFont := true;

  j := Result.ElPanel1.ControlCount;
  for i := 0 to j - 1 do
  begin
    AControl := Result.ElPanel1.Controls[i];
    if (AControl is TElPopupButton) and
      (TLMDPtrInt(AControl.Tag) = 1458)
      then
      FButtons.Add(AControl);
  end;

  with result do
  begin
    DialogUnits := LMDGetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    TOrder := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TxtRect := Rect(0, 0, 0, 0);
          lMDDrawText(canvas.handle,
            FControlTexts[TLMDPtrInt(B)],
            -1, TxtRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE
            or DrawTextBiDiModeFlagsReadingOnly);
          with TxtRect do
            ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
           ButtonWidth := ButtonWidths[B];
      end;
    end;

    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TxtRect, 0, 0, Screen.Width div 2, 0);

    TxtRect := MessageLabel.TextRect;
    if FMaxWidth = 0 then
      LMaxWidth := GetDesktopRight - GetDesktopLeft
    else
      LMaxWidth := FMaxWidth;
    if (not FIsHTML) or (TxtRect.Right - TxtRect.Left > LMaxWidth - (MessageLabel.Left + GetSystemMetrics(SM_CXEDGE) * 4 + 32 + HorzSpacing)) then
    begin
      MessageLabel.AutoSize := false;

      TxtRect := Rect(0, 0, LMaxWidth - (MessageLabel.Left + GetSystemMetrics(SM_CXEDGE) * 4 + 32 + HorzSpacing), 0);
      LMDDrawText(canvas.handle, MessageLabel.Caption, -1, TxtRect, DT_CALCRECT or DT_LEFT or DT_WORDBREAK
        or DrawTextBiDiModeFlagsReadingOnly
        );
//      OffsetRect(TxtRect, MessageLabel.Left, MessageLabel.Top);
    end;

    IconTextWidth := TxtRect.Right;
    IconTextHeight := TxtRect.Bottom;

    IconID := IconIDs[DlgType];

    if IconID<>nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max({MessageLabel.Left + }TxtRect.Right, Max(IconTextWidth, ButtonGroupWidth)) + HorzMargin * 2;
    if FShowOnceMore then
       yoffs := ShowAgainCB.Height + VertSpacing
    else
       yoffs := 0;
    if (FTimeLimit > 0) and (not Self.FTimedShow) then
    begin
      SetRectEmpty(Rect1);
      Rect1.Right := ClientWidth - HorzSpacing * 2;
      S := Format(FControlTexts[12], [FTimeLimit]);
      DrawText(Canvas.Handle, PChar(S), Length(S) + 1, Rect1,
               DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK

               or
               DrawTextBiDiModeFlagsReadingOnly

               );
      TimeLabel.Caption := S;
      inc(yoffs, Rect1.Bottom + VertSpacing);
      TimeLabel.Visible := true;
    end;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing + VertMargin * 2 + yoffs;

    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);

    if IconID<>nil then
    with Result.Image do
    begin
      Picture.Icon.Handle := LoadIcon(0, IconID);
      SetBounds(HorzMargin, VertMargin, 32, 32);
    end;

    with MessageLabel do
    begin
      BoundsRect := TxtRect;

      BiDiMode := Result.BiDiMode;

      ALeft := IconTextWidth - TxtRect.Right + HorzMargin;

      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;

      SetBounds(ALeft, VertMargin,
        TxtRect.Right - TxtRect.Left, TxtRect.Bottom - TxtRect.Top);
    end;

    if FDefBtn in Buttons then
    begin
      DefaultButton := GetBtn(FDefBtn);
      if DefaultButton <> nil then
        DefaultButton.Default := true;
    end;

    if FCancelBtn in Buttons then
    begin
      aBtn := GetBtn(FCancelBtn);
      if aBtn <> nil then aBtn.Cancel := true;
    end;

    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      aBtn := GetBtn(B);
      if aBtn <> nil then
      begin
        aBtn.Visible := B in Buttons;
        if aBtn.Visible then
          with aBtn do
          begin
            TabOrder := TOrder;
            Inc(TOrder);

            Caption := FControlTexts[TLMDPtrInt(B)];
            ModalResult := ModalResults[B];
            ShowGlyph := Self.FShowGlyphs;

            SetBounds(X, IconTextHeight + VertMargin + VertSpacing + yoffs,
              ButtonWidth, ButtonHeight);
            Inc(X, ButtonWidth + ButtonSpacing);
          end;
      end;
    end;
    if TimeLabel.Visible then
    begin
      Y := Max(VertMargin + MessageLabel.Height, Image.Top + Image.Height) + VertSpacing;
      X := (ClientWidth - Rect1.Right) div 2;
      TimeLabel.SetBounds(X, Y, Rect1.Right, Rect1.Bottom);
      Inc(Y, Rect1.Bottom + VertSpacing);
    end else
      Y := Max(VertMargin + MessageLabel.Height, Image.Top + Image.Height) + VertSpacing;
    ShowAgainCB.SetBounds(HorzMargin, Y, Width - HorzMargin * 2, ShowAgainCB.Height);
  end;

  FButtons.Free;

  if CaptionIdx <> -1 then
     s2 := Captions[CaptionIdx]
  else
  if DialogCaption <> '' then
     s2 := FDlgCaption
  else
    s2 := Application.Title;

  Result.Captions.Texts[0].Caption := s2;
  Result.Captions.Active := not FDisableCustomCaption;

  Result.Caption := s2; // Should be after Result.Captions.Active := val;

  Result.ShowAgainCB.Visible := FShowOnceMore;
  if FShowOnceMore then
    Result.ShowAgainCB.TabOrder := TOrder;

  Result.ShowAgainCB.Checked := FShowAgainChecked;
  if FShowAgainText <> '' then
     Result.ShowAgainCB.Caption := FShowAgainText
  else
     Result.ShowAgainCB.Caption := FControlTexts[11];

  Result.ElFormPersist1.TopMost := Topmost;

  if FTimeLimit > 0 then
  begin
    Result.FLeft := FTimeLimit;
    Result.FShowTime := true;
    Result.Timer.Interval := 1000;
    Result.Timer.Enabled  := true;
    Result.FDisableOk := FTimedShow;
    if FTimedShow then
    begin
      if Result.DefaultButton <> nil then
      begin
        Result.FSaveDefText := Result.DefaultButton.Caption;
        Result.DefaultButton.Caption := IntToStr(FTimeLimit);
        Result.DefaultButton.Enabled := false;
      end;
    end;
  end;

  Result.SecondsCaption := FControlTexts[12];
  Result.FOnTimer := FOnTimer;
  Result.FOnClose := CloseTransfer;
  Result.Tag := Tag;
  Result.CustomData := CustomData;
  Result.HelpContext := HelpContext;
  Result.Position := Position;
  FForm := Result;

  FForm.MessageLabel.ShowAccelChar := ShowAccelChar;

  with FForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;

  with FForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
      if PropInfo <> nil then
        SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
    end;

  if assigned(FOnBeforeShow) then FOnBeforeShow(Result);
end;

procedure TElPromptDialog.SetControlTexts(newValue : TLMDStringArray);
begin
  FControlTexts.Assign(newValue);
end;

procedure TElPromptDialog.SetDisableCustomCaption(const Value: Boolean);
begin
  if FDisableCustomCaption <> Value then
  begin
    FDisableCustomCaption := Value;
    if FForm <> nil then
      FForm.Captions.Active := not FDisableCustomCaption;
  end;
end;

{ SetControlTexts }

procedure TElPromptDialog.SetParentFont(Value: Boolean);
var
  AForm : TForm;
begin
  if FParentFont <> Value then
  begin
    if Value then
    begin
      AForm := LMDGetOwnerForm(Self);
      if AForm <> nil then
        Font := AForm.Font;
      FParentFont := true;
    end
    else
      FParentFont := false;
  end;
end;

procedure TElPromptDialog.SetParentCaptionFont(Value: Boolean);
var
  AForm : TForm;
begin
  if FParentCaptionFont <> Value then
  begin
    if Value then
    begin
      AForm := LMDGetOwnerForm(Self);
      if AForm <> nil then
        CaptionFont := AForm.Font;
      FParentCaptionFont := true;
    end
    else
      FParentCaptionFont := false;
  end;
end;

procedure TElPromptDialog.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    ParentFont := false;
  end;
end;

procedure TElPromptDialog.SetCaptionFont(Value: TFont);
begin
  if FCaptionFont <> Value then
  begin
    FCaptionFont.Assign(Value);
    ParentCaptionFont := false;
  end;
end;

procedure TElPromptDialog.CloseTransfer(Sender : TObject; Result : integer);
begin
  FForm := nil;
  if assigned(FOnClose) then
    FOnClose(Sender, Result);
end;

procedure TElPromptDialog.FontChange(Sender : TObject);
begin
  ParentFont := false;
  if FForm <> nil then
  begin
    FForm.Font := FFont;
    //FForm.Captions.Font := FFont;
    //FForm.Captions.SystemFont := false;
  end;
end;

procedure TElPromptDialog.CaptionFontChange(Sender : TObject);
begin
  ParentCaptionFont := false;
  if FForm <> nil then
  begin
    FForm.Captions.Font := FCaptionFont;
    FForm.Captions.SystemFont := false;
  end;
end;

procedure TElPromptDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElPromptDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

procedure TElPromptForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TElPromptForm.MessageLabelImageNeeded(Sender: TObject;Src: TLMDString; var Image: TBitmap);
begin
  if Assigned(FOnImageNeed) then
     FOnImageNeed(Self, Src, Image);
end;

procedure TElPromptForm.MessageLabelLinkClick(Sender: TObject; HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
     FOnLinkClick(Self, HRef);
end;

procedure TElPromptForm.FormShow(Sender: TObject);
var DesktopRect : TRect;
begin
  DesktopRect := GetDesktopRect;
  if Left < DesktopRect.Left then
    Left := DesktopRect.Left;
  if Top < DesktopRect.Top then
    Top := DesktopRect.Top;
  if Left + Width > DesktopRect.Right then
    Left := DesktopRect.Right - Width;
  if Top + Height > DesktopRect.Bottom then
    Top := DesktopRect.Bottom - Height;

  ElPanel1.TabStop := false;
  if Assigned(DefaultButton) and DefaultButton.Enabled then
    DefaultButton.SetFocus;
  MessageLabel.OnLinkClick := MessageLabelLinkClick;
  MessageLabel.OnImageNeeded := MessageLabelImageNeeded;
  if FDisableOk then
  begin
    EnableMenuItem(GetSystemMenu(Handle, false), SC_CLOSE, MF_BYCOMMAND or MF_DISABLED);
  end;
end;

procedure TElPromptForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FOnClose) then
     FOnClose(Self, ModalResult);
  if not Modal then
     Action := caFree;
end;

procedure TElPromptForm.BtnClick(Sender: TObject);
var Btn : TElPopupButton;
begin
  Btn := Sender as TElPopupButton;
  if (Btn.ModalResult <> mrNone) and (not Modal) then
  begin
    ModalResult := Btn.ModalResult;
    Close;
  end;
end;

procedure TElPromptForm.WMSysCommand(var Message : TWMSysCommand);
begin
  if (Message.CmdType = SC_CLOSE) and FDisableOk and (FLeft > 0) then
  begin
    Message.Result := 0;
    exit;
  end;
  inherited;
end;

procedure TElPromptForm.TimerTimer(Sender: TObject);
begin
  dec(FLeft);
  if not FDisableOk then
  begin
    if FLeft > 0 then
    begin
      TimeLabel.Caption := Format(SecondsCaption, [FLeft]);
    end else
    begin
      if assigned(FOnTimer) then FOnTimer(Self);
      if assigned(FOnClose) then
      begin
        if DefaultButton <> nil then
           FOnClose(Self, DefaultButton.ModalResult)
        else
           FOnClose(Self, mrNone);
      end;
      if DefaultButton <> nil then
         DefaultButton.Click
      else
        Close;
    end;
  end else
  begin
    if FLeft > 0 then
    begin
      if DefaultButton <> nil then
         DefaultButton.Caption := IntToStr(FLeft);
    end else
    begin
      if assigned(FOnTimer) then FOnTimer(Self);
      EnableMenuItem(GetSystemMenu(Handle, false), SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
      if DefaultButton <> nil then
      begin
        DefaultButton.Enabled := true;
        DefaultButton.Caption := FSaveDefText;
        DefaultButton.SetFocus;
      end;
    end;
  end;
end;

procedure TElPromptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s, s1: TLMDString;
  i: integer;
begin
  if (Shift = [ssCtrl]) and ((Key = VK_INSERT) or (Key = ord('C'))) then
  begin
    s := '---------------------------';
    s := s + #13#10 + FCaption;
    s := s + #13#10 + '---------------------------';
    s := s + #13#10 + MessageLabel.PlainText;
    s := s + #13#10 + '---------------------------';
    with ElPanel1 do
      for i := 0 to ControlCount - 1 do
        if Controls[i] is TElPopupButton and TElPopupButton(Controls[i]).Visible then
          if s1 = '' then
            s1 := TElPopupButton(Controls[i]).Caption
          else
            s1 := s1 + ' '+ TElPopupButton(Controls[i]).Caption;
    s1 := LMDReplaceStr(s1, '&', '');
    s := s  + #13#10 + s1;
    s := s + #13#10 + '---------------------------';
    LMDCopyTextToClipboard(s);
    Key := 0;
  end;
end;

function TElPromptDialog.getLMDPackage: TLMDPackageID;
begin
   result:=pi_LMD_ELCORE;
end;

end.
