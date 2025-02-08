unit pLMDElPE;
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

pLMDElPE unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, Graphics, Controls, TypInfo, Dialogs, ImgList,
  ActnList, Menus,
  ColnEdit, DesignEditors, VCLEditors, DesignWindows, DsnConst, DesignIntf,
  LMDTypes,
  ElPgCtl;

type

  {******************** TElActivePageProperty *********************************}
  TElActivePageProperty = class(TComponentProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {******************** TElImageIndexProperty *********************************}
  TElImageIndexProperty = class(TIntegerProperty, ICustomPropertyListDrawing, ICustomPropertyDrawing)
  protected
    function GetImages: TCustomImageList; virtual;
    function GetImagesPropertyName: String; virtual;
    property Images: TCustomImageList read GetImages;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); 
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
                               var AWidth: Integer); 
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
                                var AHeight: Integer); 
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
                            const ARect: TRect; ASelected: Boolean); 
  end;

  {******************** TElCurrencyEditButtonImageIndexProperty ***************}
  TElCurrencyEditButtonImageIndexProperty = class(TElImageIndexProperty)
  protected
    function GetImagesPropertyName: String; override;
  end;

  {*************************** TFormProperty **********************************}
  TElFormProperty = class(TEnumProperty)
  private
    List : TStringList;
    FormName,
    FileName : String;
    procedure EnumProc(const FileName, UnitName, FormName, DesignClass: string; CoClasses: TStrings);
    procedure FNProc(const FileName, UnitName, FormName, DesignClass: string; CoClasses: TStrings);
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  {*********************** TElHTMLContainerItemsProperty **********************}
  TElHTMLContainerItemsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  {*********************** TElHTMLStringsProperty *****************************}
  TElHTMLStringsProperty = class(TClassProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {*********************** TElHTMLStringProperty ******************************}
  TElHTMLStringProperty = class(TStringProperty)
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {*********************** TElHTMLStringsProperty *****************************}
  TElMlCaptionProperty = class(TStringProperty)
  private
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  {*********************** TElSectionsProperty ********************************}
  TElSectionsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

  {*********************** TElXSectionsProperty ********************************}
  TElXSectionsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

  {****************** TElSideBarSectionImageIndexProperty *********************}
  TElSideBarSectionImageIndexProperty = class(TElImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  {******************* TElSideBarItemImageIndexProperty ***********************}
  TElSideBarItemImageIndexProperty = class(TElImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  {******************* TStrPoolItemsProperty **********************************}
  TStrPoolItemsProperty = class(TPropertyEditor)
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

  {******************* TElTabSheetImageIndexProperty **************************}
  TElTabSheetImageIndexProperty = class(TElImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  {******************* TElToolButtonImageIndexProperty ************************}
  TElToolButtonImageIndexProperty = class(TElImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  {******************* TLMDWideStringsProperty *********************************}
  {$ifdef LMD_UNICODE}
  TLMDWideStringsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;
  {$endif}

implementation
uses
  LMDUnicodeStrings, ElSideBar, ElToolBar, ElHeader, ElXHeader, ElStrPool, ElStrArray,
  pLMDElHTMLEditorDlg, pLMDElSectProp, pLMDElXSectProp, pLMDElStrPoolEdit, pLMDElMlCapProp;

{ ******************** class TElActivePageProperty *************************** }
function TElActivePageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ -----------------------------------------------------------------------------}
procedure TElActivePageProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  if GetComponent(0) is TElPageControl then
    begin
      for I := 0 to TElPageControl(GetComponent(0)).PageCount - 1 do
        Proc(TElPageControl(GetComponent(0)).Pages[i].Name);
    end;
end;

{ ******************** class TElImageIndexProperty *************************** }
{ ------------------------------ protected ----------------------------------- }
function TElImageIndexProperty.GetImages: TCustomImageList;
var
  C: TPersistent;
begin
  C := GetComponent(0);
  Result := TCustomImageList(GetObjectProp(C, GetImagesPropertyName(), TCustomImageList));
end;

{ -----------------------------------------------------------------------------}
function TElImageIndexProperty.GetImagesPropertyName: String;
begin
  Result := 'Images';
end;

{ ------------------------------ public -------------------------------------- }
function TElImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc('-1');
  if Images = nil then Exit;
  for I := 0 to Images.Count - 1 do
    Proc(IntToStr(I));
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  ATextRect: TRect;
  Bmp: Graphics.TBitmap;
begin
  ATextRect := ARect;
  if Images <> nil then
  begin
    Inc(ATextRect.Left, 1 + Images.Width + 1);
    with ARect do
    begin
      ACanvas.FillRect(Rect(Left, Top, ATextRect.Left, Bottom));
    end;
    Bmp := Graphics.TBitmap.Create;
    try
      Images.GetBitmap(StrToInt(Value), Bmp);
      if Images.Height > ARect.Bottom - ARect.Top - 2 then Bmp.Height := ARect.Bottom - ARect.Top - 2;
      ACanvas.Draw(ARect.Left + 1, ARect.Top + 1, Bmp);
    finally
      Bmp.Free;
    end;
  end;
  with ATextRect, ACanvas do
    ACanvas.TextRect(ATextRect, Left + 1, (Top + Bottom - TextHeight(Value)) div 2, Value);
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
begin

  AHeight := ACanvas.TextHeight('Wg');

  if (Images <> nil) and (AHeight < 1 + Images.Height + 1) then
    AHeight := 1 + Images.Height + 1;
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);

var
  I: Char;
  WD: Integer;

begin

  AWidth := 0;
  for I := '0' to '9' do
  begin
    WD := ACanvas.TextWidth(I);
    if WD > AWidth then
    begin
      AWidth := WD;
    end;
  end;
  AWidth := ACanvas.TextWidth('-') + (7 * AWidth);

  if Images <> nil then Inc(AWidth, 1 + Images.Width + 1);
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.PropDrawName(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{ -----------------------------------------------------------------------------}
procedure TElImageIndexProperty.PropDrawValue(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
begin
  if GetVisualValue <> '' then
    ListDrawValue(GetVisualValue, ACanvas, ARect, ASelected)
  else

    DefaultPropertyDrawValue(Self, ACanvas, ARect);

end;

{ ******************** class TElFormProperty ********************************* }
function TElFormProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ -----------------------------------------------------------------------------}
function TElFormProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

{ -----------------------------------------------------------------------------}
procedure TElFormProperty.EnumProc(const FileName, UnitName, FormName, DesignClass: string; CoClasses: TStrings);
begin
  if FormName <> '' then
     List.Add(FormName);
end;

{ -----------------------------------------------------------------------------}
procedure TElFormProperty.FNProc(const FileName, UnitName, FormName, DesignClass: string; CoClasses: TStrings);
begin
  if Self.FormName = FormName then
  begin
    Self.FileName := FormName;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TElFormProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  List := TStringList.Create;
  try
    Designer.GetProjectModules(EnumProc);
    for i := 0 to List.Count - 1 do Proc(List[i]);
  finally
    List.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TElFormProperty.SetValue(const Value: string);
begin
  if Value = '' then SetStrValue('') else
  begin
    FormName := Value;
    FileName := '';
    Designer.GetProjectModules(FNProc);
    SetStrValue(FileName);
  end;
end;

{------------------------------------------------------------------------------}
{ TElHTMLContainerItemsProperty }
{------------------------------------------------------------------------------}
type
  TElHTMLContainerColEditor = class(TCollectionEditor)
    procedure SelectionUpdate(Sender: TObject);
  private
    FEditorAction: TAction;

    Prop: IProperty;
    procedure int_GetPropEditProc(const Prop: IProperty);

  protected
    procedure Loaded; override;
    procedure OpenEditor(Sender:TObject);
  public
  end;

{------------------------------------------------------------------------------}
procedure TElHTMLContainerColEditor.Loaded;
var
  FItemMenu: TMenuItem;
begin
  inherited Loaded;

  ListView1.OnDblClick := OpenEditor;
  FEditorAction := TAction.Create(self);
  FEditorAction.Caption := 'Item Editor';
  FEditorAction.OnExecute := OpenEditor;
  FEditorAction.OnUpdate := SelectionUpdate;
  FItemMenu := TMenuItem.Create(PopupMenu1);
  FItemMenu.Action := FEditorAction;
  PopupMenu1.Items.Add(FItemMenu);
end;

{------------------------------------------------------------------------------}

procedure TElHTMLContainerColEditor.int_GetPropEditProc(const Prop: IProperty);

begin
  if  Assigned(Prop) and SameText(Prop.GetName, 'Caption') then
    self.Prop := Prop;
end;

{------------------------------------------------------------------------------}

procedure TElHTMLContainerColEditor.OpenEditor(Sender:TObject);
var
  Itm: TCollectionItem;
  Components: IDesignerSelections;
begin
  if  (ListView1.Selected <> nil) then
    begin
      Prop := nil;
      Components := TDesignerSelections.Create;

      try
        Itm := Collection.Items[ListView1.Selected.Index];
        Components.Add(Itm);
        GetComponentProperties(Components, [{$IFDEF LMD_UNICODE}tkWString{$ELSE}tkString{$ENDIF}], Designer, int_GetPropEditProc);
        Components := nil;
        if  Assigned(Prop)  then
          begin
          Prop.Edit;
          end;
      finally
        Prop := nil;
        Components := nil;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TElHTMLContainerColEditor.SelectionUpdate(Sender: TObject);
begin
  inherited ;

  FEditorAction.Enabled := (ListView1.Selected <> nil);
end;

{------------------------------------------------------------------------------}
function TElHTMLContainerItemsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TElHTMLContainerColEditor;
end;

{ ******************** class TElHTMLProperty ********************************* }
procedure TElHTMLStringsProperty.Edit;
var
  fEditor: TfrmLMDElHTMLEditor;
  aList: TLMDMemoryStrings;
begin
  aList := TLMDMemoryStrings.Create;
  try
    fEditor := TfrmLMDElHTMLEditor.Create(nil);
    with fEditor do
      try
        HTMLEdit.Lines.Text := TLMDStrings(Pointer(GetOrdValue)).text;
        if ShowModal=mrOK then
          begin
            aList.Text:=HTMLEdit.Lines.Text;
            SetOrdValue(Longint(Pointer(aList)));
            if Assigned(self.Designer) then Self.Designer.Modified;
          end;
      finally
        Free;
      end;
  finally
    aList.Clear;
    aList.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElHTMLStringsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ ******************** class TElHTMLStringProperty *************************** }
procedure TElHTMLStringProperty.Edit;
begin
  with TfrmLMDElHTMLEditor.Create(nil) do
    try
    if GetPropType^.Kind = tkWString then
      begin
        HTMLEdit.Lines.Text := TypInfo.GetWideStrProp(GetComponent(0), GetPropInfo);
      end
    else
    HTMLEdit.Lines.Text := GetValue;

      if ShowModal=mrOK then
        begin
          if GetPropType^.Kind = tkWString then
            SetWideStrProp(GetComponent(0), GetPropInfo, HTMLEdit.Lines.Text)
          else
          SetValue(HTMLEdit.Lines.Text);
          if Assigned(self.Designer) then Self.Designer.Modified;
        end;
    finally
      Free;
    end;
end;

{ -----------------------------------------------------------------------------}
function TElHTMLStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ ************************ TElMlCaptionProperty ****************************** }
procedure TElMlCaptionProperty.Edit;
begin
  with TMlCapEditDialog.Create(Application) do
  try
    if GetPropType^.Kind = tkWString then
    begin
      Memo.Text := TypInfo.GetWideStrProp(GetComponent(0), GetPropInfo);
    end
    else
    Memo.Text := GetValue;

    MemoChange(Self);
    if ShowModal = mrOk then
    begin
      if GetPropType^.Kind = tkWString then
        begin
          SetWideStrProp(GetComponent(0), GetPropInfo, Memo.Text);
        end
      else
      SetValue(Memo.Text);
     if Assigned(self.Designer) then Self.Designer.Modified;
    end;
  finally
    Free
  end
end;

{ -----------------------------------------------------------------------------}
function TElMlCaptionProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog];
  end;

{ ************************ TElSectionsProperty ******************************* }
procedure TElSectionsProperty.Edit;
var
  Editor : TElSectionsPropDlg;
begin
  Editor := nil;
  try
    Editor := TElSectionsPropDlg.Create(Application);
    Editor.ASect := TElHeaderSections(GetOrdValue);
    Editor.SetData;
    Editor.Caption := Format('Editing %s.Sections', [Editor.ASect.Owner.Name]);
    if Editor.ShowModal = mrOk then
      begin
        Editor.GetData;
        if Assigned(self.Designer) then Self.Designer.Modified;
      end;
  finally
    Editor.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElSectionsProperty.GetAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ -----------------------------------------------------------------------------}
function TElSectionsProperty.GetValue;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ ************************ TElSectionsProperty ******************************* }
procedure TElXSectionsProperty.Edit;
var
  Editor : TElXSectionsPropDlg;
begin
  Editor := nil;
  try
    Editor := TElXSectionsPropDlg.Create(Application);
    Editor.ASect := TElXHeaderSections(GetOrdValue);
    Editor.SetData;
    Editor.Caption := Format('Editing %s.Sections', [Editor.ASect.Owner.Name]);
    if Editor.ShowModal = mrOk then
      begin
        Editor.GetData;
        if Assigned(self.Designer) then Self.Designer.Modified;
      end;
  finally
    Editor.Free;
  end;
end;

{ -----------------------------------------------------------------------------}
function TElXSectionsProperty.GetAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ -----------------------------------------------------------------------------}
function TElXSectionsProperty.GetValue;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ ******************** TElSideBarSectionImageIndexProperty ******************* }
function TElSideBarSectionImageIndexProperty.GetImages: TCustomImageList;
var
  SideBarItem: TElSideBarCItem;
  SideBar: TElSideBar;
  Component: TPersistent;
begin
  Result := nil;
  Component := GetComponent(0);
  if not (Assigned(Component) and (Component is TElSideBarSection)) then Exit;
  SideBarItem := TElSideBarCItem(Component);
  SideBar := SideBarItem.GetBar;
  if Assigned(SideBar) then
  begin
    Result := SideBar.SectionImages;
  end;
end;

{ ******************** TElSideBarItemImageIndexProperty ********************** }
function TElSideBarItemImageIndexProperty.GetImages: TCustomImageList;
var
  SideBarItem: TElSideBarCItem;
  SideBar: TElSideBar;
  Component: TPersistent;
begin
  Result := nil;
  Component := GetComponent(0);
  if not (Assigned(Component) and (Component is TElSideBarItem)) then Exit;
  SideBarItem := TElSideBarCItem(Component);
  SideBar := SideBarItem.GetBar;
  if Assigned(SideBar) then
  begin
    Result := SideBar.ItemImages;
  end;
end;

{ ******************** TElToolButtonImageIndexProperty *********************** }
function TElToolButtonImageIndexProperty.GetImages: TCustomImageList;
var
  ToolButton: TElToolButton;
  Component: TPersistent;
begin
  Result := nil;
  Component := GetComponent(0);
  if not (Assigned(Component) and (Component is TElToolButton)) then Exit;
  ToolButton := TElToolButton(Component);
  if Assigned(ToolButton.Parent) and (ToolButton.Parent is TElToolBar) then
  begin
    Result := TElToolBar(ToolButton.Parent).Images;
  end;
end;

{ ******************** TStrPoolItemsProperty ********************************* }
procedure TStrPoolItemsProperty.Edit;
var anArray : TLMDStringArray;
    b       : boolean;
begin
  with TStrPoolEditForm.Create(Application) do
  begin
    try
      b := TObject(GetOrdProp(GetComponent(0), GetPropInfo)) is TLMDStringArray;
      if not b then
      begin
        anArray := TLMDStringArray.Create;
        anArray.Assign(TObject(GetOrdProp(GetComponent(0), GetPropInfo)) as TElStringArray);
      end
      else
        anArray := TObject(GetOrdProp(GetComponent(0), GetPropInfo)) as TLMDStringArray;
      SetData(anArray);
      if (ShowModal = mrOk) then
      begin
        GetData(anArray);
        if Assigned(self.Designer) then Self.Designer.Modified;
      end;
      if not b then AnArray.Free;
    finally
      Free;  { Free dialog. }
    end;  { try/finally }
  end;  { with }
end;  { Edit }

{ -----------------------------------------------------------------------------}
function TStrPoolItemsProperty.GetValue : string;
begin
  result := 'String Array Items';
end;

{ -----------------------------------------------------------------------------}
function TStrPoolItemsProperty.GetAttributes : TPropertyAttributes;
{ Returns information used by the Object Inspector to show the approprate adornments (e.g., "..." button, drop-down button). }
begin
  GetAttributes := [paDialog];
end;  { GetAttributes }

{ ******************** TElTabSheetImageIndexProperty ************************* }
function TElTabSheetImageIndexProperty.GetImages: TCustomImageList;
var
  PageControl : TElPageControl;
  Component: TPersistent;
begin
  Result := nil;
  Component := GetComponent(0);
  if not (Assigned(Component) and (Component is TElTabSheet)) then Exit;
  PageControl := TElTabSheet(Component).PageControl;
  if PageControl <> nil then
  begin
    Result := PageControl.Images;
  end;
end;

{ ******************** TElCurrencyEditButtonImageIndexProperty *************** }
function TElCurrencyEditButtonImageIndexProperty.GetImagesPropertyName: String;
begin
  Result := 'ButtonImages';
end;

{ ******************** TLMDWideStringsProperty ******************************** }
{$ifdef LMD_UNICODE}
procedure TLMDWideStringsProperty.Edit;
begin
  with TMlCapEditDialog.Create(Application) do
  try
    Memo.Lines.Assign(TLMDWideStrings(GetOrdValue));
    MemoChange(Memo);
    if ShowModal = mrOk then
      begin
        SetOrdValue(Longint(Memo.Lines));
        // TLMDWideStrings(GetOrdValue).Assign(Memo.Lines);
       if Assigned(self.Designer) then Self.Designer.Modified;
      end;
  finally
    Free;
  end
end;

{ -----------------------------------------------------------------------------}
function TLMDWideStringsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;
{$endif}

end.
