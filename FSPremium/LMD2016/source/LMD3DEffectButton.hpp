// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMD3DEffectButton.pas' rev: 31.00 (Windows)

#ifndef Lmd3deffectbuttonHPP
#define Lmd3deffectbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustom3DButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDButtonBase.hpp>
#include <LMDButtonLayout.hpp>
#include <Vcl.Menus.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGlyph.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmd3deffectbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMD3DEffectButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMD3DEffectButton : public Lmdcustom3dbutton::TLMDCustom3DButton
{
	typedef Lmdcustom3dbutton::TLMDCustom3DButton inherited;
	
public:
	__fastcall virtual TLMD3DEffectButton(System::Classes::TComponent* AOwner);
	
__published:
	__property ButtonFace;
	__property ButtonLayout;
	__property DropDownMenu;
	__property EnterColor = {default=-16777207};
	__property EnterColorChange = {default=0};
	__property Glyph;
	__property NumGlyphs = {default=1};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Transparent = {default=0};
	__property GroupIndex = {default=0};
	__property AllowAllUp = {default=0};
	__property Compressed = {default=0};
	__property PixelFormat = {default=0};
	__property QuickDraw = {default=0};
public:
	/* TLMDCustom3DButton.Destroy */ inline __fastcall virtual ~TLMD3DEffectButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmd3deffectbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMD3DEFFECTBUTTON)
using namespace Lmd3deffectbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmd3deffectbuttonHPP
