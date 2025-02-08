// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseDialog.pas' rev: 31.00 (Windows)

#ifndef LmdbasedialogHPP
#define LmdbasedialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDClass.hpp>
#include <LMDFormStyler.hpp>
#include <LMDCustomFormFill.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBaseDialog : public Lmdcontainercomponent::TLMDContainerComponent
{
	typedef Lmdcontainercomponent::TLMDContainerComponent inherited;
	
private:
	System::UnicodeString FCaptionTitle;
	System::UnicodeString FCustomButton;
	Lmdclass::TLMDDlgEffect FEffect;
	System::Classes::TStringList* FHints;
	bool FShowHint;
	bool FFillCaption;
	System::Byte FColors;
	Vcl::Graphics::TFont* FFont;
	Lmdclass::TLMDDlgPosition FPosition;
	Lmdclass::TLMDDlgPosRel FDlgPosRel;
	System::Classes::TNotifyEvent FOnCustomize;
	System::Classes::TNotifyEvent FOnCustomClick;
	void __fastcall PaintBack(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &Dest);
	void __fastcall SetCaptionTitle(System::UnicodeString aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetHints(System::Classes::TStrings* aValue);
	System::Classes::TStrings* __fastcall GetHints(void);
	
protected:
	Vcl::Forms::TCustomForm* FOpenedDlg;
	System::Uitypes::TModalResult __fastcall BaseExecute(Vcl::Forms::TCustomForm* aForm, Vcl::Forms::TCustomForm* aParentForm, Vcl::Stdctrls::TButton* Custom, Lmdformstyler::TLMDFormStyler* fs, Lmdcustomformfill::TLMDCustomFormFill* b, System::UnicodeString defCaption);
	virtual void __fastcall DoCustomize(System::TObject* Sender);
	__property bool CaptionFill = {read=FFillCaption, write=FFillCaption, default=0};
	__property System::UnicodeString CaptionTitle = {read=FCaptionTitle, write=SetCaptionTitle};
	__property System::UnicodeString CustomButton = {read=FCustomButton, write=FCustomButton};
	__property Lmdclass::TLMDDlgEffect Effect = {read=FEffect, write=FEffect, default=0};
	__property System::Byte Colors = {read=FColors, write=FColors, default=32};
	__property System::Classes::TStrings* Hints = {read=GetHints, write=SetHints};
	__property bool ShowHints = {read=FShowHint, write=FShowHint, default=1};
	__property System::Classes::TNotifyEvent OnCustomize = {read=FOnCustomize, write=FOnCustomize};
	__property System::Classes::TNotifyEvent OnCustomClick = {read=FOnCustomClick, write=FOnCustomClick};
	
public:
	__fastcall virtual TLMDBaseDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseDialog(void);
	bool __fastcall ControlSupportsXP(void);
	virtual bool __fastcall Execute(void);
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Vcl::Forms::TCustomForm* Dlg = {read=FOpenedDlg};
	__property Lmdclass::TLMDDlgPosition Position = {read=FPosition, write=FPosition, default=5};
	__property Lmdclass::TLMDDlgPosRel RelatePos = {read=FDlgPosRel, write=FDlgPosRel, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEDIALOG)
using namespace Lmdbasedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasedialogHPP
