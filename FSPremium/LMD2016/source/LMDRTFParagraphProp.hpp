// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFParagraphProp.pas' rev: 31.00 (Windows)

#ifndef LmdrtfparagraphpropHPP
#define LmdrtfparagraphpropHPP

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
#include <Vcl.Buttons.hpp>
#include <System.UITypes.hpp>
#include <LMDRTFRichEdit.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfparagraphprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichfrmParagraph;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichfrmParagraph : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnTabstops;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TLabel* lblJustify;
	Vcl::Stdctrls::TLabel* lblHeading;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* lblMargins;
	Vcl::Stdctrls::TLabel* lblLeftMargin;
	Vcl::Stdctrls::TLabel* lblRightMargin;
	Vcl::Stdctrls::TLabel* lblFirstLine;
	Vcl::Stdctrls::TLabel* lblIndentAt;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* lblIntervals;
	Vcl::Stdctrls::TLabel* lblBefore;
	Vcl::Stdctrls::TLabel* lblAfter;
	Vcl::Stdctrls::TLabel* lblLineSpacing;
	Vcl::Stdctrls::TLabel* lblValue;
	Vcl::Stdctrls::TComboBox* cbxJustify;
	Vcl::Stdctrls::TComboBox* cbxHeading;
	Vcl::Stdctrls::TEdit* edtLeftMargin;
	Vcl::Stdctrls::TEdit* edtRightMargin;
	Vcl::Comctrls::TUpDown* udLeftMargin;
	Vcl::Comctrls::TUpDown* udRightMargin;
	Vcl::Stdctrls::TComboBox* cbxIndent;
	Vcl::Stdctrls::TEdit* edtIndentAt;
	Vcl::Comctrls::TUpDown* udIndentAt;
	Vcl::Stdctrls::TEdit* edtBeforeInterval;
	Vcl::Stdctrls::TEdit* edtAfterInterval;
	Vcl::Comctrls::TUpDown* udBeforeInterval;
	Vcl::Comctrls::TUpDown* udAfterInterval;
	Vcl::Stdctrls::TComboBox* cbxLineSpacing;
	Vcl::Stdctrls::TEdit* edtLineSpacingValue;
	Vcl::Comctrls::TUpDown* udLineSpacingValue;
	Vcl::Extctrls::TBevel* Bevel3;
	void __fastcall cbxShadingColorDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cbxShadingStyleDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall cbxJustifyDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall cbxHeadingDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall cbxIndentChange(System::TObject* Sender);
	void __fastcall cbxLineSpacingChange(System::TObject* Sender);
	void __fastcall edtDigitsKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall udLeftMarginChangingEx(System::TObject* Sender, bool &AllowChange, short NewValue, Vcl::Comctrls::TUpDownDirection Direction);
	
public:
	__classmethod bool __fastcall Execute(Lmdrtfrichedit::TLMDParaAttributes* aParagraph, Lmdrtfrichedit::TLMDCustomRichEdit* aRichEdit);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRichfrmParagraph(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichfrmParagraph(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRichfrmParagraph(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichfrmParagraph(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfparagraphprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFPARAGRAPHPROP)
using namespace Lmdrtfparagraphprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfparagraphpropHPP
