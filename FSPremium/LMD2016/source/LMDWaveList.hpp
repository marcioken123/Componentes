// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWaveList.pas' rev: 31.00 (Windows)

#ifndef LmdwavelistHPP
#define LmdwavelistHPP

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
#include <LMDWave.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwavelist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWaveListItem;
class DELPHICLASS TLMDWaveList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWaveListItem : public Lmdcustomcontainer::TLMDListItem
{
	typedef Lmdcustomcontainer::TLMDListItem inherited;
	
private:
	Lmdwave::TLMDWave* FWave;
	void __fastcall SetWave(Lmdwave::TLMDWave* aValue);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	
public:
	__fastcall virtual TLMDWaveListItem(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWaveListItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FreeData(void);
	__property Compressed = {default=0};
	
__published:
	__property Lmdwave::TLMDWave* Wave = {read=FWave, write=SetWave, stored=false};
	__property Description = {default=0};
	__property Ident;
};


class PASCALIMPLEMENTATION TLMDWaveList : public Lmdcustomcontainer::TLMDCustomContainer
{
	typedef Lmdcustomcontainer::TLMDCustomContainer inherited;
	
public:
	TLMDWaveListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDWaveListItem* __fastcall GetArrayItem(int index);
	TLMDWaveListItem* __fastcall GetArrayNameItem(System::UnicodeString Index);
	
public:
	__fastcall virtual TLMDWaveList(System::Classes::TComponent* AOwner);
	__property TLMDWaveListItem* Items[int Index] = {read=GetArrayItem/*, default*/};
	__property TLMDWaveListItem* ItemByName[System::UnicodeString Index] = {read=GetArrayNameItem};
	
__published:
	__property DefaultCompressed = {default=0};
public:
	/* TLMDCustomContainer.Destroy */ inline __fastcall virtual ~TLMDWaveList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDWVLGetItem(const System::UnicodeString FileName, int index, Lmdwave::TLMDWave* aWave);
}	/* namespace Lmdwavelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWAVELIST)
using namespace Lmdwavelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwavelistHPP
