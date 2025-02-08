// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLabelFill.pas' rev: 31.00 (Windows)

#ifndef LmdlabelfillHPP
#define LmdlabelfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomLabelFill.hpp>
#include <LMDCustomLabel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlabelfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLabelFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLabelFill : public Lmdcustomlabelfill::TLMDCustomLabelFill
{
	typedef Lmdcustomlabelfill::TLMDCustomLabelFill inherited;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Bevel;
	__property BrushBackColor = {default=-16777201};
	__property Caption = {default=0};
	__property FillObject;
	__property FocusControl;
	__property Font;
	__property FontFX;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property MultiLine = {index=1, default=0};
	__property Options;
	__property ShowAccelChar = {index=2, default=1};
	__property Transparent = {default=1};
public:
	/* TLMDCustomLabelFill.Create */ inline __fastcall virtual TLMDLabelFill(System::Classes::TComponent* aOwner) : Lmdcustomlabelfill::TLMDCustomLabelFill(aOwner) { }
	/* TLMDCustomLabelFill.Destroy */ inline __fastcall virtual ~TLMDLabelFill(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlabelfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLABELFILL)
using namespace Lmdlabelfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlabelfillHPP
