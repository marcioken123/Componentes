// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCaptionButtons.pas' rev: 31.00 (Windows)

#ifndef LmdcaptionbuttonsHPP
#define LmdcaptionbuttonsHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDButtonLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDDwmApi.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcaptionbuttons
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaptionButton;
class DELPHICLASS TLMDCapButtons;
class DELPHICLASS TLMDCaptionButtons;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCaptionButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Graphics::TBitmap* FGlyph;
	Lmdbuttonlayout::TLMDButtonLayout* FLayout;
	int FImageIndex;
	int FGroupIndex;
	int FWidth;
	int FDistance;
	bool FAutoSize;
	bool FFlat;
	bool FTransparent;
	bool FPressed;
	bool FVisible;
	bool FShowHint;
	bool FEnabled;
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TFont* FFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	System::Uitypes::TColor FColor;
	Vcl::Menus::TPopupMenu* FDropDownMenu;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	System::Types::TRect FRect;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseExit;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetColor(System::Uitypes::TColor aValue);
	void __fastcall Set3DCaption(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetDropDownMenu(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetEvent(int index, System::Classes::TNotifyEvent anEvent);
	
protected:
	Vcl::Graphics::TBitmap* FBack;
	void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCaptionButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDCaptionButton(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FreeBack(void);
	__property System::Types::TRect DisplayRect = {read=FRect, write=FRect};
	__property bool Pressed = {read=FPressed, write=SetBoolean, index=3, default=0};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetBoolean, index=6, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=SetString, index=0};
	__property bool ShowHint = {read=FShowHint, write=SetBoolean, index=0, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property int GroupIndex = {read=FGroupIndex, write=SetInteger, index=3, default=0};
	__property Lmdbuttonlayout::TLMDButtonLayout* Layout = {read=FLayout, write=SetLayout};
	__property bool Enabled = {read=FEnabled, write=SetBoolean, index=1, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=SetString, index=1};
	__property int Distance = {read=FDistance, write=SetInteger, index=0, default=0};
	__property Vcl::Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=SetDropDownMenu};
	__property int Width = {read=FWidth, write=SetInteger, index=1, default=-1};
	__property bool Visible = {read=FVisible, write=SetBoolean, index=2, default=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=Set3DCaption};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Transparent = {read=FTransparent, write=SetBoolean, index=4, default=0};
	__property bool Flat = {read=FFlat, write=SetBoolean, index=5, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetInteger, index=2, default=-1};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=SetEvent, index=0};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=SetEvent, index=1};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=SetEvent, index=2};
	__property System::Classes::TNotifyEvent OnMouseExit = {read=FOnMouseExit, write=SetEvent, index=3};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCapButtons : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDCaptionButton* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdwndproccomponent::TLMDWndProcComponent* FOwner;
	HIDESBASE TLMDCaptionButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDCaptionButton* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	void __fastcall SwitchSiblings(int ofBtn);
	void __fastcall FreeBacks(void);
	
public:
	__fastcall TLMDCapButtons(Lmdwndproccomponent::TLMDWndProcComponent* Owner);
	__fastcall virtual ~TLMDCapButtons(void);
	HIDESBASE TLMDCaptionButton* __fastcall Add(void);
	__property TLMDCaptionButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDCaptionButtonAlignment : unsigned char { cbLeft, cbRight };

typedef void __fastcall (__closure *TLMDCaptionButtonClickEvent)(System::TObject* Sender, int Index);

class PASCALIMPLEMENTATION TLMDCaptionButtons : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	TLMDCapButtons* FCapButtons;
	TLMDCaptionButtonAlignment FAlignment;
	Lmdclass::TLMDTimer* FHintTimerId;
	int FMouseAbove;
	int FToRelease;
	TLMDCaptionButtonClickEvent FOnMouseEnter;
	TLMDCaptionButtonClickEvent FOnMouseExit;
	TLMDCaptionButtonClickEvent FOnDblClick;
	TLMDCaptionButtonClickEvent FOnClick;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	Vcl::Controls::THintWindow* HintWnd;
	System::UnicodeString FCurrentHint;
	System::Types::TRect FHintRect;
	bool FUseGlobalTimer;
	void __fastcall SetCapButtons(TLMDCapButtons* aValue);
	void __fastcall SetAlignment(TLMDCaptionButtonAlignment aValue);
	void __fastcall SetMouseAbove(int aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int aValue);
	
protected:
	void __fastcall DoThemeChange(void);
	bool __fastcall UseXP(void);
	bool __fastcall HasControl(void);
	void __fastcall GetIMLChange(System::TObject* Sender);
	void __fastcall DrawButton(int index, Vcl::Graphics::TCanvas* toCanvas);
	void __fastcall DrawButtons(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DesignEnabledChanged(void);
	virtual void __fastcall EnabledChanged(void);
	void __fastcall Click(int index);
	void __fastcall DblClick(int index);
	void __fastcall UnClick(void);
	__property int MouseAbove = {read=FMouseAbove, write=SetMouseAbove, nodefault};
	__property TLMDCaptionButtonAlignment Alignment = {read=FAlignment, write=SetAlignment, default=1};
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	void __fastcall ActivateHideTimer(void);
	void __fastcall DoHideTimerEvent(System::TObject* Sender);
	void __fastcall ActivateHint(void);
	void __fastcall DoTimerEvent(System::TObject* Sender);
	void __fastcall RemoveTimer(void);
	
public:
	__fastcall virtual TLMDCaptionButtons(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCaptionButtons(void);
	void __fastcall NCPaint(void);
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property DesignEnabled = {default=0};
	__property TLMDCapButtons* Buttons = {read=FCapButtons, write=SetCapButtons};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ListIndex = {read=FListIndex, write=SetIndex, default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property TLMDCaptionButtonClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TLMDCaptionButtonClickEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property TLMDCaptionButtonClickEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnClick};
	__property TLMDCaptionButtonClickEvent OnMouseExit = {read=FOnMouseExit, write=FOnDblClick};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcaptionbuttons */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCAPTIONBUTTONS)
using namespace Lmdcaptionbuttons;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcaptionbuttonsHPP
