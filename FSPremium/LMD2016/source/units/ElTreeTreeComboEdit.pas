unit ElTreeTreeComboEdit;
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

ElTreeTreeComboEdit unit
------------------------


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
  Controls,
  Forms,
  Graphics,
  SysUtils,
  Classes,
  ImgList,
  Types,

  LMDProcs,
  LMDVldBase,

  ElStyleMan,
  ElTree,
  ElHeader,
  ElTreeCombo,
  ElTreeInplaceEditors;

type

  TElTreeInplaceTreeComboEdit = class(TElTreeInplaceEditor)
  private
    FTreeFont: TFont;
    SaveWndProc: TWndMethod;
    SaveTreeWndProc : TWndMethod;
    procedure EditorWndProc(var Message : TMessage);
    procedure TreeWndProc(var Message : TMessage);
    procedure SetItems_FTree(Value: TElTreeItems);
    function GetItems_FTree: TElTreeItems;
    procedure SetFont_FTree(Value: TFont);
    function GetShowImages: Boolean;
    procedure SetShowImages(Value: Boolean);
    function GetImages_FTree: TCustomImageList;
    procedure SetImages_FTree(Value: TCustomImageList);
    function GetTreeImages2: TCustomImageList;
    procedure SetTreeImages2(Value: TCustomImageList);
    procedure SetShowGripper(Value: Boolean);
    function GetShowGripper: Boolean;
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    procedure AdjustBounds; override;
    function GetEditor: TElTreeCombo;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    procedure SetEditorParent; override;
    procedure TreeFontChange(Sender: TObject);
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid: boolean); override;
    property Editor: TElTreeCombo read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property Items: TElTreeItems read GetItems_FTree write SetItems_FTree;
//    property Items: TElTreeItems read FTreeItems write FTreeItems;
    property Font;
    property TreeFont: TFont read FTreeFont write SetFont_FTree;
    property ShowImages: Boolean read GetShowImages write SetShowImages;
    property Images: TCustomImageList read GetImages_FTree write SetImages_FTree;
    property Images2: TCustomImageList read GetTreeImages2 write SetTreeImages2;
    property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

implementation

constructor TElTreeInplaceTreeComboEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElTreeCombo.Create(Self);
  FEditor.Visible := false;
  Editor.HandleDialogKeys := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  SaveTreeWndProc := Editor.GetTree.WindowProc;
  Editor.GetTree.WindowProc := TreeWndProc;
  Editor.Ctl3D := false;
  FTypes := [sftText];
  FTreeFont := TFont.Create;
  FTreeFont.OnChange := TreeFontChange;
end;

destructor TElTreeInplaceTreeComboEdit.Destroy;
begin
  FTreeFont.Free;
  Editor.GetTree.WindowProc := SaveTreeWndProc;
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceTreeComboEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceTreeComboEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceTreeComboEdit.TreeWndProc(var Message : TMessage);
var
  LHandle: Cardinal;
begin
  if (Message.Msg = WM_KILLFOCUS) then
  begin
    LHandle := TWMKillFocus(Message).FocusedWnd;
    if FEditor.HandleAllocated and (LHandle <> FEditor.Handle) and
       (Editor.GetTree.HandleAllocated) and (LHandle <> Editor.GetTree.Handle) and
       (LHandle <> Editor.GetTree.Parent.Handle) then

    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  end;
  SaveTreeWndProc(Message);
end;

procedure TElTreeInplaceTreeComboEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceTreeComboEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceTreeComboEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
  b          : boolean;
  LControl: TObject;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        b := false;
        if Editor.Dropped then
        begin
          b := true;
          // Dropped := false;
          SaveWndProc(Message);
        end;
        // else
        begin
          InputValid := true;
          FEditing := false;
          TriggerValidateResult(InputValid);
          FEditing := true;
          if InputValid then
          begin
            CompleteOperation(true);
            TWMKey(Message).CharCode := 0;
            exit;
          end
          else
            Editor.SetFocus;
          TWMKey(Message).CharCode := 0;
          if b then exit;
        end;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = CM_CANCELMODE) then
  begin
    LControl := TObject(Pointer(Message.lParam));
    if (Message.lParam = 0) or
       ((TControl(LControl).Parent <> Editor) and
       (TControl(LControl).Parent <> Editor.GetTree) and
       (LControl <> Editor) and
       (LControl <> Editor.GetTree)) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  end
  else
  if (Message.Msg = WM_KILLFOCUS) then
  begin
    if (Editor.GetTree.HandleAllocated) and
       (TWMKillFocus(Message).FocusedWnd <> Editor.GetTree.Handle) and
       (TWMKillFocus(Message).FocusedWnd <> FEditor.{GetTree.Parent.}Handle) then
       if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  end;
  SaveWndProc(Message);
end;

function TElTreeInplaceTreeComboEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceTreeComboEdit.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceTreeComboEdit.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

procedure TElTreeInplaceTreeComboEdit.TriggerValidateResult(
  var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

procedure TElTreeInplaceTreeComboEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceTreeComboEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceTreeComboEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceTreeComboEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceTreeComboEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceTreeComboEdit.GetImages_FTree: TCustomImageList;
begin
  Result := Editor.Images;
end;

function TElTreeInplaceTreeComboEdit.GetItems_FTree: TElTreeItems;
begin
  Result := Editor.GetTree.Items;
end;

function TElTreeInplaceTreeComboEdit.GetShowImages: Boolean;
begin
  Result := Editor.ShowImages;
end;

function TElTreeInplaceTreeComboEdit.GetTreeImages2: TCustomImageList;
begin
  Result := Editor.Images2;
end;

procedure TElTreeInplaceTreeComboEdit.SetFont_FTree(Value: TFont);
begin
  if FTreeFont <> Value then
  begin
    FTreeFont.Assign(Value);
  end;
end;

procedure TElTreeInplaceTreeComboEdit.SetImages_FTree(Value: TCustomImageList);
begin
  Editor.Images := Value;
end;

procedure TElTreeInplaceTreeComboEdit.SetItems_FTree(Value: TElTreeItems);
begin
  if Assigned(Value) then
    Editor.GetTree.Items := Value;
end;

procedure TElTreeInplaceTreeComboEdit.SetShowImages(Value: Boolean);
begin
  Editor.ShowImages := Value;
end;

procedure TElTreeInplaceTreeComboEdit.SetTreeImages2(Value: TCustomImageList);
begin
  Editor.Images2 := Value;
end;

procedure TElTreeInplaceTreeComboEdit.TreeFontChange(Sender: TObject);
begin
  if Assigned(FEditor) then
    Editor.TreeFont := FTreeFont;
end;

function TElTreeInplaceTreeComboEdit.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

procedure TElTreeInplaceTreeComboEdit.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;

procedure TElTreeInplaceTreeComboEdit.AdjustBounds;
var
  r: TRect;
begin
  Editor.AutoSize := False;
  r := FCellRect;
  InflateRect(r, 1, 1);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceTreeComboEdit.GetEditor: TElTreeCombo;
begin
  Result := FEditor as TElTreeCombo;
end;

function TElTreeInplaceTreeComboEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceTreeComboEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceTreeComboEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceTreeComboEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceTreeComboEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceTreeComboEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
