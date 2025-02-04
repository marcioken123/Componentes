// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acAlphaHintsEdit.pas' rev: 27.00 (Windows)

#ifndef AcalphahintseditHPP
#define AcalphahintseditHPP

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
#include <System.Variants.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <acAlphaHints.hpp>	// Pascal unit
#include <sListBox.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sPageControl.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sCheckBox.hpp>	// Pascal unit
#include <acHintPage.hpp>	// Pascal unit
#include <sGroupBox.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acalphahintsedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAlphaHintsEdit;
class PASCALIMPLEMENTATION TAlphaHintsEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	Spagecontrol::TsPageControl* sPageControl1;
	Spagecontrol::TsTabSheet* sTabSheet1;
	Spagecontrol::TsTabSheet* sTabSheet2;
	Spagecontrol::TsTabSheet* sTabSheet3;
	Spagecontrol::TsTabSheet* sTabSheet4;
	Scheckbox::TsCheckBox* sCheckBox1;
	Achintpage::TFrameHintPage* FrameTL;
	Acalphahints::TsAlphaHints* Hints;
	Sgroupbox::TsGroupBox* sGroupBox1;
	Sspeedbutton::TsSpeedButton* sSpeedButton1;
	Sspeedbutton::TsSpeedButton* sSpeedButton2;
	Slistbox::TsListBox* sListBox1;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sspeedbutton::TsSpeedButton* sSpeedButton3;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Acalphaimagelist::TsAlphaImageList* sAlphaImageList1;
	Sspeedbutton::TsSpeedButton* sSpeedButton4;
	void __fastcall sCheckBox1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall sListBox1Click(System::TObject* Sender);
	void __fastcall sPageControl1Change(System::TObject* Sender);
	void __fastcall sSpeedButton3Click(System::TObject* Sender);
	void __fastcall sSpeedButton1Click(System::TObject* Sender);
	void __fastcall sSpeedButton2Click(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FrameTLPaintBox1Paint(System::TObject* Sender);
	void __fastcall sSpeedButton4Click(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	Achintpage::TFrameHintPage* CurrentFrame;
	void __fastcall LoadTemplates(void);
	void __fastcall InitTemplate(int Index);
	void __fastcall UpdateFrame(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAlphaHintsEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAlphaHintsEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAlphaHintsEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAlphaHintsEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TAlphaHintsEdit* AlphaHintsEdit;
extern DELPHI_PACKAGE Achintpage::TFrameHintPage* FrameTR;
extern DELPHI_PACKAGE Achintpage::TFrameHintPage* FrameBR;
extern DELPHI_PACKAGE Achintpage::TFrameHintPage* FrameBL;
extern DELPHI_PACKAGE Acalphahints::TacHintTemplate* CurrentTemplate;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* PreviewBmp;
extern DELPHI_PACKAGE bool acInitializing;
extern DELPHI_PACKAGE void __fastcall ChangeStates(Vcl::Controls::TWinControl* Parent, int Tag, bool Enabled);
extern DELPHI_PACKAGE bool __fastcall EditHints(Acalphahints::TsAlphaHints* acHints);
}	/* namespace Acalphahintsedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACALPHAHINTSEDIT)
using namespace Acalphahintsedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcalphahintseditHPP
