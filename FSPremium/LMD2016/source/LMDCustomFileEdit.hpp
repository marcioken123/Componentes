// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomFileEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcustomfileeditHPP
#define LmdcustomfileeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomfileedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomFileEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomFileEdit : public Lmdcustombrowseedit::TLMDCustomBrowseEdit
{
	typedef Lmdcustombrowseedit::TLMDCustomBrowseEdit inherited;
	
private:
	bool FFilenameOnly;
	bool FLastPath;
	bool FLastFile;
	bool FEllipse;
	System::UnicodeString FFullText;
	void __fastcall SetFilenameOnly(bool aValue);
	void __fastcall SetFilename(const System::UnicodeString aValue);
	System::UnicodeString __fastcall GetFileName(void);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall UpdateText(void);
	virtual void __fastcall SetNewText(void);
	__property System::UnicodeString FullText = {read=FFullText};
	__property System::UnicodeString Filename = {read=GetFileName, write=SetFilename};
	__property bool StartWithLastPath = {read=FLastPath, write=FLastPath, default=0};
	__property bool StartWithLastName = {read=FLastFile, write=FLastFile, default=0};
	
public:
	__fastcall virtual TLMDCustomFileEdit(System::Classes::TComponent* aOwner);
	__property bool MinimizeName = {read=FEllipse, write=FEllipse, default=0};
	__property bool FilenameOnly = {read=FFilenameOnly, write=SetFilenameOnly, nodefault};
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDCustomFileEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFileEdit(HWND ParentWindow) : Lmdcustombrowseedit::TLMDCustomBrowseEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomfileedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMFILEEDIT)
using namespace Lmdcustomfileedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomfileeditHPP
