// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeTreeComboEdit.pas' rev: 31.00 (Windows)

#ifndef EltreetreecomboeditHPP
#define EltreetreecomboeditHPP

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
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <LMDProcs.hpp>
#include <LMDVldBase.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElTreeCombo.hpp>
#include <ElTreeInplaceEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreetreecomboedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTreeInplaceTreeComboEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTreeInplaceTreeComboEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	Vcl::Graphics::TFont* FTreeFont;
	System::Classes::TWndMethod SaveWndProc;
	System::Classes::TWndMethod SaveTreeWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall TreeWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetItems_FTree(Eltree::TElTreeItems* Value);
	Eltree::TElTreeItems* __fastcall GetItems_FTree(void);
	void __fastcall SetFont_FTree(Vcl::Graphics::TFont* Value);
	bool __fastcall GetShowImages(void);
	void __fastcall SetShowImages(bool Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetImages_FTree(void);
	void __fastcall SetImages_FTree(Vcl::Imglist::TCustomImageList* Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetTreeImages2(void);
	void __fastcall SetTreeImages2(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
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
	Eltreecombo::TElTreeCombo* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	void __fastcall TreeFontChange(System::TObject* Sender);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElTreeInplaceTreeComboEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceTreeComboEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	__property Eltreecombo::TElTreeCombo* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Eltree::TElTreeItems* Items = {read=GetItems_FTree, write=SetItems_FTree};
	__property Font;
	__property Vcl::Graphics::TFont* TreeFont = {read=FTreeFont, write=SetFont_FTree};
	__property bool ShowImages = {read=GetShowImages, write=SetShowImages, nodefault};
	__property Vcl::Imglist::TCustomImageList* Images = {read=GetImages_FTree, write=SetImages_FTree};
	__property Vcl::Imglist::TCustomImageList* Images2 = {read=GetTreeImages2, write=SetTreeImages2};
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreetreecomboedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREETREECOMBOEDIT)
using namespace Eltreetreecomboedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreetreecomboeditHPP
