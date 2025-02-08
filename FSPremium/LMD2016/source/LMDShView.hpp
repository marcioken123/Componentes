// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShView.pas' rev: 31.00 (Windows)

#ifndef LmdshviewHPP
#define LmdshviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDShBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshview
{
//-- forward type declarations -----------------------------------------------
__interface ILMDShellView;
typedef System::DelphiInterface<ILMDShellView> _di_ILMDShellView;
__interface ILMDShellEdit;
typedef System::DelphiInterface<ILMDShellEdit> _di_ILMDShellEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDShellItemFilter)(System::TObject* Sender, Lmdshbase::TLMDCustomShellItem* ShellItem, bool &Accept);

typedef void __fastcall (__closure *TLMDShellItemEvent)(System::TObject* Sender, Lmdshbase::TLMDCustomShellItem* Item);

__interface  INTERFACE_UUID("{3E2D823C-8076-4FB1-8676-CE94E56ED34F}") ILMDShellView  : public System::IInterface 
{
	virtual void __fastcall BeginUpdate(void) = 0 ;
	virtual void __fastcall EndUpdate(void) = 0 ;
	virtual void __fastcall BeginEnumeration(void) = 0 ;
	virtual void __fastcall EndEnumeration(void) = 0 ;
	virtual bool __fastcall TerminateEnumeration(void) = 0 ;
	virtual void __fastcall AddItem(Lmdshbase::TLMDCustomShellItem* aItem) = 0 ;
	virtual void __fastcall ActiveFolderChanged(void) = 0 ;
	virtual Lmdshbase::TLMDCustomShellController* __fastcall Controller(void) = 0 ;
	virtual void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2) = 0 ;
	virtual void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2) = 0 ;
	virtual void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2) = 0 ;
};

__interface  INTERFACE_UUID("{CF5219D0-A7F6-494D-9329-D38F24217EEC}") ILMDShellEdit  : public System::IInterface 
{
	virtual bool __fastcall Editable(void) = 0 ;
	virtual bool __fastcall CanCut(void) = 0 ;
	virtual bool __fastcall CanCopy(void) = 0 ;
	virtual bool __fastcall CanDelete(void) = 0 ;
	virtual bool __fastcall CanPaste(void) = 0 ;
	virtual bool __fastcall CanRename(void) = 0 ;
	virtual bool __fastcall CanAccessItem(void) = 0 ;
	virtual void __fastcall CopyToClipboard(void) = 0 ;
	virtual void __fastcall CutToClipboard(void) = 0 ;
	virtual void __fastcall PasteFromClipboard(void) = 0 ;
	virtual void __fastcall DeleteItems(void) = 0 ;
	virtual void __fastcall ShowProperties(void) = 0 ;
	virtual void __fastcall CopyFileNameAsText(void) = 0 ;
	virtual void __fastcall CopyPathAsText(void) = 0 ;
	virtual bool __fastcall NewFolder(void) = 0 ;
	virtual void __fastcall Open(void) = 0 ;
	virtual void __fastcall OpenWith(void) = 0 ;
	virtual bool __fastcall Rename(void) = 0 ;
	virtual void __fastcall CopyItems(const System::UnicodeString Target) = 0 ;
	virtual void __fastcall MoveItems(const System::UnicodeString Target) = 0 ;
	virtual void __fastcall ExecuteCommand(const System::UnicodeString Verb, bool &Handled) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE GUID IID_ILMDShellView;
}	/* namespace Lmdshview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHVIEW)
using namespace Lmdshview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshviewHPP
