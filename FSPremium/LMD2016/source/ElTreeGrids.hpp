// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeGrids.pas' rev: 31.00 (Windows)

#ifndef EltreegridsHPP
#define EltreegridsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <ElStrArray.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElVCLUtils.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElTreeBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <Vcl.ImgList.hpp>
#include <ElScrollBar.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.Menus.hpp>
#include <ElIni.hpp>
#include <LMDClass.hpp>
#include <ElSBCtrl.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElDragDrop.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreegrids
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElTreeGrid;
class DELPHICLASS TElTreeTrickyInplaceEdit;
class DELPHICLASS TElTreeStringGrid;
class DELPHICLASS TElTreeGridView;
class DELPHICLASS EElTreeGridError;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElTreeGrid : public Eltree::TCustomElTree
{
	typedef Eltree::TCustomElTree inherited;
	
private:
	bool FgoAlwaysShowEditor;
	bool FgoRowSelect;
	bool FgoColMoving;
	bool FgoTabs;
	void __fastcall EditFocusedItem(bool ForcedEdit);
	void __fastcall SetgoRowSelect(bool Value);
	void __fastcall SetgoColMoving(bool Value);
	int __fastcall GetCol(void);
	void __fastcall SetCol(int Value);
	int __fastcall GetRow(void);
	void __fastcall SetRow(int Value);
	int __fastcall GetLeftCol(void);
	void __fastcall SetLeftCol(int Value);
	int __fastcall GetColCount(void);
	void __fastcall SetColCount(int Value);
	int __fastcall GetColWidths(int Index);
	void __fastcall SetColWidths(int Index, int Value);
	int __fastcall GetDefaultColWidth(void);
	void __fastcall SetDefaultColWidth(int Value);
	int __fastcall GetDefaultRowHeight(void);
	void __fastcall SetDefaultRowHeight(int Value);
	bool __fastcall GetEditorMode(void);
	void __fastcall SetEditorMode(bool Value);
	int __fastcall GetRowCount(void);
	void __fastcall SetRowCount(int Value);
	int __fastcall GetTopRow(void);
	void __fastcall SetTopRow(int Value);
	bool __fastcall GetgoEditing(void);
	void __fastcall SetgoEditing(bool Value);
	
protected:
	bool FgoTabSkipNonEditable;
	bool FgoDeletion;
	System::Classes::TNotifyEvent FOnRowAdded;
	virtual void __fastcall OnHeaderSectionDelete(Elheader::TCustomElHeader* Header, Elheader::TElHeaderSection* Section);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	virtual Eltree::TElTreeView* __fastcall CreateView(void);
	Eltree::TElTreeItem* __fastcall GetAsCell(int ACol, int ARow);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	virtual void __fastcall MouseDownTransfer(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall EnsureColumnVisible(int SectionNumber);
	Elheader::TElHeaderSection* __fastcall GetNextTabSection(int SectionIndex, bool &ToNextItem);
	Elheader::TElHeaderSection* __fastcall GetPrevTabSection(int SectionIndex, bool &ToNextItem);
	virtual void __fastcall TriggerRowAddedEvent(void);
	__property bool goAlwaysShowEditor = {read=FgoAlwaysShowEditor, write=FgoAlwaysShowEditor, nodefault};
	__property bool goRowSelect = {read=FgoRowSelect, write=SetgoRowSelect, nodefault};
	__property bool goColMoving = {read=FgoColMoving, write=SetgoColMoving, default=1};
	__property bool goTabs = {read=FgoTabs, write=FgoTabs, nodefault};
	__property bool goDeletion = {read=FgoDeletion, write=FgoDeletion, default=0};
	__property bool goEditing = {read=GetgoEditing, write=SetgoEditing, default=1};
	__property bool goTabSkipNonEditable = {read=FgoTabSkipNonEditable, write=FgoTabSkipNonEditable, nodefault};
	__property int ColCount = {read=GetColCount, write=SetColCount, default=5};
	__property int DefaultColWidth = {read=GetDefaultColWidth, write=SetDefaultColWidth, default=64};
	__property int DefaultRowHeight = {read=GetDefaultRowHeight, write=SetDefaultRowHeight, default=24};
	__property bool EditorMode = {read=GetEditorMode, write=SetEditorMode, nodefault};
	__property int RowCount = {read=GetRowCount, write=SetRowCount, default=5};
	__property System::Classes::TNotifyEvent OnRowAdded = {read=FOnRowAdded, write=FOnRowAdded};
	
public:
	System::Types::TRect __fastcall CellRect(int ACol, int ARow);
	void __fastcall MouseToCell(int X, int Y, int &ACol, int &ARow);
	__fastcall virtual TCustomElTreeGrid(System::Classes::TComponent* Owner);
	Elheader::TElHeaderSection* __fastcall GetNextEditableSection(Elheader::TElHeaderSection* Section, bool GoForward);
	__property int Col = {read=GetCol, write=SetCol, nodefault};
	__property int ColWidths[int Index] = {read=GetColWidths, write=SetColWidths};
	__property int LeftCol = {read=GetLeftCol, write=SetLeftCol, nodefault};
	__property int Row = {read=GetRow, write=SetRow, nodefault};
	__property int TopRow = {read=GetTopRow, write=SetTopRow, nodefault};
	
__published:
	__property VerticalLines = {default=1};
	__property HorizontalLines = {default=1};
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TCustomElTreeGrid(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eltree::TCustomElTree(AOwner, ItemClass) { }
	/* TCustomElTree.Destroy */ inline __fastcall virtual ~TCustomElTreeGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElTreeGrid(HWND ParentWindow) : Eltree::TCustomElTree(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


class PASCALIMPLEMENTATION TElTreeTrickyInplaceEdit : public Eltreebtnedit::TElTreeInplaceButtonEdit
{
	typedef Eltreebtnedit::TElTreeInplaceButtonEdit inherited;
	
private:
	System::UnicodeString FDummyStr;
	
__published:
	__property System::UnicodeString Name = {read=FDummyStr};
	__property System::UnicodeString Tree = {read=FDummyStr};
public:
	/* TElTreeInplaceButtonEdit.Create */ inline __fastcall virtual TElTreeTrickyInplaceEdit(System::Classes::TComponent* AOwner) : Eltreebtnedit::TElTreeInplaceButtonEdit(AOwner) { }
	/* TElTreeInplaceButtonEdit.Destroy */ inline __fastcall virtual ~TElTreeTrickyInplaceEdit(void) { }
	
};


class PASCALIMPLEMENTATION TElTreeStringGrid : public TCustomElTreeGrid
{
	typedef TCustomElTreeGrid inherited;
	
private:
	Lmdunicodestrings::TLMDWideStringArray* FCols;
	Lmdunicodestrings::TLMDWideStringArray* FRows;
	System::Classes::TWndMethod FSavedEditWndProc;
	System::Classes::TStrings* __fastcall GetCols(int Index);
	void __fastcall SetCols(int Index, System::Classes::TStrings* Value);
	System::Classes::TStrings* __fastcall GetRows(int Index);
	void __fastcall SetRows(int Index, System::Classes::TStrings* Value);
	Lmdtypes::TLMDString __fastcall GetCells(int ACol, int ARow);
	void __fastcall SetCells(int ACol, int ARow, Lmdtypes::TLMDString Value);
	System::TObject* __fastcall GetObjects(int ACol, int ARow);
	void __fastcall SetObjects(int ACol, int ARow, System::TObject* Value);
	void __fastcall SetEditor(Eltreebtnedit::TElTreeInplaceButtonEdit* Value);
	
protected:
	Eltreebtnedit::TElTreeInplaceButtonEdit* FEditor;
	bool FUseDefaultEditor;
	virtual void __fastcall TriggerInplaceEditorNeeded(Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	virtual void __fastcall OnFontChange(System::TObject* Sender);
	virtual void __fastcall KeyDownTransfer(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall EditorKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall EditWndProc(Winapi::Messages::TMessage &Message);
	virtual Lmdtypes::TLMDString __fastcall GetIncSearchColumnText(Eltree::TElTreeItem* Item);
	
public:
	__fastcall virtual TElTreeStringGrid(System::Classes::TComponent* Owner);
	__fastcall virtual ~TElTreeStringGrid(void);
	__property System::Classes::TStrings* Cols[int Index] = {read=GetCols, write=SetCols};
	__property System::Classes::TStrings* Rows[int Index] = {read=GetRows, write=SetRows};
	__property Lmdtypes::TLMDString Cells[int ACol][int ARow] = {read=GetCells, write=SetCells/*, default*/};
	__property System::TObject* Objects[int ACol][int ARow] = {read=GetObjects, write=SetObjects};
	__property Eltreebtnedit::TElTreeInplaceButtonEdit* Editor = {read=FEditor, write=SetEditor};
	
__published:
	__property bool UseDefaultEditor = {read=FUseDefaultEditor, write=FUseDefaultEditor, default=0};
	__property ColCount = {default=5};
	__property RowCount = {default=5};
	__property goAlwaysShowEditor = {default=0};
	__property goRowSelect = {default=0};
	__property goColMoving = {default=1};
	__property goDeletion = {default=0};
	__property goEditing = {default=1};
	__property goTabs = {default=0};
	__property goTabSkipNonEditable = {default=0};
	__property DefaultColWidth = {default=64};
	__property DefaultRowHeight = {default=24};
	__property AlwaysKeepFocus = {default=1};
	__property AlwaysKeepSelection = {default=1};
	__property AutoCollapse = {default=0};
	__property AutoExpand = {default=0};
	__property AutoLineHeight = {default=0};
	__property DefaultSectionWidth = {default=64};
	__property BarStyle = {default=0};
	__property BarStyleVerticalLines = {default=0};
	__property UseThemeForSelection = {default=0};
	__property CheckBoxFlat = {default=0};
	__property CheckBoxGlyph;
	__property CheckBoxSize = {default=15};
	__property IgnoreEnabled = {default=0};
	__property IncrementalSearch = {default=0};
	__property IncrementalSearchScope = {default=0};
	__property IncrementalSearchTimeout = {default=500};
	__property KeepSelectionWithinLevel = {default=0};
	__property MainTextType = {default=1};
	__property MouseFrameSelect = {default=1};
	__property PathSeparator = {default=92};
	__property QuickEditMode = {default=0};
	__property RowHotTrack = {default=0};
	__property SortUseCase = {default=1};
	__property StripedOddColor;
	__property StripedEvenColor;
	__property StripedItems = {default=0};
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property AutoLookup = {default=0};
	__property AutoResizeColumns = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DragKind = {default=0};
	__property DoubleBuffered = {default=1};
	__property AdjustMultilineHeight = {default=1};
	__property Background;
	__property BackgroundType = {default=2};
	__property BorderStyle = {default=1};
	__property ChangeDelay = {default=500};
	__property ChangeStateImage = {default=0};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property CustomCheckboxes = {default=0};
	__property CustomPlusMinus = {default=0};
	__property VertDivLinesColor = {default=-16777201};
	__property HorzDivLinesColor = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragAllowed = {default=0};
	__property DragTrgDrawMode = {default=2};
	__property DragType = {default=1};
	__property DragExpandDelay = {default=500};
	__property DragImageMode = {default=0};
	__property DrawFocusRect = {default=1};
	__property DragRectAcceptColor = {default=32768};
	__property DragRectDenyColor = {default=255};
	__property Enabled = {default=1};
	__property ExpandOnDragOver = {default=0};
	__property ExplorerEditMode = {default=0};
	__property FilteredVisibility = {default=0};
	__property Flat = {default=0};
	__property FlatFocusedScrollbars = {default=1};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property ForcedScrollBars = {default=0};
	__property Font = {stored=true};
	__property GradientStartColor = {default=0};
	__property GradientEndColor = {default=0};
	__property GradientSteps = {default=64};
	__property HeaderActiveFilterColor = {default=0};
	__property HeaderColor = {default=-16777201};
	__property HeaderHeight = {default=0};
	__property HeaderHotTrack = {default=1};
	__property HeaderInvertSortArrows = {default=0};
	__property HeaderSections;
	__property HeaderFilterColor = {default=-16777198};
	__property HeaderFlat = {default=0};
	__property HeaderImages;
	__property HeaderFont;
	__property HeaderUseTreeFont = {default=1};
	__property HorzArrowsScroll = {default=0};
	__property AlphaForHeaderImages;
	__property HeaderWrapCaptions = {default=0};
	__property HideFocusRect = {default=0};
	__property HideHintOnTimer = {default=0};
	__property HideHintOnMove = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HideSelection = {default=0};
	__property HighlightAlphaLevel = {default=255};
	__property HorizontalLines = {default=1};
	__property HideHorzScrollBar = {default=0};
	__property HideVertScrollBar = {default=0};
	__property Hint;
	__property HorzScrollBarStyles;
	__property HeaderImageForm;
	__property ImageForm;
	__property Images;
	__property Images2;
	__property AlphaForImages;
	__property AlphaForImages2;
	__property InactiveBorderType = {default=3};
	__property InplaceEditorDelay = {default=500};
	__property ItemIndent = {default=17};
	__property Items;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property LinesColor = {default=-16777201};
	__property LinesStyle = {default=2};
	__property LineHintColor = {default=-16777211};
	__property LineHintMode = {default=1};
	__property LineHintTimeout = {default=3000};
	__property LineHintType = {default=2};
	__property LockHeaderHeight = {default=1};
	__property MainTreeColumn = {default=0};
	__property MinusPicture;
	__property MoveFocusOnCollapse = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PlusMinusTransparent = {default=0};
	__property PlusPicture;
	__property PopupMenu;
	__property RadioButtonGlyph;
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property RightClickSelect = {default=1};
	__property ScrollbarOpposite = {default=0};
	__property HorzScrollTracking = {default=0};
	__property VertScrollTracking = {default=0};
	__property ShowButtons = {default=0};
	__property ShowCheckBoxes = {default=0};
	__property ShowEmptyImages = {default=0};
	__property ShowEmptyImages2 = {default=0};
	__property ShowHint;
	__property ShowImages = {default=0};
	__property ShowLines = {default=0};
	__property ShowRoot = {default=0};
	__property ShowRootButtons = {default=1};
	__property SortDir = {default=0};
	__property SortMode = {default=0};
	__property SortSection = {default=0};
	__property SortType = {default=1};
	__property Storage;
	__property StoragePath = {default=0};
	__property StickyHeaderSections = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property UseCustomScrollBars = {default=1};
	__property VerticalLines = {default=1};
	__property VerticalLinesLong = {default=0};
	__property VertScrollBarStyles;
	__property VirtualityLevel = {default=0};
	__property Visible = {default=1};
	__property UseSystemHintColors = {default=0};
	__property TextColor = {default=-16777208};
	__property BkColor = {default=-16777211};
	__property OnRowAdded;
	__property OnScroll;
	__property OnHeaderColumnClick;
	__property OnHeaderColumnDraw;
	__property OnHeaderColumnResize;
	__property OnHeaderColumnMove;
	__property OnHeaderLookup;
	__property OnHeaderLookupDone;
	__property OnHeaderResize;
	__property OnHeaderSectionExpand;
	__property OnHeaderSectionCollapse;
	__property OnHeaderSectionFilterCall;
	__property OnHeaderSectionAutoSize;
	__property OnHeaderSectionMeasure;
	__property OnHorzScrollDrawPart;
	__property OnHorzScrollHintNeeded;
	__property OnAfterSelectionChange;
	__property OnChanging;
	__property OnDragTargetChange;
	__property OnItemChange;
	__property OnItemPreDraw;
	__property OnItemDraw;
	__property OnResize;
	__property OnInplaceEditorNeeded;
	__property OnTryEdit;
	__property OnItemChecked;
	__property OnItemExpand;
	__property OnItemCollapse;
	__property OnItemExpanding;
	__property OnItemCollapsing;
	__property OnItemDeletion;
	__property OnItemFocused;
	__property OnShowLineHint;
	__property OnCompareItems;
	__property OnItemPicDraw;
	__property OnItemPicDraw2;
	__property OnItemPostDraw;
	__property OnHotTrack;
	__property OnSortBegin;
	__property OnSortEnd;
	__property OnItemSave;
	__property OnItemLoad;
	__property OnItemSelectedChange;
	__property OnCellStyleSave;
	__property OnCellStyleLoad;
	__property OnVertScrollDrawPart;
	__property OnVertScrollHintNeeded;
	__property OnHTMLImageNeeded;
	__property OnHTMLImageNeededEx;
	__property OnLinkClick;
	__property OnLinkOver;
	__property LinkCursor = {default=-21};
	__property LinkColor = {default=16711680};
	__property LinkStyle = {default=4};
	__property OnHeaderMouseDown;
	__property OnVirtualTextNeeded;
	__property OnVirtualHintNeeded;
	__property OnVirtualValueNeeded;
	__property OnVirtualStyleNeeded;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnOleTargetDrag;
	__property OnOleTargetDrop;
	__property OnOleDragStart;
	__property OnOleDragFinish;
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElTreeStringGrid(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : TCustomElTreeGrid(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeStringGrid(HWND ParentWindow) : TCustomElTreeGrid(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeGridView : public Eltree::TElTreeView
{
	typedef Eltree::TElTreeView inherited;
	
protected:
	HIDESBASE bool __fastcall IntLButtonDown(int X, int Y, System::Classes::TShiftState Shift);
	virtual bool __fastcall NeedToFoxusItemInMouseDown(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
public:
	/* TElTreeView.Create */ inline __fastcall virtual TElTreeGridView(System::Classes::TComponent* Owner) : Eltree::TElTreeView(Owner) { }
	/* TElTreeView.Destroy */ inline __fastcall virtual ~TElTreeGridView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeGridView(HWND ParentWindow) : Eltree::TElTreeView(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION EElTreeGridError : public Eltreeinplaceeditors::EElTreeError
{
	typedef Eltreeinplaceeditors::EElTreeError inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElTreeGridError(const System::UnicodeString Msg) : Eltreeinplaceeditors::EElTreeError(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElTreeGridError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : Eltreeinplaceeditors::EElTreeError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElTreeGridError(NativeUInt Ident)/* overload */ : Eltreeinplaceeditors::EElTreeError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElTreeGridError(System::PResStringRec ResStringRec)/* overload */ : Eltreeinplaceeditors::EElTreeError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElTreeGridError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : Eltreeinplaceeditors::EElTreeError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElTreeGridError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : Eltreeinplaceeditors::EElTreeError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElTreeGridError(const System::UnicodeString Msg, int AHelpContext) : Eltreeinplaceeditors::EElTreeError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElTreeGridError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : Eltreeinplaceeditors::EElTreeError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElTreeGridError(NativeUInt Ident, int AHelpContext)/* overload */ : Eltreeinplaceeditors::EElTreeError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElTreeGridError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Eltreeinplaceeditors::EElTreeError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElTreeGridError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Eltreeinplaceeditors::EElTreeError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElTreeGridError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Eltreeinplaceeditors::EElTreeError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElTreeGridError(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreegrids */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEGRIDS)
using namespace Eltreegrids;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreegridsHPP
