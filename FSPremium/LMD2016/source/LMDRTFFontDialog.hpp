// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFFontDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtffontdialogHPP
#define LmdrtffontdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <Winapi.CommDlg.hpp>
#include <LMDRTFRichEdit.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtffontdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFFontDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRTFFontDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
private:
	bool FDisabled;
	bool FLink;
	bool FRevised;
	bool FHidden;
	Lmdrtfrichedit::TLMDCustomRichEdit* FRichEdit;
	Lmdrtfrichedit::TLMDAttributeType FAttributeType;
	Lmdrtfrichedit::TLMDRichSubscriptStyle FSubscriptStyle;
	Lmdrtfrichedit::TLMDUnderlineType FUnderlineType;
	System::Uitypes::TColor FBkColor;
	void __fastcall UpdateFromLogFont(const tagLOGFONTW &LogFont);
	Lmdrtfrichedit::TLMDTextAttributes* __fastcall GetTextAttributes(void);
	void __fastcall SetRichEdit(Lmdrtfrichedit::TLMDCustomRichEdit* Value);
	void __fastcall SetAttributeType(Lmdrtfrichedit::TLMDAttributeType Value);
	
public:
	__fastcall virtual TLMDRTFFontDialog(System::Classes::TComponent* aOwner);
	virtual bool __fastcall Execute(void)/* overload */;
	__property Lmdrtfrichedit::TLMDTextAttributes* TextAttributes = {read=GetTextAttributes};
	
__published:
	__property Lmdrtfrichedit::TLMDCustomRichEdit* RichEdit = {read=FRichEdit, write=SetRichEdit};
	__property Lmdrtfrichedit::TLMDAttributeType AttributeType = {read=FAttributeType, write=SetAttributeType, default=0};
public:
	/* TCommonDialog.Destroy */ inline __fastcall virtual ~TLMDRTFFontDialog(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtffontdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFFONTDIALOG)
using namespace Lmdrtffontdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtffontdialogHPP
