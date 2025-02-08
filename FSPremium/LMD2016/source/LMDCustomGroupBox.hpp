// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomGroupBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomgroupboxHPP
#define LmdcustomgroupboxHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFXCaption.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomgroupbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomGroupBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDGroupCaptionAlign : unsigned char { gcaTopLeft, gcaTopCenter, gcaTopRight, gcaLeftBottom, gcaLeftCenter, gcaLeftTop, gcaBottomLeft, gcaBottomCenter, gcaBottomRight, gcaRightTop, gcaRightCenter, gcaRightBottom };

class PASCALIMPLEMENTATION TLMDCustomGroupBox : public Lmdcustomparentpanel::TLMDCustomParentPanel
{
	typedef Lmdcustomparentpanel::TLMDCustomParentPanel inherited;
	
private:
	bool FAccelChar;
	TLMDGroupCaptionAlign FAlignCaption;
	int FCaptionOffSet;
	Vcl::Graphics::TFont* FCaptionFont;
	bool FCaptionParentFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	bool FCtlXPCaption;
	int FCaptionHeight;
	Lmdfxcaption::TLMDFxCaption* FFontFX;
	void __fastcall SetAlignCaption(TLMDGroupCaptionAlign aValue);
	void __fastcall SetAccelChar(bool aValue);
	void __fastcall SetCaptionOffset(int aValue);
	void __fastcall SetCaptionFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetCaptionParentFont(bool aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetCtlXPCaption(bool Value);
	void __fastcall SetCaptionHeight(void);
	int __fastcall GetCaptionHeight(void);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	__property int CaptionHeight = {read=GetCaptionHeight, nodefault};
	
public:
	__fastcall virtual TLMDCustomGroupBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomGroupBox(void);
	__property TLMDGroupCaptionAlign Alignment = {read=FAlignCaption, write=SetAlignCaption, default=0};
	__property Vcl::Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Lmd3dcaption::TLMD3DCaption* CaptionFont3D = {read=FFont3D, write=SetFont3D};
	__property int CaptionOffset = {read=FCaptionOffSet, write=SetCaptionOffset, default=8};
	__property bool CaptionParentFont = {read=FCaptionParentFont, write=SetCaptionParentFont, default=1};
	__property CtlXP = {default=1};
	__property bool ShowAccelChar = {read=FAccelChar, write=SetAccelChar, default=1};
	
__published:
	__property bool CtlXPCaptionColor = {read=FCtlXPCaption, write=SetCtlXPCaption, default=1};
	__property ParentColor = {default=1};
	__property ParentBackground = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomGroupBox(HWND ParentWindow) : Lmdcustomparentpanel::TLMDCustomParentPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomgroupbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMGROUPBOX)
using namespace Lmdcustomgroupbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomgroupboxHPP
