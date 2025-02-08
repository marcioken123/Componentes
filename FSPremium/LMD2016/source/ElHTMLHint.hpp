// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHTMLHint.pas' rev: 31.00 (Windows)

#ifndef ElhtmlhintHPP
#define ElhtmlhintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElComponent.hpp>
#include <ElVCLUtils.hpp>
#include <ElHintWnd.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDUtils.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhtmlhint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElHTMLHint;
class DELPHICLASS TElHTMLHintWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElHTMLHint : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	bool FEnabled;
	Vcl::Controls::THintWindowClass FHintClass;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	
protected:
	System::Uitypes::TFontName FFontName;
	virtual void __fastcall SetEnabled(bool Value);
	void __fastcall SetOnHide(System::Classes::TNotifyEvent Value);
	void __fastcall SetOnShow(System::Classes::TNotifyEvent Value);
	void __fastcall SetOnImageNeeded(Lmdhtmlunit::TElHTMLImageNeededEvent Value);
	void __fastcall SetOnVariableNeeded(const Lmdhtmlunit::TLMDHTMLVariableNeededEvent Value);
	void __fastcall SetOnTagFound(const Lmdhtmlunit::TLMDHTMLTagFoundEvent Value);
	void __fastcall SetFontName(const System::Uitypes::TFontName Value);
	System::Uitypes::TFontCharset __fastcall GetFontCharset(void);
	void __fastcall SetFontCharset(System::Uitypes::TFontCharset Value);
	
public:
	__fastcall virtual ~TElHTMLHint(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=SetOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=SetOnHide};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=SetOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=SetOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=SetOnTagFound};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFontName};
	__property System::Uitypes::TFontCharset FontCharset = {read=GetFontCharset, write=SetFontCharset, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TElHTMLHint(System::Classes::TComponent* AOwner) : Elcomponent::TElComponent(AOwner) { }
	
};


class PASCALIMPLEMENTATION TElHTMLHintWindow : public Elhintwnd::TElHintWindow
{
	typedef Elhintwnd::TElHintWindow inherited;
	
protected:
	void __fastcall OnShow(void);
	void __fastcall OnHide(void);
	MESSAGE void __fastcall WMShowWindow(Winapi::Messages::TWMShowWindow &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	void __fastcall SetupRightCaption(System::UnicodeString Caption);
	
public:
	__fastcall virtual TElHTMLHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElHTMLHintWindow(void);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHTMLHintWindow(HWND ParentWindow) : Elhintwnd::TElHintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhtmlhint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHTMLHINT)
using namespace Elhtmlhint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhtmlhintHPP
