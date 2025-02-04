
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2007 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit cxLibraryReg;

{$I cxVer.inc}

interface

uses
  SysUtils,
{$IFDEF DELPHI6}
  {$IFDEF CLR}
    Borland.Vcl.Design.DesignIntf, Borland.Vcl.Design.DesignEditors,
  {$ELSE}
    DesignIntf, DesignEditors, DesignConst,
  {$ENDIF}
{$ELSE}
  DsgnIntf, SysConst, 
{$ENDIF}
  TypInfo, cxContainer, cxLookAndFeels,
{$IFNDEF CLR}
  cxPropertiesStore, cxPropertiesStoreEditor,
  PicEdit, dxGDIPlusAPI, dxGDIPlusClasses,
{$ENDIF}
  cxStyleRepositoryEditor, cxImageListEditor, cxStyles, Classes, Controls, Menus,
  cxControls, cxLookAndFeelPainters;

const
  dxCompanyName = 'Developer Express Inc.';
  dxCompanyURL = 'www.devexpress.com';

  sdxBitmapAndPNGFilter = 'All (*.bmp;*.png)|*.bmp;*.png|Bitmaps (*.bmp)|*.bmp|PNG graphics from DevExpress (*.png)|*.png';

type
{$IFNDEF DELPHI6}
  TGetPropProc = TGetPropEditProc;
{$ENDIF}

  { TcxComponentEditor }

  TcxComponentEditor = class(TComponentEditor)
  private
    function InternalGetVerbCount: Integer;
  protected
    function GetProductName: string; virtual; abstract;
    function GetProductMajorVersion: string; virtual; abstract;
    function GetProductVersion: string; virtual;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TcxControlPopupMenuProperty }

  TcxControlPopupMenuProperty = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{$IFNDEF CLR}
  { TcxGraphicProperty }

  TcxGraphicProperty = class(TGraphicProperty)
  private
    procedure OnShowPicEdit(Sender: TObject);
  protected
    function BuildFilter: string; virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TcxBitmapProperty = class(TcxGraphicProperty)
  protected
    function BuildFilter: string; override;
  end;

{$ENDIF}

procedure Register;

implementation

{$IFDEF CLR}
{$R TcxLookAndFeelController.bmp}
{$R TcxStyleRepository.bmp}
{$R TcxImageList.bmp}
{$ENDIF}

uses
{$IFDEF DELPHI6}
  {$IFDEF CLR}
    Borland.Vcl.Design.Surface, Borland.Vcl.Design.VCLEditors,
  {$ELSE}
    VCLEditors,
  {$ENDIF}
  Types,
{$ENDIF}
  Windows, Math, Graphics, Dialogs, ImgList, cxGraphics, cxDesignWindows, cxPropEditors,
  cxClasses;

const
  cxLibraryVersion = '6.24';

type
  TcxContainerAccess = class(TcxContainer);

  { TcxLibraryComponentEditor }

  TcxLibraryComponentEditor = class(TcxComponentEditor)
  protected
    function GetProductName: string; override;
    function GetProductVersion: string; override;
  end;

  { TcxLookAndFeelControllerEditor }

  TcxLookAndFeelControllerEditor = class(TcxLibraryComponentEditor)
  private
    function GetLookAndFeelController: TcxLookAndFeelController;
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TcxStyleRepositoryComponentEditor }

  TcxStyleRepositoryComponentEditor = class(TcxLibraryComponentEditor)
  private
    function GetStyleRepository: TcxStyleRepository;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{$IFNDEF CLR}

  { TcxPropertiesStoreComponentEditor }

  TcxPropertiesStoreComponentEditor = class(TcxLibraryComponentEditor)
  private
    function GetPropertiesStore: TcxPropertiesStore;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{$ENDIF}

  { TcxImageListComponentEditor }

  TcxImageListComponentEditor = class(TcxLibraryComponentEditor)
  private
    FImageLists: TStringList;
    procedure AddImageList(const AImageListName: string);
    function GetImageList: TcxImageList;
    property ImageList: TcxImageList read GetImageList;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TcxContainerStyleProperty }

  TcxContainerStyleProperty = class(TClassProperty)
  private
    FProc: TGetPropProc;
    procedure GetPropProc({$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxContainerStyleAssignedValuesProperty }

  TcxContainerStyleAssignedValuesProperty = class(TSetProperty)
  protected
    procedure FillVisiblePropertiesList(AList: TStringList);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  end;

  { TcxContainerStyleAssignedValuesElementProperty }

  TcxContainerStyleAssignedValuesElementProperty = class(TSetElementProperty)
{$IFNDEF DELPHI6}
  private
    FElement: Integer;
  protected
    constructor Create(Parent: TPropertyEditor; AElement: Integer);
    property Element: Integer read FElement;
{$ENDIF}
  public
    function GetName: string; override;
  end;

  { TcxLookAndFeelProperty }

  TcxLookAndFeelProperty = class(TClassProperty)
  private
    FProc: TGetPropProc;
    procedure GetPropProc({$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxLookAndFeelAssignedValuesProperty }

  TcxLookAndFeelAssignedValuesProperty = class(TSetProperty)
  protected
    FProc: TGetPropProc;
    procedure GetPropProc({$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

{ TcxLibraryComponentEditor }

function TcxLibraryComponentEditor.GetProductName: string;
begin
  Result := 'ExpressLibrary';
end;

function TcxLibraryComponentEditor.GetProductVersion: string;
begin
  Result := cxLibraryVersion;
end;

{ TcxLookAndFeelControllerEditor }

procedure TcxLookAndFeelControllerEditor.Edit;
begin
end;

procedure TcxLookAndFeelControllerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      begin
        with GetLookAndFeelController do
        begin
          Kind := cxDefaultLookAndFeelKind;
          NativeStyle := cxDefaultLookAndFeelNativeStyle;
        end;
        Designer.Modified;
      end;
  end;
end;

function TcxLookAndFeelControllerEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Reset'
  else
    Result := inherited GetVerb(Index);
end;

function TcxLookAndFeelControllerEditor.GetVerbCount: Integer;
begin
  Result := 1 + inherited GetVerbCount;
end;

function TcxLookAndFeelControllerEditor.GetLookAndFeelController: TcxLookAndFeelController;
begin
  Result := Component as TcxLookAndFeelController;
end;

{ TcxStyleRepositoryComponentEditor }

procedure TcxStyleRepositoryComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowStyleRepositoryEditor(Designer, GetStyleRepository);
end;

function TcxStyleRepositoryComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit...'
  else
    Result := inherited GetVerb(Index);
end;

function TcxStyleRepositoryComponentEditor.GetVerbCount: Integer;
begin
  Result := 1 + inherited GetVerbCount;
end;

function TcxStyleRepositoryComponentEditor.GetStyleRepository: TcxStyleRepository;
begin
  Result := Component as TcxStyleRepository;
end;

{ TcxStyleSheetComponentProperty }

type
  TcxStyleSheetComponentProperty = class(TComponentProperty)
  private
    FStrProc: TGetStrProc;
    procedure StrProc(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TcxStyleSheetComponentProperty.StrProc(const S: string);
begin
  if TcxStyles(GetComponent(0)).IsValidStyleSheet(TcxCustomStyleSheet(Designer.GetComponent(S))) then
    FStrProc(S);
end;

procedure TcxStyleSheetComponentProperty.GetValues(Proc: TGetStrProc);
begin
  FStrProc := Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType), StrProc);
end;

{$IFNDEF CLR}

{ TcxPropertiesStoreComponentEditor }

procedure TcxPropertiesStoreComponentEditor.ExecuteVerb(Index: Integer);
var
  AActive: Boolean;
  APropertiesStore: TcxPropertiesStore;

  procedure DsgnStoreTo;
  begin
    APropertiesStore := TcxPropertiesStore(Component);
    AActive := APropertiesStore.Active;
    APropertiesStore.Active := True;
    APropertiesStore.StoreTo;
    APropertiesStore.Active := AActive;
  end;

  procedure DsgnRestoreFrom;
  begin
    APropertiesStore := TcxPropertiesStore(Component);
    AActive := APropertiesStore.Active;
    APropertiesStore.Active := True;
    APropertiesStore.RestoreFrom;
    APropertiesStore.Active := AActive;
  end;
  
begin
  case Index of
    0: ShowPropertiesStoreEditor(GetPropertiesStore,
         {$IFNDEF DELPHI6}Designer.GetRoot{$ELSE}Designer.Root{$ENDIF}, Designer);
    2: DsgnStoreTo;
    3: DsgnRestoreFrom;
  end;
end;

function TcxPropertiesStoreComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit...';
    1: Result := '-';
    2: Result := 'Store';
    3: Result := 'Restore';
  else
    Result := inherited GetVerb(Index);
  end;
end;

function TcxPropertiesStoreComponentEditor.GetVerbCount: Integer;
begin
  Result := 1 + 3 + inherited GetVerbCount;
end;

function TcxPropertiesStoreComponentEditor.GetPropertiesStore: TcxPropertiesStore;
begin
  Result := Component as TcxPropertiesStore;
end;

{$ENDIF}

{ TcxImageListComponentEditor }

procedure TcxImageListComponentEditor.ExecuteVerb(Index: Integer);

  procedure Edit;
  begin
    FImageLists := TStringList.Create;
    try
      Designer.GetComponentNames(GetTypeData(TCustomImageList.ClassInfo), AddImageList);
      if cxEditImageList(ImageList, FImageLists) then
        Designer.Modified;
    finally
      FreeAndNil(FImageLists);
    end;
  end;
  
begin
  if (Index = 0) then
    Edit;
end;

function TcxImageListComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit...'
  else
    Result := inherited GetVerb(Index);
end;

function TcxImageListComponentEditor.GetVerbCount: Integer;
begin
  Result := 1 + inherited GetVerbCount;
end;

function TcxImageListComponentEditor.GetImageList: TcxImageList;
begin
  Result := Component as TcxImageList;
end;

procedure TcxImageListComponentEditor.AddImageList(const AImageListName: string);
var
  AImageList: TCustomImageList;
begin
  AImageList := TCustomImageList(Designer.GetComponent(AImageListName));
  if (AImageList <> ImageList) and
    (AImageList.Width = ImageList.Width) and
    (AImageList.Height = ImageList.Height) then
    FImageLists.AddObject(AImageListName, AImageList);
end;

{ TcxContainerStyleProperty }

procedure TcxContainerStyleProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxContainerStyleProperty.GetPropProc({$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if not TcxContainer(GetComponent(I)).IsStylePropertyPublished(Prop.GetName, GetName <> 'Style') then
      Exit;
  FProc(Prop);
end;

{ TcxContainerStyleAssignedValuesProperty }

procedure TcxContainerStyleAssignedValuesProperty.GetProperties(Proc: TGetPropProc);
var
  AStyleValueList: TStringList;
  I, AValue: Integer;
begin
  AStyleValueList := TStringList.Create;
  try
    FillVisiblePropertiesList(AStyleValueList);
    for I := 0 to AStyleValueList.Count - 1 do
    begin
    {$IFNDEF CLR}
      AValue := TcxContainerStyleValue(AStyleValueList.Objects[I]);
    {$ELSE}
      AValue := StrToInt(string(AStyleValueList.Objects[I]));
    {$ENDIF}
      Proc(TcxContainerStyleAssignedValuesElementProperty.Create(Self, AValue{$IFDEF CLR}, AValue{$ENDIF}));
    end;
  finally
    AStyleValueList.Free;
  end;
end;

function TcxContainerStyleAssignedValuesProperty.GetValue: string;
var
  AStyleValues: TcxContainerStyleValues;
  AStyleValueList: TStringList;
  I: Integer;
begin
{$IFDEF CLR}
  AStyleValues := TcxContainerStyleValues(GetOrdValue);
{$ELSE}
  Integer(AStyleValues) := GetOrdValue;
{$ENDIF}
  Result := '';
  AStyleValueList := TStringList.Create;
  try
    FillVisiblePropertiesList(AStyleValueList);
    for I := 0 to AStyleValueList.Count - 1 do
    {$IFNDEF CLR}
      if TcxContainerStyleValue(AStyleValueList.Objects[I]) in AStyleValues then
    {$ELSE}
      if StrToInt(string(AStyleValueList.Objects[I])) in AStyleValues then
    {$ENDIF}
        Result := Result + AStyleValueList[I] + ',';
    Delete(Result, Length(Result), 1);
    Result := '[' + Result + ']';
  finally
    AStyleValueList.Free;
  end;
end;

procedure TcxContainerStyleAssignedValuesProperty.FillVisiblePropertiesList(
  AList: TStringList);

{$IFDEF CLR}
  function IsPropertyUnique(const APropList: TPropList;
    const APropName: string): Boolean;
  var
    ACount, I: Integer;
  begin
    ACount := 0;
    for I := 0 to Length(APropList) - 1 do
      if APropList[I].Name = APropName then
        Inc(ACount);
    Result := ACount = 1;
  end;

  procedure CheckPropList(var APropList: TPropList);
  var
    I: Integer;
  begin
    I := 0;
    while I < Length(APropList) do
      if not IsPropertyUnique(APropList, APropList[I].Name) then
      begin
        if I < Length(APropList) - 1 then
          System.Array.Copy(APropList, I + 1, APropList, I, Length(APropList) - I - 1);
        SetLength(APropList, Length(APropList) - 1);
      end
      else
        Inc(I);
  end;
{$ENDIF}

  procedure FillStyleValueList(AStyle: TcxContainerStyle;
    AStyleValueList: TStringList);
  var
    APropertyCount, AStyleValueIndex, I: Integer;
    APPropList: PPropList;
    AStyleValue: TcxContainerStyleValue;
  begin
  {$IFDEF CLR}
    APPropList := GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray]);
    CheckPropList(APPropList);
    APropertyCount := Length(APPropList);
  {$ELSE}
    APropertyCount := GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray], nil);
  {$ENDIF}
    if APropertyCount = 0 then Exit;
  {$IFNDEF CLR}
    GetMem(APPropList, APropertyCount * SizeOf(Pointer));
  {$ENDIF}
    try
    {$IFDEF CLR}
      APPropList := GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray]);
      CheckPropList(APPropList);
    {$ELSE}
      GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray], APPropList);
    {$ENDIF}
      for I := 0 to APropertyCount - 1 do
      begin
        if not AStyle.GetStyleValue(APPropList[I].Name, AStyleValue) then
          Continue;
        if (AStyle.Container = nil) and ((AStyle.State = csNormal) or AStyle.IsExtendedStylePropertyPublished(APPropList[I].Name)) or
          (AStyle.Container <> nil) and AStyle.Container.IsStylePropertyPublished(APPropList[I].Name, AStyle.State <> csNormal) then
        begin
          AStyleValueIndex := AStyleValueList.IndexOf(APPropList[I].Name);
          if AStyleValueIndex = -1 then
            AStyleValueList.AddObject(APPropList[I].Name, {$IFNDEF CLR}TObject{$ELSE}IntToStr{$ENDIF}(1))
          else
            AStyleValueList.Objects[AStyleValueIndex] :=
            {$IFNDEF CLR}
              TObject(Integer(AStyleValueList.Objects[AStyleValueIndex]) + 1);
            {$ELSE}
              IntToStr(StrToInt(string(AStyleValueList.Objects[AStyleValueIndex])) + 1);
            {$ENDIF}
        end;
      end;
    finally
    {$IFNDEF CLR}
      FreeMem(APPropList);
    {$ENDIF}
    end;
  end;

var
  AStyleValue: TcxContainerStyleValue;
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    FillStyleValueList(TcxContainerStyle(GetComponent(I)), AList);
  AList.Sort;

  for I := AList.Count - 1 downto 0 do
  {$IFNDEF CLR}
    if Integer(AList.Objects[I]) <> PropCount then
  {$ELSE}
    if StrToInt(string(AList.Objects[I])) <> PropCount then
  {$ENDIF}
      AList.Delete(I)
    else
    begin
      TcxContainerStyle(GetComponent(0)).GetStyleValue(AList[I], AStyleValue);
      AList.Objects[I] := {$IFNDEF CLR}TObject{$ELSE}IntToStr{$ENDIF}(AStyleValue);
    end;
end;

{ TcxContainerStyleAssignedValuesElementProperty }

function TcxContainerStyleAssignedValuesElementProperty.GetName: string;
begin
  TcxContainerStyle(GetComponent(0)).GetStyleValueName(Element, Result);
end;

{$IFNDEF DELPHI6}
constructor TcxContainerStyleAssignedValuesElementProperty.Create(Parent: TPropertyEditor;
  AElement: Integer);
begin
  inherited Create(Parent, AElement);
  FElement := AElement;
end;
{$ENDIF}

{ TcxComponentEditor }

function TcxComponentEditor.GetVerb(Index: Integer): string;
begin
  Index := Index - (GetVerbCount - InternalGetVerbCount);
  case Index of
    0: Result := '-';
    1: Result := GetProductName + ' ' + GetProductVersion;
    2: Result := dxCompanyName;
    3: Result := dxCompanyURL;
  end;
end;

function TcxComponentEditor.GetVerbCount: Integer;
begin
  Result := InternalGetVerbCount;
end;

function TcxComponentEditor.GetProductVersion: string;
begin
  Result := Format('%s.%d', [GetProductMajorVersion, dxBuildNumber]);
end;

function TcxComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 4;
end;

{ TcxControlPopupMenuProperty }

procedure TcxControlPopupMenuProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(CheckComponent);
end;

procedure TcxControlPopupMenuProperty.CheckComponent(const Value: string);
var
  AComponent: TComponent;
  AIcxPopupMenu: IcxPopupMenu;
begin
  AComponent := Designer.GetComponent(Value);
  if AComponent <> nil then
  begin
    if (AComponent is TPopupMenu) or
      Supports(AComponent, IcxPopupMenu, AIcxPopupMenu) then
      FProc(Value);
  end;
end;

{ TcxLookAndFeelProperty }

procedure TcxLookAndFeelProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxLookAndFeelProperty.GetPropProc(
  {$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if SameText(Prop.GetName, 'SkinName') and
      (not ClassSupportsSkinProc(GetComponent(0)) or (GetExtendedStylePainters.Count = 0)) then Exit;
  FProc(Prop);
end;

{ TcxLookAndFeelAssignedValuesProperty }

procedure TcxLookAndFeelAssignedValuesProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxLookAndFeelAssignedValuesProperty.GetPropProc(
  {$IFNDEF DELPHI6}Prop: TPropertyEditor{$ELSE}const Prop: IProperty{$ENDIF});
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if SameText(Prop.GetName, 'lfvSkinName') and
      (not ClassSupportsSkinProc(TcxLookAndFeel(GetComponent(0)).Owner) or
      (GetExtendedStylePainters.Count = 0)) then Exit;
  FProc(Prop);
end;

{ TcxStyleProperty }

const
  sCreateNewStyleInRepositoryBegin = '<Create a new style in ';
  sCreateNewStyleInRepositoryEnd = '>';
  sCreateNewStyleInNewRepository = '<Create a new style in the new repository>';

  StylePreviewAreaWidth = 55;
  StylePreviewAreaOffset = 3;
  StyleTextOffset = 1;
  StylePreviewOffset = StyleTextOffset;
  StylePreviewBorderSize = 1;

type
  TcxStyleProperty = class(TComponentProperty{$IFDEF DELPHI6},
    ICustomPropertyDrawing, ICustomPropertyListDrawing{$ENDIF})
  private
    FStyleRepositories: TList;
    procedure GetStyleRepositoryNameProc(const S: string);
  protected
    // ICustomPropertyDrawing
  {$IFDEF DELPHI6}
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  {$ENDIF}
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);{$IFNDEF DELPHI6} override;{$ENDIF}
    // ICustomPropertyListDrawing
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);{$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);{$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);{$IFNDEF DELPHI6} override;{$ENDIF}

    function GetStyleRepositories: TList;
  public
    function AutoFill: Boolean; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

procedure TcxStyleProperty.GetStyleRepositoryNameProc(const S: string);
begin
  FStyleRepositories.Add(Designer.GetComponent(S));
end;

{$IFDEF DELPHI6}

procedure TcxStyleProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{$ENDIF}

procedure TcxStyleProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue = '' then
  {$IFDEF DELPHI6}
    DefaultPropertyDrawValue(Self, ACanvas, ARect)
  {$ELSE}
    inherited
  {$ENDIF}
  else
    ListDrawValue(GetVisualValue, ACanvas, ARect, ASelected);
end;

procedure TcxStyleProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas;
  var AWidth: Integer);
var
  AStyle: TcxStyle;
begin
  AStyle := Designer.GetComponent(Value) as TcxStyle;
  if AStyle <> nil then
    Inc(AWidth, StylePreviewAreaWidth + StylePreviewAreaOffset);
end;

procedure TcxStyleProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
var
  AComponent: TComponent;
  AStyle: TcxStyle;
  APrevFont: TFont;

  function GetItemHeight: Integer;
  begin
    Result := ACanvas.TextHeight('Qq') +
      2 * (StylePreviewOffset + StylePreviewBorderSize + StyleTextOffset);
  end;

begin
  AComponent := Designer.GetComponent(Value);
  if AComponent = nil then
    Inc(AHeight)
  else
    if AComponent is TcxStyle then
    begin
      AStyle := TcxStyle(AComponent);
      AHeight := GetItemHeight;
      if svFont in AStyle.AssignedValues then
      begin
        APrevFont := TFont.Create;
        APrevFont.Assign(ACanvas.Font);
        ACanvas.Font := AStyle.Font;
        AHeight := Max(AHeight, GetItemHeight);
        ACanvas.Font := APrevFont;
        APrevFont.Free;
      end;
    end;
end;

procedure TcxStyleProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
const
  PreviewText = 'Text Text Text Text Text';
var
  AStyle: TcxStyle;
  APrevBkColor, APrevTextColor: COLORREF;
  APrevFont: TFont;

  procedure SaveCanvasParams;
  begin
    APrevBkColor := GetBkColor(ACanvas.Handle);
    APrevTextColor := GetTextColor(ACanvas.Handle);
    APrevFont := TFont.Create;
    APrevFont.Assign(ACanvas.Font);
  end;

  procedure RestoreCanvasParams;
  begin
    ACanvas.Font := APrevFont;
    APrevFont.Free;
    SetBkColor(ACanvas.Handle, APrevBkColor);
    SetTextColor(ACanvas.Handle, APrevTextColor);
  end;

  function GetStyleNameRect: TRect;
  begin
    Result := ARect;
    Inc(Result.Left, StylePreviewAreaWidth + StylePreviewAreaOffset + StyleTextOffset);
    Result.Top := (Result.Top + Result.Bottom - ACanvas.TextHeight(Value)) div 2;
  end;

  (*procedure DrawStyleAssignedValuesInfo;
  const
    StyleValuesText = 'BCFT';
  var
    AInfoItemWidth, I, ATextX, ATextY: Integer;
    AStyleValue: TcxStyleValue;
  begin //!!!
    //ACanvas.Font.Style := [fsBold];
    AInfoItemWidth := 0;
    for I := 1 to Length(StyleValuesText) do
      AInfoItemWidth := Max(AInfoItemWidth, ACanvas.TextWidth(StyleValuesText[I]));

    with GetStyleNameRect do
    begin
      ATextX := Left - 40; //!!!
      ATextY := Top;
    end;

    for AStyleValue := Low(TcxStyleValue) to High(TcxStyleValue) do
    begin
      if AStyleValue in AStyle.AssignedValues then
        //ACanvas.Font.Style := [fsBold]
        ACanvas.Font.Color := APrevFont.Color
      else
        ACanvas.Font.Color := clBtnFace;
        //ACanvas.Font.Style := [];
      ACanvas.TextOut(ATextX, ATextY, StyleValuesText[1 + Ord(AStyleValue)]);
      Inc(ATextX, AInfoItemWidth);
    end;

    //ACanvas.Font.Style := [];
  end;*)

  function GetPreviewBounds: TRect;
  begin
    Result := ARect;
    Result.Right := Result.Left + StylePreviewAreaWidth;
    InflateRect(Result, -StylePreviewOffset, -StylePreviewOffset);
  end;

  function GetPreviewClientBounds: TRect;
  begin
    Result := GetPreviewBounds;
    InflateRect(Result, -StylePreviewBorderSize, -StylePreviewBorderSize);
  end;

  procedure DrawPreviewBorder;

    function GetBorderColor: TColor;
    begin
      if AStyle.AssignedValues * [svBitmap, svColor] = [] then
        if ColorToRGB(ACanvas.Brush.Color) = ColorToRGB(clBtnFace) then
          Result := clBtnShadow
        else
          Result := clBtnFace
      else
        Result := clWindowText;
    end;

  begin
    ACanvas.Brush.Color := GetBorderColor;
    ACanvas.FrameRect(GetPreviewBounds);
  end;

  procedure DrawPreviewBackground;
  var
    R, ABitmapR: TRect;
    AcxCanvas: TcxCanvas;
  begin
    R := GetPreviewClientBounds;
    if svBitmap in AStyle.AssignedValues then
    begin
      ABitmapR := R;
      if svColor in AStyle.AssignedValues then
        ABitmapR.Right := (R.Left + R.Right) div 2;
      AcxCanvas := TcxCanvas.Create(ACanvas);
      AcxCanvas.FillRect(ABitmapR, AStyle.Bitmap);
      AcxCanvas.Free;
      R.Left := ABitmapR.Right;
    end;
    if svColor in AStyle.AssignedValues then
    begin
      ACanvas.Brush.Color := AStyle.Color;
      ACanvas.FillRect(R);
    end;
  end;

  procedure DrawPreviewText;
  var
    ATextR: TRect;

    function GetTextColor: TColor;
    begin
      if svTextColor in AStyle.AssignedValues then
        Result := AStyle.TextColor
      else
        {if svColor in AStyle.AssignedValues then
          Result := ColorToRGB(AStyle.Color) xor clWhite  //!!!
        else}
          Result := APrevFont.Color;
    end;

    function GetTextTopBound: Integer;
    begin
      Result := (ATextR.Top + ATextR.Bottom - ACanvas.TextHeight(PreviewText)) div 2;
    end;

  begin
    if AStyle.AssignedValues * [svFont, svTextColor] = [] then Exit;
    if svFont in AStyle.AssignedValues then
      ACanvas.Font := AStyle.Font;
    ACanvas.Font.Color := GetTextColor;
    ATextR := GetPreviewClientBounds;
    ACanvas.Brush.Style := bsClear;
    ACanvas.TextRect(ATextR, ATextR.Left + StyleTextOffset, GetTextTopBound, PreviewText);
    ACanvas.Brush.Style := bsSolid;
  end;

begin
  AStyle := Designer.GetComponent(Value) as TcxStyle;
  if AStyle = nil then
  {$IFDEF DELPHI6}
    DefaultPropertyListDrawValue(Value, ACanvas, ARect, ASelected)
  {$ELSE}
    inherited
  {$ENDIF}  
  else
  begin
    SaveCanvasParams;  // for correct focus rect drawing and height measurement
    with GetStyleNameRect do
      ACanvas.TextRect(ARect, Left, Top, Value);
    //DrawStyleAssignedValuesInfo;
    DrawPreviewBorder;
    DrawPreviewBackground;
    DrawPreviewText;
    RestoreCanvasParams;
  end;
end;
  
function TcxStyleProperty.GetStyleRepositories: TList;
begin
  Result := TList.Create;
  FStyleRepositories := Result;
  Designer.GetComponentNames(GetTypeData(TcxStyleRepository.ClassInfo), GetStyleRepositoryNameProc);
end;

function TcxStyleProperty.AutoFill: Boolean;
begin
  Result := False;
end;

procedure TcxStyleProperty.GetValues(Proc: TGetStrProc);
var
  AStyleRepositories: TList;
  I: Integer;
  S: string;
begin
  AStyleRepositories := GetStyleRepositories;
  try
    for I := 0 to AStyleRepositories.Count - 1 do
    begin
      S := Designer.GetComponentName(TComponent(AStyleRepositories[I]));
      Proc(sCreateNewStyleInRepositoryBegin + S + sCreateNewStyleInRepositoryEnd);
    end;
  finally
    AStyleRepositories.Free;
  end;
  Proc(sCreateNewStyleInNewRepository);
  inherited;
end;

procedure TcxStyleProperty.SetValue(const Value: string);
var
  AName: string;
  AStyleRepository: TcxStyleRepository;

  procedure CreateAndAssignNewStyle(AStyleRepository: TcxStyleRepository);
  var
    AStyle: TcxStyle;

    function GetStyleDesigner: IDesigner;
    begin
    {$IFNDEF CLR}
      Result := FindRootDesigner(AStyle) as IDesigner;
    {$ELSE}
      Result := TDesignSurface(AStyle.GetRootDesigner).Designer;
    {$ENDIF}
      //FindRootDesigner(AStyle).QueryInterface(IDesigner, Result);
    end;

  begin
    AStyle := AStyleRepository.CreateItemEx(TcxStyle, AStyleRepository.Owner) as TcxStyle;
    AStyle.Name := CreateUniqueName(AStyle.Owner, nil, AStyle, '', '');
    if GetStyleDesigner <> Designer then
      FindRootDesigner(AStyle).Modified;
  {$IFDEF CLR}
    SetObjValue(AStyle);
  {$ELSE}
    SetOrdValue(Integer(AStyle));
  {$ENDIF}  
  end;

begin
  if Value = sCreateNewStyleInNewRepository then
  begin
    AStyleRepository := TcxStyleRepository.Create(Designer.{$IFDEF DELPHI6}Root{$ELSE}GetRoot{$ENDIF});
    AStyleRepository.Name := Designer.UniqueName(
      Copy(TcxStyleRepository.ClassName, 2, Length(TcxStyleRepository.ClassName) - 1));
    CreateAndAssignNewStyle(AStyleRepository);
  end
  else
    if Copy(Value, 1, Length(sCreateNewStyleInRepositoryBegin)) = sCreateNewStyleInRepositoryBegin then
    begin
      AName := Copy(Value, Length(sCreateNewStyleInRepositoryBegin) + 1,
        Length(Value) - (Length(sCreateNewStyleInRepositoryBegin) + Length(sCreateNewStyleInRepositoryEnd)));
      CreateAndAssignNewStyle(Designer.GetComponent(AName) as TcxStyleRepository);
    end
    else
      inherited;
end;

{$IFNDEF CLR}

{ TcxGraphicProperty }

procedure TcxGraphicProperty.Edit;
var
  PictureEditor: TPictureEditor;
  PictureEditorDlg: TWinControl;
begin
  PictureEditor := TPictureEditor.Create(nil);
  try
    PictureEditor.GraphicClass := TGraphicClass(GetTypeData(GetPropType)^.ClassType);
    PictureEditor.Picture.Graphic := TGraphic(Pointer(GetOrdValue));
    with PictureEditor do
    begin
      if BuildFilter <> '' then
      begin
        PictureEditorDlg := FindControl(FindWindow('TPictureEditorDlg', nil));
        if PictureEditorDlg is TPictureEditorDlg then
          TPictureEditorDlg(PictureEditorDlg).OnShow := OnShowPicEdit;
      end;
      if Execute then                     
        if (Picture.Graphic = nil) or (Picture.Graphic is GraphicClass) then
          SetOrdValue(LongInt(Picture.Graphic))
        else
          if Picture.Graphic is TdxPNGImage then
            SetOrdValue(LongInt(TdxPNGImage(Picture.Graphic).GetAsBitmap))
          else
            raise Exception.CreateRes(@SInvalidFormat)
    end;
  finally
    PictureEditor.Free;
  end;
end;

function TcxGraphicProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TcxGraphicProperty.GetValue: string;
var
  Graphic: TGraphic;
begin
  Graphic := TGraphic(GetOrdValue);
  if (Graphic = nil) or Graphic.Empty then
    Result := 'None'
  else
    Result := '(' + Graphic.ClassName + ')';
end;

procedure TcxGraphicProperty.SetValue(const Value: string);
begin
  if Value = '' then SetOrdValue(0);
end;

procedure TcxGraphicProperty.OnShowPicEdit(Sender: TObject);
begin
  if Sender is TPictureEditorDlg then
    TPictureEditorDlg(Sender).OpenDialog.Filter := BuildFilter;
end;

function TcxGraphicProperty.BuildFilter: string;
begin
  Result := '';
end;

{ TcxBitmapProperty }

function TcxBitmapProperty.BuildFilter: string;
begin
  if CheckGdiPlus then
    Result := sdxBitmapAndPNGFilter
  else
    Result := '';
end;

{$ENDIF}

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponentEditor(TcxLookAndFeelController, TcxLookAndFeelControllerEditor);
  RegisterPropertyEditor(TypeInfo(TcxCustomStyleSheet), TcxStyles, 'StyleSheet', TcxStyleSheetComponentProperty);
  RegisterComponentEditor(TcxStyleRepository, TcxStyleRepositoryComponentEditor);
{$IFNDEF CLR}
  RegisterComponentEditor(TcxImageList, TcxImageListComponentEditor);
  RegisterComponentEditor(TcxPropertiesStore, TcxPropertiesStoreComponentEditor);
  RegisterComponents('Dev Express', [TcxPropertiesStore, TcxImageList]);
  RegisterPropertyEditor(TypeInfo(TBitmap), nil, '', TcxGraphicProperty);
{$ENDIF}
  RegisterComponents('Dev Express', [TcxLookAndFeelController, TcxStyleRepository]);

  RegisterPropertyEditor(TypeInfo(TcxStyleController), TcxStyleController, 'FakeStyleController', nil);
  RegisterPropertyEditor(TypeInfo(TcxStyleController), TcxContainer, 'FakeStyleController', nil);
  RegisterPropertyEditor(TypeInfo(TcxContainerStyle), TcxContainer, '', TcxContainerStyleProperty);
  RegisterPropertyEditor(TypeInfo(TcxContainerStyle), TcxStyleController, '',
    TcxStyleControllerStyleProperty);

  RegisterPropertyEditor(TypeInfo(TComponent), TcxControl, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TcxStyle), nil, '', TcxStyleProperty);

  RegisterClasses([TcxStyle]);
  RegisterNoIcon([TcxStyle]);

  RegisterPropertyEditor(TypeInfo(TcxContainerStyleValues), TcxContainerStyle,
    'AssignedValues', TcxContainerStyleAssignedValuesProperty);

  RegisterPropertyEditor(TypeInfo(TcxLookAndFeel), nil, '', TcxLookAndFeelProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxLookAndFeelController, 'SkinName', nil);
  RegisterPropertyEditor(TypeInfo(TcxLookAndFeelValues), TcxLookAndFeel,
    'AssignedValues', TcxLookAndFeelAssignedValuesProperty);
end;

{$IFDEF DELPHI6}
initialization
  StartClassGroup(TControl);
{$IFNDEF CLR}
  GroupDescendentsWith(TcxCustomPropertiesStore, TControl);
{$ENDIF}
{$ENDIF}

end.
