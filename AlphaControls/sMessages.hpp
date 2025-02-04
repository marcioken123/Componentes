// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sMessages.pas' rev: 27.00 (Windows)

#ifndef SmessagesHPP
#define SmessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smessages
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TacSectionInfo
{
public:
	int SkinIndex;
	System::UnicodeString Name;
	bool RepaintNeeded;
};


typedef TacSectionInfo *PacSectionInfo;

//-- var, const, procedure ---------------------------------------------------
static const System::Word SM_ALPHACMD = System::Word(0xa100);
static const System::Int8 AC_SETNEWSKIN = System::Int8(0x1);
static const System::Int8 AC_REMOVESKIN = System::Int8(0x2);
static const System::Int8 AC_REFRESH = System::Int8(0x3);
static const System::Int8 AC_GETPROVIDER = System::Int8(0x4);
static const System::Int8 AC_GETCACHE = System::Int8(0x5);
static const System::Int8 AC_ENDPARENTUPDATE = System::Int8(0x6);
static const System::Int8 AC_CTRLHANDLED = System::Int8(0x7);
static const System::Int8 AC_UPDATING = System::Int8(0x8);
static const System::Int8 AC_PREPARING = System::Int8(0xa);
static const System::Int8 AC_GETHALFVISIBLE = System::Int8(0xb);
static const System::Int8 AC_UPDATESECTION = System::Int8(0xd);
static const System::Int8 AC_DROPPEDDOWN = System::Int8(0xe);
static const System::Int8 AC_SETSECTION = System::Int8(0xf);
static const System::Int8 AC_STOPFADING = System::Int8(0x10);
static const System::Int8 AC_SETBGCHANGED = System::Int8(0x11);
static const System::Int8 AC_INVALIDATE = System::Int8(0x12);
static const System::Int8 AC_CHILDCHANGED = System::Int8(0x13);
static const System::Int8 AC_SETCHANGEDIFNECESSARY = System::Int8(0x14);
static const System::Int8 AC_GETCONTROLCOLOR = System::Int8(0x15);
static const System::Int8 AC_SETHALFVISIBLE = System::Int8(0x16);
static const System::Int8 AC_PREPARECACHE = System::Int8(0x17);
static const System::Int8 AC_DRAWANIMAGE = System::Int8(0x18);
static const System::Int8 AC_CONTROLLOADED = System::Int8(0x19);
static const System::Int8 AC_GETSKININDEX = System::Int8(0x1a);
static const System::Int8 AC_GETSERVICEINT = System::Int8(0x1b);
static const System::Int8 AC_UPDATECHILDREN = System::Int8(0x1c);
static const System::Int8 AC_MOUSEENTER = System::Int8(0x1d);
static const System::Int8 AC_MOUSELEAVE = System::Int8(0x1e);
static const System::Int8 AC_BEGINUPDATE = System::Int8(0x1f);
static const System::Int8 AC_ENDUPDATE = System::Int8(0x20);
static const System::Int8 AC_CLEARCACHE = System::Int8(0x21);
static const System::Int8 AC_GETBG = System::Int8(0x22);
static const System::Int8 AC_GETDISKIND = System::Int8(0x23);
static const System::Int8 AC_GETSKINSTATE = System::Int8(0x24);
static const System::Int8 AC_GETSKINDATA = System::Int8(0x25);
static const System::Int8 AC_PRINTING = System::Int8(0x26);
static const System::Int8 AC_PAINTOUTER = System::Int8(0x28);
static const System::Int8 AC_BEFORESCROLL = System::Int8(0x33);
static const System::Int8 AC_AFTERSCROLL = System::Int8(0x34);
static const System::Int8 AC_REINITSCROLLS = System::Int8(0x35);
static const System::Int8 AC_GETAPPLICATION = System::Int8(0x3c);
static const System::Int8 AC_PARENTCLOFFSET = System::Int8(0x3d);
static const System::Int8 AC_NCPAINT = System::Int8(0x3e);
static const System::Int8 AC_GETOUTRGN = System::Int8(0x46);
static const System::Int8 AC_COPYDATA = System::Int8(0x47);
static const System::Word WM_DRAWMENUBORDER = System::Word(0xbcb3);
static const System::Word WM_DRAWMENUBORDER2 = System::Word(0xbcb4);
}	/* namespace Smessages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SMESSAGES)
using namespace Smessages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SmessagesHPP
