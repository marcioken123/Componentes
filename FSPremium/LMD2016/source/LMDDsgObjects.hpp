// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgObjects.pas' rev: 31.00 (Windows)

#ifndef LmddsgobjectsHPP
#define LmddsgobjectsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgobjects
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ILMDDsgObjsNotifier;
class DELPHICLASS TLMDDesignObjects;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDDsgObjsNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Changed(TLMDDesignObjects* ASender) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDDsgObjsNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDDsgObjsNotifier(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDesignObjects : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	System::Classes::TPersistent* operator[](int AIndex) { return this->Item[AIndex]; }
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FItems;
	System::Classes::TList* FNotifiers;
	int FUpdateCount;
	bool FChanged;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall Changed(void);
	int __fastcall GetCount(void);
	System::Classes::TPersistent* __fastcall GetItem(int AIndex);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall DoChange(void);
	
public:
	__fastcall virtual TLMDDesignObjects(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDesignObjects(void);
	void __fastcall AddNotifier(ILMDDsgObjsNotifier* ANotifier);
	void __fastcall RemoveNotifier(ILMDDsgObjsNotifier* ANotifier);
	void __fastcall Clear(void);
	void __fastcall Add(System::Classes::TPersistent* AItem);
	void __fastcall Delete(int AIndex);
	HIDESBASE void __fastcall Remove(System::Classes::TPersistent* AItem);
	int __fastcall IndexOf(System::Classes::TPersistent* AItem);
	void __fastcall SetItems(System::Classes::TList* AItems);
	void __fastcall GetItems(System::Classes::TList* AResult);
	void __fastcall GetComps(System::Classes::TList* AResult);
	void __fastcall SetOne(System::Classes::TPersistent* AItem);
	void __fastcall CopyFrom(TLMDDesignObjects* AObjects);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property int Count = {read=GetCount, nodefault};
	__property System::Classes::TPersistent* Item[int AIndex] = {read=GetItem/*, default*/};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgobjects */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGOBJECTS)
using namespace Lmddsgobjects;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgobjectsHPP
