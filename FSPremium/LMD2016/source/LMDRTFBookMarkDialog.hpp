// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFBookMarkDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtfbookmarkdialogHPP
#define LmdrtfbookmarkdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <LMDRTFHyperText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfbookmarkdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichfrmBookMarks;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichfrmBookMarks : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TEdit* FNameEditor;
	Vcl::Stdctrls::TListBox* FBookMarkList;
	Vcl::Stdctrls::TButton* btnNew;
	Vcl::Stdctrls::TButton* btnDelete;
	Vcl::Stdctrls::TButton* btnSelect;
	Vcl::Stdctrls::TButton* btnClose;
	void __fastcall FNameEditorChange(System::TObject* Sender);
	void __fastcall FBookMarkListClick(System::TObject* Sender);
	void __fastcall btnCloseClick(System::TObject* Sender);
	void __fastcall btnNewClick(System::TObject* Sender);
	void __fastcall btnSelectClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall FBookMarkListDblClick(System::TObject* Sender);
	
private:
	Lmdrtfhypertext::TLMDRichHyperText* FHyperText;
	bool __fastcall IsValidName(const System::UnicodeString aName);
	
public:
	__fastcall TLMDRichfrmBookMarks(Lmdrtfhypertext::TLMDRichHyperText* aHyperText);
	__classmethod void __fastcall Execute(Lmdrtfhypertext::TLMDRichHyperText* aHyperText);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRichfrmBookMarks(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichfrmBookMarks(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRichfrmBookMarks(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichfrmBookMarks(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfbookmarkdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFBOOKMARKDIALOG)
using namespace Lmdrtfbookmarkdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfbookmarkdialogHPP
