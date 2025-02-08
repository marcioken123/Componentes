// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCaption.pas' rev: 31.00 (Windows)

#ifndef ElcaptionHPP
#define ElcaptionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDGlyphs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUtils.hpp>
#include <LMDGraph.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElVCLUtils.hpp>
#include <ElHook.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcaption
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCaptionText;
class DELPHICLASS TElCaptionTexts;
class DELPHICLASS TElCaptionButton;
class DELPHICLASS TElCaptionButtons;
class DELPHICLASS TElFormCaption;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCaptionText : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Uitypes::TColor FActiveColor;
	System::Uitypes::TColor FInactiveColor;
	Vcl::Graphics::TFont* FFont;
	bool FVisible;
	Lmdtypes::TLMDString FCaption;
	bool FOwnerStyle;
	Vcl::Buttons::TButtonLayout FLayout;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	System::Classes::TAlignment FAlign;
	TElFormCaption* FFormCaption;
	void __fastcall SetOwnerStyle(bool newValue);
	void __fastcall SetActiveColor(System::Uitypes::TColor newValue);
	void __fastcall SetInactiveColor(System::Uitypes::TColor newValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	void __fastcall SetVisible(bool newValue);
	void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	void __fastcall FontChange(System::TObject* Sender);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetLayout(Vcl::Buttons::TButtonLayout newValue);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall SetAlign(System::Classes::TAlignment newValue);
	
protected:
	virtual void __fastcall Paint(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	int __fastcall GetWidth(Vcl::Graphics::TCanvas* Canvas, int Height);
	
public:
	__fastcall virtual TElCaptionText(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElCaptionText(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=-16777207};
	__property System::Uitypes::TColor InactiveColor = {read=FInactiveColor, write=SetInactiveColor, default=-16777197};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property bool OwnerStyle = {read=FOwnerStyle, write=SetOwnerStyle, default=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, nodefault};
	__property System::Classes::TAlignment Align = {read=FAlign, write=SetAlign, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCaptionTexts : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElCaptionText* operator[](int index) { return this->Items[index]; }
	
private:
	TElFormCaption* FCaption;
	
protected:
	TElCaptionText* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElCaptionText* newValue);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TElCaptionText* __fastcall Add(void);
	__property TElCaptionText* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TElCaptionTexts(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TElCaptionTexts(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElPaintBkgndType : unsigned char { pbtActive, pbtInactive, pbtAlways };

class PASCALIMPLEMENTATION TElCaptionButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TAlignment FAlign;
	Lmdtypes::TLMDString FCaption;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	int FGlyphWidth;
	TElCaptionButtons* FButtons;
	bool FEnabled;
	bool FFixClick;
	bool FDown;
	bool FVisible;
	bool FOwnerStyle;
	System::Uitypes::TColor FActiveColor;
	System::Uitypes::TColor FInactiveColor;
	Vcl::Graphics::TFont* FFont;
	Vcl::Buttons::TButtonLayout FLayout;
	System::Types::TRect FBtnRect;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	Lmdglyphs::TLMDGlyphListMaskUsage FGlyphMaskUsage;
	void __fastcall SetLayout(Vcl::Buttons::TButtonLayout newValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	void __fastcall SetOwnerStyle(bool newValue);
	void __fastcall SetActiveColor(System::Uitypes::TColor newValue);
	void __fastcall SetInactiveColor(System::Uitypes::TColor newValue);
	void __fastcall SetVisible(bool newValue);
	void __fastcall SetEnabled(bool newValue);
	void __fastcall SetDown(bool newValue);
	void __fastcall SetAlign(System::Classes::TAlignment newValue);
	void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall FontChange(System::TObject* Sender);
	int __fastcall GetImageIndex(void);
	bool __fastcall GetUseImageList(void);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetUseImageList(const bool Value);
	
protected:
	bool FFlat;
	virtual void __fastcall Paint(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	int __fastcall GetWidth(Vcl::Graphics::TCanvas* Canvas, int Height);
	void __fastcall SetFlat(bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TElCaptionButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElCaptionButton(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property System::Classes::TAlignment Align = {read=FAlign, write=SetAlign, default=1};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool FixClick = {read=FFixClick, write=FFixClick, nodefault};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool OwnerStyle = {read=FOwnerStyle, write=SetOwnerStyle, default=1};
	__property System::Uitypes::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=-16777198};
	__property System::Uitypes::TColor InactiveColor = {read=FInactiveColor, write=SetInactiveColor, default=-16777198};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Lmdglyphs::TLMDGlyphListMaskUsage GlyphMaskUsage = {read=FGlyphMaskUsage, write=FGlyphMaskUsage, default=2};
	__property bool UseImageList = {read=GetUseImageList, write=SetUseImageList, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCaptionButtons : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElCaptionButton* operator[](int index) { return this->Items[index]; }
	
private:
	TElFormCaption* FCaption;
	
protected:
	TElCaptionButton* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElCaptionButton* newValue);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TElCaptionButton* __fastcall Add(void);
	__property TElCaptionButton* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TElCaptionButtons(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TElCaptionButtons(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElCaptionDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect);

typedef void __fastcall (__closure *TCaptionButtonEvent)(System::TObject* Sender, TElCaptionButton* Button);

class PASCALIMPLEMENTATION TElFormCaption : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Vcl::Imglist::TChangeLink* FDownChLink;
	Vcl::Imglist::TChangeLink* FDisabledChLink;
	Vcl::Imglist::TChangeLink* FChLink;
	bool FUseImageList;
	Vcl::Imglist::TCustomImageList* FDownImages;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TCustomImageList* FImages;
	TElCaptionTexts* FTexts;
	Vcl::Graphics::TBitmap* FInactiveBitmap;
	TElCaptionButtons* FButtons;
	TElPaintBkgndType FPaintBkgnd;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	Vcl::Graphics::TBitmap* FBitmap;
	Elhook::TElHook* FHook;
	bool FActive;
	System::Uitypes::TColor FActiveLeftColor;
	System::Uitypes::TColor FActiveRightColor;
	System::Uitypes::TColor FInactiveLeftColor;
	System::Uitypes::TColor FInactiveRightColor;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	int FNumColors;
	System::Classes::TAlignment FAlignment;
	Vcl::Forms::TForm* FForm;
	int FCaptionHeight;
	bool FSystemFont;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* Font2;
	bool FWndActive;
	HRGN FRegion;
	HRGN FSaveRegion;
	bool FActiveForm;
	bool FClicked;
	bool FInBtn;
	TElCaptionButton* FBtnPressed;
	System::Types::TRect FBtnsRect;
	TElCaptionDrawEvent FOnDrawCaption;
	TCaptionButtonEvent FOnButtonClick;
	TCaptionButtonEvent FOnButtonDblClick;
	bool FPreventUpdate;
	bool FRepaintCaption;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	void __fastcall SetActive(bool newValue);
	void __fastcall SetActiveLeftColor(System::Uitypes::TColor newValue);
	void __fastcall SetActiveRightColor(System::Uitypes::TColor newValue);
	void __fastcall SetInactiveLeftColor(System::Uitypes::TColor newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetNumColors(int newValue);
	void __fastcall SetAlignment(System::Classes::TAlignment newValue);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* newValue);
	void __fastcall BitmapChange(System::TObject* Sender);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall OnAfterHook(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall SetPaintBkgnd(TElPaintBkgndType newValue);
	void __fastcall SetInactiveRightColor(System::Uitypes::TColor newValue);
	void __fastcall SetButtons(TElCaptionButtons* newValue);
	void __fastcall SetInactiveBitmap(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetSystemFont(bool newValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall GetSystemFont(void);
	void __fastcall SetTexts(TElCaptionTexts* newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetUseImageList(const bool Value);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetDownImages(Vcl::Imglist::TCustomImageList* const Value);
	
protected:
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall ImagesChanged(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	void __fastcall Update(void);
	virtual void __fastcall PaintCaption(Winapi::Messages::TMessage &Msg, int Step);
	virtual void __fastcall TriggerDrawCaptionEvent(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect);
	virtual void __fastcall TriggerButtonClickEvent(TElCaptionButton* Button);
	virtual void __fastcall TriggerButtonDblClickEvent(TElCaptionButton* Button);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	
public:
	__fastcall virtual TElFormCaption(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFormCaption(void);
	TElCaptionButton* __fastcall ButtonAtPos(int X, int Y);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall IsThemed(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property System::Uitypes::TColor ActiveLeftColor = {read=FActiveLeftColor, write=SetActiveLeftColor, default=0};
	__property System::Uitypes::TColor ActiveRightColor = {read=FActiveRightColor, write=SetActiveRightColor, default=-16777214};
	__property System::Uitypes::TColor InactiveLeftColor = {read=FInactiveLeftColor, write=SetInactiveLeftColor, default=0};
	__property System::Uitypes::TColor InactiveRightColor = {read=FInactiveRightColor, write=SetInactiveRightColor, default=-16777213};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* DownImages = {read=FDownImages, write=SetDownImages};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property bool UseImageList = {read=FUseImageList, write=SetUseImageList, default=0};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property int NumColors = {read=FNumColors, write=SetNumColors, default=64};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Vcl::Graphics::TBitmap* ActiveBitmap = {read=FBitmap, write=SetBitmap};
	__property TElPaintBkgndType PaintBkgnd = {read=FPaintBkgnd, write=SetPaintBkgnd, default=2};
	__property TElCaptionButtons* Buttons = {read=FButtons, write=SetButtons};
	__property Vcl::Graphics::TBitmap* InactiveBitmap = {read=FInactiveBitmap, write=SetInactiveBitmap};
	__property TElCaptionDrawEvent OnDrawCaption = {read=FOnDrawCaption, write=FOnDrawCaption};
	__property TCaptionButtonEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TCaptionButtonEvent OnButtonDblClick = {read=FOnButtonDblClick, write=FOnButtonDblClick};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TElCaptionTexts* Texts = {read=FTexts, write=SetTexts};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcaption */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCAPTION)
using namespace Elcaption;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcaptionHPP
