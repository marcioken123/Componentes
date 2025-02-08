unit ElTreeColorCombo;
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

ElTreeColorCombo unit
---------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

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
  Types,
  Dialogs,

  LMDProcs,

  ElStyleMan,
  ElTree,
  ElCombos,
  ElTreeInplaceEditors,
  ElHeader,
  ElClrCmb;

type
  THackTreeColorCombo = class (TCustomElComboBox);
  THackInplaceColorCombo = class(TElColorCombo)
  protected
    procedure ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc:  Pointer); override;
  end;

  TElTreeInplaceColorCombo = class(TElTreeInplaceEditor)
  private
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message : TMessage);
    procedure SetOptions(Value: TColorComboOptions);
    function GetOptions: TColorComboOptions;
    function GetDialogOptions: TColorDialogOptions;
    procedure SetDialogOptions(const Value: TColorDialogOptions);
    procedure SetShowGripper(Value: Boolean);
    function GetShowGripper: Boolean;
  protected
    FInitiallyDropped : boolean;
    FIgnoreKillFocus  : boolean;
    procedure AdjustBounds; override;
    function GetEditor: TElColorCombo;
    procedure SetEditorParent; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure ColorDialogShow(Sender : TObject; AfterShow : boolean);
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    function GetStyleManager: TElStyleManager;
    procedure SetStyleManager(Value: TElStyleManager);
    function GetStyleName: string;
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Editor: TElColorCombo read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped;
    property Options: TColorComboOptions read GetOptions write SetOptions;
    property DialogOptions: TColorDialogOptions read GetDialogOptions write SetDialogOptions;
    property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
  end;

implementation

constructor TElTreeInplaceColorCombo.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := THackInplaceColorCombo.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  Editor.OnColorDialogShow := ColorDialogShow;
  //FEditor.ListWindowProc := ListWndProc;
  //FEditor.EditWindowProc := EditWndProc;
  FTypes := [sftEnum];
end;

destructor TElTreeInplaceColorCombo.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceColorCombo.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceColorCombo.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  if InitiallyDropped then
    Editor.DropDown;
//    FEditor.Perform(CB_SHOWDROPDOWN, 1, 0);
end;

procedure TElTreeInplaceColorCombo.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceColorCombo.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
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
        end;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus))then
  begin
    if FEditing then
      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      EndEditWithInputChecked;
    end
    else
      CompleteOperation(false);

  SaveWndProc(Message);
end;

function TElTreeInplaceColorCombo.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceColorCombo.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := ColorToString(Editor.SelectedColor);
end;

procedure TElTreeInplaceColorCombo.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
    Editor.SelectedColor := StringToColor(ValueAsText);
end;

procedure TElTreeInplaceColorCombo.ColorDialogShow(Sender : TObject; AfterShow : boolean);
begin
  FIgnoreKillFocus := not AfterShow;
end;

function TElTreeInplaceColorCombo.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

procedure TElTreeInplaceColorCombo.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

function TElTreeInplaceColorCombo.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceColorCombo.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure THackInplaceColorCombo.ComboWndProc(var Message: TMessage; ComboWnd:
    THandle; ComboProc:  Pointer);
var
  InputValid : boolean;
begin
  with TElTreeInplaceColorCombo(Owner) do
  begin
    if Message.Msg = WM_KEYDOWN then
    begin
      with TWMKey(Message) do
      if KeyDataToShiftState(KeyData) = [] then
      begin
        if CharCode = VK_RETURN then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
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
    if (Message.Msg = WM_KILLFOCUS) then
    begin
      if FEditing and
        (not THackTreeColorCombo(FEditor).FIgnoreFocus) then
        PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end
    else
    if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
  end;
  inherited;
end;

function TElTreeInplaceColorCombo.GetDialogOptions: TColorDialogOptions;
begin
  Result := Editor.DialogOptions
end;

function TElTreeInplaceColorCombo.GetOptions: TColorComboOptions;
begin
  Result := Editor.Options
end;

procedure TElTreeInplaceColorCombo.SetDialogOptions(
  const Value: TColorDialogOptions);
begin
  Editor.DialogOptions := Value;
end;

procedure TElTreeInplaceColorCombo.SetOptions(Value: TColorComboOptions);
begin
  Editor.Options := Value;
end;

function TElTreeInplaceColorCombo.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

procedure TElTreeInplaceColorCombo.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;

procedure TElTreeInplaceColorCombo.AdjustBounds;
var
  r: TRect;
begin
  Editor.AutoSize := False;
  r := FCellRect;
  InflateRect(r, 1, 1);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceColorCombo.GetEditor: TElColorCombo;
begin
  Result := FEditor as TElColorCombo;
end;

end.
