// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCFCSettingObject.pas' rev: 31.00 (Windows)

#ifndef LmdcfcsettingobjectHPP
#define LmdcfcsettingobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDObject.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcfcsettingobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCFCSettingObjects;
class DELPHICLASS TLMDColorObject;
class DELPHICLASS TLMDCtlSettings;
class DELPHICLASS TLMDStyleObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDCFCSettingObjectKind : unsigned char { cfcUnknown, cfcFont, cfcFont3D, cfcFontFX, cfcFillObject, cfcBitmapEffect, cfcBevel, cfcColor, cfcCtlSettings, cfcStyle };

class PASCALIMPLEMENTATION TLMDCFCSettingObjects : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	System::Classes::TPersistent* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TStringList* FList;
	int __fastcall GetCount(void);
	System::Classes::TPersistent* __fastcall GetItem(int index);
	void __fastcall SetItem(int Index, System::Classes::TPersistent* aObject);
	System::UnicodeString __fastcall GetObjName(int Index);
	void __fastcall SetObjName(int Index, const System::UnicodeString Value);
	void __fastcall ReadData(System::Classes::TReader* Reader);
	void __fastcall WriteData(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDCFCSettingObjects(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCFCSettingObjects(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall Add(System::Classes::TPersistent* aObject, System::UnicodeString aName = System::UnicodeString())/* overload */;
	int __fastcall Add(TLMDCFCSettingObjectKind aKind)/* overload */;
	void __fastcall Clear(void);
	__classmethod void __fastcall CreateCFCObject(System::Classes::TPersistentClass aClass, System::Classes::TPersistent* &anObject);
	int __fastcall FindInstanceOf(System::Classes::TPersistentClass AClass, bool AExact = true, int AStartAt = 0x0);
	HIDESBASE void __fastcall Insert(int Index, System::Classes::TPersistent* aObject, const System::UnicodeString aName = System::UnicodeString());
	int __fastcall IndexOf(const System::UnicodeString aName);
	int __fastcall IndexOfObject(System::Classes::TPersistent* aObject);
	System::UnicodeString __fastcall NameOfObject(System::Classes::TPersistent* aObject);
	HIDESBASE int __fastcall Remove(System::Classes::TPersistent* aObject);
	System::UnicodeString __fastcall UniqueName(const System::UnicodeString BaseName);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString aFilename);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromFile(const System::UnicodeString aFilename);
	__property int Count = {read=GetCount, nodefault};
	__property System::Classes::TPersistent* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property System::UnicodeString Names[int Index] = {read=GetObjName, write=SetObjName};
};


class PASCALIMPLEMENTATION TLMDColorObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FColor;
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDColorObject(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777201};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDColorObject(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCtlSettings : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	bool FTransparent;
	bool FCtlXP;
	void __fastcall SetBoolean(int Index, const bool Value);
	bool __fastcall GetBoolean(int Index);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDCtlSettings(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property bool Transparent = {read=GetBoolean, write=SetBoolean, index=0, default=0};
	__property bool CtlXP = {read=GetBoolean, write=SetBoolean, index=1, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCtlSettings(void) { }
	
};


class PASCALIMPLEMENTATION TLMDStyleObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::UnicodeString FStyleName;
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDStyleObject(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDStyleObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDCFCSettingObjectKind __fastcall LMDCFCGetSettingsKindObject(System::Classes::TPersistent* aObject);
extern DELPHI_PACKAGE TLMDCFCSettingObjectKind __fastcall LMDCFCGetSettingsKindClass(System::Classes::TPersistentClass aObject);
extern DELPHI_PACKAGE System::Classes::TPersistentClass __fastcall LMDCFCGetSettingsClass(TLMDCFCSettingObjectKind aKind);
}	/* namespace Lmdcfcsettingobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCFCSETTINGOBJECT)
using namespace Lmdcfcsettingobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcfcsettingobjectHPP
