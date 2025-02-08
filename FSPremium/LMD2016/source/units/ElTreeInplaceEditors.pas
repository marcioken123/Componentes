unit ElTreeInplaceEditors;
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

ElTreeInplaceEditors unit
-------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Messages, Windows, Graphics, Forms, StdCtrls,
  ExtCtrls, CommCtrl,  Types,  ImgList, Buttons, Menus,
  Variants, Imm, ActiveX, TypInfo,

  LMDVldBase,
  LMDElConst, LMDClass, LMDThemes, Themes, LMDTypes,
  {$ifdef LMD_UNICODE}LMDUnicodeStrings,{$endif}
  LMDHTMLUnit, LMDObjectList, LMDProcs, LMDGraphUtils,

  ElStyleMan, ElComponent,  ElHook, ElXPThemedControl,
  ElHeader, ElSBCtrl, ElScrollBar, ElHintWnd, ElInputProcessor,
  ElIni, LMDGlyphs, ElImgFrm, ElDragDrop, ElVCLUtils;

const
  DefaultTreeOwnerDrawMask = '~~@~~';

type
  {$EXTERNALSYM TElFieldType}
  TElFieldType = ElHeader.TElFieldType;
  {$EXTERNALSYM TElFieldTypes}
  TElFieldTypes = ElHeader.TElFieldTypes;
  TSTItemPart  = (ipButton, ipMainText, ipColumn, ipInside, ipPicture, ipPicture2, ipCheckBox, ipGutter, ipOutside);
  TSTXItemPart  = TSTItemPart;
  TElDragType = (dtOLE, dtDelphi, dtBoth);
  TSTSelModes  = (smSimple, smUsual);
  TSortDirs    = (sdAscend, sdDescend);
  TSortModes   = (smNone, smAdd, smClick, smAddClick);
  TSortTypes   = (stCustom, stText, stNumber, stFloating, stDateTime, stDate, stTime, stBoolean, stCurrency);
  THintModes   = (shmNone, shmLong, shmAll);
  TLineHintType= (lhtMainTextOnly, lhtCellTextOnly, lhtSmart);
  TElHintType  = (shtMainText, shtHintOnly, shtHintOrText);
  TDragImgMode = (dimNever, dimOne, dimAll);
  TNodeAttachMode = (naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert);
  TElCheckBoxType = (ectCheckBox, ect3SCheckBox, ectRadioButton);
  TElDblClickMode = (dcmNone, dcmExpand, dcmEdit);
  TElIncSearchScope = (issWholeTree, issWithinParent);
  TElIncSearchColumn = (iscMainText, iscSortColumn);
  TVirtualityLevel= (vlNone,{ vlText,} vlTextAndStyles, vlAllProps);
  TElItemBorderStyle  = (ibsNone, ibsRaised, ibsFlat, ibsSunken, ibsSpace);
  TItemChangeMode = (icmText, icmState, icmCheckState, icmColumnText);

  TColumnNotifyEvent = procedure(Sender: TObject; SectionIndex: Integer) of object;

  EElTreeError = class(Exception)
  end;

  TElVirtPropType = (vptMainText, // item text
                     vptCellText, // cell text
                     vptStyles,   // ibfUseStyles and all styles
                     vptFontStyle,// item main text style
                     vptVisual,   // assorted drawing flags
                     vptHTML,     // ibfHintIsHTML
                     vptCheck,    // check box flags
                     vptSelection,// reserved
                     vptButtons,  // button flags
                     vptImages,   // item images
                     vptColors,   // item colors
                     vptEdit,     // ibfAllowEdit
                     vptIndent    // ibfIndentAdjust
                    );
  TElVirtPropTypes = set of TElVirtPropType;

  TDragTargetDraw = (ColorFrame,
                     ColorRect,
                     SelColorRect,
                     dtdNone,
                     dtdUpColorLine,
                     dtdDownColorLine,
                     dtdUpSelColorLine,
                     dtdDownSelColorLine);
     // ColorFrame - usual background, color frame
     // ColorRect  - green rect (drop allowed) or red rect (drop not allowed)
     // SelColorRect - usual selected color rect

// *****************************************************************************

const
  AllVirtPropTypes = [vptMainText, vptCellText, vptStyles, vptFontStyle, vptVisual, vptHTML, vptCheck, vptSelection, vptButtons, vptImages, vptColors, vptEdit, vptIndent];

type
  TElTreeInplaceEditor = class;
  TInplaceOperationEvent      = procedure (Sender: TObject; var DefaultConversion: boolean) of object;
  TInplaceAfterOperationEvent = procedure (Sender: TObject; var Accepted: boolean; var DefaultConversion: boolean) of object;
  TInplaceValidationEvent     = procedure (Sender: TObject; var InputValid: boolean) of object;
  TInplaceOperationCompleteEvent = procedure (Editor: TElTreeInplaceEditor; Accepted: boolean) of object;

  TElTreeInplaceManager = class;
  TElTreeViewAncestor = class;

  IElTreeView = interface
    procedure EditOperationAccepted;
    procedure EditOperationCancelled;
  end;

  {$hints off}
  IElTree = interface
    function GetEditorManager: TElTreeInplaceManager;
    function GetView: TElTreeViewAncestor;
    property View: TElTreeViewAncestor read GetView;
  end;
  {$hints on}

  TElTreeViewAncestor = class(TCustomControl) //, IElTreeView)
  protected
    procedure EditOperationAccepted; virtual; abstract;
    procedure EditOperationCancelled; virtual; abstract;
  end;

  TElTreeAncestor = class(TElXPThemedControl) //, IElTree)
  protected
    FOnEditKeyDown: TKeyEvent;
    FHorizontalLines,
    FVerticalLines: Boolean;
    FExplorerEditMode: Boolean;
    FEditorManager: TElTreeInplaceManager;
    //    function GetEditorManager: TElTreeInplaceManager; virtual; abstract;
    function GetTreeViewAncestor: TElTreeViewAncestor; virtual; abstract;
    function GetAlignmentOnSection(SectionIndex: integer): string; virtual; abstract;
  public
    property View: TElTreeViewAncestor read GetTreeViewAncestor;
    property EditorManager: TElTreeInplaceManager read FEditorManager;
    property OnEditKeyDown: TKeyEvent read FOnEditKeyDown write FOnEditKeyDown;
  end;

  TElTreeInplaceManager = class(TElComponent)
  protected
    FEditorsList: TLMDObjectList;
    procedure RegisterEditor(Editor: TElTreeInplaceEditor);
    procedure UnregisterEditor(Editor: TElTreeInplaceEditor);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSuitableEditor(SupposedFieldType: TElFieldType): TElTreeInplaceEditor;
  published
  end;

  THackWinControl = class(TWinControl);

  TElTreeInplaceEditor = class(TElComponent)
  private
    procedure SetCellRect(const Value: TRect);
    procedure SetDataType(const Value: TElFieldType);
    procedure SetItem(const Value: TPersistent);
    procedure SetSectionIndex(const Value: Integer);
    procedure SetValueAsText(const Value: TLMDString);
  protected
    FFont: TFont;
    FEditor: TWinControl;
    FExplorerEditMode: boolean;
    FDefaultValueAsText: TLMDString;
    FEditing: boolean;
    FTree: TElTreeAncestor;
//    FContainer: TWinControl;
    FTypes: TElFieldTypes;
    FItem: TPersistent;
    FValueAsText: TLMDString;
    FSectionIndex: Integer;
    FDataType: TElFieldType;
    FCellRect: TRect;
    CanReFocus: boolean;
    FOnBeforeOperation: TInplaceOperationEvent;
    FOnAfterOperation: TInplaceAfterOperationEvent;
    FOnValidateResult: TInplaceValidationEvent;
    FInputChecked: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetTree(Value: TElTreeAncestor);
    function GetVisible: Boolean; virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetEditorParent; virtual;

    procedure TriggerBeforeOperation(var DefaultConversion: boolean); virtual;
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); virtual;
    procedure TriggerKeyDown(Message: TWMKey); virtual;
    procedure DoStartOperation; virtual;
    procedure DoStopOperation(Accepted: boolean); virtual;
    procedure FontChange(Sender: TObject);
    procedure EndEditWithInputChecked;

    procedure AdjustBounds; virtual;
    procedure AdjustBoundsRect(var r: TRect); virtual;
    function IsVistaUp: boolean;
    function HorizontalLines: boolean;
    function VerticalLines: boolean;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure StartOperation; virtual;
    procedure CompleteOperation(Accepted: boolean); virtual;

    procedure TriggerValidateResult(var InputValid: boolean); virtual;
    property Font: TFont read FFont write SetFont stored True;
    property Item: TPersistent read FItem write SetItem;
    property ValueAsText: TLMDString read FValueAsText write SetValueAsText;
    property SectionIndex: Integer read FSectionIndex write SetSectionIndex;
    property DataType: TElFieldType read FDataType write SetDataType;
    property CellRect: TRect read FCellRect write SetCellRect;
    property Visible: Boolean read GetVisible;
    property Editing: Boolean read FEditing;
    property InputChecked: Boolean read FinputChecked write FInputChecked;
  published
    property Tree: TElTreeAncestor read FTree write SetTree;
    property Types: TElFieldTypes read FTypes write FTypes default [];
    property DefaultValueAsText: TLMDString read FDefaultValueAsText write
      FDefaultValueAsText;
    property OnBeforeOperation: TInplaceOperationEvent read FOnBeforeOperation
      write FOnBeforeOperation;
    property OnAfterOperation: TInplaceAfterOperationEvent read FOnAfterOperation
      write FOnAfterOperation;
    property OnValidateResult: TInplaceValidationEvent read FOnValidateResult
      write FOnValidateResult;
  end;

implementation

uses
  LMDSysIn;

procedure TElTreeInplaceEditor.SetTree(Value: TElTreeAncestor);
begin
  if FTree <> Value then
  begin
    if Visible then CompleteOperation(false);
    if FTree <> nil then
      FTree.EditorManager.UnregisterEditor(Self);
    FTree := Value;
    if FTree <> nil then
      FTree.EditorManager.RegisterEditor(Self);
  end;
end;

procedure TElTreeInplaceEditor.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
// {
  if Operation = opRemove then
  begin
    if AComponent = FTree then
      Tree := nil;

    if (FTree <> nil) and (AComponent = FTree.FEditorManager) then
    begin
      if Visible then
        CompleteOperation(false);
      FTree.FEditorManager.UnregisterEditor(Self);
      FTree := nil;
    end;
  end;
// }
end;

procedure TElTreeInplaceEditor.CompleteOperation(Accepted: boolean);
var AcceptResults,
    DefaultConversion: boolean;
    AForm: TForm;
begin
  FEditing := false;
  AcceptResults := Accepted;
  TriggerAfterOperation(AcceptResults, DefaultConversion);
  AForm := TForm(GetParentForm(FTree));
  CanReFocus := (AForm <> nil) and (AForm.ActiveControl <> nil);
  DoStopOperation(true);
  if AcceptResults then
    FTree.View.EditOperationAccepted
  else
    FTree.View.EditOperationCancelled;
end;

procedure TElTreeInplaceEditor.SetEditorParent;
begin
  // default implementation does nothing
end;

procedure TElTreeInplaceEditor.StartOperation;
var
  DefaultConversion: boolean;
  LAlignment: string;
  PropInfo   : PPropInfo;
begin
  SetEditorParent;
  LAlignment := FTree.GetAlignmentOnSection(SectionIndex);
  if LAlignment <> 'none' then
  begin
    PropInfo := TypInfo.GetPropInfo(FEditor, 'Alignment');
    if PropInfo <> nil then
      SetEnumProp(FEditor, PropInfo, LAlignment);
  end;
  if Assigned(FEditor) then
    THackWinControl(FEditor).Font := FFont;
  TriggerBeforeOperation(DefaultConversion);
  DoStartOperation();
  FEditing := true;
  FInputChecked := False;

  if FEditor <> nil then
    FEditor.Update;
end;

procedure TElTreeInplaceEditor.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  DefaultConversion := true;
  if Assigned(FOnBeforeOperation) then
    FOnBeforeOperation(Self, DefaultConversion);
  if DefaultConversion and (ValueAsText = '') then
    FValueAsText := DefaultValueAsText;
end;

procedure TElTreeInplaceEditor.TriggerKeyDown(Message: TWMKey);
begin
  if Assigned(Tree.OnEditKeyDown) then
    Tree.OnEditKeyDown(Self, Message.CharCode, KeyDataToShiftState(Message.KeyData));
end;

procedure TElTreeInplaceEditor.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  DefaultConversion := true;
  if Assigned(FOnAfterOperation) then
    FOnAfterOperation(Self, Accepted, DefaultConversion);
end;

procedure TElTreeInplaceEditor.TriggerValidateResult(var InputValid: boolean);
begin
  if Assigned(FOnValidateResult) then
    FOnValidateResult(Self, InputValid);
end;

procedure TElTreeInplaceEditor.DoStartOperation;
begin
  // intentionally left blank
end;

procedure TElTreeInplaceEditor.DoStopOperation(Accepted: boolean);
begin
  if FTree.View.CanFocus and FTree.CanFocus and FTree.Parent.CanFocus and (not (csDestroying in FTree.ComponentState)) then
  try
    if CanRefocus then
      FTree.View.SetFocus;
  except
  end;
end;

procedure TElTreeInplaceEditor.SetCellRect(const Value: TRect);
begin
  FCellRect := Value;
end;

procedure TElTreeInplaceEditor.SetDataType(const Value: TElFieldType);
begin
  FDataType := Value;
end;

procedure TElTreeInplaceEditor.SetItem(const Value: TPersistent);
begin
  FItem := Value;
end;

procedure TElTreeInplaceEditor.SetSectionIndex(const Value: Integer);
begin
  FSectionIndex := Value;
end;

procedure TElTreeInplaceEditor.SetValueAsText(const Value: TLMDString);
begin
  FValueAsText := Value;
end;

procedure TElTreeInplaceManager.RegisterEditor(Editor: TElTreeInplaceEditor);
begin
  if FEditorsList.IndexOf(Editor) = -1 then
  begin
    FEditorsList.Add(Editor);
    Editor.FreeNotification(Self);
  end;
end;

procedure TElTreeInplaceManager.UnregisterEditor(Editor: TElTreeInplaceEditor);
begin
  FEditorsList.Remove(Editor);
  if not (csDestroying in Editor.ComponentState) then
    Editor.RemoveFreeNotification(Self);
  end;

constructor TElTreeInplaceManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditorsList := TLMDObjectList.Create;
end;

destructor TElTreeInplaceManager.Destroy;
begin
  inherited;
  FEditorsList.Free;
  FEditorsList := nil;
end;

function TElTreeInplaceManager.GetSuitableEditor(SupposedFieldType :
    TElFieldType): TElTreeInplaceEditor;
var i: integer;
    Editor: TElTreeInplaceEditor;
begin
  Result := nil;
  for i := 0 to FEditorsList.Count - 1 do
  begin
    Editor := TElTreeInplaceEditor(FEditorsList[i]);
    if SupposedFieldType in Editor.Types then
    begin
      Result := Editor;
      exit;
    end;
  end;
end;

procedure TElTreeInplaceManager.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TElTreeInplaceEditor) then
  begin
    FEditorsList.Remove(AComponent);
  end;
end;

constructor TElTreeInplaceEditor.Create(AOwner: TComponent);
begin
  inherited;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
end;

procedure TElTreeInplaceEditor.FontChange(Sender: TObject);
begin
  if Assigned(FEditor) and Assigned(FEditor.Parent) then
    THackWinControl(FEditor).Font := FFont;
end;

procedure TElTreeInplaceEditor.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
  end;
end;

destructor TElTreeInplaceEditor.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TElTreeInplaceEditor.EndEditWithInputChecked;
var
  InputValid : boolean;
begin
  if not InputChecked then
  begin
    InputValid := true;
    TriggerValidateResult(InputValid);
    CompleteOperation(InputValid);
  end
  else
    CompleteOperation(true);
end;

function TElTreeInplaceEditor.HorizontalLines: boolean;
begin
  result :=  TElTreeAncestor(FTree).FHorizontalLines;
end;

function TElTreeInplaceEditor.VerticalLines: boolean;
begin
  result := TElTreeAncestor(FTree).FVerticalLines;
  end;

function TElTreeInplaceEditor.IsVistaUp: boolean;
begin
  result := LMDSIWindowsVistaUp;
end;

procedure TElTreeInplaceEditor.AdjustBounds;
begin
//do nothing in base class
end;

procedure TElTreeInplaceEditor.AdjustBoundsRect(var r: TRect);
begin
  if VerticalLines and not IsVistaUp then
    OffsetRect(r, -1, 0);
  if not VerticalLines and IsVistaUp then
    Inc(r.Right, 1);
end;

end.
