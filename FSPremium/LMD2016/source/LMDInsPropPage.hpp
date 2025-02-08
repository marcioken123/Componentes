// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsPropPage.pas' rev: 31.00 (Windows)

#ifndef LmdinsproppageHPP
#define LmdinsproppageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Grids.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.GraphUtil.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Themes.hpp>
#include <System.Math.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsCst.hpp>
#include <Vcl.Mask.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinsproppage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPropsPage;
class DELPHICLASS TLMDPropsPageInplaceEdit;
class DELPHICLASS TLMDPropsPageItem;
class DELPHICLASS TLMDPropsPageItems;
struct TLMDRestoreItem;
class DELPHICLASS TLMDPropPageStateObject;
class DELPHICLASS TLMDCustomPropsPage;
class DELPHICLASS TLMDPropsPage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPropsPage : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPropsPage(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPropsPage(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropsPage(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropsPage(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropsPage(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropsPage(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPropsPage(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPropsPage(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropsPage(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropsPage(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropsPage(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropsPage(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPropsPage(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDPropsPageInplaceEdit : public Vcl::Grids::TInplaceEditList
{
	typedef Vcl::Grids::TInplaceEditList inherited;
	
private:
	bool FChangingBounds;
	bool FReadOnlyStyle;
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall PickListMeasureItem(Vcl::Controls::TWinControl* Control, int Index, int &Height);
	void __fastcall PickListDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DropDown(void);
	virtual void __fastcall UpdateContents(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall DoEditButtonClick(void);
	DYNAMIC void __fastcall DoGetPickListItems(void);
	DYNAMIC void __fastcall CloseUp(bool Accept);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall BoundsChanged(void);
	
public:
	__fastcall virtual TLMDPropsPageInplaceEdit(System::Classes::TComponent* AOwner);
	__property bool ReadOnlyStyle = {read=FReadOnlyStyle, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPropsPageInplaceEdit(HWND ParentWindow) : Vcl::Grids::TInplaceEditList(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDPropsPageInplaceEdit(void) { }
	
};


enum DECLSPEC_DENUM TLMDPropsPageItemExpandable : unsigned char { ieAuto, ieYes, ieNo };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropsPageItem : public Lmdinsclass::TLMDObjectList
{
	typedef Lmdinsclass::TLMDObjectList inherited;
	
public:
	TLMDPropsPageItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDPropsPageItem* FParent;
	TLMDCustomPropsPage* FOwner;
	TLMDPropsPageItemExpandable FExpandable;
	Lmdtypes::TLMDString FCaption;
	bool FExpanded;
	Lmdtypes::TLMDString FDisplayValue;
	Vcl::Grids::TEditStyle FEditStyle;
	int FRow;
	bool FReadOnly;
	bool FAutoUpdate;
	bool FOwnerDrawPickList;
	bool FIsCategory;
	void *FData;
	bool FHighlighted;
	bool __fastcall CanExpand(void);
	int __fastcall Ident(void);
	bool __fastcall IsOnExpandButton(int AX);
	HIDESBASE TLMDPropsPageItem* __fastcall GetItems(int AIndex);
	void __fastcall SetExpandable(const TLMDPropsPageItemExpandable Value);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	int __fastcall GetLevel(void);
	void __fastcall SetEditStyle(const Vcl::Grids::TEditStyle Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetAutoUpdate(const bool Value);
	void __fastcall SetOwnerDrawPickList(const bool Value);
	bool __fastcall GetActive(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetIsCategory(const bool Value);
	TLMDPropsPageItem* __fastcall GetNonCategoryParent(void);
	TLMDPropsPageItem* __fastcall GetParentCategory(void);
	void __fastcall SetHighlighted(const bool Value);
	
protected:
	virtual System::TObject* __fastcall CreateItem(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall Deleted(void);
	virtual Lmdtypes::TLMDString __fastcall GetDisplayValue(void);
	virtual Lmdtypes::TLMDString __fastcall GetEditValue(void);
	virtual void __fastcall SetEditValue(const Lmdtypes::TLMDString Value, bool AForce);
	DYNAMIC void __fastcall EditButtonClick(void);
	DYNAMIC void __fastcall EditDblClick(void);
	virtual void __fastcall GetEditPickList(System::Classes::TStrings* APickList);
	virtual void __fastcall PickListMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall PickListMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall PickListDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	
public:
	__fastcall virtual TLMDPropsPageItem(TLMDCustomPropsPage* AOwner, TLMDPropsPageItem* AParent);
	__fastcall virtual ~TLMDPropsPageItem(void);
	TLMDPropsPageItem* __fastcall Find(const Lmdtypes::TLMDString ACaption);
	void __fastcall Expand(void);
	void __fastcall Collapse(void);
	System::Types::TRect __fastcall DisplayRect(bool ACaption, bool AValue);
	int __fastcall Index(void);
	bool __fastcall IsFirst(void);
	bool __fastcall IsLast(void);
	bool __fastcall ShowEditor(void);
	__property TLMDCustomPropsPage* Owner = {read=FOwner};
	__property TLMDPropsPageItem* Parent = {read=FParent};
	__property TLMDPropsPageItem* NonCategoryParent = {read=GetNonCategoryParent};
	__property TLMDPropsPageItem* ParentCategory = {read=GetParentCategory};
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	__property TLMDPropsPageItemExpandable Expandable = {read=FExpandable, write=SetExpandable, nodefault};
	__property bool Expanded = {read=FExpanded, nodefault};
	__property int Level = {read=GetLevel, nodefault};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Lmdtypes::TLMDString DisplayValue = {read=GetDisplayValue};
	__property Vcl::Grids::TEditStyle EditStyle = {read=FEditStyle, write=SetEditStyle, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, nodefault};
	__property bool AutoUpdate = {read=FAutoUpdate, write=SetAutoUpdate, nodefault};
	__property bool Highlighted = {read=FHighlighted, write=SetHighlighted, nodefault};
	__property bool IsCategory = {read=FIsCategory, write=SetIsCategory, nodefault};
	__property bool OwnerDrawPickList = {read=FOwnerDrawPickList, write=SetOwnerDrawPickList, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TLMDPropsPageItem* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropsPageItems : public Lmdinsclass::TLMDObjectList
{
	typedef Lmdinsclass::TLMDObjectList inherited;
	
public:
	TLMDPropsPageItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDCustomPropsPage* FOwner;
	HIDESBASE TLMDPropsPageItem* __fastcall GetItems(int AIndex);
	
protected:
	virtual System::TObject* __fastcall CreateItem(void);
	virtual void __fastcall Change(void);
	
public:
	__fastcall TLMDPropsPageItems(TLMDCustomPropsPage* AOwner);
	TLMDPropsPageItem* __fastcall Find(const Lmdtypes::TLMDString ACaption);
	__property TLMDCustomPropsPage* Owner = {read=FOwner};
	__property TLMDPropsPageItem* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TLMDPropsPageItems(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDRestoreItem
{
public:
	Lmdtypes::TLMDString Caption;
	void *Items;
};


typedef System::DynamicArray<TLMDRestoreItem> TLMDRestoreItems;

typedef TLMDRestoreItems *PLMDRestoreItems;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropPageStateObject : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRestoreItems FActiveItemInfo;
	TLMDRestoreItems FExpandedInfo;
	void __fastcall FreeExpandInfo(PLMDRestoreItems ARItems);
	
public:
	__fastcall TLMDPropPageStateObject(void);
	__fastcall virtual ~TLMDPropPageStateObject(void);
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdinsproppage__6 : unsigned char { ppsMovingSplitter, ppsScrollingByMouse, ppsChanged, ppsDestroying, ppsUpdatingEditorContent, ppsChangingActiveItem, ppsSettingAutoUpdateItemValue };

typedef System::Set<Lmdinsproppage__6, Lmdinsproppage__6::ppsMovingSplitter, Lmdinsproppage__6::ppsSettingAutoUpdateItemValue> TLMDPropsPageState;

enum DECLSPEC_DENUM TLMDPropsPageHitTest : unsigned char { htOnItem, htOnExpandButton, htOnCaption, htOnValue, htOnSplitter };

typedef System::Set<TLMDPropsPageHitTest, TLMDPropsPageHitTest::htOnItem, TLMDPropsPageHitTest::htOnSplitter> TLMDPropsPageHitTests;

typedef void __fastcall (__closure *TLMDPropsPageItemEvent)(System::TObject* Sender, TLMDPropsPageItem* AItem);

enum DECLSPEC_DENUM TLMDPropsPageSelectionStyle : unsigned char { ssClassic, ssFlat };

class PASCALIMPLEMENTATION TLMDCustomPropsPage : public Vcl::Grids::TCustomGrid
{
	typedef Vcl::Grids::TCustomGrid inherited;
	
	
private:
	typedef System::DynamicArray<TLMDPropsPageItem*> _TLMDCustomPropsPage__1;
	
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDPropsPageState FState;
	int FOldRow;
	int FSplitterOffset;
	Lmdtypes::TLMDString FEditText;
	TLMDPropsPageItem* FEditTextItem;
	TLMDPropsPageItems* FItems;
	_TLMDCustomPropsPage__1 FRows;
	int FUpdateCount;
	System::Uitypes::TColor FValuesColor;
	Vcl::Graphics::TBitmap* FGridPattern;
	System::Uitypes::TColor FGridPatternColor;
	System::Uitypes::TColor FGridPatternBkColor;
	HBRUSH FBrush;
	Vcl::Graphics::TBitmap* FCellBitmap;
	TLMDPropsPageItemEvent FOnExpanded;
	TLMDPropsPageItemEvent FOnCollapsed;
	bool FToolTips;
	Vcl::Controls::THintWindow* FToolTipWindow;
	System::Types::TPoint LCurrentToolTipPos;
	Lmdtypes::TLMDString LCurrentToolTip;
	bool FGridVisible;
	System::Uitypes::TColor FGridColor;
	Vcl::Graphics::TBitmap* FCursorBitmap;
	System::Uitypes::TColor FCursorColor;
	bool FGutterVisible;
	System::Uitypes::TColor FGutterColor;
	bool FCursorVisible;
	TLMDPropsPageSelectionStyle FSelectionStyle;
	System::Uitypes::TColor FFlatSelectionBackgroundColor;
	System::Uitypes::TColor FFlatSelectionColor;
	System::Uitypes::TColor FGutterLineColor;
	System::Uitypes::TColor FCatergoryBackgroundColor;
	Lmdtypes::TLMDString FDefaultPropName;
	Vcl::Graphics::TFont* FCategoryFont;
	System::Uitypes::TColor FFlatSplitterColor;
	void __fastcall SetEditTextBuf(const Lmdtypes::TLMDString AValue, TLMDPropsPageItem* AItem);
	Lmdtypes::TLMDString __fastcall GetEditTextBuf(TLMDPropsPageItem* AItem);
	void __fastcall CancelEditTextBuf(void);
	void __fastcall FlushEditTextBuf(void);
	void __fastcall ItemsChange(void);
	bool __fastcall IsOnSplitter(int AX);
	void __fastcall UpdateColWidths(void);
	void __fastcall UpdateScrollBar(void);
	void __fastcall AdjustTopRow(void);
	TLMDPropsPageItem* __fastcall ItemByRow(int ARow);
	void __fastcall UpdatePattern(bool AForce = false);
	void __fastcall IsToolTipMsg(tagMSG &AMsg);
	void __fastcall UpdateToolTip(void);
	void __fastcall ActivateToolTip(const System::Types::TPoint &LP, const Lmdtypes::TLMDString ATip);
	void __fastcall CancelToolTip(void);
	void __fastcall CategoryFontChanged(System::TObject* Sender);
	void __fastcall UpdateRowHeight(void);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	TLMDPropsPageItem* __fastcall GetActiveItem(void);
	int __fastcall GetSplitter(void);
	void __fastcall SetSplitter(const int Value);
	void __fastcall SetValuesColor(const System::Uitypes::TColor Value);
	void __fastcall SetToolTips(const bool Value);
	void __fastcall SetGridVisible(const bool Value);
	void __fastcall SetGridColor(const System::Uitypes::TColor Value);
	void __fastcall SetGutterVisible(const bool Value);
	void __fastcall SetGutterColor(const System::Uitypes::TColor Value);
	void __fastcall SetCursorVisible(const bool Value);
	void __fastcall SetSelectionStyle(const TLMDPropsPageSelectionStyle Value);
	void __fastcall SetFlatSelectionBackgroundColor(const System::Uitypes::TColor Value);
	void __fastcall SetFlatSelectionColor(const System::Uitypes::TColor Value);
	void __fastcall SetGutterLineColor(const System::Uitypes::TColor Value);
	void __fastcall SetCatergoryBackgroundColor(const System::Uitypes::TColor Value);
	void __fastcall SetCategoryFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetFlatSplitterColor(const System::Uitypes::TColor Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedCaptionTextColor(System::Uitypes::TColor ADefault);
	System::Uitypes::TColor __fastcall GetThemedValueTextColor(void);
	System::Uitypes::TColor __fastcall GetThemedCategoryBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedCategoryTextColor(void);
	System::Uitypes::TColor __fastcall GetThemedGutterColor(void);
	System::Uitypes::TColor __fastcall GetThemedGutterLineColor(void);
	Vcl::Graphics::TBitmap* __fastcall GetThemedCursor(void);
	System::Uitypes::TColor __fastcall GetThemedSplitterColor(int AShift);
	System::Uitypes::TColor __fastcall GetThemedGridColor(void);
	virtual void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState AState);
	void __fastcall DrawGutter(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, int AGutterLeft, bool AIsFirst, int AFirstParentGutterLeft, bool AIsLast, int ALastParentGutterLeft);
	virtual void __fastcall DoDrawCell(Vcl::Graphics::TCanvas* ACanvas, int AWidth, int AHeight, TLMDPropsPageItem* AItem, int ACol, int ARow, Vcl::Grids::TGridDrawState AState);
	virtual bool __fastcall CanEditShow(void);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual Vcl::Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual void __fastcall Paint(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC Vcl::Grids::TEditStyle __fastcall GetEditStyle(int ACol, int ARow);
	DYNAMIC bool __fastcall CanEditModify(void);
	DYNAMIC System::UnicodeString __fastcall GetEditText(int ACol, int ARow);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const System::UnicodeString Value);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall TopLeftChanged(void);
	DYNAMIC void __fastcall SizeChanged(int OldColCount, int OldRowCount);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall BeginDestruction(void);
	virtual TLMDPropsPageItem* __fastcall CreateItem(TLMDPropsPageItem* AParent);
	virtual void __fastcall ItemDestroying(TLMDPropsPageItem* AItem);
	virtual void __fastcall ItemExpanded(TLMDPropsPageItem* AItem);
	virtual void __fastcall ItemCollapsed(TLMDPropsPageItem* AItem);
	virtual System::Uitypes::TColor __fastcall GetItemCaptionColor(TLMDPropsPageItem* AItem);
	__property TLMDPropsPageItems* Items = {read=FItems};
	__property TLMDPropsPageItem* ActiveItem = {read=GetActiveItem};
	__property int Splitter = {read=GetSplitter, write=SetSplitter, nodefault};
	__property System::Uitypes::TColor ValuesColor = {read=FValuesColor, write=SetValuesColor, default=8388608};
	__property Color = {default=-16777201};
	__property bool ToolTips = {read=FToolTips, write=SetToolTips, default=1};
	__property System::Uitypes::TColor GridColor = {read=FGridColor, write=SetGridColor, default=-16777200};
	__property bool GridVisible = {read=FGridVisible, write=SetGridVisible, default=1};
	__property bool GutterVisible = {read=FGutterVisible, write=SetGutterVisible, default=0};
	__property System::Uitypes::TColor GutterColor = {read=FGutterColor, write=SetGutterColor, default=15793151};
	__property System::Uitypes::TColor GutterLineColor = {read=FGutterLineColor, write=SetGutterLineColor, default=-16777200};
	__property bool CursorVisible = {read=FCursorVisible, write=SetCursorVisible, default=0};
	__property TLMDPropsPageSelectionStyle SelectionStyle = {read=FSelectionStyle, write=SetSelectionStyle, default=0};
	__property System::Uitypes::TColor FlatSelectionBackgroundColor = {read=FFlatSelectionBackgroundColor, write=SetFlatSelectionBackgroundColor, default=-16777203};
	__property System::Uitypes::TColor FlatSelectionColor = {read=FFlatSelectionColor, write=SetFlatSelectionColor, default=-16777202};
	__property System::Uitypes::TColor FlatSplitterColor = {read=FFlatSplitterColor, write=SetFlatSplitterColor, default=8421504};
	__property System::Uitypes::TColor CategoryBackgroundColor = {read=FCatergoryBackgroundColor, write=SetCatergoryBackgroundColor, default=-16777203};
	__property Vcl::Graphics::TFont* CategoryFont = {read=FCategoryFont, write=SetCategoryFont};
	__property Lmdtypes::TLMDString DefaultPropName = {read=FDefaultPropName, write=FDefaultPropName};
	__property TLMDPropsPageItemEvent OnExpanded = {read=FOnExpanded, write=FOnExpanded};
	__property TLMDPropsPageItemEvent OnCollapsed = {read=FOnCollapsed, write=FOnCollapsed};
	
public:
	__fastcall virtual TLMDCustomPropsPage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPropsPage(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	bool __fastcall CanCopyToClipboard(void);
	bool __fastcall CanCutToClipboard(void);
	bool __fastcall CanPasteFromClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	TLMDPropPageStateObject* __fastcall SaveState(void);
	void __fastcall RestoreState(TLMDPropPageStateObject* AStateObject, bool AFreeStateObject = true);
	TLMDPropsPageItem* __fastcall ItemAtPos(int AX, int AY);
	TLMDPropsPageHitTests __fastcall GetHitTestInfoAt(int AX, int AY);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomPropsPage(HWND ParentWindow) : Vcl::Grids::TCustomGrid(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDPropsPage : public TLMDCustomPropsPage
{
	typedef TLMDCustomPropsPage inherited;
	
public:
	__property Items;
	__property ActiveItem;
	
__published:
	__property Splitter;
	__property ValuesColor = {default=8388608};
	__property ToolTips = {default=1};
	__property GridColor = {default=-16777200};
	__property GridVisible = {default=1};
	__property GutterVisible = {default=0};
	__property GutterColor = {default=15793151};
	__property GutterLineColor = {default=-16777200};
	__property CursorVisible = {default=0};
	__property SelectionStyle = {default=0};
	__property FlatSelectionBackgroundColor = {default=-16777203};
	__property FlatSelectionColor = {default=-16777202};
	__property FlatSplitterColor = {default=8421504};
	__property CategoryBackgroundColor = {default=-16777203};
	__property CategoryFont;
	__property DefaultPropName = {default=0};
	__property OnExpanded;
	__property OnCollapsed;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
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
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TLMDCustomPropsPage.Create */ inline __fastcall virtual TLMDPropsPage(System::Classes::TComponent* AOwner) : TLMDCustomPropsPage(AOwner) { }
	/* TLMDCustomPropsPage.Destroy */ inline __fastcall virtual ~TLMDPropsPage(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPropsPage(HWND ParentWindow) : TLMDCustomPropsPage(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinsproppage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSPROPPAGE)
using namespace Lmdinsproppage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinsproppageHPP
