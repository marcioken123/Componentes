// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCEBase.pas' rev: 31.00 (Windows)

#ifndef PlmdcebaseHPP
#define PlmdcebaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Menus.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <DesignMenus.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcebase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDComponentEditor;
class DELPHICLASS TLMDDefaultEditor;
class DELPHICLASS TLMDBaseFormEditorObject;
class DELPHICLASS TLMDFormEditorTemplateObject;
class DELPHICLASS TLMDFormEditorControlsObject;
class DELPHICLASS TLMDFormEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDComponentEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
private:
	System::UnicodeString FPropName;
	Designintf::_di_IProperty FProp;
	void __fastcall int_GetPropEditProc(const Designintf::_di_IProperty Prop);
	
protected:
	void __fastcall HandleThemeModeEvent(System::TObject* Sender);
	void __fastcall AddThemeModeItems(Designmenus::_di_IMenuItem AItem);
	void __fastcall OpenEditorDlg(const System::UnicodeString aPropName);
	
public:
	virtual void __fastcall PrepareItem(int Index, const Designmenus::_di_IMenuItem AItem);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDComponentEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDefaultEditor : public TLMDComponentEditor
{
	typedef TLMDComponentEditor inherited;
	
public:
	Designintf::_di_IProperty FFirst;
	Designintf::_di_IProperty FBest;
	bool FContinue;
	void __fastcall CheckEdit(const Designintf::_di_IProperty Prop);
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDDefaultEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TLMDComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDefaultEditor(void) { }
	
private:
	void *__IDefaultEditor;	// Designintf::IDefaultEditor 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {5484FAE1-5C60-11D1-9FB6-0020AF3D82DA}
	operator Designintf::_di_IDefaultEditor()
	{
		Designintf::_di_IDefaultEditor intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Designintf::IDefaultEditor*(void) { return (Designintf::IDefaultEditor*)&__IDefaultEditor; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseFormEditorObject : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	Designintf::_di_IDesigner Designer;
	Vcl::Forms::TCustomForm* Form;
	
public:
	virtual System::UnicodeString __fastcall GetName(void) = 0 ;
	virtual void __fastcall PrepareItem(const Designmenus::_di_IMenuItem AItem) = 0 ;
	virtual void __fastcall HandleClickEvent(System::TObject* Sender) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDBaseFormEditorObject(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseFormEditorObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFormEditorTemplateObject : public TLMDBaseFormEditorObject
{
	typedef TLMDBaseFormEditorObject inherited;
	
public:
	virtual System::UnicodeString __fastcall GetName(void);
	virtual void __fastcall PrepareItem(const Designmenus::_di_IMenuItem AItem);
	virtual void __fastcall HandleClickEvent(System::TObject* Sender);
public:
	/* TObject.Create */ inline __fastcall TLMDFormEditorTemplateObject(void) : TLMDBaseFormEditorObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFormEditorTemplateObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFormEditorControlsObject : public TLMDBaseFormEditorObject
{
	typedef TLMDBaseFormEditorObject inherited;
	
public:
	virtual System::UnicodeString __fastcall GetName(void);
	virtual void __fastcall PrepareItem(const Designmenus::_di_IMenuItem AItem);
	virtual void __fastcall HandleClickEvent(System::TObject* Sender);
public:
	/* TObject.Create */ inline __fastcall TLMDFormEditorControlsObject(void) : TLMDBaseFormEditorObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFormEditorControlsObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFormEditor : public TLMDDefaultEditor
{
	typedef TLMDDefaultEditor inherited;
	
protected:
	Vcl::Forms::TCustomForm* __fastcall GetForm(void);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall PrepareItem(int Index, const Designmenus::_di_IMenuItem AItem);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDFormEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TLMDDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFormEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define IDS_THEMEMODE L"ThemeMode"
#define IDS_UPDATECTLXP L"Form: Update ThemeMode property"
extern DELPHI_PACKAGE void __fastcall LMDRegisterFormEditorObject(TLMDBaseFormEditorObject* aObject);
}	/* namespace Plmdcebase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCEBASE)
using namespace Plmdcebase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcebaseHPP
