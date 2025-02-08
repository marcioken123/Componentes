// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFTabsProp.pas' rev: 31.00 (Windows)

#ifndef LmdrtftabspropHPP
#define LmdrtftabspropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Mask.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <LMDRTFRichEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtftabsprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichfrmTabs;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichfrmTabs : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TListBox* ListBox;
	Vcl::Stdctrls::TLabel* labTabPosition;
	Vcl::Stdctrls::TButton* btnSet;
	Vcl::Stdctrls::TButton* btnDelete;
	Vcl::Stdctrls::TButton* btnDeleteAll;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Mask::TMaskEdit* MaskEdit;
	void __fastcall btnSetClick(System::TObject* Sender);
	void __fastcall btnDeleteAllClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall ListBoxClick(System::TObject* Sender);
	void __fastcall MaskEditChange(System::TObject* Sender);
	void __fastcall MaskEditKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	void __fastcall InsertSorted(int aItem);
	void __fastcall CheckButtons(void);
	
public:
	__classmethod bool __fastcall Execute(Lmdrtfrichedit::TLMDParaAttributes* aParagraph, Lmdrtfrichedit::TLMDCustomRichEdit* aRichEdit);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRichfrmTabs(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichfrmTabs(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRichfrmTabs(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichfrmTabs(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtftabsprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFTABSPROP)
using namespace Lmdrtftabsprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtftabspropHPP
