// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDActionsData.pas' rev: 31.00 (Windows)

#ifndef PlmdactionsdataHPP
#define PlmdactionsdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdactionsdata
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDActionsData;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDActionsData : public System::Classes::TDataModule
{
	typedef System::Classes::TDataModule inherited;
	
__published:
	Vcl::Controls::TImageList* Icons;
public:
	/* TDataModule.Create */ inline __fastcall virtual TLMDActionsData(System::Classes::TComponent* AOwner) : System::Classes::TDataModule(AOwner) { }
	/* TDataModule.CreateNew */ inline __fastcall virtual TLMDActionsData(System::Classes::TComponent* AOwner, int Dummy) : System::Classes::TDataModule(AOwner, Dummy) { }
	/* TDataModule.Destroy */ inline __fastcall virtual ~TLMDActionsData(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDActionsData* LMDActionsData;
}	/* namespace Plmdactionsdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDACTIONSDATA)
using namespace Plmdactionsdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdactionsdataHPP
