// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDNoteBook.pas' rev: 31.00 (Windows)

#ifndef LmdnotebookHPP
#define LmdnotebookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDCustomSheetControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <LMDBitmapEffectObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdnotebook
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDNoteBookPage;
class DELPHICLASS TLMDNoteBook;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDNoteBookPage : public Lmdcustomsheetcontrol::TLMDCustomSheet
{
	typedef Lmdcustomsheetcontrol::TLMDCustomSheet inherited;
	
__published:
	__property BackFX;
	__property BackFXPass = {default=0};
	__property Included = {default=1};
	__property Transparent = {default=0};
public:
	/* TLMDCustomSheet.Create */ inline __fastcall virtual TLMDNoteBookPage(System::Classes::TComponent* AOwner) : Lmdcustomsheetcontrol::TLMDCustomSheet(AOwner) { }
	/* TLMDCustomSheet.Destroy */ inline __fastcall virtual ~TLMDNoteBookPage(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDNoteBookPage(HWND ParentWindow) : Lmdcustomsheetcontrol::TLMDCustomSheet(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDNoteBookPageChangeEvent)(System::TObject* Sender, TLMDNoteBookPage* NewPage, bool &Cancel);

class PASCALIMPLEMENTATION TLMDNoteBook : public Lmdcustomsheetcontrol::TLMDCustomSheetControl
{
	typedef Lmdcustomsheetcontrol::TLMDCustomSheetControl inherited;
	
private:
	TLMDNoteBookPageChangeEvent FOnPageChange;
	void __fastcall SetActivePage(TLMDNoteBookPage* aValue);
	TLMDNoteBookPage* __fastcall GetPage(int Index);
	TLMDNoteBookPage* __fastcall GetActivePage(void);
	
protected:
	virtual void __fastcall DoPageChange(Lmdcustomsheetcontrol::TLMDCustomSheet* NewPage, bool &Cancel);
	
public:
	__fastcall virtual TLMDNoteBook(System::Classes::TComponent* AnOwner);
	virtual Lmdcustomsheetcontrol::TLMDSheetClass __fastcall GetSheetClass(void);
	__property CtlXP = {default=0};
	__property TLMDNoteBookPage* Page[int Index] = {read=GetPage};
	
__published:
	__property TLMDNoteBookPage* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property PageIndex;
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property TLMDNoteBookPageChangeEvent OnChanging = {read=FOnPageChange, write=FOnPageChange};
public:
	/* TLMDCustomSheetControl.Destroy */ inline __fastcall virtual ~TLMDNoteBook(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDNoteBook(HWND ParentWindow) : Lmdcustomsheetcontrol::TLMDCustomSheetControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdnotebook */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDNOTEBOOK)
using namespace Lmdnotebook;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdnotebookHPP
