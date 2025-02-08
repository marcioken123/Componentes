// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGraphicLabel.pas' rev: 31.00 (Windows)

#ifndef LmdgraphiclabelHPP
#define LmdgraphiclabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomGraphicLabel.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDGrlf.hpp>
#include <LMDBevel.hpp>
#include <LMDGraphicControl.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgraphiclabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGraphicLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGraphicLabel : public Lmdcustomgraphiclabel::TLMDCustomGraphicLabel
{
	typedef Lmdcustomgraphiclabel::TLMDCustomGraphicLabel inherited;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Attributes = {default=4};
	__property AutoSize = {index=1, default=0};
	__property Bevel;
	__property BrushBackColor = {default=-16777201};
	__property Caption = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Factor = {index=2, default=5};
	__property FillObject;
	__property Font;
	__property FontFX;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property InvertCaption = {index=2, default=0};
	__property Perspective = {default=1};
	__property PerspectiveDepth = {index=4, default=5};
	__property Toggle = {default=0};
	__property Transform = {default=0};
	__property Transparent = {default=0};
public:
	/* TLMDCustomGraphicLabel.Create */ inline __fastcall virtual TLMDGraphicLabel(System::Classes::TComponent* aOwner) : Lmdcustomgraphiclabel::TLMDCustomGraphicLabel(aOwner) { }
	/* TLMDCustomGraphicLabel.Destroy */ inline __fastcall virtual ~TLMDGraphicLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdgraphiclabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRAPHICLABEL)
using namespace Lmdgraphiclabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgraphiclabelHPP
