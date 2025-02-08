{
//
// Components : TwwNavigatorButtonsEditor, TwwNavigatorEditor
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}

// 10/5/98 - Added so delphi knows that a change took place -ksw (10/5/98)


unit wwDBNavEdt;
{$i wwIfDef.pas}

interface

uses Classes,
       {$ifdef wwdelphi6up}
       designintf, designeditors,
       {$else}
       dsgnintf,
       {$endif}
  wwDBNavigator, Forms, Dialogs, SysUtils,
  wwCommon, wwCollection, wwCollectionEditor, Controls, Graphics,
  wwprpedt;

const
  WW_ADD_BUTTON = 0;
  WW_ADD_INFOPOWERDIALOGS = 1;
  WW_SELECT_ALL = 2;
  WW_VERB_COUNT = 3;

type
  TwwDBNavigatorEditorEvents = class
    class procedure AddInfoPowerDialogsClick(Sender: TObject);
  end;

  TwwDBNavigatorButtonsEditor = class(TPropertyEditor)
  public
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure CollectionCustomize(EditorForm: TwwCollectionEditorForm);
  end;

  TwwNavButtonEditor = class(TComponentEditor)
  public
    constructor Create(AComponent: TComponent;
     ADesigner:
        {$ifdef wwDelphi6Up} IDesigner);
        {$else} {$ifdef wwDelphi4Up} IFormDesigner); {$else} TFormDesigner); {$endif}
        {$endif}
        override;
    destructor Destroy; override;
  end;

  TwwDBNavigatorEditor = class(TwwComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure CollectionCustomize(EditorForm: TwwCollectionEditorForm);
  end;

implementation

{$r wwDBNavEdit.res}

class procedure TwwDBNavigatorEditorEvents.AddInfoPowerDialogsClick(Sender: TObject);
var wwNavButtons: IwwNavButtons;
begin
  with (GetParentForm(Sender as TControl) as TwwCollectionEditorForm) do
  begin
    Collection.QueryInterface(IwwNavButtons, wwNavButtons);
    wwNavButtons.AddInfoPowerDialogs;
    Reload;
  end;
end;

procedure CustomizeCollection(EditorForm: TwwCollectionEditorForm; AddInfoPowerDialogsClick: TNotifyEvent);
var ABitmap: TBitmap;
begin
  with EditorForm do
  begin
    UserButtonDivider.Visible := True;
    UserButton1.Visible := True;
    UserButton1.Caption := 'Add InfoPower Dialogs';
    UserButton1.Hint := UserButton1.Caption;
    UserButton1.OnClick := AddInfoPowerDialogsClick;

    ABitmap := TBitmap.Create;
    ABitmap.LoadFromResourceName(HINSTANCE, 'WW_DBN_ADDIPDIALOGS');
    EnabledImageList.Add(ABitmap, nil);
    ABitmap.Free;    
  end;
end;

function TwwDBNavigatorButtonsEditor.GetValue: string;
begin
  result := '(TwwNavButtons)';
end;

function TwwDBNavigatorButtonsEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog];
end;

procedure TwwDBNavigatorButtonsEditor.CollectionCustomize(EditorForm: TwwCollectionEditorForm);
begin
  CustomizeCollection(EditorForm, TwwDBNavigatorEditorEvents.AddInfoPowerDialogsClick);
end;

procedure TwwDBNavigatorButtonsEditor.Edit;
begin
  wwExecuteCollectionEditor('Editing ' + (GetComponent(0) as TComponent).Name + '.Buttons',
    Designer, (GetComponent(0) as TwwDBNavigator).Buttons as IwwCollection,
    CollectionCustomize);
end;

procedure TwwDBNavigatorEditor.CollectionCustomize(EditorForm: TwwCollectionEditorForm);
begin
  CustomizeCollection(EditorForm, TwwDBNavigatorEditorEvents.AddInfoPowerDialogsClick);
end;

procedure TwwDBNavigatorEditor.Edit;
begin
  wwExecuteCollectionEditor('Editing ' + Component.Name + '.Buttons',
    Designer, (Component as TwwDBNavigator).Buttons as IwwCollection,
    CollectionCustomize);
end;

procedure TwwDBNavigatorEditor.ExecuteVerb(Index: Integer);
var
    {$ifdef wwDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}
    i: Integer;
begin
  case Index of
    WW_ADD_BUTTON: (Component as TwwDBNavigator).Buttons.Add(nbsCustom, nil);
    WW_ADD_INFOPOWERDIALOGS: (Component as TwwDBNavigator).Buttons.AddInfoPowerDialogs;
    WW_SELECT_ALL: begin
      {$ifndef wwDelphi5Up}
      Selections := TComponentList.Create;
      {$else}
      Selections := CreateSelectionList;
      {$endif}
      for i := 0 to (Component as TwwDBNavigator).Buttons.Count - 1 do
        {$ifdef wwDelphi5}
        Selections.Add(MakeIPersistent((Component as TwwDBNavigator).Buttons[i]));
        {$else}
        Selections.Add((Component as TwwDBNavigator).Buttons[i]);
        {$endif}
      Designer.SetSelections(Selections);
      {$ifndef wwDelphi5Up}
       Selections.Free;
       {$endif}
    end;
    else inherited ExecuteVerb(Index)
  end;
  // Added so delphi knows that a change took place -ksw (10/5/98)
  if (Index = WW_ADD_BUTTON) or (Index = WW_ADD_INFOPOWERDIALOGS) then
    Designer.Modified;
end;

function TwwDBNavigatorEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    WW_ADD_BUTTON: result := 'Add &Button';
    WW_ADD_INFOPOWERDIALOGS: result := 'Add &InfoPower Dialogs';
    WW_SELECT_ALL: result := '&Select All Buttons';
    else result:= inherited GetVerb(Index);
  end;
end;

function TwwDBNavigatorEditor.GetVerbCount: Integer;
begin
  result := (inherited GetVerbCount) + WW_VERB_COUNT;
end;

constructor TwwNavButtonEditor.Create(AComponent: TComponent;
     ADesigner:
        {$ifdef wwDelphi6Up} IDesigner);
        {$else} {$ifdef wwDelphi4Up} IFormDesigner); {$else} TFormDesigner); {$endif}
        {$endif}
// ADesigner: {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif});
begin
  inherited;
  if wwCollectionEditorForm <> nil then
    wwCollectionEditorForm.SetSelection(AComponent, True);
end;

destructor TwwNavButtonEditor.Destroy;
begin
  if wwCollectionEditorForm <> nil then
    wwCollectionEditorForm.SetSelection(Component, False);
  inherited;
end;

end.
