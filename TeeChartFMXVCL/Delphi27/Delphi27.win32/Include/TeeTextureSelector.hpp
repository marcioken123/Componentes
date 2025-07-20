// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeTextureSelector.pas' rev: 34.00 (Windows)

#ifndef TeetextureselectorHPP
#define TeetextureselectorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <TeeMakerLibrary.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeMakerControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teetextureselector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTextureSelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTextureSelector : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* PanelList;
	Vcl::Stdctrls::TListBox* ListTextures;
	Vcl::Extctrls::TSplitter* SplitterList;
	Vcl::Stdctrls::TLabel* LabelSize;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Stdctrls::TLabel* LabelFileName;
	Vcl::Stdctrls::TLabel* LabelFileSize;
	Vcl::Controls::TImageList* Images;
	Vcl::Stdctrls::TCheckBox* CBEmbedd;
	Vcl::Extctrls::TPanel* Panel6;
	void __fastcall ListTexturesClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ListTexturesDblClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ListTexturesEnter(System::TObject* Sender);
	void __fastcall CBStretchClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Teemakercontrol::TMaker* Preview;
	Teeblocks::TBlocks* IBlocks;
	Teeblocks::TBlockFormat* IFormat;
	Teemakerlibrary::TMakerLibrary* ILibrary;
	System::UnicodeString IFolder;
	void __fastcall PreviewMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	Teeblocks::TBlockTexture* __fastcall PreviewTexture();
	Vcl::Graphics::TPicture* __fastcall SelectedPicture();
	void __fastcall ShowPicParams(const System::UnicodeString FileName);
	void __fastcall TreeChanged(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeEnter(System::TObject* Sender);
	
public:
	void __fastcall Fill(System::UnicodeString APath)/* overload */;
	void __fastcall Fill(Teeblocks::TBlocks* Blocks, Teeblocks::TBlockFormat* AFormat, bool Components = true)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TBlocks* AParent, Teeblocks::TBlockFormat* AFormat)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, System::UnicodeString APicFile)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Vcl::Graphics::TGraphic* AGraphic)/* overload */;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTextureSelector(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTextureSelector(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTextureSelector() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTextureSelector(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE __int64 __fastcall FileSize(const System::UnicodeString FileName);
}	/* namespace Teetextureselector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEETEXTURESELECTOR)
using namespace Teetextureselector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeetextureselectorHPP
