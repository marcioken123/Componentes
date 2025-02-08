// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBufferComponent.pas' rev: 31.00 (Windows)

#ifndef LmdbuffercomponentHPP
#define LmdbuffercomponentHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBuffer.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuffercomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBufferComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBufferComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int FMaxEntries;
	Lmdbuffer::TLMDGetItemSizeEvent FOnGetItemSize;
	Lmdbuffer::TLMDDestroyItemEvent FOnDeleteItem;
	void __fastcall SetInteger(int aValue);
	
protected:
	Lmdbuffer::TLMDBuffer* FBuffer;
	void __fastcall DoDeleteItem(System::TObject* Sender, void * Item);
	void __fastcall DoGetItemSize(System::TObject* Sender, void * Item, int &size);
	int __fastcall GetCount(void);
	
public:
	__fastcall virtual TLMDBufferComponent(System::Classes::TComponent* aOwner);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	bool __fastcall isEmtpy(void);
	bool __fastcall isFull(void);
	__property int Count = {read=GetCount, nodefault};
	
__published:
	__property About = {default=0};
	__property int MaxEntries = {read=FMaxEntries, write=SetInteger, default=-1};
	__property Lmdbuffer::TLMDGetItemSizeEvent OnGetItemSize = {read=FOnGetItemSize, write=FOnGetItemSize};
	__property Lmdbuffer::TLMDDestroyItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property OnChange;
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDBufferComponent(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbuffercomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUFFERCOMPONENT)
using namespace Lmdbuffercomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuffercomponentHPP
