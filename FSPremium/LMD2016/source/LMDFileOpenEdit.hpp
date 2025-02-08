// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFileOpenEdit.pas' rev: 31.00 (Windows)

#ifndef LmdfileopeneditHPP
#define LmdfileopeneditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCustomFileEdit.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <System.UITypes.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfileopenedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFileOpenEdit;
class DELPHICLASS TLMDLabeledFileOpenEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFileOpenEdit : public Lmdcustomfileedit::TLMDCustomFileEdit
{
	typedef Lmdcustomfileedit::TLMDCustomFileEdit inherited;
	
private:
	System::Uitypes::TOpenOptions FOptions;
	System::UnicodeString FTitle;
	System::UnicodeString FInitialDir;
	System::UnicodeString FFilter;
	System::UnicodeString FDefaultExt;
	
protected:
	virtual void __fastcall DoBrowse(void);
	
public:
	__fastcall virtual TLMDFileOpenEdit(System::Classes::TComponent* aOwner);
	
__published:
	__property System::Uitypes::TOpenOptions Options = {read=FOptions, write=FOptions, default=4};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property Filename = {default=0};
	__property System::UnicodeString DefaultExt = {read=FDefaultExt, write=FDefaultExt};
	__property MinimizeName = {default=0};
	__property FilenameOnly;
	__property ReadOnly = {index=1, default=0};
	__property StartWithLastName = {default=0};
	__property StartWithLastPath = {default=0};
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDFileOpenEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFileOpenEdit(HWND ParentWindow) : Lmdcustomfileedit::TLMDCustomFileEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledFileOpenEdit : public TLMDFileOpenEdit
{
	typedef TLMDFileOpenEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledFileOpenEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledFileOpenEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledFileOpenEdit(HWND ParentWindow) : TLMDFileOpenEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfileopenedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILEOPENEDIT)
using namespace Lmdfileopenedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfileopeneditHPP
