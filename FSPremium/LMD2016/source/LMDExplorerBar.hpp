// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExplorerBar.pas' rev: 31.00 (Windows)

#ifndef LmdexplorerbarHPP
#define LmdexplorerbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <LMDBarConsts.hpp>
#include <LMDBarBase.hpp>
#include <LMDClass.hpp>
#include <LMDControl.hpp>
#include <LMDBarHTMLLabel.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Actions.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdexplorerbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExplorerBarLabel;
struct TLMDBarPaintInfo;
struct TLMDBarDrawInfo;
class DELPHICLASS TLMDExplorerBarController;
class DELPHICLASS TLMDExplorerBarBasePanel;
class DELPHICLASS TLMDExplorerBarPanel;
class DELPHICLASS TLMDExplorerBarActionLink;
class DELPHICLASS TLMDExplorerBarItem;
class DELPHICLASS TLMDExplorerBarItems;
class DELPHICLASS TLMDExplorerBarSection;
class DELPHICLASS TLMDExplorerBarSections;
class DELPHICLASS TLMDExplorerBarStorage;
class DELPHICLASS TLMDExplorerBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExplorerBarLabel : public Lmdbarhtmllabel::TLMDBarHTMLLabel
{
	typedef Lmdbarhtmllabel::TLMDBarHTMLLabel inherited;
	
private:
	TLMDExplorerBarSection* FSection;
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDExplorerBarLabel(System::Classes::TComponent* AOwner);
public:
	/* TLMDBarHTMLLabel.Destroy */ inline __fastcall virtual ~TLMDExplorerBarLabel(void) { }
	
};


enum DECLSPEC_DENUM TLMDExplorerBarStyle : unsigned char { ebsItemList, ebsInformation, ebsContainer, ebsOwnerDraw };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDBarPaintInfo
{
public:
	TLMDExplorerBar* ExplorerBar;
	NativeUInt Handle;
	Vcl::Graphics::TCanvas* Canvas;
	System::Types::TRect Rect;
	bool UseXP;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDBarDrawInfo
{
public:
	TLMDBarPaintInfo PaintInfo;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TLMDBarHeaderState : unsigned char { bhsNormal, bhsHighlight, bhsPressed };

enum DECLSPEC_DENUM TLMDBarHeaderStyle : unsigned char { bhsRounded, bhsRect };

typedef void __fastcall (__closure *TLMDBarMeasureHeightEvent)(TLMDExplorerBarSection* Sender, int &Height);

typedef void __fastcall (__closure *TLMDBarDrawInfoEvent)(TLMDExplorerBarSection* Sender, const TLMDBarDrawInfo &DrawInfo);

typedef int __fastcall (__closure *TLMDBarSortEvent)(TLMDExplorerBarSection* Sender, TLMDExplorerBarItem* First, TLMDExplorerBarItem* Second);

class PASCALIMPLEMENTATION TLMDExplorerBarController : public Lmdbarbase::TLMDBarController
{
	typedef Lmdbarbase::TLMDBarController inherited;
	
private:
	bool FCtlXP;
	int FSectionsSpace;
	int FVSpace;
	int FHSpace;
	Vcl::Graphics::TBitmap* FExpandGlyph;
	Vcl::Graphics::TBitmap* FCollapseGlyph;
	System::Uitypes::TColor FItemsHightlightColor;
	System::Uitypes::TColor FHeaderStartColor;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FItemsColor;
	System::Uitypes::TColor FSectionBackColor;
	System::Uitypes::TColor FItemsDisableColor;
	System::Uitypes::TColor FHeaderEndColor;
	System::Uitypes::TColor FHightlightColor;
	Vcl::Graphics::TFont* FHeaderFont;
	TLMDBarHeaderStyle FHeaderStyle;
	void __fastcall SetCollapseGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetCtlXP(const bool Value);
	void __fastcall SetExpandGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetHeaderEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeaderFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetHeaderStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeaderStyle(const TLMDBarHeaderStyle Value);
	void __fastcall SetHightlightColor(const System::Uitypes::TColor Value);
	void __fastcall SetHSpace(const int Value);
	void __fastcall SetItemsColor(const System::Uitypes::TColor Value);
	void __fastcall SetItemsDisableColor(const System::Uitypes::TColor Value);
	void __fastcall SetItemsHightlightColor(const System::Uitypes::TColor Value);
	void __fastcall SetSectionBackColor(const System::Uitypes::TColor Value);
	void __fastcall SetSectionsSpace(const int Value);
	void __fastcall SetVSpace(const int Value);
	
protected:
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDExplorerBarController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDExplorerBarController(void);
	void __fastcall UpdateParent(void);
	
__published:
	__property TLMDBarHeaderStyle HeaderStyle = {read=FHeaderStyle, write=SetHeaderStyle, default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=14585452};
	__property System::Uitypes::TColor HeaderStartColor = {read=FHeaderStartColor, write=SetHeaderStartColor, default=16777215};
	__property System::Uitypes::TColor HeaderEndColor = {read=FHeaderEndColor, write=SetHeaderEndColor, default=16242384};
	__property System::Uitypes::TColor ItemsColor = {read=FItemsColor, write=SetItemsColor, default=12997202};
	__property System::Uitypes::TColor ItemsHightlightColor = {read=FItemsHightlightColor, write=SetItemsHightlightColor, default=14585452};
	__property System::Uitypes::TColor ItemsDisableColor = {read=FItemsDisableColor, write=SetItemsDisableColor, default=16690860};
	__property System::Uitypes::TColor SectionBackColor = {read=FSectionBackColor, write=SetSectionBackColor, default=16244694};
	__property System::Uitypes::TColor HightlightColor = {read=FHightlightColor, write=SetHightlightColor, default=14585452};
	__property Vcl::Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property Vcl::Graphics::TBitmap* CollapseGlyph = {read=FCollapseGlyph, write=SetCollapseGlyph};
	__property Vcl::Graphics::TBitmap* ExpandGlyph = {read=FExpandGlyph, write=SetExpandGlyph};
	__property bool CtlXP = {read=FCtlXP, write=SetCtlXP, default=1};
	__property int VSpace = {read=FVSpace, write=SetVSpace, default=10};
	__property int HSpace = {read=FHSpace, write=SetHSpace, default=10};
	__property int SectionsSpace = {read=FSectionsSpace, write=SetSectionsSpace, default=15};
};


class PASCALIMPLEMENTATION TLMDExplorerBarBasePanel : public Lmdcontrol::TLMDBaseCustomControl
{
	typedef Lmdcontrol::TLMDBaseCustomControl inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
public:
	/* TLMDBaseCustomControl.Create */ inline __fastcall virtual TLMDExplorerBarBasePanel(System::Classes::TComponent* AOwner) : Lmdcontrol::TLMDBaseCustomControl(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TLMDExplorerBarBasePanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExplorerBarBasePanel(HWND ParentWindow) : Lmdcontrol::TLMDBaseCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDExplorerBarPanel : public TLMDExplorerBarBasePanel
{
	typedef TLMDExplorerBarBasePanel inherited;
	
protected:
	TLMDExplorerBarSection* Section;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDExplorerBarPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDExplorerBarPanel(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExplorerBarPanel(HWND ParentWindow) : TLMDExplorerBarBasePanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDExplorerBarActionLink : public Vcl::Actnlist::TActionLink
{
	typedef Vcl::Actnlist::TActionLink inherited;
	
protected:
	TLMDExplorerBarItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const System::UnicodeString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(System::Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TLMDExplorerBarActionLink(System::TObject* AClient) : Vcl::Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TLMDExplorerBarActionLink(void) { }
	
};


typedef System::TMetaClass* TLMDExplorerBarActionLinkClass;

typedef void __fastcall (__closure *TLMDExplorerBarOnGetItemSettings)(System::TObject* Sender, TLMDExplorerBarSection* Section, TLMDExplorerBarItem* Item, Vcl::Graphics::TFont* Font, System::UnicodeString &Caption);

class PASCALIMPLEMENTATION TLMDExplorerBarItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDExplorerBarActionLink* FActionLink;
	bool FCaptionLong;
	bool FVisible;
	bool FEnabled;
	int FTag;
	int FImageIndex;
	void *FData;
	System::UnicodeString FCaption;
	System::UnicodeString FHint;
	System::Classes::TNotifyEvent FOnMouseExit;
	TLMDExplorerBarOnGetItemSettings FOnGetItemSettings;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnClick;
	void __fastcall DoActionChange(System::TObject* Sender);
	System::Classes::TBasicAction* __fastcall GetAction(void);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsOnClickStored(void);
	bool __fastcall IsVisibleStored(void);
	void __fastcall SetAction(System::Classes::TBasicAction* const Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	HIDESBASE virtual void __fastcall Changed(void);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseExit(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	DYNAMIC TLMDExplorerBarActionLinkClass __fastcall GetActionLinkClass(void);
	void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDExplorerBarItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDExplorerBarItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall InitiateAction(void);
	__property void * Data = {read=FData, write=FData};
	__property bool IsLongCaption = {read=FCaptionLong, nodefault};
	__property TLMDExplorerBarActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
__published:
	__property System::Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, stored=IsVisibleStored, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, nodefault};
	__property Index;
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
	__property TLMDExplorerBarOnGetItemSettings OnGetItemSettings = {read=FOnGetItemSettings, write=FOnGetItemSettings};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseExit = {read=FOnMouseExit, write=FOnMouseExit};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExplorerBarItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDExplorerBarItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	bool FSorting;
	TLMDExplorerBarItem* __fastcall GetItems(int Index);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDExplorerBarItems(TLMDExplorerBarSection* Owner);
	HIDESBASE TLMDExplorerBarItem* __fastcall Add(void);
	void __fastcall InitiateActions(void);
	__property TLMDExplorerBarItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDExplorerBarItems(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDExplorerBarBeforeSectionChange)(System::TObject* Sender, bool &allowChange);

class PASCALIMPLEMENTATION TLMDExplorerBarSection : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Imglist::TChangeLink* FChangeLink;
	TLMDExplorerBarItems* FItems;
	bool FVisible;
	bool FExpanded;
	System::UnicodeString FCaption;
	TLMDExplorerBarStyle FStyle;
	bool FParentFont;
	bool FVertScrollBar;
	bool FSorted;
	int FHeight;
	System::UnicodeString FHint;
	Vcl::Graphics::TFont* FFont;
	Vcl::Controls::TImageList* FImageList;
	bool FParentShowHint;
	bool FShowHint;
	TLMDBarMeasureHeightEvent FOnMeasureHeight;
	TLMDBarDrawInfoEvent FOnDrawInfo;
	TLMDBarSortEvent FOnSort;
	System::Classes::TNotifyEvent FOnExpand;
	int FHeaderSize;
	int FItemsVSpace;
	int FItemsHSpace;
	System::Classes::TNotifyEvent FOnCollapse;
	TLMDExplorerBarPanel* FPanel;
	Vcl::Stdctrls::TScrollBar* FScrollBar;
	System::Classes::TNotifyEvent FOnScrollChange;
	Vcl::Stdctrls::TScrollEvent FOnScroll;
	Vcl::Controls::TAlign FLinkedControlAlign;
	Vcl::Controls::TControl* FLinkedControl;
	int FLinkedControlLeft;
	int FLinkedControlTop;
	System::UnicodeString FInformation;
	System::UnicodeString FName;
	int FMargin;
	int FLineGap;
	TLMDExplorerBarItem* FHotItem;
	Vcl::Graphics::TFont* FCurrentItemFont;
	TLMDExplorerBarBeforeSectionChange FOnBeforeCollapse;
	TLMDExplorerBarBeforeSectionChange FOnBeforeExpand;
	void __fastcall SetItems(TLMDExplorerBarItems* const Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetStyle(const TLMDExplorerBarStyle Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetImageList(Vcl::Controls::TImageList* const Value);
	void __fastcall SetParentFont(const bool Value);
	void __fastcall SetSorted(const bool Value);
	void __fastcall SetVertScrollBar(const bool Value);
	void __fastcall ChangeBitmap(System::TObject* Sender);
	void __fastcall SetHeaderSize(const int Value);
	void __fastcall SetItemsHSpace(const int Value);
	void __fastcall SetItemsVSpace(const int Value);
	void __fastcall SetPanel(TLMDExplorerBarPanel* const Value);
	void __fastcall SetScrollBar(Vcl::Stdctrls::TScrollBar* const Value);
	void __fastcall SetLinkedControl(Vcl::Controls::TControl* const Value);
	void __fastcall SetLinkedControlAlign(const Vcl::Controls::TAlign Value);
	void __fastcall SetLinkedControlLeft(const int Value);
	void __fastcall SetLinkedControlTop(const int Value);
	bool __fastcall CheckDesignTime(void);
	void __fastcall SetInformation(const System::UnicodeString Value);
	void __fastcall SetName(const System::UnicodeString Value);
	bool __fastcall IsCustomFont(void);
	
protected:
	int iLeft;
	int iTop;
	int iWidth;
	int iHeight;
	bool FUseScroll;
	int FScrollPos;
	TLMDExplorerBar* FExplorerBar;
	TLMDBarHeaderState FHeaderState;
	System::Types::TRect FHeaderRect;
	TLMDExplorerBarItem* FPressedItem;
	bool FAnimating;
	int FAnimateStage;
	int FAnimateStep;
	int FAnimateMax;
	Vcl::Graphics::TBitmap* FAnimateBmp;
	TLMDExplorerBarLabel* FLMDTextLabel;
	void __fastcall SetHotItem(TLMDExplorerBarItem* Item);
	void __fastcall SetMargin(const int value);
	void __fastcall SetInfoLineGap(const int value);
	virtual void __fastcall StartAnimate(void);
	virtual void __fastcall StopAnimate(void);
	int __fastcall GetSectionHeight(Vcl::Graphics::TCanvas* Canvas);
	int __fastcall GetItemHeight(Vcl::Graphics::TCanvas* Canvas);
	int __fastcall GetDefSectionItemsHeight(Vcl::Graphics::TCanvas* Canvas);
	int __fastcall GetHeaderHeight(Vcl::Graphics::TCanvas* Canvas);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseEnter(Vcl::Controls::TControl* AControl);
	DYNAMIC void __fastcall MouseLeave(Vcl::Controls::TControl* AControl);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Activate(TLMDExplorerBar* ExplorerBar);
	virtual void __fastcall Deactivate(TLMDExplorerBar* ExplorerBar);
	bool __fastcall CheckPointInHeader(int X, int Y);
	void __fastcall SetMainCursor(System::Uitypes::TCursor Cursor);
	void __fastcall CaptureMouse(void);
	void __fastcall ReleaseMouse(void);
	virtual void __fastcall SectionChanged(System::TObject* Sender = (System::TObject*)(0x0));
	System::Classes::TComponent* __fastcall GetControlOwner(void);
	TLMDExplorerBarItem* __fastcall GetItemAt(Vcl::Graphics::TCanvas* Canvas, int X, int Y);
	virtual int __fastcall ItemsCompare(TLMDExplorerBarItem* First, TLMDExplorerBarItem* Second);
	void __fastcall QuickSort(int L, int R);
	virtual void __fastcall ReSort(void);
	virtual void __fastcall FireClick(void);
	virtual void __fastcall Paint(TLMDBarPaintInfo &PaintInfo);
	virtual void __fastcall PaintHeader(TLMDBarPaintInfo &PaintInfo, TLMDBarHeaderState State);
	virtual void __fastcall PaintBackground(TLMDBarPaintInfo &PaintInfo);
	virtual void __fastcall PaintItems(TLMDBarPaintInfo &PaintInfo, bool bPaintPanel);
	virtual void __fastcall PaintInside(TLMDBarPaintInfo &PaintInfo);
	void __fastcall Repaint(void);
	void __fastcall ScrollChangeEvent(System::TObject* Sender);
	void __fastcall ScrollEvent(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall UpdateHint(System::UnicodeString szHint);
	void __fastcall CancelHint(void);
	void __fastcall UpdateScroll(int Height = 0xffffffff);
	void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Loaded(void);
	void __fastcall UpdateLinkedControl(void);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	bool __fastcall GetShowHintState(void);
	
public:
	__fastcall virtual TLMDExplorerBarSection(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDExplorerBarSection(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SetSize(int Left, int Top, int Width, int Height);
	__property TLMDExplorerBarItem* HotItem = {read=FHotItem};
	__property TLMDExplorerBarPanel* Panel = {read=FPanel, write=SetPanel};
	__property Vcl::Stdctrls::TScrollBar* ScrollBar = {read=FScrollBar, write=SetScrollBar};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TLMDExplorerBarStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property TLMDExplorerBarItems* Items = {read=FItems, write=SetItems};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=0};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property bool VertScrollBar = {read=FVertScrollBar, write=SetVertScrollBar, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsCustomFont};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, default=0};
	__property bool ParentShowHint = {read=FParentShowHint, write=FParentShowHint, default=1};
	__property Vcl::Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property int HeaderSize = {read=FHeaderSize, write=SetHeaderSize, default=0};
	__property int ItemsHSpace = {read=FItemsHSpace, write=SetItemsHSpace, default=15};
	__property int ItemsVSpace = {read=FItemsVSpace, write=SetItemsVSpace, default=15};
	__property int Margin = {read=FMargin, write=SetMargin, default=1};
	__property int InfoLineGap = {read=FLineGap, write=SetInfoLineGap, default=0};
	__property Vcl::Controls::TControl* LinkedControl = {read=FLinkedControl, write=SetLinkedControl};
	__property Vcl::Controls::TAlign LinkedControlAlign = {read=FLinkedControlAlign, write=SetLinkedControlAlign, default=5};
	__property int LinkedControlLeft = {read=FLinkedControlLeft, write=SetLinkedControlLeft, nodefault};
	__property int LinkedControlTop = {read=FLinkedControlTop, write=SetLinkedControlTop, nodefault};
	__property System::UnicodeString Information = {read=FInformation, write=SetInformation};
	__property TLMDExplorerBarBeforeSectionChange OnBeforeCollapse = {read=FOnBeforeCollapse, write=FOnBeforeCollapse};
	__property TLMDExplorerBarBeforeSectionChange OnBeforeExpand = {read=FOnBeforeExpand, write=FOnBeforeExpand};
	__property TLMDBarMeasureHeightEvent OnMeasureHeight = {read=FOnMeasureHeight, write=FOnMeasureHeight};
	__property System::Classes::TNotifyEvent OnExpand = {read=FOnExpand, write=FOnExpand};
	__property System::Classes::TNotifyEvent OnCollapse = {read=FOnCollapse, write=FOnCollapse};
	__property TLMDBarSortEvent OnSort = {read=FOnSort, write=FOnSort};
	__property TLMDBarDrawInfoEvent OnDrawInfo = {read=FOnDrawInfo, write=FOnDrawInfo};
	__property System::Classes::TNotifyEvent OnScrollChange = {read=FOnScrollChange, write=FOnScrollChange};
	__property Vcl::Stdctrls::TScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExplorerBarSections : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDExplorerBarSection* operator[](int Index) { return this->Section[Index]; }
	
private:
	TLMDExplorerBarSection* __fastcall GetItems(int Index);
	TLMDExplorerBarSection* __fastcall GetItemByName(System::UnicodeString Value);
	
protected:
	TLMDExplorerBar* FExplorerBar;
	virtual void __fastcall Activate(TLMDExplorerBar* ExplorerBar);
	virtual void __fastcall Deactivate(TLMDExplorerBar* ExplorerBar);
	System::UnicodeString __fastcall ValidateName(System::UnicodeString NewName);
	System::UnicodeString __fastcall GetSectionName(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDExplorerBarSections(System::Classes::TPersistent* Owner);
	HIDESBASE TLMDExplorerBarSection* __fastcall Add(void);
	__property TLMDExplorerBarSection* Section[int Index] = {read=GetItems/*, default*/};
	__property TLMDExplorerBarSection* SectionByName[System::UnicodeString Value] = {read=GetItemByName};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDExplorerBarSections(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDExplorerBarStorage : public Lmdbarbase::TLMDBarController
{
	typedef Lmdbarbase::TLMDBarController inherited;
	
private:
	TLMDExplorerBarSections* FSections;
	void __fastcall SetSections(TLMDExplorerBarSections* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDExplorerBarStorage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDExplorerBarStorage(void);
	
__published:
	__property TLMDExplorerBarSections* Sections = {read=FSections, write=SetSections};
};


class PASCALIMPLEMENTATION TLMDExplorerBar : public TLMDExplorerBarBasePanel
{
	typedef TLMDExplorerBarBasePanel inherited;
	
private:
	TLMDExplorerBarSections* FSections;
	TLMDExplorerBarStorage* FSectionStorage;
	System::Uitypes::TColor FColor;
	bool FCtlXP;
	int FSectionsSpace;
	int FHSpace;
	int FVSpace;
	System::Uitypes::TColor FHeaderEndColor;
	System::Uitypes::TColor FSectionBackColor;
	System::Uitypes::TColor FHeaderStartColor;
	Vcl::Graphics::TBitmap* FCollapseGlyphUp;
	Vcl::Graphics::TBitmap* FCollapseGlyphDown;
	Vcl::Graphics::TFont* FHeaderFont;
	System::Uitypes::TColor FHightlightColor;
	Vcl::Graphics::TBitmap* FCollapseGlyphHot;
	Vcl::Graphics::TBitmap* FExpandGlyphHot;
	Vcl::Graphics::TBitmap* FExpandGlyphDown;
	Vcl::Graphics::TBitmap* FExpandGlyphUp;
	bool FSmoothEffect;
	Vcl::Graphics::TBitmap* FCollapseGlyph;
	Vcl::Graphics::TBitmap* FExpandGlyph;
	System::Word FHintPause;
	System::Uitypes::TColor FItemsColor;
	System::Uitypes::TColor FItemsHightlightColor;
	TLMDBarHeaderStyle FHeaderStyle;
	System::Uitypes::TColor FItemsDisableColor;
	TLMDExplorerBarController* FThemeController;
	System::Classes::TNotifyEvent FOnChange;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetSections(TLMDExplorerBarSections* const Value);
	void __fastcall SetSectionStorage(TLMDExplorerBarStorage* const Value);
	HIDESBASE void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetCtlXP(const bool Value);
	void __fastcall SetHSpace(const int Value);
	void __fastcall SetSectionsSpace(const int Value);
	void __fastcall SetVSpace(const int Value);
	void __fastcall SetHeaderEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeaderStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetSectionBackColor(const System::Uitypes::TColor Value);
	void __fastcall SetCollapseGlyphDown(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetCollapseGlyphUp(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetHeaderFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetHightlightColor(const System::Uitypes::TColor Value);
	void __fastcall SetCollapseGlyphHot(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetExpandGlyphHot(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetExpandGlyphDown(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetExpandGlyphUp(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetCollapseGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetExpandGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetItemsColor(const System::Uitypes::TColor Value);
	void __fastcall SetItemsHightlightColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeaderStyle(const TLMDBarHeaderStyle Value);
	void __fastcall SetItemsDisableColor(const System::Uitypes::TColor Value);
	void __fastcall SetThemeController(TLMDExplorerBarController* const Value);
	TLMDExplorerBarSections* __fastcall GetActiveSections(void);
	bool __fastcall GetScrollBarVisible(void);
	bool __fastcall IsNoController(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMUpdateLinkMessage(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	bool __fastcall IsCustomColor(void);
	bool __fastcall IsCustomCtlXP(void);
	bool __fastcall IsCustomHeaderEndColor(void);
	bool __fastcall IsCustomHeaderStartColor(void);
	bool __fastcall IsCustomHighlightColor(void);
	bool __fastcall IsCustomHSpace(void);
	bool __fastcall IsCustomItemsColor(void);
	bool __fastcall IsCustomItemsDisableColor(void);
	bool __fastcall IsCustomItemsHighlightColor(void);
	bool __fastcall IsCustomSectionBackColor(void);
	bool __fastcall IsCustomSectionSpace(void);
	bool __fastcall IsCustomVSpace(void);
	bool __fastcall IsCustomHeaderStyle(void);
	
protected:
	TLMDExplorerBarSection* FLastMouseMoveSection;
	TLMDExplorerBarSection* FCaptureSection;
	Vcl::Controls::THintWindow* FHintWnd;
	Vcl::Extctrls::TTimer* FHintTimer;
	int FScrollPosition;
	int FScrollSize;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall OnHintTimer(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	void __fastcall UpdateHint(System::UnicodeString szHint);
	void __fastcall CancelHint(void);
	void __fastcall StartHintTimer(int Value);
	void __fastcall StopHintTimer(void);
	void __fastcall ChangeSections(TLMDExplorerBarSections* OldS, TLMDExplorerBarSections* NewS);
	void __fastcall ClearLastMouseMoveSection(void);
	virtual void __fastcall Loaded(void);
	HIDESBASE virtual void __fastcall DoMouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE virtual void __fastcall DoMouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintBackground(TLMDBarPaintInfo &PaintInfo);
	virtual void __fastcall PaintSections(TLMDBarPaintInfo &PaintInfo);
	virtual void __fastcall CreateSectionBitmap(Vcl::Graphics::TBitmap* Bmp, TLMDExplorerBarSection* Section);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall SetImageProperties(Vcl::Graphics::TBitmap* dstBmp, Vcl::Graphics::TBitmap* srcBmp, int Index);
	virtual void __fastcall GlyphsChanged(void);
	void __fastcall UpdateSectionStorage(void);
	void __fastcall UpdateTheme(void);
	__property Vcl::Graphics::TBitmap* CollapseGlyphUp = {read=FCollapseGlyphUp, write=SetCollapseGlyphUp};
	__property Vcl::Graphics::TBitmap* CollapseGlyphHot = {read=FCollapseGlyphHot, write=SetCollapseGlyphHot};
	__property Vcl::Graphics::TBitmap* CollapseGlyphDown = {read=FCollapseGlyphDown, write=SetCollapseGlyphDown};
	__property Vcl::Graphics::TBitmap* ExpandGlyphUp = {read=FExpandGlyphUp, write=SetExpandGlyphUp};
	__property Vcl::Graphics::TBitmap* ExpandGlyphHot = {read=FExpandGlyphHot, write=SetExpandGlyphHot};
	__property Vcl::Graphics::TBitmap* ExpandGlyphDown = {read=FExpandGlyphDown, write=SetExpandGlyphDown};
	
public:
	__fastcall virtual TLMDExplorerBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDExplorerBar(void);
	void __fastcall InvalidateEx(void);
	void __fastcall InvalidateSections(void);
	virtual void __fastcall ArrangeSections(bool ShowBar = true);
	TLMDExplorerBarSection* __fastcall GetSectionByPoint(int X, int Y);
	virtual void __fastcall CollapseSection(TLMDExplorerBarSection* Section);
	virtual void __fastcall ExpandSection(TLMDExplorerBarSection* Section);
	void __fastcall ExpandAll(void);
	void __fastcall CollapseAll(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property TLMDExplorerBarSections* ActiveSections = {read=GetActiveSections};
	__property bool IsScrollBarVisible = {read=GetScrollBarVisible, nodefault};
	__property DockManager;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property PopupMenu;
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Visible = {default=1};
	__property TLMDBarHeaderStyle HeaderStyle = {read=FHeaderStyle, write=SetHeaderStyle, stored=IsCustomHeaderStyle, nodefault};
	__property bool SmoothEffect = {read=FSmoothEffect, write=FSmoothEffect, default=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, stored=IsCustomColor, nodefault};
	__property System::Uitypes::TColor HeaderStartColor = {read=FHeaderStartColor, write=SetHeaderStartColor, stored=IsCustomHeaderStartColor, nodefault};
	__property System::Uitypes::TColor HeaderEndColor = {read=FHeaderEndColor, write=SetHeaderEndColor, stored=IsCustomHeaderEndColor, nodefault};
	__property System::Uitypes::TColor ItemsColor = {read=FItemsColor, write=SetItemsColor, stored=IsCustomItemsColor, nodefault};
	__property System::Uitypes::TColor ItemsHightlightColor = {read=FItemsHightlightColor, write=SetItemsHightlightColor, stored=IsCustomItemsHighlightColor, nodefault};
	__property System::Uitypes::TColor ItemsDisableColor = {read=FItemsDisableColor, write=SetItemsDisableColor, stored=IsCustomItemsDisableColor, nodefault};
	__property System::Uitypes::TColor SectionBackColor = {read=FSectionBackColor, write=SetSectionBackColor, stored=IsCustomSectionBackColor, nodefault};
	__property System::Uitypes::TColor HightlightColor = {read=FHightlightColor, write=SetHightlightColor, stored=IsCustomHighlightColor, nodefault};
	__property Vcl::Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont, stored=IsNoController};
	__property System::Word HintPause = {read=FHintPause, write=FHintPause, default=800};
	__property Font;
	__property Vcl::Graphics::TBitmap* CollapseGlyph = {read=FCollapseGlyph, write=SetCollapseGlyph, stored=IsNoController};
	__property Vcl::Graphics::TBitmap* ExpandGlyph = {read=FExpandGlyph, write=SetExpandGlyph, stored=IsNoController};
	__property TLMDExplorerBarSections* Sections = {read=FSections, write=SetSections};
	__property TLMDExplorerBarStorage* SectionStorage = {read=FSectionStorage, write=SetSectionStorage};
	__property TLMDExplorerBarController* ThemeController = {read=FThemeController, write=SetThemeController};
	__property bool CtlXP = {read=FCtlXP, write=SetCtlXP, stored=IsCustomCtlXP, nodefault};
	__property int VSpace = {read=FVSpace, write=SetVSpace, stored=IsCustomVSpace, nodefault};
	__property int HSpace = {read=FHSpace, write=SetHSpace, stored=IsCustomHSpace, nodefault};
	__property int SectionsSpace = {read=FSectionsSpace, write=SetSectionsSpace, stored=IsCustomSectionSpace, nodefault};
	__property System::Classes::TNotifyEvent OnSectionsChange = {read=FOnChange, write=FOnChange};
	__property Anchors = {default=3};
	__property Constraints;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
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
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExplorerBar(HWND ParentWindow) : TLMDExplorerBarBasePanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdexplorerbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXPLORERBAR)
using namespace Lmdexplorerbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdexplorerbarHPP
