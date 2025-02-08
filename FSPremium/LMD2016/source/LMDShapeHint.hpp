// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeHint.pas' rev: 31.00 (Windows)

#ifndef LmdshapehintHPP
#define LmdshapehintHPP

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
#include <LMDTypes.hpp>
#include <LMDPNGImage.hpp>
#include <LMDButtonBase.hpp>
#include <LMD3DCaption.hpp>
#include <LMDCustomHint.hpp>
#include <LMDCustomShapeHint.hpp>
#include <LMDNativeHint.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDGradient.hpp>
#include <LMDShadow.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeHint;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeHint : public Lmdcustomshapehint::TLMDCustomShapeHint
{
	typedef Lmdcustomshapehint::TLMDCustomShapeHint inherited;
	
__published:
	__property CloseBtnType = {default=1};
	__property CloseBtnStyle = {default=1};
	__property DefaultTitle = {default=0};
	__property DefaultIcon = {default=2};
	__property Enabled = {default=1};
	__property Font3D;
	__property Gradient;
	__property HideAccelChar = {default=1};
	__property Distance = {default=1};
	__property NoseLength = {default=25};
	__property NoseWidth = {default=25};
	__property NoseAngleWidth = {default=25};
	__property Options;
	__property Position = {default=1};
	__property RoundRectWidth = {default=18};
	__property Shadow;
	__property Style = {default=4};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TitleFont;
	__property TitleFont3D;
	__property UseGradient = {default=0};
	__property UseSystemShadow = {default=0};
public:
	/* TLMDCustomShapeHint.Create */ inline __fastcall virtual TLMDShapeHint(System::Classes::TComponent* AOwner) : Lmdcustomshapehint::TLMDCustomShapeHint(AOwner) { }
	/* TLMDCustomShapeHint.Destroy */ inline __fastcall virtual ~TLMDShapeHint(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPEHINT)
using namespace Lmdshapehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapehintHPP
