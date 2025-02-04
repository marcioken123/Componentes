// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ac3dNewClass.pas' rev: 27.00 (Windows)

#ifndef Ac3dnewclassHPP
#define Ac3dnewclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ac3dnewclass
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFormNewThirdClass;
class PASCALIMPLEMENTATION TFormNewThirdClass : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sedit::TsEdit* sEdit1;
	Scombobox::TsComboBox* sComboBox1;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Acalphaimagelist::TsAlphaImageList* sAlphaImageList1;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormNewThirdClass(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormNewThirdClass(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormNewThirdClass(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormNewThirdClass(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TFormNewThirdClass* FormNewThirdClass;
}	/* namespace Ac3dnewclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_AC3DNEWCLASS)
using namespace Ac3dnewclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ac3dnewclassHPP
