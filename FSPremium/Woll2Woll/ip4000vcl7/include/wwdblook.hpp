// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwdblook.pas' rev: 6.00

#ifndef wwdblookHPP
#define wwdblookHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <wwcombobutton.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Wwlocate.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Wwdbigrd.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <Wwtable.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdblook
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TNotifyCloseUpEvent)(System::TObject* Sender, Db::TDataSet* LookupTable, Db::TDataSet* FillTable, bool modified);

typedef void __fastcall (__closure *TNotInListEvent)(System::TObject* Sender, Db::TDataSet* LookupTable, AnsiString NewValue, bool &Accept);

typedef void __fastcall (__closure *TwwPerformSearchEvent)(System::TObject* Sender, Db::TDataSet* LookupTable, AnsiString SearchField, AnsiString SearchValue, bool PerformLookup, bool &Found);

#pragma option push -b-
enum TwwDBLookupComboStyle { csDropDown, csDropDownList };
#pragma option pop

#pragma option push -b-
enum TwwDBLookupListOption { loColLines, loRowLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace };
#pragma option pop

typedef Set<TwwDBLookupListOption, loColLines, loSearchOnBackspace>  TwwDBLookupListOptions;

#pragma option push -b-
enum TwwCalcFieldType { cftUnknown, cftCalculated, cftNotCalculated };
#pragma option pop

#pragma option push -b-
enum TwwSeqSearchOption { ssoEnabled, ssoCaseSensitive };
#pragma option pop

typedef Set<TwwSeqSearchOption, ssoEnabled, ssoCaseSensitive>  TwwSeqSearchOptions;

#pragma option push -b-
enum TwwLookupSearchType { lstDefault, lstCustom };
#pragma option pop

class DELPHICLASS TwwDropDownGridOptions;
class PASCALIMPLEMENTATION TwwDropDownGridOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FTitleLines;
	Graphics::TColor FColor;
	Classes::TAlignment FTitleAlignment;
	
public:
	__fastcall TwwDropDownGridOptions(Classes::TComponent* AOwner);
	
__published:
	__property int TitleLines = {read=FTitleLines, write=FTitleLines, default=1};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777211};
	__property Classes::TAlignment TitleAlignment = {read=FTitleAlignment, write=FTitleAlignment, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwDropDownGridOptions(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBCustomLookupCombo;
class DELPHICLASS TwwPopupGrid;
class DELPHICLASS TwwDBLookupList;
class PASCALIMPLEMENTATION TwwDBLookupList : public Wwdbigrd::TwwCustomDBGrid 
{
	typedef Wwdbigrd::TwwCustomDBGrid inherited;
	
private:
	TwwDBCustomLookupCombo* FCombo;
	Dbctrls::TFieldDataLink* FFieldLink;
	Dbctrls::TFieldDataLink* FNavigatorLink;
	AnsiString FLookupField;
	Db::TField* FDisplayFld;
	Db::TField* FValueFld;
	Db::TField* FValueFld2;
	Db::TField* FValueFld3;
	AnsiString FValue;
	AnsiString FValue2;
	AnsiString FValue3;
	AnsiString FDisplayValue;
	int FHiliteRow;
	TwwDBLookupListOptions FOptions;
	int FTitleOffset;
	bool FFoundValue;
	bool FInCellSelect;
	Classes::TNotifyEvent FOnListClick;
	bool BeAccurate;
	int inDataChanged;
	AnsiString DummyString;
	HIDESBASE Classes::TStrings* __fastcall getSelectedFields(void);
	HIDESBASE void __fastcall setSelectedFields(Classes::TStrings* sel);
	AnsiString __fastcall GetDataField();
	HIDESBASE Db::TDataSource* __fastcall GetDataSource(void);
	Db::TDataSource* __fastcall GetLookupSource(void);
	AnsiString __fastcall GetLookupField();
	Db::TDataSet* __fastcall GetLookupTable(void);
	AnsiString __fastcall GetValue();
	AnsiString __fastcall GetValue2();
	AnsiString __fastcall GetValue3();
	AnsiString __fastcall GetDisplayValue();
	bool __fastcall GetReadOnly(void);
	void __fastcall FieldLinkActive(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall NavigatorDataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall SetDataField(const AnsiString Value);
	HIDESBASE void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetLookupSource(Db::TDataSource* Value);
	void __fastcall SetLookupTable(Db::TDataSet* value);
	void __fastcall SetLookupField(const AnsiString Value);
	void __fastcall SetValue(const AnsiString Value);
	void __fastcall SetDisplayValue(const AnsiString Value);
	void __fastcall SetReadOnly(bool Value);
	HIDESBASE void __fastcall SetOptions(TwwDBLookupListOptions Value);
	HIDESBASE void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall NewLayout(void);
	void __fastcall FastLookup(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	
protected:
	Wwtable::TwwTable* __fastcall LTable(void);
	bool __fastcall isWWCalculatedField(void);
	virtual bool __fastcall HighlightCell(int DataCol, int DataRow, const AnsiString Value, Grids::TGridDrawState AState);
	DYNAMIC bool __fastcall CanGridAcceptKey(Word Key, Classes::TShiftState Shift);
	virtual void __fastcall DefineFieldMap(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall CanEdit(void);
	void __fastcall InitFields(bool showError);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall LinkActive(bool Value);
	virtual void __fastcall Scroll(int Distance);
	DYNAMIC void __fastcall ListClick(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DataChanged(void);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	
public:
	int lookupFieldCount;
	__fastcall virtual TwwDBLookupList(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBLookupList(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	__property AnsiString Value = {read=GetValue, write=SetValue};
	__property AnsiString DisplayValue = {read=GetDisplayValue, write=SetDisplayValue};
	__property Db::TField* DisplayFld = {read=FDisplayFld};
	__property VisibleRowCount ;
	virtual void __fastcall SetColumnAttributes(void);
	void __fastcall DoLookup(bool SetToDisplayIndex);
	
__published:
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Classes::TStrings* Selected = {read=getSelectedFields, write=setSelectedFields};
	__property Db::TDataSet* LookupTable = {read=GetLookupTable, write=SetLookupTable};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property AnsiString LookupField = {read=GetLookupField, write=SetLookupField};
	__property TwwDBLookupListOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property Classes::TNotifyEvent OnClick = {read=FOnListClick, write=FOnListClick};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Align  = {default=0};
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBLookupList(HWND ParentWindow) : Wwdbigrd::TwwCustomDBGrid(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwPopupGrid : public TwwDBLookupList 
{
	typedef TwwDBLookupList inherited;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall CanEdit(void);
	virtual void __fastcall LinkActive(bool Value);
	
public:
	__property RowCount  = {default=5};
	__property ColCount  = {default=5};
	__fastcall virtual TwwPopupGrid(Classes::TComponent* AOwner);
	
__published:
	__property ControlType ;
public:
	#pragma option push -w-inl
	/* TwwDBLookupList.Destroy */ inline __fastcall virtual ~TwwPopupGrid(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwPopupGrid(HWND ParentWindow) : TwwDBLookupList(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwDBCustomLookupCombo : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	Wwdbedit::TwwDBPicture* FPicture;
	Classes::TAlignment FDropDownAlignment;
	Controls::TControlCanvas* FCanvas;
	int FDropDownCount;
	int FDropDownWidth;
	Controls::TWinControl* FBtnControl;
	TwwDBLookupComboStyle FStyle;
	Classes::TNotifyEvent FOnDropDown;
	TNotifyCloseUpEvent FOnCloseUp;
	TNotInListEvent FOnNotInList;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	bool FShowMatchText;
	TwwPerformSearchEvent FOnPerformCustomSearch;
	Classes::TNotifyEvent FOnBeforeDropDown;
	TwwDropDownGridOptions* FDropDownGridOptions;
	bool FNavigator;
	bool ChangingFromLink;
	bool ProcessingNotInList;
	bool InCloseUpEvent;
	int FSearchDelay;
	bool FAutoDropDown;
	AnsiString FSearchField;
	TwwSeqSearchOptions FSeqSearchOptions;
	bool FOrderByDisplay;
	int FItemCount;
	bool FPreciseEditRegion;
	bool FAllowClearKey;
	bool FUseTFields;
	Controls::TImageList* FImageList;
	Wwframe::TwwComboButtonStyle FButtonStyle;
	int ExtraHeight;
	bool FControlInfoInDataset;
	Wwframe::TwwEditFrame* FFrame;
	Wwframe::TwwButtonEffects* FButtonEffects;
	int FButtonWidth;
	bool SkipUpdate;
	bool SetModifiedInChangeEvent;
	bool InCustomSearch;
	bool FDisableThemes;
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TDataSet* __fastcall GetLookupTable(void);
	AnsiString __fastcall GetLookupField();
	bool __fastcall GetReadOnly(void);
	AnsiString __fastcall GetValue();
	AnsiString __fastcall GetValue2();
	AnsiString __fastcall GetValue3();
	void __fastcall EnableEdit(void);
	AnsiString __fastcall GetDisplayValue();
	int __fastcall GetMinHeight(void);
	TwwDBLookupListOptions __fastcall GetOptions(void);
	bool __fastcall CanEdit(void);
	bool __fastcall Editable(void);
	bool __fastcall MouseEditable(void);
	void __fastcall SetValue(const AnsiString NewValue);
	void __fastcall SetDisplayValue(const AnsiString NewValue);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetLookupTable(Db::TDataSet* sel);
	void __fastcall SetLookupField(const AnsiString Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall SetOptions(TwwDBLookupListOptions Value);
	void __fastcall SetStyle(TwwDBLookupComboStyle Value);
	void __fastcall SetPreciseEditRegion(bool val);
	void __fastcall FieldLinkActive(System::TObject* Sender);
	void __fastcall NonEditMouseDown(Messages::TWMMouse &Message);
	void __fastcall DoSelectAll(void);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSetFont(Messages::TWMSetFont &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	Classes::TStrings* __fastcall getSelectedFields(void);
	void __fastcall setSelectedFields(Classes::TStrings* sel);
	bool __fastcall GetShowButton(void);
	void __fastcall SetShowButton(bool sel);
	bool __fastcall IsLookup(void);
	void __fastcall SetUseTFields(bool val);
	Classes::TStrings* __fastcall GetControlType(void);
	void __fastcall SetControlType(Classes::TStrings* val);
	void __fastcall SetButtonGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	void __fastcall SetButtonStyle(Wwframe::TwwComboButtonStyle val);
	void __fastcall SetButtonWidth(int val);
	int __fastcall GetButtonWidth(void);
	void __fastcall SetNavigator(bool Value);
	
protected:
	Dbctrls::TFieldDataLink* FFieldLink;
	Extctrls::TTimer* FTimer;
	TwwPopupGrid* FGrid;
	Wwcombobutton::TwwComboButton* FButton;
	AnsiString FLastSearchKey;
	bool InList;
	AnsiString TypedInText;
	AnsiString OldLookupValue;
	AnsiString OldDisplayValue;
	bool InAutoDropDown;
	bool SkipDataChange;
	bool FMouseInButtonControl;
	bool FFocused;
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	bool __fastcall HasMasterSource(void);
	bool __fastcall UseSeqSearch(void);
	Wwtable::TwwTable* __fastcall LTable(void);
	bool __fastcall IsWWCalculatedField(void);
	virtual void __fastcall DrawButton(Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, Controls::TControlState ControlState, bool &DefaultPaint);
	AnsiString __fastcall SetValue2();
	AnsiString __fastcall SetValue3();
	void __fastcall WwChangeFromLink(Db::TDataSet* AlookupTable, bool &modified);
	virtual void __fastcall OnEditTimerEvent(System::TObject* Sender);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	Db::TDataSource* __fastcall GetLookupSource(void);
	void __fastcall UpdateData(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	void __fastcall GridClick(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	AnsiString __fastcall GetLookupValue();
	void __fastcall RedrawListGrid(void);
	void __fastcall UpdateButtonGlyph(void);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall UpdateFromCurrentSelection(void);
	void __fastcall UpdateSearchIndex(bool useDisplayIndex);
	int __fastcall GetSearchIndex(void);
	HIDESBASE void __fastcall SetModified(bool val);
	bool __fastcall IsValidChar(Word key);
	virtual bool __fastcall IsLookupDlg(void);
	bool __fastcall IsLookupRequired(void);
	virtual bool __fastcall DoFindRecord(AnsiString ASearchValue, AnsiString ASearchField, Wwlocate::TwwLocateMatchType matchType);
	void __fastcall ComputeLookupFields(void);
	void __fastcall UpdateButtonPosition(void);
	virtual bool __fastcall FindRecord(AnsiString KeyValue, AnsiString LookupField, Wwlocate::TwwLocateMatchType MatchType, bool CaseSensitive, bool PerformLookup = false);
	virtual void __fastcall DrawFrame(Graphics::TCanvas* Canvas);
	virtual bool __fastcall IsCustom(void);
	bool __fastcall Is3DBorder(void);
	Classes::TAlignment __fastcall GetEffectiveAlignment(void);
	void __fastcall InvalidateTransparentButton(void);
	virtual void __fastcall PerformCustomSearch(AnsiString SearchField, AnsiString SearchValue, bool PerformLookup, bool &Found);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	__property Controls::TControlCanvas* ControlCanvas = {read=FCanvas};
	
public:
	TwwCalcFieldType wwDBCalcFieldType;
	Variant Patch;
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	bool __fastcall isTransparentEffective(void);
	void __fastcall RefreshDisplay(void);
	void __fastcall RefreshButton(void);
	void __fastcall PerformSearch(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	__fastcall virtual TwwDBCustomLookupCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomLookupCombo(void);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall CloseUp(bool modified);
	__property AnsiString Value = {read=GetValue, write=SetValue};
	__property AnsiString Value2 = {read=GetValue2};
	__property AnsiString Value3 = {read=GetValue3};
	__property AnsiString LookupValue = {read=GetLookupValue, write=SetValue};
	__property AnsiString DisplayValue = {read=GetDisplayValue, write=SetDisplayValue};
	__property AnsiString SearchField = {read=FSearchField, write=FSearchField};
	__property Classes::TLeftRight DropDownAlignment = {read=FDropDownAlignment, write=FDropDownAlignment, nodefault};
	__property Classes::TStrings* Selected = {read=getSelectedFields, write=setSelectedFields};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Wwframe::TwwComboButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property Wwframe::TwwButtonEffects* ButtonEffects = {read=FButtonEffects, write=FButtonEffects};
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=IsCustom};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, default=0};
	__property Db::TDataSet* LookupTable = {read=GetLookupTable, write=SetLookupTable};
	__property AnsiString LookupField = {read=GetLookupField, write=SetLookupField};
	__property TwwDBLookupListOptions Options = {read=GetOptions, write=SetOptions, default=0};
	__property TwwDBLookupComboStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool AutoDropDown = {read=FAutoDropDown, write=FAutoDropDown, nodefault};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnBeforeDropDown = {read=FOnBeforeDropDown, write=FOnBeforeDropDown};
	__property TNotifyCloseUpEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property bool ShowButton = {read=GetShowButton, write=SetShowButton, nodefault};
	__property TwwSeqSearchOptions SeqSearchOptions = {read=FSeqSearchOptions, write=FSeqSearchOptions, default=1};
	__property TNotInListEvent OnNotInList = {read=FOnNotInList, write=FOnNotInList};
	__property TwwPopupGrid* Grid = {read=FGrid, write=FGrid};
	__property bool OrderByDisplay = {read=FOrderByDisplay, write=FOrderByDisplay, default=1};
	__property bool PreciseEditRegion = {read=FPreciseEditRegion, write=SetPreciseEditRegion, nodefault};
	__property bool AllowClearKey = {read=FAllowClearKey, write=FAllowClearKey, nodefault};
	__property bool ShowMatchText = {read=FShowMatchText, write=FShowMatchText, default=0};
	__property bool UseTFields = {read=FUseTFields, write=SetUseTFields, default=1};
	__property Controls::TImageList* ImageList = {read=FImageList, write=FImageList};
	__property bool ControlInfoInDataset = {read=FControlInfoInDataset, write=FControlInfoInDataset, default=1};
	__property Classes::TStrings* ControlType = {read=GetControlType, write=SetControlType};
	__property Wwframe::TwwEditFrame* Frame = {read=FFrame, write=FFrame};
	__property int SearchDelay = {read=FSearchDelay, write=FSearchDelay, default=0};
	__property TwwDropDownGridOptions* DropDownGridOptions = {read=FDropDownGridOptions, write=FDropDownGridOptions};
	__property TwwPerformSearchEvent OnPerformCustomSearch = {read=FOnPerformCustomSearch, write=FOnPerformCustomSearch};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property bool Navigator = {read=FNavigator, write=SetNavigator, nodefault};
	__property bool DisableThemes = {read=FDisableThemes, write=FDisableThemes, nodefault};
	
__published:
	__property Wwdbedit::TwwDBPicture* Picture = {read=FPicture, write=FPicture};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property ParentBiDiMode  = {default=1};
	__property AutoSize  = {default=1};
	__property Ctl3D ;
	__property Font ;
	__property CharCase  = {default=0};
	__property BorderStyle  = {default=1};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomLookupCombo(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDBLookupCombo;
class PASCALIMPLEMENTATION TwwDBLookupCombo : public TwwDBCustomLookupCombo 
{
	typedef TwwDBCustomLookupCombo inherited;
	
__published:
	__property DisableThemes ;
	__property ControlInfoInDataset  = {default=1};
	__property ControlType ;
	__property DropDownAlignment ;
	__property Selected ;
	__property DataField ;
	__property DataSource ;
	__property LookupTable ;
	__property LookupField ;
	__property Options  = {default=0};
	__property Style  = {default=0};
	__property AutoSelect  = {default=1};
	__property Color  = {default=-16777211};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property DropDownCount  = {default=8};
	__property DropDownWidth  = {default=0};
	__property Enabled  = {default=1};
	__property ButtonStyle  = {default=1};
	__property ButtonEffects ;
	__property Navigator ;
	__property Frame ;
	__property ButtonWidth  = {default=0};
	__property ButtonGlyph ;
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property ImageList ;
	__property MaxLength  = {default=0};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property AutoDropDown ;
	__property ShowButton ;
	__property SeqSearchOptions  = {default=1};
	__property OrderByDisplay  = {default=1};
	__property SearchDelay  = {default=0};
	__property UseTFields  = {default=1};
	__property AllowClearKey ;
	__property ShowMatchText  = {default=0};
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnBeforeDropDown ;
	__property OnDropDown ;
	__property OnCloseUp ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnNotInList ;
	__property OnPerformCustomSearch ;
public:
	#pragma option push -w-inl
	/* TwwDBCustomLookupCombo.Create */ inline __fastcall virtual TwwDBLookupCombo(Classes::TComponent* AOwner) : TwwDBCustomLookupCombo(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomLookupCombo.Destroy */ inline __fastcall virtual ~TwwDBLookupCombo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBLookupCombo(HWND ParentWindow) : TwwDBCustomLookupCombo(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwLookupComboButton;
class PASCALIMPLEMENTATION TwwLookupComboButton : public Wwcombobutton::TwwComboButton 
{
	typedef Wwcombobutton::TwwComboButton inherited;
	
protected:
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall paint(void);
public:
	#pragma option push -w-inl
	/* TwwComboButton.Create */ inline __fastcall virtual TwwLookupComboButton(Classes::TComponent* AOwner) : Wwcombobutton::TwwComboButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwComboButton.Destroy */ inline __fastcall virtual ~TwwLookupComboButton(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwdblook)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwdblook */
using namespace Wwdblook;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwdblook
