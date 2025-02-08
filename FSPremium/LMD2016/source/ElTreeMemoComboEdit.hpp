// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeMemoComboEdit.pas' rev: 31.00 (Windows)

#ifndef EltreememocomboeditHPP
#define EltreememocomboeditHPP

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
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDProcs.hpp>
#include <LMDVldBase.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElMemoCombo.hpp>
#include <ElTreeInplaceEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreememocomboedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceMemoComboEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceMemoComboEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	System::Classes::TWndMethod SaveMemoWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall MemoWndProc(Winapi::Messages::TMessage &Message);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Elmemocombo::TElMemoCombo* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	
public:
	__fastcall virtual TElTreeInplaceMemoComboEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceMemoComboEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	__property Elmemocombo::TElMemoCombo* Editor = {read=GetEditor};
	
__published:
	__property Font;
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreememocomboedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEMEMOCOMBOEDIT)
using namespace Eltreememocomboedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreememocomboeditHPP
