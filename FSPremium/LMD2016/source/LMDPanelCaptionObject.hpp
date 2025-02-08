// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPanelCaptionObject.pas' rev: 31.00 (Windows)

#ifndef LmdpanelcaptionobjectHPP
#define LmdpanelcaptionobjectHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpanelcaptionobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPanelCaptionObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPanelCaptionButton : unsigned char { pcsHelp, pcsMinMax, pcsClose };

typedef System::Set<TLMDPanelCaptionButton, TLMDPanelCaptionButton::pcsHelp, TLMDPanelCaptionButton::pcsClose> TLMDPanelCaptionButtons;

enum DECLSPEC_DENUM TLMDPanelCaptionDrawMode : unsigned char { pcdWindows, pcdNormal, pcdOwnerDraw };

class PASCALIMPLEMENTATION TLMDPanelCaptionObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Classes::TComponent* FOwner;
	bool FVisible;
	Lmdgraph::TLMDFrameSide FPosition;
	int FHeight;
	System::Uitypes::TColor FColor;
	TLMDPanelCaptionDrawMode FPaintMode;
	System::Uitypes::TColor FInActiveColor;
	int FFontSize;
	System::Uitypes::TColor FFontActiveColor;
	System::Uitypes::TColor FFontInActiveColor;
	System::Uitypes::TFontName FFontName;
	Lmdgraph::TLMDAlignment FAlignment;
	TLMDPanelCaptionButtons FButtons;
	System::Byte FCaptionGap;
	System::Byte FButtonGap;
	bool __fastcall IsCustom(void);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetPosition(const Lmdgraph::TLMDFrameSide Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetPaintMode(const TLMDPanelCaptionDrawMode Value);
	void __fastcall SetInActiveColor(const System::Uitypes::TColor Value);
	void __fastcall SetFontActiveColor(const System::Uitypes::TColor Value);
	void __fastcall SetFontInActiveColor(const System::Uitypes::TColor Value);
	void __fastcall SetFontName(const System::Uitypes::TFontName Value);
	void __fastcall SetFontSize(const int Value);
	void __fastcall SetAlignment(const Lmdgraph::TLMDAlignment Value);
	void __fastcall SetButtons(const TLMDPanelCaptionButtons Value);
	void __fastcall SetCaptionGap(const System::Byte Value);
	void __fastcall SetButtonGap(const System::Byte Value);
	
protected:
	DYNAMIC void __fastcall Change(void);
	void __fastcall ChangeExt(void);
	
public:
	__fastcall TLMDPanelCaptionObject(void)/* overload */;
	__fastcall TLMDPanelCaptionObject(System::Classes::TComponent* aOwner)/* overload */;
	__fastcall virtual ~TLMDPanelCaptionObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Byte ButtonGap = {read=FButtonGap, write=SetButtonGap, default=1};
	__property System::Byte CaptionGap = {read=FCaptionGap, write=SetCaptionGap, default=2};
	__property TLMDPanelCaptionButtons Buttons = {read=FButtons, write=SetButtons, default=4};
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=3};
	__property TLMDPanelCaptionDrawMode PaintMode = {read=FPaintMode, write=SetPaintMode, default=0};
	__property System::Uitypes::TColor ActiveColor = {read=FColor, write=SetColor, default=-16777214};
	__property System::Uitypes::TColor InActiveColor = {read=FInActiveColor, write=SetInActiveColor, default=-16777213};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFontName, stored=IsCustom};
	__property int FontSize = {read=FFontSize, write=SetFontSize, default=10};
	__property System::Uitypes::TColor FontActiveColor = {read=FFontActiveColor, write=SetFontActiveColor, default=-16777207};
	__property System::Uitypes::TColor FontInActiveColor = {read=FFontInActiveColor, write=SetFontInActiveColor, default=-16777197};
	__property int Height = {read=FHeight, write=SetHeight, default=18};
	__property Lmdgraph::TLMDFrameSide Position = {read=FPosition, write=SetPosition, default=3};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 def_CaptionHeight = System::Int8(0x12);
static const System::Int8 def_CaptionFontSize = System::Int8(0xa);
}	/* namespace Lmdpanelcaptionobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPANELCAPTIONOBJECT)
using namespace Lmdpanelcaptionobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpanelcaptionobjectHPP
