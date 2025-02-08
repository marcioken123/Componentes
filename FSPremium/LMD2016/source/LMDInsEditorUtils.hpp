// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsEditorUtils.pas' rev: 31.00 (Windows)

#ifndef LmdinseditorutilsHPP
#define LmdinseditorutilsHPP

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
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDInsCst.hpp>
#include <LMDInsClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinseditorutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditorUtils;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditorUtils : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FRefCounter;
	bool FIsReset;
	
public:
	TLMDEditorUtils* __fastcall AddRef(void);
	void __fastcall Release(bool AReset = false);
	__property bool IsReset = {read=FIsReset, nodefault};
	virtual void __fastcall GetObjects(System::Classes::TList* AResult) = 0 ;
	virtual void __fastcall SetObjects(System::Classes::TList* AObjects) = 0 /* overload */;
	void __fastcall SetObjects(System::Classes::TPersistent* *AObjects, const int AObjects_High)/* overload */;
	virtual void __fastcall MarkModified(void) = 0 /* overload */;
	virtual Lmdtypes::TLMDString __fastcall GetUniqueCompName(System::Classes::TComponent* AComp);
public:
	/* TObject.Create */ inline __fastcall TLMDEditorUtils(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEditorUtils(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinseditorutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSEDITORUTILS)
using namespace Lmdinseditorutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinseditorutilsHPP
