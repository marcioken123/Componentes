// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwfltdlg.pas' rev: 6.00

#ifndef wwfltdlgHPP
#define wwfltdlgHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ComCtrls.hpp>	// Pascal unit
#include <wwradiogroup.hpp>	// Pascal unit
#include <wwclearbuttongroup.hpp>	// Pascal unit
#include <Wwdbcomb.hpp>	// Pascal unit
#include <Wwdotdot.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <wwdbdatetimepicker.hpp>	// Pascal unit
#include <wwDialog.hpp>	// Pascal unit
#include <wwSystem.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <Tabs.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Wwfltdum.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Wwdatsrc.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwfltdlg
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwFilterDialogOption { fdCaseSensitive, fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdShowNonMatching, fdHidePartialAnywhere, fdDisableDateTimePicker, fdSizeable, fdTabsAtTop };
#pragma option pop

#pragma option push -b-
enum TwwFilterFieldsFetchType { fmUseTTable, fmUseSQL, fmUseTFields };
#pragma option pop

typedef Set<TwwFilterDialogOption, fdCaseSensitive, fdTabsAtTop>  TwwFilterDialogOptions;

#pragma option push -b-
enum TwwFilterDialogSort { fdSortByFieldNo, fdSortByFieldName };
#pragma option pop

#pragma option push -b-
enum TwwFilterMatchType { fdMatchStart, fdMatchAny, fdMatchExact, fdMatchEnd, fdMatchRange, fdMatchNone };
#pragma option pop

#pragma option push -b-
enum TwwFilterMethodAll { fdByFilter, fdByQueryModify, fdByQueryParams };
#pragma option pop

typedef TwwFilterMethodAll TwwFilterMethod;

typedef TwwFilterMatchType TwwDefaultMatchType;

#pragma option push -b-
enum TwwDefaultFilterBy { fdSmartFilter, fdFilterByRange, fdFilterByValue };
#pragma option pop

typedef void __fastcall (__closure *TwwFilterDialogSummaryEvent)(System::TObject* Sender, Classes::TList* AFieldInfo, bool &DoDefault);

typedef void __fastcall (__closure *TwwOnInitTempDataSetEvent)(System::TObject* Sender, Db::TDataSet* OrigDataSet, Db::TDataSet* TempDataSet);

class DELPHICLASS TwwFilterDlg;
typedef void __fastcall (__closure *TwwOnInitFilterDlgEvent)(TwwFilterDlg* Dialog);

typedef void __fastcall (__closure *TwwOnExecuteSQLEvent)(TwwFilterDlg* Dialog, Dbtables::TQuery* Query);

typedef void __fastcall (__closure *TwwOnEncodeValueEvent)(Db::TFieldType AFieldType, AnsiString AFieldName, AnsiString &AUserValue);

typedef void __fastcall (__closure *TwwOnEncodeDateTimeEvent)(System::TDateTime ADateTime, Db::TFieldType AFieldType, AnsiString AFieldName, AnsiString &FormattedDateStr);

#pragma option push -b-
enum TwwFilterOptimization { fdNone, fdUseAllIndexes, fdUseActiveIndex };
#pragma option pop

#pragma option push -b-
enum TwwQueryFormatDateMode { qfdMonthDayYear, qfdDayMonthYear, qfdYearMonthDay };
#pragma option pop

typedef void __fastcall (__closure *TwwOnSelectFilterField)(System::TObject* Sender, AnsiString FieldName, AnsiString &PictureMask, Classes::TStrings* ComboList);

typedef void __fastcall (__closure *TwwOnAcceptFilterRecord)(System::TObject* Sender, Db::TDataSet* DataSet, bool &Accept, bool &DefaultFiltering);

class DELPHICLASS TwwFieldInfo;
class PASCALIMPLEMENTATION TwwFieldInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString FieldName;
	AnsiString DisplayLabel;
	TwwFilterMatchType MatchType;
	AnsiString FilterValue;
	AnsiString MinValue;
	AnsiString MaxValue;
	bool CaseSensitive;
	bool NonMatching;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwFieldInfo(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TwwFieldInfo(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwFilterDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* FieldCriteriaPanel;
	Comctrls::TPageControl* SelectNotebook;
	Comctrls::TTabSheet* TabSheet1;
	Stdctrls::TLabel* FieldValueLbl;
	Extctrls::TRadioGroup* MatchTypeGroup;
	Extctrls::TPanel* Panel1;
	Stdctrls::TCheckBox* CaseSensitive;
	Stdctrls::TCheckBox* Nonmatching;
	Buttons::TBitBtn* FilterValueClearButton;
	Wwdbcomb::TwwDBComboBox* FilterValueCombo;
	Wwdbedit::TwwDBEdit* FilterValueEdit;
	Comctrls::TTabSheet* TabSheet2;
	Stdctrls::TLabel* StartingRangeLbl;
	Stdctrls::TLabel* EndingRangeLbl;
	Stdctrls::TEdit* MinValueEdit;
	Stdctrls::TEdit* MaxValueEdit;
	Buttons::TBitBtn* MinValueClearButton;
	Buttons::TBitBtn* MaxValueClearButton;
	Wwdbdatetimepicker::TwwDBDateTimePicker* MinDateEdit;
	Wwdbdatetimepicker::TwwDBDateTimePicker* MaxDateEdit;
	Extctrls::TPanel* FieldListPanel;
	Comctrls::TTabControl* FieldTabSet;
	Stdctrls::TListBox* FieldsListBox;
	Extctrls::TPanel* ButtonPanel;
	Stdctrls::TButton* ViewButton;
	Stdctrls::TButton* ClearSearchButton;
	Extctrls::TPanel* OKCancelPanel;
	Extctrls::TPanel* CriteriaLabelPanel;
	Stdctrls::TLabel* FieldCriteria;
	Extctrls::TPanel* FieldsLabelPanel;
	Stdctrls::TLabel* FieldsLbl;
	Extctrls::TPanel* FieldOrderPanel;
	Extctrls::TRadioGroup* FieldOrder;
	void __fastcall FieldOrderClick(System::TObject* Sender);
	void __fastcall FieldsListBoxClick(System::TObject* Sender);
	void __fastcall ViewButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ValueRangeTabSetChange(System::TObject* Sender, int NewTab, bool &AllowChange);
	void __fastcall ClearSearchButtonClick(System::TObject* Sender);
	void __fastcall FilterValueComboChange(System::TObject* Sender);
	void __fastcall MinValueEditChange(System::TObject* Sender);
	void __fastcall MaxValueEditChange(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall MinValueClearButtonClick(System::TObject* Sender);
	void __fastcall MaxValueClearButtonClick(System::TObject* Sender);
	void __fastcall FilterValueClearButtonClick(System::TObject* Sender);
	void __fastcall MatchTypeGroupClick(System::TObject* Sender);
	void __fastcall FieldTabSetChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall FieldCriteriaPanelResize(System::TObject* Sender);
	
private:
	int LastItemIndex;
	bool FormActivated;
	bool __fastcall IsValueField(AnsiString ADisplayLabel);
	bool __fastcall IsValueType(Db::TFieldType AFieldType);
	void __fastcall RefreshClearbutton(void);
	bool __fastcall ValidEditValue(AnsiString val);
	bool __fastcall ValidEditValues(AnsiString val);
	void __fastcall ApplyIntl(void);
	Db::TFieldType __fastcall GetFieldType(AnsiString ADisplayLabel);
	void __fastcall UpdateFilterEditControl(void);
	AnsiString __fastcall GetSQLPropertyname();
	void __fastcall ShowValueRangeTabs(void);
	
protected:
	Classes::TComponent* DlgComponent;
	Db::TDataSet* DlgDataSet;
	Classes::TList* FieldInfo;
	Stdctrls::TCustomEdit* MinValueEditControl;
	Stdctrls::TCustomEdit* MaxValueEditControl;
	Stdctrls::TCustomEdit* FilterValueEditControl;
	
public:
	Stdctrls::TButton* OKBtn;
	Stdctrls::TButton* CancelBtn;
	bool FilterChanged;
	void __fastcall RefreshFieldList(bool ShowAll);
	void __fastcall AdjustFieldTabSet(int NewTab);
	__fastcall TwwFilterDlg(Classes::TComponent* AOwner, Classes::TComponent* ADlgComponent);
	__fastcall virtual ~TwwFilterDlg(void);
	bool __fastcall SelectField(bool FieldChanged);
	void __fastcall SelectPage(void);
	void __fastcall SelectFocus(void);
	void __fastcall SetFilterfield(AnsiString ADisplayLabel, TwwFilterMatchType AMatchType, AnsiString AFilterValue, AnsiString AMinValue, AnsiString AMaxValue, bool ACaseSensitive, bool ANonMatching);
	bool __fastcall GetFilterField(AnsiString ADisplayLabel, TwwFieldInfo* &FldInfo);
	void __fastcall CopyList(Classes::TList* fromlist, Classes::TList* tolist);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TwwFilterDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwFilterDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwFilterDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBFieldInfo;
class PASCALIMPLEMENTATION TwwDBFieldInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString LogicalFieldName;
	AnsiString PhysicalFieldName;
	AnsiString TableName;
	Db::TFieldType FieldType;
	AnsiString DisplayLabel;
	int Size;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwDBFieldInfo(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TwwDBFieldInfo(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwDatasetFilterType { fdUseOnFilter, fdUseFilterProp, fdUseBothFilterTypes };
#pragma option pop

class DELPHICLASS TwwFilterPropertyOptions;
class PASCALIMPLEMENTATION TwwFilterPropertyOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TwwDatasetFilterType FDatasetFilterType;
	AnsiString FLikeWildcardChar;
	bool FUseBracketsAroundFields;
	bool FUseLikeOperator;
	bool FLikeSupportsUpperKeyword;
	
__published:
	__property TwwDatasetFilterType DatasetFilterType = {read=FDatasetFilterType, write=FDatasetFilterType, default=0};
	__property bool UseLikeOperator = {read=FUseLikeOperator, write=FUseLikeOperator, default=0};
	__property AnsiString LikeWildcardChar = {read=FLikeWildcardChar, write=FLikeWildcardChar};
	__property bool LikeSupportsUpperKeyword = {read=FLikeSupportsUpperKeyword, write=FLikeSupportsUpperKeyword, default=0};
	__property bool UseBracketsAroundFields = {read=FUseBracketsAroundFields, write=FUseBracketsAroundFields, default=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwFilterPropertyOptions(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwFilterPropertyOptions(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwFieldOperators;
class PASCALIMPLEMENTATION TwwFieldOperators : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FOrChar;
	AnsiString FAndChar;
	AnsiString FNullChar;
	void __fastcall SetOrChar(AnsiString val);
	void __fastcall SetAndChar(AnsiString val);
	void __fastcall SetNullChar(AnsiString val);
	void __fastcall SetOpChar(AnsiString &opchar, AnsiString val);
	
public:
	__fastcall TwwFieldOperators(Classes::TComponent* Owner);
	
__published:
	__property AnsiString OrChar = {read=FOrChar, write=SetOrChar};
	__property AnsiString AndChar = {read=FAndChar, write=SetAndChar};
	__property AnsiString NullChar = {read=FNullChar, write=SetNullChar};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwFieldOperators(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwSQLTablesCollectionItem;
class PASCALIMPLEMENTATION TwwSQLTablesCollectionItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FTableName;
	AnsiString FTableAliasName;
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	
__published:
	__property AnsiString TableName = {read=FTableName, write=FTableName};
	__property AnsiString TableAliasName = {read=FTableAliasName, write=FTableAliasName};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TwwSQLTablesCollectionItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TwwSQLTablesCollectionItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwSQLTablesCollection;
class PASCALIMPLEMENTATION TwwSQLTablesCollection : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
protected:
	Classes::TComponent* Control;
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TwwSQLTablesCollection(Classes::TComponent* Control);
	HIDESBASE TwwSQLTablesCollectionItem* __fastcall Add(void);
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TwwSQLTablesCollection(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwOnFilterPropertyOption { fdClearWhenNoCriteria, fdClearWhenCloseDataSet };
#pragma option pop

typedef Set<TwwOnFilterPropertyOption, fdClearWhenNoCriteria, fdClearWhenCloseDataSet>  TwwOnFilterPropertyOptions;

class DELPHICLASS TwwFilterDialog;
class PASCALIMPLEMENTATION TwwFilterDialog : public Wwdialog::TwwCustomDialog 
{
	typedef Wwdialog::TwwCustomDialog inherited;
	
private:
	Db::TDataLink* FDataLink;
	TwwFilterDialogOptions FOptions;
	TwwFilterDialogSort FSortBy;
	Wwfltdum::TwwDummyForm* FDummyForm;
	AnsiString FTitle;
	TwwFilterMethodAll FFilterMethod;
	TwwFilterMatchType FDefaultMatchType;
	TwwDefaultFilterBy FDefaultFilterBy;
	AnsiString FDefaultField;
	Classes::TStrings* FSelectedFields;
	TwwOnInitFilterDlgEvent FOnInitDialog;
	TwwOnExecuteSQLEvent FOnExecuteSQL;
	TwwFieldOperators* FwwOperators;
	bool FRangeApplied;
	TwwFilterOptimization FFilterOptimization;
	Word FUpperRangePadChar;
	int FDlgHeight;
	TwwOnEncodeValueEvent FOnEncodeValue;
	TwwOnEncodeDateTimeEvent FOnEncodeDateTime;
	TwwOnSelectFilterField FOnSelectField;
	TwwOnInitTempDataSetEvent FOnInitTempDataSet;
	TwwOnAcceptFilterRecord FOnAcceptFilterRecord;
	TwwFilterFieldsFetchType FFieldsFetchMethod;
	TwwFilterDialogSummaryEvent FOnDialogSummary;
	Classes::TStrings* FOrigSQL;
	Classes::TList* FFldList;
	bool FShowDialog;
	Classes::TList* FDependentComponents;
	TwwQueryFormatDateMode FQueryFormatDateMode;
	TwwFilterPropertyOptions* FFilterPropertyOptions;
	TwwOnFilterPropertyOptions FOnFilterPropertyOptions;
	TwwSQLTablesCollection* FSQLTables;
	AnsiString FSQLUpperString;
	bool SkipClearFieldInfo;
	AnsiString FSQLPropertyName;
	void __fastcall SetDataSource(Db::TDataSource* value);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetFilterMethod(TwwFilterMethod val);
	void __fastcall ReplaceRemoteSQL(Classes::TStrings* querySQL);
	AnsiString __fastcall PadUpperRange(int size, AnsiString val);
	void __fastcall SetDlgHeight(int val);
	AnsiString __fastcall GetEffectiveSQLUpperString();
	
protected:
	virtual void __fastcall FilterDialogView(Classes::TList* AFieldInfo);
	virtual AnsiString __fastcall GetSQLPropertyname();
	virtual void __fastcall DoInitDialog(void);
	TwwDBFieldInfo* __fastcall AddDBFieldInfo(void);
	virtual void __fastcall LinkActive(bool active);
	virtual void __fastcall DoSelectField(AnsiString FieldName, AnsiString &PictureMask, Classes::TStrings* ComboList);
	virtual void __fastcall DoInitTempDataSet(Db::TDataSet* OrigDataSet, Db::TDataSet* TempDataset);
	virtual void __fastcall DoAcceptFilterRecord(Db::TDataSet* DataSet, bool &Accept, bool &DefaultFiltering);
	virtual void __fastcall InitQueryFields(void);
	virtual void __fastcall InitTableFields(void);
	virtual void __fastcall ReplaceWhereClause(Classes::TStrings* whereClause);
	
public:
	char *MemoBuffer;
	TwwFilterDlg* Form;
	Classes::TList* FieldInfo;
	bool FieldsInDblQuotes;
	Variant Patch;
	Classes::TStringList* SQLWhereClause;
	__fastcall virtual TwwFilterDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwFilterDialog(void);
	bool __fastcall ExecuteDialog(bool ExecuteQuery = true, Classes::TStrings* ReturnWhereClause = (Classes::TStrings*)(0x0));
	virtual bool __fastcall Execute(void);
	virtual Db::TDataSet* __fastcall GetPrimaryDataSet(void);
	void __fastcall ApplyFilter(void);
	void __fastcall ClearFilter(void);
	virtual void __fastcall InitFields(void);
	__property Classes::TList* AllFields = {read=FFldList};
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, nodefault};
	TwwDBFieldInfo* __fastcall GetDBInfoForField(AnsiString AFilterFieldName);
	void __fastcall AddDependent(Classes::TComponent* value);
	void __fastcall RemoveDependent(Classes::TComponent* value);
	TwwFieldInfo* __fastcall AddFieldInfo(void);
	
__published:
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TwwFilterDialogSummaryEvent OnDialogSummary = {read=FOnDialogSummary, write=FOnDialogSummary};
	__property TwwFilterDialogOptions Options = {read=FOptions, write=FOptions, default=62};
	__property TwwFilterDialogSort SortBy = {read=FSortBy, write=FSortBy, nodefault};
	__property AnsiString Caption = {read=FTitle, write=FTitle};
	__property TwwFilterMethod FilterMethod = {read=FFilterMethod, write=SetFilterMethod, nodefault};
	__property TwwDefaultMatchType DefaultMatchType = {read=FDefaultMatchType, write=FDefaultMatchType, nodefault};
	__property TwwDefaultFilterBy DefaultFilterBy = {read=FDefaultFilterBy, write=FDefaultFilterBy, nodefault};
	__property AnsiString DefaultField = {read=FDefaultField, write=FDefaultField};
	__property TwwFilterFieldsFetchType FieldsFetchMethod = {read=FFieldsFetchMethod, write=FFieldsFetchMethod, default=0};
	__property TwwFieldOperators* FieldOperators = {read=FwwOperators, write=FwwOperators};
	__property TwwFilterPropertyOptions* FilterPropertyOptions = {read=FFilterPropertyOptions, write=FFilterPropertyOptions};
	__property TwwOnFilterPropertyOptions OnFilterPropertyOptions = {read=FOnFilterPropertyOptions, write=FOnFilterPropertyOptions, default=3};
	__property Classes::TStrings* SelectedFields = {read=FSelectedFields, write=FSelectedFields};
	__property TwwFilterOptimization FilterOptimization = {read=FFilterOptimization, write=FFilterOptimization, nodefault};
	__property Word UpperRangePadChar = {read=FUpperRangePadChar, write=FUpperRangePadChar, default=122};
	__property int DlgHeight = {read=FDlgHeight, write=SetDlgHeight, default=267};
	__property TwwQueryFormatDateMode QueryFormatDateMode = {read=FQueryFormatDateMode, write=FQueryFormatDateMode, nodefault};
	__property TwwSQLTablesCollection* SQLTables = {read=FSQLTables, write=FSQLTables};
	__property AnsiString SQLUpperString = {read=FSQLUpperString, write=FSQLUpperString};
	__property AnsiString SQLPropertyName = {read=FSQLPropertyName, write=FSQLPropertyName};
	__property TwwOnInitFilterDlgEvent OnInitDialog = {read=FOnInitDialog, write=FOnInitDialog};
	__property TwwOnExecuteSQLEvent OnExecuteSQL = {read=FOnExecuteSQL, write=FOnExecuteSQL};
	__property TwwOnEncodeValueEvent OnEncodeValue = {read=FOnEncodeValue, write=FOnEncodeValue};
	__property TwwOnEncodeDateTimeEvent OnEncodeDateTime = {read=FOnEncodeDateTime, write=FOnEncodeDateTime};
	__property TwwOnSelectFilterField OnSelectField = {read=FOnSelectField, write=FOnSelectField};
	__property TwwOnInitTempDataSetEvent OnInitTempDataSet = {read=FOnInitTempDataSet, write=FOnInitTempDataSet};
	__property TwwOnAcceptFilterRecord OnAcceptFilterRecord = {read=FOnAcceptFilterRecord, write=FOnAcceptFilterRecord};
};


class DELPHICLASS TwwFilterDataLink;
class PASCALIMPLEMENTATION TwwFilterDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TwwFilterDialog* FilterDialog;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TwwFilterDataLink(TwwFilterDialog* AFilterDialog);
public:
	#pragma option push -w-inl
	/* TDataLink.Destroy */ inline __fastcall virtual ~TwwFilterDataLink(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwfltdlg)
extern PACKAGE TwwFilterDlg* wwFilterDlg;
extern PACKAGE void __fastcall Register(void);
extern PACKAGE AnsiString __fastcall wwGetFilterToken(AnsiString FilterValue, AnsiString SearchDelimiter, int &CurPos);
extern PACKAGE AnsiString __fastcall wwGetFilterOperator(AnsiString FilterValue, TwwFieldOperators* FilterOperator, bool &OrFlg, bool &AndFlg);
extern PACKAGE AnsiString __fastcall wwPadUpperRange(int size, AnsiString s, Word UpperRangePadChar);

}	/* namespace Wwfltdlg */
using namespace Wwfltdlg;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwfltdlg
