// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDWideStringsEditDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdwidestringseditdlgHPP
#define PlmdwidestringseditdlgHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLConst.hpp>
#include <LMDUnicodeStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdwidestringseditdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFrmWideStringsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFrmWideStringsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lbLineCount;
	Vcl::Extctrls::TBevel* bvlMain;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Extctrls::TPanel* pnlMain;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	System::TObject* FMemo;
	System::Classes::TStrings* FLines;
	void __fastcall MemoChange(System::TObject* Sender);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	void __fastcall CopyToMemo(void);
	void __fastcall CopyFromMemo(void);
	
public:
	bool __fastcall Execute(void);
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFrmWideStringsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFrmWideStringsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFrmWideStringsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFrmWideStringsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdwidestringseditdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDWIDESTRINGSEDITDLG)
using namespace Plmdwidestringseditdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdwidestringseditdlgHPP
