unit CADForm;
{$I lmddlgcmps.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JSDialogs, ComCtrls;

type
  TDlgSettings = class
  private
    FTitle: string;
    FMainInstruction: string;
    FContent: TStrings;
    FIcon: Integer;
    FButtons: TCommonButtons;
    FUseMethod: Integer;
    FVerifyText: string;
    FWrapperMethodIdx: Integer;
    procedure SetContent(const Value: TStrings);
    function GetDlgButtons: string;
    function GetCommonButtons: string;
    function GetDlgType: string;
    function GetTaskType: string;
    function GetTaskButtons: string;
    function GetTaskDialogIcon: string;
    function GetJSDialogTemplate: string;
  public
    constructor Create;
    destructor Destroy; override;
    function ToString: string; {$IFDEF DELPHI2009}override;{$ENDIF}
    property Title: string read FTitle write FTitle;
    property MainInstruction: string read FMainInstruction write FMainInstruction;
    property Content: TStrings read FContent write SetContent;
    property Icon: Integer read FIcon write FIcon;
    property Buttons: TCommonButtons read FButtons write FButtons;
    property VerifyText: string read FVerifyText write FVerifyText;
    property UseMethod: Integer read FUseMethod write FUseMethod;
    property WrapperMethodIdx: Integer read FWrapperMethodIdx write FWrapperMethodIdx;
  end;

  TfrmCAD = class(TForm)
    bOK: TButton;
    bCancel: TButton;
    bHelp: TButton;
    bPreview: TButton;
    cbDefault: TCheckBox;
    PageControl1: TPageControl;
    tsTaskDialog: TTabSheet;
    tsMessageDlg: TTabSheet;
    tsJSDialog: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    iMainIcon: TImage;
    gbCommonButtons: TGroupBox;
    cbcbYes: TCheckBox;
    cbcbNo: TCheckBox;
    cbcbOK: TCheckBox;
    cbcbCancel: TCheckBox;
    cbcbRetry: TCheckBox;
    cbcbClose: TCheckBox;
    eInstruction: TEdit;
    mContent: TMemo;
    rgMainIcon: TRadioGroup;
    eTitle: TEdit;
    Label3: TLabel;
    Image1: TImage;
    rgMsgDlgType: TRadioGroup;
    Label4: TLabel;
    Memo1: TMemo;
    gbDlgButtons: TGroupBox;
    cbmbYes: TCheckBox;
    cbmbNo: TCheckBox;
    cbmbOK: TCheckBox;
    cbmbCancel: TCheckBox;
    cbmbAbort: TCheckBox;
    cbmbRetry: TCheckBox;
    cbmbIgnore: TCheckBox;
    cbmbAll: TCheckBox;
    cbmbNoToAll: TCheckBox;
    cbmbYesToAll: TCheckBox;
    cbmbHelp: TCheckBox;
    cbmbClose: TCheckBox;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    eInstructionVerifyMessage: TEdit;
    Label6: TLabel;
    mContentVerifyMessage: TMemo;
    iVerifyMessage: TImage;
    rgVerifyMessage: TRadioGroup;
    GroupBox1: TGroupBox;
    cbvmYes: TCheckBox;
    cbvmNo: TCheckBox;
    cbvmOK: TCheckBox;
    cbvmCancel: TCheckBox;
    cbvmAbort: TCheckBox;
    cbvmRetry: TCheckBox;
    cbvmIgnore: TCheckBox;
    cbvmAll: TCheckBox;
    cbvmNoToAll: TCheckBox;
    cbvmYesToAll: TCheckBox;
    cbvmHelp: TCheckBox;
    cbvmClose: TCheckBox;
    Label7: TLabel;
    eVerifyText: TEdit;
    TabSheet2: TTabSheet;
    rgWrapperMethod: TRadioGroup;
    Label8: TLabel;
    eWrapperMessage: TEdit;
    procedure rgMainIconClick(Sender: TObject);
    procedure cbcbYesClick(Sender: TObject);
    procedure bPreviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgMsgDlgTypeClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure rgVerifyMessageClick(Sender: TObject);
  private
    { Private declarations }
    procedure ValidateMethod;
  public
    { Public declarations }
    class function Execute(var aSettings: TDlgSettings): Boolean;
    function GetButtons: TCommonButtons;
    function GetDlgButtonsEx: TCommonButtons;
    function GetDlgButtons: TMsgDlgButtons;
    function GetDlgType: TMsgDlgType;
    function GetTDIcon: Integer;
    function GetTDButtons: Integer;
    function GetVMDlgButtonsEx: TCommonButtons;
    function GetVMIcon: TTaskDialogIcon;
  end;

var
  frmCAD: TfrmCAD;

implementation

uses
  JSDialog;

{$R *.dfm}

{ TfrmCAD }

procedure TfrmCAD.bPreviewClick(Sender: TObject);
var
  lTempBool: Boolean;
begin
  case PageControl1.ActivePageIndex of
    0:
      begin
        if GetTDButtons = 0 then
          cbcbOK.Checked := True;
        TaskDialog(0, eTitle.Text, eInstruction.Text, mContent.Text, GetTDIcon, GetTDButtons);
      end;
    1:
      begin
        if GetDlgButtons = [] then
          cbmbOK.Checked := True;
        MessageDlg(Memo1.Text, GetDlgType, GetDlgButtons, 0);
      end;
    2: ; // TJsdialog
    3:
      begin
        if GetVMDlgButtonsEx = [] then
          cbvmOK.Checked := True;
        if (mContentVerifyMessage.Text = '') and (eInstructionVerifyMessage.Text <> '') then
          VerifyMessage(eInstructionVerifyMessage.Text, GetVMIcon, GetVMDlgButtonsEx,
            0, mtInstruction, eVerifyText.Text, lTempBool)
        else if (mContentVerifyMessage.Text <> '') and (eInstructionVerifyMessage.Text = '') then
          VerifyMessage(mContentVerifyMessage.Text, GetVMIcon, GetVMDlgButtonsEx,
            0, mtContent, eVerifyText.Text, lTempBool)
        else
          VerifyMessage(eInstructionVerifyMessage.Text, mContentVerifyMessage.Text, GetVMIcon, GetVMDlgButtonsEx,
            0, eVerifyText.Text, lTempBool);
      end;
    4: 
      begin
        case rgWrapperMethod.ItemIndex of
          0: ShowMessage(eWrapperMessage.Text);  
          1: ShowErrorMessage('You cannot preview the ShowMessageFmt method as it requires variable input');
          2: ShowInfoMessage(eWrapperMessage.Text);
          3: ShowErrorMessage(eWrapperMessage.Text);
          4: ShowConfirmMessage(eWrapperMessage.Text);
          5: ShowWarningMessage(eWrapperMessage.Text);
        end;
      end;
  end;
end;

procedure TfrmCAD.cbcbYesClick(Sender: TObject);
begin
  ValidateMethod;
end;

class function TfrmCAD.Execute(var aSettings: TDlgSettings): Boolean;
var
  lDlg: TfrmCAD;
begin
  lDlg := TfrmCAD.Create(nil);
  try
    result := lDlg.ShowModal = mrOK;
    if result then
    begin
      if lDlg.PageControl1.ActivePageIndex = 0 then
      begin
        aSettings.Title := lDlg.eTitle.Text;
        aSettings.MainInstruction := lDlg.eInstruction.Text;
        aSettings.Content.Assign(lDlg.mContent.Lines);
        aSettings.Icon := lDlg.rgMainIcon.ItemIndex;
        aSettings.Buttons := lDlg.GetButtons;
        aSettings.UseMethod := lDlg.PageControl1.ActivePageIndex;
      end
      else if lDlg.PageControl1.ActivePageIndex = 1 then
      begin
        aSettings.Title := '';
        aSettings.MainInstruction := '';
        aSettings.Content.Assign(lDlg.Memo1.Lines);
        aSettings.Icon := lDlg.rgMsgDlgType.ItemIndex;
        aSettings.Buttons := lDlg.GetDlgButtonsEx;
        aSettings.UseMethod := lDlg.PageControl1.ActivePageIndex;
      end
      else if lDlg.PageControl1.ActivePageIndex = 3 then
      begin
        aSettings.Title := '';
        aSettings.MainInstruction := lDlg.eInstructionVerifyMessage.Text;
        aSettings.Content.Assign(lDlg.mContentVerifyMessage.Lines);
        aSettings.Icon := lDlg.rgVerifyMessage.ItemIndex;
        if lDlg.rgVerifyMessage.ItemIndex = lDlg.rgVerifyMessage.Items.Count - 1 then
          aSettings.Icon := aSettings.Icon + 1;        
        aSettings.Buttons := lDlg.GetVMDlgButtonsEx;
        aSettings.VerifyText := lDlg.eVerifyText.Text;
        aSettings.UseMethod := lDlg.PageControl1.ActivePageIndex;
      end
      else if lDlg.PageControl1.ActivePageIndex = 4 then
      begin
        aSettings.Title := '';
        aSettings.MainInstruction := '';
        aSettings.Content.Add(lDlg.eWrapperMessage.Text);
        aSettings.Icon := 0;
        aSettings.Buttons := [];
        aSettings.VerifyText := '';
        aSettings.UseMethod := lDlg.PageControl1.ActivePageIndex;
        aSettings.WrapperMethodIdx := lDlg.rgWrapperMethod.ItemIndex;
      end
    end;
  finally
    lDlg.Free;
  end;
end;

procedure TfrmCAD.FormCreate(Sender: TObject);
begin
  tsJSDialog.TabVisible := False;
  rgMainIcon.ItemIndex := 3;
  rgMainIconClick(rgMainIcon);
  rgMsgDlgType.ItemIndex := 2;
  rgMsgDlgTypeClick(rgMsgDlgType);
  rgVerifyMessage.ItemIndex := 4;
  rgVerifyMessageClick(rgVerifyMessage);
  PageControl1.ActivePageIndex := 0;
end;

{ TDlgSettings }

constructor TDlgSettings.Create;
begin
  FContent := TStringList.Create;
end;

destructor TDlgSettings.Destroy;
begin
  FContent.Free;
  inherited;
end;

function TDlgSettings.GetCommonButtons: string;
begin
  result := '[';
  if cbYes in Buttons then
    result := result + 'cbYes, ';
  if cbNo in Buttons then
    result := result + 'cbNo, ';
  if cbOK in Buttons then
    result := result + 'cbOK, ';
  if cbCancel in Buttons then
    result := result + 'cbCancel, ';
  if cbAbort in Buttons then
    result := result + 'cbAbort, ';
  if cbRetry in Buttons then
    result := result + 'cbRetry, ';
  if cbIgnore in Buttons then
    result := result + 'cbIgnore, ';
  if cbAll in Buttons then
    result := result + 'cbAll, ';
  if cbNoToAll in Buttons then
    result := result + 'cbNoToAll, ';
  if cbYesToAll in Buttons then
    result := result + 'cbYesToAll, ';
  if cbHelp in Buttons then
    result := result + 'cbHelp, ';
  if cbClose in Buttons then
    result := result + 'cbClose, ';
  result := Copy(result, 1, Length(result) - 2) + ']';
end;

function TDlgSettings.GetDlgButtons: string;
begin
  result := '[';
  if cbYes in Buttons then
    result := result + 'mbYes, ';
  if cbNo in Buttons then
    result := result + 'mbNo, ';
  if cbOK in Buttons then
    result := result + 'mbOK, ';
  if cbCancel in Buttons then
    result := result + 'mbCancel, ';
  if cbAbort in Buttons then
    result := result + 'mbAbort, ';
  if cbRetry in Buttons then
    result := result + 'mbRetry, ';
  if cbIgnore in Buttons then
    result := result + 'mbIgnore, ';
  if cbAll in Buttons then
    result := result + 'mbAll, ';
  if cbNoToAll in Buttons then
    result := result + 'mbNoToAll, ';
  if cbYesToAll in Buttons then
    result := result + 'mbYesToAll, ';
  if cbHelp in Buttons then
    result := result + 'mbHelp, ';
  if cbClose in Buttons then
    result := result + 'mbClose, ';
  result := Copy(result, 1, Length(result) - 2) + ']';
end;

function TDlgSettings.GetDlgType: string;
begin
  result := '';
  case TTaskDialogIcon(Icon) of
    tdiNone: result := 'mtCustom';
    tdiWarning: result := 'mtWarning';
    tdiError: result := 'mtError';
    tdiInformation: result := 'mtInformation';
    tdiConfirmation: result := 'mtConfirmation';
    tdiCustom: result := 'mtCustom';
    tdiShield: result := 'mtCustom';
  end;
end;

function TDlgSettings.GetJSDialogTemplate: string;
begin
  result := '';
end;

function TDlgSettings.GetTaskButtons: string;
begin
  result := '';
  if cbYes in Buttons then
    result := result + 'TD_BUTTON_YES or ';
  if cbNo in Buttons then
    result := result + 'TD_BUTTON_NO or ';
  if cbOK in Buttons then
    result := result + 'TD_BUTTON_OK or ';
  if cbCancel in Buttons then
    result := result + 'TD_BUTTON_CANCEL or ';
  if cbRetry in Buttons then
    result := result + 'TD_BUTTON_RETRY or ';
  if cbClose in Buttons then
    result := result + 'TD_BUTTON_CLOSE or ';
  result := Copy(result, 1, Length(result) - 4);
end;

function TDlgSettings.GetTaskDialogIcon: string;
begin
  case TTaskDialogIcon(Icon) of
    tdiNone: result := 'tdiNone';
    tdiWarning: result := 'tdiWarning';
    tdiError: result := 'tdiError';
    tdiInformation: result := 'tdiInformation';
    tdiConfirmation: result := 'tdiConfirmation';
    tdiCustom: result := 'tdiCustom';
    tdiShield: result := 'tdiShield';
  end;
end;

function TDlgSettings.GetTaskType: string;
begin
  result := '';
  case TTaskDialogIcon(Icon) of
    tdiNone: result := 'TD_ICON_BLANK';
    tdiWarning: result := 'TD_ICON_WARNING';
    tdiError: result := 'TD_ICON_ERROR';
    tdiInformation: result := 'TD_ICON_INFORMATION';
    tdiConfirmation: result := 'TD_ICON_QUESTION';
    tdiCustom: result := 'TD_ICON_BLANK';
    tdiShield: result := 'TD_ICON_SHIELD';
  end;
end;

procedure TDlgSettings.SetContent(const Value: TStrings);
begin
  FContent.Assign(Value);
end;

function EscapeStr(const AStr: string): string;
begin
  if Pos('#13#10', AStr) > 0 then
    Result := AStr
  else
    Result := StringReplace(aStr, '''', '''''', [rfReplaceAll]);
end;

function ExtractStr(const AStr: string): string;
//var
//  LPos: Integer;
begin
  Result := AStr;
  if POS(#13#10, AStr) = Length(AStr) - 1 then
  begin
//    ShowMessage('Removing end line break');
    Result := Copy(AStr, 1, Length(AStr) - 2);
  end;
//  LPos := POS(#13#10, Result);
//  if LPos > 0 then
//    ShowMessage('Has a line break @ : ' + IntToStr(LPos));
  Result := StringReplace(Result, #13#10, ''' + #13#10 + ''', [rfReplaceAll]);
end;

function TDlgSettings.ToString: string;
var
  lMethodName: string;
  lContentText: string;
  I: Integer;
begin
  LContentText := '';
  for I := 0 to FContent.Count - 1 do
  begin
    LContentText := LContentText + FContent[I] + #13#10;
  end;
  if Length(lContentText) > 0 then
  begin
    if (lContentText[Length(lContentText)] = #10) and (lContentText[Length(lContentText)-1] = #13) then
    begin
      lContentText := Copy(lContentText, 1, Length(lContentText) - 2);
    end;
  end;
  case UseMethod of
    1:
      begin
        result := Format('MessageDlg(''%s'', %s, %s, 0);'#13#10, [
          EscapeStr(ExtractStr(Content.Text)), GetDlgType, GetDlgButtons]);
      end;
    0:
      begin
        result := Format('TaskDialog(%d, ''%s'', ''%s'', ''%s'', %s, %s);', [
          0, EscapeStr(Title), EscapeStr(MainInstruction), EscapeStr(ExtractStr(LContentText)), GetTaskType, GetTaskButtons]);
      end;
    2: ; // jsdialog
    3:
      begin
        if (FContent.Text = '') and (FMainInstruction <> '') then
          result := Format('VerifyMessage(''%s'', %s, %s, 0, %s, ''%s'', lVerifyChecked);', [EscapeStr(FMainInstruction),
            GetTaskDialogIcon, GetCommonButtons, 'mtInstruction', FVerifyText])
        else if (FContent.Text <> '') and (FMainInstruction = '') then
          result := Format('VerifyMessage(''%s'', %s, %s, 0, %s, ''%s'', lVerifyChecked);', [EscapeStr(lContentText),
            GetTaskDialogIcon, GetCommonButtons, 'mtContent', FVerifyText])
        else
          result := Format('VerifyMessage(''%s'', ''%s'', %s, %s, 0, ''%s'', lVerifyChecked);', [EscapeStr(FMainInstruction),
            EscapeStr(lContentText), GetTaskDialogIcon, GetCommonButtons, FVerifyText])
      end;
    4:
      begin
        case FWrapperMethodIdx of
          0: lMethodName := 'ShowMessage';
          1: lMethodName := 'ShowMessageFmt';
          2: lMethodName := 'ShowInfoMessage';
          3: lMethodName := 'ShowErrorMessage';
          4: lMethodName := 'ShowConfirmMessage';
          5: lMethodName := 'ShowWarningMessage';
        end;
        if FWrapperMethodIdx <> 1 then
          result := Format('%s(''%s'');', [lMethodName, EscapeStr(lContentText)])
        else
          result := Format('%s(''%s'', []);', [lMethodName, EscapeStr(lContentText)])
      end
  else
    result := GetJSDialogTemplate;
  end;

end;

function TfrmCAD.GetButtons: TCommonButtons;
begin
  result := [];
  if cbcbYes.Checked then
    result := result + [cbYes];
  if cbcbNo.Checked then
    result := result + [cbNo];
  if cbcbCancel.Checked then
    result := result + [cbCancel];
  if cbcbOK.Checked then
    result := result + [cbOK];
  if cbcbRetry.Checked then
    result := result + [cbRetry];
  if cbcbClose.Checked then
    result := result + [cbClose];
end;

function TfrmCAD.GetDlgButtons: TMsgDlgButtons;
begin
  result := [];
  if cbmbYes.Checked then
    result := result + [mbYes];
  if cbmbNo.Checked then
    result := result + [mbNo];
  if cbmbCancel.Checked then
    result := result + [mbCancel];
  if cbmbOK.Checked then
    result := result + [mbOK];
  if cbmbAbort.Checked then
    result := result + [mbAbort];
  if cbmbRetry.Checked then
    result := result + [mbRetry];
  if cbmbIgnore.Checked then
    result := result + [mbIgnore];
  if cbmbAll.Checked then
    result := result + [mbAll];
  if cbmbNoToAll.Checked then
    result := result + [mbNoToAll];
  if cbmbYesToAll.Checked then
    result := result + [mbYesToAll];
  if cbmbHelp.Checked then
    result := result + [mbHelp];
end;

function TfrmCAD.GetDlgButtonsEx: TCommonButtons;
begin
  result := [];
  if cbmbYes.Checked then
    result := result + [cbYes];
  if cbmbNo.Checked then
    result := result + [cbNo];
  if cbmbCancel.Checked then
    result := result + [cbCancel];
  if cbmbOK.Checked then
    result := result + [cbOK];
  if cbmbAbort.Checked then
    result := result + [cbAbort];
  if cbmbRetry.Checked then
    result := result + [cbRetry];
  if cbmbIgnore.Checked then
    result := result + [cbIgnore];
  if cbmbAll.Checked then
    result := result + [cbAll];
  if cbmbNoToAll.Checked then
    result := result + [cbNoToAll];
  if cbmbYesToAll.Checked then
    result := result + [cbYesToAll];
  if cbmbHelp.Checked then
    result := result + [cbHelp];
  if cbmbClose.Checked then
    result := result + [cbClose];
end;

function TfrmCAD.GetVMDlgButtonsEx: TCommonButtons;
begin
  result := [];
  if cbvmYes.Checked then
    result := result + [cbYes];
  if cbvmNo.Checked then
    result := result + [cbNo];
  if cbvmCancel.Checked then
    result := result + [cbCancel];
  if cbvmOK.Checked then
    result := result + [cbOK];
  if cbvmAbort.Checked then
    result := result + [cbAbort];
  if cbvmRetry.Checked then
    result := result + [cbRetry];
  if cbvmIgnore.Checked then
    result := result + [cbIgnore];
  if cbvmAll.Checked then
    result := result + [cbAll];
  if cbvmNoToAll.Checked then
    result := result + [cbNoToAll];
  if cbvmYesToAll.Checked then
    result := result + [cbYesToAll];
  if cbvmHelp.Checked then
    result := result + [cbHelp];
  if cbvmClose.Checked then
    result := result + [cbClose];
end;

function TfrmCAD.GetVMIcon: TTaskDialogIcon;
begin
  result := TTaskDialogIcon(rgVerifyMessage.ItemIndex);
  if result = tdiCustom then
    result := tdiShield;
end;

function TfrmCAD.GetDlgType: TMsgDlgType;
begin
  case rgMsgDlgType.ItemIndex of
    0: result := mtWarning;
    1: result := mtError;
    2: result := mtInformation;
    3: result := mtConfirmation;
  else
    result := mtCustom;
  end;
end;

function TfrmCAD.GetTDButtons: Integer;
begin
  result := 0;
  if cbcbYes.Checked then
    result := result or TD_BUTTON_YES;
  if cbcbNo.Checked then
    result := result or TD_BUTTON_NO;
  if cbcbOK.Checked then
    result := result or TD_BUTTON_OK;
  if cbcbCancel.Checked then
    result := result or TD_BUTTON_CANCEL;
  if cbcbRetry.Checked then
    result := result or TD_BUTTON_RETRY;
  if cbcbClose.Checked then
    result := result or TD_BUTTON_CLOSE;
end;

function TfrmCAD.GetTDIcon: Integer;
begin
  case TTaskDialogIcon(rgMainIcon.ItemIndex) of
    tdiWarning: result := TD_ICON_WARNING;
    tdiError: result := TD_ICON_ERROR;
    tdiInformation: result := TD_ICON_INFORMATION;
    tdiConfirmation: result := TD_ICON_QUESTION;
    tdiCustom: result := TD_ICON_SHIELD_OK;
    //tdiShield
  else
    result := 0;
  end;
end;

procedure TfrmCAD.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0: ActiveControl := eTitle;
    1: ActiveControl := Memo1;
  end;
end;

procedure TfrmCAD.rgMainIconClick(Sender: TObject);
var
  lIconId: PChar;
  lIconType: TTaskDialogIcon;
  LIsCustomVistaShield: Boolean;
begin
  lIconType := TTaskDialogIcon(rgMainIcon.ItemIndex);
  if lIconType = tdiCustom then
    lIconType := tdiShield;
  if (lIconType = tdiShield) and (Win32MajorVersion < 6) then
  begin
    iMainIcon.Picture.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD');
    iMainIcon.Transparent := True;
  end
  else
  begin
    lIconId := GetIcon(lIconType, LIsCustomVistaShield);
    if IsVista then
    begin
      if lIconId <> nil then
      begin
        iMainIcon.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
      end
      else
      begin
        iMainIcon.Picture.Assign(nil);
      end;
    end
    else
    begin
      iMainIcon.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
    end;
  end;
end;

procedure TfrmCAD.rgMsgDlgTypeClick(Sender: TObject);
var
  lIconId: PChar;
  lIconType: TTaskDialogIcon;
  LIsCustomVistaShield: Boolean;
begin
  lIconType := TTaskDialogIcon(rgMsgDlgType.ItemIndex + 1);
  lIconId := GetIcon(lIconType, LIsCustomVistaShield);
  if IsVista then
  begin
    if lIconId <> nil then
      Image1.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR)
    else
      Image1.Picture.Assign(nil);
  end
  else
  begin
    Image1.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
  end;
end;

procedure TfrmCAD.rgVerifyMessageClick(Sender: TObject);
var
  lIconId: PChar;
  lIconType: TTaskDialogIcon;
  LIsCustomVistaShield: Boolean;
begin
  lIconType := TTaskDialogIcon(rgVerifyMessage.ItemIndex);
  if lIconType = tdiCustom then
    lIconType := tdiShield;
  if (lIconType = tdiShield) and (Win32MajorVersion < 6) then
  begin
    iVerifyMessage.Picture.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD');
    iVerifyMessage.Transparent := True;
  end
  else
  begin
    lIconId := GetIcon(lIconType, LIsCustomVistaShield);
    if IsVista then
    begin
      if lIconId <> nil then
        iVerifyMessage.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR)
      else
        iVerifyMessage.Picture.Assign(nil);
    end
    else
    begin
      iVerifyMessage.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
    end;
  end;
end;

procedure TfrmCAD.ValidateMethod;
begin
  // TaskDialog call is invalid when these options are used
//  rgMethodCalled.Controls[1].Enabled := not (cbcbAbort.Checked or cbcbIgnore.Checked or
//    cbcbAll.Checked or cbcbNoToAll.Checked or cbcbYesToAll.Checked or cbcbHelp.Checked);
//  if not rgMethodCalled.Controls[1].Enabled then
//    rgMethodCalled.ItemIndex := 0;
end;

end.
