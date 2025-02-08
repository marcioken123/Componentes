// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxAniDesignerForm.pas' rev: 31.00 (Windows)

#ifndef LmdfxanidesignerformHPP
#define LmdfxanidesignerformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxEffect.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDFxAnimation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxanidesignerform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxAnimationDesignerForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxAnimationDesignerForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	Vcl::Stdctrls::TComboBox* FAniCombo;
	Vcl::Stdctrls::TButton* FPreviewButton;
	Vcl::Stdctrls::TGroupBox* FPreviewBox;
	Vcl::Extctrls::TPaintBox* FPreviewPaint;
	Vcl::Stdctrls::TGroupBox* FSettingBox;
	Vcl::Stdctrls::TComboBox* FDirectionCombo;
	Vcl::Stdctrls::TComboBox* FTimeEdit;
	Vcl::Stdctrls::TComboBox* FResEdit;
	Vcl::Stdctrls::TComboBox* FTileEdit;
	Vcl::Extctrls::TImage* FBitmap;
	Vcl::Dialogs::TOpenDialog* FBitmapDialog;
	bool FUpdating;
	Lmdfxanimation::TLMDFxAnimation* FAnimationItem;
	Lmdfxbitmap::TLMDFxBitmap* FSourceImage;
	Lmdfxbitmap::TLMDFxBitmap* FDestImage;
	void __fastcall BuildAniList(void);
	void __fastcall DoAniComboChange(System::TObject* Sender);
	void __fastcall DoPreviewPaint(System::TObject* Sender);
	void __fastcall DoExecute(System::TObject* Sender);
	void __fastcall DoTimeChange(System::TObject* Sender);
	void __fastcall DoDirectionChange(System::TObject* Sender);
	void __fastcall DoBitmapChange(System::TObject* Sender);
	void __fastcall DoBitmapButtonClick(System::TObject* Sender);
	void __fastcall UpdateAnimation(void);
	void __fastcall UpdateControls(void);
	
public:
	__fastcall virtual TLMDFxAnimationDesignerForm(const bool aButtonsExt);
	__fastcall virtual ~TLMDFxAnimationDesignerForm(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFxAnimationDesignerForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFxAnimationDesignerForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFxAnimationDesignerForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall LMDFxShowDesignerForm(Lmdfxanimation::TLMDFxAnimation* const AAnimationItem, const System::UnicodeString aCaption, bool OkCancelButtons, System::Classes::TNotifyEvent NotifyProc = 0x0)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall LMDFxShowDesignerForm(Lmdfxanimation::TLMDFxAnimation* const AAnimationItem)/* overload */;
}	/* namespace Lmdfxanidesignerform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXANIDESIGNERFORM)
using namespace Lmdfxanidesignerform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxanidesignerformHPP
