// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCFCStateObject.pas' rev: 31.00 (Windows)

#ifndef LmdcfcstateobjectHPP
#define LmdcfcstateobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDCFCSettingObject.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdcfcstateobject {
typedef Byte TLMDStateList[7];
#define TLMDStateList TLMDStateList*
}

namespace Lmdcfcstateobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCFCStateObject;
class DELPHICLASS TLMDCFCStateObjects;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDStateKind : unsigned char { skFocused, skMouseAbove, skDown, skModified, skReadOnly, skWrongData, skDisabled };

typedef System::StaticArray<System::UnicodeString, 7> Lmdcfcstateobject__1;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCFCStateObject : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDStateList FKind;
	System::Classes::TStringList* FSettings;
	int FLinkIndex;
	void __fastcall SetStringList(System::Classes::TStringList* const Value);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadKind(System::Classes::TReader* Reader);
	void __fastcall WriteKind(System::Classes::TWriter* Writer);
	void __fastcall ReadSettings(System::Classes::TReader* Reader);
	void __fastcall WriteSettings(System::Classes::TWriter* Writer);
	
public:
	__fastcall virtual TLMDCFCStateObject(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDCFCStateObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Synchronize(void);
	void __fastcall SynchronizeName(void);
	bool __fastcall Paint(Vcl::Controls::TControl* aControl);
	TLMDStateList __fastcall getKind(void);
	void __fastcall setKind(const TLMDStateList &aStateList);
	bool __fastcall Add(System::Classes::TPersistent* aSettingObject, bool replace);
	int __fastcall IndexOfSetting(const Lmdcfcsettingobject::TLMDCFCSettingObjectKind aValue);
	
__published:
	__property System::Classes::TStringList* Settings = {read=FSettings, write=SetStringList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCFCStateObjects : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDCFCStateObject* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdcfcsettingobject::TLMDCFCSettingObjects* FObjects;
	HIDESBASE TLMDCFCStateObject* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDCFCStateObject* Value);
	void __fastcall SetObjects(Lmdcfcsettingobject::TLMDCFCSettingObjects* aValue);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDCFCStateObjects(Lmdcustomcomponent::TLMDCustomComponent* Owner);
	__fastcall virtual ~TLMDCFCStateObjects(void);
	HIDESBASE TLMDCFCStateObject* __fastcall Add(void);
	int __fastcall ItemByKind(const TLMDStateList &Index);
	__property TLMDCFCStateObject* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Lmdcfcsettingobject::TLMDCFCSettingObjects* SettingsObjects = {read=FObjects, write=SetObjects};
	void __fastcall Synchronize(void);
	void __fastcall SynchronizeNames(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 CFCSELFLINK = System::Int8(-2);
static const System::Int8 CFCCONTROLLINK = System::Int8(-1);
static const System::Int8 StateIgnore = System::Int8(0x0);
static const System::Int8 StateOn = System::Int8(0x1);
static const System::Int8 StateOff = System::Int8(0x2);
extern DELPHI_PACKAGE TLMDStateList stateNormal;
extern DELPHI_PACKAGE TLMDStateList stateDisabled;
extern DELPHI_PACKAGE TLMDStateList stateError;
extern DELPHI_PACKAGE TLMDStateList stateFocused;
extern DELPHI_PACKAGE TLMDStateList stateReadOnly;
extern DELPHI_PACKAGE TLMDStateList stateHot;
extern DELPHI_PACKAGE TLMDStateList statePressed;
extern DELPHI_PACKAGE TLMDStateList stateModified;
extern DELPHI_PACKAGE Lmdcfcstateobject__1 TLMDStateKindStr;
extern DELPHI_PACKAGE int __fastcall LMDCFCGetAvailableStatesCount(void);
extern DELPHI_PACKAGE bool __fastcall LMDCFCCompareStates(const TLMDStateList &s1, const TLMDStateList &s2);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCFCGetStateDescription(const TLMDStateList &state)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCFCGetStateDescription(int index)/* overload */;
}	/* namespace Lmdcfcstateobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCFCSTATEOBJECT)
using namespace Lmdcfcstateobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcfcstateobjectHPP
