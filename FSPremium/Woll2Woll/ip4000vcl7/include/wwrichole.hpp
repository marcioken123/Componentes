// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwrichole.pas' rev: 6.00

#ifndef wwricholeHPP
#define wwricholeHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <RichEdit.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwrichole
{
//-- type declarations -------------------------------------------------------
#pragma pack(push, 1)
struct TREOBJECT
{
	unsigned cbStruct;
	int cp;
	GUID clsid;
	_di_IOleObject oleobj;
	_di_IStorage stg;
	_di_IOleClientSite olesite;
	tagSIZE sizelL;
	unsigned dvaspect;
	unsigned dwFlags;
	unsigned dwUser;
} ;
#pragma pack(pop)

__interface IRichEditOle;
typedef System::DelphiInterface<IRichEditOle> _di_IRichEditOle;
__interface  INTERFACE_UUID("{00020D00-0000-0000-C000-000000000046}") IRichEditOle  : public IInterface 
{
	
public:
	virtual HRESULT __stdcall GetClientSite(/* out */ _di_IOleClientSite &lplpolesite) = 0 ;
	virtual int __stdcall GetObjectCount(void) = 0 ;
	virtual int __stdcall GetLinkCount(void) = 0 ;
	virtual HRESULT __stdcall GetObject(int iob, /* out */ TREOBJECT &reobject, unsigned dwFlags) = 0 ;
	virtual HRESULT __stdcall InsertObject(const TREOBJECT &reobject) = 0 ;
	virtual HRESULT __stdcall ConvertObject(int iob, const GUID &clsidNew, WideChar * lpStrUserTypeNew) = 0 ;
	virtual HRESULT __stdcall ActivateAs(const GUID &clsid, const GUID &clsidAs) = 0 ;
	virtual HRESULT __stdcall SetHostNames(WideChar * lpstrContainerApp, WideChar * lpstrContainerObj) = 0 ;
	virtual HRESULT __stdcall SetLinkAvailable(int iob, BOOL fAvailable) = 0 ;
	virtual HRESULT __stdcall SetDvaspect(int iob, unsigned dvaspect) = 0 ;
	virtual HRESULT __stdcall HandsOffStorage(int iob) = 0 ;
	virtual HRESULT __stdcall SaveCompleted(int iob, _di_IStorage stg) = 0 ;
	virtual HRESULT __stdcall InPlaceDeactivate(void) = 0 ;
	virtual HRESULT __stdcall ContextSensitiveHelp(BOOL fEnterMode) = 0 ;
	virtual HRESULT __stdcall GetClipboardData(const _charrange &chrg, unsigned reco, /* out */ _di_IDataObject &dataobj) = 0 ;
	virtual HRESULT __stdcall ImportDataObject(_di_IDataObject dataobj, Word cf, unsigned hMetaPict) = 0 ;
};

__interface IRichEditOleCallback;
typedef System::DelphiInterface<IRichEditOleCallback> _di_IRichEditOleCallback;
__interface  INTERFACE_UUID("{00020D03-0000-0000-C000-000000000046}") IRichEditOleCallback  : public IInterface 
{
	
public:
	virtual HRESULT __stdcall GetNewStorage(/* out */ _di_IStorage &stg) = 0 ;
	virtual HRESULT __stdcall GetInPlaceContext(/* out */ _di_IOleInPlaceFrame &Frame, /* out */ _di_IOleInPlaceUIWindow &Doc, tagOIFI &FrameInfo) = 0 ;
	virtual HRESULT __stdcall ShowContainerUI(BOOL fShow) = 0 ;
	virtual HRESULT __stdcall QueryInsertObject(const GUID &clsid, _di_IStorage stg, int cp) = 0 ;
	virtual HRESULT __stdcall DeleteObject(_di_IOleObject oleobj) = 0 ;
	virtual HRESULT __stdcall QueryAcceptData(_di_IDataObject dataobj, Word &cfFormat, unsigned reco, BOOL fReally, unsigned hMetaPict) = 0 ;
	virtual HRESULT __stdcall ContextSensitiveHelp(BOOL fEnterMode) = 0 ;
	virtual HRESULT __stdcall GetClipboardData(const _charrange &chrg, unsigned reco, /* out */ _di_IDataObject &dataobj) = 0 ;
	virtual HRESULT __stdcall GetDragDropEffect(BOOL fDrag, unsigned grfKeyState, unsigned &dwEffect) = 0 ;
	virtual HRESULT __stdcall GetContextMenu(Word seltype, _di_IOleObject oleobj, const _charrange &chrg, HMENU &menu) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwrichole)
static const Shortint REO_GETOBJ_NO_INTERFACES = 0x0;
static const Shortint REO_GETOBJ_POLEOBJ = 0x1;
static const Shortint REO_GETOBJ_PSTG = 0x2;
static const Shortint REO_GETOBJ_POLESITE = 0x4;
static const Shortint REO_GETOBJ_ALL_INTERFACES = 0x7;
static const unsigned REO_CP_SELECTION = 0xffffffff;
static const unsigned REO_IOB_SELECTION = 0xffffffff;
static const unsigned REO_IOB_USE_CP = 0xfffffffe;
static const Shortint REO_NULL = 0x0;
static const Shortint REO_READWRITEMASK = 0x3f;
static const Shortint REO_DONTNEEDPALETTE = 0x20;
static const Shortint REO_BLANK = 0x10;
static const Shortint REO_DYNAMICSIZE = 0x8;
static const Shortint REO_INVERTEDSELECT = 0x4;
static const Shortint REO_BELOWBASELINE = 0x2;
static const Shortint REO_RESIZABLE = 0x1;
static const unsigned REO_LINK = 0x80000000;
static const int REO_STATIC = 0x40000000;
static const int REO_SELECTED = 0x8000000;
static const int REO_OPEN = 0x4000000;
static const int REO_INPLACEACTIVE = 0x2000000;
static const int REO_HILITED = 0x1000000;
static const int REO_LINKAVAILABLE = 0x800000;
static const int REO_GETMETAFILE = 0x400000;
static const Shortint RECO_PASTE = 0x0;
static const Shortint RECO_DROP = 0x1;
static const Shortint RECO_COPY = 0x2;
static const Shortint RECO_CUT = 0x3;
static const Shortint RECO_DRAG = 0x4;
extern PACKAGE BOOL __fastcall RichEdit_SetOleCallback(HWND RichEdit, _di_IRichEditOleCallback OleInterface);
extern PACKAGE BOOL __fastcall RichEdit_GetOleInterface(HWND RichEdit, /* out */ _di_IRichEditOle &OleInterface);

}	/* namespace Wwrichole */
using namespace Wwrichole;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwrichole
