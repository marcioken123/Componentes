// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsStrsEditor.pas' rev: 31.00 (Windows)

#ifndef LmdinsstrseditorHPP
#define LmdinsstrseditorHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Variants.hpp>
#include <LMDInsCst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinsstrseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringsEditorDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStringsEditorDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TLabel* lbLineCount;
	Vcl::Extctrls::TBevel* bvlMain;
	Vcl::Stdctrls::TMemo* memMain;
	void __fastcall memMainChange(System::TObject* Sender);
	
private:
	System::Classes::TStrings* __fastcall GetLines(void);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	
public:
	bool __fastcall Execute(void);
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDStringsEditorDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStringsEditorDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDStringsEditorDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStringsEditorDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinsstrseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSSTRSEDITOR)
using namespace Lmdinsstrseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinsstrseditorHPP
