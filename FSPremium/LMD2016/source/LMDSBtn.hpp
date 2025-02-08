// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSBtn.pas' rev: 31.00 (Windows)

#ifndef LmdsbtnHPP
#define LmdsbtnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDPNGImage.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDFXCaption.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsbtn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSpecialButton;
class DELPHICLASS TLMDSpecialButtons;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnCustomBtnClick)(System::TObject* Sender, int index);

class PASCALIMPLEMENTATION TLMDSpecialButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TBitmap* FGlyph;
	System::Uitypes::TCursor FCursor;
	int FGroupIndex;
	bool FParentFont;
	bool FEnabled;
	TLMDOnCustomBtnClick FOnClick;
	Lmdbuttonlayout::TLMDButtonLayout* FLayout;
	Vcl::Graphics::TFont* FFont;
	Lmdfxcaption::TLMDFxCaption* FFontFX;
	Lmdclass::TLMDThemeMode FThemeMode;
	Lmdpngimage::TLMDPNGObject* FPngGlyph;
	bool FUsePngGlyph;
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetBtn(Lmdspeedbutton::TLMDSpeedButton* aValue);
	void __fastcall SetCursor(System::Uitypes::TCursor aValue);
	void __fastcall SetLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFontFX(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetInteger(int aValue);
	void __fastcall SetParentFont(bool aValue);
	bool __fastcall GetParentFont(void);
	void __fastcall DoOnClick(System::TObject* Sender);
	void __fastcall GetChange(System::TObject* Sender);
	bool __fastcall GetPressed(void);
	void __fastcall SetPressed(const bool Value);
	void __fastcall SetCtlXP(const bool Value);
	bool __fastcall GetCtlXP(void);
	bool __fastcall GetAllowAllUp(void);
	void __fastcall SetAllowAllUp(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	int __fastcall GetImageIndex(void);
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	int __fastcall GetListIndex(void);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetListIndex(const int Value);
	void __fastcall SetPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetUsePngGlyph(const bool Value);
	bool __fastcall GetUsePngGlyph(void);
	
protected:
	Lmdspeedbutton::TLMDSpeedButton* FBtn;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall CreateButtonControl(void);
	
public:
	__fastcall virtual TLMDSpecialButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSpecialButton(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DoClick(void);
	__property Lmdspeedbutton::TLMDSpeedButton* Btn = {read=FBtn, write=SetBtn};
	__property bool Pressed = {read=GetPressed, write=SetPressed, default=0};
	__property bool CtlXP = {read=GetCtlXP, write=SetCtlXP, default=0};
	
__published:
	__property bool AllowAllUp = {read=GetAllowAllUp, write=SetAllowAllUp, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetString, index=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=-2};
	__property System::UnicodeString Hint = {read=FHint, write=SetString, index=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property Lmdbuttonlayout::TLMDButtonLayout* Layout = {read=FLayout, write=SetLayout};
	__property bool ParentFont = {read=GetParentFont, write=SetParentFont, default=1};
	__property Lmdpngimage::TLMDPNGObject* PngGlyph = {read=FPngGlyph, write=SetPngGlyph};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFX, write=SetFontFX};
	__property int GroupIndex = {read=FGroupIndex, write=SetInteger, default=0};
	__property Index;
	__property DisplayName = {default=0};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=0};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	__property int ListIndex = {read=GetListIndex, write=SetListIndex, nodefault};
	__property TLMDOnCustomBtnClick OnClick = {read=FOnClick, write=FOnClick};
	__property bool UsePngGlyph = {read=GetUsePngGlyph, write=SetUsePngGlyph, nodefault};
};


class PASCALIMPLEMENTATION TLMDSpecialButtons : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDSpecialButton* operator[](int Index) { return this->Items[Index]; }
	
private:
	Vcl::Controls::TWinControl* FOwner;
	bool FInform;
	System::Classes::TNotifyEvent FOnChange;
	HIDESBASE TLMDSpecialButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSpecialButton* Value);
	
protected:
	void __fastcall Change(void);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual System::Classes::TCollectionItemClass __fastcall GetButtonClass(void);
	
public:
	__fastcall virtual TLMDSpecialButtons(Vcl::Controls::TWinControl* Owner, bool inform);
	__fastcall virtual ~TLMDSpecialButtons(void);
	HIDESBASE virtual TLMDSpecialButton* __fastcall Add(void);
	__property TLMDSpecialButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsbtn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSBTN)
using namespace Lmdsbtn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsbtnHPP
