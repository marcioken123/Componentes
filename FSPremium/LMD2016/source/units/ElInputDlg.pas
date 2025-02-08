unit ElInputDlg;
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

ElInputDlg unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Math,
  Forms,
  Consts,
  LMDTypes,
  ElBtnCtl,
  ElCheckCtl,
  ElHTMLLbl,
  ElPanel,
  ElEdits,
  LMDHTMLUnit,
  ElVCLUtils,
  ExtCtrls,
  ElCaption,
  ElComponent,

  Types,

  ElStyleMan,
  LMDGraph,
  LMDUtils,
  ElPopBtn;

type

  TElValidateInputEvent = procedure(Sender : TObject; var Value: TElFString; var CanAccept : boolean) of object;

  TElInputDialog = class(TElBaseDlgComponent)
  private
    FPrompt: TLMDString;
    FCaption: TLMDString;
    FIsHTML: Boolean;
    FValue: TLMDString;
    FFont: TFont;
    FParentFont: Boolean;
    FPosition : TPosition;
    FStyleManager: TElStyleManager;
    FStyleName: string;

    FUseXPThemes: Boolean;
    FPasswordChar: TLMDString;
    FShowGlyphs: Boolean;
    FOnValidateInput: TElValidateInputEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;

    FForm: TForm;
    FOkBtn : TElPopupButton;
    FEdit  : TElEdit;
    FKeyPressEvent: TKeyPressEvent;

    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure FontChange(Sender : TObject);
    procedure ValidateInputChange(Sender : TObject); virtual;
    procedure EditorKeyPress(Sender : TObject; var Key : Char); virtual;
    //property ShowGlyphs: Boolean read FShowGlyphs write FShowGlyphs;
  public
    function Execute: Boolean; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property Prompt: TLMDString read FPrompt write FPrompt;
    property Caption: TLMDString read FCaption write FCaption;
    property IsHTML: Boolean read FIsHTML write FIsHTML;
    property Position : TPosition read FPosition write FPosition;
    property Value: TLMDString read FValue write FValue;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property Font: TFont read FFont write SetFont;
    property ParentFont: Boolean read FParentFont write SetParentFont default true;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property PasswordChar: TLMDString read FPasswordChar write FPasswordChar;
    property OnValidateInput: TElValidateInputEvent read FOnValidateInput write
        FOnValidateInput;
    property OnEditorKeyPress: TKeyPressEvent read FKeyPressEvent write
        FKeyPressEvent;
  end;

function InputQuery(const ACaption, APrompt: TLMDString; var AValue: TLMDString;
    AIsHTML : boolean  = true; IsPassword : boolean  = false): Boolean;

type TInputDlgClass = class of TForm;

var

  InputDlgClass : TInputDlgClass = TForm;

var
  MsgDlgOk: TLMDString;
  MsgDlgCancel: TLMDString;

implementation

uses
  LMDGraphUtils,
  LMDObjectList;

function InputQuery(const ACaption, APrompt: TLMDString; var AValue: TLMDString;
    AIsHTML : boolean  = true; IsPassword : boolean  = false): Boolean;
begin
  with TElInputDialog.Create(nil) do
  try
    Caption := ACaption;
    Prompt := APrompt;
    Value := AValue;
    IsHTML := AIsHTML;
    if IsPassword then
      PasswordChar := '*';
    result := Execute;
    if Result then
      AValue := Value;
  finally
    Free;
  end;
end;

function TElInputDialog.Execute: Boolean;
var
  APanel: TElPanel;
  Prompt: TElHTMLLabel;
  DialogUnits: TPoint;
  FFormCaption : TElFormCaption;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  FForm := InputDlgClass.Create(Application);
  with FForm do
    try
      if (Assigned(Self.Font)) and (Assigned(Font)) then
        Font := Self.Font;

      Canvas.Font := Font;
      DialogUnits := LMDGetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := FCaption;
      Position := poScreenCenter;

      APanel := TElPanel.Create(FForm);
      APanel.Parent := FForm;
      APanel.Align := alClient;
      APanel.BevelOuter := bvNone;
      APanel.StyleManager := Self.StyleManager;
      APanel.StyleName := Self.StyleName;
      APanel.UseXPThemes := Self.UseXPThemes;

      FFormCaption := TElFormCaption.Create(FForm);
      FFormCaption.Texts.Add.Caption := FCaption;
      FFormCaption.Active := TRUE;
      FFormCaption.BackgroundType := bgtColorFill;
      FFormCaption.ActiveLeftColor := clActiveCaption;
      FFormCaption.ActiveRightColor := clActiveCaption;
      FFormCaption.InActiveLeftColor := clInActiveCaption;
      FFormCaption.InActiveRightColor := clInActiveCaption;
      FFormCaption.StyleManager := Self.StyleManager;
      FFormCaption.StyleName := Self.StyleName;
      FFormCaption.UseXPThemes := Self.UseXPThemes;

      Prompt := TElHTMLLabel.Create(FForm);
      Prompt.IsHTML := IsHTML;
      Prompt.OnLinkClick := FOnLinkClick;
      Prompt.OnImageNeeded := FOnImageNeeded;
      Prompt.Transparent := true;
      Prompt.StyleManager := Self.StyleManager;
      Prompt.StyleName := Self.StyleName;
      Prompt.UseXPThemes := Self.UseXPThemes;
      with Prompt do
      begin
        Parent := APanel;
        AutoSize := True;
        WordWrap := false;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(4, DialogUnits.Y, 8);
        Caption := FPrompt;
      end;
      FEdit := TElEdit.Create(FForm);
      FEdit.StyleManager := Self.StyleManager;
      FEdit.StyleName := Self.StyleName;
      FEdit.UseXPThemes := Self.UseXPThemes;
      FEdit.PasswordChar := PasswordChar;
      with FEdit do
      begin
        Parent := APanel;
        Left := Prompt.Left;
        Top := MulDiv(8, DialogUnits.Y, 8) + Prompt.Height;
        Width := Max(MulDiv(164, DialogUnits.X, 4), Prompt.Width);
        MaxLength := 255;
        Text := Value;
        SelectAll;
        InactiveBorderType := fbtSunkenOuter;
        ActiveBorderType := fbtSunken;
        Flat := true;
        TabStop := true;
        TabOrder := 0;
        OnChange := ValidateInputChange;
        OnKeyPress := EditorKeyPress;
      end;
      FEdit.HandleNeeded;

      ClientWidth := Max(MulDiv(180, DialogUnits.X, 4), Prompt.Width + MulDiv(16, DialogUnits.X, 4));

      ClientHeight := Prompt.Height + MulDiv(8 * 4 + 12, DialogUnits.Y, 8);
      ButtonTop := Prompt.Height + FEdit.Height + MulDiv(12, DialogUnits.Y, 8);

      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(16, DialogUnits.Y, 8);
      FOkBtn := TElPopupButton.Create(FForm);
      with FOkBtn do
      begin
        Parent := APanel;
        Caption := MsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds((FForm.ClientWidth - (ButtonWidth * 2 + MulDiv(4, DialogUnits.X, 4))) div 2, ButtonTop, ButtonWidth,
          ButtonHeight);
        TabStop := true;
        TabOrder := 1;
        ShowGlyph := FShowGlyphs;

        StyleManager := Self.StyleManager;
        StyleName := Self.StyleName;

        UseXPThemes := Self.UseXPThemes;
      end;
      with TElPopupButton.Create(FForm) do
      begin
        Parent := APanel;
        Caption := MsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds((FForm.ClientWidth + (ButtonWidth * 2 + MulDiv(4, DialogUnits.X, 4))) div 2 - ButtonWidth, ButtonTop, ButtonWidth,
          ButtonHeight);
        TabStop := true;
        TabOrder := 2;
        ShowGlyph := FShowGlyphs;
        StyleManager := Self.StyleManager;
        StyleName := Self.StyleName;
        UseXPThemes := Self.UseXPThemes;
      end;

      ActiveControl := FEdit;
      Position := Self.Position;

      ValidateInputChange(nil);

      if ShowModal = mrOk then
      begin
        Value := FEdit.Text;
        Result := True;
      end;
    finally
      FreeAndNil(FForm);
    end;
end;

procedure TElInputDialog.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    ParentFont := false;
  end;
end;

procedure TElInputDialog.SetParentFont(Value: Boolean);
var AForm : TForm;
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

procedure TElInputDialog.SetStyleManager(Value: TElStyleManager);
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

procedure TElInputDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

constructor TElInputDialog.Create(AOwner : TComponent);
begin
  inherited;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  Position := poScreenCenter;
  FUseXPThemes := true;
end;

procedure TElInputDialog.FontChange(Sender : TObject);
begin
  ParentFont := false;
  //if FForm <> nil then
  //  FForm.Font := FFont;
end;

destructor TElInputDialog.Destroy;
begin
  inherited;
  FFont.Free;
end;

procedure TElInputDialog.ValidateInputChange(Sender : TObject);
var
  Valid : boolean;
  Value : TLMDString;
  OldPos: integer;
begin
  Valid := true;
  Value := FEdit.Text;
  if Assigned(FOnValidateInput) then
    FOnValidateInput(Self, Value, Valid);
  FOkBtn.Enabled := Valid;
  if FEdit.Text <> Value then
  begin
    OldPos := FEdit.SelStart;
    FEdit.Text := Value;
    FEdit.SelStart := OldPos;
  end;
end;

procedure TElInputDialog.EditorKeyPress(Sender : TObject; var Key : Char);
begin
  if assigned(FKeyPressEvent) then
    FKeyPressEvent(Self, Key);
end;

initialization
  MsgDlgOk := SMsgDlgOk;
  MsgDlgCancel := SMsgDlgCancel;

end.
