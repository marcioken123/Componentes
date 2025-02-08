// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShBrwDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshbrwdlgHPP
#define LmdshbrwdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <LMDShBase.hpp>
#include <LMDShMisc.hpp>
#include <LMDShController.hpp>
#include <LMDShTree.hpp>
#include <LMDShFolder.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshbrwdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellBrowseDialog;
class DELPHICLASS TLMDShellfrmBrowseDialog;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDShellBrowseDialogEvent)(System::TObject* Sender, TLMDShellfrmBrowseDialog* aForm);

enum DECLSPEC_DENUM TLMDShellBrowseDialogOption : unsigned char { doSizeable, doSizeGrip, doInstructionField, doCreateButton, doCreateSpeedButton, doDeleteSpeedButton, doStatusBar, doShowHidden, doShowHints, doReadOnly, doShowContextMenu };

typedef System::Set<TLMDShellBrowseDialogOption, TLMDShellBrowseDialogOption::doSizeable, TLMDShellBrowseDialogOption::doShowContextMenu> TLMDShellBrowseDialogOptions;

class PASCALIMPLEMENTATION TLMDShellBrowseDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	TLMDShellfrmBrowseDialog* FDialog;
	System::UnicodeString FCaption;
	System::UnicodeString FDescription;
	System::UnicodeString FDisplayName;
	System::UnicodeString FInstructionText;
	System::UnicodeString FStatusText;
	unsigned FImageIndex;
	Vcl::Graphics::TBitmap* FImageLarge;
	Vcl::Graphics::TBitmap* FImageSmall;
	System::Sysutils::TFileName FSelectedPath;
	TLMDShellBrowseDialogOptions FOptions;
	TLMDShellBrowseDialogEvent FOnInit;
	TLMDShellBrowseDialogEvent FOnResize;
	Lmdshutils::TLMDRoot FRootFolder;
	void __fastcall SetCaption(const System::UnicodeString aValue);
	void __fastcall SetStatusText(const System::UnicodeString aValue);
	Vcl::Graphics::TBitmap* __fastcall GetImage(int Index);
	void __fastcall SetOptions(TLMDShellBrowseDialogOptions aValue);
	
protected:
	DYNAMIC void __fastcall DoInit(TLMDShellfrmBrowseDialog* aForm);
	DYNAMIC void __fastcall DoResize(TLMDShellfrmBrowseDialog* aForm);
	
public:
	__fastcall virtual TLMDShellBrowseDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellBrowseDialog(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__property System::UnicodeString Description = {read=FDescription};
	__property System::UnicodeString DisplayName = {read=FDisplayName};
	__property unsigned ImageIndex = {read=FImageIndex, nodefault};
	__property Vcl::Graphics::TBitmap* ImageLarge = {read=GetImage, index=1};
	__property Vcl::Graphics::TBitmap* ImageSmall = {read=GetImage, index=2};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString InstructionText = {read=FInstructionText, write=FInstructionText};
	__property TLMDShellBrowseDialogOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Lmdshutils::TLMDRoot RootFolder = {read=FRootFolder, write=FRootFolder};
	__property System::Sysutils::TFileName SelectedPath = {read=FSelectedPath, write=FSelectedPath, stored=false};
	__property System::UnicodeString StatusText = {read=FStatusText, write=SetStatusText};
	__property TLMDShellBrowseDialogEvent OnInitialize = {read=FOnInit, write=FOnInit};
	__property TLMDShellBrowseDialogEvent OnResize = {read=FOnResize, write=FOnResize};
};


class PASCALIMPLEMENTATION TLMDShellfrmBrowseDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TStatusBar* StatusBar;
	Lmdshfolder::TLMDShellFolder* ShellFolder;
	Vcl::Extctrls::TPanel* pnlBottom;
	Vcl::Stdctrls::TButton* btnCreateFolder;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Extctrls::TPanel* pnlTop;
	Vcl::Buttons::TSpeedButton* sbtnDeleteFolder;
	Vcl::Buttons::TSpeedButton* sbtnCreateFolder;
	Vcl::Extctrls::TPanel* pnlTree;
	Lmdshtree::TLMDShellTree* ShellTree;
	Vcl::Stdctrls::TLabel* lblInstruction;
	void __fastcall sbtnDeleteFolderClick(System::TObject* Sender);
	void __fastcall ShellFolderChange(System::TObject* Sender);
	void __fastcall sbtnCreateFolderClick(System::TObject* Sender);
	void __fastcall ShellTreeItemSelected(System::TObject* Sender, Lmdshbase::TLMDCustomShellItem* Item);
	
private:
	TLMDShellBrowseDialog* FComponent;
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	
public:
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShellfrmBrowseDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShellfrmBrowseDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShellfrmBrowseDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellfrmBrowseDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshbrwdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHBRWDLG)
using namespace Lmdshbrwdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshbrwdlgHPP
