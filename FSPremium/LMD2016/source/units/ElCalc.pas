unit ElCalc;
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

ElCalc unit
-----------

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
  Forms,
  Clipbrd,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  TypInfo,

  ElStyleMan,
  ElComponent,
  ElXPThemedControl,
  ElEdits,
  ElBtnCtl,
  ElPopBtn,
  ElPanel,
  ElPromptDlg,
  ElVCLUtils, 
  ElScrollBox, 
  ElCaption, 
  ElCGControl,

  LMDTypes;

type
  EElMathError = class(Exception)
  end;

  TElMathErrorEvent = procedure(Sender: TObject; AError: TElFString) of object;
  TElCalcDeactivateEvent = procedure(Sender : TOBject; var ModalResult : integer) of object;

  TElDialogStyle = (edsDialog, edsPopup);

  TElCalculatorForm = class(TForm)
    ElCalcPanel: TElPanel;
    ButtonPanel: TElPanel;
    bOk: TElPopupButton;
    bCancel: TElPopupButton;
    b1: TElGraphicButton;
    b2: TElGraphicButton;
    b3: TElGraphicButton;
    b4: TElGraphicButton;
    b5: TElGraphicButton;
    b6: TElGraphicButton;
    b7: TElGraphicButton;
    b8: TElGraphicButton;
    b9: TElGraphicButton;
    b0: TElGraphicButton;
    bSign: TElGraphicButton;
    bPoint: TElGraphicButton;
    bMC: TElGraphicButton;
    bMR: TElGraphicButton;
    bMS: TElGraphicButton;
    bMPlus: TElGraphicButton;
    bDiv: TElGraphicButton;
    bMul: TElGraphicButton;
    bMinus: TElGraphicButton;
    bPlus: TElGraphicButton;
    bSqrt: TElGraphicButton;
    bPercent: TElGraphicButton;
    bDivX: TElGraphicButton;
    bEval: TElGraphicButton;
    bBackspace: TElGraphicButton;
    bCE: TElGraphicButton;
    bC: TElGraphicButton;
    MemoryBox: TElScrollBox;
    Memory: TElPanel;
    FormCaption: TElFormCaption;
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditorEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure b7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Modified: Boolean;
  protected
    FOnDeactivate : TElCalcDeactivateEvent;
    FDialogStyle: TElDialogStyle;
    FEditor: TElEdit;
    FFirst: Extended;
    FLast: Extended;
    FLastOp: char;
    FValue,
    FMemory: Extended;
    FNew: Boolean;
    FOnError: TElMathErrorEvent;
    FOperator: char;
    FSep: boolean;
    IsModal : boolean;
    FShowControlButtons : boolean;
    function GetResult: Extended;
    procedure WMQueryEndSession(var Message : TMessage); message WM_QueryEndSession;
    procedure WMActivate(var Msg : TWMActivate); message WM_ACTIVATE;
    procedure SetDialogStyle(const Value: TElDialogStyle);
    function GetValue: Extended;
    procedure SetValue(Value: Extended);
    procedure CreateParams(var Params : TCreateParams); override;
  public
    property Editor: TElEdit read FEditor write FEditor default nil;
    property Result: Extended read GetResult;
    property DialogStyle: TElDialogStyle read FDialogStyle Write SetDialogStyle default edsDialog;
    property OnError: TElMathErrorEvent read FOnError write FOnError;
    property OnDeactivate : TElCalcDeactivateEvent read FOnDeactivate write FOnDeactivate;
    property Value: Extended read GetValue write SetValue;
  published
  end;

  TElCalculatorDialog = class(TElBaseDlgComponent)
  protected
    FCaption: TLMDString;
    FResetValue: boolean;
    FDigitButtonFont: TFont;
    FMemoryButtonFont: TFont;
    FOperatorButtonFont: TFont;
    FResult: Double;
    FServiceButtonFont: TFont;
    FInitialValue: Double;
    FEditor: TCustomElEdit;
    FOnError: TElMathErrorEvent;
    FOnShow: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FShowControlButtons: Boolean;
    FOnDeactivate: TElCalcDeactivateEvent;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FUseXPThemes: Boolean;
    FPosition: TPosition;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure PrepareDlg(ElCalcForm: TElCalculatorForm);
    procedure DoError(Sender : TObject; AError : TLMDString); virtual;
    procedure DoClose; virtual;
    procedure DoShow; virtual;
    procedure DoDeactivate(Sender : TObject; var ModalResult : integer); virtual;
    procedure InitCalculatorForm(ElCalculatorForm:TElCalculatorForm); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean; override;
  published
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;

    property MemoryButtonFont: TFont read FMemoryButtonFont Write FMemoryButtonFont;
    property DigitButtonFont: TFont read FDigitButtonFont Write FDigitButtonFont;
    property OperatorButtonFont: TFont read FOperatorButtonFont Write FOperatorButtonFont;
    property ServiceButtonFont: TFont read FServiceButtonFont Write FServiceButtonFont;
    property Caption: TLMDString read FCaption write FCaption;
    property Result: Double read FResult;
    property InitialValue: Double read FInitialValue write FInitialValue;
    property Editor: TCustomElEdit read FEditor write FEditor;
    property OnError: TElMathErrorEvent read FOnError write FOnError;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property ShowControlButtons: Boolean read FShowControlButtons write FShowControlButtons default true;
    property OnDeactivate: TElCalcDeactivateEvent read FOnDeactivate write FOnDeactivate;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property Position: TPosition read FPosition write FPosition;
    property ResetValue: Boolean read FResetValue write FResetValue default False;
  end;

procedure LoadCalculatorDefaultGlyph( Glyph: TBitmap );

const
  ElMemoryButtons: array[1..4] of string = ('bMC', 'bMS', 'bMR', 'bMPlus');
  ElServiceButtons: array[1..3] of string = ('bC', 'bBackspace', 'bCE');
  ElOperatorButtons: array[1..10] of string = ('bDiv', 'bMul', 'bPlus', 'bMinus',
    'bSign', 'bPoint', 'bSqrt', 'bPercent', 'bDivX', 'bEval');

implementation

{$R *.dfm}

procedure TElCalculatorForm.EditorKeyPress(Sender: TObject; var Key: Char);
begin
  if not ({$IFDEF LMDCOMP12}CharInSet(Key, ['0'..'9', ',']){$ELSE}Key in ['0'..'9',',']{$ENDIF}) then Key := #0;
  end;

procedure TElCalculatorForm.EditorEnter(Sender: TObject);
begin
  SetFocusedControl(Memory);
end;

procedure TElCalculatorForm.FormCreate(Sender: TObject);
begin
  bPoint.Caption := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
  FSep := false;
  FNew := False;
  FLastOp := #0;
  OnCloseQuery := FormCloseQuery;
end;

procedure TElCalculatorForm.FormShow(Sender: TObject);
begin
  if not Assigned(Editor) then
  begin
    Editor := TElEdit.Create(Self);
    Editor.Parent := Self;
    Editor.Text := '0' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
    Editor.Align := alTop;
    Editor.Alignment := taRightJustify;
    Editor.OnEnter := EditorEnter;
    Editor.OnKeyPress := EditorKeyPress;
    Editor.ReadOnly := True;
    Editor.Multiline := false;
    Height := Height + Editor.Height;
  end;
  SetValue(FValue);
  if not FShowControlButtons then
  begin
    ButtonPanel.Visible := false;
    Height := Height - ButtonPanel.Height;
  end;
end;

procedure TElCalculatorForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  if AnsiChar(Key) in ['0'..'9'] then
  begin
    for i := 0 to ComponentCount - 1 do
      if (Components[i].Name = ('b'+Key)) and
         (Components[i] is TElGraphicButton) then
      begin
       (Components[i] as TElGraphicButton).ButtonClick;
       Modified := true;
      end;
  end
  else
  begin
    case Key of
    '/': bDiv.ButtonClick;
    '*': bMul.ButtonClick;
    '-': bMinus.ButtonClick;
    '+': bPlus.ButtonClick;
    '%': bPercent.ButtonClick;
    '_': bSign.ButtonClick;
    'Q': bSqrt.ButtonClick;
    'R': bDivX.ButtonClick;
//    #13,
    '=': if (not ButtonPanel.Visible) and (not Modified) then
         begin
           ModalResult := mrOk;
           Close;
         end
         else
         begin
           bEval.ButtonClick;
           Modified := false;
         end;
    #27: if (not ButtonPanel.Visible) and (not Modified) then
         begin
           ModalResult := mrCancel;
           Close;
         end
         else
         begin
           bC.ButtonClick;
           Modified := false;
         end;
    #08: bBackspace.ButtonClick;
    end;
    if (Key = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) or (Key = '.') then bPoint.ButtonClick;
    if not (AnsiChar(Key) in [#27, #13, '=']) then Modified := true;
  end;
end;

procedure TElCalculatorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if (ModalResult = mrOk) and Modified then
  begin
    FLastOp := #0;
    bEval.ButtonClick;
    Modified := false;
    FOperator := #0;
    ModalResult := mrOk;
  end;
end;

procedure TElCalculatorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (KEY = ord('V')) and Clipboard.HasFormat(CF_TEXT) then
  begin
    if TextToFloat(PChar(Clipboard.AsText), FValue, fvExtended) then
    Editor.Text := Clipboard.AsText;
  end;
end;

procedure TElCalculatorForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FDialogStyle = edsPopup then
    with Params do
    begin
      Style := WS_POPUP or WS_DLGFRAME;
      ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    end;
end;

procedure TElCalculatorForm.b7Click(Sender: TObject);
var
  i: integer;
  FT: string;
  FR: Extended;

  procedure PutDigit(st: string);
  var
    t: TLMDString;
  begin
    t := Editor.Text;
    if (st <> {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) and (not FSep) then
    begin
      if t = '0'+{$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
        t := st + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator
      else
      begin
        Delete(t, Length(t), 1);
        t := t + st + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
      end;
    end
    else
    begin
      if st = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
        FSep := true
      else
        t := t + st;
    end;
    Editor.Text := t;
  end;

  function Solve(AFirst: Extended; AOp: char; ASecond: Extended): Extended;
  begin
    Result := 0;
    case AOp of
    '+': Result := AFirst + ASecond;
    '-': Result := AFirst - ASecond;
    '*': Result := AFirst * ASecond;
    '/': Result := AFirst / ASecond;
    end;
  end;

begin
  for i := 0 to 9 do
    if (Sender as TControl).Name = 'b' + IntToStr(i) then
    begin
      if FNew then
      begin
        SetValue(0);
        FNew := False;
      end;
      PutDigit(IntToStr(i));
      Modified := true;
    end;

  if (Sender as TControl).Name = 'bPoint' then
  begin
    if FNew then
    begin
      SetValue(0);
      FNew := False;
    end;
    PutDigit({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bBackspace' then
  begin
    if not FNew then
    begin
      FT := Editor.Text;
      if (not FSep) then
        Delete(FT, Length(FT) - 1, 1)
      else
      begin
        if (FT[Length(FT)] <> {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) then
          Delete(FT, Length(FT), 1)
        else
          FSep := False;
      end;
      if (FT = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) or (FT = '-' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) then FT := '0' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
      Editor.Text := FT;
      Modified := true;
    end
    else
    begin
      FNew := false;
      FOperator := #0;
      Modified := true;
    end;
  end
  else

  // Work with memory
  if (Sender as TControl).Name = 'bMS' then
  begin
    FMemory := GetValue;
    Memory.Caption := 'M';
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bMC' then
  begin
    FMemory := 0;
    Memory.Caption := '';
    Modified := true;
  end
  else
  if (Sender as TControl).Name = 'bMR' then
  begin
    SetValue(FMemory);
    Modified := true;
  end
  else
  if (Sender as TControl).Name = 'bMPlus' then
  begin
    FMemory := FMemory + GetValue;
    Memory.Caption := 'M';
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bC' then
  begin
    SetValue(0);
    FFirst := 0;
    FOperator := #0;
    FSep := False;
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bCE' then
  begin
    SetValue(0);
    FSep := False;
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bSign' then
  begin
    if FT <> '0' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then SetValue(-GetValue);
    Modified := true;
  end
  else

  if (Sender as TControl).Name = 'bSqrt' then
  begin
    try
      SetValue(Sqrt(GetValue))
    except
      if Assigned(OnError) then
        FOnError(Self, 'Invalid argument')
      else
        ElMessageDlg('Invalid argument', mtError, [mbOK], 0);
    end;
    Modified := true;
  end
  else

  // Division
  if (Sender as TControl).Name = 'bDiv' then
  begin
    if GetValue = 0 then
    begin
      if Assigned(OnError) then
        FOnError(Self, 'Division by Zero')
      else
        ElMessageDlg('Division by Zero', mtError, [mbOK], 0);
    end
    else
    begin
      if FOperator <> #0 then
        SetValue(Solve(FFirst, FOperator, GetValue));

      FFirst := GetValue;
      FOperator := '/';
      FNew := True;
    end;
    Modified := true;
  end
  else

  // Addition
  if (Sender as TControl).Name = 'bPlus' then
  begin
    if FOperator <> #0 then
      SetValue(Solve(FFirst, FOperator, GetValue));

    FFirst := GetValue;
    FOperator := '+';
    FNew := True;
    Modified := true;
  end
  else

  // Subtraction
  if (Sender as TControl).Name = 'bMinus' then
  begin
    if FOperator <> #0 then
      SetValue(Solve(FFirst, FOperator, GetValue));

    FFirst := GetValue;
    FOperator := '-';
    FNew := True;
    Modified := true;
  end
  else

  // Multiply
  if (Sender as TControl).Name = 'bMul' then
  begin
    if FOperator <> #0 then
      SetValue(Solve(FFirst, FOperator, GetValue));

    FFirst := GetValue;
    FOperator := '*';
    FNew := True;
    Modified := true;
  end
  else

  // Eval
  if (Sender as TControl).Name = 'bEval' then
  begin
    if FOperator <> #0 then
    begin
      FLast := GetValue;
      SetValue(Solve(FFirst, FOperator, FLast));
      FLastOp := FOperator;
    end
    else
    if FLastOp <> #0 then
      SetValue(Solve(GetValue, FLastOp, FLast));

    FOperator := #0;
    FNew := True;
    Modified := true;
  end
  else

  // 1/x
  if (Sender as TControl).Name = 'bDivX' then
  begin
    if GetValue = 0 then
    begin
      if Assigned(OnError) then
        FOnError(Self, 'Division by Zero')
      else
        ElMessageDlg('Division by Zero', mtError, [mbOK], 0);
    end
    else
      SetValue(Solve(1, '/', GetValue));
    Modified := true;
  end
  else

  // %
  if (Sender as TControl).Name = 'bPercent' then
  begin
    if FOperator <> #0 then
    begin
      FR := GetValue;
      if AnsiChar(FOperator) in ['+', '-'] then
        FR := FFirst * FR / 100;

      if AnsiChar(FOperator) in ['*', '/'] then
        FR := FR / 100;

      SetValue(Solve(FFirst, FOperator, FR));
      FOperator := #0;
    end;
    Modified := true;
  end;
end;

function TElCalculatorForm.GetResult: Extended;
begin
  Result := StrToFloat(Editor.Text);
end;

procedure TElCalculatorForm.WMActivate(var Msg: TWMActivate);
var MR: Integer;
begin
  inherited;
  MR := mrNone;
  if Msg.Active = WA_INACTIVE then
    if Assigned(FOnDeactivate) then FOnDeactivate(Self, MR);
  if MR <> mrNone then
    ModalResult := MR;
end;

procedure TElCalculatorForm.WMQueryEndSession(var Message: TMessage);

begin
  inherited;
  Message.Result := 1;
end;

procedure TElCalculatorForm.SetDialogStyle(const Value: TElDialogStyle);
begin
  if FDialogStyle <> Value then
  begin
    FDialogStyle := Value;
    if HandleAllocated then RecreateWnd;
    if Value = edsPopup then
      Height := Height - (GetSystemMetrics(SM_CYSMCAPTION){ - 3})
    else
      Height := Height + (GetSystemMetrics(SM_CYSMCAPTION){ - 3})
  end;
end;

function TElCalculatorForm.GetValue: Extended;
begin
  if Editor = nil then
    result := FValue
  else
    result := StrToFloat(Editor.Text);
end;

procedure TElCalculatorForm.SetValue(Value: Extended);
var
  Ftemp: string;
begin
  if Editor <> nil then
  begin
    Ftemp := FloatToStr(Value);
    FSep := (Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, Ftemp) <> 0);
    if not FSep then
     Ftemp := Ftemp + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
    Editor.Text := Ftemp;
  end
  else
    FValue := Value;
end;

{ TElCalculatorDialog }

procedure TElCalculatorDialog.PrepareDlg(ElCalcForm: TElCalculatorForm);
var
  i: Integer;
  PropInfo   : PPropInfo;
begin
  ElCalcForm.Position := FPosition;
  for i := 0 to 9 do
    (ElCalcForm.FindComponent('b' + IntToStr(i)) as TElGraphicButton).Font := FDigitButtonFont;
  for i := 1 to 4 do
    (ElCalcForm.FindComponent(ElMemoryButtons[i]) as TElGraphicButton).Font := FMemoryButtonFont;
  for i := 1 to 3 do
    (ElCalcForm.FindComponent(ElServiceButtons[i]) as TElGraphicButton).Font := FServiceButtonFont;
  for i := 1 to 10 do
    (ElCalcForm.FindComponent(ElOperatorButtons[i]) as TElGraphicButton).Font := FOperatorButtonFont;
  ElCalcForm.FormCaption.Texts[0].Caption := Self.Caption;
  with ElCalcForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
      if PropInfo <> nil then
        SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
    end;
  with ElCalcForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;
end;

procedure TElCalculatorDialog.SetStyleManager(Value: TElStyleManager);
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

procedure TElCalculatorDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

constructor TElCalculatorDialog.Create(AOwner: TComponent);
begin
  inherited;
  FMemoryButtonFont := TFont.Create;
  FOperatorButtonFont := TFont.Create;
  FServiceButtonFont := TFont.Create;
  FDigitButtonFont := TFont.Create;
  FShowControlButtons := true;
  FUseXPThemes := true;
  FPosition := poScreenCenter;
  FResetValue := false;
end;

destructor TElCalculatorDialog.Destroy;
begin
  inherited;
  FMemoryButtonFont.Free;
  FOperatorButtonFont.Free;
  FServiceButtonFont.Free;
  FDigitButtonFont.Free;
end;

function TElCalculatorDialog.Execute: boolean;
var
  ElCalculatorForm: TElCalculatorForm;
begin
  if csDesigning in ComponentState then
    ElCalculatorForm := TElCalculatorForm.Create(nil)
  else
    ElCalculatorForm := TElCalculatorForm.Create(Self);
  try
    InitCalculatorForm(ElCalculatorForm);
    DoShow;
    result := ElCalculatorForm.ShowModal = mrOk;
    FResult := ElCalculatorForm.Result;
    DoClose;
  finally
    ElCalculatorForm.Free;
  end;
end;

procedure TElCalculatorDialog.DoError(Sender : TObject; AError : TLMDString);
begin
  if assigned(FOnError) then FOnError(Self, AError);
end;

procedure TElCalculatorDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TElCalculatorDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TElCalculatorDialog.DoDeactivate(Sender : TObject; var ModalResult :
    integer);
begin
  ModalResult := mrNone;
  if assigned(FOnDeactivate) then FOnDeactivate(Self, ModalResult);
end;

procedure TElCalculatorDialog.InitCalculatorForm(ElCalculatorForm: TElCalculatorForm);
begin
    PrepareDlg(ElCalculatorForm);
    ElCalculatorForm.Caption := FCaption;
    ElCalculatorForm.Value := InitialValue;
    ElCalculatorForm.Editor := TElEdit(Editor);
    ElCalculatorForm.OnError := DoError;
    ElCalculatorForm.OnDeactivate := DoDeactivate;
    ElCalculatorForm.FShowControlButtons := FShowControlButtons;
    ElCalculatorForm.FNew := FResetValue;
end;

procedure LoadCalculatorDefaultGlyph( Glyph: TBitmap );
begin
  Glyph.LoadFromResourceName(hInstance, 'ELCALCULATOREDIT');
  end;

end.
