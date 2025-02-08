// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDlgButtonPanel.pas' rev: 31.00 (Windows)

#ifndef LmddlgbuttonpanelHPP
#define LmddlgbuttonpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddlgbuttonpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDlgButtonPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDlgButtonAlign : unsigned char { baTopLeft, baRightBottom, baCenter };

enum DECLSPEC_DENUM TLMDDlgButtonOption : unsigned char { boAttachBtnHelp, boCheckBtnTag };

typedef System::Set<TLMDDlgButtonOption, TLMDDlgButtonOption::boAttachBtnHelp, TLMDDlgButtonOption::boCheckBtnTag> TLMDDlgButtonOptions;

class PASCALIMPLEMENTATION TLMDDlgButtonPanel : public Lmdsimplepanel::TLMDSimplePanel
{
	typedef Lmdsimplepanel::TLMDSimplePanel inherited;
	
private:
	System::Byte FBtnGap;
	System::Byte FBtnMargin;
	TLMDDlgButtonAlign FBtnAlign;
	TLMDDlgButtonOptions FOptions;
	void __fastcall SetButtonAlign(TLMDDlgButtonAlign aValue);
	void __fastcall SetButtonGap(System::Byte aValue);
	void __fastcall SetButtonMargin(System::Byte aValue);
	void __fastcall SetOptions(TLMDDlgButtonOptions aValue);
	
protected:
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDDlgButtonPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDlgButtonPanel(void);
	void __fastcall DoHelpClick(System::TObject* Sender);
	virtual void __fastcall EndUpdate(bool aValue);
	
__published:
	__property Align = {default=0};
	__property TLMDDlgButtonAlign BtnAlign = {read=FBtnAlign, write=SetButtonAlign, default=0};
	__property System::Byte BtnGap = {read=FBtnGap, write=SetButtonGap, default=10};
	__property System::Byte BtnMargin = {read=FBtnMargin, write=SetButtonMargin, default=10};
	__property TLMDDlgButtonOptions BtnOptions = {read=FOptions, write=SetOptions, default=3};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDlgButtonPanel(HWND ParentWindow) : Lmdsimplepanel::TLMDSimplePanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_BtnOptions (System::Set<TLMDDlgButtonOption, TLMDDlgButtonOption::boAttachBtnHelp, TLMDDlgButtonOption::boCheckBtnTag>() << TLMDDlgButtonOption::boAttachBtnHelp << TLMDDlgButtonOption::boCheckBtnTag )
}	/* namespace Lmddlgbuttonpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDLGBUTTONPANEL)
using namespace Lmddlgbuttonpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddlgbuttonpanelHPP
