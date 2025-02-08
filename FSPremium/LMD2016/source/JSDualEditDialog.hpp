// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDualEditDialog.pas' rev: 31.00 (Windows)

#ifndef JsdualeditdialogHPP
#define JsdualeditdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <JSEditDialog.hpp>
#include <JSDialogs.hpp>
#include <JSDialog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdualeditdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSDualEditProperties;
class DELPHICLASS TJSCustomDualEditDialog;
class DELPHICLASS TJSDualEditDialog;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSDualEditProperties : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FValue1Caption;
	System::UnicodeString FValue2Caption;
	System::UnicodeString FValue2;
	System::UnicodeString FValue1;
	Jseditdialog::TJSCaptionAlignment FCaptionAlignment;
	void __fastcall SetValue1(const System::UnicodeString Value);
	void __fastcall SetValue2(const System::UnicodeString Value);
	
public:
	__fastcall TJSDualEditProperties(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Jseditdialog::TJSCaptionAlignment CaptionAlignment = {read=FCaptionAlignment, write=FCaptionAlignment, default=1};
	__property System::UnicodeString Value1 = {read=FValue1, write=SetValue1};
	__property System::UnicodeString Value1Caption = {read=FValue1Caption, write=FValue1Caption};
	__property System::UnicodeString Value2 = {read=FValue2, write=SetValue2};
	__property System::UnicodeString Value2Caption = {read=FValue2Caption, write=FValue2Caption};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSDualEditProperties(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJSCustomDualEditDialog : public Jseditdialog::TJSEditDialog
{
	typedef Jseditdialog::TJSEditDialog inherited;
	
private:
	TJSDualEditProperties* FDualEditProperties;
	System::UnicodeString FEditValue2;
	System::UnicodeString FEditValue1;
	void __fastcall SetDualEditProperties(TJSDualEditProperties* const Value);
	
protected:
	virtual void __fastcall DoGetEditControlClass(Vcl::Controls::TControlClass &AControlClass);
	virtual int __fastcall DoGetControlHeight(void);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual void __fastcall UpdateEditValues(void);
	
public:
	__fastcall virtual TJSCustomDualEditDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomDualEditDialog(void);
	__property TJSDualEditProperties* DualEditProperties = {read=FDualEditProperties, write=SetDualEditProperties};
	__property System::UnicodeString EditValue1 = {read=FEditValue1};
	__property System::UnicodeString EditValue2 = {read=FEditValue2};
};


class PASCALIMPLEMENTATION TJSDualEditDialog : public TJSCustomDualEditDialog
{
	typedef TJSCustomDualEditDialog inherited;
	
__published:
	__property DualEditProperties;
public:
	/* TJSCustomDualEditDialog.Create */ inline __fastcall virtual TJSDualEditDialog(System::Classes::TComponent* AOwner) : TJSCustomDualEditDialog(AOwner) { }
	/* TJSCustomDualEditDialog.Destroy */ inline __fastcall virtual ~TJSDualEditDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsdualeditdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDUALEDITDIALOG)
using namespace Jsdualeditdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdualeditdialogHPP
