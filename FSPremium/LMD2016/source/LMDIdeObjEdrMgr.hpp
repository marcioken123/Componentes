// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeObjEdrMgr.pas' rev: 31.00 (Windows)

#ifndef LmdideobjedrmgrHPP
#define LmdideobjedrmgrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ActnList.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.ComCtrls.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDInsClass.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgModule.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideobjedrmgr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDObjectEditor;
class DELPHICLASS TLMDObjectEditorManager;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDObjectEditorClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDObjectEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDObjectEditorManager* FOwner;
	System::Classes::TPersistent* FInstance;
	Lmdsvcpvdr::TLMDServiceProvider* __fastcall GetServiceProvider(void);
	
public:
	__fastcall virtual TLMDObjectEditor(TLMDObjectEditorManager* AOwner, System::Classes::TPersistent* AInstance);
	__fastcall virtual ~TLMDObjectEditor(void);
	bool __fastcall CreateEditorWndCbs(System::Classes::TPersistent* AEditingObject, /* out */ Lmdinseditorwnds::TLMDEditorWindowCallbacks* &AResult);
	void __fastcall Changed(void);
	void __fastcall GetObjects(System::Classes::TList* AResult);
	void __fastcall SetObjects(System::Classes::TList* AObjects)/* overload */;
	void __fastcall SetObjects(System::Classes::TPersistent* *AObjects, const int AObjects_High)/* overload */;
	virtual void __fastcall Edit(void);
	virtual int __fastcall GetVerbCount(void);
	virtual Lmdtypes::TLMDString __fastcall GetVerb(int AIndex);
	virtual void __fastcall ExecuteVerb(int AIndex);
	__property TLMDObjectEditorManager* Owner = {read=FOwner};
	__property System::Classes::TPersistent* Instance = {read=FInstance};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=GetServiceProvider};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDComponentEdrMgrOnGetEditorClass)(System::TObject* Sender, System::Classes::TPersistent* AInstance, TLMDObjectEditorClass &AEditorClass);

typedef void __fastcall (__closure *TLMDComponentEdrMgrOnAdjustMenu)(System::TObject* Sender, TLMDObjectEditor* AEditor, Vcl::Menus::TPopupMenu* AMenu, bool &AHandled);

typedef void __fastcall (__closure *TLMDComponentEdrMgrOnDefaultAction)(System::TObject* Sender, System::Classes::TPersistent* AInstance, bool &AHandled);

class PASCALIMPLEMENTATION TLMDObjectEditorManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FItems;
	System::Classes::TList* FEditors;
	int FRecreateDefferCount;
	bool FNeedRecreate;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	Lmddsgobjects::TLMDDesignObjects* FSelection;
	System::TObject* FSelnNotifier;
	TLMDComponentEdrMgrOnGetEditorClass FOnGetEditorClass;
	TLMDComponentEdrMgrOnAdjustMenu FOnAdjustMenu;
	TLMDComponentEdrMgrOnDefaultAction FOnDefaultAction;
	System::Classes::TNotifyEvent FOnChange;
	bool FEventHandlerAsDefaultAction;
	void __fastcall ClearItems(void);
	System::TObject* __fastcall FindItem(System::Classes::TPersistentClass AClass);
	void __fastcall InsertEditor(TLMDObjectEditor* AEditor);
	void __fastcall RemoveEditor(TLMDObjectEditor* AEditor);
	void __fastcall ClearEditors(void);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetSelection(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall RegisterStandardEditors(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual Lmdinseditorwnds::TLMDEditorWindowManager* __fastcall DetectEditorWindowManager(System::Classes::TPersistent* AEditingObject);
	virtual void __fastcall DoDefaultAction(System::Classes::TPersistent* AInstance, bool &AHandled);
	virtual void __fastcall DoChange(System::Classes::TPersistent* AInstance);
	void __fastcall RecreateEditors(void);
	void __fastcall BeginRecreateDeffer(void);
	void __fastcall EndRecreateDeffer(void);
	
public:
	__fastcall virtual TLMDObjectEditorManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDObjectEditorManager(void);
	void __fastcall RegisterEditor(System::Classes::TPersistentClass AClass, TLMDObjectEditorClass AEditorClass);
	void __fastcall UnregisterEditor(System::Classes::TPersistentClass AClass);
	TLMDObjectEditorClass __fastcall FindEditorClass(System::Classes::TPersistent* AInstance);
	void __fastcall UpdateEditors(void);
	TLMDObjectEditor* __fastcall FindEditor(System::Classes::TPersistent* AInstance);
	void __fastcall DblClicked(System::Classes::TPersistent* AInstance);
	void __fastcall AdjustMenu(System::Classes::TPersistent* AInstance, Vcl::Menus::TPopupMenu* AMenu);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property Lmddsgobjects::TLMDDesignObjects* Selection = {read=FSelection, write=SetSelection};
	__property bool EventHandlerAsDefaultAction = {read=FEventHandlerAsDefaultAction, write=FEventHandlerAsDefaultAction, default=0};
	__property TLMDComponentEdrMgrOnGetEditorClass OnGetEditorClass = {read=FOnGetEditorClass, write=FOnGetEditorClass};
	__property TLMDComponentEdrMgrOnAdjustMenu OnAdjustMenu = {read=FOnAdjustMenu, write=FOnAdjustMenu};
	__property TLMDComponentEdrMgrOnDefaultAction OnDefaultAction = {read=FOnDefaultAction, write=FOnDefaultAction};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDRemoveEditorMenuItems(Vcl::Menus::TPopupMenu* AMenu);
extern DELPHI_PACKAGE Vcl::Menus::TMenuItem* __fastcall LMDCreateVerbMenuItem(System::Classes::TComponent* AOwner, TLMDObjectEditor* AEditor, int AVerbIndex);
extern DELPHI_PACKAGE Vcl::Menus::TMenuItem* __fastcall LMDCreateSimpleMenuItem(System::Classes::TComponent* AOwner, const Lmdtypes::TLMDString ACaption);
}	/* namespace Lmdideobjedrmgr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEOBJEDRMGR)
using namespace Lmdideobjedrmgr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideobjedrmgrHPP
