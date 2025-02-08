unit pLMDFxAniListDesigner;
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

pLMDFxAniListDesigner unit (RM, AH)
-----------------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, DesignWindows,
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Buttons,
  SysUtils,
  LMDFxAnimation;

type

{ TLMDFxAniListDesignerForm - designer form }

  TLMDFxAniListDesignerForm = class(TDesignWindow)
  private
    FAnimationList: TLMDFxAnimationList;
    FSelected: TLMDFxAnimation;

    FList: TListBox;
    FToolbar: TPanel;
    FAddButton: TSpeedButton;
    FDeleteButton: TSpeedButton;
    FDesigner: IDesigner;
    procedure BuildAniList;
    procedure DoActivate(Sender: TObject);
    procedure DoFormClose(Sender: TObject; var Action: TCloseAction);
    procedure DoAddButtonClick(Sender: TObject);
    procedure DoDeleteButtonClick(Sender: TObject);
    procedure DoListClick(Sender: TObject);
    procedure DoListDblClick(Sender: TObject);
    procedure DoItemChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function UniqueName(Component: TComponent): String; override;
  public
    constructor CreateDesigner; virtual;
    destructor Destroy; override;
  end;

  TLMDFxAnimationListEditor = class(TDefaultEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb (Index: Integer); override;
    function GetVerb (Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

procedure ShowAniListDesignerForm(const AAnimationList: TLMDFxAnimationList;
  const ADesigner: IDesigner);

implementation

uses
  LMDFxAniDesignerForm;

{ ---------------------------------------------------------------------------- }
procedure ShowAniListDesignerForm(const AAnimationList: TLMDFxAnimationList;
  const ADesigner: IDesigner);
var
  i: integer;
  Form: TCustomForm;
  DesignerForm: TLMDFxAniListDesignerForm;
begin
  { Search opened }
  for i := 0 to Screen.FormCount - 1 do
  begin
    Form := Screen.Forms[i];
    if Form is TLMDFxAniListDesignerForm then
      if TLMDFxAniListDesignerForm(Form).FAnimationList = AAnimationList then
      begin
        Form.Show;
        if Form.WindowState = wsMinimized then
          Form.WindowState := wsNormal;
        Exit;
      end;
  end;
  { Show }
  DesignerForm := TLMDFxAniListDesignerForm.CreateDesigner;
  try
    DesignerForm.FDesigner := ADesigner;
    DesignerForm.FSelected := nil;
    DesignerForm.FAnimationList := AAnimationList;
    DesignerForm.Caption := 'Editing component -' + AAnimationList.Name;

    DesignerForm.BuildAniList;

    DesignerForm.Show;
  except
    DesignerForm.Free;
    raise;
  end;
end;

{ ************************ class TLMDFxAnimationListEditor ******************* }
{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationListEditor.Edit;
begin
  if Assigned(Component) then
    ShowAniListDesignerForm(Component as TLMDFxAnimationList, Designer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationListEditor.ExecuteVerb (Index: Integer);
begin
  if Index = 0 then
    Edit;
end;
{ ---------------------------------------------------------------------------- }
function TLMDFxAnimationListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxAnimationListEditor.GetVerb (Index: Integer): String;
begin
  if Index = 0 then
    Result := 'Edit...'
  else
    Result := '';
end;

{ ************************ class TLMDFxAniListDesignerForm ******************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxAniListDesignerForm.BuildAniList;
var
  i: integer;
begin
  { Build AniCombo }
  FList.Items.Clear;
  for i := 0 to FAnimationList.Count - 1 do
    begin
      FAnimationList[i].OnInternalChange := DoItemChange;
      FList.Items.Add(FAnimationList[i].Name);
    end;
end;

{ Event handlers }
{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDesigner <> nil then FDesigner.Modified;
  Action := caFree;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoActivate(Sender: TObject);
begin
  { Activate}
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoAddButtonClick(Sender: TObject);
begin
  FSelected := TLMDFxAnimation.Create(FAnimationList.Owner);
  FSelected.Name := UniqueName(FSelected);

  FAnimationList.Add(FSelected);
  BuildAniList;
  FList.ItemIndex := FList.Items.Count - 1;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoDeleteButtonClick(Sender: TObject);
var
  SaveIndex: integer;
begin
  if FSelected = nil then Exit;

  SaveIndex := FList.ItemIndex;

  FAnimationList.Remove(FSelected);
  FSelected.Free;
  FSelected := nil;

  BuildAniList;

  if SaveIndex > 0 then
    FList.ItemIndex := SaveIndex - 1
  else
    FList.ItemIndex := 0;

  if (FAnimationList.Count > 0) and (FList.ItemIndex >= 0) then
    FSelected := FAnimationList[FList.ItemIndex];
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoListClick(Sender: TObject);
begin
  FSelected := FAnimationList.Items[FList.ItemIndex];

  FDesigner.SelectComponent(FSelected);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoListDblClick(Sender: TObject);
begin
  FSelected := FAnimationList.Items[FList.ItemIndex];

  LMDFxShowDesignerForm(FSelected);

  FDesigner.SelectComponent(nil);
  FDesigner.SelectComponent(FSelected);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxAniListDesignerForm.DoItemChange(Sender: TObject);
var
  SaveIndex: integer;
begin
  SaveIndex := FList.ItemIndex;;
  BuildAniList;
  FList.ItemIndex := SaveIndex;
end;

{ VCL Designer Routines }
{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxAniListDesignerForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAnimationList) then
    Free;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxAniListDesignerForm.UniqueName(Component: TComponent): String;
begin
  if FDesigner <> nil then
    Result := FDesigner.UniqueName(Component.ClassName)
  else
    Result := Component.ClassName + IntToStr(Random(100));
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxAniListDesignerForm.CreateDesigner;
begin
  inherited CreateNew(Application);
  Position := poScreenCenter;
  BorderStyle := bsSizeable;
  Width := 220;
  Height := 300;

  OnActivate := DoActivate;
  OnClose := DoFormClose;

  { Create controls }
  FToolbar := TPanel.Create(Self);
  with FToolbar do
    begin
      Parent := Self;
      Visible := true;
      Align := alTop;
      Height := 30;
      BorderWidth := 4;

      FAddButton := TSpeedButton.Create(Self);
      with FAddButton do
        begin
          Parent := FToolBar;
          Align := alLeft;
          Width := 60;
          Caption := 'Insert';

          OnClick := DoAddButtonClick;
        end;

      FDeleteButton := TSpeedButton.Create(Self);
      with FDeleteButton do
        begin
          Parent := FToolBar;
          Align := alLeft;
          Width := 60;
          Caption := 'Delete';

          OnClick := DoDeleteButtonClick;
        end;
    end;

  FList := TListBox.Create(Self);
  with FList do
    begin
      Parent := Self;
      Visible := true;
      Align := alClient;

      OnClick := DoListClick;
      OnDblClick := DoListDblClick;
    end;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxAniListDesignerForm.Destroy;
begin
  inherited Destroy;
end;

end.
