// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwdbigrd.pas' rev: 6.00

#ifndef WwdbigrdHPP
#define WwdbigrdHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Mask.hpp>	// Pascal unit
#include <wwpaintoptions.hpp>	// Pascal unit
#include <wwdbdatetimepicker.hpp>	// Pascal unit
#include <wwriched.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <wwSystem.hpp>	// Pascal unit
#include <Wwlocate.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <Wwtable.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdbigrd
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwEditControlOption { ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableCustomControls, ecoDisableDateTimePicker, ecoDisableEditorIfReadOnly };
#pragma option pop

typedef Set<TwwEditControlOption, ecoCheckboxSingleClick, ecoDisableEditorIfReadOnly>  TwwEditControlOptions;

class DELPHICLASS TwwGridHintWindow;
class PASCALIMPLEMENTATION TwwGridHintWindow : public Controls::THintWindow 
{
	typedef Controls::THintWindow inherited;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	Db::TField* Field;
	bool WordWrap;
	Classes::TAlignment Alignment;
public:
	#pragma option push -w-inl
	/* THintWindow.Create */ inline __fastcall virtual TwwGridHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TwwGridHintWindow(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwGridHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	#pragma option pop
	
};


#pragma pack(push, 4)
struct TwwTitleImageAttributes
{
	int ImageIndex;
	Classes::TAlignment Alignment;
	int Margin;
	bool IsGroupHeader;
} ;
#pragma pack(pop)

typedef void __fastcall (__closure *TTitleButtonClickEvent)(System::TObject* Sender, AnsiString AFieldName);

typedef void __fastcall (__closure *TCalcCellColorsEvent)(System::TObject* Sender, Db::TField* Field, Grids::TGridDrawState State, bool Highlight, Graphics::TFont* AFont, Graphics::TBrush* ABrush);

typedef void __fastcall (__closure *TCalcTitleAttributesEvent)(System::TObject* Sender, AnsiString AFieldName, Graphics::TFont* AFont, Graphics::TBrush* ABrush, Classes::TAlignment &ATitleAlignment);

typedef void __fastcall (__closure *TwwDrawTitleCellEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, Db::TField* Field, const Types::TRect &Rect, bool &DefaultDrawing);

typedef void __fastcall (__closure *TwwDrawGroupHeaderCellEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, AnsiString GroupHeaderName, const Types::TRect &Rect, bool &DefaultDrawing);

typedef void __fastcall (__closure *TwwCalcTitleImageEvent)(System::TObject* Sender, Db::TField* Field, TwwTitleImageAttributes &TitleImageAttributes);

typedef void __fastcall (__closure *TDrawFooterCellEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &FooterCellRect, Db::TField* Field, AnsiString FooterText, bool &DefaultDrawing);

typedef void __fastcall (__closure *TColWidthChangedEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TAllowColResizeEvent)(System::TObject* Sender, int Column, bool &Accept);

typedef void __fastcall (__closure *TwwLeftColChangedEvent)(System::TObject* Sender, int NewLeftCol);

typedef void __fastcall (__closure *TwwCreateGridHintWindowEvent)(System::TObject* Sender, TwwGridHintWindow* HintWindow, Db::TField* AField, const Types::TRect &R, bool &WordWrap, int &MaxWidth, int &MaxHeight, bool &DoDefault);

#pragma option push -b-
enum TwwMultiSelectOption { msoAutoUnselect, msoShiftSelect };
#pragma option pop

typedef Set<TwwMultiSelectOption, msoAutoUnselect, msoShiftSelect>  TwwMultiSelectOptions;

typedef void __fastcall (__closure *TwwFieldChangedEvent)(System::TObject* Sender, Db::TField* Field);

class DELPHICLASS TwwGridDataLink;
class DELPHICLASS TwwCustomDBGrid;
class DELPHICLASS TwwGridLineColors;
class PASCALIMPLEMENTATION TwwGridLineColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FDataColor;
	Graphics::TColor FHighlightColor;
	Graphics::TColor FShadowColor;
	Graphics::TColor FFixedColor;
	
__published:
	__property Graphics::TColor DataColor = {read=FDataColor, write=FDataColor, default=12632256};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, default=-16777196};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, default=-16777200};
	__property Graphics::TColor FixedColor = {read=FFixedColor, write=FFixedColor, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwGridLineColors(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwGridLineColors(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwDBGridOption { dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgShowFooter, dgFooter3DCells, dgNoLimitColSize, dgTrailingEllipsis, dgShowCellHint, dgTabExitsOnLastCol, dgFixedResizable, dgFixedEditable, dgProportionalColResize, dgRowResize, dgRowLinesDisableFixed, dgColLinesDisableFixed, dgFixedProportionalResize, dgHideBottomDataLine, dgDblClickColSizing };
#pragma option pop

typedef Set<TwwDBGridOption, dgEditing, dgDblClickColSizing>  TwwDBGridOptions;

#pragma option push -b-
enum TwwDBGridKeyOption { dgEnterToTab, dgAllowDelete, dgAllowInsert };
#pragma option pop

typedef Set<TwwDBGridKeyOption, dgEnterToTab, dgAllowInsert>  TwwDBGridKeyOptions;

typedef void __fastcall (__closure *TwwDrawDataCellEvent)(System::TObject* Sender, const Types::TRect &Rect, Db::TField* Field, Grids::TGridDrawState State);

#pragma option push -b-
enum TIndicatorColorType { icBlack, icYellow };
#pragma option pop

class DELPHICLASS TwwIButton;
class PASCALIMPLEMENTATION TwwIButton : public Buttons::TSpeedButton 
{
	typedef Buttons::TSpeedButton inherited;
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
public:
	#pragma option push -w-inl
	/* TSpeedButton.Create */ inline __fastcall virtual TwwIButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TwwIButton(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TwwGridURLOpenEvent)(System::TObject* Sender, AnsiString &URLLink, Db::TField* Field, bool &UseDefault);

class DELPHICLASS TwwColumn;
class PASCALIMPLEMENTATION TwwColumn : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FFieldName;
	TwwCustomDBGrid* Grid;
	AnsiString FFooterValue;
	AnsiString FGroupName;
	bool FDisableSizing;
	bool __fastcall GetReadOnly(void);
	AnsiString __fastcall GetDisplayLabel();
	int __fastcall GetDisplayWidth(void);
	AnsiString __fastcall GetGroupName();
	void __fastcall SetReadOnly(bool val);
	void __fastcall SetDisplayLabel(AnsiString val);
	void __fastcall SetDisplayWidth(int val);
	void __fastcall SetFooterValue(AnsiString val);
	void __fastcall SetGroupName(AnsiString val);
	
public:
	Byte *ColumnFlags;
	__property AnsiString FieldName = {read=FFieldName};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
	__property AnsiString DisplayLabel = {read=GetDisplayLabel, write=SetDisplayLabel};
	__property int DisplayWidth = {read=GetDisplayWidth, write=SetDisplayWidth, nodefault};
	__property AnsiString FooterValue = {read=FFooterValue, write=SetFooterValue};
	__property AnsiString GroupName = {read=GetGroupName, write=SetGroupName};
	__property bool DisableSizing = {read=FDisableSizing, write=FDisableSizing, nodefault};
	__fastcall TwwColumn(Classes::TComponent* AOwner, AnsiString AFieldName);
	__fastcall virtual ~TwwColumn(void);
};


#pragma option push -b-
enum TwwPadColumnStyle { pcsPlain, pcsPadHeader, pcsPadHeaderAndData };
#pragma option pop

#pragma option push -b-
enum TwwGridLineStyle { glsSingle, gls3D, glsDynamic };
#pragma option pop

class DELPHICLASS TwwCustomDrawGridCellInfo;
typedef void __fastcall (__closure *TwwCustomDrawCellEvent)(TwwCustomDBGrid* Sender, TwwCustomDrawGridCellInfo* DrawCellInfo);

class PASCALIMPLEMENTATION TwwCustomDBGrid : public Grids::TCustomGrid 
{
	typedef Grids::TCustomGrid inherited;
	
private:
	bool FShowHorzScrollBar;
	Classes::TNotifyEvent FOnBeforePaint;
	Classes::TStrings* FSelected;
	TwwGridLineColors* FLineColors;
	Graphics::TFont* FTitleFont;
	Graphics::TColor FTitleColor;
	Graphics::TColor FFooterColor;
	Graphics::TColor FFooterCellColor;
	int FFooterHeight;
	bool FReadOnly;
	bool FUserChange;
	int FUpdatingColWidths;
	TwwDBGridOptions FOptions;
	TwwDBGridKeyOptions FKeyOptions;
	Byte FTitleOffset;
	Byte FUpdateLock;
	bool FInColExit;
	bool FDefaultDrawing;
	bool FSelfChangingTitleFont;
	int FSelRow;
	TwwGridDataLink* FDataLink;
	Classes::TNotifyEvent FOnColEnter;
	Classes::TNotifyEvent FOnColExit;
	TwwDrawDataCellEvent FOnDrawDataCell;
	TCalcCellColorsEvent FOnCalcCellColors;
	TCalcTitleAttributesEvent FOnCalcTitleAttributes;
	TwwDrawTitleCellEvent FOnDrawTitleCell;
	TwwDrawGroupHeaderCellEvent FOnDrawGroupHeaderCell;
	TwwCalcTitleImageEvent FOnCalcTitleImage;
	TTitleButtonClickEvent FOnTitleButtonClick;
	Wwdbedit::TwwValidateEvent FOnCheckValue;
	Classes::TNotifyEvent FOnTopRowChanged;
	Classes::TNotifyEvent FOnRowChanged;
	Classes::TNotifyEvent FOnCellChanged;
	TwwLeftColChangedEvent FOnLeftColChanged;
	AnsiString FEditText;
	TIndicatorColorType FIndicatorColor;
	Graphics::TColor FIndicatorIconColor;
	Classes::TAlignment FTitleAlignment;
	int FRowHeightPercent;
	int FTitleLines;
	bool FShowVertScrollBar;
	Grids::TMovedEvent FOnColumnMoved;
	TColWidthChangedEvent FOnColWidthChanged;
	TAllowColResizeEvent FOnAllowColResize;
	bool FTitleButtons;
	bool FEditCalculated;
	bool FUseTFields;
	int FIndicatorWidth;
	TwwIButton* FIndicatorButton;
	Controls::TImageList* FImageList;
	Controls::TImageList* FTitleImageList;
	TDrawFooterCellEvent FOnDrawFooterCell;
	TwwFieldChangedEvent FOnFieldChanged;
	Classes::TNotifyEvent FOnUpdateFooter;
	TwwCreateGridHintWindowEvent FOnCreateHintWindow;
	TwwGridURLOpenEvent FOnURLOpen;
	int FSavePrevGridWidth;
	bool FHideAllLines;
	Controls::TCursor FSavedCursor;
	int URLLinkActiveRow;
	int URLLinkActiveCol;
	bool InUpdateRowCount;
	int FCalcCellRow;
	int FCalcCellCol;
	bool isWhiteBackground;
	bool isDrawFocusRect;
	bool SkipLineDrawing;
	int TitleClickColumn;
	int TitleClickRow;
	bool TitleClickGroupTitle;
	bool MouseOverGroupTitle;
	TwwMultiSelectOptions FMultiSelectOptions;
	bool DisableCellChangedEvent;
	Classes::TList* ColItems;
	bool UseDragCanvas;
	Graphics::TBitmap* CaptureTitleBitmap;
	int FDragVertOffset;
	bool SkipTitleButtonClick;
	Classes::TStrings* FControlType;
	bool FControlInfoInDataset;
	Classes::TStrings* FPictureMasks;
	bool FPictureMaskFromDataSet;
	bool CallColEnter;
	void *LastBookmark;
	void *LastMasterBookmark;
	int TempLastCol;
	bool ShouldUpdateFooter;
	TwwColumn* DummyColumn;
	int lastMouseX;
	int lastMouseY;
	int titleLastMouseX;
	int titleLastMouseY;
	Extctrls::TTimer* HintTimer;
	int HintTimerCount;
	int FUpdateCount;
	TwwPadColumnStyle FPadColumnStyle;
	Graphics::TCanvas* FPaintCanvas;
	Graphics::TBitmap* FPaintBitmap;
	TwwEditControlOptions FEditControlOptions;
	Wwpaintoptions::TwwGridPaintOptions* FPaintOptions;
	#pragma pack(push, 1)
	Types::TRect UpdateRect;
	#pragma pack(pop)
	
	bool ChangedBrushColor;
	bool AlternatingEven;
	int FSizingIndex;
	int FPriorSizingWidth;
	int FRowOffset;
	TwwGridLineStyle FLineStyle;
	bool ClickedOnGroupName;
	bool ClickedOnGroupChild;
	bool FCompareBookmarksAltMethod;
	TwwCustomDrawCellEvent FOnBeforeDrawCell;
	TwwCustomDrawCellEvent FOnAfterDrawCell;
	HIDESBASE Grids::TGridCoord __fastcall CalcCoordFromPoint(int X, int Y, const Grids::TGridDrawInfo &DrawInfo);
	void __fastcall SetRowOffset(int value);
	void __fastcall SetUseTFields(bool Val);
	Classes::TComponent* __fastcall GetPictureControl(void);
	void __fastcall HintTimerEvent(System::TObject* Sender);
	void __fastcall MouseLoop_DragColumn(int HitTest, int X, int Y);
	bool __fastcall IsScrollBarVisible(void);
	bool __fastcall AcquireFocus(void);
	void __fastcall EditingChanged(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	int __fastcall GetFieldCount(void);
	Db::TField* __fastcall GetFields(int Index);
	Db::TField* __fastcall GetSelectedField(void);
	int __fastcall GetSelectedIndex(void);
	void __fastcall RecordChanged(Db::TField* Field);
	void __fastcall FieldChanged(Db::TField* Field);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	HIDESBASE void __fastcall SetOptions(TwwDBGridOptions Value);
	void __fastcall SetSelectedField(Db::TField* Value);
	void __fastcall SetSelectedIndex(int Value);
	void __fastcall SetTitleFont(Graphics::TFont* Value);
	void __fastcall SetIndicatorIconColor(Graphics::TColor Value);
	void __fastcall SetTitleAlignment(Classes::TAlignment sel);
	void __fastcall SetTitleLines(int sel);
	void __fastcall SetRowHeightPercent(int sel);
	void __fastcall SetShowVertScrollBar(bool val);
	void __fastcall SetTitleButtons(bool val);
	bool __fastcall GetShowHorzScrollBar(void);
	void __fastcall SetShowHorzScrollBar(bool val);
	Classes::TStrings* __fastcall GetSelectedFields(void);
	void __fastcall SetSelectedFields(Classes::TStrings* sel);
	int __fastcall GetColWidthsPixels(int Index);
	void __fastcall SetColWidthsPixels(int Index, int Value);
	void __fastcall SetIndicatorWidth(int val);
	void __fastcall TitleFontChanged(System::TObject* Sender);
	void __fastcall UpdateData(void);
	void __fastcall UpdateActive(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	TwwColumn* __fastcall GetColumn(int Index);
	void __fastcall SetFooterColor(Graphics::TColor sel);
	void __fastcall SetFooterCellColor(Graphics::TColor sel);
	void __fastcall SetFooterHeight(int val);
	Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall SetPictureMasks(Classes::TStrings* val);
	void __fastcall SetControlType(Classes::TStrings* val);
	void __fastcall SetUpdateState(bool Updating);
	void __fastcall InheritedPaint(void);
	void __fastcall SetIndicatorColor(TIndicatorColorType Value);
	int __fastcall GetCalcCellRow(void);
	HIDESBASE MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE Grids::TGridCoord __fastcall CalcMaxTopLeft(const Grids::TGridCoord &Coord, const Grids::TGridDrawInfo &DrawInfo);
	
protected:
	Classes::TList* FCacheColInfo;
	int FTopRecord;
	Byte FIndicatorOffset;
	Wwriched::TwwDBRichEdit* TempRichEdit;
	bool FUpdateFields;
	bool FAcquireFocus;
	bool SuppressShowEditor;
	bool ShiftSelectMode;
	void *ShiftSelectBookmark;
	AnsiString dummy1;
	AnsiString dummy2;
	int TitleTextOffset;
	bool FieldMappedText;
	bool URLLinkActive;
	Controls::THintWindow* HintWindow;
	Word *OrigColWidths;
	int OrigColWidthsCount;
	TwwCustomDrawGridCellInfo* DrawCellInfo;
	bool SkipErase;
	Controls::TWinControl* CurrentCustomEdit;
	Wwdbdatetimepicker::TwwDBCustomDateTimePicker* FDateTimePicker;
	bool FFocused;
	virtual bool __fastcall UseAlternateBuffering(void);
	virtual int __fastcall GetGridDataBottom(const Grids::TGridDrawInfo &DrawInfo);
	void __fastcall ResetTitleClick(void);
	void __fastcall UpdateLeftCol(int ACol);
	HIDESBASE virtual void __fastcall ShowEditor(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall MoveCol(int ACol);
	virtual void __fastcall DoCreateHintWindow(TwwGridHintWindow* HintWindow, Db::TField* AField, const Types::TRect &R, bool &WordWrap, int &MaxWidth, int &MaxHeight, bool &DoDefault);
	virtual bool __fastcall IsProportionalColumns(void);
	virtual void __fastcall DoURLOpen(AnsiString &URLLink, Db::TField* Field, bool &UseDefault);
	bool __fastcall IsDropDownGridFocused(void);
	bool __fastcall IsDropDownGridShowing(void);
	virtual void __fastcall FillWithAlternatingRowBitmap(const Types::TRect &TempRect);
	virtual void __fastcall LayoutChanged(void);
	DYNAMIC void __fastcall CalcRowHeight(void);
	bool __fastcall RecordCountIsValid(void);
	DYNAMIC bool __fastcall AllowCancelOnExit(void);
	DYNAMIC bool __fastcall CanEditAcceptKey(char Key);
	DYNAMIC bool __fastcall CanEditModify(void);
	DYNAMIC int __fastcall GetEditLimit(void);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall ColEnter(void);
	DYNAMIC void __fastcall ColExit(void);
	virtual void __fastcall Scroll(int Distance);
	DYNAMIC void __fastcall ColWidthsChanged(void);
	virtual bool __fastcall HighlightCell(int DataCol, int DataRow, const AnsiString Value, Grids::TGridDrawState AState);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	DYNAMIC AnsiString __fastcall GetEditMask(int ACol, int ARow);
	DYNAMIC AnsiString __fastcall GetEditText(int ACol, int ARow);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	Db::TField* __fastcall GetColField(int ACol);
	DYNAMIC AnsiString __fastcall GetFieldValue(int ACol);
	virtual void __fastcall DefineFieldMap(void);
	DYNAMIC void __fastcall DrawDataCell(const Types::TRect &Rect, Db::TField* Field, Grids::TGridDrawState State);
	virtual void __fastcall ProportionalColWidths(void);
	virtual void __fastcall SetColumnAttributes(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall LinkActive(bool Value);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall TimedScroll(Grids::TGridScrollDirection Direction);
	virtual void __fastcall CreateWnd(void);
	virtual bool __fastcall IsWWControl(int ACol, int ARow);
	virtual void __fastcall InvalidateTitle(void);
	__property bool DefaultDrawing = {read=FDefaultDrawing, write=FDefaultDrawing, default=1};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property ParentColor  = {default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property Graphics::TColor TitleColor = {read=FTitleColor, write=FTitleColor, default=-16777201};
	__property Graphics::TColor FooterColor = {read=FFooterColor, write=SetFooterColor, default=-16777201};
	__property Graphics::TColor FooterCellColor = {read=FFooterCellColor, write=SetFooterCellColor, default=-16777201};
	__property int FooterHeight = {read=FFooterHeight, write=SetFooterHeight, default=0};
	__property Graphics::TFont* TitleFont = {read=FTitleFont, write=SetTitleFont};
	__property Classes::TNotifyEvent OnColEnter = {read=FOnColEnter, write=FOnColEnter};
	__property Classes::TNotifyEvent OnColExit = {read=FOnColExit, write=FOnColExit};
	__property TwwDrawDataCellEvent OnDrawDataCell = {read=FOnDrawDataCell, write=FOnDrawDataCell};
	virtual void __fastcall DoTitleButtonClick(AnsiString AFieldName);
	virtual void __fastcall DoDrawTitleCell(Graphics::TCanvas* ACanvas, Db::TField* Field, const Types::TRect &ARect, bool &DefaultDrawing);
	virtual void __fastcall DoDrawGroupHeaderCell(Graphics::TCanvas* ACanvas, AnsiString GroupHeaderName, const Types::TRect &ARect, bool &DefaultDrawing);
	virtual void __fastcall DoCalcTitleImage(System::TObject* Sender, Db::TField* Field, TwwTitleImageAttributes &TitleImageAttributes);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	bool __fastcall UseRightToLeftAlignmentForField(const Db::TField* AField, Classes::TAlignment Alignment);
	void __fastcall UpdateScrollBar(void);
	bool __fastcall IsValidCell(int ACol, int ARow);
	int __fastcall DbCol(int col);
	int __fastcall DbRow(int row);
	void __fastcall Draw3DLines(const Types::TRect &ARect, int ACol, int ARow, Grids::TGridDrawState AState);
	virtual Graphics::TColor __fastcall CellColor(int ACol, int ARow);
	virtual void __fastcall DrawCheckBox(const Types::TRect &ARect, int ACol, int ARow, bool val);
	void __fastcall DrawCheckBox_Checkmark(const Types::TRect &ARect, int ACol, int ARow, bool val);
	virtual void __fastcall RefreshBookmarkList(void);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual void __fastcall HideControls(void);
	__property TColWidthChangedEvent OnColWidthChanged = {read=FOnColWidthChanged, write=FOnColWidthChanged};
	__property TAllowColResizeEvent OnAllowColResize = {read=FOnAllowColResize, write=FOnAllowColResize};
	__property Grids::TMovedEvent OnColumnMoved = {read=FOnColumnMoved, write=FOnColumnMoved};
	virtual void __fastcall UnselectAll(void);
	bool __fastcall IsSelectedCheckbox(int ACol);
	virtual void __fastcall DataChanged(void);
	DYNAMIC bool __fastcall IsSelectedRow(int DataRow);
	virtual void __fastcall DoTopRowChanged(void);
	virtual void __fastcall DoRowChanged(void);
	virtual void __fastcall DoCellChanged(void);
	virtual void __fastcall DoCheckRowChanged(void);
	__property int IndicatorButtonWidth = {read=FIndicatorWidth, write=SetIndicatorWidth, nodefault};
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	DYNAMIC void __fastcall TopLeftChanged(void);
	virtual Types::TRect __fastcall GetClientRect();
	virtual void __fastcall Paint(void);
	Classes::TStrings* __fastcall GetControlType(void);
	virtual void __fastcall GetControlInfo(AnsiString AFieldName, AnsiString &AControlType, AnsiString &AParameters);
	virtual void __fastcall DoFieldChanged(Db::TField* Field);
	virtual void __fastcall DoUpdateFooter(void);
	virtual Types::TRect __fastcall GetFooterRect();
	virtual void __fastcall CheckFooterUpdate(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int AX, int AY);
	virtual void __fastcall FreeHintWindow(void);
	virtual Controls::THintWindow* __fastcall CreateHintWindow(Db::TField* AField);
	virtual void __fastcall ValidationErrorUsingMask(Db::TField* Field);
	void __fastcall ChangeOrientation(bool RightToLeftOrientation);
	virtual void __fastcall DrawLines(void);
	virtual void __fastcall PaintClickedTitleButton(void);
	bool __fastcall AdjustBoundsRect(Controls::TWinControl* ACurrentCustomEdit);
	virtual void __fastcall CalcSizingState(int X, int Y, Grids::TGridState &State, int &Index, int &SizingPos, int &SizingOfs, Grids::TGridDrawInfo &FixedInfo);
	virtual void __fastcall InitCacheColInfo(void);
	bool __fastcall UseThemesInTitle(void);
	
public:
	bool AlternatePaintBuffering;
	bool SkipHideControls;
	bool SkipDataChange;
	bool AlwaysShowControls;
	int MinRowHeightPercent;
	__property int RowOffset = {read=FRowOffset, write=SetRowOffset, nodefault};
	__property Byte TitleOffset = {read=FTitleOffset, nodefault};
	__property bool CompareBookmarksAltMethod = {read=FCompareBookmarksAltMethod, write=FCompareBookmarksAltMethod, default=0};
	virtual void __fastcall FillWithBlendBitmap(const Types::TRect &TempRect, int CurRelRow, Graphics::TColor FillColor = (Graphics::TColor)(0x1fffffff));
	virtual void __fastcall FillWithFixedBitmap(const Types::TRect &TempRect, int CurRelRow, Graphics::TColor FillColor = (Graphics::TColor)(0x1fffffff));
	void __fastcall UpdateCustomEdit(void);
	void __fastcall ResetProportionalWidths(void);
	bool __fastcall ShouldShowCustomControls(void);
	virtual bool __fastcall CanEditGrid(void);
	void __fastcall ClearURLPaint(void);
	Controls::TWinControl* __fastcall ActiveExpandButton(void);
	HIDESBASE virtual void __fastcall CalcDrawInfo(Grids::TGridDrawInfo &DrawInfo);
	bool __fastcall HasFocus(void);
	bool __fastcall IsActiveRowAlternatingColor(void);
	void __fastcall CollapseChildGrid(void);
	void __fastcall AddField(AnsiString FieldName, int Position = 0xffffffff, bool Redraw = true);
	void __fastcall RemoveField(AnsiString FieldName, bool Redraw = true);
	bool __fastcall HaveAnyRowLines(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	virtual void __fastcall GetURLLink(AnsiString Value, AnsiString &URLDisplayString, AnsiString &URLLinkAddress);
	void __fastcall InvalidateCurrentRow(void);
	void __fastcall InvalidateFooter(void);
	virtual void __fastcall FlushChanges(void);
	void __fastcall UpdateRowCount(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	void __fastcall SizeLastColumn(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool Repaint = false);
	bool __fastcall IsCustomEditCell(int col, int row, Controls::TWinControl* &customEdit);
	virtual Types::TRect __fastcall TitleCellRect(int ACol, int ARow);
	virtual Types::TRect __fastcall GroupNameCellRect(int ACol, int ARow, int &StartCol, int &EndCol, bool VisibleOnly = true);
	virtual Types::TRect __fastcall DragTitleCellRect(int ACol, int x, int y);
	HIDESBASE virtual Types::TRect __fastcall CellRect(int ACol, int ARow);
	void __fastcall RestoreRowHeights(void);
	virtual void __fastcall ApplySelected(void);
	void __fastcall PaintActiveRowBackground(Graphics::TCanvas* ACanvas, const Types::TRect &ARect);
	__fastcall virtual TwwCustomDBGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwCustomDBGrid(void);
	bool __fastcall IsCheckBox(int col, int row, AnsiString &checkboxon, AnsiString &checkboxoff);
	virtual bool __fastcall IsMemoField(int Acol, int Arow);
	DYNAMIC bool __fastcall IsSelected(void);
	bool __fastcall AllowPerfectFit(void);
	bool __fastcall DoPerfectFit(void);
	bool __fastcall DoShrinkToFit(void);
	virtual void __fastcall SelectRecord(void);
	virtual void __fastcall UnselectRecord(void);
	void __fastcall SetPictureMask(AnsiString FieldName, AnsiString Mask);
	void __fastcall SetPictureAutoFill(AnsiString FieldName, bool AutoFill);
	void __fastcall ClearLastBookmarks(void);
	AnsiString __fastcall FieldName(int Acol);
	Graphics::TColor __fastcall GetHighlightColor(void);
	void __fastcall DefaultDrawDataCell(const Types::TRect &Rect, Db::TField* Field, Grids::TGridDrawState State);
	virtual void __fastcall DoCalcTitleAttributes(AnsiString AFieldName, Graphics::TFont* AFont, Graphics::TBrush* ABrush, Classes::TAlignment &FTitleAlignment);
	virtual void __fastcall DoCalcCellColors(Db::TField* Field, Grids::TGridDrawState State, bool highlight, Graphics::TFont* AFont, Graphics::TBrush* ABrush);
	virtual void __fastcall DoCalcCellColorsDetect(Db::TField* Field, Grids::TGridDrawState State, bool highlight, Graphics::TFont* AFont, Graphics::TBrush* ABrush);
	int __fastcall XIndicatorOffset(void);
	HIDESBASE Controls::TWinControl* __fastcall GetComponent(AnsiString thisName);
	int __fastcall GetEffectiveFooterHeight(void);
	HIDESBASE Grids::TGridCoord __fastcall MouseCoord(int X, int Y);
	void __fastcall AutoSizeColumn(int ACol);
	bool __fastcall GetPriorRecordText(AnsiString AFieldname, AnsiString &AText);
	bool __fastcall GetNextRecordText(AnsiString AFieldname, AnsiString &AText);
	__property TwwGridDataLink* DataLink = {read=FDataLink};
	__property RowHeights ;
	__property int ColWidthsPixels[int Index] = {read=GetColWidthsPixels, write=SetColWidthsPixels};
	__property EditorMode ;
	__property int FieldCount = {read=GetFieldCount, nodefault};
	__property Db::TField* Fields[int Index] = {read=GetFields};
	__property Db::TField* SelectedField = {read=GetSelectedField, write=SetSelectedField};
	__property int SelectedIndex = {read=GetSelectedIndex, write=SetSelectedIndex, nodefault};
	__property TIndicatorColorType IndicatorColor = {read=FIndicatorColor, write=SetIndicatorColor, nodefault};
	__property Graphics::TColor IndicatorIconColor = {read=FIndicatorIconColor, write=SetIndicatorIconColor, default=0};
	__property TwwDBGridOptions Options = {read=FOptions, write=SetOptions, default=7421};
	__property TwwDBGridKeyOptions KeyOptions = {read=FKeyOptions, write=FKeyOptions, default=6};
	__property Classes::TAlignment TitleAlignment = {read=FTitleAlignment, write=SetTitleAlignment, nodefault};
	__property int TitleLines = {read=FTitleLines, write=SetTitleLines, nodefault};
	__property TCalcCellColorsEvent OnCalcCellColors = {read=FOnCalcCellColors, write=FOnCalcCellColors};
	__property TCalcTitleAttributesEvent OnCalcTitleAttributes = {read=FOnCalcTitleAttributes, write=FOnCalcTitleAttributes};
	__property TwwDrawTitleCellEvent OnDrawTitleCell = {read=FOnDrawTitleCell, write=FOnDrawTitleCell};
	__property TwwDrawGroupHeaderCellEvent OnDrawGroupHeaderCell = {read=FOnDrawGroupHeaderCell, write=FOnDrawGroupHeaderCell};
	__property TwwCalcTitleImageEvent OnCalcTitleImage = {read=FOnCalcTitleImage, write=FOnCalcTitleImage};
	__property TTitleButtonClickEvent OnTitleButtonClick = {read=FOnTitleButtonClick, write=FOnTitleButtonClick};
	__property int RowHeightPercent = {read=FRowHeightPercent, write=SetRowHeightPercent, default=100};
	__property bool ShowVertScrollBar = {read=FShowVertScrollBar, write=SetShowVertScrollBar, default=1};
	__property bool ShowHorzScrollBar = {read=GetShowHorzScrollBar, write=SetShowHorzScrollBar, nodefault};
	__property Wwdbedit::TwwValidateEvent OnCheckValue = {read=FOnCheckValue, write=FOnCheckValue};
	__property Classes::TNotifyEvent OnTopRowChanged = {read=FOnTopRowChanged, write=FOnTopRowChanged};
	__property Classes::TNotifyEvent OnRowChanged = {read=FOnRowChanged, write=FOnRowChanged};
	__property Classes::TNotifyEvent OnCellChanged = {read=FOnCellChanged, write=FOnCellChanged};
	__property TwwLeftColChangedEvent OnLeftColChanged = {read=FOnLeftColChanged, write=FOnLeftColChanged};
	__property TwwFieldChangedEvent OnFieldChanged = {read=FOnFieldChanged, write=FOnFieldChanged};
	__property Classes::TNotifyEvent OnUpdateFooter = {read=FOnUpdateFooter, write=FOnUpdateFooter};
	__property int CalcCellRow = {read=GetCalcCellRow, nodefault};
	__property int CalcCellCol = {read=FCalcCellCol, nodefault};
	__property bool TitleButtons = {read=FTitleButtons, write=SetTitleButtons, nodefault};
	__property bool EditCalculated = {read=FEditCalculated, write=FEditCalculated, default=0};
	__property TwwMultiSelectOptions MultiSelectOptions = {read=FMultiSelectOptions, write=FMultiSelectOptions, default=0};
	__property Classes::TStrings* Selected = {read=GetSelectedFields, write=SetSelectedFields};
	__property bool UseTFields = {read=FUseTFields, write=SetUseTFields, default=1};
	__property TwwIButton* IndicatorButton = {read=FIndicatorButton, write=FIndicatorButton, stored=false};
	__property Controls::TImageList* ImageList = {read=FImageList, write=FImageList};
	__property Controls::TImageList* TitleImageList = {read=FTitleImageList, write=FTitleImageList};
	__property TwwGridLineColors* LineColors = {read=FLineColors, write=FLineColors};
	__property TwwColumn* Columns[int Index] = {read=GetColumn};
	TwwColumn* __fastcall ColumnByName(AnsiString Index);
	__property TDrawFooterCellEvent OnDrawFooterCell = {read=FOnDrawFooterCell, write=FOnDrawFooterCell};
	__property TwwCreateGridHintWindowEvent OnCreateHintWindow = {read=FOnCreateHintWindow, write=FOnCreateHintWindow};
	__property Classes::TNotifyEvent OnBeforePaint = {read=FOnBeforePaint, write=FOnBeforePaint};
	__property TwwGridURLOpenEvent OnURLOpen = {read=FOnURLOpen, write=FOnURLOpen};
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property int DragVertOffset = {read=FDragVertOffset, write=FDragVertOffset, default=15};
	__property bool ControlInfoInDataset = {read=FControlInfoInDataset, write=FControlInfoInDataset, default=1};
	__property Classes::TStrings* ControlType = {read=FControlType, write=SetControlType};
	__property bool PictureMaskFromDataSet = {read=FPictureMaskFromDataSet, write=FPictureMaskFromDataSet, default=1};
	__property Classes::TStrings* PictureMasks = {read=FPictureMasks, write=SetPictureMasks};
	__property LeftCol ;
	__property TwwPadColumnStyle PadColumnStyle = {read=FPadColumnStyle, write=FPadColumnStyle, default=2};
	__property TwwEditControlOptions EditControlOptions = {read=FEditControlOptions, write=FEditControlOptions, default=2};
	__property Wwpaintoptions::TwwGridPaintOptions* PaintOptions = {read=FPaintOptions, write=FPaintOptions};
	__property TwwGridLineStyle LineStyle = {read=FLineStyle, write=FLineStyle, default=2};
	__property bool HideAllLines = {read=FHideAllLines, write=FHideAllLines, default=0};
	__property TwwCustomDrawCellEvent OnBeforeDrawCell = {read=FOnBeforeDrawCell, write=FOnBeforeDrawCell};
	__property TwwCustomDrawCellEvent OnAfterDrawCell = {read=FOnAfterDrawCell, write=FOnAfterDrawCell};
	__property VisibleRowCount ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomDBGrid(HWND ParentWindow) : Grids::TCustomGrid(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwGridDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TwwCustomDBGrid* FGrid;
	int FFieldCount;
	int FFieldMapSize;
	bool FModified;
	bool FInUpdateData;
	void *FFieldMap;
	bool __fastcall GetDefaultFields(void);
	Db::TField* __fastcall GetFields(int I);
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall FocusControl(Db::TFieldRef Field);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	
public:
	__fastcall TwwGridDataLink(TwwCustomDBGrid* AGrid);
	__fastcall virtual ~TwwGridDataLink(void);
	bool __fastcall AddMapping(const AnsiString FieldName);
	void __fastcall ClearMapping(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property bool DefaultFields = {read=GetDefaultFields, nodefault};
	__property int FieldCount = {read=FFieldCount, nodefault};
	__property Db::TField* Fields[int I] = {read=GetFields};
	__property bool isFieldModified = {read=FModified, nodefault};
};


class PASCALIMPLEMENTATION TwwCustomDrawGridCellInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	#pragma pack(push, 1)
	Types::TRect Rect;
	#pragma pack(pop)
	
	Db::TField* Field;
	Grids::TGridDrawState State;
	int DataCol;
	int DataRow;
	bool DefaultDrawBackground;
	bool DefaultDrawHorzTopLine;
	bool DefaultDrawHorzBottomLine;
	bool DefaultDrawContents;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwCustomDrawGridCellInfo(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TwwCustomDrawGridCellInfo(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwBitmapSizeType { bsOriginalSize, bsStretchToFit, bsFitHeight, bsFitWidth };
#pragma option pop

class DELPHICLASS TwwInplaceEdit;
class PASCALIMPLEMENTATION TwwInplaceEdit : public Grids::TInplaceEdit 
{
	typedef Grids::TInplaceEdit inherited;
	
private:
	Wwdbedit::TwwDBPicture* FwwPicture;
	bool FWordWrap;
	TwwCustomDBGrid* ParentGrid;
	bool FUsePictureMask;
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall BoundsChanged(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	void __fastcall SetWordWrap(bool val);
	virtual void __fastcall UpdateContents(void);
	
public:
	__fastcall virtual TwwInplaceEdit(Classes::TComponent* AOwner, int dummy);
	__fastcall virtual ~TwwInplaceEdit(void);
	bool __fastcall IsValidPictureValue(AnsiString s);
	bool __fastcall HavePictureMask(void);
	__property Wwdbedit::TwwDBPicture* Picture = {read=FwwPicture, write=FwwPicture};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property Color  = {default=-16777211};
	__property Font ;
public:
	#pragma option push -w-inl
	/* TInplaceEdit.Create */ inline __fastcall virtual TwwInplaceEdit(Classes::TComponent* AOwner) : Grids::TInplaceEdit(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwInplaceEdit(HWND ParentWindow) : Grids::TInplaceEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwCacheColInfoItem;
class PASCALIMPLEMENTATION TwwCacheColInfoItem : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Controls::TWinControl* CustomControl;
	AnsiString ControlType;
	AnsiString ControlData;
	bool AlwaysPaints;
	bool IsWhiteBackground;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwCacheColInfoItem(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TwwCacheColInfoItem(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TwwUpdateSelected { sptUpdateField, sptUpdateWidth, sptUpdateLabel, sptUpdateReadOnly, sptUpdateGroup };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwdbigrd)
extern PACKAGE void __fastcall UpdateSelectedProp(Classes::TStrings* Selected, AnsiString FieldName, AnsiString val, TwwUpdateSelected SelectedProperty, int Index = 0xffffffff);
extern PACKAGE AnsiString __fastcall GetSelectedProp(Classes::TStrings* Selected, AnsiString FieldName, TwwUpdateSelected SelectedProperty);
extern PACKAGE void __fastcall wwWriteTextLines(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, int DX, int DY, char * S, Classes::TAlignment Alignment, Wwtypes::TwwWriteTextOptions WriteOptions);

}	/* namespace Wwdbigrd */
using namespace Wwdbigrd;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwdbigrd
