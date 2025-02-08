// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMouseBaseCtrl.pas' rev: 31.00 (Windows)

#ifndef LmdmousebasectrlHPP
#define LmdmousebasectrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmousebasectrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMouseBaseCtrl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDMousePosStyle : unsigned char { mpDefaultButton, mpControl, mpClientArea };

class PASCALIMPLEMENTATION TLMDMouseBaseCtrl : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	bool FAutoActive;
	Vcl::Controls::TControl* FControl;
	TLMDMousePosStyle FPosStyle;
	void __fastcall SetControl(Vcl::Controls::TControl* aControl);
	void __fastcall SetPosStyle(TLMDMousePosStyle aValue);
	
protected:
	bool __fastcall GetTargetRect(System::Types::TRect &aRect);
	bool __fastcall HasControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	bool Performed;
	__fastcall virtual TLMDMouseBaseCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMouseBaseCtrl(void);
	
__published:
	__property About = {default=0};
	__property bool AutoActive = {read=FAutoActive, write=FAutoActive, default=0};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl, stored=HasControl};
	__property TLMDMousePosStyle Style = {read=FPosStyle, write=SetPosStyle, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmousebasectrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMOUSEBASECTRL)
using namespace Lmdmousebasectrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmousebasectrlHPP
