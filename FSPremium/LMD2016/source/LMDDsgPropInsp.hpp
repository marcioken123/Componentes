// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgPropInsp.pas' rev: 31.00 (Windows)

#ifndef LmddsgpropinspHPP
#define LmddsgpropinspHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Menus.hpp>
#include <System.Masks.hpp>
#include <System.RTLConsts.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDTypes.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgModule.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>
#include <LMDInsPropInsp.hpp>
#include <LMDInsPropPage.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgpropinsp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPropertyInspector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPropertyInspector : public Lmdinspropinsp::TLMDCustomPropertyInspector
{
	typedef Lmdinspropinsp::TLMDCustomPropertyInspector inherited;
	
private:
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	Lmddsgobjects::TLMDDesignObjects* FSelection;
	System::TObject* FSelnNotifier;
	HIDESBASE void __fastcall SetSelection(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SelnNotifierChanged(void);
	Lmddsgmodule::TLMDModule* __fastcall GetModuleForEditingInstances(Lmdinspropinsp::TLMDPropEditor* AEditor);
	void __fastcall CompsChangeNotification(System::TObject* Sender, System::Classes::TList* AChangedComps);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall GetObjects(System::Classes::TList* AResult);
	virtual void __fastcall SetObjects(System::Classes::TList* AObjects);
	virtual Lmdinseditorwnds::TLMDEditorWindowManager* __fastcall DetectEditorWindowManager(System::Classes::TPersistent* AEditedObject);
	virtual void __fastcall DoGetCompRef(Lmdinspropinsp::TLMDPropEditor* AEditor, const Lmdtypes::TLMDString ACompName, System::Classes::TComponent* &AComponent);
	virtual void __fastcall DoGetCompRefName(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AName);
	virtual void __fastcall DoGetCompRefList(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Classes::TComponentClass AClass, System::Classes::TList* AResult);
	virtual void __fastcall DoGetEventValue(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, Lmdinspropinsp::ILMDProperty* APropInfo, Lmdtypes::TLMDString &AResult);
	virtual void __fastcall DoSetEventValue(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, Lmdinspropinsp::ILMDProperty* APropInfo, const Lmdtypes::TLMDString AValue);
	virtual void __fastcall DoGetDefaultEventHandlerName(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo, Lmdtypes::TLMDString &AResult);
	virtual void __fastcall DoGetExistingEventHandlers(Lmdinspropinsp::TLMDPropEditor* AEditor, System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);
	virtual void __fastcall DoEnsureEventHandlerSource(Lmdinspropinsp::TLMDPropEditor* AEditor, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo, bool AShowSource);
	virtual void __fastcall DoGetUniqueCompName(System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AUniqueName);
	virtual void __fastcall DoChange(Lmdinspropinsp::TLMDPropEditor* AEditor);
	HIDESBASE Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
public:
	__fastcall virtual TLMDPropertyInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPropertyInspector(void);
	__property State;
	__property ActiveItem;
	__property ActiveCategory;
	__property Designer;
	__property Items;
	__property Categories;
	__property ObjectsCategories;
	
__published:
	__property Lmddsgobjects::TLMDDesignObjects* Selection = {read=FSelection, write=SetSelection};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property PropKinds = {default=1};
	__property ComponentRefColor = {default=128};
	__property ComponentRefPropColor = {default=32768};
	__property ExpandComponentRefs = {default=1};
	__property MenuOptions = {default=0};
	__property ReadOnly = {default=0};
	__property SortType = {default=0};
	__property ArrangeKind = {default=0};
	__property ToolTips = {default=1};
	__property GridColor = {default=-16777200};
	__property GridVisible = {default=1};
	__property GutterVisible = {default=0};
	__property GutterColor = {default=15793151};
	__property GutterLineColor = {default=-16777200};
	__property CursorVisible = {default=0};
	__property SelectionStyle = {default=0};
	__property FlatSelectionBackgroundColor = {default=-16777203};
	__property FlatSelectionColor = {default=-16777202};
	__property CategoryBackgroundColor = {default=-16777203};
	__property CategoryFont;
	__property DefaultPropName = {default=0};
	__property Splitter;
	__property ValuesColor = {default=8388608};
	__property HighlightNonDefaultValues = {default=1};
	__property ExpandedCategories = {default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property OnExpanded;
	__property OnCollapsed;
	__property OnCategoryExpanded;
	__property OnCategoryCollapsed;
	__property OnFilterProp;
	__property OnTranslateProp;
	__property OnChange;
	__property OnGetCaptionColor;
	__property OnGetEditorClass;
	__property OnCompare;
	__property OnDynPropsDefine;
	__property OnDynPropGetValue;
	__property OnDynPropSetValue;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPropertyInspector(HWND ParentWindow) : Lmdinspropinsp::TLMDCustomPropertyInspector(ParentWindow) { }
	
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
}	/* namespace Lmddsgpropinsp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGPROPINSP)
using namespace Lmddsgpropinsp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgpropinspHPP
