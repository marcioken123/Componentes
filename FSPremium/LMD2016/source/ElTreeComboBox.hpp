// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeComboBox.pas' rev: 31.00 (Windows)

#ifndef EltreecomboboxHPP
#define EltreecomboboxHPP

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
#include <HTMLLbx.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElCombos.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElHeader.hpp>
#include <LMDProcs.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDVldBase.hpp>
#include <ElBtnEdit.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackTrCombo;
class DELPHICLASS THackInplaceComboBox;
class DELPHICLASS TElTreeInplaceComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackTrCombo : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
public:
	/* TCustomElComboBox.Create */ inline __fastcall virtual THackTrCombo(System::Classes::TComponent* AOwner) : Elcombos::TCustomElComboBox(AOwner) { }
	/* TCustomElComboBox.Destroy */ inline __fastcall virtual ~THackTrCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackTrCombo(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackInplaceComboBox : public Htmllbx::TElHTMLComboBox
{
	typedef Htmllbx::TElHTMLComboBox inherited;
	
protected:
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, NativeUInt ComboWnd, void * ComboProc);
public:
	/* TCustomElHTMLComboBox.Create */ inline __fastcall virtual THackInplaceComboBox(System::Classes::TComponent* AOwner) : Htmllbx::TElHTMLComboBox(AOwner) { }
	/* TCustomElHTMLComboBox.Destroy */ inline __fastcall virtual ~THackInplaceComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackInplaceComboBox(HWND ParentWindow) : Htmllbx::TElHTMLComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceComboBox : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
	bool __fastcall GetIsHTML(void);
	void __fastcall SetIsHTML(const bool Value);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	bool FInitiallyDropped;
	virtual void __fastcall AdjustBounds(void);
	Htmllbx::TElHTMLComboBox* __fastcall GetEditor(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElTreeInplaceComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceComboBox(void);
	__property Htmllbx::TElHTMLComboBox* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool InitiallyDropped = {read=FInitiallyDropped, write=FInitiallyDropped, nodefault};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems, stored=true};
	__property Font;
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, default=1};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREECOMBOBOX)
using namespace Eltreecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreecomboboxHPP
