// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcustomeditHPP
#define LmdcustomeditHPP

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
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDSBtn.hpp>
#include <LMDBase.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDButtonBase.hpp>
#include <LMDEditAutoComplete.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMD3DCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnBtnClick)(System::TObject* Sender, System::TObject* Btn, int index);

class PASCALIMPLEMENTATION TLMDCustomEdit : public Lmdbaseedit::TLMDBaseEdit
{
	typedef Lmdbaseedit::TLMDBaseEdit inherited;
	
private:
	System::WideChar FPasswordChar;
	Lmdtypes::TLMDString FSpecialText;
	bool FAutoSize;
	Lmdsbtn::TLMDSpecialButtons* FCustomButtons;
	int FCustomButtonWidth;
	Lmdbuttonbase::TLMDUserButtonStyle FCustomButtonStyle;
	Lmdeditautocomplete::TLMDEditAutoComplete* FAutoComplete;
	TLMDOnBtnClick FOnBtnClick;
	bool FCustomXP;
	Lmdtypes::TLMDString FCueBanner;
	bool FPainting;
	bool FIsEmpty;
	System::Types::TRect FPaintRectWB;
	void __fastcall SetPasswordChar(System::WideChar aValue);
	HIDESBASE void __fastcall SetAutoSize(bool aValue);
	void __fastcall SetCustomButtons(Lmdsbtn::TLMDSpecialButtons* aValue);
	void __fastcall SetCustomButtonWidth(int aValue);
	void __fastcall SetCustomButtonXP(const bool Value);
	void __fastcall SetAutoComplete(Lmdeditautocomplete::TLMDEditAutoComplete* aValue);
	void __fastcall ReadOldBtnStyle(System::Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMLMDBevelChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall EMGETPASSWORDCHAR(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall EMSETPASSWORDCHAR(Winapi::Messages::TMessage &Message);
	void __fastcall SetCueBanner(const Lmdtypes::TLMDString Value);
	void __fastcall SetIsEmpty(const bool Value);
	System::WideChar __fastcall GetPasswordChar(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall BackOneMore(void);
	virtual int __fastcall CalcMousePos(System::Types::TSmallPoint Pos);
	virtual int __fastcall CalcMouseCol(int XPos);
	virtual int __fastcall CalcMouseRow(int YPos);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoThemeChanged(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall CreateSpecialText(Lmdtypes::TLMDString &s);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall FinishedSetSelText(void);
	virtual void __fastcall HandleInsertText(int at, Lmdtypes::TLMDString &aValue);
	virtual void __fastcall SetNewText(void);
	virtual void __fastcall GetNewText(void);
	virtual void __fastcall RedefineTextColor(Vcl::Graphics::TCanvas* C);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	HIDESBASE void __fastcall DrawEditText(int from, const Lmdtypes::TLMDString aTxt)/* overload */;
	virtual void __fastcall CorrectBounds(void);
	virtual void __fastcall DoAClick(System::TObject* Btn, int index);
	virtual void __fastcall UpdateCustomButtonsThemeMode(void);
	virtual bool __fastcall AllowCopyPaste(void);
	virtual void __fastcall DrawSpecialTextBackground(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall SetCustomButtonsXPMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetCaret(void);
	virtual void __fastcall SetCustomButtonStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	__property Lmdtypes::TLMDString SpecialText = {read=FSpecialText, write=FSpecialText};
	__property Lmdeditautocomplete::TLMDEditAutoComplete* AutoComplete = {read=FAutoComplete, write=SetAutoComplete};
	__property bool IsEmpty = {read=FIsEmpty, write=SetIsEmpty, default=0};
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall ShowCueBanner(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintCueBanner(Vcl::Graphics::TCanvas* Canvas);
	virtual bool __fastcall RedrawOnEnter(void);
	virtual bool __fastcall RedrawOnExit(void);
	virtual void __fastcall ModifyPaintRect(void);
	
public:
	__fastcall virtual TLMDCustomEdit(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomEdit(void);
	void __fastcall BtnClick(int index);
	void __fastcall SetBorders(void);
	virtual void __fastcall CorrectWidth(void);
	__property Text;
	__property System::WideChar PasswordChar = {read=GetPasswordChar, write=SetPasswordChar, nodefault};
	__property Lmdsbtn::TLMDSpecialButtons* CustomButtons = {read=FCustomButtons, write=SetCustomButtons};
	__property int CustomButtonWidth = {read=FCustomButtonWidth, write=SetCustomButtonWidth, default=16};
	__property Lmdbuttonbase::TLMDUserButtonStyle CustomButtonsStyle = {read=FCustomButtonStyle, write=SetCustomButtonStyle, default=9};
	__property Lmdbuttonbase::TLMDUserButtonStyle CustomButtonStyle = {read=FCustomButtonStyle, write=SetCustomButtonStyle, nodefault};
	__property bool CustomButtonParentCtlXP = {read=FCustomXP, write=SetCustomButtonXP, default=1};
	__property ReadOnly = {index=1, default=0};
	__property TLMDOnBtnClick OnBtnClick = {read=FOnBtnClick, write=FOnBtnClick};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property Lmdtypes::TLMDString CueBanner = {read=FCueBanner, write=SetCueBanner};
	__property DraggingAllowed = {default=1};
	__property Font;
	__property CharCase = {default=0};
	__property Font3D;
	__property MaxLength = {index=0, default=0};
	__property HideSelection = {index=0, default=1};
	__property AutoSelect = {index=4, default=0};
	__property OEMConvert = {index=5, default=0};
	__property ParentFont = {default=1};
	__property Options = {default=56};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomEdit(HWND ParentWindow) : Lmdbaseedit::TLMDBaseEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMEDIT)
using namespace Lmdcustomedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomeditHPP
