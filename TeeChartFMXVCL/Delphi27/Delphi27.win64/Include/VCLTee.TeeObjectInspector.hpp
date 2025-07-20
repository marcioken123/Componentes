// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeObjectInspector.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeobjectinspectorHPP
#define Vcltee_TeeobjectinspectorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeInspector.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeobjectinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TClassEditor;
class DELPHICLASS TClassEditors;
class DELPHICLASS TObjectInspector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TClassEditor : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TClass ItemClass;
	System::Classes::TNotifyEvent Editor;
public:
	/* TObject.Create */ inline __fastcall TClassEditor() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TClassEditor() { }
	
};


class PASCALIMPLEMENTATION TClassEditors : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TClassEditor* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TClassEditor* __fastcall Get(int Index);
	HIDESBASE void __fastcall Put(int Index, TClassEditor* const Value);
	
public:
	HIDESBASE void __fastcall Add(System::TClass AClass, System::Classes::TNotifyEvent AEditor);
	virtual void __fastcall Clear();
	__property TClassEditor* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TClassEditors() { }
	
public:
	/* TObject.Create */ inline __fastcall TClassEditors() : System::Classes::TList() { }
	
};


typedef void __fastcall (__closure *TInspectorFilter)(TObjectInspector* Sender, System::TObject* Instance, const System::UnicodeString PropertyName, bool &Accept);

typedef void __fastcall (__closure *TInspectorChange)(Vcltee::Teeinspector::TTeeInspector* Sender, Vcltee::Teeinspector::TInspectorItem* Item);

class PASCALIMPLEMENTATION TObjectInspector : public Vcltee::Teeinspector::TTeeInspector
{
	typedef Vcltee::Teeinspector::TTeeInspector inherited;
	
private:
	TInspectorChange FOnChange;
	TInspectorFilter FOnFilter;
	void __fastcall ChangedInteger(System::TObject* Sender);
	void __fastcall ChangedFloat(System::TObject* Sender);
	void __fastcall ChangedSet(System::TObject* Sender);
	void __fastcall ChangedString(System::TObject* Sender);
	void __fastcall DoChanged(Vcltee::Teeinspector::TInspectorItem* Item);
	void __fastcall ExpandInspector(System::TObject* Sender);
	void __fastcall EditBoolean(System::TObject* Sender);
	void __fastcall EditStrings(System::TObject* Sender);
	void __fastcall FillInspector(Vcltee::Teeinspector::TTeeInspector* Inspector, System::Classes::TPersistent* O);
	void __fastcall GetEnumItems(Vcltee::Teeinspector::TInspectorItem* Sender, Vcltee::Teeinspector::TGetItemProc Proc);
	void __fastcall GetEnumItemIndex(Vcltee::Teeinspector::TInspectorItem* Sender, int &Index);
	System::UnicodeString __fastcall GetReadableEnum(const System::UnicodeString S);
	void __fastcall SetEnumItemIndex(Vcltee::Teeinspector::TInspectorItem* Sender, int Index);
	
protected:
	virtual bool __fastcall ItemExpandable(int ARow);
	
public:
	TClassEditors* ClassEditors;
	bool ReadableEnums;
	__fastcall virtual TObjectInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TObjectInspector();
	void __fastcall Inspect(System::Classes::TPersistent* O);
	
__published:
	__property TInspectorChange OnChange = {read=FOnChange, write=FOnChange};
	__property TInspectorFilter OnFilter = {read=FOnFilter, write=FOnFilter};
public:
	/* TWinControl.CreateParented */ inline __fastcall TObjectInspector(HWND ParentWindow) : Vcltee::Teeinspector::TTeeInspector(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeobjectinspector */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEOBJECTINSPECTOR)
using namespace Vcltee::Teeobjectinspector;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeobjectinspectorHPP
