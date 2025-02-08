// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDGridPE.pas' rev: 31.00 (Windows)

#ifndef PlmdgridpeHPP
#define PlmdgridpeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Controls.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <DesignMenus.hpp>
#include <LMDGrid.hpp>
#include <LMDDBGrid.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdgridpe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGridCompEditor;
class DELPHICLASS TLMDGridColumnsProperty;
class DELPHICLASS TLMDGridFieldNameProperty;
class DELPHICLASS TLMDGridChooserNameProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridCompEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDGridCompEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGridCompEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridColumnsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDGridColumnsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDGridColumnsProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridFieldNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
private:
	Lmdgrid::TLMDGridColumn* __fastcall Column(void);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDGridFieldNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDGridFieldNameProperty(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridChooserNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
private:
	System::Classes::TList* FAncList;
	System::Classes::TList* FCompList;
	System::Classes::TPersistent* FAncestor;
	System::Classes::TComponent* FRoot;
	System::Classes::TComponent* FRootAncestor;
	Lmdgrid::TLMDGridColumn* __fastcall Column(void);
	bool __fastcall PropFilter(System::UnicodeString APropName);
	bool __fastcall PropObjFilter(const Designintf::_di_IProperty AProp);
	HIDESBASE void __fastcall AddAncestor(System::Classes::TComponent* Component);
	void __fastcall AddToCompList(System::Classes::TComponent* Component);
	HIDESBASE void __fastcall GetLookupInfo(System::Classes::TPersistent* &Ancestor, System::Classes::TComponent* &Root, System::Classes::TComponent* &LookupRoot, System::Classes::TComponent* &RootAncestor);
	
protected:
	virtual bool __fastcall GetIsDefault(void);
	System::Classes::TComponent* __fastcall GetComponentReference(void);
	bool __fastcall ShowReferenceProperty(void);
	
public:
	virtual bool __fastcall AllEqual(void);
	virtual int __fastcall GetEditLimit(void);
	virtual System::UnicodeString __fastcall GetName(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetProperties(Designintf::TGetPropProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDGridChooserNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDGridChooserNameProperty(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
private:
	void *__IShowReferenceProperty;	// Designintf::IShowReferenceProperty 
	void *__IReferenceProperty;	// Designintf::IReferenceProperty 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {ECD009DA-C711-4C7F-912B-3AB5A6A4B290}
	operator Designintf::_di_IShowReferenceProperty()
	{
		Designintf::_di_IShowReferenceProperty intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Designintf::IShowReferenceProperty*(void) { return (Designintf::IShowReferenceProperty*)&__IShowReferenceProperty; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C7EE2B1E-3F89-40AD-9250-D2667BA3D46B}
	operator Designintf::_di_IReferenceProperty()
	{
		Designintf::_di_IReferenceProperty intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Designintf::IReferenceProperty*(void) { return (Designintf::IReferenceProperty*)&__IReferenceProperty; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdgridpe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDGRIDPE)
using namespace Plmdgridpe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdgridpeHPP
