// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHintWnd.pas' rev: 31.00 (Windows)

#ifndef ElhintwndHPP
#define ElhintwndHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhintwnd
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElHintWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElHintWindow : public Vcl::Controls::THintWindow
{
	typedef Vcl::Controls::THintWindow inherited;
	
protected:
	Vcl::Graphics::TFont* FFont;
	bool FActivating;
	int FMaxWidth;
	System::WideString FWideCaption;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	bool FIsHTML;
	int FHTMLTabWidth;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	void __fastcall SetHTMLTabWidth(int Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	bool FWordWrap;
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetWordWrap(bool Value);
	
public:
	__fastcall virtual TElHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElHintWindow(void);
	virtual void __fastcall Paint(void);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	__classmethod System::Uitypes::TColor __fastcall GetThemedHintColor();
	System::Types::TRect __fastcall CalcHintRectW(int MaxWidth, const System::WideString AHint, void * AData);
	virtual void __fastcall ActivateHintW(const System::Types::TRect &Rect, const System::WideString AHint);
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, nodefault};
	__property Canvas;
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property System::WideString WideCaption = {read=FWideCaption, write=FWideCaption};
	__property bool IsHTML = {read=FIsHTML, write=FIsHTML, nodefault};
	__property int HTMLTabWidth = {read=FHTMLTabWidth, write=SetHTMLTabWidth, nodefault};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHintWindow(HWND ParentWindow) : Vcl::Controls::THintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhintwnd */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHINTWND)
using namespace Elhintwnd;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhintwndHPP
