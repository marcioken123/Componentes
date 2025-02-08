// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElStrArray.pas' rev: 31.00 (Windows)

#ifndef ElstrarrayHPP
#define ElstrarrayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Consts.hpp>
#include <System.SysConst.hpp>
#include <System.RTLConsts.hpp>
#include <LMDTypes.hpp>
#include <LMDArray.hpp>
#include <LMDUnicodeStrings.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elstrarray
{
//-- forward type declarations -----------------------------------------------
struct TElStringItem;
class DELPHICLASS TElStringArray;
//-- type declarations -------------------------------------------------------
typedef TElStringItem *PElStringItem;

struct DECLSPEC_DRECORD TElStringItem
{
public:
	System::WideChar *FString;
	System::TObject* FObject;
};


typedef Lmdunicodestrings::TLMDWideStringArray TLMDStringArray;

class PASCALIMPLEMENTATION TElStringArray : public System::Classes::TStrings
{
	typedef System::Classes::TStrings inherited;
	
private:
	bool FStoreAssociatedData;
	System::Types::TDuplicates FDuplicates;
	bool FSorted;
	System::Classes::TNotifyEvent FOnChanging;
	System::Classes::TNotifyEvent FOnChange;
	Lmdarray::TLMDArray* FArray;
	int FUpdateCount;
	void __fastcall OnItemDelete(System::TObject* Sender, void * Item);
	void __fastcall SetSorted(bool newValue);
	void __fastcall ExchangeItems(int Index1, int Index2);
	
protected:
	virtual void __fastcall QuickSort(int L, int R);
	virtual void __fastcall Changed(void);
	virtual void __fastcall Changing(void);
	virtual void __fastcall TriggerChangingEvent(void);
	virtual void __fastcall TriggerChangeEvent(void);
	virtual void __fastcall InsertItem(int Index, const System::UnicodeString S);
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual int __fastcall GetCount(void);
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	virtual void __fastcall PutStringEntry(int Index, const System::UnicodeString S, System::TObject* AObject);
	virtual void __fastcall SetUpdateState(bool Updating);
	
public:
	virtual void __fastcall Clear(void);
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual int __fastcall AddStringEntry(const System::UnicodeString S, System::TObject* AObject);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	virtual int __fastcall IndexOf(const System::UnicodeString S);
	int __fastcall IIndexOf(const System::UnicodeString S);
	virtual bool __fastcall Find(const System::UnicodeString S, int &Index);
	virtual void __fastcall Sort(void);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual void __fastcall SaveToBinaryStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromBinaryStream(System::Classes::TStream* Stream);
	__fastcall TElStringArray(void);
	__fastcall virtual ~TElStringArray(void);
	__property System::Types::TDuplicates Duplicates = {read=FDuplicates, write=FDuplicates, nodefault};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
	
__published:
	__property System::Classes::TNotifyEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool StoreAssociatedData = {read=FStoreAssociatedData, write=FStoreAssociatedData, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elstrarray */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSTRARRAY)
using namespace Elstrarray;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElstrarrayHPP
