// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCPGetMain.pas' rev: 31.00 (Windows)

#ifndef PlmdcpgetmainHPP
#define PlmdcpgetmainHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDLED.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCont.hpp>
#include <LMDDateL.hpp>
#include <LMDDateTime.hpp>
#include <LMDCustom3DButton.hpp>
#include <LMDShape.hpp>
#include <LMDTeeth.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDShapeFill.hpp>
#include <LMDShadow.hpp>
#include <LMDPointList.hpp>
#include <LMDCaption.hpp>
#include <LMDRegionMask.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcpgetmain
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDCPGetButtonFace3D(Lmdcustom3dbutton::TLMDCustom3DButton* aComponent);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetLMDCaption(Lmdcaption::TLMDCaption* aCaption, bool AllowMultiline);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetLED(Lmdled::TLMDLED* aLed);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetShadow(Lmdshadow::TLMDShadow* aShadow);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetShapeFill(Lmdshapefill::TLMDShapeFill* aShapeFill);
extern DELPHI_PACKAGE Lmdshape::TLMDShapeType __fastcall LMDCPGetShape(Lmdshape::TLMDShapeType aShape);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetSimpleBevel(Lmdsimplebevel::TLMDSimpleBevel* aSimpleBevel);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetTeeth(Lmdteeth::TLMDTeeth* aTeeth);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetPointList(Lmdpointlist::TLMDPointList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetDateList(Lmddatel::TLMDDateList* aValue);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetRegionMask(Lmdregionmask::TLMDRegionMask* aValue, bool border);
extern DELPHI_PACKAGE Lmdgraph::TLMDLightColor __fastcall LMDCPGetLightColor(Lmdgraph::TLMDLightColor aLightColor);
}	/* namespace Plmdcpgetmain */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCPGETMAIN)
using namespace Plmdcpgetmain;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcpgetmainHPP
