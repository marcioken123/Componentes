// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeSoundSelector.pas' rev: 34.00 (Windows)

#ifndef TeesoundselectorHPP
#define TeesoundselectorHPP

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
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teesoundselector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSoundSelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSoundSelector : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Comctrls::TTreeView* TreeSounds;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* BPreview;
	Vcl::Comctrls::TTrackBar* TrackVolume;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall TreeSoundsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TreeSoundsExpanding(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall TreeSoundsDblClick(System::TObject* Sender);
	void __fastcall BPreviewClick(System::TObject* Sender);
	void __fastcall TrackVolumeChange(System::TObject* Sender);
	
private:
	void __fastcall AddSoundFile(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, const System::UnicodeString AName);
	System::UnicodeString __fastcall LibrarySounds();
	
public:
	System::UnicodeString LibraryPath;
	__classmethod System::UnicodeString __fastcall ModalShow(System::Classes::TComponent* AOwner, const System::UnicodeString ALibPath);
	System::UnicodeString __fastcall SelectedSoundFile();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSoundSelector(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSoundSelector(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSoundSelector() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSoundSelector(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesoundselector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEESOUNDSELECTOR)
using namespace Teesoundselector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeesoundselectorHPP
