// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBBase.pas' rev: 31.00 (Windows)

#ifndef LmddbbaseHPP
#define LmddbbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbbase
{
//-- forward type declarations -----------------------------------------------
__interface IDataControl;
typedef System::DelphiInterface<IDataControl> _di_IDataControl;
//-- type declarations -------------------------------------------------------
__interface IDataControl  : public System::IInterface 
{
	virtual Data::Db::TDataLink* __fastcall GetDataLink(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBBASE)
using namespace Lmddbbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbbaseHPP
