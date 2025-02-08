// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeStdEditors.pas' rev: 31.00 (Windows)

#ifndef EltreestdeditorsHPP
#define EltreestdeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDProcs.hpp>
#include <LMDVldBase.hpp>
#include <ElEdits.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElTreeInplaceEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreestdeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceEdit;
class DELPHICLASS TElTreeInplaceMemo;
class DELPHICLASS TElTreeInplaceCheckBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Eledits::TElEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	
public:
	__fastcall virtual TElTreeInplaceEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	__property Eledits::TElEdit* Editor = {read=GetEditor};
	
__published:
	__property Font;
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElTreeInplaceMemo : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetHeight(int value);
	int __fastcall GetHeight(void);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Vcl::Stdctrls::TMemo* __fastcall GetEditor(void);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual void __fastcall SetEditorParent(void);
	
public:
	__fastcall virtual TElTreeInplaceMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceMemo(void);
	__property Vcl::Stdctrls::TMemo* Editor = {read=GetEditor};
	
__published:
	__property int Height = {read=GetHeight, write=SetHeight, stored=true, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
};


class PASCALIMPLEMENTATION TElTreeInplaceCheckBox : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall AdjustBounds(void);
	Vcl::Stdctrls::TCheckBox* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	
public:
	__fastcall virtual TElTreeInplaceCheckBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceCheckBox(void);
	__property Vcl::Stdctrls::TCheckBox* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreestdeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREESTDEDITORS)
using namespace Eltreestdeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreestdeditorsHPP
