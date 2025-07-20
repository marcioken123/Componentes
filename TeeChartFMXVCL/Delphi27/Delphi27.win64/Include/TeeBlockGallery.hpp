// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockGallery.pas' rev: 34.00 (Windows)

#ifndef TeeblockgalleryHPP
#define TeeblockgalleryHPP

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
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeMakerControl.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeComma.hpp>
#include <TeeMakerLibrary.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockGallery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockGallery : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcltee::Teecomma::TTeeCommander* TeeCommander1;
	Vcl::Buttons::TBitBtn* BitBtn1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Shadows1;
	Vcl::Menus::TMenuItem* Reflection1;
	Vcl::Menus::TMenuItem* Boundingbox1;
	Vcl::Menus::TMenuItem* Axes1;
	Vcl::Menus::TMenuItem* Texture1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Menus::TMenuItem* Borders1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabBasic;
	Vcl::Stdctrls::TListBox* ListBlocks;
	Vcl::Comctrls::TTabSheet* TabLibrary;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Controls::TImageList* Images;
	Vcl::Menus::TMenuItem* Gradient1;
	Vcl::Menus::TMenuItem* Floor1;
	Teemakercontrol::TMaker* MakerGallery;
	Vcl::Menus::TMenuItem* Antialias1;
	Vcl::Comctrls::TTabSheet* TabBlocks;
	Vcl::Comctrls::TTreeView* TreeBlocks;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListBlocksClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ListBlocksDblClick(System::TObject* Sender);
	void __fastcall MakerGallery1DblClick(System::TObject* Sender);
	void __fastcall Shadows1Click(System::TObject* Sender);
	void __fastcall Reflection1Click(System::TObject* Sender);
	void __fastcall Boundingbox1Click(System::TObject* Sender);
	void __fastcall Axes1Click(System::TObject* Sender);
	void __fastcall BitBtn1Click(System::TObject* Sender);
	void __fastcall Texture1Click(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Borders1Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall Floor1Click(System::TObject* Sender);
	void __fastcall Gradient1Click(System::TObject* Sender);
	void __fastcall Antialias1Click(System::TObject* Sender);
	void __fastcall TreeBlocksDblClick(System::TObject* Sender);
	void __fastcall TreeBlocksChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	Teeblocks::TBlockClass Current;
	Teeblocks::TBlocks* CurrentBlocks;
	Teeblocks::TCustomBlock* CurrentBlock;
	Teemakerlibrary::TMakerLibrary* ILibrary;
	System::UnicodeString ITexture;
	int LastIndex;
	void __fastcall CheckLibrary();
	Teeblocks::TCustomObjectBlock* __fastcall CreateNewObjectBlock(System::Classes::TComponent* ABlockOwner);
	void __fastcall LibraryOpenObject(System::TObject* Sender);
	void __fastcall LibrarySelectNode(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	Teeblocks::TCustomBlock* __fastcall NewBlock();
	Teeblocks::TCustomBlock* __fastcall SelectedBlock(System::Classes::TComponent* ABlockOwner);
	
public:
	__classmethod Teeblocks::TCustomBlock* __fastcall ModalShow(System::Classes::TComponent* AOwner, System::Classes::TComponent* ABlockOwner, Teeblocks::TBlockClass ACurrent = 0x0, bool ForGallery = false);
	__classmethod Teeblocks::TCustomBlock* __fastcall ChooseBlock(System::Classes::TComponent* AOwner, Teeblocks::TBlocks* ABlocks, Teeblocks::TCustomBlock* ABlock = (Teeblocks::TCustomBlock*)(0x0));
	__classmethod System::UnicodeString __fastcall ChooseObject(System::Classes::TComponent* AOwner);
	__classmethod void __fastcall ModalPreview(System::Classes::TComponent* AOwner, Teeblocks::TCustomBlock* ABlock);
	void __fastcall PrepareForGallery(Teeblocks::TCustomBlock* ABlock);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlockGallery(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlockGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlockGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlockGallery(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeblockgallery */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKGALLERY)
using namespace Teeblockgallery;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockgalleryHPP
