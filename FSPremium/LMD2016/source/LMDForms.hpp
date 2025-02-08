// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDForms.pas' rev: 31.00 (Windows)

#ifndef LmdformsHPP
#define LmdformsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <System.RTLConsts.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdforms
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWideForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWideForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	Lmdtypes::TLMDString FCaption;
	Lmdtypes::TLMDString __fastcall GetCaption(void);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	
protected:
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDWideForm(System::Classes::TComponent* AOwner);
	
__published:
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDWideForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDWideForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWideForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdforms */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMS)
using namespace Lmdforms;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformsHPP
