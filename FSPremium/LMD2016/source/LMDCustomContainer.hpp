// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomContainer.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcontainerHPP
#define LmdcustomcontainerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Controls.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseController.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcontainer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListItem;
class DELPHICLASS TLMDCustomContainer;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDListItemClassType : unsigned char { icImageList, icBitmap, icWave, icStringList, icGeneric, icImageListItem, icInvalid };

class PASCALIMPLEMENTATION TLMDListItem : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int __fastcall GetIndex(void);
	
protected:
	System::UnicodeString FDescription;
	System::Word FIdent;
	bool FCompressed;
	void __fastcall AssignStd(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall Change(void);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	System::Byte __fastcall ReadStd(System::Classes::TStream* Stream);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	void __fastcall WriteStd(System::Classes::TStream* Stream);
	
public:
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall FreeData(void);
	__property int ListIndex = {read=GetIndex, nodefault};
	__property Owner;
	__property bool Empty = {read=GetEmpty, nodefault};
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=0};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property System::Word Ident = {read=FIdent, write=FIdent, nodefault};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDListItem(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDListItem(void) { }
	
};


typedef System::TMetaClass* TLMDListItemClass;

enum DECLSPEC_DENUM TLMDContainerSource : unsigned char { sdComponent, sdFile, sdAppResource, sdLibResource, sdPath };

class PASCALIMPLEMENTATION TLMDCustomContainer : public Lmdbasecontroller::TLMDBaseController
{
	typedef Lmdbasecontroller::TLMDBaseController inherited;
	
private:
	void __fastcall SetSource(TLMDContainerSource aValue);
	void __fastcall SetPrefix(Lmdprocs::TLMDPathPrefix aValue);
	TLMDListItem* __fastcall GetItemByName(System::UnicodeString index);
	
protected:
	bool FDefault;
	Lmdprocs::TLMDPathPrefix FPrefix;
	TLMDContainerSource FSource;
	System::Sysutils::TFileName FFileName;
	System::Classes::TList* FList;
	TLMDListItemClass FListClass;
	TLMDListItemClassType FListType;
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	virtual int __fastcall GetCount(void);
	virtual bool __fastcall GetEmpty(void);
	virtual TLMDListItem* __fastcall GetItem(int index);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream, bool flag);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream, bool flag);
	void __fastcall Update(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCustomContainer(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomContainer(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall Add(TLMDListItem* aValue = (TLMDListItem*)(0x0));
	void __fastcall AddList(TLMDCustomContainer* aValue);
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	int __fastcall IndexOf(TLMDListItem* aValue);
	HIDESBASE void __fastcall Insert(int Index, TLMDListItem* aValue = (TLMDListItem*)(0x0));
	void __fastcall Move(int OldIndex, int NewIndex);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	__property int Count = {read=GetCount, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property TLMDListItem* Contents[int Index] = {read=GetItem};
	__property TLMDListItem* ContentsByName[System::UnicodeString Index] = {read=GetItemByName};
	__property bool DefaultCompressed = {read=FDefault, write=FDefault, default=0};
	__property TLMDContainerSource Source = {read=FSource, write=SetSource, default=0};
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=FFileName};
	__property Lmdprocs::TLMDPathPrefix FilePrefix = {read=FPrefix, write=SetPrefix, default=2};
	
__published:
	__property About = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::SmallString<3>, 7> LMDICEXTENSION;
extern DELPHI_PACKAGE System::StaticArray<System::SmallString<8>, 7> LMD_ICInfo;
static const System::Int8 ITF_COMPRESSED = System::Int8(0x1);
static const System::Int8 ITF_DESCRIPTION = System::Int8(0x2);
static const System::Int8 ITF_IDENT = System::Int8(0x4);
static const System::Int8 ITF_DATA = System::Int8(0x8);
extern DELPHI_PACKAGE System::StaticArray<bool, 7> LMD_ICRegistered;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDICGetSuffix(TLMDListItemClassType aValue, bool AddPoint);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDICGetItemSuffix(TLMDListItemClassType aValue, bool AddPoint);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDListGetTypeName(TLMDListItemClassType typ);
extern DELPHI_PACKAGE TLMDListItemClassType __fastcall LMDListGetFileType(const System::UnicodeString FileName, int &aCount, System::Classes::TList* aList);
extern DELPHI_PACKAGE bool __fastcall LMDListGetItemFromStream(System::Classes::TStream* Stream, System::Classes::TList* aList, int Index, TLMDListItem* aItem);
extern DELPHI_PACKAGE bool __fastcall LMDListGetItemFromFile(const System::UnicodeString FileName, TLMDListItemClassType aType, System::Classes::TList* aList, int Index, TLMDListItem* aItem);
}	/* namespace Lmdcustomcontainer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCONTAINER)
using namespace Lmdcustomcontainer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcontainerHPP
