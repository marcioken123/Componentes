// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeMemoEdit.pas' rev: 31.00 (Windows)

#ifndef EltreememoeditHPP
#define EltreememoeditHPP

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
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Math.hpp>
#include <LMDThemes.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDVldBase.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElEdits.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreememoedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMemoForm;
class DELPHICLASS TElInpMemo;
class DELPHICLASS TElTreeInplaceMemoEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMemoForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	TElTreeInplaceMemoEdit* FTreeMemoEdit;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	MESSAGE void __fastcall WMEnterSizeMove(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Message);
	
public:
	__fastcall virtual TMemoForm(System::Classes::TComponent* AOwner, int Dummy);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMemoForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMemoForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMemoForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElInpMemo : public Eledits::TElMemo
{
	typedef Eledits::TElMemo inherited;
	
private:
	TElTreeInplaceMemoEdit* FTreeMemoEdit;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	
protected:
	virtual void __fastcall Paint(void);
public:
	/* TCustomElMemo.Create */ inline __fastcall virtual TElInpMemo(System::Classes::TComponent* AOwner) : Eledits::TElMemo(AOwner) { }
	
public:
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElInpMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElInpMemo(HWND ParentWindow) : Eledits::TElMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceMemoEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	TMemoForm* FForm;
	bool FShowGripper;
	bool FIgnoreFocus;
	void __fastcall SetHeight(int value);
	int __fastcall GetHeight(void);
	void __fastcall SetShowGripper(bool Value);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	virtual void __fastcall AdjustBounds(void);
	Eledits::TElMemo* __fastcall GetEditor(void);
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
	__fastcall virtual TElTreeInplaceMemoEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceMemoEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	__property Eledits::TElMemo* Editor = {read=GetEditor};
	
__published:
	__property Font;
	__property int Height = {read=GetHeight, write=SetHeight, default=89};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool ShowGripper = {read=FShowGripper, write=SetShowGripper, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreememoedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEMEMOEDIT)
using namespace Eltreememoedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreememoeditHPP
