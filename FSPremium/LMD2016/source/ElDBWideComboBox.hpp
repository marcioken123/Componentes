// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBWideComboBox.pas' rev: 31.00 (Windows)

#ifndef EldbwidecomboboxHPP
#define EldbwidecomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <ElDBCtrls.hpp>
#include <LMDTypes.hpp>
#include <LMDElDBConst.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDUnicode.hpp>
#include <System.Classes.hpp>
#include <ElDBBoxes.hpp>
#include <HTMLLbx.hpp>
#include <ElCombos.hpp>
#include <ElBtnEdit.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbwidecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElWideDBComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElWideDBComboBox : public Eldbboxes::TElDBComboBox
{
	typedef Eldbboxes::TElDBComboBox inherited;
	
private:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	Lmdtypes::TLMDString __fastcall GetDBText(void);
	
protected:
	virtual void __fastcall DataChange(System::TObject* Sender);
	virtual void __fastcall UpdateData(System::TObject* Sender);
	
__published:
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=SetUnicodeMode, default=0};
	__property StressShortCut = {default=0};
public:
	/* TElDBComboBox.Create */ inline __fastcall virtual TElWideDBComboBox(System::Classes::TComponent* AOwner) : Eldbboxes::TElDBComboBox(AOwner) { }
	/* TElDBComboBox.Destroy */ inline __fastcall virtual ~TElWideDBComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBComboBox(HWND ParentWindow) : Eldbboxes::TElDBComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbwidecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBWIDECOMBOBOX)
using namespace Eldbwidecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbwidecomboboxHPP
