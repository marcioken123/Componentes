// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acPathDialog.pas' rev: 27.00 (Windows)

#ifndef AcpathdialogHPP
#define AcpathdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.FileCtrl.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <acShellCtrls.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sTreeView.hpp>	// Pascal unit
#include <sScrollBox.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acpathdialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPathDialogForm;
class PASCALIMPLEMENTATION TPathDialogForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Acshellctrls::TsShellTreeView* sShellTreeView1;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sbitbtn::TsBitBtn* sBitBtn3;
	Sscrollbox::TsScrollBox* sScrollBox1;
	Slabel::TsLabel* sLabel1;
	Acalphaimagelist::TsAlphaImageList* ImageList1;
	void __fastcall sShellTreeView1Change(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall sBitBtn3Click(System::TObject* Sender);
	void __fastcall sBitBtn2Click(System::TObject* Sender);
	void __fastcall sBitBtn1Click(System::TObject* Sender);
	
public:
	void __fastcall InitLngCaptions(void);
	void __fastcall GenerateButtons(void);
	void __fastcall UpdateAnchors(void);
	void __fastcall BtnOnClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPathDialogForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPathDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPathDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPathDialogForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TsPathDialog;
class PASCALIMPLEMENTATION TsPathDialog : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::UnicodeString FPath;
	Sconst::TacRoot FRoot;
	System::UnicodeString FCaption;
	bool FNoChangeDir;
	bool FShowRootBtns;
	Vcl::Filectrl::TSelectDirOpts FOptions;
	
public:
	__fastcall virtual TsPathDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsPathDialog(void);
	bool __fastcall Execute(void);
	
__published:
	__property System::UnicodeString Path = {read=FPath, write=FPath};
	__property Sconst::TacRoot Root = {read=FRoot, write=FRoot};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property bool NoChangeDir = {read=FNoChangeDir, write=FNoChangeDir, default=0};
	__property bool ShowRootBtns = {read=FShowRootBtns, write=FShowRootBtns, default=0};
	__property Vcl::Filectrl::TSelectDirOpts DialogOptions = {read=FOptions, write=FOptions, default=7};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TPathDialogForm* PathDialogForm;
extern DELPHI_PACKAGE int FLargeImages;
}	/* namespace Acpathdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACPATHDIALOG)
using namespace Acpathdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcpathdialogHPP
