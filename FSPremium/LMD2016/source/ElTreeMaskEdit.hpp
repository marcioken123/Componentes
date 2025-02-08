// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeMaskEdit.pas' rev: 31.00 (Windows)

#ifndef EltreemaskeditHPP
#define EltreemaskeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.MaskUtils.hpp>
#include <Vcl.Mask.hpp>
#include <LMDProcs.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElMaskEdit.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreemaskedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceMaskEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceMaskEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetCharCase(System::Uitypes::TEditCharCase Value);
	System::Uitypes::TEditCharCase __fastcall GetCharCase(void);
	void __fastcall SetEditMask(System::Maskutils::TEditMask Value);
	System::Maskutils::TEditMask __fastcall GetEditMask(void);
	System::WideChar __fastcall GetPasswordChar(void);
	void __fastcall SetPasswordChar(System::WideChar Value);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Elmaskedit::TElMaskEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElTreeInplaceMaskEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceMaskEdit(void);
	__property Elmaskedit::TElMaskEdit* Editor = {read=GetEditor};
	
__published:
	__property Font;
	__property System::Uitypes::TEditCharCase CharCase = {read=GetCharCase, write=SetCharCase, stored=true, nodefault};
	__property System::Maskutils::TEditMask EditMask = {read=GetEditMask, write=SetEditMask};
	__property System::WideChar PasswordChar = {read=GetPasswordChar, write=SetPasswordChar, nodefault};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreemaskedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEMASKEDIT)
using namespace Eltreemaskedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreemaskeditHPP
