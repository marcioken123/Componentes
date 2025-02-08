// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeAdvEdit.pas' rev: 31.00 (Windows)

#ifndef EltreeadveditHPP
#define EltreeadveditHPP

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
#include <ElStyleMan.hpp>
#include <System.Types.hpp>
#include <LMDProcs.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElEdits.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDVldBase.hpp>
#include <ElInputProcessor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreeadvedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceAdvancedEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceAdvancedEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetCharCase(Elinputprocessor::TElEditCharCase Value);
	Elinputprocessor::TElEditCharCase __fastcall GetCharCase(void);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Eledits::TElEdit* __fastcall GetEditor(void);
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
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
public:
	__fastcall virtual TElTreeInplaceAdvancedEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceAdvancedEdit(void);
	__property Eledits::TElEdit* Editor = {read=GetEditor};
	
__published:
	__property Font;
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Elinputprocessor::TElEditCharCase CharCase = {read=GetCharCase, write=SetCharCase, stored=true, nodefault};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreeadvedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEADVEDIT)
using namespace Eltreeadvedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreeadveditHPP
