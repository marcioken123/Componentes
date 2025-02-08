// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeColorCombo.pas' rev: 31.00 (Windows)

#ifndef EltreecolorcomboHPP
#define EltreecolorcomboHPP

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
#include <Vcl.Dialogs.hpp>
#include <LMDProcs.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElCombos.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElHeader.hpp>
#include <ElClrCmb.hpp>
#include <ElBtnEdit.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreecolorcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackTreeColorCombo;
class DELPHICLASS THackInplaceColorCombo;
class DELPHICLASS TElTreeInplaceColorCombo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackTreeColorCombo : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
public:
	/* TCustomElComboBox.Create */ inline __fastcall virtual THackTreeColorCombo(System::Classes::TComponent* AOwner) : Elcombos::TCustomElComboBox(AOwner) { }
	/* TCustomElComboBox.Destroy */ inline __fastcall virtual ~THackTreeColorCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackTreeColorCombo(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackInplaceColorCombo : public Elclrcmb::TElColorCombo
{
	typedef Elclrcmb::TElColorCombo inherited;
	
protected:
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, NativeUInt ComboWnd, void * ComboProc);
public:
	/* TElColorCombo.Create */ inline __fastcall virtual THackInplaceColorCombo(System::Classes::TComponent* AOwner) : Elclrcmb::TElColorCombo(AOwner) { }
	/* TElColorCombo.Destroy */ inline __fastcall virtual ~THackInplaceColorCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackInplaceColorCombo(HWND ParentWindow) : Elclrcmb::TElColorCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceColorCombo : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetOptions(Elclrcmb::TColorComboOptions Value);
	Elclrcmb::TColorComboOptions __fastcall GetOptions(void);
	Vcl::Dialogs::TColorDialogOptions __fastcall GetDialogOptions(void);
	void __fastcall SetDialogOptions(const Vcl::Dialogs::TColorDialogOptions Value);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
	
protected:
	bool FInitiallyDropped;
	bool FIgnoreKillFocus;
	virtual void __fastcall AdjustBounds(void);
	Elclrcmb::TElColorCombo* __fastcall GetEditor(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	void __fastcall ColorDialogShow(System::TObject* Sender, bool AfterShow);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElTreeInplaceColorCombo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceColorCombo(void);
	__property Elclrcmb::TElColorCombo* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool InitiallyDropped = {read=FInitiallyDropped, write=FInitiallyDropped, nodefault};
	__property Elclrcmb::TColorComboOptions Options = {read=GetOptions, write=SetOptions, nodefault};
	__property Vcl::Dialogs::TColorDialogOptions DialogOptions = {read=GetDialogOptions, write=SetDialogOptions, nodefault};
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreecolorcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREECOLORCOMBO)
using namespace Eltreecolorcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreecolorcomboHPP
