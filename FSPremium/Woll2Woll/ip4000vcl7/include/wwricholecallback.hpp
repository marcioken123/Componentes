// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwricholecallback.pas' rev: 6.00

#ifndef wwricholecallbackHPP
#define wwricholecallbackHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <OleCtnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <wwrichole.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <RichEdit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwricholecallback
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRichEditOleCallback;
class PASCALIMPLEMENTATION TRichEditOleCallback : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Classes::TComponent* FOwner;
	
protected:
	HRESULT __stdcall GetNewStorage(/* out */ _di_IStorage &stg);
	HRESULT __stdcall GetInPlaceContext(/* out */ _di_IOleInPlaceFrame &Frame, /* out */ _di_IOleInPlaceUIWindow &Doc, tagOIFI &FrameInfo);
	HRESULT __stdcall ShowContainerUI(BOOL fShow);
	HRESULT __stdcall QueryInsertObject(const GUID &clsid, _di_IStorage stg, int cp);
	HRESULT __stdcall DeleteObject(_di_IOleObject oleobj);
	HRESULT __stdcall QueryAcceptData(_di_IDataObject dataobj, Word &cfFormat, unsigned reco, BOOL fReally, unsigned hMetaPict);
	HRESULT __stdcall ContextSensitiveHelp(BOOL fEnterMode);
	HRESULT __stdcall GetClipboardData(const _charrange &chrg, unsigned reco, /* out */ _di_IDataObject &dataobj);
	HRESULT __stdcall GetDragDropEffect(BOOL fDrag, unsigned grfKeyState, unsigned &dwEffect);
	HRESULT __stdcall GetContextMenu(Word seltype, _di_IOleObject oleobj, const _charrange &chrg, HMENU &menu);
	
public:
	__fastcall TRichEditOleCallback(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRichEditOleCallback(void) { }
	#pragma option pop
	
private:
	void *__IRichEditOleCallback;	/* Wwrichole::IRichEditOleCallback */
	
public:
	operator IRichEditOleCallback*(void) { return (IRichEditOleCallback*)&__IRichEditOleCallback; }
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwricholecallback)

}	/* namespace Wwricholecallback */
using namespace Wwricholecallback;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwricholecallback
