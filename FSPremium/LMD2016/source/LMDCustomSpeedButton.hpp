// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomSpeedButton.pas' rev: 31.00 (Windows)

#ifndef LmdcustomspeedbuttonHPP
#define LmdcustomspeedbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDButtonLayout.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyph.hpp>
#include <LMDFXCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomspeedbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomSpeedButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomSpeedButton : public Lmdbasegraphicbutton::TLMDBaseGraphicButton
{
	typedef Lmdbasegraphicbutton::TLMDBaseGraphicButton inherited;
	
private:
	void __fastcall SetGlyphKind(Lmdbuttonbase::TLMDGlyphKind aValue);
	Lmdbuttonbase::TLMDUserButtonStyle __fastcall GetStyle(void);
	void __fastcall SetStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall ReadExtStyle(System::Classes::TReader* Reader);
	
protected:
	Lmdbuttonbase::TLMDGlyphKind FGlyphKind;
	Lmdbuttonbase::TLMDUserButtonStyle FStyle;
	bool FDesign;
	Vcl::Themes::TThemedElement __fastcall GetXPThemedClass(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetUnColorMain(bool aValue);
	bool __fastcall GetUnColorMain(void);
	virtual bool __fastcall ActionChangeable(void);
	virtual bool __fastcall IsCustom(void);
	virtual bool __fastcall IsHotState(void);
	virtual bool __fastcall IsHotOptionsetMode(void);
	virtual bool __fastcall RepaintOnMouse(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall Paint(void);
	void __fastcall RequestDefaultGlyph(void);
	__property Transparent = {default=1};
	__property bool Design = {read=FDesign, write=FDesign, default=1};
	
public:
	__fastcall virtual TLMDCustomSpeedButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSpeedButton(void);
	void __fastcall DoStateChange(Lmdbuttonbase::TLMDButtonState NewState, bool ForceUpdate = false);
	__property Lmdbuttonbase::TLMDGlyphKind GlyphKind = {read=FGlyphKind, write=SetGlyphKind, default=0};
	__property CtlXP = {default=1};
	__property Lmdbuttonbase::TLMDUserButtonStyle Style = {read=GetStyle, write=SetStyle, stored=false, nodefault};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FStyle, write=SetStyle, default=1};
	__property bool UnColorMain = {read=GetUnColorMain, write=SetUnColorMain, default=1};
	
__published:
	__property ButtonLayout;
	__property EnterColor = {default=-16777207};
	__property EnterColorChange = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property NumGlyphs = {default=1};
	__property Glyph;
	__property Font;
	__property FontFX;
	__property RepeatedClick = {default=0};
	__property RepeatingInterval = {default=100};
	__property RepeatingDelay = {default=500};
	__property UseCaption = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnDropDown;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSPEEDBUTTON)
using namespace Lmdcustomspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomspeedbuttonHPP
