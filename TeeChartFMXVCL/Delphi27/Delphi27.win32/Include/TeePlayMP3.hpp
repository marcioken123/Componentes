// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeePlayMP3.pas' rev: 34.00 (Windows)

#ifndef Teeplaymp3HPP
#define Teeplaymp3HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeeAnimate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeplaymp3
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPlayMP3Sound;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPlayMP3Sound : public Vcltee::Teeanimate::TPlaySoundAnimation
{
	typedef Vcltee::Teeanimate::TPlaySoundAnimation inherited;
	
private:
	int __fastcall GetVolume();
	void __fastcall SetVolume(const int Value);
	
protected:
	virtual void __fastcall SetFile(const System::UnicodeString Value);
	
public:
	virtual void __fastcall Play()/* overload */;
	__classmethod void __fastcall PlayFile(const System::UnicodeString AFileName);
	__property int Volume = {read=GetVolume, write=SetVolume, default=100};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TPlayMP3Sound(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TPlaySoundAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TPlayMP3Sound() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Play(const System::UnicodeString AFileName, bool Synchronous = true){ Vcltee::Teeanimate::TPlaySoundAnimation::Play(AFileName, Synchronous); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeplaymp3 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEPLAYMP3)
using namespace Teeplaymp3;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Teeplaymp3HPP
