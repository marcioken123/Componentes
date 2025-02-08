// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPopupMenu.pas' rev: 31.00 (Windows)

#ifndef LmdpopupmenuHPP
#define LmdpopupmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <intfLMDBase.hpp>
#include <LMDBase.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDFillObject.hpp>
#include <LMDFXCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpopupmenu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPopupMenu;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdpopupmenu__1 : unsigned char { poDisplayBar, poUseAppTitle };

typedef System::Set<Lmdpopupmenu__1, Lmdpopupmenu__1::poDisplayBar, Lmdpopupmenu__1::poUseAppTitle> TLMDPopUpOptions;

typedef void __fastcall (__closure *TLMDOnPopUpEvent)(System::TObject* Sender, int X, int Y, bool &Cancel);

class PASCALIMPLEMENTATION TLMDPopupMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdbevel::TLMDBevel* FBevel;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Graphics::TFont* FFont;
	Lmdfillobject::TLMDFillObject* FFillObject;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FGlyphTextLayout;
	System::Word FHeight;
	System::Word FGap;
	System::Word FWidth;
	TLMDPopUpOptions FOptions;
	System::UnicodeString FCaption;
	bool FDummy;
	bool FDrawing;
	Vcl::Graphics::TBitmap* FBitmap;
	Vcl::Graphics::TBitmap* FBack;
	TLMDOnPopUpEvent FOnBeforePopUp;
	System::Classes::TNotifyEvent FOnAfterPopup;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetDummy(bool aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetFontFx(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetGlyphText(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetOptions(TLMDPopUpOptions aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	void __fastcall FakeReadMethod(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	bool __fastcall IMLEmpty(void);
	void __fastcall LMDMeasureItem(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, int &Width, int &Height);
	void __fastcall LMDDrawItem(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoAfterPopup(void);
	__property bool OwnerDraw = {read=FDummy, write=SetDummy, stored=false, nodefault};
	
public:
	__fastcall virtual TLMDPopupMenu(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPopupMenu(void);
	virtual void __fastcall Popup(int X, int Y);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Layout = {read=FGlyphTextLayout, write=SetGlyphText};
	__property System::Word BarWidth = {read=FWidth, write=FWidth, default=26};
	__property System::Word BarGap = {read=FGap, write=FGap, default=1};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetFontFx};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	__property TLMDPopUpOptions Options = {read=FOptions, write=SetOptions, default=3};
	__property TLMDOnPopUpEvent OnBeforePopup = {read=FOnBeforePopUp, write=FOnBeforePopUp};
	__property System::Classes::TNotifyEvent OnAfterPopUp = {read=FOnAfterPopup, write=FOnAfterPopup};
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


//-- var, const, procedure ---------------------------------------------------
#define def_PopUpOptions (System::Set<Lmdpopupmenu__1, Lmdpopupmenu__1::poDisplayBar, Lmdpopupmenu__1::poUseAppTitle>() << Lmdpopupmenu__1::poDisplayBar << Lmdpopupmenu__1::poUseAppTitle )
}	/* namespace Lmdpopupmenu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPOPUPMENU)
using namespace Lmdpopupmenu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpopupmenuHPP
