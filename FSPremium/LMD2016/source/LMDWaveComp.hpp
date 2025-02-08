// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWaveComp.pas' rev: 31.00 (Windows)

#ifndef LmdwavecompHPP
#define LmdwavecompHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDWave.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdwavecomp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TLMDCustomWaveComp;
class PASCALIMPLEMENTATION TLMDCustomWaveComp : public Lmdcustomcomponent::TLMDCustomComponent 
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
protected:
	virtual bool __fastcall PlaySoundExt(Lmdwave::TLMDSndPlayMode aValue) = 0 ;
public:
	bool __fastcall PlaySound(Lmdwave::TLMDSndPlayMode aValue);
public:
	#pragma option push -w-inl
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDCustomWaveComp(Classes::TComponent* 
		AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	#pragma option pop
public:
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomWaveComp(void) { }
	#pragma option pop
	
};
};

namespace Lmdwavecomp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWaveComp;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWaveComp : public TLMDCustomWaveComp
{
	typedef TLMDCustomWaveComp inherited;
	
private:
	Lmdwave::TLMDWave* FWave;
	void __fastcall SetWave(Lmdwave::TLMDWave* aValue);
	
public:
	__fastcall virtual TLMDWaveComp(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWaveComp(void);
	virtual void __fastcall LoadFromFile(const System::UnicodeString Filename);
	virtual void __fastcall SaveToFile(const System::UnicodeString FileName);
	bool __fastcall Play(void);
	virtual bool __fastcall PlaySoundExt(TLMDSndPlayMode aValue);
	void __fastcall Stop(void);
	
__published:
	__property About = {default=0};
	__property Lmdwave::TLMDWave* Wave = {read=FWave, write=SetWave};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwavecomp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWAVECOMP)
using namespace Lmdwavecomp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwavecompHPP
