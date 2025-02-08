// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBrowseEdit.pas' rev: 31.00 (Windows)

#ifndef LmdbrowseeditHPP
#define LmdbrowseeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDBrowseDlg.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbrowseedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBrowseEdit;
class DELPHICLASS TLMDLabeledBrowseEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDBrowseExecuteEvent)(System::TObject* Sender, Lmdbrowsedlg::TLMDBrowseDlg* bDlg);

class PASCALIMPLEMENTATION TLMDBrowseEdit : public Lmdcustombrowseedit::TLMDCustomBrowseEdit
{
	typedef Lmdcustombrowseedit::TLMDCustomBrowseEdit inherited;
	
private:
	Lmdbrowsedlg::TLMDBrowseDlgOptions FOptions;
	Lmdbrowsedlg::TLMDSystemFolders FStartFolder;
	bool FEllipse;
	bool FStartWithLast;
	TLMDBrowseExecuteEvent FOnExecute;
	System::UnicodeString FFullText;
	void __fastcall SetPath(const System::UnicodeString aValue);
	System::UnicodeString __fastcall GetPath(void);
	void __fastcall SetEllipse(const bool Value);
	
protected:
	virtual void __fastcall DoBrowse(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall UpdateText(void);
	virtual void __fastcall SetNewText(void);
	
public:
	__fastcall virtual TLMDBrowseEdit(System::Classes::TComponent* aOwner);
	virtual void __fastcall Loaded(void);
	__property System::UnicodeString FullText = {read=FFullText};
	
__published:
	__property Lmdbrowsedlg::TLMDBrowseDlgOptions Options = {read=FOptions, write=FOptions, default=272};
	__property System::UnicodeString Path = {read=GetPath, write=SetPath};
	__property Lmdbrowsedlg::TLMDSystemFolders StartFolder = {read=FStartFolder, write=FStartFolder, default=1};
	__property bool StartWithLast = {read=FStartWithLast, write=FStartWithLast, default=0};
	__property bool MinimizeName = {read=FEllipse, write=SetEllipse, default=0};
	__property ReadOnly = {index=1, default=0};
	__property TLMDBrowseExecuteEvent OnExecute = {read=FOnExecute, write=FOnExecute};
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDBrowseEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBrowseEdit(HWND ParentWindow) : Lmdcustombrowseedit::TLMDCustomBrowseEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledBrowseEdit : public TLMDBrowseEdit
{
	typedef TLMDBrowseEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledBrowseEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledBrowseEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledBrowseEdit(HWND ParentWindow) : TLMDBrowseEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbrowseedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBROWSEEDIT)
using namespace Lmdbrowseedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbrowseeditHPP
