// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExtListBox.pas' rev: 31.00 (Windows)

#ifndef LmdextlistboxHPP
#define LmdextlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomListBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <LMDClass.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdextlistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExtListBox;
class DELPHICLASS TLMDLabeledExtListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExtListBox : public Lmdcustomlistbox::TLMDCustomListBox
{
	typedef Lmdcustomlistbox::TLMDCustomListBox inherited;
	
public:
	__property Count;
	__property CtlXP;
	
__published:
	__property AutoComplete = {default=1};
	__property VirtualMode = {default=0};
	__property Columns = {default=0};
	__property Items;
	__property ItemAutoHeight = {default=0};
	__property EditOptions = {default=0};
	__property LargeTextOptions = {default=0};
	__property VerticalScrollBar = {default=1};
	__property Margin = {default=1};
	__property MultiLine = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property HorzGridColor = {default=12632256};
	__property HorzGridStyle = {default=0};
	__property HorzGridLine = {default=0};
	__property OnEditShow;
	__property OnEditMeasure;
	__property OnEditChange;
	__property OnEditHide;
	__property OnData;
	__property OnDataObject;
	__property OnDataFind;
public:
	/* TLMDCustomListBox.Create */ inline __fastcall virtual TLMDExtListBox(System::Classes::TComponent* AOwner) : Lmdcustomlistbox::TLMDCustomListBox(AOwner) { }
	/* TLMDCustomListBox.Destroy */ inline __fastcall virtual ~TLMDExtListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExtListBox(HWND ParentWindow) : Lmdcustomlistbox::TLMDCustomListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledExtListBox : public TLMDExtListBox
{
	typedef TLMDExtListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledExtListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledExtListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledExtListBox(HWND ParentWindow) : TLMDExtListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdextlistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXTLISTBOX)
using namespace Lmdextlistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdextlistboxHPP
