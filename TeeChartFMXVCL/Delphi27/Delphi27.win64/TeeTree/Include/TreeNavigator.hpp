// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeNavigator.pas' rev: 34.00 (Windows)

#ifndef TreenavigatorHPP
#define TreenavigatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Classes.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeNavigator.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treenavigator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreePageNavigator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreePageNavigator : public Vcltee::Teenavigator::TCustomTeeNavigator
{
	typedef Vcltee::Teenavigator::TCustomTeeNavigator inherited;
	
private:
	Teetree::TCustomTree* __fastcall GetTree();
	void __fastcall SetTree(Teetree::TCustomTree* const Value);
	
protected:
	DYNAMIC void __fastcall BtnClick(Vcltee::Teenavigator::TTeeNavigateBtn Index);
	virtual void __fastcall DoTeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	
public:
	virtual void __fastcall EnableButtons();
	virtual void __fastcall Print();
	void __fastcall PrintPages(int FromPage, int ToPage);
	
__published:
	__property Teetree::TCustomTree* Tree = {read=GetTree, write=SetTree};
	__property OnButtonClicked;
public:
	/* TCustomTeeNavigator.Create */ inline __fastcall virtual TTreePageNavigator(System::Classes::TComponent* AOwner) : Vcltee::Teenavigator::TCustomTeeNavigator(AOwner) { }
	/* TCustomTeeNavigator.Destroy */ inline __fastcall virtual ~TTreePageNavigator() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreePageNavigator(HWND ParentWindow) : Vcltee::Teenavigator::TCustomTeeNavigator(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Dialogs::TPrintDialog* __fastcall TreePrintDialog(Teetree::TCustomTree* const Tree);
}	/* namespace Treenavigator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREENAVIGATOR)
using namespace Treenavigator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreenavigatorHPP
