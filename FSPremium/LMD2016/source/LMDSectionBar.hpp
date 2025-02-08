// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSectionBar.pas' rev: 31.00 (Windows)

#ifndef LmdsectionbarHPP
#define LmdsectionbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <LMDObject.hpp>
#include <LMDBarConsts.hpp>
#include <LMDBarBase.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsectionbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSectionScrollButton;
class DELPHICLASS TLMDSectionBarActionLink;
class DELPHICLASS TLMDSectionBarItem;
class DELPHICLASS TLMDSectionBarItems;
class DELPHICLASS TLMDWinControl;
class DELPHICLASS TLMDSectionBarView;
class DELPHICLASS TLMDSectionBarTheme;
class DELPHICLASS TLMDSectionBarThemeItem;
class DELPHICLASS TLMDSectionBarThemeItems;
class DELPHICLASS TLMDSectionBarController;
class DELPHICLASS TLMDSectionBarSectionPanel;
class DELPHICLASS TLMDSectionBarSection;
class DELPHICLASS TLMDSectionBarSections;
class DELPHICLASS TLMDSectionBarStorage;
class DELPHICLASS TLMDCustomSectionBar;
class DELPHICLASS TLMDSectionBar;
class DELPHICLASS TLMDBarClearButton;
class DELPHICLASS TLMDBarSectionCaptionEdit;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSectionBarItemEventType : unsigned char { istGeneral, istItemSelect, istItemUnSelect, istItemClick, istClick };

typedef void __fastcall (__closure *TLMDSectionBarItemSelectEvent)(System::TObject* Sender, TLMDSectionBarItemEventType Reason, System::TObject* Item);

enum DECLSPEC_DENUM TLMDSectionBarSelectionStyle : unsigned char { lssFull, lssIcon, lssCaption };

class PASCALIMPLEMENTATION TLMDSectionScrollButton : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	bool Visible;
	System::Classes::TNotifyEvent OnClick;
public:
	/* TObject.Create */ inline __fastcall TLMDSectionScrollButton(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSectionScrollButton(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSectionBarActionLink : public Vcl::Actnlist::TActionLink
{
	typedef Vcl::Actnlist::TActionLink inherited;
	
protected:
	TLMDSectionBarItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const System::UnicodeString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetOnExecute(System::Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TLMDSectionBarActionLink(System::TObject* AClient) : Vcl::Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TLMDSectionBarActionLink(void) { }
	
};


typedef System::TMetaClass* TLMDSectionBarActionLinkClass;

enum DECLSPEC_DENUM TLMDSectionBarUpdateKind : unsigned char { lukAll, lukState, lukParams };

enum DECLSPEC_DENUM TLMDSectionBarViewStyle : unsigned char { lvsLargeImages, lvsSmallImages };

class PASCALIMPLEMENTATION TLMDSectionBarItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDSectionBarActionLink* FActionLink;
	System::UnicodeString FCaption;
	int FImageIndex;
	int FTag;
	void *FData;
	int FTop;
	bool FIsDown;
	bool FEnabled;
	System::UnicodeString FCustomData;
	System::UnicodeString FHint;
	bool FCaptionLong;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseExit;
	void __fastcall DoActionChange(System::TObject* Sender);
	System::Classes::TBasicAction* __fastcall GetAction(void);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsOnClickStored(void);
	void __fastcall SetAction(System::Classes::TBasicAction* const Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	TLMDSectionBarItems* __fastcall GetParent(void);
	void __fastcall SetIsDown(const bool Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall UpdateParentList(TLMDSectionBarUpdateKind Kind);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	DYNAMIC TLMDSectionBarActionLinkClass __fastcall GetActionLinkClass(void);
	void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDSectionBarItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSectionBarItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall Click(void);
	void __fastcall MakeVisible(void);
	DYNAMIC void __fastcall InitiateAction(void);
	__property bool IsLongCaption = {read=FCaptionLong, nodefault};
	__property TLMDSectionBarItems* Parent = {read=GetParent};
	__property int Top = {read=FTop, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TLMDSectionBarActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
__published:
	__property System::Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property System::UnicodeString CustomData = {read=FCustomData, write=FCustomData};
	__property bool Down = {read=FIsDown, write=SetIsDown, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, nodefault};
	__property Index;
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseExit = {read=FOnMouseExit, write=FOnMouseExit};
	__property System::Classes::TNotifyEvent OnItemUp = {read=FOnChange, write=FOnChange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSectionBarItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDSectionBarItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDSectionBarView* FList;
	TLMDSectionBarItem* __fastcall GetItems(int Index);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDSectionBarItems(System::Classes::TPersistent* aOwner, TLMDSectionBarView* aList);
	HIDESBASE TLMDSectionBarItem* __fastcall Add(void);
	void __fastcall UpdateParentList(TLMDSectionBarItem* Item, TLMDSectionBarUpdateKind Kind);
	void __fastcall InitiateActions(void);
	__property TLMDSectionBarItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDSectionBarItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWinControl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
protected:
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
public:
	/* TWinControl.Create */ inline __fastcall virtual TLMDWinControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TLMDWinControl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDWinControl(void) { }
	
};


typedef void __fastcall (__closure *TLMDOnDragOver)(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept, bool &Complete);

typedef void __fastcall (__closure *TLMDDrawListViewItem)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TLMDSectionBarItem* Item, bool &Done);

typedef void __fastcall (__closure *TLMDDrawListViewBackground)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, bool &Done);

class PASCALIMPLEMENTATION TLMDSectionBarView : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FScrolling;
	Vcl::Extctrls::TTimer* FTimer;
	int FX;
	int FY;
	int FDragPlace;
	TLMDSectionBarItem* FDownItem;
	Vcl::Controls::TWinControl* FDragTargetControl;
	System::Types::TPoint FDownPoint;
	bool IsDown;
	bool IsDraging;
	int FRectPos;
	System::Types::TRect FListRect;
	TLMDSectionBarItems* FItems;
	Vcl::Imglist::TChangeLink* FLargeChangeLink;
	Vcl::Imglist::TChangeLink* FSmallChangeLink;
	Vcl::Imglist::TCustomImageList* FSmallImages;
	bool FReadOnly;
	Vcl::Imglist::TCustomImageList* FLargeImages;
	TLMDSectionBarViewStyle FViewStyle;
	TLMDSectionBarItem* FSelected;
	bool FAllowDown;
	bool FAllowAllUp;
	TLMDOnDragOver FOnDragOver;
	Lmdbarbase::_di_TLMDBarParentControlInterface FParentInterface;
	TLMDDrawListViewBackground FOnDrawBackground;
	TLMDDrawListViewItem FOnDrawItem;
	TLMDSectionBarItemSelectEvent FOnItemSelect;
	bool __fastcall CheckDesignTime(void);
	bool __fastcall CheckMousePos(int X, int Y, bool FullRepaint = false);
	void __fastcall CheckScrollVisible(void);
	System::Types::TRect __fastcall GetCaptionRect(TLMDSectionBarItem* Item);
	System::Types::TRect __fastcall GetRawItemRect(TLMDSectionBarItem* Item);
	System::Types::TRect __fastcall GetImageRect(TLMDSectionBarItem* Item);
	TLMDSectionBarItem* __fastcall GetItemAtPos(int X, int Y);
	TLMDSectionBarItem* __fastcall GetItemAtPosInternal(int X, int Y, bool bRaw = false);
	Lmdbarbase::_di_TLMDBarParentControlInterface __fastcall GetParentInterface(void);
	TLMDSectionBarItem* __fastcall GetPressed(void);
	Vcl::Controls::TWinControl* __fastcall ValidBarParent(void);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall OnDownScrollButton(System::TObject* Sender);
	void __fastcall OnUpScrollButton(System::TObject* Sender);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall ProcessPaintMessages(void);
	void __fastcall Scroll(int iScroll, bool bAnimate = true);
	void __fastcall SetAllowAllUp(const bool Value);
	void __fastcall SetAllowDown(const bool Value);
	void __fastcall SetItems(TLMDSectionBarItems* const Value);
	void __fastcall SetLargeImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetSmallImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetViewStyle(const TLMDSectionBarViewStyle Value);
	void __fastcall UpdateItems(TLMDSectionBarItem* Item, TLMDSectionBarUpdateKind Kind);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	void __fastcall SetPressed(TLMDSectionBarItem* const Value);
	
protected:
	virtual bool __fastcall CanDropItem(int X, int Y);
	void __fastcall CheckDownItem(TLMDSectionBarItem* Item);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DoItemClick(void);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	virtual void __fastcall DoSelect(void);
	void __fastcall DoSelectItem(TLMDSectionBarItem* Item);
	void __fastcall DoUnSelectItem(TLMDSectionBarItem* Item);
	void __fastcall DoUnPressItem(TLMDSectionBarItem* Item);
	bool __fastcall DragNotifyControl(Vcl::Controls::TWinControl* Control, int X, int Y);
	void __fastcall DragMove(int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	virtual void __fastcall DrawBackground(void);
	virtual void __fastcall DrawItem(TLMDSectionBarItem* Item);
	void __fastcall DrawSelectedFrame(TLMDSectionBarItem* Item, System::Uitypes::TColor Color1, System::Uitypes::TColor Color2);
	bool __fastcall GetDropPosition(int X, int Y, int &iPos, System::Types::TRect &Rect);
	virtual Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	virtual System::Types::TRect __fastcall GetItemRect(TLMDSectionBarItem* Item);
	virtual int __fastcall GetItemsHeight(void);
	int __fastcall GetScrollChange(bool bUp);
	System::Types::TRect __fastcall GrowItemRect(TLMDSectionBarItem* Item);
	void __fastcall InvalidateDragPlace(void);
	virtual void __fastcall MinimumUpdate(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual HRGN __fastcall SetClip(void);
	void __fastcall SelectItemImmediatly(TLMDSectionBarItem* Item, bool IsDown);
	void __fastcall SendMessageToParent(unsigned Msg, int WParam, int LParam);
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, nodefault};
	
public:
	TLMDSectionScrollButton* FScrollUpBtn;
	TLMDSectionScrollButton* FScrollDownBtn;
	__fastcall TLMDSectionBarView(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDSectionBarView(void);
	void __fastcall SetParentInterface(Lmdbarbase::_di_TLMDBarParentControlInterface Intf);
	bool __fastcall CheckUpdate(void);
	bool __fastcall IsItemVisible(TLMDSectionBarItem* Item);
	virtual void __fastcall DrawItems(void);
	virtual void __fastcall RealignItems(void);
	void __fastcall ScrollInView(TLMDSectionBarItem* Item);
	__property bool AllowDown = {read=FAllowDown, write=SetAllowDown, nodefault};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=GetImageList};
	__property System::Types::TRect ImageRect[TLMDSectionBarItem* Item] = {read=GetImageRect};
	__property TLMDSectionBarItem* ItemAtPos[int X][int Y] = {read=GetItemAtPos};
	__property int ItemHeight = {read=GetItemsHeight, nodefault};
	__property System::Types::TRect ItemRect[TLMDSectionBarItem* Item] = {read=GetItemRect};
	__property TLMDSectionBarItems* Items = {read=FItems, write=SetItems};
	__property Font;
	__property System::Types::TRect CaptionRect[TLMDSectionBarItem* Item] = {read=GetCaptionRect};
	__property System::Types::TRect RawItemRect[TLMDSectionBarItem* Item] = {read=GetRawItemRect};
	__property TLMDSectionBarItemSelectEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TLMDOnDragOver OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property OnDragDrop;
	__property TLMDDrawListViewBackground OnDrawBackground = {read=FOnDrawBackground, write=FOnDrawBackground};
	__property TLMDDrawListViewItem OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TLMDSectionBarItem* Pressed = {read=GetPressed, write=SetPressed};
	__property TLMDSectionBarItem* Selected = {read=FSelected};
	__property Vcl::Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
	__property TLMDSectionBarViewStyle ViewStyle = {read=FViewStyle, write=SetViewStyle, nodefault};
	__property Vcl::Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSectionBarView(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDSectionBarChangeEvent)(System::TObject* Sender, int Index);

typedef void __fastcall (__closure *TLMDSectionBarEditChangingEvent)(System::TObject* Sender, int Index, const Vcl::Controls::TCaption NewCaption, bool &Cancel);

typedef void __fastcall (__closure *TLMDSectionBarAllowChangeEvent)(System::TObject* Sender, int Index, bool &Cancel);

typedef void __fastcall (__closure *TLMDSectionBarItemEvent)(System::TObject* Sender, TLMDSectionBarSection* Section, TLMDSectionBarItem* Item);

typedef void __fastcall (__closure *TLMDSectionBarDrawSection)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, int Index, bool &Done);

typedef void __fastcall (__closure *TLMDSectionBarDrawItem)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, int SectionIndex, int ItemIndex, bool &Done);

class PASCALIMPLEMENTATION TLMDSectionBarTheme : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FButtonBackground;
	System::Uitypes::TColor FButtonHighlightTextColor;
	System::Uitypes::TColor FButtonTextColor;
	System::Uitypes::TColor FDisableTextColor;
	System::Uitypes::TColor FHighlightTextColor;
	System::Uitypes::TColor FItemDownBackGround;
	System::Uitypes::TColor FItemBorderBlack;
	System::Uitypes::TColor FItemBorderLight;
	System::Uitypes::TColor FItemDragBackground;
	System::Uitypes::TColor FItemDragBorder;
	System::Uitypes::TColor FItemSelectedBackground;
	System::Uitypes::TColor FListViewBackground;
	System::Uitypes::TColor FSectionSpaceColor;
	System::Uitypes::TColor FTextColor;
	Vcl::Graphics::TBitmap* FScrollBmp;
	TLMDSectionBarSelectionStyle FSelectionStyle;
	int FImageSpace;
	int FCaptionSpace;
	int FItemsSpace;
	int FScrollStep;
	int FDragSpace;
	int FSectionSpace;
	int FSectionHeight;
	System::Uitypes::TColor __fastcall GetColor(const int Index);
	Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	int __fastcall GetInteger(int Index);
	void __fastcall SetColor(const int Index, const System::Uitypes::TColor Value);
	void __fastcall SetInteger(int Index, const int Value);
	void __fastcall SetScrollBmp(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetSelectionStyle(const TLMDSectionBarSelectionStyle Value);
	void __fastcall SetSectionSpace(const int Value);
	void __fastcall SetSectionMinHeight(const int Value);
	
public:
	__fastcall virtual TLMDSectionBarTheme(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDSectionBarTheme(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Src);
	__property Vcl::Graphics::TBitmap* ScrollBmp = {read=GetBitmap};
	
__published:
	__property System::Uitypes::TColor ButtonBackground = {read=GetColor, write=SetColor, index=0, default=-16777201};
	__property System::Uitypes::TColor ButtonHighlightTextColor = {read=GetColor, write=SetColor, index=1, default=16711680};
	__property System::Uitypes::TColor ButtonTextColor = {read=GetColor, write=SetColor, index=2, default=0};
	__property System::Uitypes::TColor DisableTextColor = {read=GetColor, write=SetColor, index=3, default=12632256};
	__property System::Uitypes::TColor HighlightTextColor = {read=GetColor, write=SetColor, index=4, default=8388608};
	__property System::Uitypes::TColor ItemDownBackGround = {read=GetColor, write=SetColor, index=5, default=-16777201};
	__property System::Uitypes::TColor ItemBorderBlack = {read=GetColor, write=SetColor, index=6, default=12632256};
	__property System::Uitypes::TColor ItemBorderLight = {read=GetColor, write=SetColor, index=7, default=16777215};
	__property System::Uitypes::TColor ItemDragBackground = {read=GetColor, write=SetColor, index=8, default=11579568};
	__property System::Uitypes::TColor ItemDragBorder = {read=GetColor, write=SetColor, index=9, default=0};
	__property System::Uitypes::TColor ItemSelectedBackground = {read=GetColor, write=SetColor, index=10, default=15790320};
	__property System::Uitypes::TColor ViewBackground = {read=GetColor, write=SetColor, index=11, default=-16777201};
	__property System::Uitypes::TColor ButtonSpaceColor = {read=GetColor, write=SetColor, index=12, default=12632256};
	__property System::Uitypes::TColor TextColor = {read=GetColor, write=SetColor, index=13, default=0};
	__property Vcl::Graphics::TBitmap* CustomScrollBmp = {read=FScrollBmp, write=SetScrollBmp};
	__property int CaptionSpace = {read=GetInteger, write=SetInteger, index=0, default=2};
	__property int DragSpace = {read=GetInteger, write=SetInteger, index=1, default=4};
	__property int ImageSpace = {read=GetInteger, write=SetInteger, index=2, default=2};
	__property int ItemsSpace = {read=GetInteger, write=SetInteger, index=3, default=4};
	__property int ScrollStep = {read=GetInteger, write=SetInteger, index=4, default=3};
	__property int ButtonSpace = {read=FSectionSpace, write=SetSectionSpace, default=1};
	__property int ButtonMinHeight = {read=FSectionHeight, write=SetSectionMinHeight, default=0};
	__property TLMDSectionBarSelectionStyle SelectionStyle = {read=FSelectionStyle, write=SetSelectionStyle, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSectionBarThemeItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDSectionBarTheme* FTheme;
	System::UnicodeString FName;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetTheme(TLMDSectionBarTheme* const Value);
	void __fastcall GetChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDSectionBarThemeItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSectionBarThemeItem(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property TLMDSectionBarTheme* Theme = {read=FTheme, write=SetTheme};
	__property Index;
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSectionBarThemeItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDSectionBarThemeItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDSectionBarController* __fastcall GetController(void);
	TLMDSectionBarThemeItem* __fastcall GetItems(int Index);
	TLMDSectionBarThemeItem* __fastcall GetItemByName(System::UnicodeString Value);
	
protected:
	System::UnicodeString __fastcall GetThemeItemName(void);
	System::UnicodeString __fastcall ValidateName(const System::UnicodeString NewName, const System::UnicodeString oldName = System::UnicodeString());
	__property TLMDSectionBarController* Controller = {read=GetController};
	
public:
	__fastcall TLMDSectionBarThemeItems(System::Classes::TComponent* Owner);
	HIDESBASE TLMDSectionBarThemeItem* __fastcall Add(void);
	__property TLMDSectionBarThemeItem* Items[int Index] = {read=GetItems/*, default*/};
	__property TLMDSectionBarThemeItem* ItemByName[System::UnicodeString Value] = {read=GetItemByName};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDSectionBarThemeItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSectionBarController : public Lmdbarbase::TLMDBarController
{
	typedef Lmdbarbase::TLMDBarController inherited;
	
private:
	TLMDSectionBarThemeItems* FThemes;
	int FIndex;
	void __fastcall SetThemes(TLMDSectionBarThemeItems* const Value);
	void __fastcall SetIndex(const int Value);
	TLMDSectionBarTheme* __fastcall GetTheme(void);
	
public:
	__fastcall virtual TLMDSectionBarController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSectionBarController(void);
	void __fastcall UpdateParent(int UpdateIndex = 0x0);
	__property TLMDSectionBarTheme* ActiveTheme = {read=GetTheme};
	
__published:
	__property About = {default=0};
	__property int ActiveThemeIndex = {read=FIndex, write=SetIndex, default=0};
	__property TLMDSectionBarThemeItems* Themes = {read=FThemes, write=SetThemes};
};


class PASCALIMPLEMENTATION TLMDSectionBarSectionPanel : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	TLMDSectionBarSection* FSection;
	int FIndex;
	bool FAutoCreated;
	int __fastcall GetIndex(void);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TLMDSectionBarSectionPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSectionBarSectionPanel(void);
	__property int Index = {read=GetIndex, nodefault};
	__property TLMDSectionBarSection* Section = {read=FSection};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSectionBarSectionPanel(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSectionBarSection : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	TLMDSectionBarSectionPanel* FPanel;
	System::UnicodeString FHint;
	int FTag;
	TLMDSectionBarView* FView;
	System::UnicodeString FName;
	TLMDSectionBarSections* __fastcall GetSections(void);
	TLMDSectionBarView* __fastcall GetListView(void);
	TLMDSectionBarItems* __fastcall GetItems(void);
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(int Index);
	bool __fastcall GetDownState(void);
	HIDESBASE int __fastcall GetIndex(int Index);
	TLMDSectionBarItem* __fastcall GetItem(int Index);
	bool __fastcall GetReadOnly(void);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	System::Types::TRect __fastcall GetCaptionRect(TLMDSectionBarItem* Item);
	System::Types::TRect __fastcall GetImageRect(TLMDSectionBarItem* Item);
	TLMDSectionBarItem* __fastcall GetItemAtPos(int X, int Y);
	System::Types::TRect __fastcall GetItemRect(TLMDSectionBarItem* Item);
	int __fastcall GetItemsHeight(void);
	TLMDSectionBarViewStyle __fastcall GetViewStyle(void);
	bool __fastcall IsCustomCaption(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetDownState(const bool Value);
	void __fastcall SetItemIndex(const int Index, const int Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetImageList(int Index, Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetItems(TLMDSectionBarItems* const Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetViewStyle(const TLMDSectionBarViewStyle Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetItem(const int Index, TLMDSectionBarItem* const Value);
	
protected:
	void __fastcall CreateListView(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDSectionBarSection(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSectionBarSection(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SetCaptionEx(const System::UnicodeString Value, bool bEvents = true);
	virtual void __fastcall Activate(Lmdcontrol::TLMDBaseCustomControl* SectionBar);
	virtual void __fastcall Deactivate(Lmdcontrol::TLMDBaseCustomControl* SectionBar);
	bool __fastcall IsItemVisible(TLMDSectionBarItem* Item);
	void __fastcall ScrollInView(TLMDSectionBarItem* Item);
	void __fastcall Initialize(void);
	void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property TLMDSectionBarSections* Sections = {read=GetSections};
	__property TLMDSectionBarSectionPanel* Panel = {read=FPanel};
	__property TLMDSectionBarView* View = {read=GetListView};
	__property int SelectedItemIndex = {read=GetIndex, index=0, nodefault};
	__property TLMDSectionBarItem* SelectedItem = {read=GetItem, index=0};
	__property TLMDSectionBarItem* DownItem = {read=GetItem, write=SetItem, index=1};
	__property System::Types::TRect ImageRect[TLMDSectionBarItem* Item] = {read=GetImageRect};
	__property TLMDSectionBarItem* ItemAtPos[int X][int Y] = {read=GetItemAtPos};
	__property int ItemHeight = {read=GetItemsHeight, nodefault};
	__property System::Types::TRect ItemRect[TLMDSectionBarItem* Item] = {read=GetItemRect};
	__property System::Types::TRect CaptionRect[TLMDSectionBarItem* Item] = {read=GetCaptionRect};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption, stored=IsCustomCaption};
	__property int DownItemIndex = {read=GetIndex, write=SetItemIndex, index=1, default=-1};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property TLMDSectionBarItems* Items = {read=GetItems, write=SetItems};
	__property Index;
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property Vcl::Imglist::TCustomImageList* SmallImages = {read=GetImageList, write=SetImageList, index=0};
	__property Vcl::Imglist::TCustomImageList* LargeImages = {read=GetImageList, write=SetImageList, index=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property TLMDSectionBarViewStyle ViewStyle = {read=GetViewStyle, write=SetViewStyle, default=1};
	__property bool AllowDown = {read=GetDownState, write=SetDownState, default=1};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSectionBarSections : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDSectionBarSection* operator[](int Index) { return this->Section[Index]; }
	
private:
	Lmdcontrol::TLMDBaseCustomControl* FSectionBar;
	bool FUpdating;
	TLMDSectionBarSection* __fastcall GetSection(int Index);
	TLMDSectionBarSection* __fastcall GetSectionByName(System::UnicodeString Value);
	System::UnicodeString __fastcall GetSectionName(void);
	void __fastcall DoItemEvent(System::TObject* Sender, TLMDSectionBarItemEventType Reason, System::TObject* Item);
	void __fastcall OnDragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept, bool &Complete);
	void __fastcall OnLVDrawItem(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TLMDSectionBarItem* Item, bool &Done);
	void __fastcall OnLVDrawBackground(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, bool &Done);
	void __fastcall OnDragDrop(System::TObject* Sender, System::TObject* Target, int X, int Y);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	void __fastcall Initialize(void);
	
public:
	__fastcall TLMDSectionBarSections(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDSectionBarSections(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE TLMDSectionBarSection* __fastcall Add(void);
	virtual void __fastcall BeginUpdate(void);
	bool __fastcall CheckCaption(System::UnicodeString szName);
	virtual void __fastcall EndUpdate(void);
	System::UnicodeString __fastcall ValidateName(System::UnicodeString NewName);
	virtual void __fastcall Activate(Lmdcontrol::TLMDBaseCustomControl* SectionBar);
	virtual void __fastcall Deactivate(void);
	__property TLMDSectionBarSection* Section[int Index] = {read=GetSection/*, default*/};
	__property TLMDSectionBarSection* SectionByName[System::UnicodeString Value] = {read=GetSectionByName};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSectionBarStorage : public Lmdbarbase::TLMDBarController
{
	typedef Lmdbarbase::TLMDBarController inherited;
	
private:
	TLMDSectionBarSections* FSections;
	void __fastcall SetSections(TLMDSectionBarSections* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDSectionBarStorage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSectionBarStorage(void);
	
__published:
	__property TLMDSectionBarSections* Sections = {read=FSections, write=SetSections};
};


class PASCALIMPLEMENTATION TLMDCustomSectionBar : public Lmdcontrol::TLMDBaseCustomControl
{
	typedef Lmdcontrol::TLMDBaseCustomControl inherited;
	
private:
	int FInternalFontHeight;
	bool FSectionDrag;
	int FActiveSectionIndex;
	System::Classes::TAlignment FCaptionAlignment;
	int FDragSection;
	Vcl::Extctrls::TTimer* FDragTimer;
	bool FHotTrack;
	System::Classes::TNotifyEvent FOnItemDelete;
	System::Classes::TNotifyEvent FOnSectionDelete;
	System::Classes::TNotifyEvent FOnSectionChange;
	System::Classes::TNotifyEvent FOnEditHide;
	TLMDSectionBarDrawItem FOnItemDraw;
	TLMDSectionBarAllowChangeEvent FOnBeforeItemDelete;
	TLMDSectionBarAllowChangeEvent FOnBeforeSectionDelete;
	TLMDSectionBarAllowChangeEvent FOnSectionBeforeChange;
	TLMDSectionBarAllowChangeEvent FOnItemEditShow;
	TLMDSectionBarAllowChangeEvent FOnSectionEditShow;
	TLMDSectionBarEditChangingEvent FOnSectionCaptionChanging;
	TLMDSectionBarEditChangingEvent FOnItemCaptionChanging;
	TLMDSectionBarChangeEvent FOnItemAdd;
	TLMDSectionBarChangeEvent FOnSectionAdd;
	TLMDSectionBarChangeEvent FOnItemCaptionChange;
	TLMDSectionBarChangeEvent FOnSectionCaptionChange;
	TLMDSectionBarDrawSection FOnSectionDrawButton;
	TLMDSectionBarDrawSection FOnSectionDrawBackground;
	TLMDSectionBarItemEvent FOnItemClick;
	TLMDSectionBarItemEvent FOnSelect;
	TLMDSectionBarItemEvent FOnItemSelect;
	TLMDSectionBarItemEvent FOnItemUnSelect;
	int FScrollFrequency;
	TLMDSectionBarSections* FSections;
	TLMDSectionBarStorage* FSectionStorage;
	bool FSingleSection;
	TLMDSectionBarTheme* FTheme;
	TLMDSectionBarController* FThemeController;
	bool __fastcall IsNoStorage(void);
	bool __fastcall IsNoCustomTheme(void);
	TLMDSectionBarSection* __fastcall GetActiveSection(void);
	TLMDSectionBarSections* __fastcall GetActiveSections(void);
	int __fastcall GetActiveSectionIndex(void);
	Lmdobject::TLMDObject* __fastcall GetTheme(void);
	int __fastcall GetInternalSectionIndex(const int Value);
	void __fastcall SetActiveSectionIndex(const int Value);
	void __fastcall SetCaptionAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetHotTrack(const bool Value);
	void __fastcall SetScrollFrequency(const int Value);
	void __fastcall SetSections(TLMDSectionBarSections* const Value);
	void __fastcall SetSectionStorage(TLMDSectionBarStorage* const Value);
	void __fastcall SetSingleSection(const bool Value);
	void __fastcall SetTheme(TLMDSectionBarTheme* const Value);
	void __fastcall SetThemeController(TLMDSectionBarController* const Value);
	MESSAGE void __fastcall CMUpdateLinkMessage(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	MESSAGE void __fastcall WMTimer(Winapi::Messages::TWMTimer &Msg);
	MESSAGE void __fastcall WMUpdateScroll(Winapi::Messages::TMessage &Msg);
	
protected:
	bool FButtonDown;
	TLMDBarSectionCaptionEdit* FCaptionEdit;
	int FDownSectionIndex;
	int FHotSectionIndex;
	TLMDBarClearButton* FUpScroll;
	TLMDBarClearButton* FDownScroll;
	bool FTimerEnable;
	bool __fastcall CheckSectionIndex(int SectionIndex, bool Activate = true, bool effect = false);
	void __fastcall ChangeSections(TLMDSectionBarSections* OldS, TLMDSectionBarSections* NewS);
	void __fastcall ArrangeSections(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	TLMDSectionBarSection* __fastcall FindSectionByView(TLMDSectionBarView* aView);
	System::Types::TRect __fastcall GetSectionButtonRect(int Index);
	int __fastcall GetSectionButtonHeight(void);
	System::Types::TRect __fastcall GetSectionRect(bool bCorrectLast = true);
	int __fastcall GetSectionAt(int X, int Y);
	bool __fastcall GetUseXP(void);
	void __fastcall GetThemeChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OnDragTimer(System::TObject* Sender);
	void __fastcall OnScrollClick(System::TObject* Sender);
	virtual void __fastcall PaintSectionButton(int Index);
	virtual void __fastcall PaintBackground(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateSectionStorage(void);
	void __fastcall UpdateSectionSize(void);
	__property TLMDSectionBarSections* Sections = {read=FSections, write=SetSections, stored=IsNoStorage};
	__property TLMDSectionBarStorage* SectionStorage = {read=FSectionStorage, write=SetSectionStorage};
	__property TLMDSectionBarSection* ActiveSection = {read=GetActiveSection};
	__property TLMDSectionBarSections* ActiveSections = {read=GetActiveSections};
	__property int ActiveSectionIndex = {read=GetActiveSectionIndex, write=SetActiveSectionIndex, default=0};
	__property System::Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property bool HotTrack = {read=FHotTrack, write=SetHotTrack, default=1};
	__property int ScrollFrequency = {read=FScrollFrequency, write=SetScrollFrequency, default=20};
	__property bool SingleSection = {read=FSingleSection, write=SetSingleSection, default=0};
	__property bool SectionDrag = {read=FSectionDrag, write=FSectionDrag, default=0};
	__property TLMDSectionBarTheme* Theme = {read=FTheme, write=SetTheme, stored=IsNoCustomTheme};
	__property TLMDSectionBarController* ThemeController = {read=FThemeController, write=SetThemeController};
	__property TLMDSectionBarItemEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TLMDSectionBarItemEvent OnItemSelectionChange = {read=FOnSelect, write=FOnSelect};
	__property TLMDSectionBarItemEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TLMDSectionBarItemEvent OnItemUnSelect = {read=FOnItemUnSelect, write=FOnItemUnSelect};
	__property TLMDSectionBarChangeEvent OnItemCaptionChange = {read=FOnItemCaptionChange, write=FOnItemCaptionChange};
	__property TLMDSectionBarEditChangingEvent OnItemCaptionChanging = {read=FOnItemCaptionChanging, write=FOnItemCaptionChanging};
	__property TLMDSectionBarDrawItem OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TLMDSectionBarDrawSection OnSectionDrawBackground = {read=FOnSectionDrawBackground, write=FOnSectionDrawBackground};
	__property TLMDSectionBarDrawSection OnSectionDrawButton = {read=FOnSectionDrawButton, write=FOnSectionDrawButton};
	__property System::Classes::TNotifyEvent OnEditHide = {read=FOnEditHide, write=FOnEditHide};
	__property TLMDSectionBarAllowChangeEvent OnSectionEditShow = {read=FOnSectionEditShow, write=FOnSectionEditShow};
	__property TLMDSectionBarAllowChangeEvent OnItemEditShow = {read=FOnItemEditShow, write=FOnItemEditShow};
	__property TLMDSectionBarEditChangingEvent OnSectionCaptionChanging = {read=FOnSectionCaptionChanging, write=FOnSectionCaptionChanging};
	__property TLMDSectionBarChangeEvent OnSectionCaptionChange = {read=FOnSectionCaptionChange, write=FOnSectionCaptionChange};
	__property System::Classes::TNotifyEvent OnSectionChange = {read=FOnSectionChange, write=FOnSectionChange};
	__property TLMDSectionBarAllowChangeEvent OnSectionBeforeChange = {read=FOnSectionBeforeChange, write=FOnSectionBeforeChange};
	__property TLMDSectionBarChangeEvent OnSectionAdd = {read=FOnSectionAdd, write=FOnSectionAdd};
	__property TLMDSectionBarAllowChangeEvent OnBeforeSectionDelete = {read=FOnBeforeSectionDelete, write=FOnBeforeSectionDelete};
	__property System::Classes::TNotifyEvent OnSectionDelete = {read=FOnSectionDelete, write=FOnSectionDelete};
	__property TLMDSectionBarChangeEvent OnItemAdd = {read=FOnItemAdd, write=FOnItemAdd};
	__property TLMDSectionBarAllowChangeEvent OnBeforeItemDelete = {read=FOnBeforeItemDelete, write=FOnBeforeItemDelete};
	__property System::Classes::TNotifyEvent OnItemDelete = {read=FOnItemDelete, write=FOnItemDelete};
	
public:
	__fastcall virtual TLMDCustomSectionBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSectionBar(void);
	int __fastcall ItemAdd(bool IsDown = true, bool ShowEditor = false, int SectionIndex = 0xffffffff, bool Activate = true, bool effect = false);
	bool __fastcall ItemInsert(int aIndex, bool IsDown = true, int SectionIndex = 0xffffffff, bool Activate = true, bool effect = false);
	bool __fastcall ItemDelete(int aIndex = 0xffffffff, bool IsDown = true, int SectionIndex = 0xffffffff, bool Activate = true, bool effect = false);
	void __fastcall ItemEdit(int aIndex = 0xffffffff);
	bool __fastcall ItemMove(int NewIndex, int OldIndex = 0xffffffff, int SectionIndex = 0xffffffff, bool Activate = true, bool effect = false);
	void __fastcall SectionActivate(int NewIndex, bool effect = false);
	int __fastcall SectionAtPos(int X, int Y);
	int __fastcall SectionAdd(bool Activate = true, bool ShowEditor = false, bool effect = false);
	bool __fastcall SectionCopyImageSettings(int ToIndex, int FromIndex = 0xffffffff);
	bool __fastcall SectionsCopyImageSettings(int FromIndex = 0xffffffff);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetAllowDownState(const bool Value);
	void __fastcall SetViewStyle(const TLMDSectionBarViewStyle Value);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	bool __fastcall SectionInsert(int AtIndex, bool Activate = true, bool effect = false);
	bool __fastcall SectionDelete(int Index = 0xffffffff);
	void __fastcall SectionEdit(int Index = 0xffffffff);
	bool __fastcall SectionMove(int NewIndex, int Index = 0xffffffff, bool effect = false);
	int __fastcall SectionNext(bool effect = true);
	int __fastcall SectionPrev(bool effect = true);
	System::Types::TRect __fastcall SectionRect(int Index);
	bool __fastcall CancelEditMode(void);
	virtual void __fastcall InvalidateSectionButton(int Index);
	virtual void __fastcall UpdateSection(int Index);
	void __fastcall DoItemEvents(System::TObject* Sender, TLMDSectionBarItemEventType Reason, System::TObject* Item);
	void __fastcall DoDrawBackground(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, bool &Done);
	void __fastcall DoDrawItem(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TLMDSectionBarItem* Item, bool &Done);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomSectionBar(HWND ParentWindow) : Lmdcontrol::TLMDBaseCustomControl(ParentWindow) { }
	
private:
	void *__TLMDBarParentControlInterface;	// Lmdbarbase::TLMDBarParentControlInterface 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {13432433-0000-4523-3456-454870235266}
	operator Lmdbarbase::_di_TLMDBarParentControlInterface()
	{
		Lmdbarbase::_di_TLMDBarParentControlInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdbarbase::TLMDBarParentControlInterface*(void) { return (Lmdbarbase::TLMDBarParentControlInterface*)&__TLMDBarParentControlInterface; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDSectionBar : public TLMDCustomSectionBar
{
	typedef TLMDCustomSectionBar inherited;
	
public:
	__property ActiveSection;
	__property ActiveSections;
	
__published:
	__property About = {default=0};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=1};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Font;
	__property Sections;
	__property ActiveSectionIndex = {default=0};
	__property CaptionAlignment = {default=0};
	__property HotTrack = {default=1};
	__property ScrollFrequency = {default=20};
	__property SingleSection = {default=0};
	__property SectionStorage;
	__property SectionDrag = {default=0};
	__property Theme;
	__property ThemeController;
	__property OnItemClick;
	__property OnItemSelectionChange;
	__property OnItemSelect;
	__property OnItemUnSelect;
	__property OnItemDraw;
	__property OnItemAdd;
	__property OnBeforeItemDelete;
	__property OnItemDelete;
	__property OnSectionDrawBackground;
	__property OnSectionDrawButton;
	__property OnSectionChange;
	__property OnSectionBeforeChange;
	__property OnSectionAdd;
	__property OnSectionDelete;
	__property OnBeforeSectionDelete;
	__property OnEditHide;
	__property OnSectionEditShow;
	__property OnItemEditShow;
	__property OnSectionCaptionChange;
	__property OnSectionCaptionChanging;
	__property OnItemCaptionChanging;
	__property OnItemCaptionChange;
	__property Align = {default=0};
	__property PopupMenu;
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseExit;
	__property OnMouseEnter;
	__property OnKeyDown;
	__property OnKeyUp;
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
	/* TLMDCustomSectionBar.Create */ inline __fastcall virtual TLMDSectionBar(System::Classes::TComponent* AOwner) : TLMDCustomSectionBar(AOwner) { }
	/* TLMDCustomSectionBar.Destroy */ inline __fastcall virtual ~TLMDSectionBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSectionBar(HWND ParentWindow) : TLMDCustomSectionBar(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDBarClearButton : public Vcl::Buttons::TSpeedButton
{
	typedef Vcl::Buttons::TSpeedButton inherited;
	
protected:
	TLMDCustomSectionBar* FBar;
	int FSectionIndex;
	Vcl::Extctrls::TTimer* FTimer;
	virtual void __fastcall Paint(void);
	void __fastcall OnTimer(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDBarClearButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBarClearButton(void);
	bool __fastcall IsDown(void);
};


class PASCALIMPLEMENTATION TLMDBarSectionCaptionEdit : public Vcl::Stdctrls::TCustomEdit
{
	typedef Vcl::Stdctrls::TCustomEdit inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMSetFocus &Message);
	
protected:
	int ItemIndex;
	System::Classes::TComponent* FClient;
	bool CancelEdit;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	bool __fastcall IsSection(void);
	void __fastcall UpdateCaption(void);
	DYNAMIC void __fastcall VisibleChanging(void);
	
public:
	__fastcall virtual TLMDBarSectionCaptionEdit(System::Classes::TComponent* AOwner);
	HIDESBASE void __fastcall Show(System::Classes::TComponent* Value);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBarSectionCaptionEdit(HWND ParentWindow) : Vcl::Stdctrls::TCustomEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDBarSectionCaptionEdit(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 defLMD_SECTIONSPACE = System::Int8(0x1);
static const System::Int8 defLMD_ITEMSGAP = System::Int8(0x4);
static const System::Int8 defLMD_IMAGEGAP = System::Int8(0x2);
static const System::Int8 defLMD_CAPTIONGAP = System::Int8(0x2);
static const System::Int8 defLMD_SCROLLSIZE = System::Int8(0x3);
static const System::Int8 defLMD_DRAGSPACE = System::Int8(0x4);
static const System::Int8 defLMD_CXDRAG = System::Int8(0x5);
static const System::Int8 defLMD_CYDRAG = System::Int8(0x5);
}	/* namespace Lmdsectionbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSECTIONBAR)
using namespace Lmdsectionbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsectionbarHPP
