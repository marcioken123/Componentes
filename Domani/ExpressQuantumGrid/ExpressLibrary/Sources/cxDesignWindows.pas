
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCommonLibrary                                         }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCOMMONLIBRARY AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxDesignWindows;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$IFDEF CLR}
  Borland.Vcl.Design.DesignConst,
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignWindows,
  Borland.Vcl.Design.ComponentDesigner,
  Variants,
{$ELSE}
  DesignIntf, DesignWindows, ComponentDesigner, DesignConst,
{$ENDIF}
{$ELSE}
  Windows, DsgnWnds, DsgnIntf, LibIntf, DesignConst,
{$ENDIF}
  Math, TypInfo, Classes, SysUtils, Controls, Graphics, Menus, Forms, StdCtrls, ExtCtrls,
  cxClasses;

type
{$IFNDEF DELPHI6}
  IDesigner = IFormDesigner;
{$ENDIF}

{$IFDEF DELPHI6}
  TDesignerSelectionList = IDesignerSelections;
{$ENDIF}

  TcxDesignFormEditor = class;

  { TcxDesignHelper }

  TcxDesignHelper = class(TObject, {$IFNDEF CLR}IUnknown,{$ENDIF} IcxDesignHelper)
  private
    FComponent: TComponent;
    FDesigner: IDesigner;
    FList: TList;
    FWindow: TcxDesignFormEditor;
    function GetDesigner: IDesigner;
  protected
  {$IFNDEF CLR}
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  {$ENDIF}
    procedure NotifyListeners(AList: TList);
    procedure SelectionsChanged(Sender: TObject; const ASelection: TDesignerSelectionList);
  public
    constructor Create(AComponent: TComponent); virtual;
    destructor Destroy; override;
    procedure ChangeSelection(AObject: TPersistent); overload;
    procedure GetSelection(AList: TList);
    function IsObjectSelected(AObject: TPersistent): Boolean; overload;
    procedure SelectObject(AObject: TPersistent; AClearSelection: Boolean = True;
      AActivateOwner: Boolean = True); overload;
    procedure SetSelection(AList: TList);
    procedure UnselectObject(AObject: TPersistent); overload;
    // IcxDesignHelper
    procedure AddSelectionChangedListener(AListener: TPersistent);
    function CanAddComponent(AOwner: TComponent): Boolean;
    function CanDeleteComponent(AOwner: TComponent; AComponent: TComponent): Boolean;
    procedure ChangeSelection(AOwner: TComponent; AObject: TPersistent); overload;
    function IsObjectSelected(AOwner: TComponent; AObject: TPersistent): Boolean; overload;
    procedure RemoveSelectionChangedListener(AListener: TPersistent);
    procedure SelectObject(AOwner: TComponent; AObject: TPersistent; AClearSelection: Boolean = True;
      AActivateOwner: Boolean = True); overload;
    procedure ShowComponentDefaultEventHandler(AComponent: TComponent);
    procedure UnselectObject(AOwner: TComponent; AObject: TPersistent); overload;

    property Component: TComponent read FComponent write FComponent;
    property Designer: IDesigner read GetDesigner;
  end;

  { TcxDesignWindow }

  TcxSelectionsChanged = procedure(Sender: TObject; const ASelection: TDesignerSelectionList) of object;

  TcxDesignWindow = class(TDesignWindow)
  private
    FLockCount: Integer;
    FOnSelectionsChanged: TcxSelectionsChanged;
  protected
    procedure Activated; override;
    function UniqueName(Component: TComponent): string; override;
  {$IFDEF CLR}
    procedure ActivateInspector(Ch: Char);
  {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    class function GetBaseRegKey{$IFDEF DELPHI6}(ADesigner: IComponentDesigner = nil){$ENDIF}: string;
    procedure GetSelectionList(AList: TList);
    procedure SelectionChanged({$IFDEF DELPHI6}const ADesigner: IDesigner;{$ENDIF}
      {$IFDEF DELPHI6}const{$ENDIF}ASelection: TDesignerSelectionList); override;
    procedure SelectionsChanged(const ASelection: TDesignerSelectionList); virtual;
    procedure SetSelectionList(AList: TList);
    procedure UpdateSelection;
    property LockCount: Integer read FLockCount;
    property OnSelectionsChanged: TcxSelectionsChanged
      read FOnSelectionsChanged write FOnSelectionsChanged;
  end;

  { TcxDesignFormEditor }

  TcxDesignFormEditor = class(TcxDesignWindow)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FClosing: Boolean;
  protected
    ComponentProperty: TPersistent;
    ComponentPropertyName: string;
  {$IFDEF DELPHI9}
    {$IFNDEF CLR}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF}
  {$ENDIF}
    procedure CloseEditor; virtual;
    procedure InitFormEditor; virtual;
    procedure UpdateCaption; virtual;
    procedure UpdateContent; virtual;
  public
    Component: TComponent;
    ComponentClassName: string;
    function CanAddComponent: Boolean;
    function CanDeleteComponent(AComponent: TComponent): Boolean;
  {$IFDEF DELPHI6}
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
  {$ELSE}
    procedure FormClosed(AForm: TCustomForm); override;
    procedure ComponentDeleted(Component: IPersistent); override;
    procedure FormModified; override;
  {$ENDIF}
    procedure DoItemsModified; virtual;
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent); {$IFNDEF DELPHI6}virtual;{$ELSE}override;{$ENDIF}
    procedure ItemsModified(const Designer: IDesigner); {$IFNDEF DELPHI6}virtual;{$ELSE}override;{$ENDIF}
    procedure SelectComponent(AComponent: TPersistent);
    procedure SelectComponents(AList: TList; ADefaultComponent: TPersistent); virtual;

    procedure ListBoxApplySelection(AListBox: TListBox; ADefaultComponent: TPersistent);
    procedure ListBoxSynchronizeSelection(AListBox: TListBox);

    property Closing: Boolean read FClosing;
  end;

  TcxDesignFormEditorClass = class of TcxDesignFormEditor;

{$IFDEF CLR}
  { TcxDesignWindowAccess }

  TcxDesignWindowAccess = class
    class procedure ActivateInspector(AInstance: TcxDesignWindow; Ch: Char);
  end;
{$ENDIF}

function ShowFormEditorClass(ADesigner: IDesigner; AComponent: TComponent;
  AFormEditorClass: TcxDesignFormEditorClass): TcxDesignFormEditor; overload;
function ShowFormEditorClass(ADesigner: IDesigner; AComponent: TComponent;
  AProperty: TPersistent; const APropertyName: string;
  AFormEditorClass: TcxDesignFormEditorClass): TcxDesignFormEditor; overload;
procedure UpdateDesignFormEditors(AComponent: TComponent);

function CanAddComponent(AOwner: TComponent; const ADesigner: IDesigner = nil): Boolean;
function CanDeleteComponent(AOwner, AComponent: TComponent; const ADesigner: IDesigner = nil): Boolean;
function CanChangeComponentList(AOwner: TComponent; ADesigner: IDesigner = nil): Boolean;
function GetObjectDesigner(AObject: TPersistent): IDesigner;

function CreateDesignerSelectionList: TDesignerSelectionList;
procedure DeleteDesignerSelectionList(var ASelection: TDesignerSelectionList);

procedure ConvertSelectionToList(const ASelectionList: TDesignerSelectionList; AList: TList);

// ListBox routines

type
  TcxListBoxReindexProc = procedure(AList: TList; ANewIndex: Integer) of object;

function LockListBox(AListBox: TListBox): TNotifyEvent;
procedure UnlockListBox(AListBox: TListBox; APrevOnClick: TNotifyEvent);

procedure ListBoxSetItemIndex(AListBox: TListBox; AItemIndex: Integer);
procedure ListBoxSetSelected(AListBox: TListBox; AItemIndex: Integer;
  ASelected: Boolean);

procedure ListBoxRestoreSelection(AListBox: TListBox; var ASelection: TStringList;
  AItemIndex, ATopIndex: Integer);
procedure ListBoxSaveSelection(AListBox: TListBox; var ASelection: TStringList;
  var AItemIndex, ATopIndex: Integer);

procedure ListBoxRestorePos(AListBox: TListBox; AItemIndex, ATopIndex: Integer);
procedure ListBoxSavePos(AListBox: TListBox; var AItemIndex, ATopIndex: Integer);

function ListBoxGetFirstSelectedIndex(AListBox: TListBox): Integer;
function ListBoxGetLastSelectedIndex(AListBox: TListBox): Integer;

procedure ListBoxDeleteSelection(AListBox: TListBox; ASetFocus: Boolean);
procedure ListBoxGetSelection(AListBox: TListBox; AList: TList);
procedure ListBoxLoadCollection(AListBox: TListBox; ACollection: TCollection);
procedure ListBoxSelectByObject(AListBox: TListBox; AObject: TObject);
procedure ListBoxSyncSelection(AListBox: TListBox; AList: TList);
procedure ListBoxClearSelection(AListBox: TListBox);
procedure ListBoxSelectAll(AListBox: TListBox);

procedure ListBoxMoveItems(AListBox: TListBox; AIndex: Integer;
  var APrevDragIndex: Integer; AReindexProc: TcxListBoxReindexProc);
procedure ListBoxMoveUpItems(AListBox: TListBox; var APrevDragIndex: Integer;
  AReindexProc: TcxListBoxReindexProc);
procedure ListBoxMoveDownItems(AListBox: TListBox; var APrevDragIndex: Integer;
  AReindexProc: TcxListBoxReindexProc);

procedure ListBoxDragOver(AListBox: TListBox; Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean; var APrevDragIndex: Integer);
procedure ListBoxDragDrop(AListBox: TListBox; Sender, Source: TObject;
  X, Y: Integer; var APrevDragIndex: Integer; AReindexProc: TcxListBoxReindexProc);
procedure ListBoxEndDrag(AListBox: TListBox; Sender, Target: TObject;
  X, Y: Integer; var APrevDragIndex: Integer);

// component rename routines

function CreateUniqueName(AOwnerForm, AOwnerComponent, AChildComponent: TComponent;
  const ATruncateClassName, AFieldName: string): string;

// menu routines

function CreateMenuItem(AOwner: TComponent; const ACaption: string;
  AOnClick: TNotifyEvent = nil; AEnabled: Boolean = True; ATag: Integer = -1;
  AChecked: Boolean = False): TMenuItem;

// themed IDE routines

{$IFDEF DELPHI10}  // should be DELPHI105
procedure MakeColoredControlsOpaque(ARoot: TControl);
{$ENDIF}

implementation

{$IFDEF CLR}
uses
  Borland.Vcl.Design.Surface;
{$ENDIF}

{$R *.dfm}

var
  Editors: TList;

function ShowFormEditorClass(ADesigner: IDesigner; AComponent: TComponent;
  AProperty: TPersistent; const APropertyName: string;
  AFormEditorClass: TcxDesignFormEditorClass): TcxDesignFormEditor;
var
  I: Integer;
begin
  if Editors = nil then
    Editors := TList.Create;
  for I := 0 to Editors.Count - 1 do
  begin
    Result := TcxDesignFormEditor(Editors[I]);
    with Result do
      if (Designer = ADesigner) and (Component = AComponent) and
        (AProperty = ComponentProperty) and
        (CompareText(APropertyName, ComponentPropertyName) = 0) then
      begin
        Show;
        BringToFront;
        Exit;
      end;
  end;
  Result := AFormEditorClass.Create(Application);
  with Result do
  try
    Designer := ADesigner;
    Component := AComponent;
    ComponentClassName := AComponent.ClassName;
    ComponentProperty := AProperty;
    ComponentPropertyName := APropertyName;
    InitFormEditor;
    Show;
  except
    Free;
  end;
end;

function ShowFormEditorClass(ADesigner: IDesigner; AComponent: TComponent;
  AFormEditorClass: TcxDesignFormEditorClass): TcxDesignFormEditor;
begin
  Result := ShowFormEditorClass(ADesigner, AComponent, nil, '', AFormEditorClass);
end;

procedure UpdateDesignFormEditors(AComponent: TComponent);
var
  I: Integer;
  ADesignFormEditor: TcxDesignFormEditor;
begin
  if Editors = nil then
    Editors := TList.Create;
  for I := 0 to Editors.Count - 1 do
  begin
    ADesignFormEditor := TcxDesignFormEditor(Editors[I]);
    if ADesignFormEditor.Component = AComponent then
      ADesignFormEditor.UpdateContent;
  end;
end;

function CanAddComponent(AOwner: TComponent; const ADesigner: IDesigner = nil): Boolean;
begin
  Result := CanChangeComponentList(AOwner, ADesigner);
end;

function CanDeleteComponent(AOwner, AComponent: TComponent; const ADesigner: IDesigner = nil): Boolean;
begin
  Result := CanChangeComponentList(AOwner, ADesigner) and
    ((AComponent = nil) or not (csAncestor in AComponent.ComponentState));
end;

function CanChangeComponentList(AOwner: TComponent; ADesigner: IDesigner = nil): Boolean;
begin
  if ADesigner = nil then
    ADesigner := GetObjectDesigner(AOwner);
  Result := not ADesigner.IsSourceReadOnly and not (csInline in AOwner.ComponentState);
end;

function GetObjectDesigner(AObject: TPersistent): IDesigner;
begin
{$IFNDEF CLR}
  Result := FindRootDesigner(AObject) as IDesigner;
{$ELSE}
  if AObject.GetRootDesigner = nil then
    Result := nil
  else
    Result := TDesignSurface(AObject.GetRootDesigner).Designer;
{$ENDIF}
end;

function CreateDesignerSelectionList: TDesignerSelectionList;
begin
{$IFDEF DELPHI6}
  Result := CreateSelectionList;
{$ELSE}
  Result := TDesignerSelectionList.Create;
{$ENDIF}
end;

procedure DeleteDesignerSelectionList(var ASelection: TDesignerSelectionList);
begin
{$IFNDEF DELPHI6}
  FreeAndNil(ASelection);
{$ELSE}
  ASelection := nil;
{$ENDIF}
end;

procedure ConvertSelectionToList(const ASelectionList: TDesignerSelectionList; AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  if ASelectionList <> nil then
  begin
    AList.Capacity := ASelectionList.Count;
    for I := 0 to ASelectionList.Count - 1 do
      AList.Add(ASelectionList[I]);
  end;
end;

// ListBox Routines

function LockListBox(AListBox: TListBox): TNotifyEvent;
begin
  Result := AListBox.OnClick;
  AListBox.OnClick := nil;
end;

procedure UnlockListBox(AListBox: TListBox; APrevOnClick: TNotifyEvent);
begin
  AListBox.OnClick := APrevOnClick;
end;

procedure ListBoxSetItemIndex(AListBox: TListBox; AItemIndex: Integer);
var
  APrevOnClick: TNotifyEvent;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    AListBox.ItemIndex := AItemIndex;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;

procedure ListBoxSetSelected(AListBox: TListBox; AItemIndex: Integer; 
  ASelected: Boolean);
var
  APrevOnClick: TNotifyEvent;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    if AListBox.Selected[AItemIndex] <> ASelected then
      AListBox.Selected[AItemIndex] := ASelected;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;

procedure ListBoxRestoreSelection(AListBox: TListBox; var ASelection: TStringList;
  AItemIndex, ATopIndex: Integer);
var
  I: Integer;
  APrevOnClick: TNotifyEvent;
begin
  try
    APrevOnClick := LockListBox(AListBox);
    try
      with AListBox do
        for I := 0 to Items.Count - 1 do
          Selected[I] := ASelection.IndexOfObject(Items.Objects[I]) <> -1;
      if ATopIndex <> -1 then AListBox.TopIndex := ATopIndex;
      if AItemIndex <> -1 then AListBox.ItemIndex := AItemIndex;
    finally
      UnlockListBox(AListBox, APrevOnClick);
    end;
  finally
    AListBox.Items.EndUpdate;
    FreeAndNil(ASelection);
  end;
end;

procedure ListBoxSaveSelection(AListBox: TListBox; var ASelection: TStringList;
  var AItemIndex, ATopIndex: Integer);
var
  I: Integer;
begin
  ASelection := TStringList.Create;
  try
    AItemIndex := AListBox.ItemIndex;
    ATopIndex := AListBox.TopIndex;
    with AListBox do
      for I := 0 to Items.Count - 1 do
        if Selected[I] then ASelection.AddObject(Items[I], Items.Objects[I]);
    AListBox.Items.BeginUpdate;
  except
    ASelection.Free;
    ASelection := nil;
  end;
end;

procedure ListBoxRestorePos(AListBox: TListBox; AItemIndex, ATopIndex: Integer);
var
  APrevOnClick: TNotifyEvent;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    if ATopIndex <> -1 then AListBox.TopIndex := ATopIndex;
    if AItemIndex <> -1 then AListBox.ItemIndex := AItemIndex;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
//  AListBox.Items.EndUpdate;
end;

procedure ListBoxSavePos(AListBox: TListBox; var AItemIndex, ATopIndex: Integer);
begin
  AItemIndex := AListBox.ItemIndex;
  ATopIndex := AListBox.TopIndex;
//  AListBox.Items.BeginUpdate;
end;

function ListBoxGetFirstSelectedIndex(AListBox: TListBox): Integer;
begin
  for Result := 0 to AListBox.Items.Count - 1 do
    if AListBox.Selected[Result] then Exit;
  Result := -1;  
end;

function ListBoxGetLastSelectedIndex(AListBox: TListBox): Integer;
begin
  for Result := AListBox.Items.Count - 1 downto 0 do
    if AListBox.Selected[Result] then Exit;
  Result := -1;
end;

procedure ListBoxDeleteSelection(AListBox: TListBox; ASetFocus: Boolean);
var
  I, AIndex: Integer;
  AObject: TObject;

  function CanDeleteObject(AObject: TObject): Boolean;
  begin
    if AObject is TComponent then
      Result := not (csAncestor in TComponent(AObject).ComponentState)
    else
      Result := True;
  end;

begin
  AIndex := -1;
  for I := AListBox.Items.Count - 1 downto 0 do
    if AListBox.Selected[I] then
    begin
      with AListBox.Items do
      begin
        AObject := Objects[I];
        if not CanDeleteObject(AObject) then Continue;
        Delete(I);
      end;
      AObject.Free;
      AIndex := I;
    end;
  {for I := 0 to AListBox.Items.Count - 1 do
    if AListBox.Selected[I] then
    begin
      if AIndex = -1 then AIndex := I;
      AListBox.Items.Objects[I].Free;
    end;}
  // Show Last Item
  if AIndex >= AListBox.Items.Count then
    AIndex := AListBox.Items.Count - 1;
  if AIndex >= 0 then
  begin
    ListBoxSetItemIndex(AListBox, AIndex);
    if ASetFocus and AListBox.CanFocus then
      AListBox.SetFocus;
  end;
end;

procedure ListBoxGetSelection(AListBox: TListBox; AList: TList);
var
  I: Integer;
begin
  for I := 0 to AListBox.Items.Count - 1 do
    if AListBox.Selected[I] then
      AList.Add(AListBox.Items.Objects[I]);
end;

procedure ListBoxLoadCollection(AListBox: TListBox; ACollection: TCollection);
var
  I, AItemIndex, ATopIndex: Integer;
  ASelection: TStringList;
  S: string;
begin
  ListBoxSaveSelection(AListBox, ASelection, AItemIndex, ATopIndex);
  try
    AListBox.Items.Clear;
    for I := 0 to ACollection.Count - 1 do
    begin
      S := Format('%d - %s',[I, ACollection.Items[I].DisplayName]);
      AListBox.Items.AddObject(S, ACollection.Items[I]);
    end;
  finally
    ListBoxRestoreSelection(AListBox, ASelection, AItemIndex, ATopIndex);
  end;
end;

procedure ListBoxSelectByObject(AListBox: TListBox; AObject: TObject);
var
  AIndex: Integer;
begin
  AIndex := AListBox.Items.IndexOfObject(AObject);
  if AIndex <> -1 then
    ListBoxSetSelected(AListBox, AIndex, True);
end;

procedure ListBoxSyncSelection(AListBox: TListBox; AList: TList);
var
  I, AItemIndex, ATopIndex: Integer;
  ASelected: Boolean;
  APrevOnClick: TNotifyEvent;
begin
  ListBoxSavePos(AListBox, AItemIndex, ATopIndex);
  try
    APrevOnClick := LockListBox(AListBox);
    try
      for I := 0 to AListBox.Items.Count - 1 do
      begin
        ASelected := AList.IndexOf(AListBox.Items.Objects[I]) <> -1;
        if AListBox.Selected[I] <> ASelected then
          AListBox.Selected[I] := ASelected;
      end;
    finally
      UnlockListBox(AListBox, APrevOnClick);
    end;
    if AListBox.SelCount = 1 then
      for I := 0 to AListBox.Items.Count - 1 do
        if AListBox.Selected[I] then
        begin
          AItemIndex := I;
          Break;
        end;
  finally
    ListBoxRestorePos(AListBox, AItemIndex, ATopIndex);
  end;
end;

procedure ListBoxClearSelection(AListBox: TListBox);
var
  APrevOnClick: TNotifyEvent;
{$IFNDEF DELPHI6}
  I: Integer;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    if AListBox.MultiSelect then
      for I := 0 to AListBox.Items.Count - 1 do
        AListBox.Selected[I] := False
    else
      AListBox.ItemIndex := -1;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;
{$ELSE}
begin
  APrevOnClick := LockListBox(AListBox);
  try
    AListBox.ClearSelection;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;
{$ENDIF}

procedure ListBoxSelectAll(AListBox: TListBox);
var
  I: Integer;
  APrevOnClick: TNotifyEvent;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    with AListBox do
      for I := 0 to Items.Count - 1 do
        Selected[I] := True;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;

procedure ListBoxMoveItems(AListBox: TListBox; AIndex: Integer;
  var APrevDragIndex: Integer; AReindexProc: TcxListBoxReindexProc);
var
  I: Integer;
  APrevOnClick: TNotifyEvent;
  AList: TList;
begin
  APrevOnClick := LockListBox(AListBox);
  try
    with AListBox do
    begin
      if (0 <= APrevDragIndex) and (APrevDragIndex < Items.Count) then
      begin
        Selected[APrevDragIndex] := False;
        APrevDragIndex := -1;
      end;
      if AIndex <> -1 then
      begin
        AList := TList.Create;
        try
          for I := 0 to Items.Count - 1 do
            if Selected[I] then
              AList.Add(Items.Objects[I]);
          AReindexProc(AList, AIndex);
        finally
          AList.Free;
        end;
      end;
      AIndex := Max(ListBoxGetFirstSelectedIndex(AListBox), AIndex);
      AIndex := Min(ListBoxGetLastSelectedIndex(AListBox), AIndex);
      ItemIndex := AIndex;
    end;
  finally
    UnlockListBox(AListBox, APrevOnClick);
  end;
end;

procedure ListBoxMoveUpItems(AListBox: TListBox; var APrevDragIndex: Integer; 
  AReindexProc: TcxListBoxReindexProc);
begin
  ListBoxMoveItems(AListBox, Max(0, ListBoxGetFirstSelectedIndex(AListBox) - 1),
    APrevDragIndex, AReindexProc);
end;

procedure ListBoxMoveDownItems(AListBox: TListBox; var APrevDragIndex: Integer;
  AReindexProc: TcxListBoxReindexProc);
begin
  ListBoxMoveItems(AListBox, Min(AListBox.Items.Count - 1, ListBoxGetLastSelectedIndex(AListBox) + 1),
    APrevDragIndex, AReindexProc);
end;

procedure ListBoxDragOver(AListBox: TListBox; Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean; var APrevDragIndex: Integer);
var
  AIndex: Integer;
  APrevOnClick: TNotifyEvent;
begin
  if Source <> AListBox then
    Accept := False
  else
  begin
    APrevOnClick := LockListBox(AListBox);
    try
      with AListBox do
      begin
        Accept := True;
        AIndex := ItemAtPos(Point(X, Y), True);
        if APrevDragIndex <> AIndex then
        begin
          if (0 <= APrevDragIndex) and (APrevDragIndex < Items.Count) then
            Selected[APrevDragIndex] := False;
          if AIndex <> -1 then
            if not Selected[AIndex] then
            begin
              Selected[AIndex] := True;
              APrevDragIndex := AIndex;
            end
            else
              APrevDragIndex := -1;
        end;
        ItemIndex := AIndex;
      end;
    finally
      UnlockListBox(AListBox, APrevOnClick);
    end;
  end;
end;

procedure ListBoxDragDrop(AListBox: TListBox; Sender, Source: TObject; 
  X, Y: Integer; var APrevDragIndex: Integer; AReindexProc: TcxListBoxReindexProc);
var
  AIndex: Integer;
begin
  AIndex := AListBox.ItemAtPos(Point(X, Y), True);
  if (AIndex = -1) and PtInRect(AListBox.ClientRect, Point(X, Y)) then
    AIndex := AListBox.Items.Count;
  if AIndex <> -1 then
    ListBoxMoveItems(AListBox, AIndex, APrevDragIndex, AReindexProc);
end;

procedure ListBoxEndDrag(AListBox: TListBox; Sender, Target: TObject; 
  X, Y: Integer; var APrevDragIndex: Integer);
begin
  if (0 <= APrevDragIndex) and (APrevDragIndex < AListBox.Items.Count) then
  begin
    ListBoxSetSelected(AListBox, APrevDragIndex, False);
    APrevDragIndex := -1;
  end;
end;

// component rename routines

procedure CrunchFieldName(var AFieldName: string);
var
  I: Integer;
begin
  I := 1;
  while I <= Length(AFieldName) do
  begin
    if AFieldName[I] in ['A'..'Z','a'..'z','_','0'..'9'] then
      Inc(I)
    else
      if AFieldName[I] in LeadBytes then
        Delete(AFieldName, I, 2)
      else
        Delete(AFieldName, I, 1);
  end;
end;

function GenerateName(AOwnerComponent: TComponent;
  const AClassName, ATruncateClassName, AFieldName: string; ANumber: Integer): string;
var
  S: string;
begin
  S := AFieldName;
  CrunchFieldName(S);
  if (S = '') or (S[1] in ['0'..'9']) then
  begin
    if AClassName <> '' then
    begin
      if (ATruncateClassName <> '') and
        (CompareText(ATruncateClassName, Copy(AClassName, 1, Length(ATruncateClassName))) = 0) then
      begin
        S := Copy(AClassName, Length(ATruncateClassName) + 1, Length(AClassName)) + S;
      end
      else
      begin
        S := AClassName + S;
        if S[1] = 'T' then Delete(S, 1, 1);
      end;
    end;
  end;
  if AOwnerComponent <> nil then
    Result := AOwnerComponent.Name + S
  else
    Result := S;
  if ANumber > 0 then
    Result := Result + IntToStr(ANumber);
end;

function CreateUniqueName(AOwnerForm, AOwnerComponent, AChildComponent: TComponent;
  const ATruncateClassName, AFieldName: string): string;

  function IsUnique(const AName: string): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    with AOwnerForm do
      for I := 0 to ComponentCount - 1 do
        if (Components[I] <> AChildComponent) and
          (CompareText(Components[I].Name, AName) = 0) then
        begin
          Result := False;
          Break;
        end;
  end;

var
  I, J: Integer;
begin
  if GetObjectDesigner(AOwnerForm) <> nil then
  begin
    Result := GenerateName(AOwnerComponent, AChildComponent.ClassName,
      ATruncateClassName, AFieldName, 0);
    Result := GetObjectDesigner(AOwnerForm).UniqueName(Result);
  end
  else
  begin
    if AFieldName <> '' then
      J := 0
    else
      J := 1;
    for I := J to MaxInt do
    begin
      Result := GenerateName(AOwnerComponent, AChildComponent.ClassName,
        ATruncateClassName, AFieldName, I);
      if IsUnique(Result) then
        Break;
    end;
  end;
end;

function CreateMenuItem(AOwner: TComponent; const ACaption: string;
  AOnClick: TNotifyEvent = nil; AEnabled: Boolean = True; ATag: Integer = -1;
  AChecked: Boolean = False): TMenuItem;
begin
  Result := TMenuItem.Create(AOwner);
  Result.Caption := ACaption;
  Result.Checked := AChecked;
  Result.Enabled := AEnabled;
  Result.Tag := ATag;
  Result.OnClick := AOnClick;
end;

{$IFDEF DELPHI10}  // should be DELPHI105

procedure MakeColoredControlsOpaque(ARoot: TControl);
var
  I: Integer;
begin
  if (ARoot is TPanel) and (TPanel(ARoot).Color <> clBtnFace) then
    TPanel(ARoot).ParentBackground := False;
  if ARoot is TWinControl then
    for I := 0 to TWinControl(ARoot).ControlCount - 1 do
      MakeColoredControlsOpaque(TWinControl(ARoot).Controls[I]);
end;

{$ENDIF}

{ TcxDesignHelper }

constructor TcxDesignHelper.Create(AComponent: TComponent);
begin
  inherited Create;
  FComponent := AComponent;
  FList := TList.Create;
end;

destructor TcxDesignHelper.Destroy;
begin
  FWindow.Free;
  FList.Free;
  inherited Destroy;
end;

procedure TcxDesignHelper.ChangeSelection(AObject: TPersistent);
begin
  if IsObjectSelected(AObject) then
    UnselectObject(AObject)
  else
    SelectObject(AObject, False);
end;

procedure TcxDesignHelper.GetSelection(AList: TList);
var
  ASelectionList: TDesignerSelectionList;
  I: Integer;
begin
  if Designer = nil then Exit;
  ASelectionList := CreateDesignerSelectionList;
  try
    Designer.GetSelections(ASelectionList);
    AList.Capacity := ASelectionList.Count;
    for I := 0 to ASelectionList.Count - 1 do
      AList.Add(ASelectionList[I]);
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
end;

function TcxDesignHelper.IsObjectSelected(AObject: TPersistent): Boolean;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    GetSelection(AList);
    Result := AList.IndexOf(AObject) <> -1;
  finally
    AList.Free;
  end;
end;

procedure TcxDesignHelper.SelectObject(AObject: TPersistent; AClearSelection: Boolean = True;
  AActivateOwner: Boolean = True);
var
  AList: TList;
begin
  if AClearSelection and AActivateOwner then
    Designer.SelectComponent(AObject)
  else
  begin
    AList := TList.Create;
    try
      if not AClearSelection then GetSelection(AList);
      AList.Add(AObject);
      SetSelection(AList);
    finally
      AList.Free;
    end;
  end;
end;

procedure TcxDesignHelper.SetSelection(AList: TList);
var
  ASelectionList: TDesignerSelectionList;
  I: Integer;
begin
  if Designer = nil then Exit;
  ASelectionList := CreateDesignerSelectionList;
  try
    for I := 0 to AList.Count - 1 do
      ASelectionList.Add(TPersistent(AList[I]));
    Designer.SetSelections(ASelectionList);
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
end;

procedure TcxDesignHelper.UnselectObject(AObject: TPersistent);
var
  AList: TList;
begin
  if not IsObjectSelected(AObject) then Exit;
  AList := TList.Create;
  try
    GetSelection(AList);
    AList.Remove(AObject);
    SetSelection(AList);
  finally
    AList.Free;
  end;
end;

procedure TcxDesignHelper.AddSelectionChangedListener(AListener: TPersistent);
begin
  if (AListener <> nil) and Supports(AListener, IcxDesignSelectionChanged) and
    (FList.IndexOf(AListener) < 0) then
  begin
    if FWindow = nil then
    begin
      FWindow := TcxDesignFormEditor.Create(nil);
      FWindow.OnSelectionsChanged := SelectionsChanged;
    end;
    FList.Add(AListener);
  end;
end;

procedure TcxDesignHelper.RemoveSelectionChangedListener(AListener: TPersistent);
begin
  FList.Remove(AListener);
  if FList.Count = 0 then
    FreeAndNil(FWindow);
end;

function TcxDesignHelper.CanAddComponent(AOwner: TComponent): Boolean;
begin
  Result := cxDesignWindows.CanAddComponent(AOwner.Owner);
end;

function TcxDesignHelper.CanDeleteComponent(AOwner,
  AComponent: TComponent): Boolean;
begin
  Result := cxDesignWindows.CanDeleteComponent(AOwner.Owner, AComponent);
end;

procedure TcxDesignHelper.ChangeSelection(AOwner: TComponent; AObject: TPersistent);
begin
  Component := AOwner;
  ChangeSelection(AObject);
end;

function TcxDesignHelper.IsObjectSelected(AOwner: TComponent; AObject: TPersistent): Boolean;
begin
  Component := AOwner;
  Result := IsObjectSelected(AObject);
end;

procedure TcxDesignHelper.SelectObject(AOwner: TComponent;
  AObject: TPersistent; AClearSelection: Boolean = True;
  AActivateOwner: Boolean = True);
begin
  Component := AOwner;
  SelectObject(AObject, AClearSelection, AActivateOwner);
end;

procedure TcxDesignHelper.ShowComponentDefaultEventHandler(AComponent: TComponent);
var
  APropInfo: PPropInfo;
  AMethod: TMethod;
  AMethodName: string;
begin
  Component := AComponent;
  APropInfo := GetPropInfo(Component.ClassInfo, 'OnChange');
  if APropInfo = nil then
  begin
    APropInfo := GetPropInfo(Component.ClassInfo, 'OnClick');
    if APropInfo = nil then
      Exit
    else
      AMethodName := 'Click';
  end
  else
    AMethodName := 'Change';
  AMethod := GetMethodProp(Component, APropInfo);
  if AMethod.Code <> nil then
    AMethodName := Designer.GetMethodName(AMethod)
  else
  begin
    AMethodName := AComponent.Name + AMethodName;
    AMethod := GetObjectDesigner(Component).CreateMethod(AMethodName, GetTypeData(APropInfo.PropType{$IFNDEF CLR}^{$ENDIF}));
    SetMethodProp(Component, APropInfo, AMethod);
    Designer.Modified;
  end;
  Designer.ShowMethod(AMethodName);
end;

procedure TcxDesignHelper.UnselectObject(AOwner: TComponent; AObject: TPersistent);
begin
  Component := AOwner;
  UnselectObject(AObject);
end;

{$IFNDEF CLR}
function TcxDesignHelper.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxDesignHelper._AddRef: Integer; stdcall;
begin
  Result := -1;
end;

function TcxDesignHelper._Release: Integer; stdcall;
begin
  Result := -1;
end;
{$ENDIF}

procedure TcxDesignHelper.NotifyListeners(AList: TList);
var
  I: Integer;
  AIntf: IcxDesignSelectionChanged;
begin
  for I := 0 to FList.Count - 1 do
  begin
    if Supports(TObject(FList[I]), IcxDesignSelectionChanged, AIntf) then
    begin
      AIntf.DesignSelectionChanged(AList);
      AIntf := nil;
    end;
  end;
end;

procedure TcxDesignHelper.SelectionsChanged(Sender: TObject;
  const ASelection: TDesignerSelectionList);
var
  L: TList;
begin
  L := TList.Create;
  try
    ConvertSelectionToList(ASelection, L);
    NotifyListeners(L);
  finally
    L.Free;
  end;
end;

function TcxDesignHelper.GetDesigner: IDesigner;
begin
  if FDesigner = nil then
    FDesigner := GetObjectDesigner(FComponent);
  Result := FDesigner;
end;

{ TcxDesignWindow }

constructor TcxDesignWindow.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := DefFontData.Name;
end;

procedure TcxDesignWindow.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxDesignWindow.CancelUpdate;
begin
  Dec(FLockCount);
end;

procedure TcxDesignWindow.EndUpdate;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    UpdateSelection;
end;

class function TcxDesignWindow.GetBaseRegKey{$IFDEF DELPHI6}(ADesigner: IComponentDesigner = nil){$ENDIF}: string;
begin
{$IFDEF DELPHI6}
  if ADesigner = nil then
    ADesigner := ActiveDesigner;
  if ADesigner = nil then
    Result := ''
  else
    Result := ADesigner.Environment.GetBaseRegKey + '\' + SIniEditorsName;
{$ELSE}
  Result := DelphiIDE.GetBaseRegKey + '\' + SIniEditorsName;
{$ENDIF}
end;

procedure TcxDesignWindow.GetSelectionList(AList: TList);
var
  ASelectionList: TDesignerSelectionList;
begin
  ASelectionList := CreateDesignerSelectionList;
  try
    Designer.GetSelections(ASelectionList);
    ConvertSelectionToList(ASelectionList, AList);
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
end;

procedure TcxDesignWindow.SelectionChanged({$IFDEF DELPHI6}const ADesigner: IDesigner;{$ENDIF}
  {$IFDEF DELPHI6}const{$ENDIF}ASelection: TDesignerSelectionList);
begin
  if LockCount <> 0 then Exit;
  if Assigned(FOnSelectionsChanged) then
    FOnSelectionsChanged(Self, ASelection);
  {$IFDEF DELPHI6}
  if ADesigner = Designer then
  {$ENDIF}
    SelectionsChanged(ASelection);
end;

procedure TcxDesignWindow.SelectionsChanged(const ASelection: TDesignerSelectionList);
begin
end;

procedure TcxDesignWindow.SetSelectionList(AList: TList);
var
  ASelectionList: TDesignerSelectionList;
  I: Integer;
begin
  ASelectionList := CreateDesignerSelectionList;
  try
    for I := 0 to AList.Count - 1 do
      ASelectionList.Add(TPersistent(AList[I]));
    Designer.SetSelections(ASelectionList);
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
end;

procedure TcxDesignWindow.UpdateSelection;
var
  ASelectionList: TDesignerSelectionList;
begin
  ASelectionList := CreateDesignerSelectionList;
  try
    Designer.GetSelections(ASelectionList);
    SelectionChanged({$IFDEF DELPHI6}Designer, {$ENDIF}ASelectionList);
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
end;

procedure TcxDesignWindow.Activated;
begin
{$IFDEF DELPHI6}
  Designer.Activate;
{$ENDIF}
//  UpdateSelection; // TODO:
end;

function TcxDesignWindow.UniqueName(Component: TComponent): string;
begin
  Result := ''; //inherited UniqueName(Component);
end;

{$IFDEF CLR}
procedure TcxDesignWindow.ActivateInspector(Ch: Char);
begin
  inherited ActivateInspector(Ch);
end;
{$ENDIF}

{ TcxDesignFormEditor }

{$IFDEF DELPHI6}

procedure TcxDesignFormEditor.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
  inherited;
end;

{$ELSE}

procedure TcxDesignFormEditor.FormClosed(AForm: TCustomForm);
begin
  if Designer.Form = AForm then
    CloseEditor;
  inherited;
end;

procedure TcxDesignFormEditor.ComponentDeleted(Component: IPersistent);
var
  AItem: TPersistent;
begin
  AItem := TryExtractPersistent(Component);
  if AItem <> nil then
    ItemDeleted(Designer, AItem);
end;

procedure TcxDesignFormEditor.FormModified;
begin
  ItemsModified(Designer);
end;

{$ENDIF}

procedure TcxDesignFormEditor.DoItemsModified;
begin
end;

procedure TcxDesignFormEditor.ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  if (AItem = nil) or Closing then Exit;
  if (Component = nil) or (csDestroying in Component.ComponentState) or
    (AItem = Component) then
    CloseEditor;
end;

procedure TcxDesignFormEditor.ItemsModified(const Designer: IDesigner);
begin
 if Closing or (Component = nil) or (csDestroying in Component.ComponentState) then
   Exit;
  UpdateCaption;
  DoItemsModified;
end;

procedure TcxDesignFormEditor.SelectComponent(AComponent: TPersistent);
begin
  Designer.SelectComponent(AComponent);
end;

procedure TcxDesignFormEditor.SelectComponents(AList: TList; ADefaultComponent: TPersistent);
begin
  if not Active then Exit;
  if AList.Count > 0 then
    SetSelectionList(AList)
  else
    if Component <> nil then
    begin
      if ADefaultComponent <> nil then
        SelectComponent(ADefaultComponent)
      else
        SelectComponent(Component);
    end;
end;

procedure TcxDesignFormEditor.ListBoxApplySelection(AListBox: TListBox;
  ADefaultComponent: TPersistent);
var
  AList: TList;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      ListBoxGetSelection(AListBox, AList);
      SelectComponents(AList, ADefaultComponent);
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxDesignFormEditor.ListBoxSynchronizeSelection(AListBox: TListBox);
var
  AList: TList;
begin
  AList := TList.Create;
  try
    GetSelectionList(AList);
    ListBoxSyncSelection(AListBox, AList);
  finally
    AList.Free;
  end;
end;

{$IFDEF DELPHI9}
  {$IFNDEF CLR}
procedure TcxDesignFormEditor.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.MainForm.Handle;
end;
  {$ENDIF}
{$ENDIF}

procedure TcxDesignFormEditor.CloseEditor;
begin
  FClosing := True;
  Component := nil;
  ComponentProperty := nil;
  ComponentPropertyName := '';
  Close;
end;

procedure TcxDesignFormEditor.UpdateCaption;
var
  S: string;
begin
  if (Component <> nil) and (Component.Name <> '') then
  begin
    S := Component.Name;
    if Component.Owner <> nil then
      S := Component.Owner.Name + '.' + S;
    Caption := S;
  end;
end;

procedure TcxDesignFormEditor.InitFormEditor;
begin
  UpdateCaption;
end;

procedure TcxDesignFormEditor.UpdateContent;
begin
end;

function TcxDesignFormEditor.CanAddComponent: Boolean;
begin
  Result := cxDesignWindows.CanAddComponent(Component.Owner, Designer);
end;

function TcxDesignFormEditor.CanDeleteComponent(AComponent: TComponent): Boolean;
begin
  Result := cxDesignWindows.CanDeleteComponent(Component.Owner, AComponent, Designer);
end;

procedure TcxDesignFormEditor.FormCreate(Sender: TObject);
begin
  if Editors <> nil then
    Editors.Add(Self);
end;

procedure TcxDesignFormEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // TODO: save pos
  Action := caFree;
end;

procedure TcxDesignFormEditor.FormDestroy(Sender: TObject);
begin
  if Editors <> nil then
    Editors.Remove(Self);
end;

{$IFDEF CLR}
{ TcxDesignWindowAccess }

class procedure TcxDesignWindowAccess.ActivateInspector(
  AInstance: TcxDesignWindow; Ch: Char);
begin
  AInstance.ActivateInspector(Ch);
end;
{$ENDIF}

initialization

finalization
  FreeAndNil(Editors);

end.
