// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCLabel.pas' rev: 31.00 (Windows)

#ifndef ElclabelHPP
#define ElclabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <ElStyleMan.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elclabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElLabel : public Vcl::Stdctrls::TCustomLabel
{
	typedef Vcl::Stdctrls::TCustomLabel inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdtypes::TLMDString FHint;
	Lmdtypes::TLMDString FCaption;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FEndEllipsis;
	Vcl::Controls::TBorderWidth FBorderWidth;
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetUseXPThemes(bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall AdjustBounds(void);
	virtual void __fastcall SetAutoSize(bool newValue);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall Loaded(void);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	void __fastcall SetEndEllipsis(bool Value);
	virtual void __fastcall SetBorderWidth(Vcl::Controls::TBorderWidth Value);
	virtual void __fastcall Paint(void);
	__property bool EndEllipsis = {read=FEndEllipsis, write=SetEndEllipsis, default=0};
	
public:
	__fastcall virtual TCustomElLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElLabel(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	bool __fastcall IsThemed(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Color;
	__property Transparent = {default=1};
	__property Vcl::Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
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
}	/* namespace Elclabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCLABEL)
using namespace Elclabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElclabelHPP
