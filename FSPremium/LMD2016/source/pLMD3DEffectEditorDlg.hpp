// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMD3DEffectEditorDlg.pas' rev: 31.00 (Windows)

#ifndef Plmd3deffecteditordlgHPP
#define Plmd3deffecteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDCustom3DButton.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDProgress.hpp>
#include <LMDCustomButton.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDCustomProgress.hpp>
#include <LMDCaption.hpp>
#include <LMDDockButton.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemes.hpp>
#include <LMDButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemedComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmd3deffecteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMD3DEffectEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMD3DEffectEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdspinedit::TLMDSpinEdit* spind;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Extctrls::TImage* BtnImg;
	Vcl::Extctrls::TBevel* Bevel3;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdcolorcombobox::TLMDColorComboBox* cmbB;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdcolorcombobox::TLMDColorComboBox* cmbD;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Vcl::Stdctrls::TLabel* Label6;
	Lmdcolorcombobox::TLMDColorComboBox* cmbS;
	Lmdprogress::TLMDProgress* lmdprog;
	Vcl::Stdctrls::TComboBox* cmbState;
	Lmddockbutton::TLMDDockButton* dlgb;
	Lmddockbutton::TLMDDockButton* dlgd;
	Lmddockbutton::TLMDDockButton* dlgl;
	Lmddockbutton::TLMDDockButton* dlgs;
	Lmdbutton::TLMDButton* EXECUTE;
	Lmdbutton::TLMDButton* STOP;
	Lmdbutton::TLMDButton* Ok;
	Lmdbutton::TLMDButton* LMDButton4;
	Lmdbutton::TLMDButton* btngetpic;
	Lmdbutton::TLMDButton* btngetcap;
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbBChange(System::TObject* Sender);
	void __fastcall spindChange(System::TObject* Sender);
	void __fastcall dlgBClick(System::TObject* Sender);
	void __fastcall btngetpicClick(System::TObject* Sender);
	void __fastcall EXECUTEClick(System::TObject* Sender);
	void __fastcall STOPClick(System::TObject* Sender);
	void __fastcall cmbStateChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	System::Uitypes::TColor FColB;
	System::Uitypes::TColor FColD;
	System::Uitypes::TColor FColL;
	System::Uitypes::TColor FColS;
	Lmdcustom3dbutton::TLMD3DButtonBevelWidth FBevelW;
	Vcl::Graphics::TBitmap* FOrig;
	Vcl::Graphics::TBitmap* FUp;
	Vcl::Graphics::TBitmap* FDown;
	Vcl::Graphics::TBitmap* FDis;
	Lmdcaption::TLMDCaption* FCaption;
	int FDialogKind;
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMD3DEffectEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMD3DEffectEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMD3DEffectEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMD3DEffectEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool FDoTerminate;
extern DELPHI_PACKAGE void __fastcall LMDDrawCaptionFace(Lmdcaption::TLMDCaption* aCaption, Vcl::Graphics::TBitmap* aBmp);
extern DELPHI_PACKAGE bool __fastcall LMDDrawButton3D(Vcl::Graphics::TBitmap* const ASrcBitmap, Vcl::Graphics::TBitmap* AnUpBitmap, Vcl::Graphics::TBitmap* ADownBitmap, Vcl::Graphics::TBitmap* ADisabledBitmap, System::Uitypes::TColor TransparentCl, System::Uitypes::TColor LightCl, System::Uitypes::TColor ShadowCl, System::Uitypes::TColor DisabledCl, System::Uitypes::TColor OpaqueGlassColor, System::Uitypes::TColor TransparentGlassColor, System::Uitypes::TColor BevelCl, bool OpaqueGlass, int BevelWidth, Lmdprogress::TLMDProgress* aProgBar);
extern DELPHI_PACKAGE bool __fastcall LMDMakeBmpSemiTransparent(Vcl::Graphics::TBitmap* ADestBitmap, System::Uitypes::TColor TranspCol, System::Uitypes::TColor SemiTranspCol, System::Uitypes::TColor ShadowCol);
}	/* namespace Plmd3deffecteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMD3DEFFECTEDITORDLG)
using namespace Plmd3deffecteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Plmd3deffecteditordlgHPP
