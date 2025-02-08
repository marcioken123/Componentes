// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonBar.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonbarHPP
#define LmdbuttonbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDSpinButton.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDUtils.hpp>
#include <LMDProcs.hpp>
#include <LMDConst.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFXCaption.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDFaceController.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>
#include <LMDFillObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonBarSpinButton;
class DELPHICLASS TLMDButtonBarItem;
class DELPHICLASS TLMDButtonBarItems;
class DELPHICLASS TLMDButtonBarSection;
class DELPHICLASS TLMDButtonBarSections;
class DELPHICLASS TLMDButtonBarStoreComp;
class DELPHICLASS TLMDButtonBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButtonBarSpinButton : public Lmdspinbutton::TLMDSpinButton
{
	typedef Lmdspinbutton::TLMDSpinButton inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
public:
	/* TLMDSpinButton.Create */ inline __fastcall virtual TLMDButtonBarSpinButton(System::Classes::TComponent* AOwner) : Lmdspinbutton::TLMDSpinButton(AOwner) { }
	/* TLMDSpinButton.Destroy */ inline __fastcall virtual ~TLMDButtonBarSpinButton(void) { }
	
};


class PASCALIMPLEMENTATION TLMDButtonBarItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TBitmap* FLargeGlyph;
	Vcl::Graphics::TBitmap* FSmallGlyph;
	System::Uitypes::TCursor FCursor;
	bool FVisible;
	bool FEnabled;
	System::Types::TRect FGlyphRect;
	System::Types::TRect FTextRect;
	System::Types::TRect FRect;
	int FHeight;
	int FTag;
	int FImageIndex;
	System::Classes::TNotifyEvent FOnClick;
	System::TObject* FObject;
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetGlyph(int index, Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetCursor(System::Uitypes::TCursor aValue);
	void __fastcall SetInteger(int aValue);
	void __fastcall SetBoolean(bool aValue);
	void __fastcall GetChange(System::TObject* Sender);
	int __fastcall GetItemHeight(void);
	void __fastcall SetLinkObject(System::TObject* aValue);
	System::TObject* __fastcall GetLinkObject(void);
	System::Types::TRect __fastcall GetDisplayRect(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	__property bool Visible = {read=FVisible, write=SetBoolean, default=1};
	__property int Height = {read=FHeight, write=FHeight, default=-1};
	
public:
	__fastcall virtual TLMDButtonBarItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDButtonBarItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Types::TRect TextRect = {read=FTextRect, write=FTextRect};
	__property System::Types::TRect GlyphRect = {read=FGlyphRect, write=FGlyphRect};
	__property System::Types::TRect DisplayRect = {read=GetDisplayRect, write=FRect};
	__property int ItemHeight = {read=GetItemHeight, nodefault};
	__property System::TObject* LinkObject = {read=GetLinkObject, write=SetLinkObject};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetString, index=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=-2};
	__property System::UnicodeString Hint = {read=FHint, write=SetString, index=1};
	__property Vcl::Graphics::TBitmap* SmallGlyph = {read=FSmallGlyph, write=SetGlyph, index=0};
	__property Vcl::Graphics::TBitmap* LargeGlyph = {read=FLargeGlyph, write=SetGlyph, index=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetInteger, nodefault};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Index;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonBarItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDButtonBarItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TCollectionItem* FOwner;
	HIDESBASE TLMDButtonBarItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDButtonBarItem* Value);
	int __fastcall GetVisibleCount(void);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDButtonBarItems(System::Classes::TCollectionItem* Owner);
	__fastcall virtual ~TLMDButtonBarItems(void);
	HIDESBASE TLMDButtonBarItem* __fastcall Add(void);
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
	__property TLMDButtonBarItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDItemOrientation : unsigned char { ioVertical, ioHorizontal, ioAuto };

enum DECLSPEC_DENUM TLMDHintTimerMode : unsigned char { htHide, htShow };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonBarSection : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TBitmap* FGlyph;
	System::Uitypes::TCursor FCursor;
	TLMDItemOrientation FItemOrientation;
	bool FMultiLine;
	bool FTransparentGlyphs;
	bool FParentFont;
	bool FItemParentFont;
	bool FKeepItemParentFontFlag;
	bool FShowHint;
	bool FReadOnly;
	bool FUseSmallImages;
	bool FVisible;
	bool FEnabled;
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FLayout;
	TLMDButtonBarItems* FItems;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FItemFont;
	Lmdclass::TLMDTimer* FTimerHandle;
	int FHintPause;
	int FHideHintPause;
	int FListIndex;
	int FScrollPos;
	int FBtnMinHeight;
	System::Types::TRect FUpBtnRect;
	System::Types::TRect FDnBtnRect;
	System::Types::TRect FRect;
	System::Types::TRect FClientRect;
	Vcl::Controls::THintWindow* FHintWindow;
	TLMDHintTimerMode FHintTimerMode;
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetCursor(System::Uitypes::TCursor aValue);
	void __fastcall SetLayout(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetItems(TLMDButtonBarItems* aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetItemOrientation(TLMDItemOrientation aValue);
	void __fastcall GetChange(System::TObject* Sender);
	void __fastcall GetItemFontChange(System::TObject* Sender);
	bool __fastcall isFontStored(void);
	bool __fastcall isItemFontStored(void);
	void __fastcall HintTimerProc(System::TObject* Sender);
	void __fastcall StartHintTimer(int Value, TLMDHintTimerMode TimerMode);
	void __fastcall StopHintTimer(void);
	void __fastcall ActivateHint(void);
	void __fastcall CancelHint(void);
	System::TObject* __fastcall GetSectionObject(int Index);
	void __fastcall SetSectionObject(int Index, System::TObject* aValue);
	void __fastcall SetListIndex(const int Value);
	void __fastcall SetItemFont(Vcl::Graphics::TFont* const aValue);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	__property System::Types::TRect UpBtnRect = {read=FUpBtnRect, write=FUpBtnRect};
	__property System::Types::TRect DnBtnRect = {read=FDnBtnRect, write=FDnBtnRect};
	int __fastcall GetItemHeight(void);
	
public:
	__fastcall virtual TLMDButtonBarSection(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDButtonBarSection(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Types::TRect ClientRect = {read=FClientRect, write=FClientRect};
	__property int ScrollPos = {read=FScrollPos, nodefault};
	__property System::Types::TRect DisplayRect = {read=FRect, write=FRect};
	__property bool Visible = {read=FVisible, write=SetBoolean, index=7, default=1};
	System::Types::TRect __fastcall GetItemSize(int index);
	__property int ItemHeight = {read=GetItemHeight, nodefault};
	__property bool MultiLine = {read=FMultiLine, write=SetBoolean, index=6, default=0};
	__property System::TObject* Objects[int Index] = {read=GetSectionObject, write=SetSectionObject};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetString, index=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=-2};
	__property System::UnicodeString Hint = {read=FHint, write=SetString, index=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property bool Enabled = {read=FEnabled, write=SetBoolean, index=0, default=1};
	__property bool UseSmallImages = {read=FUseSmallImages, write=SetBoolean, index=1, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=SetBoolean, index=2, default=0};
	__property bool ShowHint = {read=FShowHint, write=SetBoolean, index=3, default=0};
	__property bool ParentFont = {read=FParentFont, write=SetBoolean, index=4, default=1};
	__property bool ItemParentFont = {read=FItemParentFont, write=SetBoolean, index=8, default=1};
	__property bool TransparentGlyphs = {read=FTransparentGlyphs, write=SetBoolean, index=5, default=1};
	__property TLMDItemOrientation ItemOrientation = {read=FItemOrientation, write=SetItemOrientation, default=2};
	__property Vcl::Graphics::TFont* ItemFont = {read=FItemFont, write=SetItemFont, stored=isItemFontStored};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Layout = {read=FLayout, write=SetLayout};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=isFontStored};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property int BtnMinHeight = {read=FBtnMinHeight, nodefault};
	__property int ListIndex = {read=FListIndex, write=SetListIndex, nodefault};
	__property Index;
	__property TLMDButtonBarItems* Items = {read=FItems, write=SetItems};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDButtonBarSections : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDButtonBarSection* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDButtonBarSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDButtonBarSection* Value);
	int __fastcall GetVisibleCount(void);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TLMDButtonBarSection* __fastcall Add(void);
	int __fastcall VisibleUpTo(int index);
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
	__property TLMDButtonBarSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDButtonBarSections(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDButtonBarSections(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDButtonBarStoreComp : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TLMDButtonBarSections* FSectionsButtons;
	void __fastcall SetSectionBtns(TLMDButtonBarSections* aValue);
	
public:
	__fastcall virtual TLMDButtonBarStoreComp(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDButtonBarStoreComp(void);
	
__published:
	__property TLMDButtonBarSections* Sections = {read=FSectionsButtons, write=SetSectionBtns};
};


typedef void __fastcall (__closure *TLMDButtonBarDragDropEvent)(System::TObject* Sender, System::TObject* Source, int X, int Y, int Section, int Item);

typedef void __fastcall (__closure *TLMDButtonBarDragOverEvent)(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept, int Section, int Item);

typedef void __fastcall (__closure *TLMDButtonBarOnBeforeItemClick)(System::TObject* Sender, int Section, int Item, bool &allowClick);

typedef void __fastcall (__closure *TLMDButtonBarOnItemClick)(System::TObject* Sender, int Section, int Item);

typedef void __fastcall (__closure *TLMDButtonBarBeforeSectionChange)(System::TObject* Sender, int CurrentSection, int NewSection, bool &allowExit);

typedef void __fastcall (__closure *TLMDButtonBarSectionChange)(System::TObject* Sender, int CurrentSection, int NewSection);

typedef void __fastcall (__closure *TLMDButtonBarSectionChanged)(System::TObject* Sender, int CurrentSection, int OldSection);

typedef void __fastcall (__closure *TLMDMouseItem)(System::TObject* Sender, int Item);

typedef void __fastcall (__closure *TLMDButtonBarGetItemSettings)(System::TObject* Sender, int Section, int Item, Vcl::Graphics::TFont* Font, Lmd3dcaption::TLMD3DCaption* Font3D, System::UnicodeString &caption);

enum DECLSPEC_DENUM TLMDButtonBarFocusStyle : unsigned char { bfGlyph, bfText, bfGlyphText };

typedef void __fastcall (__closure *TLMDButtonBarGetSectionFileName)(System::TObject* Sender, System::UnicodeString &s);

enum DECLSPEC_DENUM TLMDBBIniSaveOption : unsigned char { ssSectionName, ssSectionListIndex, ssIconState, ssItemNames, ssItemImageIndex, ssSectionScrollPos, ssSectionHint, ssSectionOpen, ssItemHint, ssItemEnabled };

typedef System::Set<TLMDBBIniSaveOption, TLMDBBIniSaveOption::ssSectionName, TLMDBBIniSaveOption::ssItemEnabled> TLMDBBIniSaveOptions;

enum DECLSPEC_DENUM TLMDButtonBarOrientation : unsigned char { bbHorizontal, bbVertical };

class PASCALIMPLEMENTATION TLMDButtonBar : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdclass::TLMDTimer* FTimerId;
	int FScrollDelay;
	int FScrollStep;
	int FDragItemSection;
	int FDragItemIndex;
	int FLargeItemHeight;
	int FSmallItemHeight;
	int FOldMouseOverSectionButton;
	int FOldMouseOverItem;
	int FSelectedItem;
	int FSectionButtonDown;
	int FOldBarPos;
	int FSectionHeight;
	int FSectionLeft;
	int FSectionRight;
	int FLastOpen;
	int FOpen;
	TLMDButtonBarSections* FSections;
	Vcl::Imglist::TCustomImageList* FLargeImageList;
	Vcl::Imglist::TCustomImageList* FSmallImageList;
	Vcl::Imglist::TChangeLink* FLargeChangeLink;
	Vcl::Imglist::TChangeLink* FSmallChangeLink;
	System::Uitypes::TColor FSelectedColor;
	bool FSaveAndRestore;
	bool FFillHighlightedItem;
	bool FUpBtnClicked;
	bool FDnBtnClicked;
	bool FUpBtnActClicked;
	bool FDnBtnActClicked;
	bool FUpRgnClicked;
	bool FDnRgnClicked;
	bool FReadOnly;
	bool FSingleSectionMode;
	bool FUseBitmap;
	bool FTransBtns;
	bool FSoftScroll;
	bool FMouseDown;
	System::UnicodeString FIniSection;
	System::UnicodeString FIniKey;
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	TLMDBBIniSaveOptions FIniSaveOptions;
	Lmdinictrl::TLMDIniUse FIniUse;
	Vcl::Stdctrls::TEdit* FEdit;
	System::Classes::TPersistent* FEditObject;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	System::Types::TPoint FLastMousePos;
	TLMDButtonBarFocusStyle FFocusStyle;
	System::Types::TPoint FMouseClickPos;
	TLMDButtonBarOrientation FOrientation;
	TLMDButtonBarBeforeSectionChange FOnBeforeSectionChange;
	TLMDButtonBarOnItemClick FOnItemClick;
	TLMDButtonBarOnBeforeItemClick FOnBefItemClick;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniReadData;
	Lmdinictrl::TLMDIniCtrlEvent FOnIniWriteData;
	TLMDButtonBarGetSectionFileName FOnGetSectionStoreFilename;
	TLMDButtonBarSectionChanged FOnSectionChanged;
	TLMDButtonBarSectionChange FOnSectionChange;
	TLMDButtonBarDragOverEvent FOnDragOver;
	TLMDButtonBarDragDropEvent FOnDragDrop;
	TLMDMouseItem FOnMouseExitItem;
	TLMDMouseItem FOnMouseEnterItem;
	TLMDButtonBarGetItemSettings FOnGetItemSet;
	bool FUseGlobalTimer;
	void __fastcall SetSections(TLMDButtonBarSections* aValue);
	void __fastcall SetInteger(int index, int aValue);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	void __fastcall SetOrientation(TLMDButtonBarOrientation aValue);
	void __fastcall SetLargeImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetSmallImageList(Vcl::Imglist::TCustomImageList* aValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall ReadIdent1(System::Classes::TReader* Reader);
	void __fastcall WriteIdent1(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont1(void);
	bool __fastcall HasControl1(void);
	void __fastcall ReadIdent2(System::Classes::TReader* Reader);
	void __fastcall WriteIdent2(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont2(void);
	bool __fastcall HasControl2(void);
	bool __fastcall SaveIniKey(void);
	bool __fastcall SaveIniSection(void);
	void __fastcall SetSectionLeft(const int Value);
	void __fastcall SetSectionRight(const int Value);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* aControl, System::Types::TRect &Rect);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DoIniLoadSections(void);
	DYNAMIC void __fastcall DoIniStoreSections(void);
	virtual void __fastcall DoSectionChange(int aValue);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall LoadSections(void);
	void __fastcall StoreSections(void);
	void __fastcall PaintItem(int ItemNr, bool restore, Vcl::Graphics::TCanvas* aCanvas, bool tryRestore);
	void __fastcall ScrollBtnsVisible(Vcl::Graphics::TCanvas* aCanvas, System::Byte res);
	void __fastcall paintBar(int ItemNr, Vcl::Graphics::TCanvas* aCanvas);
	void __fastcall delBar(int ItemNr);
	void __fastcall StartRepeatedClick(bool upClick);
	void __fastcall EndRepeatedClick(void);
	void __fastcall DoOnEditExit(System::TObject* Sender);
	void __fastcall DoOnEditKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DoOnScrollBtnUp(System::TObject* Sender);
	void __fastcall DoOnScrollBtnDown(System::TObject* Sender);
	bool __fastcall isEditing(void);
	void __fastcall EnterEditMode(System::Classes::TPersistent* aValue);
	void __fastcall CancelEditMode(void);
	int __fastcall mouseOverSection(const System::Types::TPoint &XY);
	int __fastcall mouseOverItem(const System::Types::TPoint &XY);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	int __fastcall GetSectionItemSpaceNeeded(void);
	int __fastcall GetSectionItemSpaceExist(void);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	
public:
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	void __fastcall DrawButton(int index, Vcl::Graphics::TCanvas* aCanvas);
	void __fastcall PaintSectionItems(bool restore, Vcl::Graphics::TCanvas* aCanvas, bool aOwnBmp);
	__fastcall virtual TLMDButtonBar(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDButtonBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall LoadSectionsFromStream(System::Classes::TStream* stream);
	void __fastcall StoreSectionsToStream(System::Classes::TStream* stream);
	void __fastcall LoadSectionsFromFile(System::UnicodeString filename);
	void __fastcall StoreSectionsToFile(System::UnicodeString filename);
	void __fastcall AddSection(void);
	void __fastcall AddNamedSection(System::UnicodeString aString);
	void __fastcall DelSection(void);
	void __fastcall RemoveSection(int index);
	void __fastcall RenSection(int Index = 0xffffffff);
	void __fastcall RenSectionTo(System::UnicodeString aString);
	TLMDButtonBarItem* __fastcall AddItem(void);
	TLMDButtonBarItem* __fastcall AddNamedItem(System::UnicodeString aString);
	TLMDButtonBarItem* __fastcall AddNamedItemToSection(int SecNr, System::UnicodeString aString);
	void __fastcall DelItem(void);
	void __fastcall RenItem(void);
	void __fastcall RenItemTo(System::UnicodeString aString);
	int __fastcall NextSection(void);
	int __fastcall PrevSection(void);
	__property CtlXP = {default=0};
	__property int Open = {read=FOpen, write=SetInteger, index=0, nodefault};
	__property int SelectedItem = {read=FSelectedItem, write=SetInteger, index=1, nodefault};
	__property int HighlightedItem = {read=FOldMouseOverItem, nodefault};
	__property int OldBarPos = {read=FOldBarPos, write=SetInteger, index=2, nodefault};
	__property DockManager;
	
__published:
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property FaceController;
	__property Bevel;
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property System::Uitypes::TColor FillSelectedColor = {read=FSelectedColor, write=FSelectedColor, default=12632256};
	__property int FixedSectionLeftBorder = {read=FSectionLeft, write=SetSectionLeft, default=20};
	__property int FixedSectionRightBorder = {read=FSectionRight, write=SetSectionRight, default=20};
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property System::UnicodeString IniKey = {read=FIniKey, write=FIniKey, stored=SaveIniKey};
	__property System::UnicodeString IniSection = {read=FIniSection, write=FIniSection, stored=SaveIniSection};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property TLMDBBIniSaveOptions IniSaveOptions = {read=FIniSaveOptions, write=FIniSaveOptions, default=31};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property int ScrollDelay = {read=FScrollDelay, write=SetInteger, index=3, default=50};
	__property int ScrollStep = {read=FScrollStep, write=SetInteger, index=6, default=-1};
	__property int SmallItemHeight = {read=FSmallItemHeight, write=SetInteger, index=4, default=24};
	__property int LargeItemHeight = {read=FLargeItemHeight, write=SetInteger, index=5, default=60};
	__property Vcl::Imglist::TCustomImageList* LargeImageList = {read=FLargeImageList, write=SetLargeImageList, stored=HasControl1};
	__property Vcl::Imglist::TCustomImageList* SmallImageList = {read=FSmallImageList, write=SetSmallImageList, stored=HasControl2};
	__property TLMDButtonBarOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int SectionBtnSize = {read=FSectionHeight, write=SetInteger, index=7, default=20};
	__property ParentFont = {default=1};
	__property PopupMenu;
	__property TLMDButtonBarSections* Sections = {read=FSections, write=SetSections};
	__property FillObject;
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property bool TransparentButtons = {read=FTransBtns, write=SetBoolean, index=1, default=0};
	__property bool SingleSectionMode = {read=FSingleSectionMode, write=SetBoolean, index=2, default=0};
	__property bool FillSelectedItem = {read=FFillHighlightedItem, write=FFillHighlightedItem, index=3, default=1};
	__property bool SoftScroll = {read=FSoftScroll, write=FSoftScroll, default=1};
	__property bool SaveAndRestore = {read=FSaveAndRestore, write=FSaveAndRestore, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property TLMDButtonBarFocusStyle FocusStyle = {read=FFocusStyle, write=FFocusStyle, default=2};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property TLMDButtonBarBeforeSectionChange OnBeforeSectionChange = {read=FOnBeforeSectionChange, write=FOnBeforeSectionChange};
	__property TLMDButtonBarOnBeforeItemClick OnBeforeItemClick = {read=FOnBefItemClick, write=FOnBefItemClick};
	__property TLMDButtonBarOnItemClick OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TLMDButtonBarGetSectionFileName OnGetSectionStoreFilename = {read=FOnGetSectionStoreFilename, write=FOnGetSectionStoreFilename};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniReadData = {read=FOnIniReadData, write=FOnIniReadData};
	__property Lmdinictrl::TLMDIniCtrlEvent OnIniWriteData = {read=FOnIniWriteData, write=FOnIniWriteData};
	__property TLMDButtonBarSectionChange OnSectionChange = {read=FOnSectionChange, write=FOnSectionChange};
	__property TLMDButtonBarSectionChanged OnSectionChanged = {read=FOnSectionChanged, write=FOnSectionChanged};
	__property TLMDMouseItem OnMouseEnterItem = {read=FOnMouseEnterItem, write=FOnMouseEnterItem};
	__property TLMDMouseItem OnMouseExitItem = {read=FOnMouseExitItem, write=FOnMouseExitItem};
	__property TLMDButtonBarGetItemSettings OnGetItemSettings = {read=FOnGetItemSet, write=FOnGetItemSet};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseExit;
	__property OnMouseEnter;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnDragOver;
	__property OnClick;
	__property OnDblClick;
	__property OnResize;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButtonBar(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString IDS_BUTTONBARSAVE;
}	/* namespace Lmdbuttonbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONBAR)
using namespace Lmdbuttonbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonbarHPP
