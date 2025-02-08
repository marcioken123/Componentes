// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBarCE.pas' rev: 31.00 (Windows)

#ifndef PlmdbarceHPP
#define PlmdbarceHPP

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
#include <ColnEdit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <LMDBarBase.hpp>
#include <LMDExplorerBar.hpp>
#include <LMDSectionBar.hpp>
#include <LMDSectionBarPopupMenu.hpp>
#include <pLMDCommon.hpp>
#include <pLMDGlobalEditors.hpp>
#include <ToolWnds.hpp>
#include <DesignWindows.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbarce
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBarHTMLLabelComponentEditor;
class DELPHICLASS TLMDBarExplorerBarCollectionEditor;
class DELPHICLASS TLMDBarExplorerBarCollectionProperty;
class DELPHICLASS TLMDBarExplorerBarEditor;
class DELPHICLASS TLMDBarSectionBarControllerEditor;
class DELPHICLASS TLMDBarSectionBarCollectionProperty;
class DELPHICLASS TLMDBarSectionBarCollectionEditor;
class DELPHICLASS TLMDBarSectionBarEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarHTMLLabelComponentEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDBarHTMLLabelComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBarHTMLLabelComponentEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDBarExplorerBarCollectionEditor : public Plmdglobaleditors::TLMDCollectionItemsEditor
{
	typedef Plmdglobaleditors::TLMDCollectionItemsEditor inherited;
	
protected:
	virtual System::Classes::TCollection* __fastcall GetWorkCollection(int index);
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TLMDBarExplorerBarCollectionEditor(System::Classes::TComponent* AOwner) : Plmdglobaleditors::TLMDCollectionItemsEditor(AOwner) { }
	/* TDesignWindow.Destroy */ inline __fastcall virtual ~TLMDBarExplorerBarCollectionEditor(void) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDBarExplorerBarCollectionEditor(System::Classes::TComponent* AOwner, int Dummy) : Plmdglobaleditors::TLMDCollectionItemsEditor(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBarExplorerBarCollectionEditor(HWND ParentWindow) : Plmdglobaleditors::TLMDCollectionItemsEditor(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarExplorerBarCollectionProperty : public Colnedit::TCollectionProperty
{
	typedef Colnedit::TCollectionProperty inherited;
	
public:
	virtual Colnedit::TCollectionEditorClass __fastcall GetEditorClass(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDBarExplorerBarCollectionProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Colnedit::TCollectionProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDBarExplorerBarCollectionProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarExplorerBarEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDBarExplorerBarEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBarExplorerBarEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarSectionBarControllerEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDBarSectionBarControllerEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBarSectionBarControllerEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarSectionBarCollectionProperty : public Colnedit::TCollectionProperty
{
	typedef Colnedit::TCollectionProperty inherited;
	
public:
	virtual Colnedit::TCollectionEditorClass __fastcall GetEditorClass(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDBarSectionBarCollectionProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Colnedit::TCollectionProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDBarSectionBarCollectionProperty(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDBarSectionBarCollectionEditor : public Plmdglobaleditors::TLMDCollectionItemsEditor
{
	typedef Plmdglobaleditors::TLMDCollectionItemsEditor inherited;
	
protected:
	virtual System::Classes::TCollection* __fastcall GetWorkCollection(int index);
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TLMDBarSectionBarCollectionEditor(System::Classes::TComponent* AOwner) : Plmdglobaleditors::TLMDCollectionItemsEditor(AOwner) { }
	/* TDesignWindow.Destroy */ inline __fastcall virtual ~TLMDBarSectionBarCollectionEditor(void) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDBarSectionBarCollectionEditor(System::Classes::TComponent* AOwner, int Dummy) : Plmdglobaleditors::TLMDCollectionItemsEditor(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBarSectionBarCollectionEditor(HWND ParentWindow) : Plmdglobaleditors::TLMDCollectionItemsEditor(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBarSectionBarEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDBarSectionBarEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBarSectionBarEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbarce */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBARCE)
using namespace Plmdbarce;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbarceHPP
