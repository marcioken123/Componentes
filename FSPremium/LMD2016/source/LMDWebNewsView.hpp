// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebNewsView.pas' rev: 31.00 (Windows)

#ifndef LmdwebnewsviewHPP
#define LmdwebnewsviewHPP

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
#include <Vcl.Controls.hpp>
#include <LMDWebBase.hpp>
#include <LMDWebConst.hpp>
#include <LMDURLSupp.hpp>
#include <LMDWebXML.hpp>
#include <LMDNews.hpp>
#include <LMDWebNewsViewForm.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebnewsview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebNewsFormOptions;
class DELPHICLASS TLMDWebNewsView;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebNewsFormOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FCaption;
	bool FShowToolsBar;
	bool FShowGetNewsButton;
	bool FShowHelpButton;
	bool FShowPropertiesButton;
	System::UnicodeString FGetNewsButtonHint;
	System::UnicodeString FHelpButtonHint;
	System::UnicodeString FPropertiesButtonHint;
	
public:
	__fastcall TLMDWebNewsFormOptions(void);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property bool ShowToolsBar = {read=FShowToolsBar, write=FShowToolsBar, default=0};
	__property bool ShowGetNewsButton = {read=FShowGetNewsButton, write=FShowGetNewsButton, default=1};
	__property bool ShowHelpButton = {read=FShowHelpButton, write=FShowHelpButton, default=1};
	__property bool ShowPropertiesButton = {read=FShowPropertiesButton, write=FShowPropertiesButton, default=1};
	__property System::UnicodeString GetNewsButtonHint = {read=FGetNewsButtonHint, write=FGetNewsButtonHint};
	__property System::UnicodeString HelpButtonHint = {read=FHelpButtonHint, write=FHelpButtonHint};
	__property System::UnicodeString PropertiesButtonHint = {read=FPropertiesButtonHint, write=FPropertiesButtonHint};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDWebNewsFormOptions(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWebNewsView : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	bool FLoading;
	Vcl::Controls::TImageList* FImageList;
	Lmdnews::TLMDWebNews* FNews;
	TLMDWebNewsFormOptions* FNewsFormOptions;
	Lmdwebnewsviewform::TLMDOnNewsEvent FOnNewsClick;
	System::Classes::TNotifyEvent FOnNewsHint;
	System::Classes::TNotifyEvent FOnGetNewsClick;
	System::Classes::TNotifyEvent FOnHelpClick;
	System::Classes::TNotifyEvent FOnPropertiesClick;
	void __fastcall SetImageList(Vcl::Controls::TImageList* const Value);
	void __fastcall SetLoading(const bool Value);
	void __fastcall SetNews(Lmdnews::TLMDWebNews* const Value);
	void __fastcall SetNewsFormOptions(TLMDWebNewsFormOptions* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDWebNewsView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebNewsView(void);
	void __fastcall Execute(void);
	
__published:
	__property Lmdnews::TLMDWebNews* News = {read=FNews, write=SetNews};
	__property Vcl::Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property bool Loading = {read=FLoading, write=SetLoading, default=1};
	__property TLMDWebNewsFormOptions* NewsFormOptions = {read=FNewsFormOptions, write=SetNewsFormOptions};
	__property Lmdwebnewsviewform::TLMDOnNewsEvent OnNewsClick = {read=FOnNewsClick, write=FOnNewsClick};
	__property System::Classes::TNotifyEvent OnNewsHint = {read=FOnNewsHint, write=FOnNewsHint};
	__property System::Classes::TNotifyEvent OnGetNewsClick = {read=FOnGetNewsClick, write=FOnGetNewsClick};
	__property System::Classes::TNotifyEvent OnHelpClick = {read=FOnHelpClick, write=FOnHelpClick};
	__property System::Classes::TNotifyEvent OnPropertiesClick = {read=FOnPropertiesClick, write=FOnPropertiesClick};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebnewsview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBNEWSVIEW)
using namespace Lmdwebnewsview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebnewsviewHPP
