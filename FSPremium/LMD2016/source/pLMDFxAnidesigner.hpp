﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDFxAniDesigner.pas' rev: 31.00 (Windows)

#ifndef PlmdfxanidesignerHPP
#define PlmdfxanidesignerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <DesignWindows.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDFxAnimation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdfxanidesigner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxAnimationPropertyEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxAnimationPropertyEditor : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDFxAnimationPropertyEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDFxAnimationPropertyEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdfxanidesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDFXANIDESIGNER)
using namespace Plmdfxanidesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdfxanidesignerHPP
