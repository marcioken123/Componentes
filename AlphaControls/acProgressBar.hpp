// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acProgressBar.pas' rev: 27.00 (Windows)

#ifndef AcprogressbarHPP
#define AcprogressbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acprogressbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsProgressBar;
class PASCALIMPLEMENTATION TsProgressBar : public Vcl::Comctrls::TProgressBar
{
	typedef Vcl::Comctrls::TProgressBar inherited;
	
private:
	int FOldCount;
	Vcl::Extctrls::TTimer* Timer;
	Scommondata::TsCommonData* FCommonData;
	System::UnicodeString FProgressSkin;
	double FMarqPos;
	int FMarqSize;
	int FMarqStep;
	int FOrient;
	void __fastcall PrepareCache(void);
	System::Types::TRect __fastcall ProgressRect(void);
	System::Types::TSize __fastcall ItemSize(void);
	System::Types::TRect __fastcall ClRect(void);
	void __fastcall SetProgressSkin(const System::UnicodeString Value);
	void __fastcall TimerAction(System::TObject* Sender);
	
public:
	void __fastcall Paint(HDC DC);
	__fastcall virtual TsProgressBar(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TsProgressBar(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property System::UnicodeString ProgressSkin = {read=FProgressSkin, write=SetProgressSkin};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsProgressBar(HWND ParentWindow) : Vcl::Comctrls::TProgressBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acprogressbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACPROGRESSBAR)
using namespace Acprogressbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcprogressbarHPP
