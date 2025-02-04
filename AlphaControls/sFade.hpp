// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sFade.pas' rev: 27.00 (Windows)

#ifndef SfadeHPP
#define SfadeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sfade
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsFadeTimer;
class PASCALIMPLEMENTATION TsFadeTimer : public Vcl::Extctrls::TTimer
{
	typedef Vcl::Extctrls::TTimer inherited;
	
private:
	void __fastcall SetDirection(const Sconst::TFadeDirection Value);
	void __fastcall SetOwnerData(Scommondata::TsCommonData* const Value);
	void __fastcall TimerAction(System::TObject* Sender);
	
public:
	Sconst::TFadeDirection FDirection;
	Scommondata::TsCommonData* FOwnerData;
	int Iterations;
	int FadeLevel;
	Vcl::Graphics::TBitmap* BmpFrom;
	__fastcall virtual TsFadeTimer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsFadeTimer(void);
	void __fastcall Change(void);
	DYNAMIC void __fastcall Timer(void);
	bool __fastcall ToEnd(void);
	__property Sconst::TFadeDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Scommondata::TsCommonData* OwnerData = {read=FOwnerData, write=SetOwnerData};
};


class DELPHICLASS TsAnimTimer;
class PASCALIMPLEMENTATION TsAnimTimer : public Vcl::Extctrls::TTimer
{
	typedef Vcl::Extctrls::TTimer inherited;
	
private:
	bool FadeInProcess;
	void __fastcall SetOwnerData(Scommondata::TsCommonData* const Value);
	void __fastcall TimerAction(System::TObject* Sender);
	
public:
	Vcl::Graphics::TBitmap* BmpFrom;
	Vcl::Graphics::TBitmap* TmpBmp;
	Scommondata::TsCommonData* FOwnerData;
	int Iterations;
	int FadeLevel;
	__fastcall virtual TsAnimTimer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsAnimTimer(void);
	__property Enabled = {default=0};
	void __fastcall DoFade(void);
	void __fastcall Repaint(void);
	DYNAMIC void __fastcall Timer(void);
	bool __fastcall ToEnd(void);
	__property Scommondata::TsCommonData* OwnerData = {read=FOwnerData, write=SetOwnerData};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall EventEnabled(Sconst::TacAnimatEvent Event, Sconst::TacAnimatEvents CurrentProperty, Sskinmanager::TsSkinManager* SkinManager = (Sskinmanager::TsSkinManager*)(0x0));
extern DELPHI_PACKAGE void __fastcall DoChangePaint(TsFadeTimer* &Timer, Scommondata::TsCommonData* CommonData, bool Clicked, bool AllowAnimation, Sconst::TFadeDirection Direction = (Sconst::TFadeDirection)(0x1));
extern DELPHI_PACKAGE void __fastcall StopFading(TsFadeTimer* &Timer);
}	/* namespace Sfade */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SFADE)
using namespace Sfade;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SfadeHPP
