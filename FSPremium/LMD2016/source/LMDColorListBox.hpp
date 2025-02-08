// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDColorListBox.pas' rev: 31.00 (Windows)

#ifndef LmdcolorlistboxHPP
#define LmdcolorlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomColorListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcolorlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDColorListBox;
class DELPHICLASS TLMDLabeledColorListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDColorListBox : public Lmdcustomcolorlistbox::TLMDCustomColorListBox
{
	typedef Lmdcustomcolorlistbox::TLMDCustomColorListBox inherited;
	
public:
	/* TLMDCustomColorListBox.Create */ inline __fastcall virtual TLMDColorListBox(System::Classes::TComponent* AOwner) : Lmdcustomcolorlistbox::TLMDCustomColorListBox(AOwner) { }
	/* TLMDCustomColorListBox.Destroy */ inline __fastcall virtual ~TLMDColorListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDColorListBox(HWND ParentWindow) : Lmdcustomcolorlistbox::TLMDCustomColorListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledColorListBox : public Lmdcustomcolorlistbox::TLMDCustomColorListBox
{
	typedef Lmdcustomcolorlistbox::TLMDCustomColorListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledColorListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomColorListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledColorListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledColorListBox(HWND ParentWindow) : Lmdcustomcolorlistbox::TLMDCustomColorListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcolorlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOLORLISTBOX)
using namespace Lmdcolorlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcolorlistboxHPP
