// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDFxAniListDesigner.pas' rev: 31.00 (Windows)

#ifndef PlmdfxanilistdesignerHPP
#define PlmdfxanilistdesignerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <DesignWindows.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxAnimation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdfxanilistdesigner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxAniListDesignerForm;
class DELPHICLASS TLMDFxAnimationListEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxAniListDesignerForm : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
private:
	Lmdfxanimation::TLMDFxAnimationList* FAnimationList;
	Lmdfxanimation::TLMDFxAnimation* FSelected;
	Vcl::Stdctrls::TListBox* FList;
	Vcl::Extctrls::TPanel* FToolbar;
	Vcl::Buttons::TSpeedButton* FAddButton;
	Vcl::Buttons::TSpeedButton* FDeleteButton;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall BuildAniList(void);
	void __fastcall DoActivate(System::TObject* Sender);
	void __fastcall DoFormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall DoAddButtonClick(System::TObject* Sender);
	void __fastcall DoDeleteButtonClick(System::TObject* Sender);
	void __fastcall DoListClick(System::TObject* Sender);
	void __fastcall DoListDblClick(System::TObject* Sender);
	void __fastcall DoItemChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual System::UnicodeString __fastcall UniqueName(System::Classes::TComponent* Component);
	
public:
	__fastcall virtual TLMDFxAniListDesignerForm(void);
	__fastcall virtual ~TLMDFxAniListDesignerForm(void);
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TLMDFxAniListDesignerForm(System::Classes::TComponent* AOwner) : Designwindows::TDesignWindow(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFxAniListDesignerForm(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFxAniListDesignerForm(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxAnimationListEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDFxAnimationListEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxAnimationListEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ShowAniListDesignerForm(Lmdfxanimation::TLMDFxAnimationList* const AAnimationList, const Designintf::_di_IDesigner ADesigner);
}	/* namespace Plmdfxanilistdesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDFXANILISTDESIGNER)
using namespace Plmdfxanilistdesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdfxanilistdesignerHPP
