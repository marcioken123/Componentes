// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBuffer.pas' rev: 34.00 (Windows)

#ifndef LmdbufferHPP
#define LmdbufferHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuffer
{
//-- forward type declarations -----------------------------------------------
struct TLMDDynNode;
class DELPHICLASS TLMDBuffer;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDDestroyItemEvent)(System::TObject* Sender, void * item);

typedef void __fastcall (__closure *TLMDGetItemSizeEvent)(System::TObject* Sender, void * item, int &size);

typedef TLMDDynNode *PLMDDynNode;

struct DECLSPEC_DRECORD TLMDDynNode
{
public:
	void *item;
	TLMDDynNode *next;
};


class PASCALIMPLEMENTATION TLMDBuffer : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
protected:
	int FUpdateCount;
	int FMaxEntries;
	int FCount;
	TLMDDestroyItemEvent FOnDestroyItem;
	TLMDGetItemSizeEvent FOnGetItemSize;
	virtual void __fastcall FirstNode(void * &node) = 0 ;
	virtual void __fastcall NextNode(void * &node) = 0 ;
	virtual void * __fastcall GetItem(void * node) = 0 ;
	int __fastcall GetItemSize(void * node);
	virtual bool __fastcall EOFBuffer(void * node) = 0 ;
	
public:
	__fastcall virtual TLMDBuffer(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDBuffer();
	virtual bool __fastcall IsEmpty() = 0 ;
	virtual bool __fastcall IsFull() = 0 ;
	virtual void __fastcall Put(void * item) = 0 ;
	virtual void * __fastcall Get() = 0 ;
	virtual void __fastcall Clear() = 0 ;
	HIDESBASE void __fastcall BeginUpdate();
	HIDESBASE void __fastcall EndUpdate();
	bool __fastcall Updating();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	__property int Count = {read=FCount, nodefault};
	__property int MaxEntries = {read=FMaxEntries, write=FMaxEntries, default=-1};
	__property TLMDDestroyItemEvent OnDestroyItem = {read=FOnDestroyItem, write=FOnDestroyItem};
	__property TLMDGetItemSizeEvent OnGetItemSize = {read=FOnGetItemSize, write=FOnGetItemSize};
};


//-- var, const, procedure ---------------------------------------------------
#define buffer_type L"@LMDBufferStream-V0.1@"
}	/* namespace Lmdbuffer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUFFER)
using namespace Lmdbuffer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbufferHPP
