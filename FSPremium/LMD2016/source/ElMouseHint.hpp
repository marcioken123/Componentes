// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMouseHint.pas' rev: 31.00 (Windows)

#ifndef ElmousehintHPP
#define ElmousehintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUtils.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElComponent.hpp>
#include <ElHintWnd.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmousehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElMouseHint;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElMouseHintLocation : unsigned char { hlLeftTop, hlLeftCenter, hlLeftBottom, hlRightTop, hlRightCenter, hlRightBottom, hlCenterTop, hlCenterBottom };

typedef System::Set<TElMouseHintLocation, TElMouseHintLocation::hlLeftTop, TElMouseHintLocation::hlCenterBottom> TElMousehintLocations;

class PASCALIMPLEMENTATION TElMouseHint : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Elhintwnd::TElHintWindow* FHintWindow;
	
protected:
	bool FActive;
	bool FAutoSize;
	bool FIsHTML;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	bool FUseSystemHintSettings;
	System::Classes::TStrings* FLines;
	bool FWordWrap;
	System::Uitypes::TColor FColor;
	int FWidth;
	int FHeight;
	TElMouseHintLocation FLocation;
	Vcl::Graphics::TFont* FFont;
	Vcl::Controls::TControl* FBoundingControl;
	bool FVisible;
	int FDistanceToHint;
	bool FKeepWithinWindow;
	int FHideCount;
	TElMousehintLocations FLocations;
	bool FAutoAdjustLocation;
	void __fastcall SetActive(bool Value);
	void __fastcall SetAutoSize(bool Value);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	void __fastcall SetIsHTML(bool Value);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall SetLines(System::Classes::TStrings* Value);
	void __fastcall LinesChange(System::TObject* Sender);
	Lmdtypes::TLMDString __fastcall GetCaption(void);
	void __fastcall BuildHint(void);
	void __fastcall SetWordWrap(bool Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetWidth(int Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetLocation(TElMouseHintLocation Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall SetBoundingControl(Vcl::Controls::TControl* Value);
	Vcl::Controls::TControl* __fastcall GetBoundingControl(void);
	void __fastcall UpdateHintPos(const System::Types::TPoint &MousePos, Vcl::Controls::TControl* Control);
	System::Types::TRect __fastcall DoUpdatePos(const System::Types::TPoint &MousePos, TElMouseHintLocation Location);
	void __fastcall SetDistanceToHint(int Value);
	void __fastcall SetUseSystemHintSettings(bool Value);
	void __fastcall DoShowHintWindow(void);
	void __fastcall DoHideHintWindow(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	void __fastcall SetKeepWithinWindow(bool Value);
	void __fastcall SetAutoAdjustLocation(bool Value);
	__property TElMousehintLocations Locations = {read=FLocations, write=FLocations, nodefault};
	
public:
	__fastcall virtual TElMouseHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElMouseHint(void);
	void __fastcall ShowHint(void);
	void __fastcall HideHint(void);
	virtual void __fastcall Loaded(void);
	void __fastcall ShowLines(System::Classes::TStrings* Lines);
	void __fastcall ShowString(Lmdtypes::TLMDString Caption);
	__property bool Visible = {read=GetVisible, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, nodefault};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property bool UseSystemHintSettings = {read=FUseSystemHintSettings, write=SetUseSystemHintSettings, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines, stored=false};
	__property Vcl::Controls::TControl* BoundingControl = {read=FBoundingControl, write=SetBoundingControl};
	__property int DistanceToHint = {read=FDistanceToHint, write=SetDistanceToHint, default=2};
	__property bool KeepWithinWindow = {read=FKeepWithinWindow, write=SetKeepWithinWindow, default=0};
	__property bool AutoAdjustLocation = {read=FAutoAdjustLocation, write=SetAutoAdjustLocation, default=0};
	__property TElMouseHintLocation Location = {read=FLocation, write=SetLocation, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elmousehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMOUSEHINT)
using namespace Elmousehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElmousehintHPP
