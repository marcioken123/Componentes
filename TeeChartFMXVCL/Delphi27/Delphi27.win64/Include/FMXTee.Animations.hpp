// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Animations.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_AnimationsHPP
#define Fmxtee_AnimationsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Ani.hpp>
#include <FMX.Utils.hpp>
#include <FMX.Types3D.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Animations
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBaseAnimation;
class DELPHICLASS TIntegerAnimation;
class DELPHICLASS TChildrenAnimation;
class DELPHICLASS TSequenceAnimation;
class DELPHICLASS TPosition3DAnimation;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBaseAnimation : public Fmx::Ani::TAnimation
{
	typedef Fmx::Ani::TAnimation inherited;
	
private:
	bool FStartFromCurrent;
	System::UnicodeString FPath;
	System::UnicodeString FPropertyName;
	System::TObject* FInstance;
	
protected:
	void __fastcall CheckPath();
	
public:
	__property System::TObject* Instance = {read=FInstance, write=FInstance};
	__property System::UnicodeString Path = {read=FPath, write=FPath};
	
__published:
	__property bool StartFromCurrent = {read=FStartFromCurrent, write=FStartFromCurrent, default=0};
	__property System::UnicodeString PropertyName = {read=FPropertyName, write=FPropertyName};
public:
	/* TAnimation.Create */ inline __fastcall virtual TBaseAnimation(System::Classes::TComponent* AOwner) : Fmx::Ani::TAnimation(AOwner) { }
	/* TAnimation.Destroy */ inline __fastcall virtual ~TBaseAnimation() { }
	
};


class PASCALIMPLEMENTATION TIntegerAnimation : public TBaseAnimation
{
	typedef TBaseAnimation inherited;
	
private:
	int FStartInt;
	int FStopInt;
	
protected:
	virtual void __fastcall ProcessAnimation();
	
public:
	__fastcall virtual TIntegerAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TIntegerAnimation();
	virtual void __fastcall Start();
	virtual void __fastcall Stop();
	
__published:
	__property int StartValue = {read=FStartInt, write=FStartInt, stored=true, nodefault};
	__property int StopValue = {read=FStopInt, write=FStopInt, stored=true, nodefault};
};


class PASCALIMPLEMENTATION TChildrenAnimation : public Fmx::Ani::TFloatAnimation
{
	typedef Fmx::Ani::TFloatAnimation inherited;
	
private:
	float FOverlap;
	void __fastcall CreateAnimations();
	int __fastcall ParentChildrenCount();
	
public:
	virtual void __fastcall Start();
	
__published:
	__property float Overlap = {read=FOverlap, write=FOverlap};
public:
	/* TFloatAnimation.Create */ inline __fastcall virtual TChildrenAnimation(System::Classes::TComponent* AOwner) : Fmx::Ani::TFloatAnimation(AOwner) { }
	
public:
	/* TAnimation.Destroy */ inline __fastcall virtual ~TChildrenAnimation() { }
	
};


class PASCALIMPLEMENTATION TSequenceAnimation : public Fmx::Ani::TAnimation
{
	typedef Fmx::Ani::TAnimation inherited;
	
protected:
	virtual void __fastcall ProcessAnimation();
	
public:
	virtual void __fastcall Start();
public:
	/* TAnimation.Create */ inline __fastcall virtual TSequenceAnimation(System::Classes::TComponent* AOwner) : Fmx::Ani::TAnimation(AOwner) { }
	/* TAnimation.Destroy */ inline __fastcall virtual ~TSequenceAnimation() { }
	
};


class PASCALIMPLEMENTATION TPosition3DAnimation : public TBaseAnimation
{
	typedef TBaseAnimation inherited;
	
private:
	Fmx::Types3d::TPosition3D* FStart;
	Fmx::Types3d::TPosition3D* FCurrent;
	Fmx::Types3d::TPosition3D* FStop;
	
protected:
	virtual void __fastcall ProcessAnimation();
	
public:
	__fastcall virtual TPosition3DAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPosition3DAnimation();
	virtual void __fastcall Start();
	
__published:
	__property Fmx::Types3d::TPosition3D* StartValue = {read=FStart, write=FStart};
	__property Fmx::Types3d::TPosition3D* StopValue = {read=FStop, write=FStop};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Animations */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATIONS)
using namespace Fmxtee::Animations;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_AnimationsHPP
