// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUnicodeCtrls.pas' rev: 31.00 (Windows)

#ifndef LmdunicodectrlsHPP
#define LmdunicodectrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUnicodeControl.hpp>
#include <intfLMDBase.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDStrings.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdunicodectrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWideLabel;
//-- type declarations -------------------------------------------------------
typedef Vcl::Stdctrls::TButton TLMDWideButton;

typedef Vcl::Stdctrls::TCheckBox TLMDWideCheckBox;

typedef Vcl::Stdctrls::TRadioButton TLMDWideRadioButton;

class PASCALIMPLEMENTATION TLMDWideLabel : public Vcl::Stdctrls::TCustomLabel
{
	typedef Vcl::Stdctrls::TCustomLabel inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FAlreadyInSetBounds;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent __fastcall GetOnImageNeeded(void);
	void __fastcall SetOnImageNeeded(const Lmdhtmlunit::TLMDHTMLImageNeededEvent Value);
	
protected:
	bool FUseXPThemes;
	Lmdtypes::TLMDString FCaption;
	bool FEndEllipsis;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Vcl::Controls::TBorderWidth FBorderWidth;
	DYNAMIC void __fastcall AdjustBounds(void);
	virtual void __fastcall SetAutoSize(bool newValue);
	void __fastcall SetUseXPThemes(bool Value);
	void __fastcall SetIsHTML(bool Value);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	void __fastcall SetEndEllipsis(bool Value);
	virtual void __fastcall SetBorderWidth(Vcl::Controls::TBorderWidth Value);
	virtual void __fastcall Paint(void);
	__property bool EndEllipsis = {read=FEndEllipsis, write=SetEndEllipsis, default=0};
	__property bool UseXPThemes = {read=FUseXPThemes, write=SetUseXPThemes, default=1};
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall PrepareText(void);
	HIDESBASE MESSAGE void __fastcall CMFontchanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
public:
	__fastcall virtual TLMDWideLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWideLabel(void);
	Lmdtypes::TLMDPackageID __fastcall GetLMDPackage(void);
	
__published:
	__property AutoSize = {default=1};
	__property Font;
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Color;
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, nodefault};
	__property Transparent = {default=1};
	__property Vcl::Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=GetOnImageNeeded, write=SetOnImageNeeded};
	__property WordWrap = {default=0};
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
}	/* namespace Lmdunicodectrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUNICODECTRLS)
using namespace Lmdunicodectrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdunicodectrlsHPP
