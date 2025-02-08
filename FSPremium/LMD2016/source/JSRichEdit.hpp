// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSRichEdit.pas' rev: 31.00 (Windows)

#ifndef JsricheditHPP
#define JsricheditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.RichEdit.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <JSTypes.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsrichedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSRichEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLinkClickedEvent)(System::TObject* Sender, const System::UnicodeString Link, bool &Handled);

class PASCALIMPLEMENTATION TJSRichEdit : public Vcl::Comctrls::TRichEdit
{
	typedef Vcl::Comctrls::TRichEdit inherited;
	
private:
	bool FShowLinks;
	TLinkClickedEvent FOnLinkClicked;
	void __fastcall SetShowLinks(const bool Value);
	void __fastcall UpdateShowLinks(const bool Value);
	
protected:
	virtual void __fastcall DoLinkClicked(const System::UnicodeString ALink);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall CNNotify(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TJSRichEdit(System::Classes::TComponent* AOwner);
	void __fastcall ScrollToLine(const int aLineNumber);
	void __fastcall ScrollToTop(void);
	void __fastcall ScrollToEnd(void);
	
__published:
	__property bool ShowLinks = {read=FShowLinks, write=SetShowLinks, default=1};
	__property TLinkClickedEvent OnLinkClicked = {read=FOnLinkClicked, write=FOnLinkClicked};
public:
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TJSRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSRichEdit(HWND ParentWindow) : Vcl::Comctrls::TRichEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsrichedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSRICHEDIT)
using namespace Jsrichedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsricheditHPP
