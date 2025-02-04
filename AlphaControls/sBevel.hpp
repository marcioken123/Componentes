// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sBevel.pas' rev: 27.00 (Windows)

#ifndef SbevelHPP
#define SbevelHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sbevel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsBevel;
class PASCALIMPLEMENTATION TsBevel : public Vcl::Extctrls::TBevel
{
	typedef Vcl::Extctrls::TBevel inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	
protected:
	Vcl::Extctrls::TBevelStyle StoredBevel;
	Vcl::Extctrls::TBevelShape StoredShape;
	virtual void __fastcall Paint(void);
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	
public:
	__fastcall virtual TsBevel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsBevel(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Invalidate(void);
	void __fastcall CheckSkinSection(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sbevel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SBEVEL)
using namespace Sbevel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SbevelHPP
