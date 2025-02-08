unit pLMDCEBase;
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

LMD-Tools Component Editors - Base Classes (RM)
-----------------------------------------------
Introduces base Component and FormEditor classes

Changes
-------
Release 9.0 (April 2008)
 - Initial Release

###############################################################################}

interface
uses
  Menus,  // PrepareItem
  DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  Classes, SysUtils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, ComCtrls,
  LMDClass;

const
  IDS_THEMEMODE = 'ThemeMode';
  IDS_UPDATECTLXP = 'Form: Update ThemeMode property';

type
  // Use this one, when doubleclick should open a dialog
  {*********************** TLMDComponentEditor ********************************}
  TLMDComponentEditor = class(TComponentEditor)
  private
    FPropName : string;  // required for OpenEditor
    FProp: IProperty;    // found property Editor
    procedure int_GetPropEditProc(const Prop: IProperty);
  protected
    procedure HandleThemeModeEvent(Sender: TObject);
    procedure AddThemeModeItems(AItem: IMenuItem);
    procedure OpenEditorDlg(const aPropName: String);  // use this method for dialog based properties
  public
    procedure PrepareItem(Index:Integer; const AItem: IMenuItem); override;
  end;

  // Default component editor
  {*********************** TLMDComponentEditor ********************************}
  TLMDDefaultEditor = class(TLMDComponentEditor, IDefaultEditor)
  public
    FFirst,
    FBest: IProperty;
    FContinue: Boolean;
    procedure CheckEdit(const Prop: IProperty);
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); virtual;
  public
    procedure Edit; override;
  end;

  // TLMDFormEditor and helper classes
  // allows "dynamic" FormEditor. Higher product SKUs (like LMD-Tools, ElPack
  // etc. can add on demand additional functionality by registering an additional
  // TLMDBaseFormEditorObject descendant via the
  {************************** TLMDFormEditor **********************************}
  TLMDBaseFormEditorObject = class
  protected
    Designer : IDesigner;
    Form : TCustomForm;
  public
    function GetName: String; virtual; abstract;
    procedure PrepareItem(const AItem: IMenuItem); virtual; abstract;
    procedure HandleClickEvent(Sender: TObject); virtual; abstract;
  end;

  TLMDFormEditorTemplateObject = class (TLMDBaseFormEditorObject)
  public
    function GetName: String; override;
    procedure PrepareItem(const AItem: IMenuItem); override;
    procedure HandleClickEvent(Sender: TObject); override;
  end;

  TLMDFormEditorControlsObject = class (TLMDBaseFormEditorObject)
  public
    function GetName: String; override;
    procedure PrepareItem(const AItem: IMenuItem); override;
    procedure HandleClickEvent(Sender: TObject); override;
  end;

  TLMDFormEditor = class (TLMDDefaultEditor)
  protected
    function  GetForm: TCustomForm;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer):string; override;
    procedure PrepareItem(Index:Integer; const AItem: IMenuItem); override;
  end;

  // register additional TLMDBaseFormEditorObject descendant for
  // TLMDFormEditor (advanced editor for TForm controls)
  procedure LMDRegisterFormEditorObject(aObject : TLMDBaseFormEditorObject);

implementation
//uses

var
  LMDFormEditorObjects : TList;

{------------------------------------------------------------------------------}
procedure LMDRegisterFormEditorObject(aObject : TLMDBaseFormEditorObject);
begin
  LMDFormEditorObjects.Add(aObject);
end;

{ ************************ TLMDComponentEditor ********************************}
{------------------------- protected ------------------------------------------}
procedure TLMDComponentEditor.AddThemeModeItems(aItem: IMenuItem);
var
  i, lThemeMode: Integer;
begin
  if IsPublishedProp(Component, IDS_THEMEMODE) then
    lThemeMode := GetOrdProp(Component, IDS_THEMEMODE)
  else
    lThemeMode := -1;

  with aItem do
    for i := 0 to Ord(High(TLMDThemeMode)) do
      AddItem(GetEnumName(TypeInfo(TLMDThemeMode), Ord(i)), 0, lThemeMode = i, true, HandleThemeModeEvent, i);
end;

{------------------------------------------------------------------------------}
procedure TLMDComponentEditor.HandleThemeModeEvent(Sender: TObject);
begin
 if IsPublishedProp(Component, IDS_THEMEMODE) then
   SetOrdProp (Component, IDS_THEMEMODE, TMenuItem(Sender).MenuIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDComponentEditor.int_GetPropEditProc(const Prop: IProperty);
begin
  if  Assigned(Prop) and SameText(Prop.GetName, self.FPropName) then
    self.FProp := Prop;
end;

{------------------------------------------------------------------------------}
procedure TLMDComponentEditor.OpenEditorDlg(const aPropName: String);
var
  Components: IDesignerSelections;
begin
  FProp := nil;
  FPropName := aPropName;
  Components := TDesignerSelections.Create;
  try
    Components.Add(Component);
    GetComponentProperties(Components, [tkClass], Designer, int_GetPropEditProc);
    if  Assigned(FProp) then
      FProp.Edit;
  finally
    FProp := nil;
    Components := nil;
  end;
end;

{-------------------------- public --------------------------------------------}
procedure TLMDComponentEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  if AItem.Caption = IDS_THEMEMODE then
    AddThemeModeItems(AItem)
  else
    inherited;
end;

{********************* Class TLMDDefaultEditor ******************************* }
{------------------------- protected ------------------------------------------}
procedure TLMDDefaultEditor.CheckEdit(const Prop: IProperty);
begin
  if FContinue then
    EditProperty(Prop, FContinue);
end;

{-------------------------- public --------------------------------------------}
procedure TLMDDefaultEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
  BestName: string;
  MethodProperty: IMethodProperty;

  procedure ReplaceBest;
  begin
    FBest := Prop;
    if FFirst = FBest then
      FFirst := nil;
  end;

begin
  if not Assigned(FFirst) and Supports(Prop, IMethodProperty, MethodProperty) then
    FFirst := Prop;
  PropName := Prop.GetName;
  BestName := '';
  if Assigned(FBest) then
    BestName := FBest.GetName;
  if CompareText(PropName, 'ONCREATE') = 0 then
    ReplaceBest
  else
    if CompareText(BestName, 'ONCREATE') <> 0 then
      if CompareText(PropName, 'ONCHANGE') = 0 then
        ReplaceBest
      else
        if CompareText(BestName, 'ONCHANGE') <> 0 then
          if CompareText(PropName, 'ONCHANGED') = 0 then
            ReplaceBest
          else
            if CompareText(BestName, 'ONCHANGED') <> 0 then
              if CompareText(PropName, 'ONCLICK') = 0 then
                ReplaceBest;
end;

{------------------------------------------------------------------------------}
procedure TLMDDefaultEditor.Edit;
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  FContinue := True;
  Components.Add(Component);
  FFirst := nil;
  FBest := nil;
  try
    GetComponentProperties(Components, tkAny, Designer, CheckEdit);
    if FContinue then
      if Assigned(FBest) then
        FBest.Edit
      else if Assigned(FFirst) then
        FFirst.Edit;
  finally
    FFirst := nil;
    FBest := nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDCEAddMenuItem(aMenuItem: IMenuItem; const aCaption: String;
                                 aIdent: Integer; aHandler: TNotifyEvent; const aBitmapRes : String ='');
begin
  with AMenuItem do
    if aCaption = '-' then
      AddLine
    else
      AddItem(aCaption, 0, false, true, aHandler, aIdent);
end;

{***************** Class TLMDFormEditorTemplateObject**************************}
{-------------------------- public --------------------------------------------}
function TLMDFormEditorTemplateObject.GetName: String;
begin
  result := 'LMD Form-Templates';
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEditorTemplateObject.PrepareItem(const AItem: IMenuItem);
begin
  with AItem do
    AddItem('Main Form', 0, false, true, HandleClickEvent, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEditorTemplateObject.HandleClickEvent(Sender: TObject);
var
  Toolbar: TToolbar;
  StatusBar: TStatusBar;
begin
  case TMenuItem(Sender).HelpContext of
    0: begin
         StatusBar := Designer.CreateComponent( TStatusBar, Form, 10, 10, 0, 0 ) as TStatusBar;
         StatusBar.Parent := Form;
         Toolbar := Designer.CreateComponent( TToolbar, Form, 10, 10, 0, 0 ) as TToolbar;
         Toolbar.Parent := Form;
       end;
  else
    exit;
  end;
  if Designer <> nil then
    Designer.Modified;
end;

{***************** Class TLMDFormEditorControlsObject *************************}
{-------------------------- public --------------------------------------------}
function TLMDFormEditorControlsObject.GetName: String;
begin
  result := 'Add VCL Control';
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEditorControlsObject.PrepareItem(const AItem: IMenuItem);
begin
  with AItem do
    begin
      AddItem('ToolBar', 0, false, true, HandleClickEvent, 0);
      AddItem('StatusBar', 0, false, true, HandleClickEvent, 1);
      AddItem('Panel', 0, false, true, HandleClickEvent, 2);
      AddItem('MainMenu', 0, false, true, HandleClickEvent, 3);
      AddItem('PopUpMenu', 0, false, true, HandleClickEvent, 4);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEditorControlsObject.HandleClickEvent(Sender: TObject);
begin
  case TMenuItem(Sender).HelpContext of
    0: Designer.CreateComponent( TToolbar, Form, 10, 10, 0, 0 );
    1: Designer.CreateComponent( TStatusBar, Form, 10, 10, 0, 0 );
    2: Designer.CreateComponent( TPanel, Form, 10, 10, 168, 100 );
    3: Designer.CreateComponent( TMainMenu, Form, 228, 120, 24, 24 );
    4: Designer.CreateComponent( TPopupMenu, Form, 256, 120, 24, 24 );
  end;
  if Designer <> nil then
    Designer.Modified;
end;

{***************** Class TLMDFormEditor ***************************************}
{-------------------------- private -------------------------------------------}
function TLMDFormEditor.GetForm: TCustomForm;
begin
  Result := Component as TForm;
end;

{-------------------------- public --------------------------------------------}
function TLMDFormEditor.GetVerbCount: Integer;
begin
  Result := LMDFormEditorObjects.Count;
end;

{------------------------------------------------------------------------------}
function TLMDFormEditor.GetVerb( Index: Integer ): string;
begin
  if Index < LMDFormEditorObjects.Count then
    begin
      result := TLMDBaseFormEditorObject(LMDFormEditorObjects[Index]).GetName;
      TLMDBaseFormEditorObject(LMDFormEditorObjects[Index]).Designer := self.Designer;
      TLMDBaseFormEditorObject(LMDFormEditorObjects[Index]).Form := self.GetForm;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  inherited;
  if Index < LMDFormEditorObjects.Count then
    TLMDBaseFormEditorObject(LMDFormEditorObjects[Index]).PrepareItem(AItem);
end;

initialization
  LMDFormEditorObjects := TList.Create;
  // check registry setting here
  LMDRegisterFormEditorObject(TLMDFormEditorTemplateObject.Create);
  LMDRegisterFormEditorObject(TLMDFormEditorControlsObject.Create);

finalization
  if LMDFormEditorObjects<>nil then
    begin
      while LMDFormEditorObjects.Count>0 do
        begin
          TLMDFormEditorControlsObject(LMDFormEditorObjects[LMDFormEditorObjects.Count-1]).Free;
          LMDFormEditorObjects.Delete(LMDFormEditorObjects.Count-1);
        end;
      LMDFormEditorObjects.Free;
      LMDFormEditorObjects := nil;
    end;

end.

