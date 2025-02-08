// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDOIEnh.pas' rev: 31.00 (Windows)

#ifndef PlmdoienhHPP
#define PlmdoienhHPP

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
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdoienh
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSetProperty;
class DELPHICLASS TLMDSetElementProperty;
class DELPHICLASS TLMDBoolProperty;
class DELPHICLASS TLMDBooleanProperty;
class DELPHICLASS TLMDFontProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetProperty : public Vcleditors::TSetProperty
{
	typedef Vcleditors::TSetProperty inherited;
	
public:
	System::Typinfo::TTypeInfo *FEnumInfo;
	virtual void __fastcall Initialize(void);
	virtual void __fastcall GetProperties(Designintf::TGetPropProc Proc);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc AProc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDSetProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Vcleditors::TSetProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDSetProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetElementProperty : public Vcleditors::TSetElementProperty
{
	typedef Vcleditors::TSetElementProperty inherited;
	
public:
	HIDESBASE void __fastcall PropDrawName(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	HIDESBASE void __fastcall PropDrawValue(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TSetElementProperty.Create */ inline __fastcall TLMDSetElementProperty(Designeditors::TPropertyEditor* Parent, int AElement) : Vcleditors::TSetElementProperty(Parent, AElement) { }
	
public:
	/* TNestedProperty.Destroy */ inline __fastcall virtual ~TLMDSetElementProperty(void) { }
	
private:
	void *__ICustomPropertyDrawing;	// Vcleditors::ICustomPropertyDrawing 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E1A50419-1288-4B26-9EFA-6608A35F0824}
	operator Vcleditors::_di_ICustomPropertyDrawing()
	{
		Vcleditors::_di_ICustomPropertyDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyDrawing*(void) { return (Vcleditors::ICustomPropertyDrawing*)&__ICustomPropertyDrawing; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBoolProperty : public Designeditors::TEnumProperty
{
	typedef Designeditors::TEnumProperty inherited;
	
public:
	void __fastcall PropDrawName(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	void __fastcall PropDrawValue(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDBoolProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TEnumProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDBoolProperty(void) { }
	
private:
	void *__ICustomPropertyDrawing;	// Vcleditors::ICustomPropertyDrawing 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E1A50419-1288-4B26-9EFA-6608A35F0824}
	operator Vcleditors::_di_ICustomPropertyDrawing()
	{
		Vcleditors::_di_ICustomPropertyDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyDrawing*(void) { return (Vcleditors::ICustomPropertyDrawing*)&__ICustomPropertyDrawing; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBooleanProperty : public Designeditors::TEnumProperty
{
	typedef Designeditors::TEnumProperty inherited;
	
public:
	void __fastcall PropDrawName(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	void __fastcall PropDrawValue(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDBooleanProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TEnumProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDBooleanProperty(void) { }
	
private:
	void *__ICustomPropertyDrawing;	// Vcleditors::ICustomPropertyDrawing 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E1A50419-1288-4B26-9EFA-6608A35F0824}
	operator Vcleditors::_di_ICustomPropertyDrawing()
	{
		Vcleditors::_di_ICustomPropertyDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyDrawing*(void) { return (Vcleditors::ICustomPropertyDrawing*)&__ICustomPropertyDrawing; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontProperty : public Vcleditors::TFontProperty
{
	typedef Vcleditors::TFontProperty inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	void __fastcall PropDrawName(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	void __fastcall PropDrawValue(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDFontProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Vcleditors::TFontProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDFontProperty(void) { }
	
private:
	void *__ICustomPropertyDrawing;	// Vcleditors::ICustomPropertyDrawing 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E1A50419-1288-4B26-9EFA-6608A35F0824}
	operator Vcleditors::_di_ICustomPropertyDrawing()
	{
		Vcleditors::_di_ICustomPropertyDrawing intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcleditors::ICustomPropertyDrawing*(void) { return (Vcleditors::ICustomPropertyDrawing*)&__ICustomPropertyDrawing; }
	#endif
	
};

#pragma pack(pop)

typedef System::Int8 TLMDSet;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdoienh */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDOIENH)
using namespace Plmdoienh;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdoienhHPP
