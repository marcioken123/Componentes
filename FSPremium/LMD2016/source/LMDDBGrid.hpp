// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBGrid.pas' rev: 31.00 (Windows)

#ifndef LmddbgridHPP
#define LmddbgridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <LMDTypes.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Data.DB.hpp>
#include <Vcl.Menus.hpp>
#include <LMDStrings.hpp>
#include <intfLMDBase.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDGrid.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbgrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridDataLink;
class DELPHICLASS TLMDGridLookupChooser;
class DELPHICLASS TLMDCustomDBGrid;
class DELPHICLASS TLMDDBGrid;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TGridDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TLMDCustomDBGrid* FGrid;
	int FOldFieldCnt;
	void __fastcall ResetOldFieldCnt(void);
	int __fastcall FieldCnt(void);
	
protected:
	virtual void __fastcall DataEvent(Data::Db::TDataEvent Event, NativeInt Info);
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall FocusControl(Data::Db::TFieldRef Field);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Data::Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	virtual void __fastcall CheckBrowseMode(void);
	
public:
	__fastcall TGridDataLink(TLMDCustomDBGrid* AGrid);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TGridDataLink(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDGridLookupChooser : public Lmdgrid::TLMDGridColumnChooser
{
	typedef Lmdgrid::TLMDGridColumnChooser inherited;
	
private:
	TLMDCustomDBGrid* FDBGrid;
	int FDefWidth;
	int FItemHeight;
	int FDropDownCount;
	Data::Db::TDataSource* FLookupSource;
	System::Variant FKey;
	System::Variant FValue;
	TLMDCustomDBGrid* __fastcall CreateDBGrid(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, Lmdgrid::TLMDGridCellStates ACellState);
	void __fastcall SetDropDownCount(const int Value);
	int __fastcall CalkHeight(void);
	
protected:
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual void __fastcall SetFocus(void);
	virtual Lmdgrid::TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual Lmdgrid::TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect);
	virtual System::Types::TSize __fastcall GetControlSize(void);
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	
public:
	__fastcall virtual TLMDGridLookupChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridLookupChooser(void);
	
__published:
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=18};
	__property int DropDownCount = {read=FDropDownCount, write=SetDropDownCount, default=7};
};


typedef void __fastcall (__closure *TLMDDataSetSortEvent)(System::TObject* Sender, Lmdgrid::TLMDGridColumn* AColumn, Lmdgrid::TLMDGridSortKind ASortKind, Data::Db::TDataSet* ADataSet);

class PASCALIMPLEMENTATION TLMDCustomDBGrid : public Lmdgrid::TLMDCustomGrid
{
	typedef Lmdgrid::TLMDCustomGrid inherited;
	
	
private:
	typedef System::DynamicArray<Data::Db::TField*> _TLMDCustomDBGrid__1;
	
	typedef System::DynamicArray<Data::Db::TField*> _TLMDCustomDBGrid__2;
	
	typedef System::DynamicArray<bool> _TLMDCustomDBGrid__3;
	
	
private:
	TGridDataLink* FLink;
	bool FAutoColumnsMode;
	bool FDoRemoveDefPropsMode;
	_TLMDCustomDBGrid__1 FColFields;
	_TLMDCustomDBGrid__2 FColFieldsKey;
	_TLMDCustomDBGrid__3 FColFieldsCompat;
	System::DynamicArray<System::Byte> FSelAncBmk;
	System::Types::TPoint FSelAnc;
	TLMDDataSetSortEvent FGridSortEvent;
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(Data::Db::TDataSource* const Value);
	Data::Db::TFields* __fastcall GetFields(bool ActiveDSOnly = true);
	Lmdgrid::TLMDGridColumn* __fastcall ColByField(System::UnicodeString AField)/* overload */;
	Lmdgrid::TLMDGridColumn* __fastcall ColByField(Data::Db::TField* AField)/* overload */;
	Data::Db::TField* __fastcall FieldByCol(Lmdgrid::TLMDGridColumn* AColumn);
	void __fastcall MoveColField(int AFrom, int ATo);
	int __fastcall GetAveTextWidth(const Lmdtypes::TLMDString AText, int AMaxTextLn, Vcl::Graphics::TFont* AFont);
	int __fastcall GetTextLnByWidth(int AWidth, Vcl::Graphics::TFont* AFont);
	void __fastcall ReadAutoColumns(System::Classes::TReader* Reader);
	void __fastcall WriteAutoColumns(System::Classes::TWriter* Writer);
	bool __fastcall IsColumnFieldCompatible(Lmdgrid::TLMDGridColumn* ACol, bool ABySettings, Data::Db::TField* AField, Lmdgrid::PLMDString AErrMessage);
	void __fastcall DataSetChanged(void);
	void __fastcall CheckBrowseMode(void);
	void __fastcall UpdateScrollBar(void);
	void __fastcall UpdateLinkConfig(void);
	bool __fastcall IsSequenced(void);
	void __fastcall UpdateData(void);
	void __fastcall RecordChanged(Data::Db::TField* Field);
	void __fastcall FocusControl(Data::Db::TFieldRef Field);
	
protected:
	DYNAMIC void __fastcall TopLeftChanged(void);
	int __fastcall FieldWidthToColWidth(Lmdgrid::TLMDGridColumn* AColumn, int AWidth);
	int __fastcall ColWidthToFieldWidth(Lmdgrid::TLMDGridColumn* AColumn, int AWidth);
	void __fastcall ActiveChanged(void);
	void __fastcall CheckUnidirectional(Data::Db::TDataSource* ADataSource);
	void __fastcall RefreshColumns(void)/* overload */;
	void __fastcall RefreshColumns(bool AutoCreateComponents, Lmdgrid::TLMDGridColumnNameSetCallback ANameSetProc)/* overload */;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall GetAvailableColumnFieldNames(Lmdgrid::TLMDGridColumn* ACol, System::Classes::TStrings* AList);
	virtual bool __fastcall IsEOF(void);
	virtual void __fastcall MoveDataRow(int AFrom, int ATo);
	virtual void __fastcall ColumnAdding(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnAdded(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnDeleting(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnMoving(int AFrom, int ATo);
	virtual void __fastcall InternalColumnDataTypeChanged(Lmdgrid::TLMDGridColumn* ACol);
	virtual void __fastcall InternalDataLayoutChange(void);
	virtual void __fastcall InternalDataSourceSort(Lmdgrid::TLMDGridColumn* AColumn, Lmdgrid::TLMDGridSortKind Value, int &ACorrectIdx);
	virtual void __fastcall InternalDeleteDataRow(int ARow, int &CorrIndex);
	virtual void __fastcall InternalSetColumnFieldName(Lmdgrid::TLMDGridColumn* AColumn, const System::UnicodeString AValue, bool ABefore);
	virtual void __fastcall InternalSetColumnGrid(Lmdgrid::TLMDGridColumn* AColumn);
	virtual bool __fastcall InternalIsColumnDataBound(int ACol);
	virtual void __fastcall InternalSetDefaultColWidth(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall InternalSetDefaultColPos(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall InternalSetupScrollBarsStyle(void);
	virtual bool __fastcall CanStoreMoveRow(void);
	virtual bool __fastcall CanStoreMoveCol(void);
	virtual bool __fastcall CanStoreEdit(void);
	virtual bool __fastcall CanStoreInsert(void);
	virtual bool __fastcall CanStoreRemove(void);
	virtual bool __fastcall CanStoreRowEdit(void);
	virtual int __fastcall GetDataRowCount(void);
	virtual void __fastcall SetDataRowCount(const int Value);
	virtual void __fastcall InternalGetDataCell(int ACol, int ARow, System::PVariant Key, System::PVariant Value);
	virtual void __fastcall InternalSetDataCell(int ACol, int ARow, System::PVariant Key, System::PVariant Value, bool ABlockSort, /* out */ int &NewRow);
	virtual void __fastcall InternalEnterNewRecMode(int ADestIndex);
	virtual void __fastcall InternalExitNewRecMode(bool ACommit, /* out */ int &ACurrentIndex);
	virtual void __fastcall InternalEnterRowEditMode(void);
	virtual void __fastcall InternalExitRowEditMode(bool ACommit, /* out */ int &ACurrentIndex);
	virtual void __fastcall InternalAfterSyncGridStore(void);
	virtual void __fastcall InternalUpdateStore(void);
	virtual bool __fastcall InternalDataSourceCanSort(void);
	virtual void __fastcall InternalRestrictDataPoint(int &ACol, int &ARow);
	virtual bool __fastcall InternalMoveVert(int ANewCurrent, int ANewTop);
	virtual void __fastcall InternalEndUpdateLow(void);
	virtual bool __fastcall GetAutoColumnsMode(void);
	virtual void __fastcall SetAutoColumnsMode(bool AMode);
	virtual bool __fastcall CanFillColumnsFromStore(void);
	virtual void __fastcall FillColumnsFromStore(Lmdgrid::TLMDGridColumnNameSetCallback ANameSetProc);
	virtual System::Types::TRect __fastcall GetSelRect(void);
	virtual bool __fastcall IsSelectionValid(void);
	virtual void __fastcall CancelSelectionLow(void);
	void __fastcall CancelSelAncLow(void);
	virtual Data::Db::TField* __fastcall GetColumnField(Lmdgrid::TLMDGridColumn* AColumn);
	virtual Data::Db::TField* __fastcall GetColumnFieldKey(Lmdgrid::TLMDGridColumn* AColumn);
	virtual Lmdtypes::TLMDString __fastcall GetDefaultColumnCaption(Lmdgrid::TLMDGridColumn* AColumn);
	virtual System::Classes::TAlignment __fastcall GetDefaultColumnAlignment(Lmdgrid::TLMDGridColumn* AColumn);
	virtual bool __fastcall GetDefaultColumnVisible(Lmdgrid::TLMDGridColumn* AColumn);
	virtual bool __fastcall GetDefaultColumnReadOnly(Lmdgrid::TLMDGridColumn* AColumn);
	virtual int __fastcall GetDefaultColumnWidth(Lmdgrid::TLMDGridColumn* AColumn);
	virtual void __fastcall PageSizeChanged(void);
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TLMDDataSetSortEvent OnDataSetSort = {read=FGridSortEvent, write=FGridSortEvent};
	
public:
	__fastcall virtual TLMDCustomDBGrid(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomDBGrid(void);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomDBGrid(HWND ParentWindow) : Lmdgrid::TLMDCustomGrid(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDDBGrid : public TLMDCustomDBGrid
{
	typedef TLMDCustomDBGrid inherited;
	
__published:
	__property DataSource;
	__property Columns;
	__property Style;
	__property DefaultColWidth = {default=64};
	__property DefaultRowHeight = {default=18};
	__property ScrollBarsStyle = {default=3};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Options;
	__property OnBeforeRowDelete;
	__property OnPaintEmptyBanner;
	__property OnGetCellColor;
	__property OnDrawDataCell;
	__property OnDrawHeaderCell;
	__property OnDrawIndicator;
	__property OnDataSetSort;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentDoubleBuffered = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnGesture;
	__property Touch;
	__property OnMouseActivate;
public:
	/* TLMDCustomDBGrid.Create */ inline __fastcall virtual TLMDDBGrid(System::Classes::TComponent* AOwner) : TLMDCustomDBGrid(AOwner) { }
	/* TLMDCustomDBGrid.Destroy */ inline __fastcall virtual ~TLMDDBGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBGrid(HWND ParentWindow) : TLMDCustomDBGrid(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbgrid */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBGRID)
using namespace Lmddbgrid;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbgridHPP
