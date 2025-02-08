unit ElTreeStdEditors;
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

ElTreeStdEditors unit
---------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

08 February, 2008 (EK)
 - Validation support added;

###############################################################################}

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  Types,
  ImgList,
  SysUtils,
  Classes,

  LMDProcs,
  LMDVldBase,

  ElEdits,
  ElTree,
  ElHeader,
  ElTreeInplaceEditors;

type
    TElTreeInplaceEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc : TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetStressShortCut(Value: TShortCut);
      function GetStressShortCut: TShortCut;
      function GetValidationMsgString: string;
      function GetValidator: TLMDValidationEntity;
      procedure SetValidationMsgString(const Value: string);
      procedure SetValidator(const Value: TLMDValidationEntity);
      function GetOnValidationError: TLMDValidationErrorEvent;
      procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    protected
//      FEditor: TElEdit;
      procedure AdjustBounds; override;
      function GetEditor: TElEdit;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure TriggerValidateResult(var InputValid: boolean); override;
      property Editor: TElEdit read GetEditor;
    published
      property Font;
      property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
      //Validation support, Feb.2008, EK
      property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
      property Validator: TLMDValidationEntity read GetValidator write SetValidator;
      property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
      //End of Validation support
    end;

    TElTreeInplaceMemo = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetHeight(value: Integer);
      function GetHeight: Integer;
    protected
//      FEditor: TMemo;
      procedure AdjustBounds; override;
      function GetEditor: TMemo;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TMemo read GetEditor;
    published
      property Height: integer read GetHeight write SetHeight stored True;
      property Font: TFont read FFont write SetFont stored True;
    end;

    TElTreeInplaceCheckBox = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
//      FEditor: TCheckBox;
      procedure AdjustBounds; override;
      function GetEditor: TCheckBox;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TCheckBox read GetEditor;
    published
      property Font: TFont read FFont write SetFont stored True;
    end;

implementation

uses
  LMDSysIn;

type
  THackElTree = class(TElTreeAncestor);
  TElInpEdit = class(TElEdit)
  protected
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyPress(var Key: Char); override;
  end;

  TElInpMemo = class(TMemo)
  protected
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyPress(var Key: Char); override;
  end;

  TElInpCheckBox = class(TCheckBox)
  protected
    procedure KeyPress(var Key: Char); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    end;
  procedure TElInpMemo.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElInpMemo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS; // we want the RETURN key
end;

procedure TElInpEdit.WMGetDlgCode(var Message: TWMGetDlgCode); // CNS
begin
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS; // we want the RETURN key
end;

procedure TElInpEdit.KeyPress(var Key: Char); // CNS
begin                                   // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElTreeInplaceEdit.TriggerAfterOperation(var Accepted : boolean; var
    DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);

begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
//  if Assigned(FFont) then
//    FEditor.Font := FFont;
end;

procedure TElTreeInplaceEdit.TriggerValidateResult(var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

procedure TElTreeInplaceEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_GETDLGCODE then
  begin
    inherited;
    Message.Result := Message.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
  end
  else
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
    begin
      if KeyDataToShiftState(KeyData) = [] then
      begin
        if CharCode = VK_RETURN then
        begin
          InputValid := true;
          FEditing := false;
          TriggerValidateResult(InputValid);
          FEditing := true;
          if InputValid then
          begin
            CompleteOperation(true);
            CharCode := 0;
            exit;
          end
          else
            Editor.SetFocus;
          CharCode := 0;
        end
        else
        if CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          CharCode := 0;
          exit;
        end;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
      (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).FExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
      if Message.Msg <> CM_CANCELMODE then
        SendMessage(THackElTree(Tree).View.Handle, CM_EXIT, 0, 0);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElTreeInplaceEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

function TElTreeInplaceEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

constructor TElTreeInplaceEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpEdit.Create(Self);
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.Flat := True;
  Editor.AutoSelect := true;
  FEditor.Visible := false;
  Editor.AutoSize := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  Editor.BorderStyle := bsNone;
  Editor.BorderSides := [];
  FTypes := [sftText];
end;

destructor TElTreeInplaceEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceMemo.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceMemo.TriggerAfterOperation(var Accepted : boolean; var
    DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceMemo.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
//  FEditor.BoundsRect := FCellRect;
end;

function TElTreeInplaceEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

constructor TElTreeInplaceMemo.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpMemo.Create(Self);
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftMemo];
  FEditor.Height := 89;
end;

destructor TElTreeInplaceMemo.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceMemo.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceMemo.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceMemo.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
    if KeyDataToShiftState(KeyData) = [] then
    begin
      if CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        CharCode := 0;
      end
      else
      if CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
      (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).FExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceMemo.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

constructor TElTreeInplaceCheckBox.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpCheckBox.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FDefaultValueAsText := '*';
  FTypes := [sftBool];
end;

destructor TElTreeInplaceCheckBox.Destroy;
begin
  FreeAndNil(FEditor);
  inherited;
end;

procedure TElTreeInplaceCheckBox.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceCheckBox.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceCheckBox.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
    if KeyDataToShiftState(KeyData) = [] then
    begin
      if CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          exit;
        end
        else
          Editor.SetFocus;
        CharCode := 0;
      end
      else
      if CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
      (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).FExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
      begin
        CompleteOperation(false);
        exit;
      end;
    end;
  SaveWndProc(Message);
end;

function TElTreeInplaceCheckBox.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceCheckBox.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
  begin
    if Editor.Checked then
      ValueAsText := FDefaultValueAsText
    else
      ValueAsText := '';
  end;
end;

procedure TElTreeInplaceCheckBox.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Checked := ValueAsText <> '';
end;

procedure TElTreeInplaceCheckBox.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElInpCheckBox.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElInpCheckBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTALLKEYS; // we want the RETURN key
end;

function TElTreeInplaceMemo.GetHeight: Integer;
begin
  if Assigned(FEditor) then
    Result := FEditor.Height
  else
    Result := 0;
end;

procedure TElTreeInplaceMemo.SetHeight(value: Integer);
begin
  if Assigned(FEditor) then
    FEditor.Height := Value;
end;

procedure TElTreeInplaceEdit.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  if HorizontalLines then
    InflateRect(r, 0, 1);
  InflateRect(r, 1, 0);
  if VerticalLines and not IsVistaUp then
    OffsetRect(r, -1, 0);
  if not VerticalLines and IsVistaUp then
    OffsetRect(r, 1, 0);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceEdit.GetEditor: TElEdit;
begin
  Result := FEditor as TElEdit;
end;

function TElTreeInplaceCheckBox.GetEditor: TCheckBox;
begin
  Result := FEditor as TCheckBox;
end;

procedure TElTreeInplaceMemo.AdjustBounds;
var
  P: TPoint;
  W,H, H1 : integer;
  R: TRect;
begin
  P := Point(FCellRect.Left,FCellRect.Top);
  W := FCellRect.Right - FCellRect.Left;
  H := FEditor.Height;
  H1 := FEditor.Height - (FCellRect.Bottom - FCellRect.Top);
  if ((P.Y + H) > self.Tree.Height) and (self.Tree.Height > H) then
    Dec(P.Y, H1);
  R := Rect(P.X - 2, P.Y - 1, W + 2, H);
  if IsVistaUp then
    begin
      if VerticalLines then
        Dec(R.Right, 1);
      OffsetRect(R, 1, 0);
    end
  else
    if not VerticalLines then
      Inc(R.Right);
  FEditor.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
end;

function TElTreeInplaceMemo.GetEditor: TMemo;
begin
  Result := FEditor as TMemo;
end;

procedure TElTreeInplaceCheckBox.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  InflateRect(r, 1, 1);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

end.
