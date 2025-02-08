unit wwfltdlg;
{
//
// Components : TwwFilterDialog
//
// Copyright (c) 1996-2001 by Woll2Woll Software
//
//
// 9/9/97 - Support alternate display label when operating against a
//          joined query.  Previously SelectedField mappings were ignored
//
// 10/25/97 - Get session name to assign to temporary table object
//
// 11/12/97 - Hide range value select tab if its a memo field for a query
//
// 11/18/97 - Remove Form.IsValueType reference so it works without dialog
//
// 11/18/97 - Treat boolean as non-value type
//
// 11/18/97 - 16 bit BDE treat boolean as string by using quotes when creating sql
// 1/8/98 - Check to see if displaylabel is defined in selectedfields
// 1/17/98 - Add '$' to list of valid characters for GetWord to handle tablenames
//           with $ in them.
//
// 2/24/98 - Support ending range pad character
//
// 4/22/98 - Free FFldList items before clearing it
// 4/30/98 - Default Field would not be on correct field if displaylabel contained '~'
// 9/18/98 - Don't reference wwFilterMemoSize in destructor
// 9/30/98 - When replacing where clause, do not include blank lines
// 10/1/98 - Fix problems when using queries with parameterized queries.
// 11/17/98 - Set patch[0] to True to preserve filter even when dataset is closed
// 11/24/98 - Set patch[1] to True to preserve old behavior of enclosing value in single quotes
//            New behavior supports single quotes in text
// 12/9/98 - Skip clearing of filter when closing table. This fixes a problem
//           where the filter was cleared the 2nd time when optimizations to
//           use table indexes were performed.
// 2/23/99 - Give owner to TempDataSet for 3rd party engines
// 4/8/99 -  Make sure its TParams, so virtual datasets that don't use TParams won't throw an exception
// 5/20/99 - Recognize and save date/time pair
// 5/20/99 - Use AnsiUpperCase instead of Uppercase when converting field value.
// 6/5/99  - RSW - Repaint calling form
// 6/25/99 - Support mapped list
// 9/17/99 - Added FixedChar Support.
// 11/22/99 - Maplist support
// 12/3/99 - fix incompatibility with usetfields and sqltables property.
// 01/13/00 - Add OnEncodeValue event so that user can change how the value is formatted
//            when forming sql string
// 2/01/2000 - Support aliases in fieldnames when using FieldsFetchMethod of fmUseTFields
// 2/8/2000 - Add SQLPropertyName property so that you can use it with component that use
//            a different property name besides SQL.
// 2/9/2000 - Use TDefCollection Find so that FieldDef = nil does not throw exception
// 4/21/00 - Remove patch[0] reference
// 5/1/00 - Restore original case for replacewhereclause
// 5/20/00 - Memo fields should not use = operator
// 6/4/00 - Support values of "or" and "and" as field values instead
//          of operators
// 6/07/00 - PYW - Only put the date and time when there is a Time Value and/or when
//             there is a time separator in the Max Date Range TwwDBDateTimePicker text.
// 7/2/00 - Support non ttables partial match for value type
// 7/25/00 - Fix index out of range problem with filterdialog
// 7/31/00 - Some dataset's close dataset when filter set to false so prevent
//           clearing of fieldinfo
// 11/21/00 - Support OnEncodeValue event for range
// 5/11/2001 - PYW Truncate word after encoding value.
// 8/7/01 - 2nd Time in dialog, it defaults to the wrong tab page.
//          Should default to searched fields tab page.
// 1/4/02 - Refresh with all fields when new search button is clicked.
// 2/28/02 - Make procedure AdjustFieldTabSet public.
// 6/17/02 - Make default (necessary when no bitmaps in button
// 6/25/02 - Support non-tstring type
}
interface

{$i wwIfDef.pas}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DB, Wwdatsrc, ExtCtrls, Buttons, wwfltdum, dbtables,
  Tabs, wwcommon, wwsystem, wwDialog, wwDBDateTimePicker, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwclearbuttongroup, wwradiogroup, ComCtrls;


type
  TwwFilterDialogOption = (fdCaseSensitive, fdShowCaseSensitive, fdShowOKCancel,
                               fdShowViewSummary, fdShowFieldOrder,
                               fdShowValueRangeTab, fdShowNonMatching,
                               fdHidePartialAnywhere, fdDisableDateTimePicker, fdSizeable,
                               fdTabsAtTop);

  TwwFilterFieldsFetchType = (fmUseTTable, fmUseSQL, fmUseTFields);
  TwwFilterDialogOptions = set of TwwFilterDialogOption;

  TwwFilterDialogSort = (fdSortByFieldNo, fdSortByFieldName);
  TwwFilterMatchType = (fdMatchStart, fdMatchAny, fdMatchExact,
                        fdMatchEnd, fdMatchRange, fdMatchNone);
  TwwFilterMethodAll = (fdByFilter, fdByQueryModify, fdByQueryParams);
  TwwFilterMethod = fdByFilter..fdByQueryModify;

  TwwDefaultMatchType = fdMatchStart..fdMatchExact;
  TwwDefaultFilterBy = (fdSmartFilter, fdFilterByRange, fdFilterByValue);
  TwwFilterDlg = class;
  TwwFilterDialogSummaryEvent = procedure(Sender: TObject; AFieldInfo: TList;
     var DoDefault: boolean) of object;
  TwwOnInitTempDataSetEvent = procedure(
     Sender: TObject;
     OrigDataSet, TempDataSet: TDataSet) of object;
  TwwOnInitFilterDlgEvent = procedure(Dialog : TwwFilterDlg) of object;
  TwwOnExecuteSQLEvent = procedure(Dialog: TwwFilterDlg; Query: TQuery) of object;
  TwwOnEncodeValueEvent = procedure(AFieldType: TFieldType;
       AFieldName: string; var AUserValue: string) of object;
  TwwOnEncodeDateTimeEvent = procedure(ADateTime: TDateTime;
       AFieldType: TFieldType; AFieldName: string; var FormattedDateStr: string) of object;
  TwwFilterOptimization = (fdNone, fdUseAllIndexes, fdUseActiveIndex);
  TwwQueryFormatDateMode = (qfdMonthDayYear, qfdDayMonthYear, qfdYearMonthDay);
  TwwOnSelectFilterField = procedure(
     Sender: TObject;
     FieldName: string;
     var PictureMask: string; ComboList: TStrings) of object;
  TwwOnAcceptFilterRecord = procedure(Sender: TObject;
     DataSet: TDataSet; var Accept: boolean; var DefaultFiltering: boolean) of object;

  TwwFieldInfo = class
  public
     FieldName: string;
     DisplayLabel: string;
     MatchType: TwwFilterMatchType;
     FilterValue: string;
     MinValue: string;
     MaxValue: string;
     CaseSensitive: boolean;
     NonMatching: boolean;
  end;

  TwwFilterDlg = class(TForm)
    FieldCriteriaPanel: TPanel;
    SelectNotebook: TPageControl;
    TabSheet1: TTabSheet;
    FieldValueLbl: TLabel;
    MatchTypeGroup: TRadioGroup;
    Panel1: TPanel;
    CaseSensitive: TCheckBox;
    Nonmatching: TCheckBox;
    FilterValueClearButton: TBitBtn;
    FilterValueCombo: TwwDBComboBox;
    FilterValueEdit: TwwDBEdit;
    TabSheet2: TTabSheet;
    StartingRangeLbl: TLabel;
    EndingRangeLbl: TLabel;
    MinValueEdit: TEdit;
    MaxValueEdit: TEdit;
    MinValueClearButton: TBitBtn;
    MaxValueClearButton: TBitBtn;
    MinDateEdit: TwwDBDateTimePicker;
    MaxDateEdit: TwwDBDateTimePicker;
    FieldListPanel: TPanel;
    FieldTabSet: TTabControl;
    FieldsListBox: TListBox;
    ButtonPanel: TPanel;
    ViewButton: TButton;
    ClearSearchButton: TButton;
    OKCancelPanel: TPanel;
    CriteriaLabelPanel: TPanel;
    FieldCriteria: TLabel;
    FieldsLabelPanel: TPanel;
    FieldsLbl: TLabel;
    FieldOrderPanel: TPanel;
    FieldOrder: TRadioGroup;
    procedure FieldOrderClick(Sender: TObject);
    procedure FieldsListBoxClick(Sender: TObject);
    procedure ViewButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ValueRangeTabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ClearSearchButtonClick(Sender: TObject);
    procedure FilterValueComboChange(Sender: TObject);
    procedure MinValueEditChange(Sender: TObject);
    procedure MaxValueEditChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure MinValueClearButtonClick(Sender: TObject);
    procedure MaxValueClearButtonClick(Sender: TObject);
    procedure FilterValueClearButtonClick(Sender: TObject);
    procedure MatchTypeGroupClick(Sender: TObject);
    procedure FieldTabSetChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FieldCriteriaPanelResize(Sender: TObject);
  private
    LastItemIndex: integer;
    FormActivated: boolean;

    Function IsValueField(ADisplayLabel: string): boolean;
    Function IsValueType(AFieldType: TFieldType): boolean;
    Procedure RefreshClearbutton;
    Function ValidEditValue(val: string): boolean;
    Function ValidEditValues(val: string): boolean; {paul}
    procedure ApplyIntl;
    Function GetFieldType(ADisplayLabel: wwSmallString): TFieldType;
    procedure UpdateFilterEditControl;
    function GetSQLPropertyname: string;
    procedure ShowValueRangeTabs;
  protected   {!!!! - 3/19/2001 - PYW - Move to Protected From Private to allow further customization of dialog.}
    DlgComponent: TComponent;
    DlgDataSet: TDataSet;
    FieldInfo: TList;
    MinValueEditControl, MaxValueEditControl: TCustomEdit;
    FilterValueEditControl: TCustomEdit;
  public
     OKBtn, CancelBtn: TButton;
     FilterChanged: Boolean;

     Procedure RefreshFieldList(ShowAll: boolean);
     procedure AdjustFieldTabSet(NewTab: integer);
     constructor CreateDlg(AOwner: TComponent; ADlgComponent: TComponent);
     destructor Destroy; override;
     Function SelectField(FieldChanged: boolean): boolean;
     Procedure SelectPage;
     Procedure SelectFocus;
     procedure SetFilterfield(ADisplayLabel: wwSmallString;
       AMatchType: TwwFilterMatchType; AFilterValue, AMinValue, AMaxValue: string;
       ACaseSensitive, ANonMatching: boolean);
     Function GetFilterField(ADisplayLabel: wwSmallString; var FldInfo: TwwFieldInfo): boolean;
     Procedure CopyList(fromlist, tolist: TList);

  end;

  TwwDBFieldInfo = class
  public
     LogicalFieldName: string;
     PhysicalFieldName: string;
     TableName: string;
     FieldType: TFieldType;
     DisplayLabel: string;
     Size: integer;
  end;

  TwwDatasetFilterType = (fdUseOnFilter, fdUseFilterProp, fdUseBothFilterTypes);
  TwwFilterPropertyOptions = class(TPersistent)
  private
     FDatasetFilterType: TwwDatasetFilterType;
     FLikeWildcardChar: string;
     FUseBracketsAroundFields: boolean;
     FUseLikeOperator: boolean;
     FLikeSupportsUpperKeyword: boolean;
  published
     property DatasetFilterType: TwwDatasetFilterType read FDatasetFilterType write FDataSetFilterType default fdUseOnFilter;
     property UseLikeOperator : boolean read FUseLikeOperator write FUseLikeOperator default False;
     property LikeWildcardChar: string read FLikeWildcardChar write FLikeWildcardChar;
     property LikeSupportsUpperKeyword: boolean read FLikeSupportsUpperKeyword write FLikeSupportsUpperKeyword default false;
     property UseBracketsAroundFields: boolean read FUseBracketsAroundFields write FUseBracketsAroundFields default true;
  end;

  TwwFieldOperators = class(TPersistent)
  private
     FOrChar: string;
     FAndChar: string;
     FNullChar: string;
     procedure SetOrChar(val: string);
     procedure SetAndChar(val: string);
     procedure SetNullChar(val: string);
     procedure SetOpChar(var opchar: string; val:string);
  public
     constructor Create(Owner: TComponent);
  published
     property OrChar: string read FOrChar write SetOrChar;
     property AndChar: string read FAndChar write SetAndChar;
     property NullChar: string read FNullChar write SetNullChar;
  end;

  TwwSQLTablesCollectionItem = class(TCollectionItem)
  private
    FTableName: string;
    FTableAliasName: string;
  protected
    function GetDisplayName: string; override;
  published
    property TableName: string read FTableName write FTableName;
    property TableAliasName: string read FTableAliasName write FTableAliasName;
  end;


  TwwSQLTablesCollection = class(TCollection)
  protected
    Control: TComponent;
    function GetOwner: TPersistent; override;
//    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Control: TComponent);
    function Add: TwwSQLTablesCollectionItem;
  end;


  TwwOnFilterPropertyOption = (fdClearWhenNoCriteria,
                               fdClearWhenCloseDataSet);
  TwwOnFilterPropertyOptions = set of TwwOnFilterPropertyOption;


  TwwFilterDialog = class(TwwCustomDialog)
  private
     FDataLink: TDataLink;
     FOptions: TwwFilterDialogOptions;
     FSortBy: TwwFilterDialogSort;
     FDummyForm: TwwDummyForm;
     FTitle: String;
     FFilterMethod: TwwFilterMethod;
     FDefaultMatchType: TwwDefaultMatchType;
     FDefaultFilterBy: TwwDefaultFilterBy;
     FDefaultField: string;
     FSelectedFields: TStrings;
     FOnInitDialog: TwwOnInitFilterDlgEvent;
     FOnExecuteSQL: TwwOnExecuteSQLEvent;
     FwwOperators: TwwFieldOperators;
     FRangeApplied: boolean;
     FFilterOptimization: TwwFilterOptimization;
     FUpperRangePadChar: word;
     FDlgHeight: integer;
     FOnEncodeValue : TwwOnEncodeValueEvent;
     FOnEncodeDateTime : TwwOnEncodeDateTimeEvent;
     FOnSelectField: TwwOnSelectFilterField;
     FOnInitTempDataSet:  TwwOnInitTempDataSetEvent;
     FOnAcceptFilterRecord: TwwOnAcceptFilterRecord;
     FFieldsFetchMethod : TwwFilterFieldsFetchType;
     FOnDialogSummary: TwwFilterDialogSummaryEvent;

     FOrigSQL: TStrings;
     FFldList: TList;
     FShowDialog: boolean;
     FDependentComponents: Tlist;
     FQueryFormatDateMode : TwwQueryFormatDateMode;
     FFilterPropertyOptions: TwwFilterPropertyOptions;
     FOnFilterPropertyOptions: TwwOnFilterPropertyOptions;
     FSQLTables: TwwSQLTablesCollection;
     FSQLUpperString: string;
     SkipClearFieldInfo: boolean;
     FSQLPropertyName: string;

     procedure SetDataSource(value : TDataSource);
     function GetDataSource: TDataSource;
     procedure SetFilterMethod(val: TwwFilterMethod);
     procedure ReplaceRemoteSQL(querySQL: TStrings);
     Function PadUpperRange(size: integer; val: string): string;
     Procedure SetDlgHeight(val: integer);
     function GetEffectiveSQLUpperString: string;

  protected
      procedure FilterDialogView(AFieldInfo: TList); virtual;
      function GetSQLPropertyname: string; virtual;
      Procedure DoInitDialog; virtual;   { This method should only be called by TwwFilterDlg }
      Function AddDBFieldInfo: TwwDBFieldInfo;
      procedure LinkActive(active: Boolean); virtual;
      Procedure DoSelectField(
          FieldName: string;
          var PictureMask: string;
          ComboList: TStrings); virtual;
      Procedure DoInitTempDataSet(OrigDataSet, TempDataset: TDataSet); virtual;
      Procedure DoAcceptFilterRecord(DataSet: TDataSet;
         var Accept: boolean;
         var DefaultFiltering: boolean); virtual;
     Procedure InitQueryFields; virtual;
     Procedure InitTableFields; virtual;
     Procedure ReplaceWhereClause(whereClause: TStrings); virtual;
  public
     MemoBuffer: PChar;
     Form: TwwFilterDlg;
     FieldInfo: TList;
     FieldsInDblQuotes: boolean;
     Patch: Variant;

     SQLWhereClause: TStringList;

     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     Function ExecuteDialog(ExecuteQuery: boolean = True;
                      ReturnWhereClause: TStrings = nil): boolean;
     Function Execute: boolean; override;
     function GetPrimaryDataSet: TDataSet; override;
     Procedure ApplyFilter;
     Procedure ClearFilter;
     Procedure InitFields; virtual;
     property AllFields: TList read FFldList; { Used by filter fields property editor}
     property ShowDialog: boolean read FShowDialog write FShowDialog;
     Function GetDBInfoForField(AFilterFieldName: wwSmallString): TwwDBFieldInfo; { Used by filter fields property editor}
     Procedure AddDependent(value: TComponent);
     Procedure RemoveDependent(value: TComponent);
     Function AddFieldInfo: TwwFieldInfo;

  published
     property DataSource: TDataSource read GetDataSource write SetDataSource;
     property OnDialogSummary: TwwFilterDialogSummaryEvent read FOnDialogSummary write FOnDialogSummary;
     property Options: TwwFilterDialogOptions read FOptions write FOptions default
              [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder,
               fdShowValueRangeTab];

     property SortBy: TwwFilterDialogSort read FSortBy write FSortBy;
     property Caption: string read FTitle write FTitle;
     property FilterMethod: TwwFilterMethod read FFilterMethod write SetFilterMethod;
     property DefaultMatchType: TwwDefaultMatchType read FDefaultMatchType write FDefaultMatchType;
     property DefaultFilterBy: TwwDefaultFilterBy read FDefaultFilterBy write FDefaultFilterBy;
     property DefaultField: string read FDefaultField write FDefaultField;
     property FieldsFetchMethod : TwwFilterFieldsFetchType read FFieldsFetchMethod write FFieldsFetchMethod default fmUseTTable;
     property FieldOperators: TwwFieldOperators read FwwOperators write FwwOperators;
     property FilterPropertyOptions: TwwFilterPropertyOptions read FFilterPropertyOptions write FFilterPropertyOptions;
     property OnFilterPropertyOptions: TwwOnFilterPropertyOptions read FOnFilterPropertyOptions write FOnFilterPropertyOptions
                  Default [fdClearWhenNoCriteria,
                           fdClearWhenCloseDataSet];
     property SelectedFields: TStrings read FSelectedFields write FSelectedFields;
     property FilterOptimization: TwwFilterOptimization read FFilterOptimization write FFilterOptimization;
     property UpperRangePadChar: word read FUpperRangePadChar write FUpperRangePadChar default 122;
     property DlgHeight: integer read FDlgHeight write SetDlgHeight default 267;
     property QueryFormatDateMode : TwwQueryFormatDateMode read FQueryFormatDateMode write FQueryFormatDateMode;
     property SQLTables: TwwSQLTablesCollection read FSQLTables write FSQLTables;
     property SQLUpperString: string read FSQLUpperString write FSQLUpperString;
     property SQLPropertyName: string read FSQLPropertyName write FSQLPropertyName;

     property OnInitDialog: TwwOnInitFilterDlgEvent read FOnInitDialog write FOnInitDialog;
     property OnExecuteSQL: TwwOnExecuteSQLEvent read FOnExecuteSQL write FOnExecuteSQL;
     property OnEncodeValue : TwwOnEncodeValueEvent read FOnEncodeValue write FOnEncodeValue;
     property OnEncodeDateTime : TwwOnEncodeDateTimeEvent read FOnEncodeDateTime write FOnEncodeDateTime;
     property OnSelectField: TwwOnSelectFilterField read FOnSelectField write FOnSelectField;
     property OnInitTempDataSet: TwwOnInitTempDataSetEvent
              read FOnInitTempDataSet write FOnInitTempDataSet;
     property OnAcceptFilterRecord: TwwOnAcceptFilterRecord
              read FOnAcceptFilterRecord write FOnAcceptFilterRecord;

  end;

  TwwFilterDataLink = class(TDataLink)
    private
      FilterDialog: TwwFilterDialog;
    protected
      procedure ActiveChanged; override;
    public
      constructor Create(AFilterDialog: TwwFilterDialog);
  end;


  Function wwGetFilterOperator(FilterValue: string;
                             FilterOperator: TwwFieldOperators;
                             var OrFlg: boolean; var AndFlg: boolean): string;

  Function wwGetFilterToken(FilterValue: string;
                          SearchDelimiter: string;
                          var CurPos: integer): string;

Function wwPadUpperRange(size: integer; s: string; UpperRangePadChar: word): string;

  procedure Register;

var
  wwFilterDlg: TwwFilterDlg;

implementation
{$R *.DFM}

uses wwtable, wwquery, wwqbe, wwstorep, wwstr, wwfltvw, wwtypes, wwintl, 
 {$ifdef wwDelphi6Up}
 variants,
 {$endif}
 typinfo;

const dbl='"';
      single='''';

constructor TwwFieldOperators.Create(Owner: TComponent);
begin
   FOrChar:= 'or';
   FAndChar:= 'and';
   FNullChar := 'null';
end;

Procedure TwwFilterDlg.CopyList(fromlist, tolist: TList);
var i: integer;
    srcFieldInfo, tempFieldInfo: TwwFieldInfo;
begin
   for i:= 0 to toList.count-1 do TwwFieldInfo(toList[i]).Free;
   toList.clear;
   for i:= 0 to fromList.count-1 do begin
      tempFieldInfo:= TwwFieldInfo.create;
      srcFieldInfo:= TwwFieldInfo(fromList[i]);
      if srcFieldInfo.DisplayLabel='' then
         srcFieldInfo.DisplayLabel:= srcFieldInfo.FieldName;

      tempFieldInfo.DisplayLabel:= srcFieldInfo.DisplayLabel;
      tempFieldInfo.MatchType:= srcFieldInfo.MatchType;
      tempFieldInfo.FilterValue:= srcFieldInfo.FilterValue;
      tempFieldInfo.MinValue:= srcFieldInfo.MinValue;
      tempFieldInfo.MaxValue:= srcFieldInfo.MaxValue;
      tempFieldInfo.CaseSensitive:= srcFieldInfo.CaseSensitive;
      tempFieldInfo.NonMatching:= srcFieldInfo.NonMatching;

      tempFieldInfo.FieldName:= wwGetFieldNameFromTitle(DlgDataSet, srcFieldInfo.DisplayLabel);

      toList.add(tempFieldInfo);
   end;
end;

constructor TwwFilterDlg.CreateDlg(AOwner: TComponent; ADlgComponent: TComponent);
begin
  inherited Create(AOwner);
  FieldInfo:= TList.create;
  DlgDataSet:= TwwFilterDialog(ADlgComponent).DataSource.DataSet;
  CopyList(TwwFilterDialog(ADlgComponent).FieldInfo, FieldInfo);
  LastItemIndex:= -1;
  FormActivated:= False;
  DlgComponent:= ADlgComponent;
  (DlgComponent as TwwFilterDialog).InitFields;

  OkBtn:= TButton(wwCreateCommonButton(self, bkOK));
  OkBtn.default:=true;  // 6/17/02 - Make default (necessary when no bitmaps in button
  OKBtn.parent:= OKCancelPanel;
  OKBtn.TabOrder := 2;
  OKBtn.Top:= (22 * PixelsPerInch) div 96;
  OKBtn.Left:= ((7 * PixelsPerInch) div 96);
//  OKBtn.Left := FieldCriteria.Left + FieldCriteria.Width + ((7 * PixelsPerInch) div 96);
//  OKBtn.Left := SelectNotebook.Left + SelectNotebook.Width + ((7 * PixelsPerInch) div 96);
  OKBtn.visible:= True;
  OkBtn.enabled:= False;
  CancelBtn:= TButton(wwCreateCommonButton(self, bkCancel));
  CancelBtn.parent:= OKCancelPanel;
  CancelBtn.TabOrder := 3;
  CancelBtn.Top:= (62 * PixelsPerInch) div 96;
  CancelBtn.Left := ((7 * PixelsPerInch) div 96);
//  CancelBtn.Left := FieldCriteria.Left + FieldCriteria.Width + ((7 * PixelsPerInch) div 96);
//  CancelBtn.Left := SelectNotebook.Left + SelectNotebook.Width + ((7 * PixelsPerInch) div 96);
  cancelBtn.visible:= True;
//  SelectNotebook.borderstyle:= bsNone;
end;

destructor TwwFilterDlg.Destroy;
var i :integer;
begin
  for i:= 0 to FieldInfo.count-1 do TwwFieldInfo(FieldInfo[i]).Free; { Free items }
  FieldInfo.Free;
  inherited destroy;
end;

constructor TwwFilterDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink:= TwwFilterDataLink.create(self);
  FSortBy:= fdSortByFieldNo;
  FDummyForm:= TwwDummyForm.create(self);
  FDummyForm.DlgComponent:= self;
  GetMem(MemoBuffer, wwFilterMemoSize);
  FieldInfo:= TList.create;
  FOrigSQL:= TStringList.create;
  FFldList:= TList.create;
  FFilterMethod:= fdByFilter;
  FSelectedFields:= TStringlist.create;
  FOptions:= [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab];
  FShowDialog:= True;
  FDependentComponents:= TList.create;
  FwwOperators:=TwwFieldOperators.create(self);
  FUpperRangePadChar:= 122;
  FDlgHeight:= 267;
  FQueryFormatDateMode := qfdMonthDayYear;
  FieldsInDblQuotes:= False;
  FFilterPropertyOptions:= TwwFilterPropertyOptions.create;
  FFilterPropertyOptions.UseBracketsAroundFields:= True;
  FFilterPropertyOptions.LikeWildcardChar:='%';
  FSQLTables:= TwwSQLTablesCollection.create(self);

  FOnFilterPropertyOptions:= [fdClearWhenNoCriteria, fdClearWhenCloseDataSet];

  Patch:= VarArrayCreate([0, 2], varVariant);
  Patch[0]:= False; { 11/17/98 - Set to True to preserve filter even when dataset is closed }
  Patch[1]:= False; { 11/24/98 - Set to True to preserve old behavior of enclosing value in single quotes }
                    { New behavior supports single quotes in text }
  Patch[2]:= False; { Set to true to disable checking of origin }
  FieldsFetchMethod := fmUseTTable;
  SQLWhereClause:= TStringList.create;

end;

destructor TwwFilterDialog.Destroy;
var i: integer;
begin
  { Detach onFilter event 10/22/96 -
    Consider case where table is destroyed before dialog.
    Comment out code until this issue is resolved.   }
{  if datasource.dataset is TwwQuery then
     (datasource.dataset as TwwQuery).OnFilter:= nil
  else if datasource.dataset is TwwTable then
     (datasource.dataset as TwwTable).OnFilter:= nil
  else if datasource.dataset is TwwQBE then
     (datasource.dataset as TwwQBE).onFilter:= nil;
}
  FDataLink.free;
  FDataLink:= Nil;
  FDummyForm.Free;
  FwwOperators.Free;
//  FreeMem(memoBuffer, wwFilterMemoSize);
  FreeMem(memoBuffer);  { 9/18/98 - Don't reference wwFilterMemoSize in destructor }

  for i:= 0 to FieldInfo.count-1 do TwwFieldInfo(FieldInfo[i]).Free;
  FieldInfo.Free;
  FOrigSQL.free;

  for i:= 0 to FFldList.count-1 do TwwDBFieldInfo(FFldList[i]).Free;
  FFldList.Free;
  FSelectedFields.Free;

  for i:= 0 to FDependentComponents.count-1 do
     TwwCheatCastNotify(FDependentComponents[i]).notification(self, opRemove);
  FDependentComponents.Free;
  FFilterPropertyOptions.Free;
  FSQLTables.Free;
  SQLWhereClause.Free;

  inherited destroy;
end;

Procedure TwwFilterDialog.SetDlgHeight(val: integer);
begin
   if val>267 then FDlgHeight:= val;
end;

procedure TwwFilterDialog.SetDataSource(value : TDataSource);
begin
   if (value<>nil) and (value.dataset<>nil) then begin
      if (value.dataset is TTable) then
        FFilterMethod:= fdByFilter
   end;
   FDataLink.dataSource:= value;
end;

function TwwFilterDialog.GetPrimaryDataSet: TDataSet;
begin
  if DataSource = nil then result := nil else result := DataSource.DataSet;
end;

Function TwwFilterDialog.GetDataSource: TDataSource;
begin
   if FDataLink<>Nil then Result:= FDataLink.dataSource
   else Result:= nil;
end;

{ Fill listbox with fields }
Procedure TwwFilterDlg.RefreshFieldList(ShowAll: boolean);
var i, curpos: integer;
    FldInfo: TwwFieldInfo;
    ParamName: wwSmallString;
    query: TQuery;
    Dlg: TwwFilterDialog;
    dbInfo: TwwDBFieldInfo;
    TempDisplayLabel, FieldName: wwSmallString;

    Procedure AddFieldToListBox(ADisplaylabel: wwSmallString);
    var TempLabelName: wwSmallString;
    begin
       if ShowAll or (GetFilterField(ADisplayLabel, FldInfo)) then
       begin
         TempLabelname:= strReplaceChar(ADisplayLabel,'~', ' ');
         if FieldsListBox.items.indexOf(TempLabelName)<0 then
            FieldsListBox.items.add(TempLabelname);
       end
    end;


begin
   FieldsListBox.items.clear;
   FieldsListBox.sorted:= (FieldOrder.itemIndex = 0);
   Dlg:= DlgComponent as TwwFilterDialog;

   if (DlgDataSet is TQuery) and
      (Dlg.FilterMethod=fdByQueryParams) then begin
      query:= DlgDataset as TQuery;
      for i:= 0 to query.ParamCount-1 do begin
         ParamName:= query.Params.items[i].name;
         if ShowAll or (GetFilterField(ParamName, FldInfo)) then
         begin
            FieldsListBox.items.add(ParamName);
         end
      end;
      exit;
   end;

   if Dlg.SelectedFields.count=0 then begin
      for i:= 0 to Dlg.FFldList.count-1 do begin
         if not wwValidFilterableFieldType(TwwDBFieldInfo(Dlg.FFldList[i]).FieldType) then continue;
         AddFieldToListBox(TwwDBFieldInfo(Dlg.FFldList[i]).DisplayLabel);
      end
   end
   else begin
      for i:= 0 to Dlg.SelectedFields.count-1 do begin
         curpos:= 1;
         FieldName:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
         dbInfo:= Dlg.GetDBInfoForField(FieldName);
         if dbInfo=nil then continue;
//         if not wwValidFilterableFieldType(dbInfo.FieldType) then continue;

         { 9/9/97 - Check display label if SelectedFields is overriding it for multiple table queries }
         TempDisplayLabel:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
         if TempDisplayLabel<>'' then
         begin
            AddFieldToListBox(TempDisplayLabel);
            dbInfo.DisplayLabel:= TempDisplayLabel;
         end
         else AddFieldToListBox(dbInfo.DisplayLabel);
      end
   end;
end;

Function GetWord(s: string; var APos: integer): string;
begin
   result:= wwGetSQLWord(s, APos);
end;


procedure TwwFilterDialog.ReplaceRemoteSQL(querySQL: TStrings);
begin
//   if wwIsClass(datasource.dataset.classType, 'TwwClientDataSet') then
     wwSetSQLProp(datasource.dataset, querysql, GetSQLPropertyName);
end;

Procedure TwwFilterDialog.ReplaceWhereClause(whereClause: TStrings);
var querysql: TStrings;
    PropInfo: PPropInfo;
    i,j, APos: integer;
    line: string;
    word: string;
    startline, lastpos, startPos: integer;
//    tempParamCheck: boolean;
    tempParams: Tparams;
    SQLStringType: boolean;
    querySQLString: string;
    PreText: string;

    Function isKeyWord(word: string): boolean;
    begin
      result:=
         (word='WHERE') or
         (word='GROUP') or (word='HAVING') or
         (word='UNION') or (word='PLAN') or
         (word='ORDER') or (word='FOR');
    end;

begin
   startpos:= 0; lastpos:= 0; startLine:= 0; { Make compiler happy}

   PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,GetSQLPropertyName);
   SQLStringType:= False;

   if PropInfo<>Nil then
   begin
      if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then
      begin
         querysqlstring:=  GetStrProp(DataSource.DataSet, PropInfo);
         SQLStringType:=True;
         querysql:= TStringlist.create;
         querysql.Add(querysqlstring);
      end
      else
         querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo))
   end
   else exit;

   if querysql.count=0 then exit;
   if whereClause.count=0 then exit;

   tempParams:= wwGetParamsProp(datasource.dataset);
   { 4/8/99 - Make sure its TParams, so virtual datasets that don't use TParams won't throw an exception }
   if (tempParams<>nil) and wwIsClass(tempParams.ClassType, 'TParams') then
   begin
      tempParams:= Tparams.create; { 10/1/98 }
      tempParams.assign(wwGetParamsProp(datasource.dataset));
   end;

//   tempParamCheck:= wwGetParamCheck(DataSource.DataSet);
//   wwSetParamCheck(Datasource.dataset, False);

   Try
      for i:= 0 to querysql.count-1 do begin
         line:= uppercase(querysql[i]);
         APos:= 1;
         repeat
            word:= GetWord(line, APos);
         until (isKeyWord(word) or (word=''));
         if isKeyWord(word) then begin
            startLine:= i;
            startPos:= APos;
            break;
         end
      end;

      if word='WHERE' then
      begin
         startPos:= startPos + 5; { Skip where keyword }

         { Find end of where clause and append to where clause }
         for i:= startLine to querysql.count-1 do begin
            line:= uppercase(querysql[i]);
            APos:= startPos;
            repeat
               lastPos:= APos;
               word:= GetWord(line, APos);
            until (isKeyWord(word) or (word=''));
            if isKeyWord(word) then break;
            startPos:= 1;
         end;
         if (i>=querysql.count) then i:= i - 1;
         line := querysql[i]; // 5/1/00 - Restore original case // 7/25/00 - Move down 1 line
         if copy(line, 1, lastpos-1)<>'' then
            querysql[i]:= copy(line, 1, lastPos-1)
         else begin { 9/30/98 }
            querysql.delete(i);
            i:= i - 1;
         end;

         querysql.insert(i+1, 'And');
         if copy(line, lastPos, length(line))<>'' then { 9/30/98 - Don't add if blank}
            querysql.insert(i+2, copy(line, lastPos, length(line)));
         inc(i); { Insert after 'And'}
      end
      else begin
         if word='' then begin
            querysql.add('Where');
            for j:= 0 to whereClause.count-1 do
              querysql.add(whereClause[j]);
            ReplaceRemoteSQL(querySQL);
            exit;
         end
         else begin
            // 7/17/02 - Allow keyword to be in middle of text (such as orderby)
            PreText:= copy(querysql[startLine], 1, startPos-length(word)-2);
            strStripPreceding(PreText, [' ',#9]);
            if PreText<>'' then
            begin
              querysql.insert(startLine, PreText);
              querysql.insert(startLine+1, 'Where');
              for j:= 0 to whereClause.count-1 do
                 querysql.insert(startLine+j+2, whereClause[j]);
              querysql[startLine+whereClause.count+2]:= copy(querySQL[startLine+whereClause.count+2], startPos-length(word), length(line));
              ReplaceRemoteSQL(querySQL);
              exit;
            end
            else
               querysql.insert(i, 'Where');
         end
      end;

      for j:= 0 to whereClause.count-1 do
         querysql.insert(i+j+1, whereClause[j]);
      ReplaceRemoteSQL(querySQL);

   finally
      if SQLStringtype then querySQL.Free;

      { 4/8/99 - Make sure its TParams, so virtual datasets that don't use TParams won't throw an exception }
      if (tempParams<>nil) and
        wwIsClass(tempParams.ClassType, 'TParams') then
      begin
        if (tempParams<>nil) and (tempParams.count>=0) then { 10/1/98 }
           wwSetParamsProp(datasource.dataset, tempParams);
        tempParams.Free;
      end
//      wwSetParamCheck(datasource.dataset, tempParamCheck);
   end;

end;

procedure TwwFilterDialog.InitFields;
begin
   { Initializes FieldDefs for dataset}
   if (FilterMethod=fdByQueryModify) then
      InitQueryFields
   else begin
      InitTableFields;
   end
end;

Function TwwFilterDlg.IsValueField(ADisplayLabel: string): boolean;
begin
   result:= isValueType(GetFieldType(ADisplayLabel));
end;

Function TwwFilterDlg.IsValueType(AFieldType: TFieldType): boolean;
begin
   result:=
       (AFieldType in
       [ftDate, ftDateTime, ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency, ftBoolean,
        {$ifdef wwDelphi6Up}
        ftFMTBcd, ftTimeStamp,
        {$endif}
        ftBCD]);
   {$ifdef win32}
   if AFieldType=ftAutoInc then result:= True;
   {$endif}

   if ((DlgComponent as TwwFilterDialog).FilterMethod=fdByQueryModify) and
      (AFieldType in [ftDateTime, ftTime]) then result:= True;
end;

Procedure TwwFilterDialog.InitTableFields;
var i: integer;
    newFldItem: TwwDBFieldInfo;
    curField: TField;
begin
   for i:= 0 to FFldList.count-1 do TwwDBFieldInfo(FFldList[i]).Free; {4/22/98}
   FFldList.clear;

   if (DataSource<>Nil) and (DataSource.DataSet<>Nil) then
   begin
      { No peristent fields and not active }
{      if (DataSource.DataSet is TwwQuery) or (DataSource.DataSet is TwwQBE) then
      begin
         if (DataSource.DataSet.FieldCount=0) and (not DataSource.DataSet.active) then
         begin
            MessageDlg('No persistent fields found.  InfoPower requires ' +
              'persistent fields when using fdByFilter on an inactive Query or QBE. '+
              'Dbl-click the TwwQuery or TwwQBE component to make your field''s persistent ' +
              'or make your query active before calling this dialog', mtError,
              [mbOK], 0);
            exit;
         end
      end
}
   end;

{   for i:= 0 to FieldDefs.count-1 do begin
      newFldItem:= TwwDBFieldInfo.create;
      with newFldItem do
      begin
         LogicalFieldName:= FieldDefs.items[i].Name;
         PhysicalFieldName:= FieldDefs.items[i].Name;
         TableName:= '';
         FieldType:= FieldDefs.items[i].DataType;

         curField:=DataSource.DataSet.FindField(PhysicalFieldName);
         if curField=nil then DisplayLabel:= PhysicalFieldName
         else DisplayLabel:= curField.DisplayLabel;
      end;
      FFldList.add(newFldItem);
   end;
}

   for i:= 0 to datasource.dataset.FieldCount-1 do begin
      newFldItem:= TwwDBFieldInfo.create;
      with newFldItem do
      begin
         curField:= DataSource.DataSet.Fields[i];
         LogicalFieldName:= curField.FieldName;
         PhysicalFieldName:= LogicalFieldName;
         TableName:= '';  { Not used witih this filter method}
         FieldType:= curField.DataType;
         DisplayLabel:= curField.DisplayLabel;;
         Size:= curField.size;
      end;
      FFldList.add(newFldItem);
   end;

end;

Function TwwFilterDialog.AddFieldInfo: TwwFieldInfo;
begin
   result:= TwwFieldInfo.create;
   FieldInfo.add(result);
end;

Function TwwFilterDialog.AddDBFieldInfo: TwwDBFieldInfo;
begin
   result:= TwwDBFieldInfo.create;
   FFldList.add(result);
end;

Procedure TwwFilterDialog.DoInitTempDataSet(OrigDataSet, TempDataset: TDataSet);
begin
    If Assigned(FOnInitTempDataSet) then
       FOnInitTempDataSet(self, OrigDataset, TempDataSet);
end;

Procedure TwwFilterDialog.InitQueryFields;
var {query: TQuery;}
    querysql: TStrings;
    {$ifdef wwDelphi3Up}
    querysql2: TStrings;
    {$endif}
    PropInfo: PPropInfo;
    table: TTable;
    tempDataSet: TDataSet;
    i, j, Apos: integer;
    line, word: string;
    tableName: wwSmallString;
    tempFldList, TempAllFldList: TStringList;
    PhysFieldName : wwSmallString;
    FieldDef: TFieldDef;
    newFldItem: TwwDBFieldInfo;
    tempField: TField;
    RemoteFieldInfo: TStrings;
    parts: TStrings;
    TableAliasList, TableNameList: TStrings;
    tnidx: integer;
    tempTableName, tempAliasName: string;
    SQLSTringType: boolean;
    querySQLString: string;

   Function FldInList(TempFldName: wwSmallString): boolean;
   var i: integer;
   begin
      result:= False;
      for i:= 0 to FFldList.count-1 do begin
         if wwEqualStr(tempFldName, TwwDBFieldInfo(FFldList[i]).LogicalFieldName) then
         begin
            result:= True;
            exit;
         end
      end
   end;

   Function ComputeFieldName(TempFldName: wwSmallString): string;
   var FirstTime: boolean;
   begin
       FirstTime:= True;
       while FldInList(TempFldName) do begin
          if FirstTime then
              TempFldName:= TempFldName + '_' + '1'
          else begin
              TempFldName[length(TempFldName[j])]:=
                 char(ord(TempFldName[length(TempFldName)])+1);
          end
       end;
       result:= TempFldName;
    end;

  Procedure UpdateFromFieldOrigin(curField: TField;
     var APhysicalFieldName, ATablename: string);
  var  Options: TwwGetWordOptions;
       APos, DotPos: integer;
       word: string;
  begin
      if (curfield.origin='') or (patch[2]=true) then exit
      else begin
         APos:= 1;
         ATableName:= '';
         APhysicalFieldName:= '';
         repeat
            Options:= [wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes, wwgwSpacesInWords];
            word:= wwGetWord(curfield.Origin, APos, Options, ['.']);
            if (word<>'.') and (word<>'') then begin
               if APhysicalFieldName<>'' then ATableName:= APhysicalFieldName;
               dotpos:= pos('.', ATableName);
               if dotpos>0 then ATableName:= copy(ATableName, 1, DotPos-1);
               APhysicalFieldName:= word;
            end
         until word='';
      end;
  end;

begin
   if (Datasource=nil) or (Datasource.dataset=nil) then exit;

   if (FieldsFetchMethod = fmUseTFields) then
   begin
      FFldList.Clear;
      with DataSource.Dataset do begin
         FieldDefs.update;
         for i:= 0 to Fields.count-1 do
         begin
             newFldItem:= TwwDBFieldInfo.create;
             with newFldItem do
             begin
                 LogicalFieldName:= Fields[i].FieldName;
                 if SQLTables.count>0 then begin { 12/3/99 - Don't use i for items index }
                     TableName:= TwwSQLTablesCollectionItem(SQLTables.Items[0]).TableAliasName;
                     if TableName='' then
                        TableName:= TwwSQLTablesCollectionItem(SQLTables.Items[0]).TableName;
                 end;

                 PhysicalFieldName:= Fields[i].FieldName;
//                 FieldDef:= FieldDefs.Find(PhysicalFieldName);
                 { 2/9/2000 - Use TDefCollection Find so that FieldDef = nil does not throw exception }
                 FieldDef:= TFieldDef(tDefCollection(FieldDefs).Find(PhysicalFieldName));

                 { 2/01/2000 - Use origin information if available }
                 UpdateFromFieldOrigin(Fields[i], PhysicalFieldName, TableName);

                 if FieldDef<>nil then
                 begin
                     FieldType:= FieldDef.DataType;
                     Size:= FieldDef.size;
                 end
                 else if Fields[i]<>nil then begin
                     FieldType:= Fields[i].DataType;
                     Size:= Fields[i].Size;
                 end;
                 tempField:=Fields[i];
                 DisplayLabel:= tempField.DisplayLabel;
             end;
            FFldList.Add(newFldItem);
         end
      end;
      exit;
   end;


//    TableNameList:= nil;
//    TableAliasList:= nil;

    { Search for From clause }
    SQLSTringType:= False;
    PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,GetSQLPropertyName);
    if PropInfo<>Nil then
    begin
       if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then
       begin
          querysqlstring:=  GetStrProp(DataSource.DataSet, PropInfo);
          SQLStringType:=True;
          querysql:= TStringlist.create;
          querysql.Add(querysqlstring);
       end
       else
          querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo))
    end
    else exit;

//    PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,GetSQLPropertyName);
//    if PropInfo<>Nil then querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo))
//    else exit;

    for i:= 0 to FFldList.count-1 do TwwDBFieldInfo(FFldList[i]).Free; {4/22/98}
    FFldList.Clear;

    for i:= 0 to querysql.count-1 do begin
       line:= uppercase(querysql[i]);
       APos:= 1;
       repeat
          word:= GetWord(line, APos);
       until (word='FROM') or (word='');
       if word='FROM' then break;
    end;


    if datasource.dataset is TBDEDataSet and
       (FieldsFetchMethod = fmUseTTable) then
    begin
       table:= TTable.create(Nil);
       tempDataSet:= table;
    end
    else if wwIsClass(datasource.dataset.classType, 'TClientDataSet') then
    begin
       table:= nil;
       TempDataSet:= nil;
    end
    else begin
       table:=nil;
       TempDataSet:= TDataSet(TComponentClass(datasource.dataset.classType).create(self)); { 2/23/99 - Give owner for 3rd party engines}
    end;

//    { 7/6/99 -Give user's of 3rd party engines a chance to override tempdataset properties }
//    DoInitTempDataSet(DataSource.dataset, TempDataSet);

    TempFldList:= TStringList.create;
    TempAllFldList:= TStringList.create;

    TableNameList:= TStringList.create;
    TableAliasList:= TStringList.create;

    if SQLTables.count>0 then begin
       for i:= 0 to SQLTables.count-1 do begin
          tempTableName:= TwwSQLTablesCollectionItem(SQLTables.Items[i]).TableName;
          tempAliasName:= TwwSQLTablesCollectionItem(SQLTables.Items[i]).TableAliasName;
          if (tempTableName<>'') then begin
             TableNameList.add(tempTableName);
             if tempAliasName='' then
                TableAliasList.add(TableNameList[i])
             else
                TableAliasList.add(tempAliasName);
          end
       end
    end
    else begin
       if word='FROM' then begin
          repeat
             repeat { Get Next table in From list }
                TableName:= GetWord(line, APos);
                if TableName='' then begin
                   if (i>=querysql.count-1) then break;
                   inc(i);
                   line:=uppercase(querysql[i]);
                   APos:= 1;
                end
             until TableName<>'';

             if (TableName[1]=Dbl) or (TableName[1]=Single) then
             begin
                TableNameList.Add(copy(TableName, 2, length(TableName)-2));
                TableAliasList.Add(GetWord(line, APos));
             end
             else begin
                TableNameList.Add(TableName);
                TableAliasList.Add(TableName);
             end;

             if (GetWord(line, APos)<>',') then break;
          until False;
       end
    end;

    try
       for tnidx:= 0 to TableNameList.count-1 do begin
          {$ifdef wwDelphi3Up}
          if (datasource.dataset is TBDEDataSet) and
             (FieldsFetchMethod = fmUseTTable) then
          begin
          {$endif}
             table.databaseName:= wwGetDatabaseName(datasource.dataset);
             { 10/25/97 - Get session name to assign to temporary table object }
             {$ifdef win32}
             table.sessionName:= wwGetSessionName(datasource.dataset);
             {$endif}
             table.tableName:= tableNameList[tnidx];
             table.readOnly:= True;
             DoInitTempDataSet(DataSource.dataset, TempDataSet);

             table.GetFieldNames(TempFldList);
          {$ifdef wwDelphi3Up}
          end
          else if wwIsClass(datasource.dataset.classType, 'TClientDataSet') then
          begin
             PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'FieldInfo');
             if PropInfo<>Nil then begin
                RemoteFieldInfo:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo));
                if RemoteFieldInfo=nil then exit;  // design time returns nil

                parts:= TStringList.create;
                for i:= 0 to RemoteFieldInfo.count-1 do
                begin
                   strbreakApart(RemoteFieldInfo[i], ';', parts);
                   with AddDBFieldInfo do begin
                     PhysicalFieldName:= parts[0];
                     LogicalFieldName:= parts[1];
                     TableName:= parts[2];
                     Displaylabel:= parts[3];
                     FieldType:= TFieldType(GetEnumValue(TypeInfo(TFieldType), parts[4]));
                     Size:= strtoInt(parts[5]);
                   end
                end;
                parts.Free;
             end
             else exit;
          end
          else begin
             wwSetDatabaseName(tempDataSet, wwGetDatabaseName(datasource.dataset));
             wwSetSessionName(tempDataSet, wwGetSessionName(datasource.dataset));
             if wwIsClass(Datasource.DataSet.ClassType, 'TCustomADODataSet') then
                wwSetConnectionString(tempDataSet, wwGetConnectionString(datasource.dataset));
             if wwIsClass(Datasource.DataSet.ClassType, 'TIBCustomDataSet') then
                wwSetIBDatabase(tempDataSet, wwGetIBDatabase(datasource.dataset));
             if wwIsClass(Datasource.DataSet.ClassType, 'TCustomADODataSet') then
                wwSetConnection(tempDataSet, wwGetConnection(datasource.dataset));

             if wwIsClass(Datasource.DataSet.ClassType, 'TCustomADODataSet') or
                wwIsClass(Datasource.DataSet.ClassType, 'TIBCustomDataSet') then
             begin
                wwSetDatabaseCursorType(tempDataSet, 0);
                wwSetDatabaseMaxRecords(tempDataSet, 1); { Limit result set }
             end;

//             wwSetRequestLive(DataSource.DataSet, True);
             PropInfo:= Typinfo.GetPropInfo(tempDataSet.ClassInfo,GetSQLPropertyName);
             if PropInfo<>Nil then begin
                if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then begin
                   SetStrProp(tempDataSet, PropInfo,
                         'Select * from ' + TableNameList[tnidx]);
                end
                else begin
                   querysql2:= TStrings(GetOrdProp(tempDataSet, PropInfo));
                   querysql2.clear;
                   querysql2.add('Select * from ' + TableNameList[tnidx]);
                end;
                DoInitTempDataSet(DataSource.dataset, TempDataSet);
                tempDataSet.GetFieldNames(TempFldList);
             end
             else exit;
          end;
          {$endif}

          if not wwIsClass(datasource.dataset.classType, 'TClientDataSet') then
          begin
             for j:= 0 to TempFldList.Count-1 do begin
                if TempAllFldList.indexOf(uppercase(TempFldList[j]))<0 then
                   TempAllFldList.add(uppercase(TempFldList[j]))
                else continue;  { Duplicate field name so ignore }

                PhysFieldName:= TempFldList[j];
                TempFldList[j]:= ComputeFieldName(TempFldList[j]);
                newFldItem:= TwwDBFieldInfo.create;
                with newFldItem do
                begin
                   LogicalFieldName:= TempFldList[j];
                   TableName:= TableAliasList[tnidx];
                   PhysicalFieldName:= PhysFieldName;
                   FieldDef:= tempDataSet.FieldDefs.Find(PhysicalFieldName);

                   if FieldDef<>nil then
                   begin
                      FieldType:= FieldDef.DataType;
                      Size:= FieldDef.size;
                   end;
                   tempField:=tempDataSet.FindField(PhysicalFieldName);
                   if tempField=nil then begin  { If field not found check query's fields }
                      tempField:= datasource.dataset.FindField(PhysicalFieldName);
                      if tempField=nil then DisplayLabel:= PhysicalFieldName
                      else DisplayLabel:= tempField.DisplayLabel;
                   end
                   else DisplayLabel:= tempField.DisplayLabel;
                end;
                FFldList.add(newFldItem);
             end;
          end;
       end
    finally
       if sqlStringType then querysql.free;
       tempDataSet.Free;
       tempFldList.Free;
       tempAllFldList.Free;
       TableNameList.Free;
       TableAliasList.Free;
    end

end;

{ From internal Field Name, Map to Physical Table and Field names.
  The FieldName and Physical Field Name would be the same except in the case
  where two related tables have the same field name.
  The logic assumes that the Delphi numbering scheme is based on the
  relative order of the tables in the 'From' clause.
}
Function TwwFilterDialog.GetDBInfoForField(AFilterFieldName: wwSmallString): TwwDBFieldInfo;
var i: integer;
begin
    result:= nil;
    for i:= 0 to FFldList.count-1 do begin
       if wwEqualStr(TwwDBFieldInfo(FFldList[i]).LogicalFieldName, AFilterFieldName) then
       begin
          result:= TwwDBFieldInfo(FFldList[i]);
          break;
       end;
    end;
end;

Function TwwFilterDialog.PadUpperRange(size: integer; val: string): string;
begin
   result:= wwPadUpperRange(size, val, UpperRangePadChar);
end;

Function TwwFilterDialog.Execute: boolean;
begin
   result := ExecuteDialog;
end;

function TwwFilterDialog.GetEffectiveSQLUpperString: string;
begin
   result:= 'Upper';
   if FSQLUpperString<>'' then result:= FSQLUpperString;
end;

Function TwwFilterDialog.ExecuteDialog(ExecuteQuery: boolean = True;
      ReturnWhereClause: TStrings = nil): boolean;
var
    FOnFilter: TwwDataSetFilterEvent;
    ApplyFilter: boolean;
    SaveCursor: TCursor;
    dbInfo: TwwDBFieldInfo;

   Function QueryFormatDateTime(val: string): string;
   var  year, month, day, hour, min, sec, msec: word;
   begin
       result:= '';
       if val='' then exit;
       DecodeDate(StrToDateTime(val), Year, Month, Day);
       DecodeTime(StrToDateTime(val), Hour, Min, Sec, MSec);
       case QueryFormatDateMode of
         qfdMonthDayYear:
            Result:= inttostr(Month) + '/' + inttostr(Day) + '/' + inttostr(year) +
                   ' ' + inttostr(hour) + ':' + inttostr(min) + ':' + inttostr(sec);
         qfdDayMonthYear:
            Result:= inttostr(Day) + '/' + inttostr(Month) + '/' + inttostr(year) +
                   ' ' + inttostr(hour) + ':' + inttostr(min) + ':' + inttostr(sec);
         qfdYearMonthDay:
            Result:= inttostr(Year) + '/' + inttostr(Month) + '/' + inttostr(Day) +
                   ' ' + inttostr(hour) + ':' + inttostr(min) + ':' + inttostr(sec);
       end;

       if Assigned(FOnEncodeDateTime) then
          OnEncodeDateTime(StrToDateTime(val), dbInfo.FieldType, dbInfo.LogicalFieldName, Result)
   end;

   Function QueryFormatDate(val: string): string;
   var  year, month, day: word;
   begin
       result:= '';
       if val='' then exit;
       DecodeDate(StrToDateTime(val), Year, Month, Day);
       case QueryFormatDateMode of
         qfdMonthDayYear:
            Result:= inttostr(Month) + '/' + inttostr(Day) + '/' + inttostr(year);
         qfdDayMonthYear:
            Result:= inttostr(Day) + '/' + inttostr(Month) + '/' + inttostr(year);
         qfdYearMonthDay:
            Result:= inttostr(Year) + '/' + inttostr(Month) + '/' + inttostr(Day);
       end;
       if Assigned(FOnEncodeDateTime) then
          OnEncodeDateTime(StrToDateTime(val), dbInfo.FieldType, dbInfo.LogicalFieldName, Result)
   end;

   Function QueryFormatTime(val: string): string;
   var  hour, min, sec, msec: word;
   begin
       result:= '';
       if val='' then exit;
       DecodeTime(StrToTime(val), Hour, Min, Sec, MSec);
       Result:= inttostr(hour) + ':' + inttostr(min) + ':' + inttostr(sec);

       if Assigned(FOnEncodeDateTime) then
          OnEncodeDateTime(StrToDateTime(val), dbInfo.FieldType, dbInfo.LogicalFieldName, Result)
   end;

   Procedure ExecQueryByNewQuery;
   var i, j: integer;
       DisplayName, FilterFieldName: wwSmallString;
       FilterValue: string;
       TableFieldName: string;
{       query: TQuery;}
       querysql: TStrings;
       PropInfo: PPropInfo;

       FldInfo: TwwFieldInfo;
       Found: boolean;
       line: string;
       tableName: wwSmallString;
       MatchType: TwwFilterMatchType;
       whereClause: TStrings;
       FoundField: boolean;
       quote: string[1];
       nextword: wwSmallString;
       First: boolean;
       SearchDelimiter: string;
       OrFlg,AndFlg : Boolean;
       CurPos : Integer;
       tempMinValue, tempMaxValue: string;
       querysqlstring, sqlString: string;
       SQLStringType: boolean;

       Function IsValueType(AFieldType: TFieldType): boolean;
       begin
          result:=
             (AFieldType in
             [ftDate, ftDateTime, ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency, ftBoolean,
             {$ifdef wwDelphi6Up}
             ftFMTBcd, ftTimeStamp,
             {$endif}
              ftBCD]);
         {$ifdef win32}
         if AFieldType=ftAutoInc then result:= True;
         {$endif}

         if (FilterMethod=fdByQueryModify) and
          (AFieldType in [ftDateTime, ftTime]) then result:= True;
       end;

   begin
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,GetSQLPropertyName);

      SQLStringType:= False;
      if PropInfo<>Nil then
      begin
         if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then
         begin
            querysqlstring:=  GetStrProp(DataSource.DataSet, PropInfo);
            SQLStringType:=True;
            querysql:= TStringlist.create;
            querysql.Add(querysqlstring);
         end
         else
            querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo))
      end
      else querysql:=nil;

//      if PropInfo<>Nil then querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo))
//      else querysql:= nil;
//      else exit;
      DataSource.dataset.active:= False;

      if querySQL<>nil then
      begin
         if FOrigSQL.count=0 then FOrigSQL.assign(querysql)
         else begin
            querysql.assign(FOrigSQL);
            ReplaceRemoteSQL(querySQL);
         end;
      end;

      whereClause:= TStringlist.create;
      foundField:= True;

      for j:= 0 to FieldInfo.count-1 do begin

         FldInfo:= TwwFieldInfo(FieldInfo[j]);
         MatchType:= FldInfo.MatchType;

         case MatchType of
           fdMatchStart, fdMatchAny, fdMatchExact:
             begin
               if (FldInfo.NonMatching) and (j>0) then
                  whereClause.add('  and not')
               else if (FldInfo.NonMatching) and (j=0) then
                  whereClause.add('  not')
               else if j>0 then whereClause.add(' and');
             end;
           fdMatchRange:
             begin
                if j>0 then whereClause.add(' and');
             end;
         end;

{         FilterField:= query.FindField(FilterFieldName);}

         if FldInfo.FieldName='' then begin
            FldInfo.FieldName:= FldInfo.DisplayLabel;

            {9/9/97 - Set field name based on SelectedFields mapping }
            for i:= 0 to SelectedFields.count-1 do begin
               curpos:= 1;
               FilterFieldName:= strGetToken(SelectedFields[i], ';', curpos);
               DisplayName:= strGetToken(SelectedFields[i], ';', curpos);
               if wwEqualStr(DisplayName, FldInfo.DisplayLabel) then
               begin
                  FldInfo.FieldName:= FilterFieldName;
                  break;
               end
            end

         end;
         FilterFieldName:= FldInfo.FieldName;
         FilterValue:= FldInfo.Filtervalue;

         dbInfo:= GetDBInfoForField(FilterFieldName);
         found:= dbInfo<>Nil;

         { 2/1/2000 - Use dbinfo.physicalfieldname instead of filterfieldname }
         if pos(' ', dbInfo.PhysicalFieldName)>0 then quote:= dbl
         else if pos('-', dbInfo.PhysicalFieldName)>0 then quote:= dbl
         else if FieldsInDblQuotes then quote:= dbl { 7/15/98 }
         else quote:= '';

         if not found then begin
            MessageDlg('TwwFilterDialog: Field not found (' + FilterFieldName + ')',
                mtWarning, [mbok], 0);
            whereClause.Free;
            exit;
         end;

         if dbinfo.Tablename<>'' then
         begin
            { 2/1/2000 - Check if table contains '.' and enclose in dbl-quotes if it does }
            if pos('.', dbInfo.TableName)>0 then
              TableFieldName:=
                 dbl + dbInfo.TableName + dbl + '.' + quote + dbInfo.PhysicalFieldName + quote
            else
              TableFieldName:=
                 dbInfo.TableName + '.' + quote + dbInfo.PhysicalFieldName + quote
         end
         else
           TableFieldName:= quote + dbInfo.PhysicalFieldName + quote;


         case MatchType of
           fdMatchStart, fdMatchAny, fdMatchExact:
             begin

               SearchDelimiter := wwGetFilterOperator(FilterValue,FwwOperators,OrFlg,AndFlg);

                {$ifdef win32}
                if (not FldInfo.CaseSensitive) and
                   not (dbInfo.FieldType in
                        [ftDate, ftDateTime,
                        {$ifdef wwDelphi6Up}
                        ftTimeStamp,
                        {$endif}
                        ftTime, ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency,
                         ftAutoInc, ftBoolean]) then
                begin
                   if dbinfo.Tablename<>'' then
                      TableFieldName:= GetEffectiveSQLUpperString + '(' +
                        dbInfo.TableName + '.' + quote + dbInfo.PhysicalFieldName + quote + ')'
                   else
                      TableFieldName:= GetEffectiveSQLUpperString + '(' +
                        quote + dbInfo.PhysicalFieldName + quote + ')';
                   FilterValue:= AnsiUppercase(FilterValue); { 5/20/99 }
                end;
                {$endif}

                if found then
                begin
                   line:= '(';
                   CurPos := 1;
                   First := True;
                   repeat
                      nextword:= wwGetFilterToken(FilterValue,SearchDelimiter,CurPos);
                      { 11/24/98 - Supported single quotes in values by not doing replace }
                      if (Patch[1]=True) and (pos('''',nextword)<>0) then
                         nextword :=  strReplaceCharWithStr(nextword,'''','''''');

                      if (not First and (nextword<>'')) then begin
                        if (OrFlg) then line:= line + ' or '
                        else line := line + ' and ';
                      end
                      else First := False;

                      strStripWhiteSpace(nextword);

                      if (Uppercase(FwwOperators.FNullChar) = uppercase(nextword)) then
                      begin
                         line := line + TableFieldName + ' is NULL';
                      end
                      else begin

                      case MatchType of
                         fdMatchStart: nextword:= nextword + '%';
                         fdMatchAny:   nextword:= '%' + nextword + '%';
                      end;

                      if (not FldInfo.CaseSensitive) then
                         nextword := uppercase(nextword);

                      { 1/14/2000 }
                      if Assigned(FOnEncodeValue) then
                         FOnEncodeValue(dbInfo.FieldType, dbInfo.LogicalFieldName, NextWord);

                      case dbInfo.FieldType of
                         ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency:
                            line:= line + TableFieldName + '=' + nextword;
                         { 11/18/97 - 16 bit BDE treat boolean as string by using quotes }
                         ftBoolean:
                         {$ifdef win32}
                            line:= line + TableFieldName + '=' + nextword;
                         {$else}
                            line:= line + TableFieldName + '=' + single + nextword + single;
                         {$endif}
                         {$ifdef win32}
                         ftAutoInc:
                            line:= line + TableFieldName + '=' + nextword;
                         {$endif}

                         ftDate:
                            line:= line + TableFieldName + '=' +  single + QueryFormatDate(nextword) + single;

                         {$ifdef wwDelphi6Up}
                         ftTimeStamp,
                         {$endif}
                         ftDateTime:
                            line:= line + '   ' + TableFieldName + '=' +  single + QueryFormatDateTime(nextword) + single;
                         ftTime:
                            line:= line + '   ' + TableFieldName + '=' +  single + QueryFormatTime(nextword) + single;

                         else
                           { 5/20/00 - Memo fields should not use = operator }
                           if (MatchType=fdMatchExact) and
                              {$ifdef wwDelphi5Up}
                              not (dbInfo.FieldType in [ftMemo,ftBlob,ftOraBlob, ftOraClob]) then begin
                              {$else}
                              not (dbInfo.FieldType in [ftMemo,ftBlob]) then begin
                              {$endif}
                              if (Patch[1]=False) and ((pos('''',nextword))<>0) then
                                line:= line + TableFieldName + '=' + dbl + nextword + dbl
                              else
                                line:= line + TableFieldName + '=' + single + nextword + single
                           end
                           else begin
                              if (Patch[1]=False) and ((pos('''',nextword))<>0) then
                                 line:= line + TableFieldName + ' like ' + dbl + nextword + dbl
                              else
                                 line:= line + TableFieldName + ' like ' + single + nextword + single
                           end;
//                           if MatchType=fdMatchExact then
//                             line:= line + TableFieldName + '=' + single + nextword + single
//                           else line:= line + TableFieldName + ' like ' + single + nextword + single;
                      end;
                      end;
                   until CurPos=-1;
                   line := line + ')';
                   whereClause.add(line);
                end
                else foundField:= False;
             end;

           fdMatchRange:
             begin
                if found then
                begin
                   tableName:= dbInfo.TableName;
                   FilterFieldName:= dbInfo.PhysicalFieldName;

                   if (dbInfo.FieldType in [ftString, ftFixedChar, ftWideString, ftDate, ftTime,
                       {$ifdef wwDelphi6Up}
                       ftTimeStamp,
                       {$endif}
                       ftDateTime]) then begin
                      case dbInfo.FieldType of
                         ftString,ftFixedChar,ftWideString: begin
                             TempMinValue:= FldInfo.MinValue;
                             TempMaxValue:= PadUpperRange(dbInfo.size, FldInfo.MaxValue)
//                             TempMaxValue:= FldInfo.MaxValue;
                           end;
                         ftDate: begin
                             TempMinValue:= QueryFormatDate(FldInfo.MinValue);
                             TempMaxValue:= QueryFormatDate(FldInfo.MaxValue);
                           end;
                         ftTime: begin
                             TempMinValue:= QueryFormatTime(FldInfo.MinValue);
                             TempMaxValue:= QueryFormatTime(FldInfo.MaxValue);
                           end;

                         {$ifdef wwDelphi6Up}
                         ftTimeStamp,
                         {$endif}
                         ftDateTime: begin
                            TempMinValue:= QueryFormatDateTime(FldInfo.MinValue);
                            TempMaxValue:= QueryFormatDateTime(FldInfo.MaxValue);
                           end;
                      end;
                      // 11/21/00 - Support OnEncodeValue event
                      if Assigned(FOnEncodeValue) then
                      begin
                         FOnEncodeValue(dbInfo.FieldType, FilterFieldName, TempMinValue);
                         FOnEncodeValue(dbInfo.FieldType, FilterFieldName, TempMaxValue);
                      end;

                      if FldInfo.MinValue<>'' then begin
                         line:= '   ' + TableFieldName + ' >= ' +
                              single + TempMinValue + single;
                         whereClause.add(line);
                      end;

                      if FldInfo.MaxValue<>'' then begin
                         if FldInfo.MinValue<>'' then whereClause.add(' and');
                         line:= '   ' + TableFieldName + ' <= ' +
                              single + TempMaxValue + single;
                         whereClause.add(line);
                      end
                   end
                   {11/18/97 - Remove Form.IsValueType reference so it works without dialog}
                   else if isValueType(dbinfo.FieldType) then
                   begin
                      if FldInfo.MinValue<>'' then begin
                         line:= '   ' + TableFieldName + ' >= ' +
                           FldInfo.MinValue;
                         whereClause.add(line);
                      end;

                      if FldInfo.MaxValue<>'' then begin
                         if FldInfo.MinValue<>'' then whereClause.add(' and');
                         line:= '   ' + TableFieldName + ' <= ' +
                             FldInfo.MaxValue;
                         whereClause.add(line);
                      end
                   end;
                end
                else foundField:= False;
             end
         end; { Case }

         if not FoundField then begin
            MessageDlg('Field Name not found in referenced tables. ' + #13 +
                FilterFieldName, mtWarning, [mbok], 0);
            break;
         end;

      end;

      try
         if ReturnWhereClause<>nil then
            ReturnWhereClause.assign(WhereClause);
         self.SQLWhereClause.assign(WhereClause);

         if FoundField and ExecuteQuery then begin
            ReplaceWhereClause(whereClause);

            if Assigned(FOnExecuteSQL) and (datasource.dataset is TQuery) then
               FOnExecuteSQL(form, (datasource.dataset as TQuery));
            try
               datasource.dataset.active:= True;
            except
               SQLString:= 'Unable to Execute SQL:' + #13;
               if QuerySQL<>nil then begin
                 for i:= 0 to QuerySql.count-1 do
                    SQLString:= SQLString + QuerySQL[i] + #13;
                 MessageDlg(SQLString, mtWarning, [mbok], 0);
               end;
               raise;
            end;
         end;
      finally
         whereClause.free;
      end;

      if SQLStringType then querysql.free;
   end;

   procedure ClearCallBackFilter;
   var NonBDE: boolean;
       PropInfo: PPropInfo;
       NilMethod: TMethod;
   begin
      NilMethod.data:= DataSource.DataSet;
      NilMethod.code:= nil;

      PropInfo:= Typinfo.GetPropInfo(Datasource.DataSet.ClassInfo,'OnFilter');
      NonBDE:= PropInfo=Nil;

      if NonBDE then Datasource.Dataset.OnFilterRecord:= nil
      else begin
         SetMethodProp(datasource.dataset, PropInfo, NilMethod);
      end;
   end;

   Function ApplyRemoteFilter: boolean;
   var
       FilterExpr: TStrings;
       FilterField: TField;
       FoundField: boolean;
       i, j: integer;
       FldInfo: TwwFieldInfo;
       MatchType: TwwFilterMatchType;
       FilterFieldName: wwSmallString;
       FilterValue: string;
       quote: string[1];
       SearchDelimiter: string;
       OrFlg,AndFlg : Boolean;
       Line: string;
       CurPos : Integer;
       First: boolean;
       nextword: wwSmallString;
       tempMinValue, tempMaxValue: string;
       tempFilter, sqlString: string;
       SaveCursor: TCursor;
       SkipNextConjunction: boolean;

       Function IsValueType(AFieldType: TFieldType): boolean;
       begin
          result:=
             (AFieldType in
             [ftDate, ftDateTime, ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency, ftBoolean,
              ftBCD]);
         if AFieldType=ftAutoInc then result:= True;
         if (AFieldType in [ftDateTime, ftTime]) then result:= True;
       end;

   begin
      FilterExpr:= TStringlist.create;
      result:= True;
      FoundField:= True;
      SkipNextConjunction:= False;

      for j:= 0 to FieldInfo.count-1 do begin

         FldInfo:= TwwFieldInfo(FieldInfo[j]);
         MatchType:= FldInfo.MatchType;

         if not SkipNextConjunction then case MatchType of
           fdMatchStart, fdMatchAny, fdMatchExact:
             begin
               if (FldInfo.NonMatching) and (j>0) then
                  FilterExpr.add('  and not')
               else if (FldInfo.NonMatching) and (j=0) then
                  FilterExpr.add('  not')
               else if j>0 then FilterExpr.add(' and');
             end;
           fdMatchRange:
             begin
                if j>0 then FilterExpr.add(' and');
             end;
         end;

         SkipNextConjunction:= False;

         FilterField:= DataSource.DataSet.FindField(FldInfo.FieldName);
         FoundField:=  FilterField<>nil;
         if FilterField is TBlobField then continue;
         if FilterField.Lookup then continue;
         if FilterField.calculated then continue;

         if FilterPropertyOptions.UseBracketsAroundFields then
            FilterFieldName:= '[' + FldInfo.FieldName + ']'
         else
            FilterFieldName:= FldInfo.FieldName;
         FilterValue:= FldInfo.Filtervalue;

{        //5/11/2001 - Moved to after onencodevalue
         if FilterField is TStringField then
         egin
            if FilterField.size>0 then begin
               FilterValue:= copy(FilterValue, 1, FilterField.size);
               FldInfo.FilterValue:=FilterValue;
            end
         end;
}
         quote:= single;

         case MatchType of
           fdMatchStart, fdMatchAny, fdMatchExact:
             begin
                SearchDelimiter := wwGetFilterOperator(FilterValue,FwwOperators,OrFlg,AndFlg);

                with FilterPropertyOptions do
                begin
                   if (DatasetFilterType in [fdUseFilterProp, fdUseBothFilterTypes]) and
                      (UseLikeOperator and LikeSupportsUpperKeyword) then
                   begin
                      if (not FldInfo.CaseSensitive) and
                          not (FilterField.DataType in
                          [ftDate, ftDateTime, ftTime, ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency,
                            {$ifdef wwDelphi6Up}
                            ftFMTBcd, ftTimeStamp,
                            {$endif}
                            ftAutoInc, ftBoolean]) then
                       begin
                         FilterFieldName:= GetEffectiveSQLUpperString + '(' + FilterFieldName + ')';
                         FilterValue:= AnsiUppercase(FilterValue); { 5/20/99 }
                       end
                   end
                end;

                if FoundField then
                begin
                   CurPos := 1;
                   line:= '(';
                   First := True;
                   repeat
                      nextword:= wwGetFilterToken(FilterValue,SearchDelimiter,CurPos);

                      { Support single quotes }
                      nextword :=  strReplaceCharWithStr(nextword,'''','''''');

                      if (not First and (nextword<>'')) then begin
                        if (OrFlg) then line:= line + ' or '
                        else line := line + ' and ';
                      end
                      else First := False;

                      strStripWhiteSpace(nextword);

                      if (Uppercase(FwwOperators.FNullChar) = uppercase(nextword)) then
                      begin
                         line := line + FilterFieldName + ' is NULL';
                      end
                      else begin

                        with FilterPropertyOptions do begin
                           if UseLikeOperator then
                           begin
                              case MatchType of
                                 fdMatchStart: nextword:= nextword + LikeWildcardChar;
                                 fdMatchAny:   nextword:= LikeWildcardChar + nextword + LikeWildcardChar;
                              end
                           end
                           else begin
                              case MatchType of
                                 fdMatchStart: nextword:= nextword + '*';
                                 fdMatchAny:   nextword:= '*' + nextword + '*';
                              end;
                           end
                        end;

                        { 1/14/2000 }
                        if Assigned(FOnEncodeValue) then
                           FOnEncodeValue(FilterField.DataType, FilterFieldName, NextWord);

                        {5/11/2001 - PYW Truncate word after encoding value.}
                        if FilterField is TStringField then
                        begin
                           if FilterField.size>0 then begin
                              NextWord:= copy(NextWord, 1, FilterField.size);
                           end
                        end;

                       case FilterField.DataType of
                          ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency:
                            line:= line + FilterFieldName + '=' + nextword;
                          { 11/18/97 - 16 bit BDE treat boolean as string by using quotes }
                          ftBoolean:
                             line:= line + FilterFieldName + '=' + nextword;
                          ftAutoInc:
                             line:= line + FilterFieldName + '=' + nextword;

                          ftDate:
                             line:= line + FilterFieldName + '=' +  single + QueryFormatDate(nextword) + single;
                          {$ifdef wwDelphi6Up}
                          ftTimeStamp,
                          {$endif}
                          ftDateTime:
                             line:= line + '   ' + FilterFieldName + '=' +  single + QueryFormatDateTime(nextword) + single;
                          ftTime:
                             line:= line + '   ' + FilterFieldName + '=' +  single + QueryFormatTime(nextword) + single;

                          else
                            { 11/24/98 - Supported single quotes in values }
                            if MatchType=fdMatchExact then begin
                                line:= line + FilterFieldName + '=' + single + nextword + single
                            end
                            else begin
                               if FilterPropertyOptions.UseLikeOperator then
                                  line:= line + FilterFieldName + ' like ' + single + nextword + single
                               else begin
                                  if (MatchType <> fdMatchAny) then
                                    line:= line + FilterFieldName + '=' + single + nextword + single
                                  else SkipNextConjunction:= True;
                               end
                            end;
                        end { case }
                      end;
                   until CurPos=-1;
                   if (line<>'()') then
                      FilterExpr.add(line);
                end
             end;

           fdMatchRange:
             begin
                if FoundField then
                begin
                   if (FilterField.DataType in [ftString,ftFixedChar,ftWideString,ftDate, ftTime,
                           {$ifdef wwDelphi6Up}
                            ftTimeStamp,
                           {$endif}
                            ftDateTime]) then begin
                      case FilterField.DataType of
                         ftString,ftFixedChar,ftWideString: begin
                             TempMinValue:= FldInfo.MinValue;
                             TempMaxValue:= PadUpperRange(FilterField.size, FldInfo.MaxValue)
                           end;
                         ftDate: begin
                             TempMinValue:= QueryFormatDate(FldInfo.MinValue);
                             TempMaxValue:= QueryFormatDate(FldInfo.MaxValue);
                           end;
                         ftTime: begin
                             TempMinValue:= QueryFormatTime(FldInfo.MinValue);
                             TempMaxValue:= QueryFormatTime(FldInfo.MaxValue);
                           end;
                         {$ifdef wwDelphi6Up}
                         ftTimeStamp,
                         {$endif}
                         ftDateTime: begin
                            TempMinValue:= QueryFormatDateTime(FldInfo.MinValue);
                            TempMaxValue:= QueryFormatDateTime(FldInfo.MaxValue);
                           end;
                      end;
                      // 11/21/00 - Support OnEncodeValue event
                      if Assigned(FOnEncodeValue) then
                      begin
                         FOnEncodeValue(FilterField.DataType, FilterFieldName, TempMinValue);
                         FOnEncodeValue(FilterField.DataType, FilterFieldName, TempMaxValue);
                      end;
                      if FldInfo.MinValue<>'' then begin
                         line:= '(' + FilterFieldName + ' >= ' +
                              single + TempMinValue + single + ')';
                         FilterExpr.add(line);
                      end;

                      if FldInfo.MaxValue<>'' then begin
                         if FldInfo.MinValue<>'' then FilterExpr.add(' and');
                         line:= '(' + FilterFieldName + ' <= ' +
                              single + TempMaxValue + single + ')';
                         FilterExpr.add(line);
                      end
                   end
                   else if isValueType(FilterField.DataType) then
                   begin
                      if FldInfo.MinValue<>'' then begin
                         line:= '(' + FilterFieldName + ' >= ' +
                           FldInfo.MinValue + ')';
                         FilterExpr.add(line);
                      end;
                      if FldInfo.MaxValue<>'' then begin
                         if FldInfo.MinValue<>'' then FilterExpr.add(' and');
                         line:= '(' + FilterFieldName + ' <= ' +
                             FldInfo.MaxValue + ')';
                         FilterExpr.add(line);
                      end
                   end;
                end
                else foundField:= False;
             end
         end; { Case }

         if not FoundField then begin
            MessageDlg('Field Name not found in referenced tables. ' + #13 +
                FilterFieldName, mtWarning, [mbok], 0);
            break;
         end;

      end;

      try
         if FoundField then begin
            SkipClearFieldInfo:= True;
            datasource.dataset.active:= false;
            SkipClearFieldInfo:= False;

            tempFilter:= '';
            for i:= 0 to FilterExpr.count-1 do
            begin
               tempFilter:= tempFilter + ' ' + filterExpr[i];
            end;

            SaveCursor:= screen.cursor;
            try
               screen.cursor:= crHourGlass;
               datasource.dataset.filtered:= false;
               datasource.dataset.filter:= tempFilter;
               datasource.dataset.filtered:= True;
               if FilterPropertyOptions.DatasetFilterType in [fdUseOnFilter, fdUseBothFilterTypes] then
                  ClearCallbackFilter;
               datasource.dataset.active:= True;
            except
               screen.cursor:= SaveCursor;
               SQLString:= 'Unable to Execute Filter:' + #13;
               for i:= 0 to FilterExpr.count-1 do
                  SQLString:= SQLString + FilterExpr[i] + #13;
               datasource.dataset.filtered:= false;
               datasource.dataset.filter:= '';
               datasource.dataset.active:= true;
               result:= false;
//               Use event here so user can customize action
               MessageDlg(SQLString, mtWarning, [mbok], 0);
            end;
         end;
      finally
         FilterExpr.free;
      end;

   end;

   procedure UseIndexForFilter;
   var i: integer;
       FldInfo: TwwFieldInfo;
       MatchType: TwwFilterMatchType;
       tempIndexName: string;
       OrFlg, AndFlg: boolean;
       FieldSize: integer;
   begin

     if ((DataSource.DataSet as TwwTable).MasterSource<>Nil) then exit;  { Don't change index if detail table}

     if FRangeApplied then begin
        SkipClearFieldInfo:= True;
        (DataSource.DataSet as TwwTable).FastCancelRange;
        SkipClearFieldInfo:= False;
        FRangeApplied:= False;
     end;

     { Try to use active index }
     if fdUseActiveIndex = FilterOptimization then begin
        if (Datasource.dataset as TwwTable).indexfieldcount<=0 then exit;

        FieldSize:= (DataSource.DataSet as TwwTable).indexFields[0].size;

        for i:= 0 to FieldInfo.count-1 do begin
           FldInfo:= TwwFieldInfo(FieldInfo[i]);
           if FldInfo.NonMatching then continue;
           if wwGetFilterOperator(FldInfo.FilterValue,FwwOperators,OrFlg,AndFlg)<>'' then continue;

           if FldInfo.FieldName='' then  { Compute field name from displaylabel if unspecified }
              FldInfo.FieldName:= wwGetFieldNameFromTitle(DataSource.DataSet, FldInfo.DisplayLabel);
           MatchType:= FldInfo.MatchType;

           case MatchType of
              fdMatchStart, fdMatchExact:
                begin
                   if (FldInfo.FieldName=(DataSource.DataSet as TwwTable).indexFieldName) then
                   begin
                      if FldInfo.FilterValue<>'' then begin
                         if MatchType=fdMatchExact then
                         begin
                            (DataSource.DataSet as TwwTable).SetRange([FldInfo.FilterValue], [FldInfo.FilterValue]);
                            FRangeApplied:= True;
                            exit;
                         end
                         else if (MatchType=fdMatchStart) and
                            ((DataSource.DataSet as TwwTable).indexFields[0].dataType in [ftString,ftFixedChar,ftWideString]) then
                         begin
                            (DataSource.DataSet as TwwTable).SetRange([FldInfo.FilterValue],
                                [PadUpperRange(FieldSize, FldInfo.FilterValue)]); {2/24/98}
                            FRangeApplied:= True;
                            exit;
                         end
                      end;
                   end
                end;

              fdMatchRange:
                begin
                   if (FldInfo.FieldName=(DataSource.DataSet as TwwTable).indexFieldName) then
                   begin
                      if (FldInfo.MinValue<>'') and (FldInfo.MaxValue<>'') then
                         (DataSource.DataSet as TwwTable).SetRange(
                           [FldInfo.MinValue], //[FldInfo.MaxValue])
                           [PadUpperRange(FieldSize, FldInfo.MaxValue)]) {2/24/98}
                      else if FldInfo.MinValue<>'' then
                         (DataSource.DataSet as TwwTable).wwSetRangeStart([FldInfo.MinValue])
                      else begin
                         with (datasource.dataset as TwwTable) do begin
                            setRangeStart;
                            setRangeEnd;
                            indexFields[0].asString:=
                               PadUpperRange(FieldSize, FldInfo.MaxValue); {2/24/98}
//                            indexFields[0].asString:= FldInfo.MaxValue + char(UpperRangeChar);
                            ApplyRange;
                         end
                      end;

                      FRangeApplied:= True;
                      exit;
                   end
                end;
           end;
        end;
     end

     { Switch index }
     else if fdUseAllIndexes = FilterOptimization then begin
        for i:= 0 to FieldInfo.count-1 do begin
           FldInfo:= TwwFieldInfo(FieldInfo[i]);
           if FldInfo.NonMatching then continue;
           if wwGetFilterOperator(FldInfo.FilterValue,FwwOperators,OrFlg,AndFlg)<>'' then continue;

           if FldInfo.FieldName='' then  { Compute field name from displaylabel if unspecified }
              FldInfo.FieldName:= wwGetFieldNameFromTitle(DataSource.DataSet, FldInfo.DisplayLabel);
           MatchType:= FldInfo.MatchType;

           case MatchType of
              fdMatchStart, fdMatchExact:
                begin
                   with (DataSource.dataSet as TwwTable) do begin
                      tempIndexName:= FieldsToIndexWithCase(FldInfo.FieldName, FldInfo.caseSensitive);
                      if tempIndexName='?' then
                         tempIndexName:= FieldsToIndexWithCase(FldInfo.FieldName, not FldInfo.caseSensitive);

                      if tempIndexName<>'?' then
                      begin
                         IndexName:= tempIndexName;

                         if FldInfo.FilterValue<>'' then begin
                            if MatchType=fdMatchExact then
                            begin
                               SetRange([FldInfo.FilterValue], [FldInfo.FilterValue]);
                               FRangeApplied:= True;
                               exit;
                            end
                            else if (MatchType=fdMatchStart) and
                               (indexFields[0].dataType in [ftString,ftFixedChar,ftWideString]) then
                            begin
                               FieldSize:= indexFields[0].size;
                               SetRange([FldInfo.FilterValue],
                                  [PadUpperRange(FieldSize, FldInfo.FilterValue)]); {2/24/98}
                               FRangeApplied:= True;
                               exit;
                            end
                         end;
                      end
                   end
                end;

              fdMatchRange:
                begin
                   with (DataSource.dataSet as TwwTable) do begin
                      tempIndexName:= FieldsToIndexWithCase(FldInfo.FieldName, False);
                      if tempIndexName='?' then
                         tempIndexName:= FieldsToIndexWithCase(FldInfo.FieldName, True);

                      if tempIndexName<>'?' then
                      begin
                         IndexName:= tempIndexName;

                         if (FldInfo.MinValue<>'') and (FldInfo.MaxValue<>'') then
                         begin
                            FieldSize:= indexFields[0].size;
                            SetRange([FldInfo.MinValue],
                              [PadUpperRange(FieldSize, FldInfo.MaxValue)]) {2/24/98}
                         end
                         else if FldInfo.MinValue<>'' then
                            wwSetRangeStart([FldInfo.MinValue])
                         else begin
                            setRangeStart;
                            setRangeEnd;
                            FieldSize:= indexFields[0].size;
                            indexFields[0].asString:=
                               PadUpperRange(FieldSize, FldInfo.MaxValue); {2/24/98}
                            ApplyRange;
                         end;

                         FRangeApplied:= True;
                         exit;
                      end;
                   end
                end;
           end;
        end;
      end;
   end;

   procedure SetOnFilterEvent;
   var PropInfo: PPropInfo;
       NonBDE: boolean;
   begin
      if FilterPropertyOptions.DatasetFilterType in [fdUseFilterProp, fdUseBothFilterTypes] then
      begin
         if not ApplyRemoteFilter then exit;
      end;

      if not (FilterPropertyOptions.DataSetFilterType in [fdUseOnFilter, fdUseBothFilterTypes]) then exit;

      if not DataSource.DataSet.active then DataSource.DataSet.active:= True;
      PropInfo:= Typinfo.GetPropInfo(Datasource.DataSet.ClassInfo,'OnFilter');
      NonBDE:= PropInfo=Nil;

      ClearCallBackFilter;

      if DataSource.DataSet is TwwTable then UseIndexForFilter;

      if (FieldInfo.count> 0) or
         not (fdClearWhenNoCriteria in OnFilterPropertyOptions) then
      begin
         FOnFilter:= (FDummyForm as TwwDummyForm).OnFilterEvent;
         if NonBDE then
            DataSource.DataSet.OnFilterRecord:= FOnFilter
         else
            SetMethodProp(datasource.dataset, PropInfo, TMethod(FOnFilter));
         if wwIsClass(datasource.dataset.classType, 'TClientDataSet') or NonBDE then
         begin
            // 7/31/00 - Some dataset's close dataset when filter set to false so prevent clearing of fieldinfo
            SkipClearFieldInfo:= True;
            datasource.dataset.filtered:= False;
            datasource.dataset.filtered:= True;
            SkipClearFieldInfo:= False;
         end
      end
      else datasource.dataset.filtered:= false;

//      else if NonBDE then begin
//         datasource.dataset.filtered:= False;
//         datasource.dataset.filtered:= True;
//         datasource.dataset.refresh; { Important to refresh for ADO, or OnFilter has problems with eof and bof }
//      end;
   end;

begin
   result:= False;
   if datasource=nil then exit;
   if datasource.dataset=nil then exit;
   if (not DataSource.dataSet.active) and (FilterMethod=fdByFilter) then
   begin
      MessageDlg('Dataset must be active to perform local filtering (FilterMethod=fdByFilter).',
          mtError, [mbOK], 0);
      exit;
   end;
   if (FwwOperators.OrChar = FwwOperators.AndChar) then
      MessageDlg('And and Or Operators have the same value.',mtWarning,[mbok],0);

   Form:= Nil;
   SaveCursor:= Screen.Cursor;

   try
    Screen.cursor:= crHourGlass;
    if ShowDialog then begin
       form:=  TwwFilterDlg.CreateDlg(Application, self);
       if (fdSizeable in options) then form.borderstyle := bsSizeable;
       form.DlgComponent:= self;
       form.Caption:= Caption;
       form.RefreshFieldList(True);

       ApplyFilter:= False;
       Result:= (form.showModal = mrOK);
       if Result and
          ((form.FilterChanged) or
           (not (ofoEnabled in wwGetOnFilterOptions(datasource.dataset)))) then
       begin
          Form.CopyList(form.FieldInfo, FieldInfo);
          ApplyFilter:= True;
       end
    end
    else ApplyFilter:= True;

    if ApplyFilter then begin
       if (Owner is TCustomForm) then (Owner as TCustomForm).Update; { 6/5/99 - Repaint calling form }

       wwSetOnFilterEnabled(datasource.dataset, True);

       if not ((datasource.dataset is TQuery) or (not ExecuteQuery) or
               (Typinfo.GetPropInfo(datasource.dataset.ClassInfo,GetSQLPropertyName)<>Nil)) then
       begin
          SetOnFilterEvent;
       end
       else begin
          case FilterMethod of
             fdByQueryModify: begin
                   Screen.cursor:= crHourGlass;
                   ExecQueryByNewQuery;
                end;

             fdByFilter: begin
                   if wwGetOwnerForm(self)<>nil then
                      wwGetOwnerForm(self).Update;
                   SetOnFilterEvent;
                end;
          end;
       end;
       result:= True;
    end;

   Finally
     Screen.cursor:= SaveCursor;
     if ShowDialog then form.Free;

   end;
end;


procedure Register;
begin
end;


procedure TwwFilterDlg.FieldOrderClick(Sender: TObject);
var currentFieldName :string;
begin
   CurrentFieldName:= '';
   if FieldsListBox.itemIndex>=0 then
      CurrentFieldName:= FieldsListBox.items[FieldsListBox.itemIndex];
   RefreshFieldList(FieldTabSet.tabIndex=0);
   FieldsListBox.itemIndex:= FieldsListBox.items.indexOf(CurrentFieldName);
   FieldsListBox.setFocus;
   LastItemIndex:= FieldsListBox.itemIndex;;
end;

Function TwwFilterDlg.GetFilterField(ADisplayLabel: wwSmallString; var FldInfo: TwwFieldInfo): boolean;
var tempFldInfo: TwwFieldInfo;
   i: integer;
begin
   FldInfo:= Nil;
   for i:= 0 to FieldInfo.count-1 do begin
      tempFldInfo:= TwwFieldInfo(FieldInfo[i]);
      if wwEqualStr(strReplaceChar(tempFldInfo.displayLabel,'~', ' '),
                    strReplaceChar(ADisplayLabel,'~', ' ')) then
      begin
         FldInfo:= tempFldInfo;
         break;
      end
   end;

   result:= FldInfo<>Nil;
end;

procedure TwwFilterDlg.SetFilterfield(ADisplayLabel: wwSmallString;
       AMatchType: TwwFilterMatchType; AFilterValue, AMinValue, AMaxValue: string;
       ACaseSensitive, ANonMatching: boolean);
var tempFldInfo: TwwFieldInfo;
   i: integer;
   found: boolean;
begin
   found:= False;

   for i:= 0 to FieldInfo.count-1 do begin

      tempFldInfo:= TwwFieldInfo(FieldInfo[i]);

      if wwEqualStr(tempFldInfo.DisplayLabel, ADisplayLabel) then
      begin
         if ((AFilterValue='') and (AMatchType<>fdMatchRange)) or
            ((AMinValue='') and (AMaxValue='') and (AMatchType=fdMatchRange)) then
         begin
            FieldInfo.delete(i);
            FilterChanged:= True;
            break;
         end
         else begin
            with TwwFieldInfo(FieldInfo[i]) do
            begin
               if (MatchType<>AMatchType) then FilterChanged:= True;

               MatchType:= AMatchType;
               if MatchType=fdMatchRange then
               begin
                  if (MinValue<>AMinValue) or (MaxValue<>AMaxValue) then FilterChanged:= True;
                  MinValue:= AMinValue;
                  MaxValue:= AMaxValue;
               end
               else begin
                  if (FilterValue<>AFilterValue) or (CaseSensitive<>ACaseSensitive) or
                     (NonMatching<>ANonMatching) then
                     FilterChanged:= True;
                  FilterValue:= AFilterValue;
                  CaseSensitive:= ACaseSensitive;
                  NonMatching:= ANonMatching;
               end;
               found:= True;
               break;
            end
         end
      end
   end;

   if (not found) and ((AFilterValue<>'') or (AMinValue<>'') or (AMaxValue<>'')) then
   begin
      tempFldInfo:= TwwFieldInfo.create;
      with tempFldInfo do
      begin
         DisplayLabel:= ADisplayLabel;
         MatchType:= AMatchType;
         if MatchType=fdMatchRange then
         begin
            MinValue:= AMinValue;
            MaxValue:= AMaxValue;
         end
         else begin
            FilterValue:= AFilterValue;
            CaseSensitive:= ACaseSensitive;
            NonMatching:= ANonMatching;
         end;
      end;
      FieldInfo.add(tempFldInfo);
      FilterChanged:= True;
   end
end;

procedure TwwFilterDlg.FieldsListBoxClick(Sender: TObject);
begin
   if SelectField(True) then
   begin
      SelectPage;
      FieldsListBox.SetFocus;
   end
end;

{ FieldChanged indicates have moved to new field so clear unused edit controls }
Function TwwFilterDlg.SelectField(FieldChanged: boolean): boolean;
var MatchType: TwwFilterMatchType;
    DisplayLabel: wwSmallString;
    FilterValue, MinValue, MaxValue: string;
    FldInfo: TwwFieldInfo;
    PictureMask: string;
    ComboList: TStrings;
    Fieldname: string;
    IsDateOnly: Boolean;

    { 11/22/99 - Maplist support }
    Function IsMappedCombo: boolean;
    begin
      result:= false;
      if FormActivated then
         if SelectNotebook.ActivePage = TabSheet1 then
            if (FilterValueEditControl is TwwDBComboBox) and
               TwwDBComboBox(FilterValueEditControl).MapList then
                  result:= True;
    end;

begin
   result:= True;

   if MatchTypeGroup.itemIndex=0 then MatchType:= fdMatchExact
   else if MatchTypeGroup.itemIndex=1 then MatchType:= fdMatchStart
   else MatchType:= fdMatchAny;

   if LastItemIndex>=0 then
   begin
      DisplayLabel:= FieldsListBox.items[LastItemIndex];

      if (not IsMappedCombo) and { 11/22/99 - Maplist support }
         isValueField(DisplayLabel) and (not ValidEditValues(FilterValueEditControl.text)) then begin
         SelectNotebook.ActivePage:= TabSheet1;
         FilterValueEditControl.SelectAll;
         FilterValueEditControl.SetFocus;
         if LastItemIndex<>FieldsListBox.ItemIndex then FieldsListBox.itemIndex:= LastItemIndex;
         result:= False;
         exit;
      end;

      { 5/20/99 - RSW - Save time portion if its entered }
      if MinValueEditControl is TwwDBDateTimePicker then begin
         if MinValueEditControl.Text<>'' then
         begin
            if (TwwDBDateTImePicker(MinValueEditControl).Time<>0) and (FieldsListBox.ItemIndex>=0) and
               {$ifdef wwDelphi6Up}
               (GetFieldType(FieldsListBox.items[FieldsListBox.ItemIndex]) in [ftDateTime, ftTimeStamp]) then
               {$else}
               (GetFieldType(FieldsListBox.items[FieldsListBox.ItemIndex]) in [ftDateTime]) then
               {$endif}
               MinValue:= DateTimeToStr(TwwDBDateTimePicker(MinValueEditControl).DateTime)
            else
               MinValue:= DateToStr(TwwDBDateTimePicker(MinValueEditControl).Date)
         end
         else MinValue:= '';

         if MaxValueEditControl.Text<>'' then begin
            // 6/07/00 - PYW - Only put the date and time when there is a Time Value and/or when
            //             there is a time separator in the Max Date Range TwwDBDateTimePicker text.
 {            if (TwwDBDateTImePicker(MaxValueEditControl).Time<>0) and (FieldsListBox.ItemIndex>=0) and
               (GetFieldType(FieldsListBox.items[FieldsListBox.ItemIndex]) = ftDateTime) then
               MaxValue:= DateTimeToStr(TwwDBDateTimePicker(MaxValueEditControl).DateTime)
 }
            IsDateOnly := True;
            if ((TwwDBDateTImePicker(MaxValueEditControl).Time)<>0) or
                (Pos(TimeSeparator,MaxValueEditControl.Text)>0) then IsDateOnly := False;

            if (not IsDateOnly) and (FieldsListBox.ItemIndex>=0) and
               {$ifdef wwDelphi6Up}
               (GetFieldType(FieldsListBox.items[FieldsListBox.ItemIndex]) in [ftDateTime, ftTimeStamp]) then
               {$else}
               (GetFieldType(FieldsListBox.items[FieldsListBox.ItemIndex]) in [ftDateTime]) then
               {$endif}
               MaxValue:= DateToStr(TwwDBDateTimePicker(MaxValueEditControl).Date)+' '+
                          TimeToStr(TwwDBDateTimePicker(MaxValueEditControl).Time)
            else
               MaxValue:= DateToStr(TwwDBDateTimePicker(MaxValueEditControl).Date)
         end
         else MaxValue:= ''
      end
      else begin
         MinValue:= MinValueEditControl.text;
         MaxValue:= MaxValueEditControl.text;
      end;

      if not ValidEditValue(MinValue) then begin
         SelectNotebook.ActivePage:= TabSheet2;
         MinValueEditControl.SelectAll;
         MinValueEditControl.SetFocus;
         if LastItemIndex<>FieldsListBox.ItemIndex then FieldsListBox.itemIndex:= LastItemIndex;
         result:= False;
         exit;
      end;
      if not ValidEditValue(MaxValue) then begin
         SelectNotebook.ActivePage:= TabSheet2;
         MaxValueEditControl.SelectAll;
         MaxValueEditControl.SetFocus;
         if LastItemIndex<>FieldsListBox.ItemIndex then FieldsListBox.itemIndex:= LastItemIndex;
         result:= False;
         exit;
      end;

      if FormActivated then begin
         if SelectNotebook.ActivePage = TabSheet1 then begin
            { 6/25/99 - Support mapped combos }
            if (FilterValueEditControl is TwwDBComboBox) and
               TwwDBComboBox(FilterValueEditControl).MapList then
               SetFilterField(DisplayLabel, MatchType,
                   TwwDBComboBox(FilterValueEditControl).Value, MinValue,
                   MaxValue, CaseSensitive.checked, NonMatching.checked)
            else
               SetFilterField(DisplayLabel, MatchType, FilterValueEditControl.Text, MinValue,
                   MaxValue, CaseSensitive.checked, NonMatching.checked)
         end
         else begin
            SetFilterField(DisplayLabel, fdMatchRange, FilterValueEditControl.Text, MinValue,
                 MaxValue, CaseSensitive.checked, NonMatching.checked);
         end
      end;
      ClearSearchButton.enabled:=  FieldInfo.count>0;
   end;

   if (FieldsListBox.itemIndex>=0) then
   begin
      LastItemIndex:= FieldsListBox.itemIndex;
      DisplayLabel:= FieldsListBox.items[LastItemIndex];
      if not (fdDisableDateTimePicker in (DlgComponent as TwwFilterDialog).Options) and
         {$ifdef wwDelphi6Up}
         (GetFieldType(FieldsListBox.items[LastItemIndex]) in [ftDate, ftDateTime, ftTimeStamp]) then
         {$else}
         (GetFieldType(FieldsListBox.items[LastItemIndex]) in [ftDate, ftDateTime]) then
         {$endif}
      begin
         MinValueEditControl:= MinDateEdit;
         MaxValueEditControl:= MaxDateEdit;
         MinDateEdit.visible:= true;
         MaxDateEdit.visible:= true;
         MinValueEdit.visible:= false;
         MaxValueEdit.visible:= false;
         {$ifdef wwDelphi6Up}
         if (GetFieldType(FieldsListBox.items[LastItemIndex]) in [ftDateTime, ftTimeStamp]) then
         {$else}
         if (GetFieldType(FieldsListBox.items[LastItemIndex]) in [ftDateTime]) then
         {$endif}
            MinDateEdit.UnboundDataType:= wwDTEdtDateTime
         else
            MinDateEdit.UnboundDataType:= wwDTEdtDate
      end
      else begin
         MinValueEditControl:= MinValueEdit;
         MaxValueEditControl:= MaxValueEdit;
         MinDateEdit.visible:= false;;
         MaxDateEdit.visible:= false;
         MinValueEdit.visible:= true;
         MaxValueEdit.visible:= true;
      end;
      StartingRangeLbl.FocusControl:= MinValueEditControl;
      EndingRangeLbl.FocusControl:= MaxValueEditControl;

      if GetFilterField(DisplayLabel, FldInfo) then
      begin
         MatchType:= FldInfo.MatchType;
         MinValue:= FldInfo.MinValue;
         MaxValue:= FldInfo.MaxValue;
         FilterValue:= FldInfo.FilterValue;
         CaseSensitive.checked:= FldInfo.caseSensitive;
         NonMatching.checked:= FldInfo.NonMatching;
      end
      else begin
         MatchType:= fdMatchNone;
         FilterValue:= '';
         MinValue:= '';
         MaxValue:= '';
         CaseSensitive.checked:= (fdCaseSensitive in (DlgComponent as TwwFilterDialog).Options);
         NonMatching.checked:= False;
      end;

//   if TwwFilterDialog(DlgComponent).FilterPropertyOptions.DataSetFilterType in [fdUseFilterProp, fdUseBothFilterTypes] then
//      CaseSensitive.checked := not (foCaseInsensitive in DlgDataSet.FilterOptions);

// Support picture masks except when partial match anywhere
   if FieldChanged and Assigned((DlgComponent as TwwFilterDialog).FOnSelectField) then
   begin
      PictureMask:= '';
      ComboList:= TStringList.create;

      if (FieldsListBox.itemIndex<0) and (FieldsListBox.Items.Count>0) then
         DisplayLabel:= FieldsListBox.items[0];

      FieldName:= wwGetFieldNameFromTitle(DlgDataSet, DisplayLabel);
      if FieldName='' then FieldName:= DisplayLabel;
      if FieldName<>'' then
      begin
         (DlgComponent as TwwFilterDialog).DoSelectField(
            FieldName, PictureMask, ComboList);
         FilterValueCombo.Picture.PictureMask:= PictureMask;
         FilterValueEdit.Picture.PictureMask:= PictureMask;
         FilterValueCombo.items.clear;
         if ComboList.count>0 then
         begin
            FilterValueCombo.Items.Assign(ComboList);
            FilterValueCombo.ShowButton:= True;
            FilterValueCombo.ShowMatchText:= True;
         end
         else begin
//            FilterValueCombo.ShowMatchText:= False;
//            FilterValueCombo.ShowButton:= False;
         end;
         FilterValueCombo.invalidate;

         ComboList.Free;
      end
   end;

   UpdateFilterEditControl;

{   if (FilterValueEditControl = FilterValueCombo) and
      (FilterValueCombo.Items.Count>0) then
   begin
      FilterValueCombo.ShowButton:= True;
      FilterValueCombo.ShowMatchText:= True;
   end
   else begin
      FilterValueCombo.ShowMatchText:= False;
      FilterValueCombo.ShowButton:= False;
   end;
}
      if MatchType= fdMatchExact then MatchTypeGroup.itemIndex:= 0
      else if MatchType= fdMatchStart then MatchTypeGroup.itemIndex:= 1
      else if MatchType = fdMatchAny then MatchTypeGroup.itemIndex:= 2
      else begin
         case (DlgComponent as TwwFilterDialog).DefaultMatchType of
            fdMatchExact: MatchTypeGroup.itemIndex:= 0;
            fdMatchStart: MatchTypeGroup.itemIndex:= 1;
            fdMatchAny: MatchTypeGroup.itemIndex:= 2;
         end
      end;

      if MatchType<>fdMatchNone then begin
         if (MatchType=fdMatchRange) then begin
            if MinValueEditControl is TwwDBDateTimePicker then
            begin
               { 5/20/99 - Support date/time pair }
               if MinValue<>'' then begin
                  if wwStrToDateTime(MinValue) then
                     TwwDBDateTimePicker(MinValueEditControl).DateTime:= StrToDateTime(MinValue)
                  else
                     TwwDBDateTimePicker(MinValueEditControl).DateTime:= StrToDate(MinValue)
               end;

               if MaxValue<>'' then begin
                  if wwStrToDateTime(MaxValue) then
                     TwwDBDateTimePicker(MaxValueEditControl).DateTime:= StrToDateTime(MaxValue)
                  else
                     TwwDBDateTimePicker(MaxValueEditControl).DateTime:= StrToDate(MaxValue)
               end;
            end
            else begin
               MinValueEditControl.text:= MinValue;
               MaxValueEditControl.text:= MaxValue;
            end;
            if FieldChanged then begin
               FilterValueEdit.text:= '';
               FilterValueCombo.text:= '';
            end
         end
         else begin
            { 6/25/99 - Support mapped list }
            if (FilterValueEditControl is TwwDBComboBox) and
               TwwDBComboBox(FilterValueEditControl).MapList then
               FilterValueEditControl.text:= FilterValueCombo.GetComboDisplay(FilterValue)
            else
               FilterValueEditControl.text:= FilterValue;
            if FieldChanged then begin
               MinValueEditControl.text:= '';
               MaxValueEditControl.text:= '';
            end
         end
      end
      else begin
         MinValueEditControl.text:= '';
         MaxValueEditControl.text:= '';
         FilterValueEditControl.text:= '';
      end;
      FieldCriteria.caption:= DisplayLabel;

//      if fdShowValueRangeTab in (DlgComponent as TwwFilterDialog).Options then { 4/17/98 }
//         ValueRangeTabSet.visible:= True; {11/12/97}
         //TabSheet2.visible:= True;
         ShowValueRangeTabs;

      { 7/2/00 - Support non ttables partial match for value types }
      if (not (DlgDataSet is TTable) and isValueField(DisplayLabel)) and
         (((DlgComponent as TwwFilterDialog).FilterMethod = fdByQueryModify) or
          ((DlgComponent as TwwFilterDialog).FilterPropertyOptions.DataSetFilterType <> fdUseOnFilter)) then
//      if not (DlgDataSet is TTable) and
//         isValueField(DisplayLabel) then
      begin
         MatchTypeGroup.itemIndex:= 0;
         MatchTypeGroup.enabled:= False;
         CaseSensitive.enabled:= False;
      end
      {$ifdef win32}                {Memo fields always case-sensitive in Delphi 2 SQL}
      else if ((DlgDataSet is TQuery) or (Typinfo.GetPropInfo(DlgDataset.ClassInfo,GetSQLPropertyName)<>Nil)) and
              ((DlgComponent as TwwFilterDialog).FilterMethod = fdByQueryModify) and
              {$ifdef wwDelphi5Up}
              (GetFieldType(DisplayLabel) in [ftmemo,ftBlob,ftOraBlob, ftOraClob]) then { 5/20/00 - Check ftBlob,ftOraBlob too }
              {$else}
              (GetFieldType(DisplayLabel) in [ftmemo,ftBlob]) then
              {$endif}
      begin
         CaseSensitive.checked:=True;
         CaseSensitive.enabled:=False;
         MatchTypeGroup.enabled:=True;
//         TabSheet2.visible:= False;
         ShowValueRangeTabs;
//         ValueRangeTabSet.visible:= false; {11/12/97 }
      end
      {$endif}                                           {pwe}
      else begin
         MatchTypeGroup.enabled:= True;
         CaseSensitive.enabled:= True;
      end
   end;

end;

Function TwwFilterDlg.GetFieldType(ADisplayLabel: wwSmallString): TFieldType;
var Dlg: TwwFilterDialog;
    dbInfo: TwwDBFieldInfo;
    Field: TField;
    FieldName, DisplayName: wwSmallString;
    curpos, i: integer;
begin
   result:= ftUnknown;

   Dlg:= TwwFilterDialog(DlgComponent);
   FieldName:= wwGetFieldNameFromTitle(
                 DlgDataSet, ADisplayLabel);
   if FieldName='' then FieldName:= ADisplayLabel;

   { Determine datatype of field }
   Field:= DlgDataSet.FindField(FieldName);
   if Field<>nil then result:= Field.DataType
   else begin

      { 1/8/98 - Check to see if displaylabel is defined in selectedfields }
      dbInfo:= Dlg.GetDBInfoForField(FieldName);
      if dbInfo=nil then begin
         for i:= 0 to Dlg.SelectedFields.count-1 do begin
            curpos:= 1;
            FieldName:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
            DisplayName:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
            if (DisplayName=ADisplayLabel) then begin
               dbInfo:= Dlg.GetDBInfoForField(FieldName);
               if dbInfo<>nil then result:= dbInfo.FieldType;
               break;
            end
         end
      end
      else result:= dbInfo.FieldType;
   end;
end;

Procedure TwwFilterDlg.SelectPage;
var FldInfo: TwwFieldInfo;
    DisplayLabel, FieldName, DisplayName: wwSmallString;
{    ItemIndex: integer;}
    Dlg: TwwFilterDialog;
    curDataType: TFieldType;
    i, curpos: integer;
    dbInfo: TwwDBFieldInfo;
begin
   Dlg:= TwwFilterDialog(DlgComponent);
   if FieldsListBox.items.count<=0 then exit;
   if not (fdShowValueRangeTab in Dlg.Options) then begin
      if Dlg.DefaultFilterBy=fdFilterByRange then SelectNotebook.ActivePage:= TabSheet2
      else SelectNotebook.ActivePage:= TabSheet1;
   end;
   if FieldsListBox.itemIndex<0 then FieldsListBox.itemIndex:= 0;

   DisplayLabel:= FieldsListBox.items[FieldsListBox.itemIndex];
   if GetFilterField(DisplayLabel, FldInfo) then
   begin
      if (FldInfo.MatchType=fdMatchRange) then
         SelectNotebook.ActivePage:= TabSheet2
      else
         if (SelectNotebook.ActivePage <> TabSheet1) then
             SelectNotebook.ActivePage:= TabSheet1
   end
   else begin
      curDataType:= GetFieldType(DisplayLabel);

      { 9/9/97 - If data type not recognized from dataset then use information from dbinfo }
      if curDataType=ftUnknown then begin
         for i:= 0 to Dlg.SelectedFields.count-1 do begin
            curpos:= 1;
            FieldName:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
            DisplayName:= strGetToken(Dlg.SelectedFields[i], ';', curpos);
            if (DisplayName=DisplayLabel) then begin
               dbInfo:= Dlg.GetDBInfoForField(FieldName);
               if dbInfo<>nil then curDataType:= dbInfo.FieldType;
               break;
            end
         end
      end;

{      FieldName:= wwGetFieldNameFromTitle(
                   DlgDataSet, DisplayLabel);
      if FieldName='' then FieldName:= DisplayLabel;

      Field:= DlgDataSet.FindField(FieldName);
      if Field<>nil then curDataType:= Field.DataType
      else begin
         dbInfo:= Dlg.GetDBInfoForField(FieldName);
         if dbInfo=nil then exit;
         curDataType:= dbInfo.FieldType;
      end;
}
      case TwwFilterDialog(DlgComponent).DefaultFilterBy of
        fdSmartFilter:
          begin
           { 11/18/97 - Treat boolean as non-value type }
            if isValueType(curDataType) and (curDataType<>ftBoolean) then
               SelectNotebook.ActivePage:= TabSheet2
            else
               SelectNotebook.ActivePage:= TabSheet1
          end;
         fdFilterbyRange: SelectNotebook.ActivePage:= TabSheet2
         else SelectNotebook.ActivePage:= TabSheet1
      end
   end;

//   ValueRangeTabSet.TabIndex:= SelectNotebook.pageIndex;

end;

procedure TwwFilterDlg.ViewButtonClick(Sender: TObject);
begin
   SelectField(False);

   if FieldInfo.count=0 then begin
      MessageDlg(wwInternational.UserMessages.FilterDlgNoCriteria,
                 mtInformation, [mbok], 0);
      exit;
   end;

   (DlgComponent as TwwFilterDialog).FilterDialogView(
      FieldInfo);

//   if ValueRangeTabSet.tabIndex=0 then
   if SelectNotebook.ActivePage=TabSheet1 then
      FilterValueEditControl.setFocus
   else MinValueEditControl.setFocus;
end;

procedure TwwFilterDialog.FilterDialogView(AFieldInfo: TList);
var DoDefault: boolean;
begin
   DoDefault:= True;
   if Assigned(OnDialogSummary) then
   begin
      DoDefault:= False;
      FOnDialogSummary(self, AFieldInfo, DoDefault);
   end;
   if DoDefault then
      wwFilterDialogView(self, AFieldInfo);
end;


procedure TwwFilterDlg.SelectFocus;
begin
   if FilterValueEditControl=Nil then
      FilterValueEditControl:= FilterValueEdit;

   if (SelectNotebook.ActivePage = TabSheet1) then
   begin
      FilterValueEditControl.setFocus;
      FiltervalueEditControl.selectAll;
   end
   else begin
      MinValueEditControl.setFocus;
      MinValueEditControl.selectAll;
   end
end;

Function wwGetFilterToken(FilterValue: string;
                           SearchDelimiter: string;
                           var CurPos: integer): string;
var nextword:string;
    DelimSet:strCharSet;
    curtoken:string;
begin
   DelimSet:=[];
   if (length(SearchDelimiter)=1) then
      DelimSet := DelimSet + [SearchDelimiter[1]];

   nextword := '';
   repeat
      curtoken := wwGetWord(FilterValue,CurPos,
                  [wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes],DelimSet);

      if (UpperCase(curtoken)=UpperCase(SearchDelimiter)) then
      begin
         // 6/4/00 - Support values of "or" and "and" as field values instead of operators
         if nextword='' then nextWord:= SearchDelimiter;
         break;
      end
      else if (nextword <> '') and (curtoken <> '') then nextword := nextword + ' ' + curtoken
      else nextword := nextword + curtoken;
   until (CurPos>length(FilterValue)) or (curtoken='');

   if (CurPos > length(FilterValue)) or (curtoken='') then Curpos:=-1;

   result := nextword;
end;


Function wwGetFilterOperator(FilterValue: string;
                           FilterOperator: TwwFieldOperators;
                           var OrFlg: boolean; var AndFlg: boolean): string;

var Count,CurPos:Integer;
    DelimSet : strCharSet;
    tempword:string;

begin
  Count:=0;
  CurPos := 1;
  OrFlg:=False;
  AndFlg:=False;

  DelimSet:=[];
  if (length(FilterOperator.OrChar)=1) then
     DelimSet := DelimSet + [FilterOperator.OrChar[1]];
  if (length(FilterOperator.AndChar)=1) then
     DelimSet := DelimSet + [FilterOperator.AndChar[1]];

  repeat
     tempword := wwGetWord(FilterValue,CurPos,
                 [wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes],DelimSet);
     if (Count> 0) then begin
        if (Uppercase(tempword) = Uppercase(FilterOperator.OrChar)) then
        begin
           OrFlg := True;
           break;
        end
        else if (Uppercase(tempword) = UpperCase(FilterOperator.AndChar)) then
        begin
           AndFlg := True;
           break;
        end;
     end;
     inc(Count);
  until (CurPos>length(FilterValue)) or (tempword='');

  if (not OrFlg) and (not AndFlg) then result:=''
  else
  begin
     if (OrFlg)then begin
        result := FilterOperator.OrChar;
      { result:=False;  }
     end
     else result := FilterOperator.AndChar;
  end;
end;


procedure TwwFilterDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

var PrevItemIndex: integer;

  Function min(x,y: integer): integer;
  begin
    if x<y then result:= x else result:= y;
  end;
  Function max(x,y: integer): integer;
  begin
    if x>y then result:= x else result:= y;
  end;

begin
   if (ActiveControl=FieldsListBox) then begin
      if (FieldTabSet.tabIndex=1) and (Key=VK_Delete) then begin
         SetFilterfield(FieldsListBox.items[FieldsListBox.itemIndex],
            fdMatchNone, '', '', '', False, False);
         RefreshFieldList(False);

        LastItemIndex:= -1;
        FieldsListBox.itemIndex:= 0;

        { Move to correct Value/Range tab page }
        SelectField(True);
        SelectPage;
        FieldsListBox.SetFocus;
        key:= 0;
      end;
      exit;
   end;

   if (key in [vk_Next, vk_prior, vk_up, vk_down]) then begin
      if (ssAlt in Shift) and (key in [vk_up, vk_down]) then exit;
      if (ActiveControl is TwwDBDateTimePicker) and
          (TwwDBDateTimePicker(ActiveControl).text<>'') and
          (key in [vk_up, vk_down]) then exit;

      PrevItemIndex:= FieldsListBox.itemIndex;

      if (key=vk_Next) then begin
         if FieldsListBox.itemIndex<FieldsListBox.items.count-1 then
            FieldsListBox.itemIndex:=
               min(FieldsListBox.itemIndex + (FieldsListBox.Height div FieldsListBox.itemHeight),
                   FieldsListBox.items.count-1);
      end
      else if (key=vk_Prior) then begin
         if FieldsListBox.itemIndex>0 then
            FieldsListBox.itemIndex:=
               max(FieldsListBox.itemIndex - (FieldsListBox.Height div FieldsListBox.itemHeight), 0);
      end
      else if (key=vk_down) then begin
         if FieldsListBox.itemIndex<FieldsListBox.items.count-1 then
            FieldsListBox.itemIndex:= FieldsListBox.itemIndex + 1;
      end
      else if (key=vk_up) then begin
         if FieldsListBox.itemIndex>0 then
            FieldsListBox.itemIndex:= FieldsListBox.itemIndex - 1;
      end;

      if FieldsListBox.itemIndex<>PrevItemIndex then begin
         if SelectField(True) then begin
            SelectPage;
            SelectFocus;
         end;
         key:= 0;
      end;
   end
end;

procedure TwwFilterDlg.FormShow(Sender: TObject);
var FldInfo: TwwFieldInfo;
    i: integer;
    Dlg: TwwFilterDialog;
    tempField: TField;
    DefaultField: string;
  Function max(x,y: integer): integer;
  begin
    if x>y then result:= x else result:= y;
  end;

begin

  Dlg:= DlgComponent as TwwFilterDialog;

  if not (fdShowOKCancel in Dlg.Options) then begin
     OKBtn.Top:= 1000;
     CancelBtn.Top:= 1000;
     width:= width - OKBtn.width - 8;
     OKCancelPanel.Width:= 10; // Fix ok/cancel form width problem
  end;

  { Don't show partial match anywhere unless like keyword is used }
  if (fdHidePartialAnywhere in Dlg.Options) or
     (Dlg.FilterMethod=fdByFilter) and
     (not Dlg.FilterPropertyOptions.UseLikeOperator) and
     (Dlg.FilterPropertyOptions.DataSetFilterType=fdUseFilterProp) then
  begin
     MatchTypeGroup.Items.delete(2);
     MatchTypeGroup.height:= MatchTypeGroup.Height - 10;
  end;

  if not (fdShowFieldOrder in Dlg.Options) then
  begin
     FieldOrder.visible:= False;
     FieldOrderPanel.visible:= False;
  end;

  if not (fdShowViewSummary in Dlg.Options) then begin
     ViewButton.visible:= False;
     ClearSearchButton.left:= ViewButton.Left;
  end;

//  if not (fdShowValueRangeTab in Dlg.Options) then
//     TabSheet2.visible:= False;
  ShowValueRangeTabs;

//     ValueRangeTabSet.visible:= False;
  if not (fdShowCaseSensitive in Dlg.Options) then
     CaseSensitive.Visible := False;
  with Dlg.FilterPropertyOptions do
     if DatasetFilterType in [fdUseFilterProp, fdUseBothFilterTypes] then
        if not (UseLikeOperator and LikeSupportsUpperKeyword) then
           CaseSensitive.Visible := False;

  if not (fdShowNonMatching in Dlg.Options) then begin
     Nonmatching.visible:= False;
     if CaseSensitive.visible then //(fdShowCaseSensitive in Dlg.Options) then
        Panel1.height := wwAdjustPixels(26,PixelsPerInch) {*PixelsPerInch) div 96;}
     else
        Panel1.visible := false;
  end
  else begin
     if CaseSensitive.visible then //(fdShowCaseSensitive in Dlg.Options) then
        Panel1.height:= wwAdjustPixels(41,PixelsPerInch) {*PixelsPerInch) div 96}
     else begin
        Panel1.height:= wwAdjustPixels(26,PixelsPerInch); {*PixelsPerInch) div 96;}
        Nonmatching.Top := wwAdjustPixels(5,PixelsPerInch) {*PixelsPerInch) div 96;}
     end;
  end;

  Height:= wwAdjustPixels(Dlg.DlgHeight,PixelsPerInch){ *PixelsPerInch) div 96};

  SelectNotebook.Width:= FieldCriteriaPanel.Width-4;
  SelectNotebook.Height:= FieldCriteriaPanel.Height-SelectNotebook.Top-ButtonPanel.height-5;

//  if Dlg.FilterPropertyOptions.DatasetFilterType in [fdUseFilterProp, fdUseBothFilterTypes] then
//     Panel1.visible:= false;

  if (Dlg.SortBy = fdSortByFieldName) then FieldOrder.itemIndex := 0
  else FieldOrder.itemIndex:= 1;

  if FieldInfo.count>0 then begin  { Default listbox to show first field of current filter}
     FieldTabset.tabIndex:= 1;
     RefreshFieldList(False); // 8/7/01 - Refresh with searched fields

     for i:= 0 to FieldsListBox.items.count-1 do begin
        if GetFilterField(FieldsListBox.items[i], FldInfo) then
        begin
           FieldsListBox.itemIndex:= i;
           break;
        end
     end
  end
  else begin
     tempField:= DlgDataSet.FindField(Dlg.DefaultField);
     if tempField<>Nil then{ defaultField:= tempField.displayLabel}
        defaultField:= strReplaceChar(tempField.displayLabel,'~', ' ') { 4/30/98 }
     else defaultField:= Dlg.DefaultField;

     FieldsListBox.itemIndex:= wwGetListIndex(FieldsListBox.items, DefaultField);
     if FieldsListBox.itemIndex<0 then FieldsListBox.itemIndex:= 0;
  end;

  SelectField(True);
  SelectPage;
  SelectFocus;

  { Adjust control sizes and positions based on dlgheight }
(*  if (fdShowFieldOrder in Dlg.Options) then
     FieldsListbox.height:= wwAdjustPixels((Dlg.DlgHeight - 107),PixelsPerInch)
  else
     FieldsListbox.height:=
//        wwAdjustPixels((Dlg.DlgHeight - 27),PixelsPerInch);
        wwAdjustPixels((Dlg.DlgHeight - 70),PixelsPerInch); { 8/6/98 }
*)

{  FieldTabset.Top:= FieldsListBox.Top + FieldsListBox.height -1;
  if (fdShowFieldOrder in Dlg.Options) then begin
     FieldOrder.Top:= FieldTabSet.Top + FieldTabSet.Height + 5;
     ClearSearchButton.Top:= FieldOrder.Top + 8 ;
  end
  else ClearSearchButton.Top:= FieldsListBox.Top +
             FieldsListbox.height - ClearSearchButton.height;
  ClearSearchButton.top:= max(wwAdjustPixels(209, PixelsPerInch), ClearSearchButton.top);
}

//  ViewButton.Top:= ClearSearchButton.Top;

  if (fdTabsAtTop in Dlg.Options) then
  begin
     FieldTabSet.TabPosition:= tpTop;
     SelectNotebook.TabPosition:= tpTop;
  end;

  Screen.cursor:= crDefault;
  ApplyIntl;
  Dlg.DoInitDialog;
  //8/1/01
  if FieldTabSet.TabPosition = tpTop then
     FieldsListBox.align:= alClient;


  if DlgDataSet.Active then FilterChanged:= False
  else FilterChanged:= True;

end;

procedure TwwFilterDlg.ValueRangeTabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
//   SelectNotebook.pageIndex:= NewTab;
//   if not SelectField(False) then AllowChange:= False;
//   SelectFocus;
end;

procedure TwwFilterDlg.ClearSearchButtonClick(Sender: TObject);
var i: integer;
begin
   for i:= 0 to FieldInfo.count-1 do TwwFieldInfo(FieldInfo[i]).Free;
   FieldInfo.clear;

   FilterChanged:= True;
   FilterValueEditControl.text:= '';
   MinValueEditControl.Text:= '';
   MaxValueEditControl.Text:= '';
   ClearSearchButton.enabled:= False;
   MatchTypeGroup.itemIndex:= 1;

   FieldTabSet.TabIndex:= 0;
   // 1/4/02 - Refresh with all fields
   AdjustFieldtabSet(FieldTabSet.TabIndex);

end;

Function TwwFilterDlg.ValidEditValue(val: string): boolean;
var curField: TField;
begin
   result:= True;
   if val='' then exit;
   curField:= nil;
   if FieldsListBox.itemIndex>=0 then
      curField:= DlgDataSet.FindField(wwGetFieldNameFromTitle(DlgDataSet, FieldsListBox.items[LastItemIndex]));
   result:= (curField=Nil) or wwFieldIsValidValue(curField, val);
end;

Function TwwFilterDlg.ValidEditValues(val: string): boolean;   {pwb}
var curFieldtype: TFieldtype;
    CurPos: Integer;
    testval: string;
begin
   result:= True;
   if val='' then exit;

   if FieldsListBox.itemIndex>=0 then
   begin
      curFieldType := GetFieldType(FieldsListBox.items[LastItemIndex]);

      CurPos:=1;
      repeat
         testval := strGetToken(val,(DlgComponent as TwwFilterDialog).FieldOperators.orChar,CurPos);
         if (CurPos>Length(val)) then CurPos := -1;
         strStripWhiteSpace(testval);
         if not (AnsiCompareText(testval,
                (DlgComponent as TwwFilterDialog).FieldOperators.nullChar)=0) then  {!!!! Paul}
            result := wwIsValidValue(curFieldType, testval);
      until ((CurPos = -1) or (result=False));
   end;
end;


procedure TwwFilterDlg.RefreshClearButton;
var tempEnabled: boolean;
begin
   tempEnabled:= False;
   if FieldInfo.count>0 then tempEnabled:= True
   else if FilterValueEditControl.text<>'' then tempEnabled:= True
   else if MinValueEditControl.text<>'' then tempEnabled:= True
   else if MaxValueEditControl.text<>'' then tempEnabled:= True;

   FilterValueClearButton.enabled:= FilterValueEditControl.text<>'';
   MinValueClearButton.enabled:= MinValueEditControl.text<>'';
   MaxValueClearButton.enabled:= MaxValueEditControl.text<>'';
   ClearSearchButton.enabled:= tempEnabled;
end;

procedure TwwFilterDlg.FilterValueComboChange(Sender: TObject);
begin
   RefreshClearButton;
   okbtn.enabled:= true;
end;

procedure TwwFilterDlg.MinValueEditChange(Sender: TObject);
begin
   RefreshClearButton;
   okbtn.enabled:= true;
end;

procedure TwwFilterDlg.MaxValueEditChange(Sender: TObject);
begin
   RefreshClearButton;
   okbtn.enabled:= true;
end;

procedure TwwFilterDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if ModalResult=mrOK then begin
      if not SelectField(True) then CanClose:= False;
   end;
end;

procedure TwwFilterDlg.FormActivate(Sender: TObject);
begin
   FormActivated:= True;
end;

procedure TwwFilterDlg.MinValueClearButtonClick(Sender: TObject);
begin
   MinValueEditControl.text:= '';
   MinValueClearButton.enabled:= False;
end;

procedure TwwFilterDlg.MaxValueClearButtonClick(Sender: TObject);
begin
   MaxValueEditControl.text:= '';
   MaxValueClearButton.enabled:= False;
end;

procedure TwwFilterDlg.FilterValueClearButtonClick(Sender: TObject);
begin
  FilterValueEditControl.text:= '';
  FilterValueClearButton.enabled:= False;
end;

procedure TwwFilterDialog.SetFilterMethod(val: TwwFilterMethod);
begin
   if datasource=nil then FFilterMethod:= val
   else if (datasource.dataset is TQuery) or
           (Typinfo.GetPropInfo(datasource.dataset.ClassInfo,GetSQLPropertyName)<>Nil) then
   begin
      FFilterMethod:= val;
   end
   else {if (datasource.dataset is TTable) or (datasource.dataset is TwwQBE) or
           (datasource.dataset is TwwStoredProc) then } begin
      if (val<>fdByFilter) then
         MessageDlg('Invalid FilterMethod for Dataset. ' + #13 +
                     'Only fdByFilter is supported for this type of Dataset', mtWarning, [mbok], 0)
      else FFilterMethod:= fdByFilter;
   end
end;

Procedure TwwFilterDialog.ClearFilter;
var i: integer;
    querysql: TStrings;
    querySQLString: string;
    PropInfo: PPropInfo;
    SQLStringType: boolean;
begin
   for i:= 0 to FieldInfo.count-1 do TwwFieldInfo(FieldInfo[i]).Free;
   FieldInfo.clear;
   SQLStringType:= False;

   { 10/17/97 - Restore initial state.
                Use SQL property instead of checking if TQuery }
   if (datasource<>Nil) and (datasource.dataset<>Nil) and
      (FilterMethod=fdByQueryModify) then
   begin
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,GetSQLPropertyName);
      if PropInfo<>Nil then begin
          // 6/25/02 - Support non-tstring type
          if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then
          begin
             querysqlstring:=  GetStrProp(DataSource.DataSet, PropInfo);
             SQLStringType:=True;
             querysql:= TStringlist.create;
             querysql.Add(querysqlstring);
          end
          else
             querysql:= TStrings(GetOrdProp(DataSource.DataSet, PropInfo));
         if FOrigSQl.count>0 then begin
            querysql.assign(FOrigSQL);
            ReplaceRemoteSQL(querySQL);
            FOrigSQL.clear;
         end;

         if SQLStringtype then querySQL.Free;

      end
   end;
end;

Procedure TwwFilterDialog.ApplyFilter;
begin
   ShowDialog:= False;
   InitFields; { 1/12/96 }
   Execute;
   ShowDialog:= True;
end;

procedure TwwFieldOperators.SetOpChar(var opChar: string; val: String);
begin
   if (val<>opChar) then begin
      strStripWhiteSpace(val);
      opChar:= val
   end;
   if ((AnsiCompareText(FOrChar,FAndChar)  =0) or
      (AnsiCompareText(FNullChar,FOrChar) =0) or
      (AnsiCompareText(FNullChar,FAndChar)=0)) then
      MessageDlg('Operators do not have a unique value.',
                  mtWarning, [mbOK], 0);
end;

procedure TwwFieldOperators.SetOrChar(val: String);
begin
  SetOpChar(FOrChar,val);
end;

procedure TwwFieldOperators.SetAndChar(val: String);
begin
  SetOpChar(FAndChar,val);
end;

procedure TwwFieldOperators.SetNullChar(val: String);
begin
  SetOpChar(FNullChar,val);
end;

procedure TwwFilterDlg.ApplyIntl;
begin
   Font.Style:= wwInternational.DialogFontStyle;
   FieldTabSet.Font.Style:= Font.Style;
//   ValueRangeTabSet.Font.Style:= Font.Style;
   
   with wwInternational.FilterDialog do begin
      ViewButton.caption:= BtnViewSummary;
      ViewButton.Hint:= BtnViewSummaryHint;
      ClearSearchButton.caption:= BtnNewSearch;
      ClearSearchButton.Hint:= BtnNewSearchHint;
      FieldOrder.Caption:= FieldOrderLabel;
      FieldOrder.Hint:= FieldOrderHint;
      FieldOrder.Items[0]:= AlphabeticLabel;
      FieldOrder.Items[1]:= LogicalLabel;
      FieldTabSet.Tabs[0]:= AllFieldsLabel;
      FieldTabSet.Tabs[1]:= SearchedFieldsLabel;
      StartingRangeLbl.Caption:= StartingRangeLabel;
      MinValueEdit.Hint:= StartingRangeHint;
      MinDateEdit.Hint:= StartingRangeHint;
      EndingRangeLbl.Caption:= EndingRangeLabel;
      MaxValueEdit.Hint:= EndingRangeHint;
      MaxDateEdit.Hint:= EndingRangeHint;
      MinValueClearButton.Caption:= BtnClearMin;
      MinValueClearButton.Hint:= BtnClearMinHint;
      MaxValueClearButton.Caption:= BtnClearMax;
      MaxValueClearButton.Hint:= BtnClearMaxHint;
      FilterValueClearButton.Caption:= BtnClearFilterValue;
      FilterValueClearButton.Hint:= BtnClearFilterValueHint;
      TabSheet1.caption:= ByValueLabel;
      TabSheet2.caption:= ByRangeLabel;
//      ValueRangeTabSet.Tabs[0]:= ByValueLabel;
//      ValueRangeTabSet.Tabs[1]:= ByRangeLabel;
      FieldValueLbl.caption:= FieldValueLabel;
      FilterValueEdit.hint:= FieldValueHint;
      FilterValueCombo.hint:= FieldValueHint;
      MatchTypeGroup.caption:= SearchTypeLabel;
      MatchTypeGroup.hint:= SearchTypeHint;
      MatchTypeGroup.Items[0]:= MatchExactLabel;
      MatchTypeGroup.Items[1]:= MatchStartLabel;
      if MatchTypeGroup.Items.count>2 then MatchTypeGroup.Items[2]:= MatchAnyLabel;
      CaseSensitive.caption:= CaseSensitiveLabel;
      CaseSensitive.hint:= CaseSensitiveHint;
      NonMatching.caption:= NonMatchingLabel;
      NonMatching.hint:= NonMatchingHint;
      FieldsLbl.caption:= FieldsLabel;
//      ValueRangeTabSet.hint:= ValueRangeTabHint;
      FieldTabSet.hint:= AllSearchedTabHint;
   end;
end;

Procedure TwwFilterDialog.AddDependent(value: TComponent);
begin
   FDependentComponents.add(value);
end;

Procedure TwwFilterDialog.RemoveDependent(value: TComponent);
begin
   FDependentComponents.remove(value);
end;

Procedure TwwFilterDialog.DoInitDialog;
begin
  if Assigned(FOnInitDialog) then OnInitDialog(form);
end;

Function wwPadUpperRange(size: integer; s: string; UpperRangePadChar: word): string;
var i: integer;
begin
   if (length(s)< size) and (UpperRangePadChar>0) then
   begin
      for i:= 0 to (size-1)-length(s) do
         s:= s + char(UpperRangePadChar);
      result:= s;
   end
   else result:= s;
end;

procedure TwwFilterDataLink.ActiveChanged;
begin
   inherited ActiveChanged;
   if FilterDialog=Nil then exit;
   FilterDialog.LinkActive(active);
end;

{ Clear filter when table is set to inactive }
procedure TwwFilterDialog.LinkActive(active: Boolean);
begin
   if (not Active) and (not SkipClearFieldInfo) and
      (fdClearWhenCloseDataSet in OnFilterPropertyOptions) then { 4/21/00 - Remove patch[0] reference }
//      ((Patch[0]=False) or (fdClearWhenCloseDataSet in OnFilterPropertyOptions)) then
   begin
      if (FieldInfo.count>0) and (datasource<>nil) and  { 1/26/99 - Check for nil datasource}
         (datasource.dataset is TBDEDataSet) and (FilterMethod = fdByFilter) then
         wwSetOnFilterEnabled(datasource.dataset, False);
      if (FilterMethod = fdByFilter) then
         ClearFilter;
   end;
end;

constructor TwwFilterDataLink.Create(AFilterDialog: TwwFilterDialog);
begin
   inherited Create;
   FilterDialog:= AFilterDialog;
end;

Procedure TwwFilterDialog.DoSelectField(
          FieldName: string;
          var PictureMask: string;
          ComboList: TStrings);
begin
   if Assigned(FOnSelectField) then
      FOnSelectField(self, FieldName, PictureMask, ComboList);
end;

procedure TwwFilterDlg.MatchTypeGroupClick(Sender: TObject);
begin
   UpdateFilterEditControl;
end;

procedure TwwFilterDlg.UpdateFilterEditControl;
var useCombo, usePicture: boolean;
begin
   usePicture:= True;
   if (MatchTypeGroup.itemIndex=2) then
   begin
      useCombo:= False;
      usePicture:= False;
   end
   else if (FilterValueCombo.Items.Count>0) then UseCombo:= True
   else UseCombo:= False;

   if UseCombo then begin
      if FilterValueEditControl<>FilterValueCombo then
      begin
         FilterValueEditControl:= FilterValueCombo;
         FilterValueCombo.visible:= True;
         FilterValueCombo.Text:= FilterValueEdit.Text;
         FilterValueEdit.visible:= False;
      end
   end
   else begin
      if FilterValueEditControl<>FilterValueEdit then
      begin
          FilterValueEditControl:= FilterValueEdit;
          FilterValueEdit.visible:= True;
          FilterValueEdit.Text:= FilterValueCombo.Text;
          FilterValueCombo.visible:= False;
      end
   end;
   FilterValueEdit.UsePictureMask:= usePicture;
   FilterValueCombo.UsePictureMask:= usePicture;
   FieldValueLbl.FocusControl:= FilterValueEditControl;
end;

Procedure TwwFilterDialog.DoAcceptFilterRecord(DataSet: TDataSet;
   var Accept: boolean;
   var DefaultFiltering: boolean);
begin
   if Assigned(FOnAcceptFilterRecord) then
      FOnAcceptFilterRecord(self, DataSet, Accept, DefaultFiltering);
end;

function TwwSQLTablesCollection.GetOwner: TPersistent;
begin
  Result := Control;
end;

function TwwSQLTablesCollection.Add: TwwSQLTablesCollectionItem;
begin
  Result := TwwSQLTablesCollectionItem(inherited Add);
end;

constructor TwwSQLTablesCollection.Create(Control: TComponent);
begin
  inherited Create(TwwSQLTablesCollectionItem);
  self.Control:= Control;
end;

function TwwSQLTablesCollectionItem.GetDisplayName: string;
var TempText: string;
begin
  if TableAliasName<>'' then TempText:= TableAliasName
  else if TableName<>'' then TempText:= TableName
  else TempText:= '<Unassigned>';
  Result := inttostr(Index) + ' - ' + TempText;
end;

function TwwFilterDialog.GetSQLPropertyname: string;
begin
   if FSQLPropertyName<>'' then result:= FSQLPropertyName
   else if (DataSource<>nil) and (DataSource.DataSet<>nil) and
      (wwIsClass(DataSource.Dataset.classtype, 'TClientDataSet') or
       wwIsClass(DataSource.Dataset.classtype, 'TADODataSet')) then
   begin
      result:= 'CommandText';
   end
   else if FSQLPropertyName='' then result:= 'SQL'
end;

procedure TwwFilterDlg.ShowValueRangeTabs;
begin
   if DlgComponent = nil then  exit;
   if fdShowValueRangeTab in (DlgComponent as TwwFilterDialog).Options then
   begin
      TabSheet1.TabVisible := True;
      TabSheet2.TabVisible := True;
   end
   else begin
      TabSheet1.TabVisible := False;
      TabSheet2.TabVisible := False;
   end;
end;

function TwwFilterDlg.GetSQLPropertyname: string;
begin
   result:= TwwFilterDialog(DlgComponent).GetSQLPropertyName;
end;


procedure TwwFilterDlg.AdjustFieldTabSet(NewTab: integer);
var CurrentFieldName: string;
begin
   CurrentFieldName:= '';
   if FieldsListBox.itemIndex>=0 then
      CurrentFieldName:= FieldsListBox.items[FieldsListBox.itemIndex];
   RefreshFieldList(NewTab=0);
   FieldsListBox.itemIndex:= FieldsListBox.items.indexOf(CurrentFieldName);
   FieldsListBox.setFocus;
   LastItemIndex:= -1;

   { Move to correct Value/Range tab page }
//   SelectField(True);
   SelectPage;
   SelectField(True); { 7/7/98 }
   FieldsListBox.SetFocus;
end;

procedure TwwFilterDlg.FieldTabSetChanging(Sender: TObject;
  var AllowChange: Boolean);
var NewTab: integer;
    pt: TPoint;
begin
   pt:= Mouse.CursorPos;
   pt:= (Sender as TWinControl).ScreenToClient(pt);
   NewTab:= (Sender as TTabControl).IndexOfTabAt(pt.x, pt.y);
   if not SelectField(False) then
   begin
      AllowChange:= False;
      exit;  {Flushes current changes }
   end;

   if (NewTab=1) and (FieldInfo.count=0) then begin
      AllowChange:= False;
      MessageDlg(wwInternational.UserMessages.FilterDlgNoCriteria,
                 mtInformation, [mbok], 0);
      exit;
   end;

   AdjustFieldTabSet(NewTab);
(*   CurrentFieldName:= '';
   if FieldsListBox.itemIndex>=0 then
      CurrentFieldName:= FieldsListBox.items[FieldsListBox.itemIndex];
   RefreshFieldList(NewTab=0);
   FieldsListBox.itemIndex:= FieldsListBox.items.indexOf(CurrentFieldName);
   FieldsListBox.setFocus;
   LastItemIndex:= -1;

   { Move to correct Value/Range tab page }
//   SelectField(True);
   SelectPage;
   SelectField(True); { 7/7/98 }
   FieldsListBox.SetFocus;
*)
end;

procedure TwwFilterDlg.FieldCriteriaPanelResize(Sender: TObject);
begin
  SelectNotebook.Height:= FieldCriteriaPanel.Height-SelectNotebook.Top-ButtonPanel.height-5;
end;

end.
