// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormFill.pas' rev: 31.00 (Windows)

#ifndef LmdformfillHPP
#define LmdformfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMDCustomFormFill.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormFill : public Lmdcustomformfill::TLMDCustomFormFill
{
	typedef Lmdcustomformfill::TLMDCustomFormFill inherited;
	
private:
	Lmdfillobject::TLMDFillObject* FFillObject;
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetEraseMode(void);
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall PaintClientArea(HDC DC);
	
public:
	__fastcall virtual TLMDFormFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormFill(void);
	
__published:
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property ListIndex = {index=1, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMFILL)
using namespace Lmdformfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformfillHPP
