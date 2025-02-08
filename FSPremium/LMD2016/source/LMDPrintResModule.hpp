// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintResModule.pas' rev: 31.00 (Windows)

#ifndef LmdprintresmoduleHPP
#define LmdprintresmoduleHPP

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

namespace Lmdprintresmodule
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintResDataModule;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPrintResDataModule : public System::Classes::TDataModule
{
	typedef System::Classes::TDataModule inherited;
	
__published:
	Vcl::Controls::TImageList* PrintToolbarImgList;
public:
	/* TDataModule.Create */ inline __fastcall virtual TLMDPrintResDataModule(System::Classes::TComponent* AOwner) : System::Classes::TDataModule(AOwner) { }
	/* TDataModule.CreateNew */ inline __fastcall virtual TLMDPrintResDataModule(System::Classes::TComponent* AOwner, int Dummy) : System::Classes::TDataModule(AOwner, Dummy) { }
	/* TDataModule.Destroy */ inline __fastcall virtual ~TLMDPrintResDataModule(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDPrintResDataModule* LMDPrintResDataModule;
}	/* namespace Lmdprintresmodule */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTRESMODULE)
using namespace Lmdprintresmodule;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintresmoduleHPP
