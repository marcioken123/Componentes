unit pLMDGridPE;
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

pLMDGridPE unit (VT)
-------------------
Unit contains property editors needed in LMD Grid.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release
 - Code formatting (YB, FEB 2011)

###############################################################################}

interface

uses
  Classes, TypInfo, Controls, DesignIntf, DesignEditors, DesignMenus,
  LMDGrid, LMDDBGrid;

type
  //== TLMDGridCompEditor ======================================================

  TLMDGridCompEditor = class(TComponentEditor)
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  //== TLMDGridColumnsProperty =================================================

  TLMDGridColumnsProperty = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  //== TLMDGridFieldNameProperty ===============================================

  TLMDGridFieldNameProperty = class(TStringProperty)
  private
    function Column: TLMDGridColumn;
  public
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  //== TLMDGridChooserNameProperty =============================================

  TLMDGridChooserNameProperty = class(TStringProperty, IReferenceProperty
                                      {$IFDEF LMDCOMP10}
                                      , IShowReferenceProperty
                                      {$ENDIF})
  private
    FAncList:             TList;
    FCompList:            TList;
    FAncestor:            TPersistent;
    FRoot, FRootAncestor: TComponent;

    function  Column: TLMDGridColumn;
    function  PropFilter(APropName: string): Boolean;
    function  PropObjFilter(const AProp: IProperty): Boolean;
    procedure AddAncestor(Component: TComponent);
    procedure AddToCompList(Component: TComponent);
    {$IFDEF LMDCOMP7}
    procedure GetLookupInfo(var Ancestor: TPersistent;
                            var Root, LookupRoot, RootAncestor: TComponent);
    {$ENDIF}
  protected
    function GetIsDefault: Boolean; {$IFDEF LMDCOMP7} override; {$ENDIF}
    function GetComponentReference: TComponent;
    function ShowReferenceProperty: Boolean;
  public
    function  AllEqual: Boolean; override;
    function  GetEditLimit: Integer; override;
    function  GetName: string; override;
    procedure SetValue(const Value: string); override;
    function  GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

implementation

uses
  Forms, DB, Dialogs, LMDGridColumnsEditor, LMDGridConst, Windows, SysUtils,
  Contnrs, Proxies, Graphics;

type
  TColAccess    = class(TLMDGridColumn);
  TCompAccess   = class(TComponent);
  TGridAccess   = class(TLMDCustomGrid);
  TWriterAccess = class(TWriter);

  TNotify = class
    Evt: TNotifyEvent;
    Obj: TObject;
  end;

  TSelectionHandler = class(TInterfacedObject, IDesignNotification)
  private
    FNotifyList: TObjectList;
  protected
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner;
                               const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
    procedure DesignSelectionNotifyRegister(ADsgControl: TControl;
                                            AIsRegister: Boolean;
                                            ANotifyProc: TNotifyEvent);
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  SelectionHandler:  TSelectionHandler;
  SelectionHandlerI: IDesignNotification;

//== Globals ===================================================================

function GetChooserName(AChooser: TLMDGridColumnChooser): string;
var
  dsc: TLMDGridChooserDescr;
begin
  dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(AChooser.ClassType);
  if dsc <> nil then
    Result := dsc.ChooserName
  else
  begin
    Result := '';
    Assert(False);
  end;
end;

function PersistentEquals(AObj1, AObj2: TPersistent): Boolean;
var
  s1, s2: TMemoryStream;
  w1, w2: TWriter;
begin
  s1 := TMemoryStream.Create;
  s2 := TMemoryStream.Create;
  w1 := TWriter.Create(s1, 1024);
  w2 := TWriter.Create(s2, 1024);
  try
    TWriterAccess(w1).WriteProperties(AObj1);
    TWriterAccess(w2).WriteProperties(AObj2);
    w1.Free;
    w2.Free;

    Result := (s1.Size = s2.Size) and CompareMem(s1.Memory, s2.Memory, s1.Size);
  finally
    s1.Free;
    s2.Free;
  end;
end;

function IsPersistentDefault(AObj: TPersistent): Boolean;
var
  s: TMemoryStream;
  w: TWriter;
begin
  s := TMemoryStream.Create;
  w := TWriter.Create(s, 1024);
  try
    TWriterAccess(w).WriteProperties(AObj);
    w.Free;

    Result := s.Size = 0;
  finally
    s.Free;
  end;
end;

procedure RunColumnsDialog(AGrid: TLMDCustomGrid; const ADesigner: IDesigner);
var
  i:    Integer;
  form: TCustomForm;
  dlg:  TLMDGridColumnEditForm;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    form := Screen.Forms[i];

    if form is TLMDGridColumnEditForm then
      if TLMDGridColumnEditForm(form).Grid = AGrid then
      begin
        form.Show;
        if form.WindowState = wsMinimized then
          form.WindowState := wsNormal;

        Exit;
      end;
  end;

  dlg             := TLMDGridColumnEditForm.Create(AGrid, ADesigner);
  dlg.WindowState := wsNormal;
  dlg.Caption     := SLMDGridColumnsEditorCaption + ': ' + AGrid.Name;
  dlg.Show;
end;

function GetDesigner(ADsgControl: TControl): IDesigner;
var
  form: TCustomForm;
  dsgH: IDesignerHook;
begin
  Result := nil;
  form := GetParentForm(ADsgControl);
  if form <> nil then
  begin
    dsgH := form.Designer;
    if dsgH <> nil then
      Result := dsgH as IDesigner;
  end;
end;

procedure DesignerGetSelections(ADsgControl: TControl; AList: TObjectList);
var
  dsg:  IDesigner;
  sels: IDesignerSelections;
  i:    Integer;
begin
  AList.Clear;

  dsg := GetDesigner(ADsgControl);
  if dsg <> nil then
  begin
    sels := CreateSelectionList;
    dsg.GetSelections(sels);
    for i := 0 to sels.Count - 1 do
      if sels[i] is TLMDGridColumn then
        AList.Add(sels[i]);
  end;
end;

procedure DesignerSetSelections(ADsgControl: TControl; AList: TObjectList);
var
  dsg:  IDesigner;
  sels: IDesignerSelections;
  i:    Integer;
begin
  dsg := GetDesigner(ADsgControl);
  if dsg <> nil then
  begin
    sels := CreateSelectionList;
    for i := 0 to AList.Count - 1 do
      sels.Add(AList[i] as TPersistent);

    dsg.SetSelections(sels);
  end;
end;

procedure DesignerSelectComponent(ADsgControl: TControl;
  AComponent: TComponent; ADoAddSelection: Boolean);
var
  dsg:  IDesigner;
  list: TObjectList;
begin
  dsg := GetDesigner(ADsgControl);
  list := TObjectList.Create(False);
  try
    if ADoAddSelection then
      DesignerGetSelections(ADsgControl, list);

    list.Add(AComponent);
    DesignerSetSelections(ADsgControl, list);
  finally
    list.Free;
  end;
end;

function DesignerIsComponentSelected(ADsgControl: TControl;
  AComponent: TComponent): Boolean;
var
  dsg:  IDesigner;
  sels: IDesignerSelections;
  i:    Integer;
begin
  Result := False;

  dsg := GetDesigner(ADsgControl);
  if dsg <> nil then
  begin
    sels := CreateSelectionList;
    dsg.GetSelections(sels);

    for i := 0 to sels.Count - 1 do
      if sels[i] = AComponent then
      begin
        Result := True;
        Break;
      end;
  end;
end;

//== TLMDGridCompEditor ========================================================

procedure TLMDGridCompEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: RunColumnsDialog(GetComponent as TLMDCustomGrid, self.Designer);
  else
    Assert(False);
  end;
end;

function TLMDGridCompEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SLMDGridDsgColumnsEdit;
  else
    Assert(False);
  end;
end;

function TLMDGridCompEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

//== TLMDGridColumnsProperty ===================================================

procedure TLMDGridColumnsProperty.Edit;
begin
  RunColumnsDialog(GetComponent(0) as TLMDCustomGrid, self.Designer);
end;

function TLMDGridColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

//== TLMDGridFieldNameProperty =================================================

function TLMDGridFieldNameProperty.Column: TLMDGridColumn;
begin
  Result := GetComponent(0) as TLMDGridColumn;
end;

function TLMDGridFieldNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

function TLMDGridFieldNameProperty.GetValue: string;
begin
  Result := Column.FieldName;
end;

procedure TLMDGridFieldNameProperty.GetValues(Proc: TGetStrProc);
var
  grid: TGridAccess;
  list: TStringList;
  i:    Integer;
begin
  grid := TGridAccess( Column.grid );
  list := TStringList.Create;
  try
    grid.GetAvailableColumnFieldNames(Column, list);
    for i := 0 to list.Count - 1 do
      Proc(list[i]);
  finally
    list.Free;
  end;
end;

procedure TLMDGridFieldNameProperty.SetValue(const Value: string);
begin
  Column.FieldName := Value;
  Modified;
end;

//== TLMDGridChooserNameProperty ===============================================

procedure TLMDGridChooserNameProperty.AddAncestor(Component: TComponent);
begin
  FAncList.Add(Component);
end;

procedure TLMDGridChooserNameProperty.AddToCompList(Component: TComponent);
begin
  FCompList.Add(Component);
end;

function TLMDGridChooserNameProperty.AllEqual: Boolean;
begin
  Result := PropCount = 1;
end;

function TLMDGridChooserNameProperty.Column: TLMDGridColumn;
begin
  Result := GetComponent(0) as TLMDGridColumn;
end;

function TLMDGridChooserNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSubProperties, paVolatileSubProperties,
             paRevertable];
end;

function TLMDGridChooserNameProperty.GetComponentReference: TComponent;
begin
  Result := (GetComponent(0) as TLMDGridColumn).Chooser;
end;

function TLMDGridChooserNameProperty.GetEditLimit: Integer;
begin
  Result := 2047;
end;

function TLMDGridChooserNameProperty.GetIsDefault: Boolean;
var
  firstInstance:        TPersistent;
  ancestorList:         TList;
  root:                 TComponent;
  ancestor:             TPersistent;
  rootAncestor:         TComponent;
  lookingFor:           TComponent;
  doneLooking:          Boolean;
  childName:            string;
  col, ancCol:          TLMDGridColumn;
  Cchooser, ancChooser: TLMDGridColumnChooser;

  function _FindChildComponent(Component: TComponent;
                               const Name: string): TComponent;
  var
    i: Integer;
  begin
    Result := Component.FindComponent(Name);
    if Result = nil then
      for i := 0 to Component.ComponentCount - 1 do
      begin
        Result := _FindChildComponent(Component.Components[i], Name);
        if Result <> nil then
          Exit;
      end;
  end;

  function _FindAncestor(const Name: string): TComponent;
  var
    i: Integer;
  begin
    for i := 0 to ancestorList.Count - 1 do
    begin
      Result := ancestorList[i];

      if SameText(Result.Name, Name) then
        Exit;
    end;
    Result := nil;
  end;

  procedure _WriteComponentSimulation(Component: TComponent);
  var
    oldAncestor:              TPersistent;
    oldRoot, oldRootAncestor: TComponent;
    oldAncestorList:          TList;
    {$IFDEF LMDCOMP7}
    tempAncestor:             TPersistent;
    {$ENDIF}
    compList:                 TList;
    i:                        Integer;
  begin
    if doneLooking then
      Exit;

    oldAncestor := ancestor;
    oldRootAncestor := rootAncestor;
    try
      if Assigned(ancestorList) then
        ancestor := _FindAncestor(Component.Name);

      // If we are at the component we were looking
      // for, then we can stop at this point.

      if lookingFor = Component then
        doneLooking := True
      else if SameText(lookingFor.Name, Component.Name) then
        doneLooking := True
      else
      begin
        if (ancestor = nil) and (Component <> Designer.root) and
            IsProxyClass(Component.ClassType)
        then
        begin
          {$IFDEF LMDCOMP7}
          tempAncestor := Designer.FindRootAncestor(Component.ClassName);
          if tempAncestor <> nil then
          begin
            ancestor := tempAncestor;
            rootAncestor := TComponent(ancestor);
          end;
          {$ENDIF}

  {        InlineRoot := ActiveDesigner.OpenRootClass(Component.ClassName);
          if InlineRoot <> nil then
          begin
            ancestor := InlineRoot.GetRoot;
            rootAncestor := TComponent(ancestor);
          end;
          }
        // use IDesigner.FindRootAncestor
        end;

        // Component.WriteState(Self); // This is simulated below, inline

        oldAncestorList := ancestorList;
        oldRoot := root;
        oldRootAncestor := rootAncestor;
        try
          ancestorList := nil;
            // if the instance isn't a TActiveXControl...
            // if not IgnoreChildren then
            try
              if (ancestor <> nil) and (ancestor is TComponent) then
              begin
                if csInline in TComponent(ancestor).ComponentState then
                  rootAncestor := TComponent(ancestor);
                ancestorList := TList.Create;
                FAncList := ancestorList;
                TCompAccess(ancestor).GetChildren(AddAncestor, rootAncestor);
              end;
              if csInline in Component.ComponentState then
                root := Component;

              compList := TList.Create;
              try
                FCompList := compList;
                TCompAccess(Component).GetChildren(AddToCompList, root);
                for i := 0 to compList.Count - 1 do
                  _WriteComponentSimulation(TComponent(compList[i]));
              finally
                compList.Free;
              end;
            finally
              ancestorList.Free;
            end;
        finally
          ancestorList := oldAncestorList;
          if not doneLooking then
          begin
            root := oldRoot;
            rootAncestor := oldRootAncestor;
          end;
        end;
      end;
    finally
      if not doneLooking then
      begin
        // Only restore the ancestor if we were not done looking.
        // This way, we can continue up the chaing looking for the
        // component.

        ancestor     := oldAncestor;
        rootAncestor := oldRootAncestor;
      end
    end;
  end;

var
  propList:    PPropList;
  propInfo:    PPropInfo;
  i, count:    Integer;
  ancValid:    Boolean;
  s:           string;
  obj, objAnc: TObject;
begin
  Result := False;

  if (Designer <> nil) and (PropCount > 0) then
  begin
    // If they are not all equal, then they
    // aren't all the default (at least one..).

    if not AllEqual then
    begin
      Result := False;
      Exit;
    end;

    // TWriter.WriteDescendent simulation.

    if Designer.AncestorDesigner <> nil then
    begin
      rootAncestor := Designer.AncestorDesigner.root;
      ancestor := FRootAncestor;
    end
    else
    begin
      rootAncestor := nil;
      ancestor := nil;
    end;

    root          := (GetComponent(0) as TComponent).Owner;
    firstInstance := GetComponent(0);
    ancestorList  := nil;
    Assert(firstInstance <> nil);

    if firstInstance is TComponent then
    begin
      lookingFor := TComponent(firstInstance);

      // Only lookup the component if it was
      // introduced in an ancestor form/frame.

      if csAncestor in lookingFor.ComponentState then
      begin
        doneLooking := False;
        if csSubComponent in lookingFor.ComponentStyle then
        begin
          childName := lookingFor.Name;
          repeat
            lookingFor := lookingFor.Owner;
          until not (csSubComponent in lookingFor.ComponentStyle);

          _WriteComponentSimulation(root);
          ancestor := _FindChildComponent(TComponent(ancestor), childName);
        end
        else
          _WriteComponentSimulation(root);
      end
      else
      begin
        rootAncestor := nil;
        ancestor     := nil;
      end;
    end
    else
    begin
      // In this case, we will not look up the ancestor (there really
      // isn't one - take columns on tlistview as an example).

      rootAncestor := nil;
      ancestor     := nil;
    end;

    col      := firstInstance as TLMDGridColumn;
    Cchooser := col.Chooser;

    if ancestor <> nil then
    begin
      ancCol := ancestor as TLMDGridColumn;
      ancChooser := ancCol.Chooser;
    end
    else
    begin
      ancCol := nil;
      ancChooser := nil;
    end;

    ancValid := (ancCol <> nil) and (rootAncestor <> nil) and
                root.InheritsFrom(rootAncestor.ClassType);
    Result   := (ancValid and (Cchooser.ClassType = ancChooser.ClassType)) or
                ((not ancValid) and TColAccess(col).IsDefaultChooserClass(Cchooser.ClassType));

    if Result then
    begin
      // Go through each of the properties on the object.

      count := GetTypeData(Cchooser.ClassInfo)^.PropCount;
      if count > 0 then
      begin
        GetMem(propList, count * SizeOf(Pointer));
        try
          GetPropInfos(Cchooser.ClassInfo, propList);
          for i := 0 to count - 1 do
          begin
            propInfo := propList^[i];
            if propInfo = nil then
              Break;

            FAncestor     := ancChooser;
            FRoot         := root;
            FRootAncestor := rootAncestor;

            s := string(propInfo.Name);
            if PropFilter(s) then
            begin
              if propInfo.PropType^.Kind = tkClass then
              begin
                obj := TObject(GetOrdProp(Cchooser, propInfo));
                if ancValid then
                  objAnc := TObject(GetOrdProp(ancChooser, propInfo))
                else
                  objAnc := nil;

                if (obj <> nil) and (obj is TPersistent) then
                begin
                  if objAnc <> nil then
                    Result := (obj.ClassType = objAnc.ClassType) and
                              PersistentEquals(obj as TPersistent, objAnc as TPersistent)
                  else
                    Result := IsPersistentDefault(obj as TPersistent);
                end
                else
                  Result := False;
              end
              else
                {$IFDEF LMDCOMP7}
                Result := IsDefaultPropertyValue(Cchooser, propInfo, GetLookupInfo);
                {$ELSE}
                Result := False;
                {$ENDIF}

              if not Result then
                Break;
            end;
          end;
        finally
          FreeMem(propList, count * SizeOf(Pointer));
        end;
      end;
    end;
  end;
end;

{$IFDEF LMDCOMP7}
procedure TLMDGridChooserNameProperty.GetLookupInfo(var Ancestor: TPersistent;
  var Root, LookupRoot, RootAncestor: TComponent);
begin
  Ancestor     := FAncestor;
  Root         := FRoot;
  LookupRoot   := FRoot;
  RootAncestor := FRootAncestor;
end;
{$ENDIF}

function TLMDGridChooserNameProperty.GetName: string;
begin
  Result := 'Chooser';
end;

procedure TLMDGridChooserNameProperty.GetProperties(Proc: TGetPropProc);
var
  i:          Integer;
  components: IDesignerSelections;
  col:        TLMDGridColumn;
begin
  components := TDesignerSelections.Create;
  for i := 0 to PropCount - 1 do
  begin
    col := GetComponent(i) as TLMDGridColumn;
    if col.Chooser <> nil then
      components.Add(col.Chooser);
  end;

  if components.Count > 0 then
    GetComponentProperties(components, tkProperties + tkMethods,
                           Designer, Proc, PropObjFilter);
end;

function TLMDGridChooserNameProperty.GetValue: string;
begin
  if PropCount <> 1 then
    Result := ''
  else
    Result := Column.ChooserName;
end;

procedure TLMDGridChooserNameProperty.GetValues(Proc: TGetStrProc);
var
  i:   Integer;
  dsc: TLMDGridChooserDescr;
  fk:  TFieldKind;
  ft:  TFieldType;
begin
  if PropCount <> 1 then
    Exit;

  for i := 0 to TLMDGridColumnChooser.RegisteredChooserClassesCount - 1 do
  begin
    dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(i);
    ft  := Column.GetColumnDataType;
    fk  := Column.GetColumnKind;

    if (ft in (dsc.MainFieldTypes + dsc.CompatibleFieldTypes)) and
       (fk in dsc.FieldKinds) then
      Proc(dsc.ChooserName);
  end;
end;

function TLMDGridChooserNameProperty.PropObjFilter(
  const AProp: IProperty): Boolean;
begin
  Result := PropFilter(AProp.GetName);
end;

function TLMDGridChooserNameProperty.PropFilter(APropName: string): Boolean;
begin
  Result := (APropName <> 'Name') and (APropName <> 'Tag');
end;

procedure TLMDGridChooserNameProperty.SetValue(const Value: string);
var
  dsc: TLMDGridChooserDescr;
begin
  dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(Value);
  if dsc <> nil then
  begin
    Column.ChooserName := Value;
    Modified;
  end;
end;

function TLMDGridChooserNameProperty.ShowReferenceProperty: Boolean;
begin
  Result := True;
end;

//== TSelectionHandler =========================================================

constructor TSelectionHandler.Create;
begin
  inherited;
  FNotifyList := TObjectList.Create(True);
end;

procedure TSelectionHandler.DesignerClosed(const ADesigner: IDesigner;
  AGoingDormant: Boolean);
begin
  // Do nothing.
end;

procedure TSelectionHandler.DesignerOpened(const ADesigner: IDesigner;
  AResurrecting: Boolean);
begin
  // Do nothing.
end;

procedure TSelectionHandler.DesignSelectionNotifyRegister(
  ADsgControl: TControl; AIsRegister: Boolean; ANotifyProc: TNotifyEvent);
type
  PMethod = ^TMethod;
var
  i, j:   Integer;
  ntf:    TNotify;
  ok:     Boolean;
  m1, m2: PMethod;
begin
  Assert(Assigned(ANotifyProc));

  if AIsRegister then
  begin
    ok := False;
    for i := 0 to FNotifyList.Count - 1 do
    begin
      ntf := FNotifyList[i] as TNotify;
      Assert(Assigned(ntf.Evt));

      m1 := @ntf.Evt;
      m2 := @ANotifyProc;

      ok := (m1.Code = m2.Code) and (m1.Data = m2.Data) and
            (ntf.Obj = ADsgControl);
      if ok then
        Break;
    end;

    if not ok then
    begin
      ntf := TNotify.Create;
      ntf.Evt := ANotifyProc;
      ntf.Obj := ADsgControl;

      FNotifyList.Add(ntf);
    end;
  end
  else
  begin
    j := -1;
    for i := 0 to FNotifyList.Count - 1 do
    begin
      ntf := FNotifyList[i] as TNotify;

      m1 := @ntf.Evt;
      m2 := @ANotifyProc;

      ok := (m1.Code = m2.Code) and (m1.Data = m2.Data) and
            (ntf.Obj = ADsgControl);
      if ok then
      begin
        j := i;
        Break;
      end;
    end;

    if j <> -1 then
      FNotifyList.Delete(j);
  end;
end;

destructor TSelectionHandler.Destroy;
begin
  FNotifyList.Clear;
  FNotifyList.Free;
  inherited;
end;

procedure TSelectionHandler.ItemDeleted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
  // Do nothing.
end;

procedure TSelectionHandler.ItemInserted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
  // Do nothing.
end;

procedure TSelectionHandler.ItemsModified(const ADesigner: IDesigner);
begin
  // Do nothing
end;

procedure TSelectionHandler.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
var
  i:   Integer;
  ntf: TNotify;
begin
  for i := 0 to FNotifyList.Count - 1 do
  begin
    ntf := FNotifyList[i] as TNotify;
    ntf.Evt(nil);
  end;
end;

procedure DesignSelectionNotifyRegister(ADsgControl: TControl;
  AIsRegister: Boolean; ANotifyProc: TNotifyEvent);
begin
  SelectionHandler.DesignSelectionNotifyRegister(ADsgControl, AIsRegister,
                                                 ANotifyProc);
end;

initialization
  SelectionHandler  := TSelectionHandler.Create;
  SelectionHandlerI := SelectionHandler;
  RegisterDesignNotification(SelectionHandlerI);

  LMDDesignerSelectComponentProc   := DesignerSelectComponent;
  LMDDesignerIsComponentSelected   := DesignerIsComponentSelected;
  LMDDesignSelectionNotifyRegister := DesignSelectionNotifyRegister;

finalization
  UnregisterDesignNotification(SelectionHandler);
  SelectionHandler                 := nil;
  SelectionHandlerI                := nil;
  LMDDesignSelectionNotifyRegister := nil;
  LMDDesignerSelectComponentProc   := nil;
  LMDDesignerIsComponentSelected   := nil;

end.
